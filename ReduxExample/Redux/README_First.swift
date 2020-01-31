/*
 
 For example on how to use data store,
    see ./Example/ExampleUsage
 
 For example of an implementation of a data store,
    see ./Example
 
 For instruction on implementing your own data store,
    see ./Template/README

*/

/*
 To use within production environment:
 
 - initialize data store in topmost parent component and put it in a constant property
 
    ```
    class ShopViewController {
        let store = ShopDataStore()
    }
    ```
 
 - pass store to children of that parent so that the children can dispatch to the data store and subscribe to the data store's state
 
    ```
    class ShopViewController {
        let store = ShopDataStore()
        let childrenComponent: UIView = ChildrenComponent1(store: store)
        let childrenComponent: UIViewController = ChildrenComponent2(store: store)
    }
    ```
 
*/
