From: hare@suse.com (Hannes Reinecke)
Date: Thu, 25 Apr 2019 09:10:56 +0200
Subject: [PATCHv2 RFC] nvme: use nvme_set_queue_dying() during namespace
 rescanning
In-Reply-To: <9c928178-8f39-1edf-c10f-9d5046d772aa@grimberg.me>
References: <20190403231221.127008-1-hare@suse.de>
 <9c928178-8f39-1edf-c10f-9d5046d772aa@grimberg.me>
Message-ID: <47d35329-8ae0-5828-874c-68d58fa1226c@suse.com>

On 4/24/19 6:30 PM, Sagi Grimberg wrote:
> 
>> From: Hannes Reinecke <hare at suse.com>
>>
>> There is a race condition between namespace rescanning and controller
>> reset; during controller reset all namespaces are quiesed vie
>> nams_stop_ctrl(), and after reset all namespaces are unquiesced
>> again.
>> When namespace scanning was active by the time controller reset was
>> triggered the rescan code will call nvme_ns_remove(), which then will
>> cause a kernel crash in nvme_start_ctrl() as it'll trip over
>> uninitialized namespaces.
>>
>> This patch calls nvme_set_queue_dying() during namespace rescan,
>> which will already unquiesce the queue. Hence we can skip all namespaces
>> with the 'DEAD' flag during unquiesce in nvme_start_ctrl() and eliminate
>> this issue.
> 
> Hannes, won't that make the namespace enumeration inconsistent?
> 
How so?
The basic problem is that nvme_validate_ns() will more-or-less 
automatically _remove_ all namespaces if it's called concurrently during 
a reset (as trivially no I/O is possible).
However, after reset we'll be rescanning all namespace _anyway_, 
re-establishing all previously deleted namespaces.

With this patch we'll just deferring the deletion (which we would've 
done anyway).

However, this patch has been folded into Ming Leis patchset (as the last 
patch in the series), so I guess we can discard it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
