From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Tue, 14 Mar 2017 19:57:05 +0000
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
Message-ID: <DE927C68B458BE418D582EC97927A9285466CCB6@ORSMSX112.amr.corp.intel.com>


> >> On the initiator we see events like this:
> >>
> >> [51390.065641] mlx5_0:dump_cqe:262:(pid 0): dump error cqe
> >> [51390.065644] 00000000 00000000 00000000 00000000 [51390.065645]
> >> 00000000 00000000 00000000 00000000 [51390.065646] 00000000
> 00000000
> >> 00000000 00000000 [51390.065648] 00000000 08007806 250003ab
> 02b9dcd2
> >> [51390.065666] nvme nvme3: MEMREG for CQE 0xffff9fc845039410 failed
> >> with status memory management operation error (6) [51390.079156] nvme
> >> nvme3: reconnecting in 10 seconds [51400.432782] nvme nvme3:
> >> Successfully reconnected
> >
> > Seems to me this is a CX4 FW issue. Mellanox can elaborate on these
> > vendor specific syndromes on this output.
> >
> >> On the target we see events like this:
> >>
> >> [51370.394694] mlx5_0:dump_cqe:262:(pid 6623): dump error cqe
> >> [51370.394696] 00000000 00000000 00000000 00000000 [51370.394697]
> >> 00000000 00000000 00000000 00000000 [51370.394699] 00000000
> 00000000
> >> 00000000 00000000 [51370.394701] 00000000 00008813 080003ea
> 00c3b1d2
> >
> > If the host is failing on memory mapping while the target is
> > initiating rdma access it makes sense that it will see errors.
> >
> > You can try out this patch to see if it makes the memreg issues to go
> > away:
> > --
> > diff --git a/drivers/infiniband/hw/mlx5/qp.c
> > b/drivers/infiniband/hw/mlx5/qp.c index ad8a2638e339..0f9a12570262
> > 100644
> > --- a/drivers/infiniband/hw/mlx5/qp.c
> > +++ b/drivers/infiniband/hw/mlx5/qp.c
> > @@ -3893,7 +3893,7 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, struct
> > ib_send_wr *wr,
> >                                 goto out;
> >
> >                         case IB_WR_LOCAL_INV:
> > -                               next_fence =
> > MLX5_FENCE_MODE_INITIATOR_SMALL;
> > +                               next_fence =
> > MLX5_FENCE_MODE_STRONG_ORDERING;
> >                                 qp->sq.wr_data[idx] = IB_WR_LOCAL_INV;
> >                                 ctrl->imm =
> > cpu_to_be32(wr->ex.invalidate_rkey);
> >                                 set_linv_wr(qp, &seg, &size); @@
> > -3901,7 +3901,7 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, struct
> > ib_send_wr *wr,
> >                                 break;
> >
> >                         case IB_WR_REG_MR:
> > -                               next_fence =
> > MLX5_FENCE_MODE_INITIATOR_SMALL;
> > +                               next_fence =
> > MLX5_FENCE_MODE_STRONG_ORDERING;
> >                                 qp->sq.wr_data[idx] = IB_WR_REG_MR;
> >                                 ctrl->imm = cpu_to_be32(reg_wr(wr)->key);
> >                                 err = set_reg_wr(qp, reg_wr(wr), &seg,
> > &size);
> > --
> >
> > Note that this will have a big performance (negative) impact on small
> > read workloads.
> >
> 
> Hi Sagi,
> 
> I think we need to add fence to the UMR wqe.
> 
> so lets try this one:
> 
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index ad8a263..c38c4fa 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -3737,8 +3737,7 @@ static void dump_wqe(struct mlx5_ib_qp *qp, int idx,
> int size_16)
> 
>   static u8 get_fence(u8 fence, struct ib_send_wr *wr)
>   {
> -       if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
> -                    wr->send_flags & IB_SEND_FENCE))
> +       if (wr->opcode == IB_WR_LOCAL_INV || wr->opcode == IB_WR_REG_MR)
>                  return MLX5_FENCE_MODE_STRONG_ORDERING;
> 
>          if (unlikely(fence)) {
> 
> 
> please update after trying the 2 patches (seperatly) + perf numbers.
> 
> These patches are only for testing and not for submission yet. If we find them
> good enought for upstream then we need to distinguish between ConnexcX4/IB
> and ConnectX5 (we probably won't see it there).

Sorry for the slow response here, we had to churn through some other testing on our test bed before we could try out these patches.  We tested the patches with a single target system and a single initiator system connected via CX4s at 25Gb through an Arista 7060X switch with regular Ethernet flow control enabled (no PFC/DCB - but the switch has no other traffic on it).  We connected 8 Intel P3520 1.2 TB SSDs from the target to the initiator with 16 IO queues per disk.  Then we ran FIO with a 4KB workload, random IO pattern, 4 jobs per disk, queue depth 32 per job, testing 100% read, 70/30 read/write, and 100% write workloads.  We used the default 4.10-RC8 kernel, then patched the same kernel with Sagi's patch, and then separately with Max's patch, and then both patches at the same time (just for fun).  The patches were applied on both target and initiator.  In general we do see to see a performance hit on small block read workloads but it is not massive, looks like about 10%.  We also tested some large block transfers and didn't see any impact.  Results here are in 4KB IOPS:

Read/Write	4.10-RC8	Patch 1 (Sagi)	Patch 2 (Max)	Both Patches
100/0		667,158		611,737		619,586		607,080
70/30		941,352		890,962		884,222		876,926
0/100		667,379		666,000		666,093		666,144

The next step for us is to retest at 50Gb - please note the failure we originally described has only been seen when running 50Gb, and has not been observed at 25Gb, so we don't yet have a conclusion on whether the patch fixes the original issue.  We should have those results later this week if all goes well.  

Let me know if you need more details on the results so far or the test configuration.

It is also worth noting the max throughput above is being limited by the 25Gb link.  When we test at 50Gb should we include some tests with fewer drives that would be disk IO bound instead of network bound, or is network bound the more interesting test case for these patches?
