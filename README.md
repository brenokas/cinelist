# 🎬 Cine List

Cine List é um aplicativo iOS desenvolvido em SwiftUI que permite explorar filmes através da API do The Movie Database (TMDB).

O projeto foi criado com o objetivo de consolidar conhecimentos em Swift e SwiftUI, aplicando conceitos modernos de desenvolvimento mobile como arquitetura MVVM, consumo de APIs REST, programação assíncrona com Async/Await, navegação entre telas, gerenciamento de estados e persistência local.

---

# 📱 Sobre o Projeto

O aplicativo permite que usuários:

- Visualizem filmes populares
- Pesquisem filmes por nome
- Visualizem detalhes completos de um filme
- Adicionem filmes aos favoritos
- Consultem sua lista de favoritos
- Naveguem entre diferentes telas

O objetivo é simular um aplicativo real de catálogo de filmes, demonstrando os principais conceitos aprendidos durante os estudos de Swift e SwiftUI.

---

# 🎯 Objetivos de Aprendizado

Este projeto foi desenvolvido para praticar:

- SwiftUI
- MVVM (Model-View-ViewModel)
- Consumo de APIs REST
- Async/Await
- Decodable
- NavigationStack
- Searchable
- AsyncImage
- Persistência local
- Tratamento de erros
- Gerenciamento de estados da interface

---

# 🛠 Tecnologias Utilizadas

- Swift
- SwiftUI
- TMDB API

---

# 🏗 Arquitetura

O projeto utiliza a arquitetura MVVM.

---

# 📂 Estrutura de Pastas

```text
CineList
│
├── CineListApp.swift
├── Assets.xcassets
├── Models
│   ├── Movie.swift
│   └── MovieResponse.swift
├── Services
│   └── MoviesService.swift
├── ViewModels
│   ├── HomeViewModel.swift
│   └── FavoritesViewModel.swift
└── Views
    ├── HomeView.swift
    ├── MovieDetailView.swift
    └── FavoritesView.swift
```