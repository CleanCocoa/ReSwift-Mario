//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

infix operator |>: MultiplicationPrecedence

/// The `apply` operator.
/// Use this to chain function calls like `f: (A) -> B` and `g: (B) -> C` to `f |> g`
func |><T, U> (initial: T, f: (T) -> U) -> U {
    return f(initial)
}
