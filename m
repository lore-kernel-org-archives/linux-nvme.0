From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Wed, 12 Apr 2017 16:41:54 +0000
Subject: cqe dump errors on target while running nvme-of large block read IO
Message-ID: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>

Hi folks-

Wanted to put this issue out there and see if anyone had thoughts.

Target system - 100Gb dual port CX5, FW 16.19.1000, through Arista 7060X switch with Ethernet flow control
Initiator system - 25Gb dual port CX4, FW 14.18.2000, through Arista 7060X switch with Ethernet flow control

We attach 16 drives from target to initiator, but are only running IO on four of them in this test, two drives per network port on initiator/target.  Drives in use are Intel P3700 400GB.

We are running Ubuntu 16.10 with the 4.11-rc6 kernel and this patch from Max:

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c index ad8a263..c38c4fa 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3737,8 +3737,7 @@ static void dump_wqe(struct mlx5_ib_qp *qp, int idx, int size_16)

  static u8 get_fence(u8 fence, struct ib_send_wr *wr)
  {
-       if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
-                    wr->send_flags & IB_SEND_FENCE))
+       if (wr->opcode == IB_WR_LOCAL_INV || wr->opcode == IB_WR_REG_MR)
                 return MLX5_FENCE_MODE_STRONG_ORDERING;

         if (unlikely(fence)) {

For the most part we can run FIO IO on the initiator against the attached subsystems without problems.  4KB random read and write, 64KB sequential writes are working OK on this setup.  We seem to encounter errors when we run a 64KB sequential read workload.  I would not the 64KB sequential read workload is the only one which generates enough traffic that we could bottleneck on the initiator NIC throughput - not sure if that is relevant, or just a coincidence.  We can reproduce these errors fairly reliably at this time.  See attached dmesg and example below:

[12728.885267] mlx5_1:dump_cqe:262:(pid 2943): dump error cqe
[12728.885271] 00000000 00000000 00000000 00000000
[12728.885272] 00000000 00000000 00000000 00000000
[12728.885274] 00000000 00000000 00000000 00000000
[12728.885275] 00000000 00008813 08000240 0255bcd3
[12728.885852] mlx5_1:dump_cqe:262:(pid 2829): dump error cqe
[12728.885855] 00000000 00000000 00000000 00000000
[12728.885857] 00000000 00000000 00000000 00000000
[12728.885859] 00000000 00000000 00000000 00000000
[12728.885861] 00000000 00008813 08000239 c2e59fd3
[12735.782466] nvmet: ctrl 17 keep-alive timer (15 seconds) expired!
[12735.784949] nvmet: ctrl 17 fatal error occurred!

These target side error prints seem correlated with IO failures and disconnect/reconnect events on the initiator so they are a problem.  Any ideas?  Any additional info we can provide?

Thanks,
Joe
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: initiator-dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170412/5dcfdcd1/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: target-dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170412/5dcfdcd1/attachment-0003.txt>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: joe16b.json
Type: application/octet-stream
Size: 6393 bytes
Desc: joe16b.json
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170412/5dcfdcd1/attachment-0001.obj>
