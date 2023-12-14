import 'package:flutter/material.dart';



class MySearchDelegate extends SearchDelegate{

  List<String> searchResults=[];



  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
            if(query.isEmpty){
              close(context,null);

            }else{
              query = '';

            }
          },
        ),
      ];
    // TODO: implement buildActions
    // throw UnimplementedError();

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context,null),
      icon: const Icon(Icons.arrow_back));
    // TODO: implement buildLeading
    // throw UnimplementedError();


  @override
  Widget buildResults(BuildContext context) => IconButton(
      onPressed: () {
        query='';
      }, icon: const Icon(Icons.clear));
    // TODO: implement buildResults
    // throw UnimplementedError();


  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> suggestions = searchResults.where((searchResults){
      final result = searchResults.toLowerCase();
      final input =query.toLowerCase();

      return result.contains(input);
    }).toList();

    // throw UnimplementedError();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index){
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap:(){
              query:suggestion;

            }
          );
        },
    );


  }

  


}