import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/core/widgets/tj_page_header.dart';
import 'package:tiaw_jung/src/routes/app_routes.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_state.dart';

/// First-run flow for a trip organizer: name, destination, dates. On
/// success, replaces this page with the new trip's detail page.
class CreateTripPage extends StatefulWidget {
  const CreateTripPage({super.key});

  @override
  State<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _destinationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<TripsCubit>().createTrip(
          name: _nameController.text.trim(),
          destination: _destinationController.text.trim().isEmpty ? null : _destinationController.text.trim(),
          startDate: _startDate,
          endDate: _endDate,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: TjPageHeader(title: l10n.createTripTitle),
      body: BlocListener<TripsCubit, TripsState>(
        listenWhen: (previous, current) => previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == TripsActionStatus.success && state.createdTrip != null) {
            final tripId = state.createdTrip!.id;
            context.read<TripsCubit>().resetActionStatus();
            context.pushReplacement(AppRoutes.tripDetail(tripId));
          } else if (state.actionStatus == TripsActionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError ?? l10n.commonSomethingWentWrong)),
            );
            context.read<TripsCubit>().resetActionStatus();
          }
        },
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {
            final isSaving = state.actionStatus == TripsActionStatus.saving;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: l10n.createTripNameLabel),
                        validator: (value) =>
                            (value == null || value.trim().isEmpty) ? l10n.createTripNameRequired : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _destinationController,
                        decoration: InputDecoration(labelText: l10n.createTripDestinationLabel),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _pickDate(isStart: true),
                              child: Text(_startDate == null
                                  ? l10n.createTripStartDateLabel
                                  : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _pickDate(isStart: false),
                              child: Text(_endDate == null
                                  ? l10n.createTripEndDateLabel
                                  : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: isSaving ? null : _submit,
                        child: isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(l10n.createTripSubmitButton),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
