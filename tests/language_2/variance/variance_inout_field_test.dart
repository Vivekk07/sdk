// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Tests various fields for the `inout` variance modifier.

// SharedOptions=--enable-experiment=variance

import "package:expect/expect.dart";

typedef Void2Int = int Function();
typedef Int2Void = void Function(int);

class A<inout T> {
  T a;
  final T b = null;
  final T Function() c = () => null;
  final void Function(T) d = (T val) {
    Expect.equals(2, val);
  };
  A<T> get e => this;
}

mixin BMixin<inout T> {
  T a;
  final T b = null;
  final T Function() c = () => null;
  final void Function(T) d = (T val) {
    Expect.equals(2, val);
  };
  BMixin<T> get e => this;
}

class B with BMixin<int> {}

void testClass() {
  A<int> a = new A();

  a.a = 2;
  Expect.equals(2, a.a);

  Expect.isNull(a.b);

  Expect.type<Void2Int>(a.c);
  Expect.isNull(a.c());

  Expect.type<Int2Void>(a.d);
  a.d(2);

  a.e.a = 3;
}

void testMixin() {
  B b = new B();

  b.a = 2;
  Expect.equals(2, b.a);

  Expect.isNull(b.b);

  Expect.type<Void2Int>(b.c);
  Expect.isNull(b.c());

  Expect.type<Int2Void>(b.d);
  b.d(2);

  b.e.a = 3;
}

main() {
  testClass();
  testMixin();
}
