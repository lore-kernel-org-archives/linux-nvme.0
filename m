From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 09:11:30 -0600
Subject: Issue with namespace delete
In-Reply-To: <f215cfd2-c0ce-34ff-bc8b-4a577a73372e@intel.com>
References: <f215cfd2-c0ce-34ff-bc8b-4a577a73372e@intel.com>
Message-ID: <20190516151130.GB23416@localhost.localdomain>

On Wed, May 15, 2019@06:23:53PM -0700, Heitke, Kenneth wrote:
> I have been doing some namespace testing with Ubuntu 18.04 (kernel 
> 4.15.0-43-generic). I'm running into an issue with namespace deletes 
> where the driver seems to hang.
> 
> [  363.484013]  synchronize_srcu+0x57/0xdc
> [  363.484016]  nvme_ns_remove+0xcc/0x180 [nvme_core]
> [  363.484018]  nvme_remove_invalid_namespaces+0xb1/0xe0 [nvme_core]
> [  363.484020]  nvme_user_cmd+0x282/0x370 [nvme_core]
> [  363.484022]  nvme_ioctl+0xd0/0x1d0 [nvme_core]
> [  363.484024]  blkdev_ioctl+0x3b8/0x980
> [  363.484025]  block_ioctl+0x3d/0x50
> [  363.484027]  do_vfs_ioctl+0xa8/0x620
> [  363.484028]  ? ptrace_notify+0x5b/0x90
> [  363.484030]  ? syscall_trace_enter+0x7b/0x2c0
> [  363.484031]  SyS_ioctl+0x7a/0x90
> [  363.484032]  do_syscall_64+0x73/0x130
> [  363.484033]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> I don't understand RCUs very well but I found the following in the 
> documentation
> 
> "Note that it is illegal to call synchronize_srcu from the corresponding 
> SRCU read-side critical section; doing so will result in deadlock."
> 
> I noticed in the driver that when multi-path is enabled, the context for 
> ioctl calls would be in a read-side critical section 
> (nvme_get_ns_from_disk) and I believe that the synchronize_srcu() call 
> is made in the same context.

Yeah, you're right.

You may have avoided this if you send the ioctl through the controller
char dev rather than the namespace block dev handle.

I'm not sure what the best way to fix this might be right now.
