;; extends
; highlights

;
((type_identifier) @type.builtin
(#match? @type.builtin  "^u8$|^u16$|^u32$|^u64$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^i8$|^i16$|^i32$|^i64$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^s8$|^s16$|^s32$|^s64$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^b8$|^b32$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^umm$|^smm$|^byt$|^szt$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^uint8_t$|^uint16_t$|^uint32_t$|^uint64_t$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^int8_t$|^int16_t$|^int32_t$|^int64_t$"))

((type_identifier) @type.builtin
(#match? @type.builtin  "^f32$|^f64$"))

((primitive_type) @type.builtin
(#match? @type.builtin  "^void$|^bool$|^char$|^float$|^double$|^int$"))

((identifier) @constant
 (#lua-match? @constant "^[A-Z][A-Z0-9_]+$"))

((identifier) @constant
 (#lua-match? @constant "^[A-Z][a-z]*([A-Z][a-z]*)"))

((identifier) @type
 (#lua-match? @type "^[A-Za-z0-9_]-([A-Z]+[a-z]+)"))

((ERROR) @type
(#match? @type  ".*"))

((type_identifier) @keyword
(#match? @keyword  "^fn$|^function$|^internal$|^local$|^global$"))

(ERROR
  (identifier) @type) 

((identifier) @type.builtin
(#match? @type.builtin  "^void$|^bool$|^char$|^u8$|^u16$|^u32$|^u64$|^i8$|^i16$|^i32$|^i64$|^s8$|^s16$|^s32$|^s64$|^f32$|^f64$|^float$|^double$|^int$|^uint8_t$|^uint16_t$|^uint32_t$|^uint64_t$|^int8_t$|^int16_t|^int32_t$|^int64_t$|^umm$|^smm$|^szt$|^byt$|^b8$|^b32$"))

((identifier) @keyword
(#match? @keyword  "^const$"))

(call_expression
  function: (identifier) @function.call)
(call_expression
  function: (field_expression
    field: (field_identifier) @function.call))
(function_declarator
  declarator: (identifier) @function)
(preproc_function_def
  name: (identifier) @function.macro)

((identifier) @type
 (#lua-match? @type "_t$"))


