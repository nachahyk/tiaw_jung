import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:core_infra/core_infra.dart';

import 'package:tiaw_jung/src/theme/app_colors.dart';
import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/core/widgets/tj_page_header.dart';
import 'package:tiaw_jung/src/features/itinerary/domain/entities/itinerary_stop.dart';
import 'package:tiaw_jung/src/features/itinerary/presentation/controllers/itinerary_cubit.dart';
import 'package:tiaw_jung/src/features/itinerary/presentation/controllers/itinerary_state.dart';
import 'package:tiaw_jung/src/features/itinerary/presentation/pages/tj_location_picker_page.dart';

/// Add/Edit form for a single itinerary stop. When [stopId] is null this
/// creates a new stop (defaulting to the trip's first day); otherwise it
/// edits the existing stop looked up from `ItineraryCubit`'s already-loaded
/// list.
class StopFormPage extends StatefulWidget {
  const StopFormPage({super.key, required this.tripId, this.stopId});

  final String tripId;
  final String? stopId;

  @override
  State<StopFormPage> createState() => _StopFormPageState();
}

class _StopFormPageState extends State<StopFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  ItineraryStop? _editing;
  DateTime _dayDate = DateTime.now();
  TimeOfDay? _startTime;
  String? _address;
  double? _lat;
  double? _lng;
  bool _initialized = false;

  void _initFromExisting(ItineraryStop stop) {
    _editing = stop;
    _titleController.text = stop.title;
    _noteController.text = stop.note ?? '';
    _dayDate = stop.dayDate;
    _startTime = stop.startTime;
    _address = stop.address;
    _lat = stop.latitude;
    _lng = stop.longitude;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dayDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked == null) return;
    setState(() => _dayDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _startTime ?? TimeOfDay.now());
    if (picked == null) return;
    setState(() => _startTime = picked);
  }

  Future<void> _pickLocation() async {
    final picked = await Navigator.of(context).push<PickedLocation>(
      MaterialPageRoute(
        builder: (context) => TjLocationPickerPage(initialLatitude: _lat, initialLongitude: _lng),
      ),
    );
    if (picked == null) return;
    setState(() {
      _address = picked.address;
      _lat = picked.latitude;
      _lng = picked.longitude;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<ItineraryCubit>();
    final stop = ItineraryStop(
      id: _editing?.id ?? '',
      tripId: widget.tripId,
      dayDate: _dayDate,
      title: _titleController.text.trim(),
      address: _address,
      latitude: _lat,
      longitude: _lng,
      startTime: _startTime,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      sortOrder: _editing?.sortOrder ?? 0,
    );
    if (_editing == null) {
      cubit.addStop(stop);
    } else {
      cubit.updateStop(stop);
    }
  }

  void _delete() {
    final id = _editing?.id;
    if (id == null) return;
    context.read<ItineraryCubit>().deleteStop(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    if (!_initialized) {
      _initialized = true;
      final stopId = widget.stopId;
      if (stopId != null) {
        for (final stop in context.read<ItineraryCubit>().state.stops) {
          if (stop.id == stopId) {
            _initFromExisting(stop);
            break;
          }
        }
      }
    }

    return Scaffold(
      appBar: TjPageHeader(title: _editing == null ? l10n.stopFormAddTitle : l10n.stopFormEditTitle),
      body: BlocListener<ItineraryCubit, ItineraryState>(
        listenWhen: (previous, current) => previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == ItineraryActionStatus.success) {
            context.read<ItineraryCubit>().resetActionStatus();
            if (context.canPop()) context.pop();
          } else if (state.actionStatus == ItineraryActionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError ?? l10n.commonSomethingWentWrong)),
            );
            context.read<ItineraryCubit>().resetActionStatus();
          }
        },
        child: BlocBuilder<ItineraryCubit, ItineraryState>(
          builder: (context, state) {
            final isSaving = state.actionStatus == ItineraryActionStatus.saving;
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: l10n.stopFormNameLabel),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty) ? l10n.stopFormNameRequired : null,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _pickDay,
                                child: Text('${l10n.stopFormDayLabel}: ${_dayDate.day}/${_dayDate.month}'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _pickTime,
                                child: Text(_startTime == null
                                    ? l10n.stopFormTimeLabel
                                    : _startTime!.format(context)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(l10n.stopFormAddressLabel, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                        const SizedBox(height: 8),
                        InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: _pickLocation,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: colors.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: colors.border),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.map_outlined, size: 18, color: colors.primary),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _address ?? l10n.stopFormAddressHint,
                                    style: TextStyle(fontSize: 13.5, color: _address == null ? colors.textFaint : colors.textPrimary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_lat != null && _lng != null) ...[
                          const SizedBox(height: 10),
                          GoogleMapPreview(latitude: _lat!, longitude: _lng!),
                        ],
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _noteController,
                          maxLines: 2,
                          decoration: InputDecoration(labelText: l10n.stopFormNoteLabel),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: isSaving ? null : _submit,
                          child: isSaving
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : Text(l10n.stopFormSaveButton),
                        ),
                        if (_editing != null) ...[
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: isSaving ? null : _delete,
                            style: OutlinedButton.styleFrom(foregroundColor: colors.terracotta, side: BorderSide(color: colors.terracotta)),
                            child: Text(l10n.stopFormDeleteButton),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
