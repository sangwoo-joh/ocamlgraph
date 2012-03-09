(**************************************************************************)
(*                                                                        *)
(*  Ocamlgraph: a generic graph library for OCaml                         *)
(*  Copyright (C) 2004-2010                                               *)
(*  Sylvain Conchon, Jean-Christophe Filliatre and Julien Signoles        *)
(*                                                                        *)
(*  This software is free software; you can redistribute it and/or        *)
(*  modify it under the terms of the GNU Library General Public           *)
(*  License version 2.1, with the special exception on linking            *)
(*  described in file LICENSE.                                            *)
(*                                                                        *)
(*  This software is distributed in the hope that it will be useful,      *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  *)
(*                                                                        *)
(**************************************************************************)

(* This module is a contribution of Yuto Takei *)

open Sig
open Blocks
open Persistent

(** Weighted graphs without negative cycles *)

(** Hello world! *)

(** Signature for edges' weights. *)
module type WEIGHT = sig
  type label
    (** Type for labels of graph edges. *)
  type t
    (** Type of edges' weights. *)
  val weight : label -> t
    (** Get the weight of an edge. *)
  val compare : t -> t -> int
    (** Weights must be ordered. *)
  val add : t -> t -> t
    (** Addition of weights. *)
  val zero : t
    (** Neutral element for {!add}. *)
end

(** Non neg  *)

module NonNegative : sig
  (** Persistent graphs *)

  module Persistent
    (G: Sig.P)
    (W: WEIGHT with type label = G.E.label) : sig

    include Sig.P with module V = G.V and module E = G.E

    exception Negative_cycle of G.E.t list
      (** Exception [NegativeCycle] is raised whenever a negative cycle
          is introduced for the first time (either with [add_edge]
          or [add_edge_e]) *)



  end

end