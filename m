From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 19:16:45 +0200
Subject: [PATCH rfc 3/3] nvmet-rdma: assign cq completion vector based
 on the port allowed cpus
In-Reply-To: <da6a9e33-163e-4964-8305-614b7b830c17@grimberg.me>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
 <1499007694-7231-4-git-send-email-sagi@grimberg.me>
 <20170713155003.GB2577@lst.de>
 <da6a9e33-163e-4964-8305-614b7b830c17@grimberg.me>
Message-ID: <20170713171645.GA5107@lst.de>

On Thu, Jul 13, 2017@07:37:13PM +0300, Sagi Grimberg wrote:
>
>> We really shouldn't be doing any of this in NVMe I think.  We'll need
>> to go back to the cq pool API first.  The last version I had was here:
>>
>> 	http://git.infradead.org/users/hch/rdma.git/shortlog/refs/heads/rdma-cq
>
> Not against the idea, though the ULP will need to pass a desired cpu
> affinity.

Yes.
