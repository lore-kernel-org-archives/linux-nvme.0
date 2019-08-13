From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Aug 2019 23:26:31 -0700
Subject: [PATCH] nvme: simplify nvme_req_qid()
In-Reply-To: <20190812110155epcms2p4f44ce4ea4d6cbcceae7a466c98897549@epcms2p4>
References: <4ce851fc-2560-cb45-9733-bb8ff4a5069e@grimberg.me>
 <20190804071902.31872-1-minwoo.im.dev@gmail.com>
 <CGME20190805181113epcas3p2fe0b38b9075ca205e5a8beff77531c10@epcms2p4>
 <20190812110155epcms2p4f44ce4ea4d6cbcceae7a466c98897549@epcms2p4>
Message-ID: <e875b23c-5cc6-6c15-e83a-7d1a3048900c@grimberg.me>


> Hi, Sagi.
> 
>>> blk_mq_unique_tag() just makes a unique tag which holds not only the
>>> tag, but also the queue_num of the hctx.  With this unique tag,
>>> blk_mq_unique_tag_to_hwq is nothing but removing the tag from it.
>>>
>>> Therefore the qid or the I/O queues can simply be:
>>> 	(struct blk_mq_hw_ctx *)->queue_num + 1
>>
>> This pattern is not unique to nvme, perhaps add a helper for it
>> in the block layer and modify the callers?
> 
> Sorry, but could you please elaborate a little bit more in detail that
> Why the pattern is not unique to nvme ?

This is at least used by smartqpi (although I did remember that more
used to use it...)
