From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 13 Jan 2016 12:50:03 +0200
Subject: [LSF/MM ATTEND][LSF/MM TOPIC] Multipath redesign
In-Reply-To: <56961493.5010901@suse.de>
References: <56961493.5010901@suse.de>
Message-ID: <56962BDB.4080509@dev.mellanox.co.il>


> Hi all,
>
> I'd like to attend LSF/MM and would like to present my ideas for a
> multipath redesign.
>
> The overall idea is to break up the centralized multipath handling in
> device-mapper (and multipath-tools) and delegate to the appropriate
> sub-systems.

I agree that would be very useful. Great topic. I'd like to attend
this talk as well.

>
> Individually the plan is:
> a) use the 'wwid' sysfs attribute to detect multipath devices;
>     this removes the need of the current 'path_id' functionality
>     in multipath-tools

CC'ing Linux-nvme,

I've recently looked at multipathing support for nvme (and nvme over
fabrics) as well. For nvme the wwid equivalent is the nsid (namespace
identifier). I'm wandering if we can have better abstraction for
user-space so it won't need to change its behavior for scsi/nvme.
The same applies for the the timeout attribute for example which
assumes scsi device sysfs structure.

> b) leverage topology information from scsi_dh_alua (which we will
>     have once my ALUA handler update is in) to detect the multipath
>     topology. This removes the need of a 'prio' infrastructure
>     in multipath-tools

This would require further attention for nvme.

> c) implement block or scsi events whenever a remote port becomes
>     unavailable. This removes the need of the 'path_checker'
>     functionality in multipath-tools.

I'd prefer if we'd have it in the block layer so we can have it for all
block drivers. Also, this assumes that port events are independent of
I/O. This assumption is incorrect in SRP for example which detects port
failures only by I/O errors (which makes path sensing a must).

> d) leverage these events to handle path-up/path-down events
>     in-kernel
> e) move the I/O redirection logic out of device-mapper proper
>     and use blk-mq to redirect I/O. This is still a bit of
>     hand-waving, and definitely would need discussion to figure
>     out if and how it can be achieved.
>     This is basically the same topic Mike Snitzer proposed, but
>     coming from a different angle.

Another (adjacent) topic is multipath performance with blk-mq.

As I said, I've been looking at nvme multipathing support and
initial measurements show huge contention on the multipath lock
which really defeats the entire point of blk-mq...

I have yet to report this as my work is still in progress. I'm not sure
if it's a topic on it's own but I'd love to talk about that as well...

> But in the end we should be able to do strip down the current (rather
> complex) multipath-tools to just handle topology changes; everything
> else will be done internally.

I'd love to see that happening.
