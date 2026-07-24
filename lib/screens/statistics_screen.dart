import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../core/categories.dart';
import '../cubit/transactions_cubit.dart';
import '../models/transaction_model.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _touchedPieIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
      ),
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.transactions.isEmpty) {
            return Center(
              child: Text(
                'No data for statistics yet.',
                style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
              ),
            );
          }

          // 1. Calculate Data
          final categoryTotals = <String, double>{};
          for (final t in state.transactions) {
            categoryTotals[t.category] = (categoryTotals[t.category] ?? 0) + t.amount;
          }

          final sortedCategories = categoryTotals.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          // Insights
          final highestCategory = sortedCategories.isNotEmpty ? sortedCategories.first : null;
          final last7Days = _getLast7DaysTotals(state.transactions);
          final avgDaily = last7Days.values.fold(0.0, (a, b) => a + b) / 7;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Insights
                Row(
                  children: [
                    Expanded(
                      child: _InsightCard(
                        title: 'Highest Spend',
                        value: highestCategory != null
                            ? '\$${highestCategory.value.toStringAsFixed(0)}'
                            : '\$0',
                        subtitle: highestCategory?.key ?? '-',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InsightCard(
                        title: 'Daily Average',
                        value: '\$${avgDaily.toStringAsFixed(0)}',
                        subtitle: 'Last 7 days',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Bar Chart
                Text(
                  'Expenses by Category',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: _CategoryBarChart(
                    data: sortedCategories,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 48),

                // Donut Chart
                Text(
                  'Budget Breakdown',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _CategoryPieChart(
                        data: sortedCategories,
                        touchedIndex: _touchedPieIndex,
                        onTouched: (idx) => setState(() => _touchedPieIndex = idx),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 14, color: scheme.onSurface.withValues(alpha: 0.6)),
                          ),
                          Text(
                            '\$${state.total.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Line Chart
                Text(
                  'Last 7 Days',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: _TrendLineChart(
                    data: last7Days,
                    color: scheme.secondary,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Map<DateTime, double> _getLast7DaysTotals(List<TransactionModel> transactions) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final map = <DateTime, double>{};

    for (int i = 6; i >= 0; i--) {
      map[today.subtract(Duration(days: i))] = 0;
    }

    for (final t in transactions) {
      final tDate = DateTime(t.date.year, t.date.month, t.date.day);
      if (map.containsKey(tDate)) {
        map[tDate] = map[tDate]! + t.amount;
      }
    }
    return map;
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _InsightCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13, color: scheme.onSurface.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: scheme.primary),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: scheme.onSurface),
          ),
        ],
      ),
    );
  }
}

class _CategoryBarChart extends StatelessWidget {
  final List<MapEntry<String, double>> data;
  final Color color;

  const _CategoryBarChart({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();
    
    // Take top 5 for bar chart readability
    final topData = data.take(5).toList();
    final maxY = topData.first.value * 1.2;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY == 0 ? 100 : maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Theme.of(context).colorScheme.surface,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${topData[groupIndex].key}\n\$${rod.toY.toStringAsFixed(0)}',
                TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= topData.length) return const SizedBox();
                final category = topData[value.toInt()].key;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Icon(iconForCategory(category), size: 20, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                );
              },
              reservedSize: 32,
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          topData.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: topData[i].value,
                color: color,
                width: 22,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: color.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryPieChart extends StatelessWidget {
  final List<MapEntry<String, double>> data;
  final int touchedIndex;
  final Function(int) onTouched;

  const _CategoryPieChart({
    required this.data,
    required this.touchedIndex,
    required this.onTouched,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();
    
    final scheme = Theme.of(context).colorScheme;
    final colors = [
      scheme.primary,
      scheme.secondary,
      const Color(0xFF4A6572),
      const Color(0xFFF9A826),
      const Color(0xFFE57373),
      const Color(0xFF81C784),
    ];

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) {
              onTouched(-1);
              return;
            }
            onTouched(pieTouchResponse.touchedSection!.touchedSectionIndex);
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 65,
        sections: List.generate(data.length, (i) {
          final isTouched = i == touchedIndex;
          final color = colors[i % colors.length];
          return PieChartSectionData(
            color: color,
            value: data[i].value,
            title: isTouched ? '\$${data[i].value.toStringAsFixed(0)}' : '',
            radius: isTouched ? 35 : 25,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            badgeWidget: isTouched ? null : Icon(iconForCategory(data[i].key), size: 16, color: Colors.white),
            badgePositionPercentageOffset: 0.5,
          );
        }),
      ),
    );
  }
}

class _TrendLineChart extends StatelessWidget {
  final Map<DateTime, double> data;
  final Color color;

  const _TrendLineChart({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();
    if (entries.isEmpty) return const SizedBox();
    
    final maxY = entries.map((e) => e.value).reduce(math.max) * 1.2;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= entries.length) return const SizedBox();
                // Show title every other day to avoid crowding
                if (idx % 2 != 0 && entries.length > 5) return const SizedBox();
                final date = entries[idx].key;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    DateFormat.E().format(date),
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                );
              },
              reservedSize: 32,
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: entries.length.toDouble() - 1,
        minY: 0,
        maxY: maxY == 0 ? 10 : maxY,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              entries.length,
              (i) => FlSpot(i.toDouble(), entries[i].value),
            ),
            isCurved: true,
            color: color,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: color.withValues(alpha: 0.15),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => Theme.of(context).colorScheme.surface,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final date = entries[spot.x.toInt()].key;
                return LineTooltipItem(
                  '${DateFormat.Md().format(date)}\n\$${spot.y.toStringAsFixed(0)}',
                  TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
