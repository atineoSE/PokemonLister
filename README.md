# PokemonLister: sample app

This is a sample iOS app that lists pokemons and their characteristics.

![](./demo/demo.gif)



## Project notes

* The architecture is MVC+C, with the expanded definition of MVC to include model controllers (such as the `PersistenceController` or the `NetworkController`). Additionally, view models are used for views (e.g. `PropertiesViewModel`) and use cases for business logic (e.g. `FetchPokemonListUseCase`).

* The minimum iOS target supported is iOS11, the app was coded in Swift 5.

* Pokemon data is taken from [this open API](https://pokeapi.co).

* Images for the pokemons are not offered by the API and were instead downloaded from [this repo](https://github.com/PokeAPI/sprites) and copied to the app bundle. In order to prevent the app from growing too much, we only offer images for the first 100 listed pokemon (there may be more than one image per pokemon in the detail page though, e.g. try with pikachu). Beyond the first 100 pokemons, a placeholder image is displayed, which is just an indication that the image was not preloaded.

* There are some unit tests for exemplification purposes, at the network, the model, the data source, and the utilities/helpers level.

* No third party packages were used for this sample app.

* Light and dark mode are both supported.

* Landscape and portrait orientations are both supported.

* iPhone and iPad are both supported.

* Offline support is offered by storing fetched data in locally available property list files, as a lightweight persistence solution. The app architecture would make it seamless to replace it for other persistence technologies, such as Core Data or SQLite.

* The project is personalized with a handy feature: in the pokemon detail screen there is a "show more / show less" button to blend/unblend long lists of properties such as the moves or the abilities of the pokemon.

  

  

  

