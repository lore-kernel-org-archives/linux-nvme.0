From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 18:01:47 +0300
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>
 <1cc73f8d-3e9d-0f9f-2b71-60d2bc6ce7b5@mellanox.com>
Message-ID: <81fe8f2a-1fba-730e-a4af-047a4e06bd1a@grimberg.me>


>> Can you please test with my patchset on converting nvme-rdma to
>> MSIX based mapping (I assume you are testing with mlx5 yes)?
> 
> Sure. does V6 is the last version of the patchset ?
> I'll test it with ConnectX-5 adapter and send the results.

Yes.

>> I'd be very much interested to know if the original problem
>> exists with this applied.
> 
> it will exist in case set->nr_hw_queues > dev->num_comp_vectors.

We don't ask for more hw queues than num_comp_vectors.
