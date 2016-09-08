From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 8 Sep 2016 12:19:07 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <9fd1f090-3b86-b496-d8c0-225ac0815fbe@grimberg.me>
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
 <9fd1f090-3b86-b496-d8c0-225ac0815fbe@grimbe rg.me>
Message-ID: <01bb01d209f5$1b7585d0$52609170$@opengridcomputing.com>

> >> Now, given that you already verified that the queues are stopped with
> >> BLK_MQ_S_STOPPED, I'm looking at blk-mq now.
> >>
> >> I see that blk_mq_run_hw_queue() and __blk_mq_run_hw_queue() indeed take
> >> BLK_MQ_S_STOPPED into account. Theoretically  if we free the queue
> >> pairs after we passed these checks while the rq_list is being processed
> >> then we can end-up with this condition, but given that it takes
> >> essentially forever (10 seconds) I tend to doubt this is the case.
> >>
> >> HCH, Jens, Keith, any useful pointers for us?
> >>
> >> To summarize we see a stray request being queued long after we set
> >> BLK_MQ_S_STOPPED (and by long I mean 10 seconds).
> >
> > Does nvme-rdma need to call blk_mq_queue_reinit() after it reinits the tag
set
> > for that queue as part of reconnecting?
> 
> I don't see how that'd help...
> 

I can't explain this, but the nvme_rdma_queue.flags field has a bit set that
shouldn't be set:

crash> nvme_rdma_queue.flags -x ffff880e52b8e7e8
  flags = 0x14

Bit 2 is set, NVME_RDMA_Q_DELETING, but bit 4 is also set and should never be...

enum nvme_rdma_queue_flags {
        NVME_RDMA_Q_CONNECTED = (1 << 0),
        NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
        NVME_RDMA_Q_DELETING = (1 << 2),
};

The rest of the structure looks fine.  I've also seen crash dumps where bit 3 is
set which is also not used.  

/me confused...
