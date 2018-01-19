From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 19 Jan 2018 21:56:48 +0800
Subject: [PATCH V5 0/2] nvme-pci: fix the timeout case when reset is
 ongoing
In-Reply-To: <20180119115255.GH12043@localhost.localdomain>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180119080130.GE12043@localhost.localdomain>
 <0639aa2f-d153-5aac-ce08-df0d4b45f9a0@oracle.com>
 <20180119084218.GF12043@localhost.localdomain>
 <84b4e3bc-fe23-607e-9d5e-bb5644eedb54@oracle.com>
 <20180119115255.GH12043@localhost.localdomain>
Message-ID: <3cc0d180-0b7e-e71f-66ce-43f4dfffb701@oracle.com>

Hi Keith

Thanks for your kindly response.

On 01/19/2018 07:52 PM, Keith Busch wrote:
> On Fri, Jan 19, 2018@05:02:06PM +0800, jianchao.wang wrote:
>> We should not use blk_sync_queue here, the requeue_work and run_work will be canceled.
>> Just flush_work(&q->timeout_work) should be ok.
> 
> I agree flushing timeout_work is sufficient. All the other work had
> already better not be running either, so it doesn't hurt to call the
> sync API.
In nvme_dev_disable, the outstanding requests will be requeued finally.
I'm afraid the requests requeued on the q->requeue_list will be blocked until another requeue
occurs, if we cancel the requeue work before it get scheduled.

>  
>> In addition, we could check NVME_CC_ENABLE in nvme_dev_disable to avoid redundant invoking.
>> :)
> 
> That should already be inferred through reading back the CSTS register.
> 
Yes, the "dead"  in nvme_dev_disable looks enough for these uncommon cases.

Thanks
Jianchao
