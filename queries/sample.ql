import python
import semmle.python.libraries.Zope

predicate is_type_method(FunctionValue fv) {
  exists(ClassValue c | c.declaredAttribute(_) = fv and c.getASuperType() = ClassValue::type())
}

predicate used_in_defining_scope(FunctionValue fv) {
  exists(Call c | c.getScope() = fv.getScope().getScope() and c.getFunc().pointsTo(fv))
}

from Function f, FunctionValue fv, string message
where
  exists(ClassValue cls, string name |
    cls.declaredAttribute(name) = fv and
    cls.isNewStyle() and
    not name = "__new__" and
    not name = "__metaclass__" and
    not name = "__init_subclass__" and
    not name = "__class_getitem__" and
    /* declared in scope */
    f.getScope() = cls.getScope()
  ) and
  f.getArgName(0) = "hoge" and
  not is_type_method(fv) and
  fv.getScope() = f and
  not f.getName() = "lambda" and
  not used_in_defining_scope(fv) and
  (
    (
      if exists(f.getArgName(0))
      then
        message =
          "First argument of function should not be hoge"
      else
        message =
          "Normal methods should have at least one parameter (the first of which should not be 'hoge')."
    ) and
    not f.hasVarArg()
  ) and
  not fv instanceof ZopeInterfaceMethodValue
select f, message
