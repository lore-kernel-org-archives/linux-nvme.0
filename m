From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 18:26:36 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <cf0ec200-209b-1cfb-0bba-217530805915@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
 <f45105cf-48e7-62d8-ca3a-56f9ce248640@grimberg.me>
 <20621565-ac87-9af2-364e-d6f84dbbadcf@mellanox.com>
 <af64b181-d673-0399-811a-4f60154b93ee@grimberg.me>
 <cf0ec200-209b-1cfb-0bba-217530805915@mellanox.com>
Message-ID: <b7f6b645-02ef-5e1a-28b5-c304647940b5@grimberg.me>


>> 3. ret = ib_mr_setup_pi(struct ib_mr *mr, struct blk_integrity *bi)
>> ??? *although this might not be able to converge scsi and nvme in one
>> ???? shot so we might have each ulp do its own thing here..
> 
> In the first patchset each ULP will fill in the sig_attrs by itself.
> We can add this incrementaly.

OK... I would like to have a lib in place that maps better to
block integrity semantics.

>> 4. ret = ib_post_send(qp, pi_wr)
>> ??? where ib_pi_wr looks exactly like ib_reg_wr but has the opcode
>> ??? dissection for the provider to do all internal stuff.
> 
> did you mean similar to IB_WR_REG_SIG_MR (and not IB_WR_REG_MR) ?
> This IB_WR_REG_PI_MR will need to create internal WR typed IB_WR_REG_MR 
> for the internal mr.

We could even simply use IB_WR_REG_MR, and if the MR has PI set
(previously ib_map_mr_sg_pi was called).

>> 5. ret = ib_check_pi_status(mr)
>>
>> Try to hide all the multiple mr madness...
> 
> I'll create internal mlx5_ib_mr pi_mr for mr typed IB_MR_TYPE_PI.

Cool..
