From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 8 Sep 2016 15:44:00 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <01f401d20a06$d4cc8360$7e658a20$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com> <0c159abb
 -24ee-21bf-09d2-9fe7d2 69a2eb@grimberg.me>
 <039601d2094f$80481640$80d842c0$@opengridcomputing.com>
 <9fd1f090-3b86-b496-d8c0-225ac0815fbe@grimbe rg.me> <01bc01d209f5$1
 b7d7510$52785f30$@opengridcomputing.com>
 <01f201d20a05$6abde5f0$4039b1d0$@opengridcomputing.com>
 <01f401d20a06$d4cc8360$7e658a20$@opengridcomputing.com>
Message-ID: <020d01d20a11$ba20cfc0$2e626f40$@opengridcomputing.com>

> > While working this with debug code to verify that we never create a qp,
> > cq, or cm_id where one already exists for an nvme_rdma_queue, I
> discovered
> > a bug where the Q_DELETING flag is never cleared, and thus a reconnect
> can
> > leak qps and cm_ids.  The fix, I think, is this:
> >
> > @@ -563,6 +572,7 @@ static int nvme_rdma_init_queue(struct
> nvme_rdma_ctrl
> > *ctrl,
> >         int ret;
> >
> >         queue = &ctrl->queues[idx];
> > +       queue->flags = 0;
> >         queue->ctrl = ctrl;
> >         init_completion(&queue->cm_done);
> >
> > I think maybe the clearing of the Q_DELETING flag was lost when we moved
> > to using the ib_client for device removal.   I'll polish this up and
> > submit a patch. It should go with the next 4.8-rc push I think.
> 
> Actually, I think the Q_DELETING flag is no longer needed.  Sagi, can you
> have look at NVME_RDMA_Q_DELETING in the latest code?  I think the
> ib_client patch made the original Q_DELETING patch obsolete.  And the
> original Q_DELETING patch probably needed the above chunk for
> correctness...
> 
> Let me know if you want me to submit something for this issue.  We could
> fix the original patches as they are still only in your nvmf-4.8-rc
> repo...

I see your debug patch v2 you sent me in an earlier email has a clear_bit() to
address the DELETING issue.  I haven't tried that patch yet. :)  Its next on my
list...

steve
