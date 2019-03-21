From: stefanha@redhat.com (Stefan Hajnoczi)
Date: Thu, 21 Mar 2019 16:12:39 +0000
Subject: No subject
In-Reply-To: <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
Message-ID: <20190321161239.GH31434@stefanha-x1.localdomain>

On Wed, Mar 20, 2019@09:08:37PM +0200, Maxim Levitsky wrote:
> On Wed, 2019-03-20@11:03 +0000, Felipe Franciosi wrote:
> > > On Mar 19, 2019,@2:41 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > 
> > > Date: Tue, 19 Mar 2019 14:45:45 +0200
> > > Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
> > > 
> > > Hi everyone!
> > > 
> > > In this patch series, I would like to introduce my take on the problem of
> > > doing 
> > > as fast as possible virtualization of storage with emphasis on low latency.
> > > 
> > > In this patch series I implemented a kernel vfio based, mediated device
> > > that 
> > > allows the user to pass through a partition and/or whole namespace to a
> > > guest.
> > 
> > Hey Maxim!
> > 
> > I'm really excited to see this series, as it aligns to some extent with what
> > we discussed in last year's KVM Forum VFIO BoF.
> > 
> > There's no arguing that we need a better story to efficiently virtualise NVMe
> > devices. So far, for Qemu-based VMs, Changpeng's vhost-user-nvme is the best
> > attempt at that. However, I seem to recall there was some pushback from qemu-
> > devel in the sense that they would rather see investment in virtio-blk. I'm
> > not sure what's the latest on that work and what are the next steps.
> I agree with that. All my benchmarks were agains his vhost-user-nvme driver, and
> I am able to get pretty much the same througput and latency.
> 
> The ssd I tested on died just recently (Murphy law), not due to bug in my driver
> but some internal fault (even though most of my tests were reads, plus
> occassional 'nvme format's.
> We are in process of buying an replacement.
> 
> > 
> > The pushback drove the discussion towards pursuing an mdev approach, which is
> > why I'm excited to see your patches.
> > 
> > What I'm thinking is that passing through namespaces or partitions is very
> > restrictive. It leaves no room to implement more elaborate virtualisation
> > stacks like replicating data across multiple devices (local or remote),
> > storage migration, software-managed thin provisioning, encryption,
> > deduplication, compression, etc. In summary, anything that requires software
> > intervention in the datapath. (Worth noting: vhost-user-nvme allows all of
> > that to be easily done in SPDK's bdev layer.)
> 
> Hi Felipe!
> 
> I guess that my driver is not geared toward more complicated use cases like you
> mentioned, but instead it is focused to get as fast as possible performance for
> the common case.
> 
> One thing that I can do which would solve several of the above problems is to
> accept an map betwent virtual and real logical blocks, pretty much in exactly
> the same way as EPT does it.
> Then userspace can map any portions of the device anywhere, while still keeping
> the dataplane in the kernel, and having minimal overhead.
> 
> On top of that, note that the direction of IO virtualization is to do dataplane
> in hardware, which will probably give you even worse partition granuality /
> features but will be the fastest option aviable,
> like for instance SR-IOV which alrady exists and just allows to split by
> namespaces without any more fine grained control.
> 
> Think of nvme-mdev as a very low level driver, which currntly uses polling, but
> eventually will use PASID based IOMMU to provide the guest with raw PCI device.
> The userspace / qemu can build on top of that with varios software layers.
> 
> On top of that I am thinking to solve the problem of migration in Qemu, by
> creating a 'vfio-nvme' driver which would bind vfio to bind to device exposed by
> the kernel, and would pass through all the doorbells and queues to the guest,
> while intercepting the admin queue. Such driver I think can be made to support
> migration while beeing able to run on top both SR-IOV device, my vfio-nvme abit
> with double admin queue emulation (its a bit ugly but won't affect performance
> at all) and on top of even regular NVME device vfio assigned to guest.

mdev-nvme seems like a duplication of SPDK.  The performance is not
better and the features are more limited, so why focus on this approach?

One argument might be that the kernel NVMe subsystem wants to offer this
functionality and loading the kernel module is more convenient than
managing SPDK to some users.

Thoughts?

Stefan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190321/8b770a99/attachment.sig>
