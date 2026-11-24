import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ExperienceListScreen extends StatefulWidget {
  const ExperienceListScreen({super.key});

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  late Future<List<Experience>> _experiencesFuture;

  @override
  void initState() {
    super.initState();
    _experiencesFuture = context.read<ApiClient>().getExperiences();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getExperiences();
    setState(() {
      _experiencesFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiences')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Experience>>(
        future: _experiencesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load experiences: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // TODO: Read experiences from snapshot.data, defaulting to an empty list.
          // When the list is empty, return a centered 'No experiences found.' message
          // wrapped in RefreshIndicator + SingleChildScrollView(physics: AlwaysScrollableScrollPhysics())
          // so pull-to-refresh still works on an empty list.
          final experiences = snapshot.data ?? <Experience>[];

          if (experiences.isEmpty) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  onRefresh: _reload,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: constraints.maxHeight,
                      child: const Center(
                        child: Text('No experiences found.')
                      )
                    )
                  )
                );
              }
            ); 
          }

          // TODO: Return a RefreshIndicator (onRefresh: _reload) wrapping a
          // ListView.builder that renders a Card/ListTile for each experience
          // (showing experience.title, experience.skills, and experience.description)
          // and navigates to ExperienceDetailScreen on tap once it exists.
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final experience = experiences[index];

                return Card(
                  child: ListTile(
                    title: Text(experience.title),
                    subtitle: Text([
                      if (experience.skills.isNotEmpty) experience.skills,
                      experience.description,
                    ].join('\n')),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
