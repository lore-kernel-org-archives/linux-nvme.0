From: james.smart@broadcom.com (James Smart)
Date: Tue, 26 Feb 2019 13:53:45 -0800
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <7721fbe9-cb21-5197-2c9d-f6786e082696@cisco.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
 <20190220221454.GA31450@osmithde-lnx.cisco.com>
 <2fc8ae0b-2773-87e1-a319-55e251b3f7d7@gmail.com>
 <2cd0c5e9-845a-2122-e2a1-7ef3f96ce33f@cisco.com>
 <7721fbe9-cb21-5197-2c9d-f6786e082696@cisco.com>
Message-ID: <9da8e308-aa16-25bb-3bf0-e3cef3e28ab8@broadcom.com>

On 2/21/2019 3:16 PM, Oliver Smith-Denny wrote:
> On 02/21/2019 10:45 AM, Oliver Smith-Denny wrote:> I have been testing 
> with these changes and have been getting one
>> warning (kernel/workqueue.c:3028) when the discovery controller gets
>> NVMe_Disconnect. I also have been trying some error injection (not
>> sending the occasional response from the target LLDD for write data)
>> and getting blocked tasks for > 120 seconds, with the following call
>> trace (this is after getting NVMe_Disconnect for the data controller):
>>
>> INFO: task kworker/27:2:35310 blocked for more than 120 seconds.
>> Tainted: G??????? W? O????? 5.0.0-rc7-next-20190220+ #1
>> ??kworker/27:2??? D??? 0 35310????? 2 0x80000080
>> Workqueue: events nvmet_fc_handle_ls_rqst_work [nvmet_fc]
>> Call Trace:
>> __schedule+0x2ab/0x880
>> ? complete+0x4d/0x60
>> schedule+0x36/0x70
>> schedule_timeout+0x1dc/0x300
>> complete+0x4d/0x60
>> nvmet_destroy_namespace+0x20/0x20 [nvmet]
>> wait_for_completion+0x121/0x180
>> wake_up_q+0x80/0x80
>> nvmet_sq_destroy+0x4f/0xf0 [nvmet]
>> nvmet_fc_delete_target_assoc+0x2fd/0x3f0 [nvmet_fc]
>> nvmet_fc_handle_ls_rqst_work+0x6ad/0xa40 [nvmet_fc]
>> process_one_work+0x179/0x3a0
>> worker_thread+0x4f/0x3e0
>> kthread+0x105/0x140
>> ? max_active_store+0x80/0x80
>> ? kthread_bind+0x20/0x20
>> ret_from_fork+0x35/0x40
>
> I tried running the vanilla 5.0-rc7 kernel and I did not see
> either the warning or the blocked tasked (but that makes sense because 
> the vanilla kernel doesn't delete controllers with the current logic 
> on NVME_Disconnect).
>
> I then readded your patch to the kernel and I see both the warning and 
> blocked task.

Oliver,

I took at look at the two patches, and the one had missed at ! check on 
scheduling the work. Thus it resulted in an extra put being done, thus 
it would be released too soon.

Try with this v2 patch and let me know.

-- james
