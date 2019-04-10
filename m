From: hare@suse.de (Hannes Reinecke)
Date: Wed, 10 Apr 2019 16:56:47 +0200
Subject: FC-NVMe csn initialisation
In-Reply-To: <5620085f-9add-7e97-3145-c815690ca9ca@broadcom.com>
References: <7f105083-7e74-7191-d321-acdeafa25f88@suse.de>
 <210FF865-6562-4404-A47D-E38EDD5D9B00@netapp.com>
 <e1d5b88f-218c-e556-6053-93a6c3aeda8b@broadcom.com>
 <fa84d071-4c61-6082-f92e-4c018e9ff0ff@suse.de>
 <5620085f-9add-7e97-3145-c815690ca9ca@broadcom.com>
Message-ID: <03b0f608-16ac-688c-4a51-a8750857df75@suse.de>

On 4/9/19 7:17 PM, James Smart wrote:
> 
> 
> On 4/8/2019 11:08 PM, Hannes Reinecke wrote:
[ .. ]
>> Well, the _actual_ background of this question was that I'd been 
>> thinking if one could use csn to implement SQ flow control; after all, 
>> csn is pretty similar to the SQ Head pointer, albeit with a different 
>> modulo. If the spec would allow us to wrap-around csn at any arbitrary 
>> fixed number we wouldn't need to implement a separate SQ head pointer 
>> at all :-)
>> Sadly, FC-NVMe is pretty adamant that we should be wrapping around at 
>> UINT_MAX...
>>
>> Cheers,
>>
>> Hannes
> 
> Nope. CSN is a different beast with different semantics. Why wouldn't 
> you go to SQHD/SQTAIL like the standard says ? (which our initiators 
> purposely ignore)
> 
> it actually wouldn't be such a big deal to implement in the transport - 
> we already have the retry logic for other things, and the nvmet target 
> does properly increment SQHD - by 1 on every command completion, thus 
> it's compliant with fabric flow control style too.? But you could then 
> pace SQHD updates to give you the flow control like you wanted (per 
> spec). Granted the question would then be do all transports honor it per 
> spec. ? It could also open to using more than a single io queues's depth 
> worth of commands on a controller (can scale out by the number of 
> queues; I dislike how many target resources we leave unused today), but 
> it goes against some of the things Christoph was trying to do, one of 
> which checking SQHD/SQTAIL.
> 
Yes, I'm aware. I just had been discussing with John, and we figured 
that having proper SQ flow control might actually help with the OnTap 
array. But of course, it'll need to be carefully measured so as not to 
incur regressions in the general case.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
