From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 8 Sep 2016 16:00:41 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <7f09e373-6316-26a3-ae81-dab1205d88ab@grimberg.me>
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
 <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>
 <7f09e373-6316-26a3-ae81-dab1205d88ab@grimbe rg.me>
Message-ID: <021101d20a14$0f19f9f0$2d4dedd0$@opengridcomputing.com>

> 
> >> Can you also give patch [1] a try? It's not a solution, but I want
> >> to see if it hides the problem...
> >>
> >
> > hmm.  I ran the experiment once with [1] and it didn't crash.  I ran it a
2nd
> > time and hit a new crash.  Maybe a problem with [1]?
> 
> Strange, I don't see how we can visit rdma_destroy_qp twice given
> that we have NVME_RDMA_IB_QUEUE_ALLOCATED bit protecting it.
> 
> Not sure if it fixes anything, but we probably need it regardless, can
> you give another go with this on top:

Still hit it with this on top (had to tweak the patch a little).

Steve.
