From: felipe@nutanix.com (Felipe Franciosi)
Date: Wed, 20 Mar 2019 11:03:29 +0000
Subject: No subject
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>


> On Mar 19, 2019,@2:41 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> 
> Date: Tue, 19 Mar 2019 14:45:45 +0200
> Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
> 
> Hi everyone!
> 
> In this patch series, I would like to introduce my take on the problem of doing 
> as fast as possible virtualization of storage with emphasis on low latency.
> 
> In this patch series I implemented a kernel vfio based, mediated device that 
> allows the user to pass through a partition and/or whole namespace to a guest.

Hey Maxim!

I'm really excited to see this series, as it aligns to some extent with what we discussed in last year's KVM Forum VFIO BoF.

There's no arguing that we need a better story to efficiently virtualise NVMe devices. So far, for Qemu-based VMs, Changpeng's vhost-user-nvme is the best attempt at that. However, I seem to recall there was some pushback from qemu-devel in the sense that they would rather see investment in virtio-blk. I'm not sure what's the latest on that work and what are the next steps.

The pushback drove the discussion towards pursuing an mdev approach, which is why I'm excited to see your patches.

What I'm thinking is that passing through namespaces or partitions is very restrictive. It leaves no room to implement more elaborate virtualisation stacks like replicating data across multiple devices (local or remote), storage migration, software-managed thin provisioning, encryption, deduplication, compression, etc. In summary, anything that requires software intervention in the datapath. (Worth noting: vhost-user-nvme allows all of that to be easily done in SPDK's bdev layer.)

These complicated stacks should probably not be implemented in the kernel, though. So I'm wondering whether we could talk about mechanisms to allow efficient and performant userspace datapath intervention  in your approach or pursue a mechanism to completely offload the device emulation to userspace (and align with what SPDK has to offer).

Thoughts welcome!
Felipe
