From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 12 Feb 2018 10:16:33 +0800
Subject: [PATCH 8/9] nvme-pci: break up nvme_timeout and nvme_dev_disable
In-Reply-To: <4f2268ba-6b6a-8273-594c-b63fdb7b6a96@grimberg.me>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
 <4f2268ba-6b6a-8273-594c-b63fdb7b6a96@grimberg.me>
Message-ID: <992179f4-becc-f0bf-867a-e49adbd756ee@oracle.com>

Hi Sagi

Thanks for your kindly remind and directive.
That's really appreciated.

On 02/11/2018 07:36 PM, Sagi Grimberg wrote:
> Jianchao,
> 
>> Currently, the complicated relationship between nvme_dev_disable
>> and nvme_timeout has become a devil that will introduce many
>> circular pattern which may trigger deadlock or IO hang. Let's
>> enumerate the tangles between them:
>> ? - nvme_timeout has to invoke nvme_dev_disable to stop the
>> ??? controller doing DMA access before free the request.
>> ? - nvme_dev_disable has to depend on nvme_timeout to complete
>> ??? adminq requests to set HMB or delete sq/cq when the controller
>> ??? has no response.
>> ? - nvme_dev_disable will race with nvme_timeout when cancels the
>> ??? previous outstanding requests.
>> 2nd case is necessary. This patch is to break up 1st and 3th case.
>>
>> To achieve this:
>> Use blk_abort_request to force all the previous outstanding requests
>> expired in nvme_dev_disable. Set NVME_REQ_CANCELLED and return
>> BLK_EH_NOT_HANDLED in nvme_timeout. Then the request will not be
>> completed and freed. We needn't invoke nvme_dev_disable any more.
>>
>> We use NVME_REQ_CANCELLED to identify them. After the controller is
>> totally disabled/shutdown, we invoke blk_mq_rq_update_aborted_gstate
>> to clear requests and invoke blk_mq_complete_request to complete them.
>> In addition, to identify the previous adminq/IOq request and adminq
>> requests from nvme_dev_disable, we introduce
>> NVME_PCI_OUTSTANDING_GRABBING and NVME_PCI_OUTSTANDING_GRABBED to
>> let nvme_timeout be able to distinguish them.
>>
>> For the adminq requests from nvme_dev_disable/nvme_reset_work:
>> invoke nvme_disable_ctrl directly, then set NVME_REQ_CANCELLED and
>> return BLK_EH_HANDLED. nvme_dev_disable/nvme_reset_work will
>> see the error.
> 
> I think this is going in the wrong direction. Every state that is needed
> to handle serialization should be done in core ctrl state. Moreover,
> please try to avoid handling this locally in nvme-pci, place common
> helpers in nvme-core and use them. I won't be surprised if fc would
> need some of these.
> 
> Also, can we try and not disable the controller from nvme_timeout?

In fact, that is what this patch what to do. For the previous outstanding requests,
this patch return BLK_EH_NOT_HANDLED and defer the work to nvme_dev_disable.

 I'm
> not sure I understand why is this needed at all. What's wrong with
> scheduling a controller reset/delete? Why is something like
> nvme_pci_disable_ctrl_directly needed?

Keith used to point out to me that, we cannot complete and free a request
before we close the controller and pci master bus, otherwise, there will
be somethings wrong in DMA accessing, because when we complete a request, 
the associated DMA mapping will be freed.

For the previous outstanding requests, this patch could grab them with blk_abort_request
in nvme_dev_disable, and complete them after we disable/shutdown the controller.

But for the adminq requests in nvme_dev_disable and nvme_reset_work, we cannot do this.
We cannot schedule another reset_work->nvme_dev_disable to do that, because we are in it.
So I use this nvme_pci_disable_ctrl_directly which looks like very ugly, to disable the
controller and then we could complete the request with failure to move progress forward.

> I'd like to see an effort to consolidate error handling paths rather
> than enhancing the current skew...

Yes, absolutely. That is also what I expect. :)

This patch has two aspects:
1. grab all the previous outstanding requests with blk_abort_request.
   It is safe when race with the irq completion path. And then complete them
   after we disable/shutdown the controller completely.
   I think this part could be placed in nvme ctrl core.

2. avoid nvme_timeout invoke nvme_dev_disable. this is the most tricky part.
   as I shared above, we have to _disable_ the controller _before_ we compete the adminq request
   from the nvme_dev_disable and nvme_reset_work. Consequently, we cannot do as the
   nvme_rdma_timeout, schedule a recovery work and then return. 

Thanks for your directive here again.

Sincerely
Jianchao

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=4qwnypr12koG5mlPP0ZwJ8CdYf883HXT6wCWIRalSDo&s=cRJP-1nma0XWbRggjGKHWYIiTEDUbiLHI_5YBfpKMBU&e=
> 
