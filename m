From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Fri, 22 Mar 2019 12:32:02 +0200
Subject: No subject
In-Reply-To: <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
 <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
 <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
 <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
Message-ID: <99a767f4b71510882a11b6369bef1070ec200de6.camel@redhat.com>

On Fri, 2019-03-22@07:54 +0000, Felipe Franciosi wrote:
> > On Mar 21, 2019,@5:04 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > 
> > On Thu, 2019-03-21@16:41 +0000, Felipe Franciosi wrote:
> > > > On Mar 21, 2019,@4:21 PM, Keith Busch <kbusch@kernel.org> wrote:
> > > > 
> > > > On Thu, Mar 21, 2019@04:12:39PM +0000, Stefan Hajnoczi wrote:
> > > > > mdev-nvme seems like a duplication of SPDK.  The performance is not
> > > > > better and the features are more limited, so why focus on this
> > > > > approach?
> > > > > 
> > > > > One argument might be that the kernel NVMe subsystem wants to offer
> > > > > this
> > > > > functionality and loading the kernel module is more convenient than
> > > > > managing SPDK to some users.
> > > > > 
> > > > > Thoughts?
> > > > 
> > > > Doesn't SPDK bind a controller to a single process? mdev binds to
> > > > namespaces (or their partitions), so you could have many mdev's assigned
> > > > to many VMs accessing a single controller.
> > > 
> > > Yes, it binds to a single process which can drive the datapath of multiple
> > > virtual controllers for multiple VMs (similar to what you described for
> > > mdev).
> > > You can therefore efficiently poll multiple VM submission queues (and
> > > multiple
> > > device completion queues) from a single physical CPU.
> > > 
> > > The same could be done in the kernel, but the code gets complicated as you
> > > add
> > > more functionality to it. As this is a direct interface with an untrusted
> > > front-end (the guest), it's also arguably safer to do in userspace.
> > > 
> > > Worth noting: you can eventually have a single physical core polling all
> > > sorts
> > > of virtual devices (eg. virtual storage or network controllers) very
> > > efficiently. And this is quite configurable, too. In the interest of
> > > fairness,
> > > performance or efficiency, you can choose to dynamically add or remove
> > > queues
> > > to the poll thread or spawn more threads and redistribute the work.
> > > 
> > > F.
> > 
> > Note though that SPDK doesn't support sharing the device between host and
> > the
> > guests, it takes over the nvme device, thus it makes the kernel nvme driver
> > unbind from it.
> 
> That is absolutely true. However, I find it not to be a problem in practice.
> 
> Hypervisor products, specially those caring about performance, efficiency and
> fairness, will dedicate NVMe devices for a particular purpose (eg. vDisk
> storage, cache, metadata) and will not share these devices for other use
> cases. That's because these products want to deterministically control the
> performance aspects of the device, which you just cannot do if you are sharing
> the device with a subsystem you do not control.
> 
> For scenarios where the device must be shared and such fine grained control is
> not required, it looks like using the kernel driver with io_uring offers very
> good performance with flexibility


I see the host/guest parition in the following way:
The guest assigned partitions are for guests that need lowest possible latency,
and in between these guests it is possible to guarantee good enough level of
fairness in my driver.
For example, in the current implementation of my driver, each guest gets its own
host submission queue.

On the other hand, the host assigned partitions are for significantly higher
latency IO, with no guarantees, and/or for guests that need all the more
advanced features of full IO virtualization, for instance snapshots, thin
provisioning, replication/backup over network, etc.
io_uring can be used here to speed things up but it won't reach the nvme-mdev
levels of latency.

Furthermore on NVME drives that support WRRU, its possible to let queues of
guest's assigned partitions to belong to the high priority class and let the
host queues use the regular medium/low priority class.
For drives that don't support WRRU, the IO throttling can be done in software on
the host queues.

Host assigned partitions also don't need polling, thus allowing polling to be
used only for guests that actually need low latency IO.
This reduces the number of cores that would be otherwise lost to polling,
because the less work the polling core does, the less latency it contributes to
overall latency, thus with less users, you could use less cores to achieve the
same levels of latency.

For Stefan's argument, we can look at it in a slightly different way too:
While the nvme-mdev can be seen as a duplication of SPDK, the SPDK can also be
seen as duplication of an existing kernel functionality which nvme-mdev can
reuse for free.

Best regards,
	Maxim Levitsky
