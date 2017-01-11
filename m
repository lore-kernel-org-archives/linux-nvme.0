From: hare@suse.de (Hannes Reinecke)
Date: Wed, 11 Jan 2017 16:16:56 +0100
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
Message-ID: <9d23f03f-5094-98bc-3c6d-e263801bed61@suse.de>

On 01/11/2017 04:07 PM, Jens Axboe wrote:
> On 01/11/2017 06:43 AM, Johannes Thumshirn wrote:
>> Hi all,
>>
>> I'd like to attend LSF/MM and would like to discuss polling for block drivers.
>>
>> Currently there is blk-iopoll but it is neither as widely used as NAPI in the
>> networking field and accoring to Sagi's findings in [1] performance with
>> polling is not on par with IRQ usage.
>>
>> On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
>> more block drivers and how to overcome the currently seen performance issues.
> 
> It would be an interesting topic to discuss, as it is a shame that blk-iopoll
> isn't used more widely.
> 
Indeed; some drivers like lpfc already _have_ a polling mode, but not
hooked up to blk-iopoll. Would be really cool to get that going.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
