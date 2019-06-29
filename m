From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 28 Jun 2019 17:00:50 -0700
Subject: [PATCH v2] nvme-fc: fix module unloads while lports still pending
In-Reply-To: <1cfc9504-45d5-2ba3-55d9-949e5a301889@broadcom.com>
References: <20190628231621.15867-1-jsmart2021@gmail.com>
 <b07da70f-770c-db0d-bf4e-7997c890c67b@acm.org>
 <1cfc9504-45d5-2ba3-55d9-949e5a301889@broadcom.com>
Message-ID: <6a2d56bd-eb0c-d9d4-884a-a883c7084b8c@acm.org>

On 6/28/19 4:32 PM, James Smart wrote:
> 
> 
> On 6/28/2019 4:26 PM, Bart Van Assche wrote:
>> On 6/28/19 4:16 PM, James Smart wrote:
>>> @@ -237,6 +242,7 @@ nvme_fc_free_lport(struct kref *ref)
>>> ????? put_device(lport->dev);
>>> ? ????? kfree(lport);
>>> +
>>> ? }
>>
>> Spurious whitespace?
> 
> yes
> 
>>
>>> +static void
>>> +nvme_fc_cleanup_for_unload(void)
>>> +{
>>> +??? struct nvme_fc_lport *lport;
>>> +??? struct nvme_fc_rport *rport;
>>> +??? unsigned long flags;
>>> +
>>> +??? spin_lock_irqsave(&nvme_fc_lock, flags);
>>> +??? list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
>>> +??????? list_for_each_entry(rport, &lport->endp_list, endp_list) {
>>> +??????????? nvme_fc_delete_controllers(rport);
>>> +??????? }
>>> +??? }
>>> +??? spin_unlock_irqrestore(&nvme_fc_lock, flags);
>>> +
>>> +??? pr_info("%s: waiting for ctlr deletes\n", __func__);
>>> +??? wait_for_completion(&nvme_fc_unload_proceed);
>>> +??? pr_info("%s: ctrl deletes complete\n", __func__);
>>> +}
>>> +
>>> ? static void __exit nvme_fc_exit_module(void)
>>> ? {
>>> -??? /* sanity check - all lports should be removed */
>>> +??? unsigned long flags;
>>> +??? bool need_cleanup = false;
>>> +
>>> +??? spin_lock_irqsave(&nvme_fc_lock, flags);
>>> +??? nvme_fc_waiting_to_unload = true;
>>> +??? init_completion(&nvme_fc_unload_proceed);
>>> ????? if (!list_empty(&nvme_fc_lport_list))
>>> -??????? pr_warn("%s: localport list not empty\n", __func__);
>>> +??????? need_cleanup = true;
>>> +??? spin_unlock_irqrestore(&nvme_fc_lock, flags);
>>> +??? if (need_cleanup)
>>> +??????? nvme_fc_cleanup_for_unload();
>>
>> Can the nvme_fc_lport_list list become empty after 
>> nvme_fc_exit_module() has unlocked nvme_fc_lock and before 
>> nvme_fc_cleanup_for_unload() is called? If so, shouldn't 
>> nvme_fc_cleanup_for_unload() be called unconditionally and shouldn't 
>> the wait_for_completion(&nvme_fc_unload_proceed) call depend on 
>> whether or not nvme_fc_cleanup_for_unload() has deleted any controllers?
> 
> It's possible which is why I init'd the completion while under the 
> lock.?? Therefore, the removal that would make it empty, which is also 
> under lock, will trigger the completion. In this scenario, the cleanup 
> routine would be an empty list, fall into the wait for completion, which 
> immediately succeeds.

Hi James,

Have you considered to use DECLARE_COMPLETION()?

Thanks,

Bart.
