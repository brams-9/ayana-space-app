import 'package:ayana_space_app/cores/dependenciesInjection/service_locator.dart';
import 'package:ayana_space_app/cores/repositories/launches_list_repository.dart';
import 'package:ayana_space_app/cores/viewmodels/home_page_viewmodel.dart';
import 'package:ayana_space_app/datas/models/launches.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageViewModel(
            repository: serviceLocator<LaunchesListRepository>(),
          ),
        ),
      ],
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  _HomePage({
    super.key,
  });

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomePageViewModel>().fetchLaunches(LaunchType.upComing);
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            context
                .read<HomePageViewModel>()
                .fetchLaunches(LaunchType.upComing);
            break;
          case 1:
            context.read<HomePageViewModel>().fetchLaunches(LaunchType.past);
            break;
          case 2:
            context.read<HomePageViewModel>().fetchLaunches(LaunchType.latest);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C0E),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 28),
              // Logo replacement
              Center(
                child: Text(
                  'AYANA',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TabBar(
                  indicatorColor: const Color(0xFF1FA3FF),
                  indicatorWeight: 3,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  tabs: const [
                    Tab(child: _UpperTabText('UPCOMING')),
                    Tab(child: _UpperTabText('PAST')),
                    Tab(child: _UpperTabText('LATEST')),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Lists per tab
              Expanded(
                child: Consumer<HomePageViewModel>(
                    builder: (context, viewModel, child) {
                  if (viewModel.error != null) {
                    return Center(
                      child: Text("Sedang Terjadi Kesalahan"),
                    );
                  }

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _LaunchesList(
                          items: viewModel.upCominglaunches ?? [],
                          isLoading: viewModel.isUpComingLoading),
                      _LaunchesList(
                          items: viewModel.pastlaunches ?? [],
                          isLoading: viewModel.isPastLoading),
                      _LaunchesList(
                          items: viewModel.latestlaunches != null
                              ? [viewModel.latestlaunches!]
                              : [],
                          isLoading: viewModel.isLatestLoading),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpperTabText extends StatelessWidget {
  const _UpperTabText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _LaunchesList extends StatelessWidget {
  const _LaunchesList({
    required this.items,
    required this.isLoading,
  });
  final List<Launches> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No launches found',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return _LaunchCard(item: item);
      },
    );
  }
}

class _LaunchCard extends StatelessWidget {
  const _LaunchCard({required this.item});
  final Launches item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121821),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'Unknown Name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    letterSpacing: .5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${item.launchDate} • ${item.launchTime}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    letterSpacing: .2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Flight-${(item.flightNumber ?? 0).toString()}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Thumbnail placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 84,
              height: 110,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF274060), Color(0xFF1C2C40)],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LaunchItem {
  final String title;
  final DateTime datetime;
  final String location;
  final String rocket;
  const LaunchItem({
    required this.title,
    required this.datetime,
    required this.location,
    required this.rocket,
  });
}

// Mock Data
const _kLocation = 'KENNEDY SPACE CENTER';
const _kRocket = 'Falcon 9';

final List<LaunchItem> _mockPast = [
  LaunchItem(
    title: 'CRS-27',
    datetime: DateTime(2023, 11, 11, 6, 27),
    location: _kLocation,
    rocket: _kRocket,
  ),
  LaunchItem(
    title: 'STARLINK 5-13',
    datetime: DateTime(2023, 10, 30, 9, 15),
    location: _kLocation,
    rocket: _kRocket,
  ),
  LaunchItem(
    title: 'STARLINK 5-12',
    datetime: DateTime(2023, 10, 18, 7, 32),
    location: _kLocation,
    rocket: _kRocket,
  ),
];

final List<LaunchItem> _mockUpcoming = [
  LaunchItem(
    title: 'STARLINK 6-55',
    datetime: DateTime(2025, 11, 12, 10, 0),
    location: _kLocation,
    rocket: _kRocket,
  ),
  LaunchItem(
    title: 'Transporter-12',
    datetime: DateTime(2025, 12, 5, 8, 45),
    location: _kLocation,
    rocket: _kRocket,
  ),
];

final List<LaunchItem> _mockLatest = [
  LaunchItem(
    title: 'STARLINK 7-01',
    datetime: DateTime(2025, 9, 2, 14, 10),
    location: _kLocation,
    rocket: _kRocket,
  ),
];
