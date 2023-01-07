%%--------------------------------------------------------------------
%% Copyright (c) 2020-2021 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_mod_slow_subs).

-behaviour(emqx_gen_mod).

-include_lib("include/emqx.hrl").
-include_lib("include/logger.hrl").

-logger_header("[SLOW Subs]").

%% emqx_gen_mod callbacks
-export([ load/1
        , unload/1
        , description/0
        ]).

-define(LIB, emqx_slow_subs).

%%--------------------------------------------------------------------
%% Load/Unload
%%--------------------------------------------------------------------

-spec(load(list()) -> ok).
load(Env) ->
    emqx_mod_sup:start_child(?LIB, worker, [Env]),
    ok.

-spec(unload(list()) -> ok).
unload(_Env) ->
    _ = emqx_mod_sup:stop_child(?LIB),
    ok.

description() ->
    "EMQ X Slow Subscribers Statistics Module".
