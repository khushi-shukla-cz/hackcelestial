import 'package:flutter/material.dart';

// Models
class Alert {
  final String id;
  final String title;
  final String description;
  final AlertSeverity severity;
  final String location;
  final String time;
  final String source;

  Alert({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.location,
    required this.time,
    required this.source,
  });
}

enum AlertSeverity { critical, warning, info }

class Incident {
  final int id;
  final String type;
  final String location;
  final AlertSeverity severity;
  final String time;
  final int affected;

  Incident({
    required this.id,
    required this.type,
    required this.location,
    required this.severity,
    required this.time,
    required this.affected,
  });
}

class DashboardStat {
  final String title;
  final String value;
  final StatChange? change;
  final IconData icon;
  final String description;

  DashboardStat({
    required this.title,
    required this.value,
    this.change,
    required this.icon,
    required this.description,
  });
}

class StatChange {
  final String value;
  final ChangeType type;

  StatChange({required this.value, required this.type});
}

enum ChangeType { increase, decrease, neutral }

// Alert Banner Component
class AlertBanner extends StatelessWidget {
  final List<Alert> alerts;
  final Function(String)? onDismiss;

  const AlertBanner({
    Key? key,
    required this.alerts,
    this.onDismiss,
  }) : super(key: key);

  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red.shade50;
      case AlertSeverity.warning:
        return Colors.orange.shade50;
      case AlertSeverity.info:
        return Colors.blue.shade50;
    }
  }

  Color _getSeverityBorderColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red;
      case AlertSeverity.warning:
        return Colors.orange;
      case AlertSeverity.info:
        return Colors.blue;
    }
  }

  Color _getSeverityBadgeColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red;
      case AlertSeverity.warning:
        return Colors.orange;
      case AlertSeverity.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: alerts.map((alert) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Card(
              color: _getSeverityColor(alert.severity),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: _getSeverityBorderColor(alert.severity),
                  width: 0.5,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                    left: BorderSide(
                      color: _getSeverityBorderColor(alert.severity),
                      width: 4,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 2, right: 12),
                          child: Icon(
                            Icons.warning,
                            size: 20,
                            color: _getSeverityBorderColor(alert.severity),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                alert.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        alert.location,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    alert.time,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getSeverityBadgeColor(alert.severity)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _getSeverityBadgeColor(alert.severity),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      alert.severity.name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: _getSeverityBadgeColor(alert.severity),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.open_in_new, size: 12),
                              label: const Text(
                                'Details',
                                style: TextStyle(fontSize: 12),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                minimumSize: Size.zero,
                              ),
                            ),
                            if (onDismiss != null) ...[
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () => onDismiss!(alert.id),
                                icon: const Icon(Icons.close, size: 12),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Source: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            alert.source,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Stats Cards Component
class StatsCards extends StatelessWidget {
  const StatsCards({Key? key}) : super(key: key);

  List<DashboardStat> get stats => [
        DashboardStat(
          title: 'Active Incidents',
          value: '23',
          change: StatChange(value: '+3', type: ChangeType.increase),
          icon: Icons.warning,
          description: 'Reports in last 24h',
        ),
        DashboardStat(
          title: 'People Affected',
          value: '1,247',
          change: StatChange(value: '+156', type: ChangeType.increase),
          icon: Icons.people,
          description: 'Requiring assistance',
        ),
        DashboardStat(
          title: 'Shelters Active',
          value: '8',
          change: StatChange(value: '0', type: ChangeType.neutral),
          icon: Icons.shield,
          description: '62% capacity utilized',
        ),
        DashboardStat(
          title: 'Response Teams',
          value: '15',
          change: StatChange(value: '+2', type: ChangeType.increase),
          icon: Icons.location_on,
          description: 'Deployed in field',
        ),
      ];

  IconData _getTrendIcon(ChangeType type) {
    switch (type) {
      case ChangeType.increase:
        return Icons.trending_up;
      case ChangeType.decrease:
        return Icons.trending_down;
      case ChangeType.neutral:
        return Icons.remove;
    }
  }

  Color _getTrendColor(ChangeType type) {
    switch (type) {
      case ChangeType.increase:
        return Colors.red;
      case ChangeType.decrease:
        return Colors.green;
      case ChangeType.neutral:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive grid
          int crossAxisCount = 1;
          if (constraints.maxWidth > 768) crossAxisCount = 2;
          if (constraints.maxWidth > 1024) crossAxisCount = 4;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.8,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              final stat = stats[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).cardColor,
                        Theme.of(context).cardColor.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            stat.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              stat.icon,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            stat.value,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (stat.change != null) ...[
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  _getTrendIcon(stat.change!.type),
                                  size: 12,
                                  color: _getTrendColor(stat.change!.type),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  stat.change!.value,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _getTrendColor(stat.change!.type),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Incident Map Component
class IncidentMap extends StatelessWidget {
  const IncidentMap({Key? key}) : super(key: key);

  List<Incident> get incidents => [
        Incident(
          id: 1,
          type: 'Flood',
          location: 'Mumbai Central',
          severity: AlertSeverity.critical,
          time: '15 min ago',
          affected: 150,
        ),
        Incident(
          id: 2,
          type: 'Building Collapse',
          location: 'Pune District',
          severity: AlertSeverity.critical,
          time: '32 min ago',
          affected: 45,
        ),
        Incident(
          id: 3,
          type: 'Power Outage',
          location: 'Nashik',
          severity: AlertSeverity.warning,
          time: '1 hour ago',
          affected: 2000,
        ),
        Incident(
          id: 4,
          type: 'Road Blockage',
          location: 'Kolhapur',
          severity: AlertSeverity.info,
          time: '2 hours ago',
          affected: 0,
        ),
      ];

  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red;
      case AlertSeverity.warning:
        return Colors.orange;
      case AlertSeverity.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 1024;
        
        if (isLargeScreen) {
          return Row(
            children: [
              Expanded(flex: 1, child: _buildMapCard()),
              const SizedBox(width: 24),
              Expanded(flex: 1, child: _buildIncidentsList()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildMapCard(),
              const SizedBox(height: 24),
              _buildIncidentsList(),
            ],
          );
        }
      },
    );
  }

  Widget _buildMapCard() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Live Incident Map',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, size: 16),
                      label: const Text('Filter'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Icon(Icons.fullscreen, size: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: 320,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Interactive Map Component',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Shows real-time incidents, shelters, and response teams',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Mock incident markers
                const Positioned(
                  top: 24,
                  left: 32,
                  child: _PulsingDot(color: Colors.red),
                ),
                const Positioned(
                  top: 64,
                  right: 48,
                  child: _PulsingDot(color: Colors.orange),
                ),
                const Positioned(
                  bottom: 48,
                  left: 64,
                  child: _PulsingDot(color: Colors.blue),
                ),
                const Positioned(
                  bottom: 32,
                  right: 32,
                  child: _PulsingDot(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentsList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Recent Incidents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: incidents.map((incident) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              incident.type,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      incident.location,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _getSeverityColor(incident.severity),
                                    ),
                                  ),
                                  child: Text(
                                    incident.severity.name,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getSeverityColor(incident.severity),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      incident.time,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                                if (incident.affected > 0) ...[
                                  const SizedBox(width: 16),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        size: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${incident.affected} affected',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('View All Incidents'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Pulsing dot animation for map markers
class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  _PulsingDotState createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(_animation.value),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.6),
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Main Dashboard Page
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Alert> alerts = [
    Alert(
      id: '1',
      title: 'Flash Flood Warning',
      description: 'Heavy rainfall expected in Mumbai Central area. Residents advised to stay indoors.',
      severity: AlertSeverity.critical,
      location: 'Mumbai Central',
      time: '5 minutes ago',
      source: 'Weather Service',
    ),
    Alert(
      id: '2',
      title: 'Building Evacuation',
      description: 'Structural damage reported in Pune residential complex.',
      severity: AlertSeverity.warning,
      location: 'Pune District',
      time: '15 minutes ago',
      source: 'Fire Department',
    ),
  ];

  void _dismissAlert(String id) {
    setState(() {
      alerts.removeWhere((alert) => alert.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Emergency Dashboard'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AlertBanner(
              alerts: alerts,
              onDismiss: _dismissAlert,
            ),
            const StatsCards(),
            const IncidentMap(),
          ],
        ),
      ),
    );
  }
}