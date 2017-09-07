From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Sep 2017 14:03:21 +0200
Subject: [PATCH 2/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <4efc8d9b-a9d6-0297-9aff-e078bfdaa7f6@grimberg.me>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-3-git-send-email-maxg@mellanox.com>
 <20170906103816.GB24667@lst.de>
 <4efc8d9b-a9d6-0297-9aff-e078bfdaa7f6@grimberg.me>
Message-ID: <20170907120321.GC18794@lst.de>

On Wed, Sep 06, 2017@05:57:47PM +0300, Sagi Grimberg wrote:
>
>>>     	int			idx;
>>>   	int			host_qid;
>>> +	int			comp_vector;
>>
>> How will this interact with these changes:
>>
>> http://git.infradead.org/users/hch/rdma.git/shortlog/refs/heads/rdma-cq.2
>>
>> which I'd really like to see in?
>
> I have another spin on that one (plus the fine-grained affinity
> assignments addition that I proposed to nvmet a while ago).
>
> You can see it here:
> git://git.infradead.org/users/sagi/linux.git rdma-cq-pool

Tiem to get it out to the list :)  Chuck was also really interested
in some of this for NFS.
