From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Apr 2018 16:04:52 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>


> Hi all,
> I've been debugging the KA mechanism lately and found a lack of
> coordination between the target and host implementations.
> 
> Johannes,
> Sorry for reverting your commit - I'll use nvme_start_keep_alive
> for my fix.
> 
> I've noticed that there is no clear definition in the NVMe spec
> regarding the keep-alive mechanism association. IMO, it should be
> a property of the admin queue and should be triggered as soon as
> the admin queue configured successfuly.
> 
> Idan/Christoph/Sagi,
> Any thoughts on that proposal ?

I don't understand what you mean by a "property of the admin queue",
there is no such definition in the spec. In any event, the keep alive
mechanism was defined to detect host/controller health on a periodic
basis.

The spec clearly states that the host needs to send keep alive at
a faster rate than the Keep alive timeout accounting things such
as transport roundtrip times, transport delays, keep alive timer
granularity and so on.

To me, this is a clear case where your use-case requires a larger
keep alive timeout. I'm not sure why sprinkling the keep alive execution
around solve/help anything. To me this looks completely redundant
(sorry).

We could theoretically make NVME_KATO_GRACE configurable, but I
seriously doubt its useful at all...

As a side note, Note that this should be solved by "Traffic Based Keep
Alive" TP which is approaching ratification. This is yet another example
showing that Having keep alive timer firing regardless of command
execution is hurtful.

> This patchset was tested using RDMA transport only:
> I've created 20 subsystems, 5 namespaces per subsystem and exposed
> all through 8 portals (total 160 ctrl's created) on 1 target.
> I used 1 initiator (host) and connected successfuly.
> Later on I've destroyed the target and caused a reconnection flow
> in the initiator side.
> Ater ~30-50 seconds, I've configured the target again but the initiator
> couldn't reconnect to it (after many retries).
> The reason for this was that the keep-alive timer expired at the target
> side, caused ctrl fatal error and the io-queue connect failed to find
> the ctrl. This loop never converged.
> 
> With the patches below, the test passed successfully after 1/2
> reconnection attempts.

Hence my comment above. As I said, I think you should either increase
the keep alive timeout for this use-case, or wait for TBKAS to ratify.
