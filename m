From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 15:34:12 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <e83090fb-c9c7-d371-9a89-53e00b17837a@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
 <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>
 <ed15449d-8991-2bcd-a381-54727eaef241@mellanox.com>
 <3ee4b1a9-0b00-f7df-5198-a9f893e5a6af@broadcom.com>
 <e83090fb-c9c7-d371-9a89-53e00b17837a@mellanox.com>
Message-ID: <8607cd8d-a0bd-ac88-7923-2473970e587d@grimberg.me>



On 04/12/2018 11:49 AM, Max Gurtovoy wrote:
> 
> 
> On 4/11/2018 7:48 PM, James Smart wrote:
>> On 4/11/2018 7:40 AM, Max Gurtovoy wrote:
>>>
>>>
>>> On 4/11/2018 5:07 PM, Sagi Grimberg wrote:
>>>>
>>>>>> I don't understand what you mean by a "property of the admin queue",
>>>>>> there is no such definition in the spec. In any event, the keep alive
>>>>>> mechanism was defined to detect host/controller health on a periodic
>>>>>> basis.
>>>>>>
>>>>>> The spec clearly states that the host needs to send keep alive at
>>>>>> a faster rate than the Keep alive timeout accounting things such
>>>>>> as transport roundtrip times, transport delays, keep alive timer
>>>>>> granularity and so on.
>>>>>>
>>>>>> To me, this is a clear case where your use-case requires a larger
>>>>>> keep alive timeout. I'm not sure why sprinkling the keep alive 
>>>>>> execution
>>>>>> around solve/help anything. To me this looks completely redundant
>>>>>> (sorry).
>>>>>
>>>>> I think that starting keep-alive timer at the target side after 
>>>>> admin connect and starting keep-alive timer at the host side after 
>>>>> all io-queues connect is wrong.
>>>>> In my solution I start keep-alive mechanism in the host side also 
>>>>> after admin connect (exactly as the target side).
>>
>> well - true, but I believe it should be started after the controller 
>> is enabled - not just that the admin queue has been created.? I don't 
>> think even the admin queue can be serviced till the adapter is 
>> enabled. Thus, I would agree with moving nvme_start_keep_alive() from 
>> nvme_start_ctrl() to nvme_enable_ctrl().?? We would also want the 
>> "enablement" to detect the keepalive style (today's keepalive or TBKA) 
>> supported by the time that call is made.?? Given that needs to be 
>> known, I believe there will always be a small window where a couple of 
>> things have to be accessed before the KA starts.
> 
> At least I see that you agree to start keep-alive timer before creating 
> the IO queues so that's a progress :).
> The fact that I didn't put it in nvme_enable_ctrl is because the FC code 
> never calls nvme_disable_ctrl (and there we probably should stop the 
> timer).
> I'm trying to solve an issue without changing the whole design of the FC 
> implementation. We can do it incrementaly.

Please don't touch any of the transport drivers for any of this, its the
wrong place to handle keep alive.

>>
>> I strongly support Sagi's statements on trying to keep the KA 
>> start/stop in common code rather than sprinkling it around.?? I agree 
>> with the current placement of the stop code in nvme_stop_ctrl().?? The 
>> stop ctrl should always be called prior to the admin queue being torn 
>> down in the transport (as part of kicking off the reset of the 
>> controller).
> 
> If we'll add KA start to nvme_enable_ctrl then the KA stop should be 
> added to nvme_disable_ctrl. We should be symmetric.

Not a must. even after the controller is disabled we want to
have a keep alive to it as we would need to enable it again at
some point.
