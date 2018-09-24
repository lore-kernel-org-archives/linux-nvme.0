From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 24 Sep 2018 02:40:59 -0700
Subject: [PATCH v2] NVMe multipath Added configarable failover progression
 time
In-Reply-To: <20180924073111.17132-1-susobhan.dey@gmail.com>
References: <f7534931-eb78-aa7c-6ede-a617d8258e37@grimberg.me>
 <20180924073111.17132-1-susobhan.dey@gmail.com>
Message-ID: <8291dced-f23a-0fce-c550-fa2129dbf3f1@grimberg.me>


> Added a module parameter failover_tt to tell multipather
> how long it should wait before sending commands to next
> available path. The whole reason of adding it, not all
> architecture can handle IOs in active/active fashion even
> though next path is live/accessible it can't handle IOs
> immediately.

Then it shouldn't be exposed as a path to the host.

> We should give some time to underneath controller
> to make itself active.

If its not active, don't have the host connected to it
in the first place. Otherwise, block the I/O on the controller
end until it gets into shape. non-optimized state semantics tells the
host that I/O service will not be optimal through that path, so
it should be well expected.

> ANA gives them the provision,using ANA
> it is possible to advertise path status.

Its not status, its state.

> Say for example if
> path is in transition then host will requeue the commands till
> path become optimized/unoptimized if no other path is optimized.
> So this is a host side additional provision where multipather
> will wait for sometime for example 10 sec and by that time controller
> should be active to handle IOs.

I'm sorry, but there is no justification for this sort of bogus setting.
If you have a proposal to address some architecture that asks the host
to block I/O although it has an available path, please propose a
technical proposal and make it a standard extension that can be
interrogated by the host.

Adding a global knob in the form of a modparam is a non-starter.

> Whole point is controller is live
> does not necessarily mean that controller is active.

Then what does it mean? its enabled, allocated I/O queues, contains
namespaces, exposes ANA states etc.. It should be capable of servicing
I/O.
