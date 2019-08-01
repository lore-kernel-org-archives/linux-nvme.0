From: kbusch@kernel.org (Keith Busch)
Date: Thu, 1 Aug 2019 08:33:31 -0600
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate
 failed because of controller reset
In-Reply-To: <55631812-bc90-9dc1-53b7-a76696a7140e@grimberg.me>
References: <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
 <2f7535ab-3d45-b24d-1512-a937e16e620f@grimberg.me>
 <20190731193257.GB15643@localhost.localdomain>
 <0720636c-8706-e927-3c0b-c2687694664f@grimberg.me>
 <20190731201634.GC15643@localhost.localdomain>
 <cb8a1faf-ea19-06c8-35dc-08cd11180974@grimberg.me>
 <20190731205836.GD15643@localhost.localdomain>
 <68358e82-cbd5-6199-1329-89421c778dc0@grimberg.me>
 <20190731215437.GA15795@localhost.localdomain>
 <55631812-bc90-9dc1-53b7-a76696a7140e@grimberg.me>
Message-ID: <20190801143331.GC15795@localhost.localdomain>

On Wed, Jul 31, 2019@06:13:06PM -0700, Sagi Grimberg wrote:
> 
> >> Well, I don't think we should do that. Unlike I/O commands, which can
> >> failover to a different path, these admin commands are bound to the
> >> specific controller. In case it takes minutes/hours/days for the
> >> controller to restore normal operation, it will be unpleasant to say
> >> the least to have admin operations get stuck for so long.
> > 
> > Unpleasant for who? The scan_work is the only thing waiting for these
> > commands, no one else should care because you can't run IO if you're
> > stuck in very long reset anyway.
> 
> The hung task detector would care, and a user who will attempt to issue
> a passthru command, and the rest of the system that have one of the
> kworkers sacrificed for a significant amount of time...

blk_execute_rq already defeats hung task detection for stalled IO.

My point, though, was passthru doesn't care about scan_work. A submitted
passthru command is blocked for reset, so blocking scan_work doesn't
make that situation any better or worse.
 
> > I think the main point is that we don't want to take a delete action on
> > a transient condition, but sprinkling NVME_CTRL_LIVE checks is open to
> > many other races.
> 
> Hence I suggested the transport error code...

That should work too.
