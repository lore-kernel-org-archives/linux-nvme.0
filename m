From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 8 Jun 2017 09:55:37 +0200
Subject: [PATCH v6 05/10] nvmet: implement namespace identify descriptor
 list
In-Reply-To: <20170608075209.GA14359@lst.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-6-jthumshirn@suse.de> <20170608074414.GD13953@lst.de>
 <ac55e56a-a47e-1e53-c537-b940de99c746@suse.de>
 <20170608075209.GA14359@lst.de>
Message-ID: <7ffdc123-c43b-dff0-73bf-4e876ece323e@suse.de>

On 06/08/2017 09:52 AM, Christoph Hellwig wrote:
> On Thu, Jun 08, 2017@09:49:35AM +0200, Johannes Thumshirn wrote:
>> On 06/08/2017 09:44 AM, Christoph Hellwig wrote:
>>>> +	if (sg_zeroout_area(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE, off)
>>>
>>> Shouldn;t the third argument be NVME_IDENTIFY_DATA_SIZE - off in theory?
>>> It's probably fine as is as the S/G helpers deal with overflows
>>> gracefully, but still..
>>
>> Ahm yes. *doh*
>>
>> Can you fix it up when applying?
> 
> Sure.
> 

Btw, is the NVMf sleftests still avtively developed? If yes I have a
testcase for this series (not sure this qualifies for blktests)

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
