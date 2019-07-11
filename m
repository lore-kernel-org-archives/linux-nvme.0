From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 11 Jul 2019 16:54:39 -0700
Subject: [PATCH rfc 4/6] nvme-cli: expand --device argument processing
In-Reply-To: <20190710232740.26734-5-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-5-jsmart2021@gmail.com>
Message-ID: <a7387cde-a948-c72a-7878-6b25bdeeba37@grimberg.me>


> The connect-all --device argument was used to specify a specific device
> to be used as the discovery controller. The device is typically a
> long-lived discovery controller that posted a discovery event.
> No attempt was made to ensure the device is who it is supposed to be
> before using it.
> 
> Revised the code to use the other arguments in the connect-all request
> to validate that the device is the entity that was expected. If the
> device doesn't match, the cli will look for an existing matching device
> (will be a discovery controller due to nqn) with the same connect
> parameters and use it.  If one is not found on the system, a new
> discovery controller will be created for the connect-all request.

Remind me James, this is to protect the case where the discovery
controller is deleted and a new one was added instead?

> To implement this:
> - The code that existed in the subsystem listing that gathers
>    controller data is split into a service routine that gets a
>    controllers info. The subsystem routine uses the new routine.

Separate patch

> - The controller list element is extended to have the connect
>    argument fields, and the new routine extended to set the > - As the routine may be called independently of a subsystem,
>    the new routine obtains the subsysnqn.

Squashed with the first patch.

> - A simple parse routine was created to search for the connect
>    tokens in a connect-all string or the address string for a
>    controller.
> - a new struct was added containing connect args. This is used
>    for subsequent searches and matches.

Separate patch?

> - A new routine was created that compares the new connect arg
>    struct vs a controller list entry's connect args.

Separate patch?

> - A new routine was created that loops through all controllers
>    and attempts to match a controller to a set of connect
>    args passed in to search for.

Separate patch?

> - The --device handling was augmented to extract the connect
>    args from the connect-all request, attempt to match the
>    device vs the args, and if no match, looks for a match on
>    the system. If not match, the default path will create a
>    new discovery controller instance (non-persistent).

Final patch?
