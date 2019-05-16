From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Wed, 15 May 2019 19:23:53 -0600
Subject: Issue with namespace delete
Message-ID: <f215cfd2-c0ce-34ff-bc8b-4a577a73372e@intel.com>

I have been doing some namespace testing with Ubuntu 18.04 (kernel 
4.15.0-43-generic). I'm running into an issue with namespace deletes 
where the driver seems to hang.

[  363.484013]  synchronize_srcu+0x57/0xdc
[  363.484016]  nvme_ns_remove+0xcc/0x180 [nvme_core]
[  363.484018]  nvme_remove_invalid_namespaces+0xb1/0xe0 [nvme_core]
[  363.484020]  nvme_user_cmd+0x282/0x370 [nvme_core]
[  363.484022]  nvme_ioctl+0xd0/0x1d0 [nvme_core]
[  363.484024]  blkdev_ioctl+0x3b8/0x980
[  363.484025]  block_ioctl+0x3d/0x50
[  363.484027]  do_vfs_ioctl+0xa8/0x620
[  363.484028]  ? ptrace_notify+0x5b/0x90
[  363.484030]  ? syscall_trace_enter+0x7b/0x2c0
[  363.484031]  SyS_ioctl+0x7a/0x90
[  363.484032]  do_syscall_64+0x73/0x130
[  363.484033]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

I don't understand RCUs very well but I found the following in the 
documentation

"Note that it is illegal to call synchronize_srcu from the corresponding 
SRCU read-side critical section; doing so will result in deadlock."

I noticed in the driver that when multi-path is enabled, the context for 
ioctl calls would be in a read-side critical section 
(nvme_get_ns_from_disk) and I believe that the synchronize_srcu() call 
is made in the same context.

If I disable NVME_MULTIPATH, I don't see any issues when I try to delete 
a namespace.

I re-enabled multi-path and enabled DEBUG_LOCK_ALLOC. I used the 
following patch to check if the lock is held and then only call 
synchronize if the lock is not held.
[I am not sure I trust this because lock_held returns true by default]

@@ -3006,7 +3008,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
         list_del_init(&ns->list);
         up_write(&ns->ctrl->namespaces_rwsem);

-       synchronize_srcu(&ns->head->srcu);
+       WARN_ON(srcu_read_lock_held(&ns->head->srcu));
+
+       if (!srcu_read_lock_held(&ns->head->srcu))
+               synchronize_srcu(&ns->head->srcu);

I do get the warning and the namespace delete is successful.

[  136.316398] WARNING: CPU: 1 PID: 2201 at 
drivers/nvme/host/core.c:3013 nvme_ns_remove+0xf8/0x250 [nvme_core]
[  136.316489] Call Trace:
[  136.316494]  nvme_remove_invalid_namespaces+0xce/0x100 [nvme_core]
[  136.316498]  nvme_user_cmd+0x292/0x3a0 [nvme_core]
[  136.316507]  nvme_ioctl+0x123/0x220 [nvme_core]


Is there a possible issue here or am I off in the weeds?

Btw, I also see this issue with the 4.18 and 4.20 kernels

Thanks!
