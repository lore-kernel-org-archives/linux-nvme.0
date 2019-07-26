From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Jul 2019 10:39:08 -0700
Subject: [PATCH v3] nvme: fix controller removal race with scan work
In-Reply-To: <a5ce0b2d-e4d5-ab79-442c-4c3795fdb0fd@suse.de>
References: <20190725185657.9025-1-sagi@grimberg.me>
 <a5ce0b2d-e4d5-ab79-442c-4c3795fdb0fd@suse.de>
Message-ID: <93c38a70-3500-b1eb-38c7-41419c8f64c8@grimberg.me>


> Weellll ... I'm not sure if I totally agree with this one.

That's fair...

> As you might know I'm chasing down the mysterious reset/rescan issue, 
> too, and still haven't been able to resolve is properly.

Have you tried the patch that I proposed to you?

This is a different problem than what you reported, this is
addressing the scenario that the host connects and quickly
disconnects from a client before the scan is completed AND
multipath is enabled.

> But looking at this patch the hunk for clearing the current path on 
> removing namespaces looks like a good idea on itself.
> Care to separate this out?

Sure, although its designed to address this issue and not very
effective without the other part.

> Thing is, I had been notified on a regression caused by commit 
> 525aa5a705d86e ("nvme-multipath: split bios with the ns_head..."), which 
> manifests itself by a spurious I/O error during failover.

Hmm, this is interesting. Not sure how this specific commit would
introduce such an issue.

> This is hitting precisely the code path in nvme multipath; we're seeing 
> the message 'No path, failing I/O' during failover despite paths having 
> been reconnected previously.

Can we understand what are the controller states in this scenario?

> So your patch would indeed increase the likelyhood here, and I'm not 
> sure if that's the correct way to go.

Well, we are clearly doing the wrong thing if we're queueing I/O if all
the paths that we have are either DELETING or DEAD controllers. That
is precisely why we suffer from I/O hangs. This patch corrects this
wrong behavior. We must only requeue I/O if we have an available path
that is expected to sometime to resume (i.e. RESETTING/CONNECTING).

If we get I/O errors because all our paths are DELETING/DEAD then these
are not spurious, but rather expected.
