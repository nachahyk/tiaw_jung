import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/core/widgets/tj_page_header.dart';
import 'package:tiaw_jung/src/routes/app_routes.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:tiaw_jung/src/features/trips/presentation/controllers/trips_state.dart';

class JoinTripPage extends StatefulWidget {
  const JoinTripPage({super.key});

  @override
  State<JoinTripPage> createState() => _JoinTripPageState();
}

class _JoinTripPageState extends State<JoinTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<TripsCubit>().joinTrip(_codeController.text.trim().toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: TjPageHeader(title: l10n.joinTripTitle),
      body: BlocListener<TripsCubit, TripsState>(
        listenWhen: (previous, current) => previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == TripsActionStatus.success && state.createdTrip != null) {
            final tripId = state.createdTrip!.id;
            context.read<TripsCubit>().resetActionStatus();
            context.pushReplacement(AppRoutes.tripDetail(tripId));
          } else if (state.actionStatus == TripsActionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError ?? l10n.joinTripNotFound)),
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
                        controller: _codeController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: l10n.joinTripCodeLabel,
                          hintText: l10n.joinTripCodeHint,
                        ),
                        validator: (value) => (value == null || value.trim().isEmpty) ? l10n.joinTripCodeLabel : null,
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: isSaving ? null : _submit,
                        child: isSaving
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : Text(l10n.joinTripSubmitButton),
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
