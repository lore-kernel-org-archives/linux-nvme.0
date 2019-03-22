From: hare@suse.com (Hannes Reinecke)
Date: Fri, 22 Mar 2019 07:55:55 +0100
Subject: [PATCH] nvme: schedule requeue whenever a LIVE state is entered
In-Reply-To: <da58a1e4-14cd-2587-6350-dccabb6632f1@grimberg.me>
References: <20190321141033.131308-1-hare@suse.de>
 <da58a1e4-14cd-2587-6350-dccabb6632f1@grimberg.me>
Message-ID: <0ccee425-93bb-ad04-5b20-f8a792f1aafa@suse.com>

On 3/21/19 10:26 PM, Sagi Grimberg wrote:
> 
>> When undergoing state transitions I/O might be requeued, hence
>> we always have to schedule requeue_work whenever the nvme device
>> is live, independent on whether the old state was live or not.
> 
> Any reason why not simply update from live to live?
> 
?

I somewhat fail to parse the answer.
Care to elaborate?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
