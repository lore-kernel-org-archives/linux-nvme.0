From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 12 Apr 2018 11:49:03 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <3ee4b1a9-0b00-f7df-5198-a9f893e5a6af@broadcom.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
 <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>
 <ed15449d-8991-2bcd-a381-54727eaef241@mellanox.com>
 <3ee4b1a9-0b00-f7df-5198-a9f893e5a6af@broadcom.com>
Message-ID: <e83090fb-c9c7-d371-9a89-53e00b17837a@mellanox.com>



On 4/11/2018 7:48 PM, James Smart wrote:
> On 4/11/2018 7:40 AM, Max Gurtovoy wrote:
>>
>>
>> On 4/11/2018 5:07 PM, Sagi Grimberg wrote:
>>>
>>>>> I don't understand what you mean by a "property of the admin queue",
>>>>> there is no such definition in the spec. In any event, the keep alive
>>>>> mechanism was defined to detect host/controller health on a periodic
>>>>> basis.
>>>>>
>>>>> The spec clearly states that the host needs to send keep alive at
>>>>> a faster rate than the Keep alive timeout accounting things such
>>>>> as transport roundtrip times, transport delays, keep alive timer
>>>>> granularity and so on.
>>>>>
>>>>> To me, this is a clear case where your use-case requires a larger
>>>>> keep alive timeout. I'm not sure why sprinkling the keep alive 
>>>>> execution
>>>>> around solve/help anything. To me this looks completely redundant
>>>>> (sorry).
>>>>
>>>> I think that starting keep-alive timer at the target side after 
>>>> admin connect and starting keep-alive timer at the host side after 
>>>> all io-queues connect is wrong.
>>>> In my solution I start keep-alive mechanism in the host side also 
>>>> after admin connect (exactly as the target side).
> 
> well - true, but I believe it should be started after the controller is 
> enabled - not just that the admin queue has been created.? I don't think 
> even the admin queue can be serviced till the adapter is enabled. Thus, 
> I would agree with moving nvme_start_keep_alive() from nvme_start_ctrl() 
> to nvme_enable_ctrl().?? We would also want the "enablement" to detect 
> the keepalive style (today's keepalive or TBKA) supported by the time 
> that call is made.?? Given that needs to be known, I believe there will 
> always be a small window where a couple of things have to be accessed 
> before the KA starts.

At least I see that you agree to start keep-alive timer before creating 
the IO queues so that's a progress :).
The fact that I didn't put it in nvme_enable_ctrl is because the FC code 
never calls nvme_disable_ctrl (and there we probably should stop the timer).
I'm trying to solve an issue without changing the whole design of the FC 
implementation. We can do it incrementaly.

> 
> I strongly support Sagi's statements on trying to keep the KA start/stop 
> in common code rather than sprinkling it around.?? I agree with the 
> current placement of the stop code in nvme_stop_ctrl().?? The stop ctrl 
> should always be called prior to the admin queue being torn down in the 
> transport (as part of kicking off the reset of the controller).

If we'll add KA start to nvme_enable_ctrl then the KA stop should be 
added to nvme_disable_ctrl. We should be symmetric.

> 
> Note: the FC patch is way off..? Also note that I've killed the 
> xxx_is_ready() routines in the updated if_ready patch I sent. So your 
> mods wouldn't apply (soon).

I'm rebased over latest nvme branch and your xxx_is_ready is not there.
If you have a better solution - please share with us.

> 
>>>
>>> That does not guarantee anything either. as you were simply able to
>>> minimize the effect.
>>>
>>> An alternative patch would also be able to minimize the effect:
>>> -- 
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index e1b708ee6783..a84198b1e0d8 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -847,7 +847,7 @@ static void nvme_start_keep_alive(struct 
>>> nvme_ctrl *ctrl)
>>> ???????? INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>>> ???????? memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>>> ???????? ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>>> -?????? schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>>> +?????? schedule_delayed_work(&ctrl->ka_work, 0);
>>> ??}
>>>
>>> ??void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>>> -- 
>>>
>>> This way the first keep alive will execute immediately the first time
>>> and not kato after...
>>
>> This is a good patch, and I can add it to the series.
> 
> Uh... I wouldn't want to do this.? You can easily burn lots of cycles 
> sending a KA.

I don't realy mind to lose some cycles during connection establishment 
and do the right thing.

> 
> I would lean toward making people get used to setting KATO to a large 
> enough value that it can be used equally well with TBKA - thus it should 
> be something like this instead:
>  ?????? schedule_delayed_work(&ctrl->ka_work, (ctrl->kato * HZ) / 2);

People are using the default value. I guess I can live with (ctrl->kato 
* HZ) / 2 as a first delay if we start the timer before IO queues creation.

> 
> This is somewhat independent from the grace value - as grace is a 
> scaling factor to accommodate congestion and delayed processing.
> 
> -- james
> 

I can summerize that there are different perspectives on that issue and 
that is the reason why I think this should be added to the spec to clear 
things up.
The spec should say explicitly that the KA timer should be started ater 
admin_queue connect and before starting to perform io_connect.

Christoph,
what do you think about the assymetry we have here and the patches that 
fix it ?

-Max.
