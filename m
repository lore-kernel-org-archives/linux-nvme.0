From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sat, 20 Jan 2018 22:07:02 +0800
Subject: [PATCH V5 0/2] nvme-pci: fix the timeout case when reset is
 ongoing
In-Reply-To: <20180120021119.GJ12043@localhost.localdomain>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180119080130.GE12043@localhost.localdomain>
 <0639aa2f-d153-5aac-ce08-df0d4b45f9a0@oracle.com>
 <20180119084218.GF12043@localhost.localdomain>
 <84b4e3bc-fe23-607e-9d5e-bb5644eedb54@oracle.com>
 <20180119115255.GH12043@localhost.localdomain>
 <3cc0d180-0b7e-e71f-66ce-43f4dfffb701@oracle.com>
 <20180120021119.GJ12043@localhost.localdomain>
Message-ID: <ea00677b-6d79-e9c0-e0af-78e287f29ddd@oracle.com>

Hi Keith

Thanks for you kindly response.

On 01/20/2018 10:11 AM, Keith Busch wrote:
> On Fri, Jan 19, 2018@09:56:48PM +0800, jianchao.wang wrote:
>> In nvme_dev_disable, the outstanding requests will be requeued finally.
>> I'm afraid the requests requeued on the q->requeue_list will be blocked until another requeue
>> occurs, if we cancel the requeue work before it get scheduled.
> 
> We should kick the request list in nvme_start_queues.
> 
Yes

@@ -3513,8 +3513,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
        struct nvme_ns *ns;
 
        mutex_lock(&ctrl->namespaces_mutex);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
+       list_for_each_entry(ns, &ctrl->namespaces, list) {
                blk_mq_unquiesce_queue(ns->queue);
+               blk_mq_kick_requeue_list(ns->queue);
+       }
        mutex_unlock(&ctrl->namespaces_mutex);
 }

Then, nvme_sync_queues could be more universal.

Many thanks for your directive.

Jianchao
