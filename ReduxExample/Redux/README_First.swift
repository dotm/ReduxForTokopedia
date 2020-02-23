/*

 For example on how to use data store,
 see ./Example/ExampleUsage

 For example of an implementation of a data store,
 see ./Example

 For instruction on implementing your own data store,
 see ./Template/README
 
 Module structure:
 - ExampleModule            //the main module
    dependencies:
    - ExampleModuleRedux
    - ExampleModuleModels
    - ExampleModuleEnums
 - ExampleModuleRedux       //Redux must NOT depend on the main module
    dependencies:
    - ExampleModuleModels
    - ExampleModuleEnums

 */
