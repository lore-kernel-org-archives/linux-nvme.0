From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 9 May 2017 16:30:02 +0800
Subject: [PATCH] nvme: remove disk after hw queue is started
In-Reply-To: <CAOSXXT5KzFN4m8DpqsssvEBPfkj=v=t8aq528wt2tFU_+LUmDQ@mail.gmail.com>
References: <CAOSXXT6nGggnZj6e0Mo4eBwq63HfWRrVe3ddVA-YORvPJd9Raw@mail.gmail.com>
 <CAOSXXT5KzFN4m8DpqsssvEBPfkj=v=t8aq528wt2tFU_+LUmDQ@mail.gmail.com>
Message-ID: <20170509082957.GA16165@ming.t460p>

On Mon, May 08, 2017@11:58:44PM -0600, Keith Busch wrote:
> [ Trying again with plain-text mode... ]
> 
> Sorry for replying with a new thread from a different email that isn't
> subscribed to the list, but my work computer isn't available at the moment
> and I am interested in hearing your thoughts on this one sooner.

No a problem at all, :-)

> 
> >> On Mon, May 08, 2017@01:25:12PM -0400, Keith Busch wrote:
> >> > > On Tue, May 09, 2017@12:15:25AM +0800, Ming Lei wrote:
> >> > > This patch looks working, but seems any 'goto out' in this function
> >> > > may have rick to cause the same race too.
> >>
> >> > The goto was really intended for handling totally broken contronllers,
> >> > which isn't the case if someone requested to remove the pci device while
> >> > we're initializing it. Point taken, though, let me run a few tests and
> >> > see if there's a better way to handle this condition.
> >>
> >> The thing is that remove can happen any time, either from hotplug or
> >> unbinding driver or 'echo 1 > $PCI_PATH/remove'. At the same time,
> >> the reset can be ongoing.
> 
> Yes, it's true you can run "echo 1 > ..." at any time to the sysfs remove
> file. You can also run "sudo umount /" or on any other in-use mounted
> partition, but that doesn't succeed. Why should "echo 1" take precedence
> over tasks writing to the device?
> 
> Compared to umount, it is more problematic to remove the pci device through
> sysfs since that holds the pci rescan remove lock, so we do need to make
> forward progress, but I really think we ought to let the dirty data sync
> before that completes. Killing the queues makes that impossible, so I think
> not considering this to be a "dead" controller is in the right direction.

OK.

I agree on this point now if I/O still can be submitted to the controller
successfully under this situation, and we still need to consider how to
handle if the controller can't complete these I/O.

> 
> But obviously the user is doing something _wrong_ if they're actively
> writing to the device they're respectfully asking Linux remove from the
> topology, right? If you _really_ want to remove it without caring about your
> data, just yank it out, and we'll handle that by destroying your in flight
> data with a synthesized failure status. But if the device you want to remove
> is still perfectly accessible, we ought to get the user data committed to
> storage, right?

Actually we don't mount a filesystem over NVMe in this test, and just
do I/O to /dev/nvme0n1p1 directly. Then in reality it is stil possible
to see reset & remove coming during heavy I/O load.

IMO we can't let these actions hang the system even though they are
insane, and we try best to not lose data, but if data lost happend,
that is still user's responsility.


Thanks,
Ming
