:- dynamic(task/4).

create_task(Id, Description, Assignee):-
    \+ task(Id, _, _, _),
    assertz(task(Id, Description, Assignee, false)),
    format("Task created: ~w.", [Id]).

assign_task(Id, New_assignee):-
    retract(task(Id, Description, _, Status)),
    assertz(task(Id, Description, New_assignee, Status)),
    format("Task ~w assigned to user: ~w.", [Id, New_assignee]).

mark_completed(Id):-
    task(Id, Description, Assignee, _),
    retract(task(Id, _, _, _)),
    assertz(task(Id, Description, Assignee, true)),
    format("Task ~w marked as completed.", [Id]).

display_tasks:-
    forall(
        task(Id, Description, Assignee, Status),
        format("Task ~w:\n\t- Description: ~w\n\t- Assignee: ~w\n\t- Completion status: ~w\n", [Id, Description, Assignee, Status])
    ).

display_tasks_assigned_to(Assignee):-
    forall(
        task(Id, Description, Assignee, Status),
        format("Tasks assigned to ~w:\nTask ~w:\n\t- Description: ~w\n\t- Completion status: ~w\n", [Assignee, Id, Description, Status])
    ).

display_completed_tasks:-
    forall(
        task(Id, Description, Assignee, true),
        format("Completed tasks:\nTask ~w:\n\t- Description: ~w\n\t- Completion status: ~w\n", [Id, Assignee, Description])
    ).

display_uncompleted_tasks:-
    forall(
        task(Id, Description, Assignee, false),
        format("Uncompleted tasks:\nTask ~w:\n\t- Description: ~w\n\t- Completion status: ~w\n", [Id, Assignee, Description])
    ).