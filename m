From: mlin@kernel.org (Ming Lin)
Date: Wed, 13 Jul 2016 16:36:52 -0700
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <1468451986.4105.3.camel@linux.intel.com>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
 <1468451986.4105.3.camel@linux.intel.com>
Message-ID: <CAF1ivSZfcnS7Hte6dKiNBerxzt9QHPHddDNyJiEe_MSfUpfLZg@mail.gmail.com>

On Wed, Jul 13, 2016 at 4:19 PM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
>
>>  static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>> @@ -687,6 +684,10 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl
>> *nctrl)
>>       list_del(&ctrl->list);
>>       mutex_unlock(&nvme_rdma_ctrl_mutex);
>>
>> +     blk_cleanup_queue(ctrl->ctrl.admin_q);
>> +     blk_mq_free_tag_set(&ctrl->admin_tag_set);
>> +     nvme_rdma_dev_put(ctrl->device);
>> +
>>       if (ctrl->ctrl.tagset) {
>>               blk_cleanup_queue(ctrl->ctrl.connect_q);
>>               blk_mq_free_tag_set(&ctrl->tag_set);
>
> This patch does not remove the second
>
> nvme_rdma_dev_put(ctrl->device);
>
> call that happens within the if() statement above if it evaluates to
> TRUE.  Should that have been removed or moved elsewhere?

Not sure I understand your question.
Did you mean line 694?

For discovery controller, there is no IO queues. So ctrl->ctrl.tagset is NULL.

The first bulk of
"blk_cleanup_queue/blk_mq_free_tag_set/nvme_rdma_dev_put" is for admin
queue.
And the second is for IO queues.

 676 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 677 {
 678         struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 679
 680         if (list_empty(&ctrl->list))
 681                 goto free_ctrl;
 682
 683         mutex_lock(&nvme_rdma_ctrl_mutex);
 684         list_del(&ctrl->list);
 685         mutex_unlock(&nvme_rdma_ctrl_mutex);
 686
 687         blk_cleanup_queue(ctrl->ctrl.admin_q);
 688         blk_mq_free_tag_set(&ctrl->admin_tag_set);
 689         nvme_rdma_dev_put(ctrl->device);
 690
 691         if (ctrl->ctrl.tagset) {
 692                 blk_cleanup_queue(ctrl->ctrl.connect_q);
 693                 blk_mq_free_tag_set(&ctrl->tag_set);
 694                 nvme_rdma_dev_put(ctrl->device);
 695         }
 696         kfree(ctrl->queues);
 697         nvmf_free_options(nctrl->opts);
 698 free_ctrl:
 699         kfree(ctrl);
 700 }
