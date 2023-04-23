//
//  PostList.swift
//  sunset-app
//
//  Created by Adrian Ma on 4/22/23.
//

import SwiftUI

struct PostList: View {
    @State var posts: [Post] = []
    var body: some View {
        List(posts) { post in
            Text(post.title)
        }
        .onAppear{
            Api().getPosts { (posts) in
                self.posts = posts
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
