//
//  ContentView.swift
//  BirdsAppApi
//
//  Created by Jakub Patelski on 12/03/2023.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var birdData = BirdData()
    var body: some View {
        NavigationView {
            List(birdData.birds) { bird in
                NavigationLink(destination: BirdDetailView(bird: bird)) {
                    HStack{
                        BirdRow(bird: bird)

                    }
                }
            }
            .navigationBarTitle("Birds")
        }
    }
}


struct BirdRow: View {
    let bird: Bird
    
    var body: some View {
        HStack {
            AsyncImage(url: bird.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()

            }
            
            Text(bird.name)
                .fontWeight(.semibold)
                .padding(.leading, 5)
                
            
        }
    }
}

struct BirdDetailView: View {
    let bird: Bird
    
    var body: some View {
        VStack {
            AsyncImage(url: bird.imageUrl){ image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical, 25)
                
            } placeholder: {
                ProgressView("Loading")
            }

            
            Text(bird.description)
                .lineLimit(7)
            
            Spacer()

            Link(destination: URL(string: bird.wikipediaUrl)!, label: {
                Image("wikipedia")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
            })
            
        }
        .padding()
        .navigationBarTitle(bird.name)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
