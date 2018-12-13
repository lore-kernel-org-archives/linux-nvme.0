From: hare@suse.de (Hannes Reinecke)
Date: Thu, 13 Dec 2018 13:04:46 +0100
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
In-Reply-To: <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
Message-ID: <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>

On 12/12/18 6:58 PM, Sagi Grimberg wrote:
> 
>> Sagi,
>>
>> What other wins are there for this split ?
>>
>> I'm considering whether its worthwhile for fc as well, but the hol 
>> issue doesn't exist with fc. What else is being resolved ?
> 
> I've pondered it myself, which is why I didn't add it to fc as well
> (would have been easy enough I think). I guess that with this the
> user can limit writes compared to read by assigning less queues as
> jens suggested in his patches...
 >
Weelll ... isn't that what blkcg is for?
I do understand if one would want to implement something like this if 
there's a real benefit from the _hardware_ side, but if there isn't we 
should try to keep it in the upper layers where it belongs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
