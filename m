From: hare@suse.de (Hannes Reinecke)
Date: Mon, 24 Sep 2018 11:16:18 +0200
Subject: [PATCH v2] NVMe multipath Added configarable failover progression
 time
In-Reply-To: <20180924073111.17132-1-susobhan.dey@gmail.com>
References: <f7534931-eb78-aa7c-6ede-a617d8258e37@grimberg.me>
 <20180924073111.17132-1-susobhan.dey@gmail.com>
Message-ID: <6ed66ac1-e32c-1fa1-b54e-cce907e8bcc6@suse.de>

On 9/24/18 9:31 AM, Susobhan Dey wrote:
> Added a module parameter failover_tt to tell multipather
> how long it should wait before sending commands to next
> available path. The whole reason of adding it, not all
> architecture can handle IOs in active/active fashion even
> though next path is live/accessible it can't handle IOs
> immediately. We should give some time to underneath controller
> to make itself active. ANA gives them the provision,using ANA
> it is possible to advertise path status. Say for example if
> path is in transition then host will requeue the commands till
> path become optimized/unoptimized if no other path is optimized.
> So this is a host side additional provision where multipather
> will wait for sometime for example 10 sec and by that time controller
> should be active to handle IOs. Whole point is controller is live
> does not necessarily mean that controller is active.
> 
> Signed-off-by: Susobhan Dey <susobhan.dey at gmail.com>
> ---
>   drivers/nvme/host/multipath.c | 59 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 19 ++++++++++-
>   2 files changed, 77 insertions(+), 1 deletion(-)
> 
That all sounds very dodgy.

If a controller is not able to accept I/Os immediately after switching
(Remember: this is NVMe-oF, where the _controller_ is responsible for 
switching paths, _not_ the host) it really should be setting the state 
to 'transitioning'.
And set the final state once it's ready to service I/Os.
Yes, this might result in all paths being set to 'transitioning', but 
that's well within scope.
Any controller which signals 'active/optimized' but is not able to 
service I/O really should be declared dead, and not worked around.
Please update the controller firmware to return 'transitioning' if it's 
not ready to service I/O after failover.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
