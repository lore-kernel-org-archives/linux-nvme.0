From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 13:36:40 +0200
Subject: [PATCH 8/9] nvme-pci: break up nvme_timeout and nvme_dev_disable
In-Reply-To: <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <4f2268ba-6b6a-8273-594c-b63fdb7b6a96@grimberg.me>

Jianchao,

> Currently, the complicated relationship between nvme_dev_disable
> and nvme_timeout has become a devil that will introduce many
> circular pattern which may trigger deadlock or IO hang. Let's
> enumerate the tangles between them:
>   - nvme_timeout has to invoke nvme_dev_disable to stop the
>     controller doing DMA access before free the request.
>   - nvme_dev_disable has to depend on nvme_timeout to complete
>     adminq requests to set HMB or delete sq/cq when the controller
>     has no response.
>   - nvme_dev_disable will race with nvme_timeout when cancels the
>     previous outstanding requests.
> 2nd case is necessary. This patch is to break up 1st and 3th case.
> 
> To achieve this:
> Use blk_abort_request to force all the previous outstanding requests
> expired in nvme_dev_disable. Set NVME_REQ_CANCELLED and return
> BLK_EH_NOT_HANDLED in nvme_timeout. Then the request will not be
> completed and freed. We needn't invoke nvme_dev_disable any more.
> 
> We use NVME_REQ_CANCELLED to identify them. After the controller is
> totally disabled/shutdown, we invoke blk_mq_rq_update_aborted_gstate
> to clear requests and invoke blk_mq_complete_request to complete them.
> In addition, to identify the previous adminq/IOq request and adminq
> requests from nvme_dev_disable, we introduce
> NVME_PCI_OUTSTANDING_GRABBING and NVME_PCI_OUTSTANDING_GRABBED to
> let nvme_timeout be able to distinguish them.
> 
> For the adminq requests from nvme_dev_disable/nvme_reset_work:
> invoke nvme_disable_ctrl directly, then set NVME_REQ_CANCELLED and
> return BLK_EH_HANDLED. nvme_dev_disable/nvme_reset_work will
> see the error.

I think this is going in the wrong direction. Every state that is needed
to handle serialization should be done in core ctrl state. Moreover,
please try to avoid handling this locally in nvme-pci, place common
helpers in nvme-core and use them. I won't be surprised if fc would
need some of these.

Also, can we try and not disable the controller from nvme_timeout? I'm
not sure I understand why is this needed at all. What's wrong with
scheduling a controller reset/delete? Why is something like
nvme_pci_disable_ctrl_directly needed?

I'd like to see an effort to consolidate error handling paths rather
than enhancing the current skew...
