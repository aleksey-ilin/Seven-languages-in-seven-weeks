% Do monitor the translate_service and restart it should it die.

-module(translate_service_monitor).
-export([loop/0]).
loop() ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating and monitoring process.~n"),
            register(translator, spawn_link(fun translate_service:loop/0)),
            loop();
        {'EXIT', From, Reason} ->
            io:format("The translate service ~p died with reason ~p.", [From, Reason]),
			io:format(" Restarting. ~n"),
            self() ! new,
            loop()
        end.

% c(translate_service_monitor).
% c(translate_service).
% Monitor = spawn(fun translate_service_monitor:loop/0).
% Monitor ! new.
% translate_service:translate(translator, "blanca").
% translate_service:translate(translator, "error").
