From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 12 Apr 2018 16:32:33 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <ad4fc7df-f53c-0c38-dd12-eb235056a0d8@grimberg.me>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
 <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>
 <ed15449d-8991-2bcd-a381-54727eaef241@mellanox.com>
 <3ee4b1a9-0b00-f7df-5198-a9f893e5a6af@broadcom.com>
 <ad4fc7df-f53c-0c38-dd12-eb235056a0d8@grimberg.me>
Message-ID: <ee210857-fc8c-cf1a-eca1-32f58e8cab2e@mellanox.com>



On 4/12/2018 3:29 PM, Sagi Grimberg wrote:
> 
> 
> On 04/11/2018 07:48 PM, James Smart wrote:
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
>> nvme_start_ctrl() to nvme_enable_ctrl().
> 
> I'm fine with that.
> 
>> ? We would also want the "enablement" to detect the keepalive style 
>> (today's keepalive or TBKA) supported by the time that call is made.   
>> Given that needs to be known, I believe there will always be a small 
>> window where a couple of things have to be accessed before the KA starts.
> 
> I honestly don't understand why should this even be an issue. If someone
> is running a heavy load where keep alive timeout is not sufficient, then
> it should use a larger keep alive.
> 
>> I strongly support Sagi's statements on trying to keep the KA 
>> start/stop in common code rather than sprinkling it around.?? I agree 
>> with the current placement of the stop code in nvme_stop_ctrl().?? The 
>> stop ctrl should always be called prior to the admin queue being torn 
>> down in the transport (as part of kicking off the reset of the 
>> controller).
> 
> Yea, we need to keep it where it is. the start can move to controller
> enable, and in fact, the target should also do that for the target
> and update the timer in nvmet_start_ctrl.
> -- 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index fe151d672241..a81bf4d5e60c 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -643,6 +643,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>  ??????? }
> 
>  ??????? ctrl->csts = NVME_CSTS_RDY;
> +?????? mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
>  ?}
> 
>  ?static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
> -- 
> 
> This would get the correct behavior and still be able to
> detect host death before the controller was enabled.
> 
> This together with moving the keep alive timer start in nvme_enable_ctrl
> should be enough and not propagating the handle to every transport
> driver, we have enough of that already.

Great, this is what I wanted to do in the first place but I was 
concerned about stopping the keep-alive in nvme_disable_ctrl.
Are you sending a new series or I will ?

> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e1b708ee6783..4b5c3f7addeb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1739,7 +1739,14 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 
> cap)
>  ??????? ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, 
> ctrl->ctrl_config);
>  ??????? if (ret)
>  ??????????????? return ret;
> -?????? return nvme_wait_ready(ctrl, cap, true);
> +
> +?????? ret = nvme_wait_ready(ctrl, cap, true);
> +?????? if (ret)
> +?????????????? return ret;
> +
> +?????? nvme_start_keep_alive(ctrl);
> +
> +?????? return 0;
>  ?}
>  ?EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
> 
> @@ -3393,9 +3400,6 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
>  ?void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>  ?{
> -?????? if (ctrl->kato)
> -?????????????? nvme_start_keep_alive(ctrl);
> -
>  ??????? if (ctrl->queue_count > 1) {
>  ??????????????? nvme_queue_scan(ctrl);
>  ??????????????? queue_work(nvme_wq, &ctrl->async_event_work);
> -- 
> 
>>>> That does not guarantee anything either. as you were simply able to
>>>> minimize the effect.
>>>>
>>>> An alternative patch would also be able to minimize the effect:
>>>> -- 
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index e1b708ee6783..a84198b1e0d8 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -847,7 +847,7 @@ static void nvme_start_keep_alive(struct 
>>>> nvme_ctrl *ctrl)
>>>> ???????? INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>>>> ???????? memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>>>> ???????? ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>>>> -?????? schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>>>> +?????? schedule_delayed_work(&ctrl->ka_work, 0);
>>>> ??}
>>>>
>>>> ??void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>>>> -- 
>>>>
>>>> This way the first keep alive will execute immediately the first time
>>>> and not kato after...
>>>
>>> This is a good patch, and I can add it to the series.
>>
>> Uh... I wouldn't want to do this.? You can easily burn lots of cycles 
>> sending a KA.
> 
> Its only for the first invocation. but I think its useless anyways...

So this one is out.

> 
>> I would lean toward making people get used to setting KATO to a large 
>> enough value that it can be used equally well with TBKA - thus it 
>> should be something like this instead:
>> ??????? schedule_delayed_work(&ctrl->ka_work, (ctrl->kato * HZ) / 2);
>>
>> This is somewhat independent from the grace value - as grace is a 
>> scaling factor to accommodate congestion and delayed processing.
> 
> This is fine too.
