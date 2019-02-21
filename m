From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Thu, 21 Feb 2019 10:45:54 -0800
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <2fc8ae0b-2773-87e1-a319-55e251b3f7d7@gmail.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
 <20190220221454.GA31450@osmithde-lnx.cisco.com>
 <2fc8ae0b-2773-87e1-a319-55e251b3f7d7@gmail.com>
Message-ID: <2cd0c5e9-845a-2122-e2a1-7ef3f96ce33f@cisco.com>

On 02/21/2019 10:29 AM, James Smart wrote:[snip]
> I plan to make another pass through the transport for spec compliance in 
> a couple of weeks. Part of that was ensuring all the headers and 
> disconnect behaviors were in sync. We should also get some of the SLER 
> bits in. I can roll your changes in with that or you're free to make the 
> suggested changes called out above.

Sounds good to roll these header changes in with the rest of the spec
compliance you are going to do. I agree with you on your other comments,
makes sense.

I have been testing with these changes and have been getting one
warning (kernel/workqueue.c:3028) when the discovery controller gets
NVMe_Disconnect. I also have been trying some error injection (not
sending the occasional response from the target LLDD for write data)
and getting blocked tasks for > 120 seconds, with the following call
trace (this is after getting NVMe_Disconnect for the data controller):

INFO: task kworker/27:2:35310 blocked for more than 120 seconds.
Tainted: G        W  O      5.0.0-rc7-next-20190220+ #1
  kworker/27:2    D    0 35310      2 0x80000080
Workqueue: events nvmet_fc_handle_ls_rqst_work [nvmet_fc]
Call Trace:
__schedule+0x2ab/0x880
? complete+0x4d/0x60
schedule+0x36/0x70
schedule_timeout+0x1dc/0x300
complete+0x4d/0x60
nvmet_destroy_namespace+0x20/0x20 [nvmet]
wait_for_completion+0x121/0x180
wake_up_q+0x80/0x80
nvmet_sq_destroy+0x4f/0xf0 [nvmet]
nvmet_fc_delete_target_assoc+0x2fd/0x3f0 [nvmet_fc]
nvmet_fc_handle_ls_rqst_work+0x6ad/0xa40 [nvmet_fc]
process_one_work+0x179/0x3a0
worker_thread+0x4f/0x3e0
kthread+0x105/0x140
? max_active_store+0x80/0x80
? kthread_bind+0x20/0x20
ret_from_fork+0x35/0x40

So I will investigate this, make sure first that it is not
from anything I am doing incorrectly in the LLDD. If that is
not the case I will update you with fuller results. I only
see this after incorporating your changes and mine (though
I will start with taking out mine, since not all of them
should be there).

Thanks,
Oliver
