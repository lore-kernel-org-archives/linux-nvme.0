From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 27 Oct 2016 08:56:50 -0700
Subject: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
In-Reply-To: <f1661bd2-12ca-20d1-ece2-5c7fe5987035@suse.de>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
 <f1661bd2-12ca-20d1-ece2-5c7fe5987035@suse.de>
Message-ID: <5227b122-8c10-5f63-4448-499fc645cfbd@sandisk.com>

On 10/26/2016 10:52 PM, Hannes Reinecke wrote:
> Hmm. Can't say I like having to have two RCU structure for the same
> purpose, but I guess that can't be helped.

Hello Hannes,

There are two RCU structures because of BLK_MQ_F_BLOCKING. Today only 
the nbd driver sets that flag. If the nbd driver would be modified such 
that it doesn't set that flag then the BLK_MQ_F_BLOCKING flag and also 
queue_rq_srcu could be eliminated from the blk-mq core.

Bart.
