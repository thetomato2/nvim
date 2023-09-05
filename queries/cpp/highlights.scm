; ;; extends
; ; highlights
;
; ; ((identifier) @constant
; ;  (#lua-match? @constant "^[A-Z][A-Z0-9_]+$"))
; ;
; ; ((identifier) @constant
; ;  (#lua-match? @constant "^[A-Z][a-z]*([A-Z][a-z]*)"))
; ;
; ; ((identifier) @type
; ;  (#lua-match? @type "^[A-Za-z0-9_]-([A-Z]+[a-z]+)"))
;
; ((ERROR) @type
; (#match? @type  ".*"))
;
; ; ((type_identifier) @keyword
; ; (#match? @keyword  "^fn|^function|^internal|^local|^global"))
;
;
; (this) @variable.builtin
; (nullptr) @variable.builtin
;
; (ERROR
;   (identifier) @type) 
;
; ((identifier) @type.builtin
; (#match? @type.builtin  "^void$|^bool$|^char$|^u8$|^u16$|^u32$|^u64$|^i8$|^i16$|^i32$|^i64$|^s8$|^s16$|^s32$|^s64$|^f32$|^f64$|^float$|^double$|^int$|^uint8_t$|^uint16_t$|^uint32_t$|^uint64_t$|^int8_t$|^int16_t|^int32_t$|^int64_t$|^umm$|^smm$|^szt$|^byt$|^b8$|^b32$"))
;
;
; (call_expression
;   function: (identifier) @function.call)
; (call_expression
;   function: (field_expression
;     field: (field_identifier) @function.call))
; (function_declarator
;   declarator: (identifier) @function)
; (preproc_function_def
;   name: (identifier) @function.macro)
;
; (function_declarator
;       declarator: (qualified_identifier
;         name: (identifier) @function))
; (function_declarator
;       declarator: (qualified_identifier
;         name: (qualified_identifier
;           name: (identifier) @function)))
; ((function_declarator
;       declarator: (qualified_identifier
;         name: (identifier) @constructor))
;  (#lua-match? @constructor "^[A-Z]"))
;
; (destructor_name
;   (identifier) @method)
;
; (namespace_definition
;     name:(namespace_definition_name
;         (identifier) @namespace))
;
