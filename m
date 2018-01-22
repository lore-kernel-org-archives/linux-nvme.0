From: oren.duer@gmail.com (Oren Duer)
Date: Mon, 22 Jan 2018 17:07:40 +0200
Subject: Reconnect on RDMA device reset
Message-ID: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>

Hi,

Today host and target stacks will respond to RDMA device reset (or plug out
and plug in) by cleaning all resources related to that device, and sitting
idle waiting for administrator intervention to reconnect (host stack) or
rebind subsystem to a port (target stack).

I'm thinking that maybe the right behaviour should be to try and restore
everything as soon as the device becomes available again. I don't think a
device reset should look different to the users than ports going down and up
again.

At the host stack we already have a reconnect flow (which works great when
ports go down and back up). Instead of registering to ib_client callback
rdma_remove_one and clean up everything, we could respond to the
RDMA_CM_EVENT_DEVICE_REMOVAL event and go into that reconnect flow.

In the reconnect flow the stack already repeats creating the cm_id and
resolving address and route, so when the RDMA device comes back up, and
assuming it will be configured with the same address and connected to the same
network (as is the case in device reset), connections will be restored
automatically.

At the target stack things are even worse. When the RDMA device resets or
disappears the softlink between the port and the subsystem stays "hanging". It
does not represent an active bind, and when the device will come back with the
same address and network it will not start working (even though the softlink
is there). This is quite confusing to the user.

What I suggest here is to implement something similar to the reconnect flow at
the host, and repeat the flow that is doing the rdma_bind_addr. This way,
again, when the device will come back with the same address and network the
bind will succeed and the subsystem will become functional again. In this case
it makes sense to keep the softlink during all this time, as the stack really
tries to re-bind to the port.

These changes also clean the code as RDMA_CM applications should not be
registering as ib_clients in the first place...

Thoughts?

Oren Duer
Mellanox Technologies
