From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu, 21 Mar 2019 19:07:38 +0200
Subject: your mail
In-Reply-To: <20190321161352.GA21682@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190321161352.GA21682@stefanha-x1.localdomain>
Message-ID: <a4dc67e66cd126892468011311ff516853754cdb.camel@redhat.com>

On Thu, 2019-03-21@16:13 +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2019@04:41:07PM +0200, Maxim Levitsky wrote:
> > Date: Tue, 19 Mar 2019 14:45:45 +0200
> > Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
> > 
> > Hi everyone!
> > 
> > In this patch series, I would like to introduce my take on the problem of
> > doing 
> > as fast as possible virtualization of storage with emphasis on low latency.
> > 
> > In this patch series I implemented a kernel vfio based, mediated device
> > that 
> > allows the user to pass through a partition and/or whole namespace to a
> > guest.
> > 
> > The idea behind this driver is based on paper you can find at
> > https://www.usenix.org/conference/atc18/presentation/peng,
> > 
> > Although note that I stared the development prior to reading this paper, 
> > independently.
> > 
> > In addition to that implementation is not based on code used in the paper
> > as 
> > I wasn't being able at that time to make the source available to me.
> > 
> > ***Key points about the implementation:***
> > 
> > * Polling kernel thread is used. The polling is stopped after a 
> > predefined timeout (1/2 sec by default).
> > Support for all interrupt driven mode is planned, and it shows promising
> > results.
> > 
> > * Guest sees a standard NVME device - this allows to run guest with 
> > unmodified drivers, for example windows guests.
> > 
> > * The NVMe device is shared between host and guest.
> > That means that even a single namespace can be split between host 
> > and guest based on different partitions.
> > 
> > * Simple configuration
> > 
> > *** Performance ***
> > 
> > Performance was tested on Intel DC P3700, With Xeon E5-2620 v2 
> > and both latency and throughput is very similar to SPDK.
> > 
> > Soon I will test this on a better server and nvme device and provide
> > more formal performance numbers.
> > 
> > Latency numbers:
> > ~80ms - spdk with fio plugin on the host.
> > ~84ms - nvme driver on the host
> > ~87ms - mdev-nvme + nvme driver in the guest
> 
> You mentioned the spdk numbers are with vhost-user-nvme.  Have you
> measured SPDK's vhost-user-blk?

I had lot of measuments of vhost-user-blk vs vhost-user-nvme.
vhost-user-nvme was always a bit faster but only a bit.
Thus I don't think it makes sense to benchamrk against vhost-user-blk.

Best regards,
	Maxim Levitsky
