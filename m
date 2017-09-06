From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Sep 2017 17:57:47 +0300
Subject: [PATCH 2/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <20170906103816.GB24667@lst.de>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-3-git-send-email-maxg@mellanox.com>
 <20170906103816.GB24667@lst.de>
Message-ID: <4efc8d9b-a9d6-0297-9aff-e078bfdaa7f6@grimberg.me>


>>   
>>   	int			idx;
>>   	int			host_qid;
>> +	int			comp_vector;
> 
> How will this interact with these changes:
> 
> http://git.infradead.org/users/hch/rdma.git/shortlog/refs/heads/rdma-cq.2
> 
> which I'd really like to see in?

I have another spin on that one (plus the fine-grained affinity
assignments addition that I proposed to nvmet a while ago).

You can see it here:
git://git.infradead.org/users/sagi/linux.git rdma-cq-pool

Its on top of the pci_alloc_vectors mlx5 conversion and
the nvme code centralization.
