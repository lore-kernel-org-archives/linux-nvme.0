From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 3 Jun 2018 14:30:53 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <20621565-ac87-9af2-364e-d6f84dbbadcf@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
 <f45105cf-48e7-62d8-ca3a-56f9ce248640@grimberg.me>
 <20621565-ac87-9af2-364e-d6f84dbbadcf@mellanox.com>
Message-ID: <af64b181-d673-0399-811a-4f60154b93ee@grimberg.me>


> Sagi,
> 
> our architecture team have presented MR features and improvments during 
> OFA 2018, and there are some similar ideas to your idea below. We need 
> to thing and plan how to progress here.

I have not attended the OFA workshop.

> Your suggestion looks reasonable 
> but in my opinion it should be divided to 2 phases (otherwise it will be 
> hard to push it in the near future):
> 1. use 1 MR to map data + metadata
> 2. use 1 MR to describe data, metadata and signature params.

Actually I think that given that we have only a single user and a single
provider we are in an ideal position to avoid the hassle of phasing this
cleanup. I think the proposed change for adding PI support is more
intrusive than it should be due to the API we came up with at the time
(mostly my fault probably).

> Oren,
> Can you share the vision for the MR layout and how it can fit to the T10 
> solution for ULPs ? Also pros/cons about the internal MR/s implemetation ?

Without knowing the end-goal in mind, I'd suggest to make the API
very specific to PI and have all the generic stuff inside the provider
driver. Looking back, I think it was a mistake to try and reflect a
generic interface for adding block metadata for consumers that only use
PI (and will probably never do anything else).

What I'd think we should aim for as an interface is something like:

1. mr = ib_alloc_mr(pd, IB_MR_TYPE_PI, max_data_sg, max_meta_sg)

2. count = ib_mr_map_sg_pi(mr, data_sg, data_sg_cnt, data_sg_offset,
                             meta_sg, meta_sg_cnt, meta_sg_offset,
                             page_size)

3. ret = ib_mr_setup_pi(struct ib_mr *mr, struct blk_integrity *bi)
    *although this might not be able to converge scsi and nvme in one
     shot so we might have each ulp do its own thing here..

4. ret = ib_post_send(qp, pi_wr)
    where ib_pi_wr looks exactly like ib_reg_wr but has the opcode
    dissection for the provider to do all internal stuff.

5. ret = ib_check_pi_status(mr)

Try to hide all the multiple mr madness...
