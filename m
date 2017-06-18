From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 11:02:17 +0300
Subject: [PATCH v5 for-4.13 3/7] mlx5: move affinity hints assignments to
 generic code
In-Reply-To: <20170616094746.GB12547@lst.de>
References: <1497533594-11579-1-git-send-email-sagi@grimberg.me>
 <1497533594-11579-4-git-send-email-sagi@grimberg.me>
 <20170616094746.GB12547@lst.de>
Message-ID: <21343c26-9b7a-de53-6e4f-ffd98189717e@grimberg.me>


>>   	rq->mpwqe.info = kzalloc_node(wq_sz * sizeof(*rq->mpwqe.info),
>> -				      GFP_KERNEL, cpu_to_node(c->cpu));
>> +					GFP_KERNEL, node);
> 
> Why the reindenting?

Heh, no good reason, I'm just a tabs person...

Although I might consider converting :)
https://www.theregister.co.uk/2017/06/16/spaces_vs_tabs/

> 
>>   	/* We allocate more than mtt_sz as we will align the pointer */
>> -	rq->mpwqe.mtt_no_align = kzalloc_node(mtt_alloc * wq_sz, GFP_KERNEL,
>> -					cpu_to_node(c->cpu));
>> +	rq->mpwqe.mtt_no_align = kzalloc_node(mtt_alloc * wq_sz,
>> +					GFP_KERNEL, node);
> 
> Or the moving of GFP_KERNEL to the next line here?

I'll respin...
