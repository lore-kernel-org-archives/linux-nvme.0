From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 29 May 2018 12:33:56 -0500
Subject: Question on inline support
Message-ID: <5276f947-0ccf-5d0e-53bc-724f65c1c837@opengridcomputing.com>

Hey guys,

While testing the nvme rdma target with inline_data_size=0 for my patch
series [1], I found that the nvme host side rejected the queue
connections with this error:

"nvme nvme0: Mandatory keyed sgls are not support"

Due to this code in nvme/host/rdma.c:

?????? /* sanity check keyed sgls */
?????? if (!(ctrl->ctrl.sgls & (1 << 20))) {
?????????????? dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not
support\n");
?????????????? ret = -EINVAL;
?????????????? goto out_remove_admin_queue;
?????? }

Because the target side only sets bit 20 if inline_data_size is > 0, in
nvme/target/admin_cmd.c:

??????? if (ctrl->ops->sqe_inline_size)
??????????????? id->sgls |= cpu_to_le32(1 << 20);


I think the host-side code can be removed, yes?? I don't see why it
shouldn't be supported.? In fact, I removed it and things appear to work
just fine when I disable inline on the target.

Thanks,

Steve.

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-May/017554.html
