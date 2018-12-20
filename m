From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Dec 2018 13:58:17 -0800
Subject: [PATCH] nvme-rdma: fix timeout handler
In-Reply-To: <b29d0862-7743-97c3-89b0-6a2aecb346d4@broadcom.com>
References: <20181213212917.8900-1-sagi@grimberg.me>
 <20181216163217.GA12814@lst.de>
 <a9c82a82-6841-3e3d-54b1-659c72a062fd@grimberg.me>
 <7b1f148f-a881-2483-1b04-3b2ff5b11449@broadcom.com>
 <20181218170738.GA13748@lst.de>
 <b29d0862-7743-97c3-89b0-6a2aecb346d4@broadcom.com>
Message-ID: <2c5c19c1-fa18-2af3-46af-c0230f59c030@grimberg.me>


>> That was my impression as well.? Or in fact just allow a transition
>> from connecting to reset (or a special connect terminate state that
>> is very similar except for not recovering)
> 
> :)? I had proposed that originally, but it was rejected.? I still think 
> that state transition is valid, but the pci guys disagreed.
> 
> I don't think it needs a new state.?? I think a transport callback that 
> can be called from the common layers is sufficient.? rdma already has it 
> in nvme_rdma_teardown_io_queues() and nvme_rdma_teardown_admin_queue(). 
> And fc has it in __nvme_fc_terminate_io().

I'm not entirely clear where this callout would be invoked from? Note
that pci shares this common flow.
