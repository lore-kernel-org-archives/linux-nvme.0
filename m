From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Apr 2018 17:07:58 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
Message-ID: <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>


>> I don't understand what you mean by a "property of the admin queue",
>> there is no such definition in the spec. In any event, the keep alive
>> mechanism was defined to detect host/controller health on a periodic
>> basis.
>>
>> The spec clearly states that the host needs to send keep alive at
>> a faster rate than the Keep alive timeout accounting things such
>> as transport roundtrip times, transport delays, keep alive timer
>> granularity and so on.
>>
>> To me, this is a clear case where your use-case requires a larger
>> keep alive timeout. I'm not sure why sprinkling the keep alive execution
>> around solve/help anything. To me this looks completely redundant
>> (sorry).
> 
> I think that starting keep-alive timer at the target side after admin 
> connect and starting keep-alive timer at the host side after all 
> io-queues connect is wrong.
> In my solution I start keep-alive mechanism in the host side also after 
> admin connect (exactly as the target side).

That does not guarantee anything either. as you were simply able to
minimize the effect.

An alternative patch would also be able to minimize the effect:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1b708ee6783..a84198b1e0d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -847,7 +847,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl 
*ctrl)
         INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
         memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
         ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
-       schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+       schedule_delayed_work(&ctrl->ka_work, 0);
  }

  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
--

This way the first keep alive will execute immediately the first time
and not kato after...

> In this way I'll make sure the "health" is ok during the io-queues 
> connection establishment (establisment of 4000-5000 IO queues can take 
> long time and we hope sending a KA packet will not take more than 15 
> seconds no matter what :) ).

No you won't. nvme_start_keep_alive will execute a keep alive kato after
it was started. and why do you need to detect the health during
connection establishment? queue creation will fail if health is lost.

> Why to have inconsistant implementation ?
> Increasing the timeout is not a solution (maybe can WA some scenarios). 
> Also TBKA comes to solve different problem.

No, it came to solve a false positive of heart-bit lost as a result of
keep alive starvation, which is exactly what this scenario is.

>> As a side note, Note that this should be solved by "Traffic Based Keep
>> Alive" TP which is approaching ratification. This is yet another example
>> showing that Having keep alive timer firing regardless of command
>> execution is hurtful.
> 
> TBKA will work as nop-in/out in iSCSI AKAIK. But again, it will no solve 
> the issue I described above.

Yes it will, fabrics connect is a traffic indication and will reset the
keep alive timer.
