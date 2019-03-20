From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Wed, 20 Mar 2019 18:48:17 +0200
Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
In-Reply-To: <1553094528.65329.29.camel@acm.org>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <1553094528.65329.29.camel@acm.org>
Message-ID: <e0491452300bca37a716499b6ecd4e9f1c2f8c99.camel@redhat.com>

On Wed, 2019-03-20@08:08 -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19@16:41 +0200, Maxim Levitsky wrote:
> > * Polling kernel thread is used. The polling is stopped after a 
> > predefined timeout (1/2 sec by default).
> > Support for all interrupt driven mode is planned, and it shows promising
> > results.
> 
> Which cgroup will the CPU cycles used for polling be attributed to? Can the
> polling code be moved into user space such that it becomes easy to identify
> which process needs most CPU cycles for polling and such that the polling
> CPU cycles are attributed to the proper cgroup?


Currently there is a single IO thread per each virtual controller instance.
I would prefer to keep all the driver in the kernel, but I think I can make it
cgroup aware, in a simiar way this is done in vhost-net, and vhost-scsi.

Best regards,
	Maxim Levitsky


> Thanks,
> 
> Bart.
