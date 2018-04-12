From: james.smart@broadcom.com (James Smart)
Date: Thu, 12 Apr 2018 10:28:53 -0700
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <8607cd8d-a0bd-ac88-7923-2473970e587d@grimberg.me>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
 <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>
 <ed15449d-8991-2bcd-a381-54727eaef241@mellanox.com>
 <3ee4b1a9-0b00-f7df-5198-a9f893e5a6af@broadcom.com>
 <e83090fb-c9c7-d371-9a89-53e00b17837a@mellanox.com>
 <8607cd8d-a0bd-ac88-7923-2473970e587d@grimberg.me>
Message-ID: <5a0754d5-49fc-abcb-f6d4-6770cad81271@broadcom.com>

On 4/12/2018 5:34 AM, Sagi Grimberg wrote:
>
>> At least I see that you agree to start keep-alive timer before 
>> creating the IO queues so that's a progress :).
>> The fact that I didn't put it in nvme_enable_ctrl is because the FC 
>> code never calls nvme_disable_ctrl (and there we probably should stop 
>> the timer).
>> I'm trying to solve an issue without changing the whole design of the 
>> FC implementation. We can do it incrementaly.
>
> Please don't touch any of the transport drivers for any of this, its the
> wrong place to handle keep alive.

The reason FC doesn't call nvme_disable_ctrl() is because I don't 
believe it has much value. It's at best a "good citizen" thing that can 
encounter more problems than it's worth.? All that disable does is 
perform a pseudo reg write (property_set) to disable the controller. But 
to perform that write requires the link-side nvmeof association to not 
be failed/in error, the admin connection valid, the controller not 
failed in any way (may already be due to the error) and able to send a 
response back. In almost all cases other than an admin-requested reset, 
those things aren't necessarily valid.? So calling it, and having it 
wait for a completion isn't a great idea imho.

Thus the use jumping to nvme_stop_ctrl() instead. It is the real 
function that disables io and stops work against the controller until a 
new association can get in place.? So I agree with where the stop KA is 
now - in nvme_stop_ctrl().


>
>>>
>>> I strongly support Sagi's statements on trying to keep the KA 
>>> start/stop in common code rather than sprinkling it around. I agree 
>>> with the current placement of the stop code in nvme_stop_ctrl().?? 
>>> The stop ctrl should always be called prior to the admin queue being 
>>> torn down in the transport (as part of kicking off the reset of the 
>>> controller).
>>
>> If we'll add KA start to nvme_enable_ctrl then the KA stop should be 
>> added to nvme_disable_ctrl. We should be symmetric.
>
> Not a must. even after the controller is disabled we want to
> have a keep alive to it as we would need to enable it again at
> some point.

As indicate above - no - don't move it.

-- james
