From: kbusch@kernel.org (Keith Busch)
Date: Wed, 31 Jul 2019 15:54:37 -0600
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate
 failed because of controller reset
In-Reply-To: <68358e82-cbd5-6199-1329-89421c778dc0@grimberg.me>
References: <2825eb74-1df5-5dd2-3e90-c696bc7fa3d1@grimberg.me>
 <20190730173048.GC13948@localhost.localdomain>
 <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
 <2f7535ab-3d45-b24d-1512-a937e16e620f@grimberg.me>
 <20190731193257.GB15643@localhost.localdomain>
 <0720636c-8706-e927-3c0b-c2687694664f@grimberg.me>
 <20190731201634.GC15643@localhost.localdomain>
 <cb8a1faf-ea19-06c8-35dc-08cd11180974@grimberg.me>
 <20190731205836.GD15643@localhost.localdomain>
 <68358e82-cbd5-6199-1329-89421c778dc0@grimberg.me>
Message-ID: <20190731215437.GA15795@localhost.localdomain>

On Wed, Jul 31, 2019@02:14:25PM -0700, Sagi Grimberg wrote:
> 
> > > > The other way it may fail to revalidate is if its identify has changed
> > > > since we last discovered it, so removal is better than data corruption.
> > > 
> > > Well, perhaps we can mark failures resulting from reset with a transport
> > > error.
> > > 
> > > For example, nvme_cancel_request is setting:NVME_SC_ABORT_REQ, perhaps
> > > we can modify nvme_error_status to set that into BLK_STS_TRANSPORT and
> > > check for that as the return code for revalidate_disk?
> > > 
> > > Thoughts?
> > 
> > Would it be sufficient to let these admin commands requeue? Instead of
> > flushing the scan work, we can let it block for IO on a reset, and the
> > IO will resume when the reset completes.
> 
> Well, I don't think we should do that. Unlike I/O commands, which can
> failover to a different path, these admin commands are bound to the
> specific controller. In case it takes minutes/hours/days for the
> controller to restore normal operation, it will be unpleasant to say
> the least to have admin operations get stuck for so long.

Unpleasant for who? The scan_work is the only thing waiting for these
commands, no one else should care because you can't run IO if you're
stuck in very long reset anyway.

I think the main point is that we don't want to take a delete action on
a transient condition, but sprinkling NVME_CTRL_LIVE checks is open to
many other races.
