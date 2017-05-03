From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 May 2017 19:55:36 +0300
Subject: [PATCH] nvme core: allow controller RESETTING to RECONNECTING
 transition
In-Reply-To: <ce7a80c3-e746-cffc-7624-b013a94bca73@gmail.com>
References: <20170502185458.3495-1-jsmart2021@gmail.com>
 <fa1b98e7-9751-885e-a2b0-a1918779cf2a@grimberg.me>
 <ce7a80c3-e746-cffc-7624-b013a94bca73@gmail.com>
Message-ID: <a531ab03-f3d8-355c-80ec-9f66437ae67e@grimberg.me>

> I'm not following as, at a high level, it sounds like we're saying the
> same thing. I'm sure the difference is in the definitions of "controller
> reset" and "reestablish our controller session".
>
> here's how I view them:
>
> RESETTING: stopping the blk queues, killing the transport
> queues/connections and outstanding io on them, then formally tearing
> down the fabric association.  Officially, RESETTING would be when
> CC.EN=0 is done. But that can only occur if there is connectivity to the
> target and can use the admin connection for a Set_Property command. All
> the same actions take place except the Set_Property on cases where you
> lose connectivity. I'm viewing all of these actions, of terminating the
> original transport association, as RESETTING.
>
> RECONNECTING: restarting the association - creating transport
> queues/connections, reprobing the controller and re-releasing block
> queues. I'm viewing all of the actions to create a new transport
> association, as RECONNECTING.
>
> on FC, I was going to: move the controller from LIVE->RESETTING when
> tearing down the association, whether invoked by the core reset
> interface or upon detecting an error and independent of whether I can
> send an CC.EN=0 (which I'll do if connected); and after teardown, from
> RESETTING->CONNECTING as I start the new association. And if the new
> association can't be immediately created: a) if there is connectivity,
> use the same periodic retry based on max_reconnects and reconnect_delay;
> and b) if there isn't connectivity, delay until connectivity occurs or a
> timeout.

This sort of discussion really calls for a unification of control and
the error handling flows for all transports, with a single state
machine semantics. I'm currently looking into it, but I suspect it'll
take me a little while...

Christoph, Keith, any thoughts?
