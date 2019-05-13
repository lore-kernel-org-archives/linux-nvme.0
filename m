From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 May 2019 08:15:01 +0200
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <689b9665-5f93-1ccc-3e6b-41436b769b09@grimberg.me>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
 <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
 <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>
 <3f84d637-4d04-45e1-ce49-59238c2aaea8@broadcom.com>
 <c3bf6edd-91fc-74d5-29a3-093fa57d561f@suse.de>
 <689b9665-5f93-1ccc-3e6b-41436b769b09@grimberg.me>
Message-ID: <e29ecf45-4b14-22a1-e161-df37e4166301@suse.de>

On 5/12/19 5:08 PM, Sagi Grimberg wrote:
> 
>> You're talking about discovery referrals, right?
>> In this case I'd go with case a), and simply create non-persistent 
>> connection.
>> Reasoning is that if the admin wants to have a persistent discovery he 
>> should be ensuring that this secondary controller is found during 
>> inital discovery (ie with the abovementioned systemd boot service).
>>
>> (And discovery referrals are tricky anyway; I've created two discovery 
>> controllers each having a reference to the other nice in order to have 
>> a failover scenario, but ended up with a looping nvme connect-all ... 
>> need to send a patch for that.)
> 
> Hmm...
> 
> I see two options here:
> 1. create new transient discovery controller for each referral as we do
> today.
> 2. make --persistent follow referrals such that we have persistent
> device for each and then we skip referrals as we will expect events
> coming from them...
> 
> I would suggest (1) as its simpler.

Same here.
A persistent connection is pretty much an admin choice, and we cannot 
and should not out-guess the admin here.
If the admin wants to use persistent connections he should be creating one.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
