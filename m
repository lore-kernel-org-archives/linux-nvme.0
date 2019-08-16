From: james.smart@broadcom.com (James Smart)
Date: Fri, 16 Aug 2019 11:24:21 -0700
Subject: [PATCH rfc] nvme: make all fabrics command run on a separate
 request queue
In-Reply-To: <1b3e039b-15ef-703b-1d01-454eaa22ef0e@grimberg.me>
References: <20190808234643.8180-1-sagi@grimberg.me>
 <4c7083d3-2067-13d8-b3d8-0418769c80c4@broadcom.com>
 <1b3e039b-15ef-703b-1d01-454eaa22ef0e@grimberg.me>
Message-ID: <44e08fd5-f5be-0055-2deb-eb914b36eaea@broadcom.com>



On 8/16/2019 10:24 AM, Sagi Grimberg wrote:
>
>> This keeps anything in that scan thread from getting in the way.?? 
>> We're not too far from this with your patches. It may be the 
>> interaction of the two isn't so bad (if you are live enough for a 
>> controller Identify, are you live enough for the ns scanning ios ?),
>
> Exactly, this is why everything stays the same, and we just unquiesce
> the admin_q after the controller is enabled (and also quiesce before
> we disable).
>
>> but my initial reaction is I'd like to separate them.? Thoughts ?
>
> I'm not sure I understand what you are suggesting. Adding states that
> will determine which request queue to use? Not sure how this is going
> to work. Can you explain more on your thoughts?
>

I'm good with the explanation.



>>
>> I think the fabrics_q had to be quiesced and unquiesed at the points 
>> where today's admin_q is in fc.? It's possible the controller may 
>> under go a reset while in the middle of creating/initializing a new 
>> controller (on FC, async detection of connectivity is detected, 
>> resetting the controller). As such, I need to be sure the fabric 
>> commands initializing the controller are stopped/aborted, and the 
>> admin queue will be marked non-live to abort any retries other 
>> attempts, until the new create_association is attempted.?? Quiescing 
>> also helps as, as is, we are looping on the admin tag set to 
>> abort/clear anything outstanding on the reset, with the request_q not 
>> quiesced, which is probably not a good thing.
>
> OK, I can add that.

Thanks.

-- james
