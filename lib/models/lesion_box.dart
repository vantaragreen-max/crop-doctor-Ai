class LesionBox {
  final int id;
  final double relX; // 0.0 to 1.0 relative to image width
  final double relY; // 0.0 to 1.0 relative to image height
  final double relW;
  final double relH;
  final double areaPct;
  final String severity; // 'Mild', 'Moderate', 'Severe'

  const LesionBox({
    required this.id,
    required this.relX,
    required this.relY,
    required this.relW,
    required this.relH,
    required this.areaPct,
    required this.severity,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'relX': relX,
        'relY': relY,
        'relW': relW,
        'relH': relH,
        'areaPct': areaPct,
        'severity': severity,
      };

  factory LesionBox.fromJson(Map<String, dynamic> json) => LesionBox(
        id: (json['id'] as num).toInt(),
        relX: (json['relX'] as num).toDouble(),
        relY: (json['relY'] as num).toDouble(),
        relW: (json['relW'] as num).toDouble(),
        relH: (json['relH'] as num).toDouble(),
        areaPct: (json['areaPct'] as num).toDouble(),
        severity: json['severity'] as String? ?? 'Moderate',
      );
}
