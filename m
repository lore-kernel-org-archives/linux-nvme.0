From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 20 Jun 2018 13:26:35 +0800
Subject: [PATCH] nvme-pci: not invoke nvme_remove_dead_ctrl when change
 state fails
In-Reply-To: <20180619163952.GE19922@localhost.localdomain>
References: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180619163952.GE19922@localhost.localdomain>
Message-ID: <7d2d346b-91f0-adad-1e11-e5ff660fb984@oracle.com>

Hi Keith

On 06/20/2018 12:39 AM, Keith Busch wrote:
> On Tue, Jun 19, 2018@04:30:50PM +0800, Jianchao Wang wrote:
>> There is race between nvme_remove and nvme_reset_work that can
>> lead to io hang.
>>
>> nvme_remove                    nvme_reset_work
>> -> change state to DELETING
>>                                -> fail to change state to LIVE
>>                                -> nvme_remove_dead_ctrl
>>                                  -> nvme_dev_disable
>>                                    -> quiesce request_queue
>>                                  -> queue remove_work
>> -> cancel_work_sync reset_work
>> -> nvme_remove_namespaces
>>   -> splice ctrl->namespaces
>>                                nvme_remove_dead_ctrl_work
>>                                -> nvme_kill_queues
>>   -> nvme_ns_remove               do nothing
>>     -> blk_cleanup_queue
>>       -> blk_freeze_queue
>> Finally, the request_queue is quiesced state when wait freeze,
>> we will get io hang here.
>>
>> In fact, when fails to change state in nvme_reset_work, the only
>> reason is someone has changed state to DELETING. So it is not
>> necessary to invoke nvme_remove_dead_ctrl in that case.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> 
> Good catch. I think the fix should either have the nvme_dev_disable set
> shutdown to true to indicate the controller isn't coming back online, or
> move the nvme_kill_queues inside nvme_remove_dead_ctrl.

Yes,just not invoking  nvme_remove_dead_ctrl when change state fails couldn't fix the hole completely.
I prefer to move nvme_kill_queues from nvme_remove_dead_ctrl_work to nvme_remove_dead_ctrl.
Will post the V2 version based on this.


Thanks
Jianchao
