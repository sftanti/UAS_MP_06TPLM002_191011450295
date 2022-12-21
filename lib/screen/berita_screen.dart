import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasmp/cubit/berita_cubit.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({super.key});

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  final BeritaCubit beritaCubit = BeritaCubit();

  @override
  void initState() {
    beritaCubit.getDataBerita();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('191011450295 - SAFITRI RISTANTI'),
        ),
      ),
      body: BlocBuilder<BeritaCubit, BeritaState>(
        bloc: beritaCubit,
        builder: (context, state) {
          if (state is BeritaInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: beritaCubit.beritaModel.data?.posts?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Image.network(
                            beritaCubit
                                .beritaModel.data!.posts![index].thumbnail!,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Text(
                                  beritaCubit
                                      .beritaModel.data!.posts![index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, top: 15),
                                  child: Text(
                                    beritaCubit.beritaModel.data!.posts![index]
                                        .pubDate!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(
                                  beritaCubit.beritaModel.data!.posts![index]
                                      .description!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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