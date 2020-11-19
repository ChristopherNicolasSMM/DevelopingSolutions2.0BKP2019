**----------------------------------------------------------------------*
**   INCLUDE COLUMN_TREE_CONTROL_DEMOCL1                                *
**----------------------------------------------------------------------*
*
*CLASS LCL_APPLICATION DEFINITION.
*
*  PUBLIC SECTION.
*    METHODS:
*      HANDLE_NODE_DOUBLE_CLICK
*        FOR EVENT NODE_DOUBLE_CLICK
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING NODE_KEY,
*      HANDLE_HEADER_CLICK
*        FOR EVENT HEADER_CLICK
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING HEADER_NAME,
*      HANDLE_EXPAND_NO_CHILDREN
*        FOR EVENT EXPAND_NO_CHILDREN
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING NODE_KEY,
*      HANDLE_ITEM_DOUBLE_CLICK
*        FOR EVENT ITEM_DOUBLE_CLICK
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING NODE_KEY ITEM_NAME,
*      HANDLE_BUTTON_CLICK
*        FOR EVENT BUTTON_CLICK
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING NODE_KEY ITEM_NAME,
*      HANDLE_LINK_CLICK
*        FOR EVENT LINK_CLICK
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING NODE_KEY ITEM_NAME,
*      HANDLE_CHECKBOX_CHANGE
*        FOR EVENT CHECKBOX_CHANGE
*        OF CL_GUI_COLUMN_TREE
*        IMPORTING NODE_KEY ITEM_NAME CHECKED.
*ENDCLASS.                    "LCL_APPLICATION DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS LCL_APPLICATION IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS LCL_APPLICATION IMPLEMENTATION.
*
*  METHOD HANDLE_NODE_DOUBLE_CLICK.
*    " this method handles the node double click event of the tree
*    " control instance
*
*    " show the key of the double clicked node in a dynpro field
*    G_EVENT = 'NODE_DOUBLE_CLICK'.
*    G_NODE_KEY = NODE_KEY.
*    CLEAR: G_ITEM_NAME, G_HEADER_NAME.
*  ENDMETHOD.                    "HANDLE_NODE_DOUBLE_CLICK
*
*  METHOD HANDLE_HEADER_CLICK.
*    " this method handles header click event of the tree
*                                       " control instance
*
*    " show the name of the clicked header in a dynpro field
*    G_EVENT = 'HEADER_CLICK'.
*    G_HEADER_NAME = HEADER_NAME.
*    CLEAR: G_NODE_KEY, G_ITEM_NAME.
*  ENDMETHOD.                    "HANDLE_HEADER_CLICK
*
*  METHOD  HANDLE_ITEM_DOUBLE_CLICK.
*    " this method handles the item double click event of the tree
*    " control instance
*
*    " show the key of the node and the name of the item
*    " of the double clicked item in a dynpro field
*    G_EVENT = 'ITEM_DOUBLE_CLICK'.
*    G_NODE_KEY = NODE_KEY.
*    G_ITEM_NAME = ITEM_NAME.
*    CLEAR G_HEADER_NAME.
*  ENDMETHOD.                    "HANDLE_ITEM_DOUBLE_CLICK
*
*  METHOD  HANDLE_LINK_CLICK.
*    " this method handles the link click event of the tree
*    " control instance
*
*    " show the key of the node and the name of the item
*    " of the clicked link in a dynpro field
*    G_EVENT = 'LINK_CLICK'.
*    G_NODE_KEY = NODE_KEY.
*    G_ITEM_NAME = ITEM_NAME.
*    CLEAR G_HEADER_NAME.
*  ENDMETHOD.                    "HANDLE_LINK_CLICK
*
*  METHOD  HANDLE_BUTTON_CLICK.
*    " this method handles the button click event of the tree
*    " control instance
*
*    " show the key of the node and the name of the item
*    " of the clicked button in a dynpro field
*    G_EVENT = 'BUTTON_CLICK'.
*    G_NODE_KEY = NODE_KEY.
*    G_ITEM_NAME = ITEM_NAME.
*    CLEAR G_HEADER_NAME.
*  ENDMETHOD.                    "HANDLE_BUTTON_CLICK
*
*  METHOD  HANDLE_CHECKBOX_CHANGE.
*    " this method handles the checkbox_change event of the tree
*    " control instance
*
*    " show the key of the node and the name of the item
*    " of the clicked checkbox in a dynpro field
*    G_EVENT = 'CHECKBOX_CHANGE'.
*    G_NODE_KEY = NODE_KEY.
*    G_ITEM_NAME = ITEM_NAME.
*    CLEAR  G_HEADER_NAME.
*  ENDMETHOD.                    "HANDLE_CHECKBOX_CHANGE
*
*
*  METHOD HANDLE_EXPAND_NO_CHILDREN.
*    DATA: NODE_TABLE TYPE TREEV_NTAB,
*          NODE TYPE TREEV_NODE,
*          ITEM_TABLE TYPE ITEM_TABLE_TYPE,
*          ITEM TYPE MTREEITM.
*
*** show the key of the expanded node in a dynpro field
**    G_EVENT = 'EXPAND_NO_CHILDREN'.
**    G_NODE_KEY = NODE_KEY.
**    CLEAR: G_ITEM_NAME, G_HEADER_NAME.
**
**    IF node_key = c_nodekey-child1.
*** add two nodes
**
*** Node with key 'New1'
**      CLEAR NODE.
**      node-node_key = c_nodekey-New1.
**      node-relatkey = c_nodekey-child1.
**      NODE-RELATSHIP = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD.
**      APPEND NODE TO NODE_TABLE.
**
*** Node with key 'New2'
**      CLEAR NODE.
**      node-node_key = c_nodekey-New2.
**      node-relatkey = c_nodekey-child1.
**      NODE-RELATSHIP = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD.
**      NODE-N_IMAGE = '@10@'.
**      APPEND NODE TO NODE_TABLE.
**
*** Items of node with key 'New1'
**      CLEAR ITEM.
**      item-node_key = c_nodekey-New1.
**      item-item_name = c_column-Column1.
**      item-class = cl_gui_column_tree=>item_class_text.
**      item-text = 'New1 Col. 1'(n11).
**      APPEND ITEM TO ITEM_TABLE.
**
**      CLEAR ITEM.
**      item-node_key = c_nodekey-New1.
**      item-item_name = c_column-Column2.
**      ITEM-CLASS = CL_GUI_COLUMN_TREE=>ITEM_CLASS_LINK.
**      item-t_image = '@3C@'.
**      APPEND ITEM TO ITEM_TABLE.
**
**      CLEAR ITEM.
**      item-node_key = c_nodekey-New1.
**      item-item_name = c_column-Column3.
**      item-class = cl_gui_column_tree=>item_class_text.
**      item-text = 'New1 Col. 3'(n13).
**      APPEND ITEM TO ITEM_TABLE.
**
*** Items of node with key 'New2'
**      CLEAR ITEM.
**      item-node_key = c_nodekey-New2.
**      item-item_name = c_column-Column1.
**      item-class = cl_gui_column_tree=>item_class_text.
**      item-text = 'New2 Col. 1'(n21).
**      APPEND ITEM TO ITEM_TABLE.
**
**      CLEAR ITEM.
**      item-node_key = c_nodekey-New2.
**      item-item_name = c_column-Column2.
**      item-class = cl_gui_column_tree=>item_class_text.
**      item-text = 'New2 Col. 2'(n22).
**      APPEND ITEM TO ITEM_TABLE.
**
**      CLEAR ITEM.
**      item-node_key = c_nodekey-New2.
**      item-item_name = c_column-Column3.
**      item-class = cl_gui_column_tree=>item_class_text.
**      item-text = 'New2 Col. 3'(n23).
**      APPEND ITEM TO ITEM_TABLE.
**
**
**    endif.
*  ENDMETHOD.                    "HANDLE_EXPAND_NO_CHILDREN
*
*ENDCLASS.                    "LCL_APPLICATION IMPLEMENTATION
