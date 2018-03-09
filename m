From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 9 Mar 2018 09:59:28 +0800
Subject: [PATCH V4 2/5] nvme: add helper interface to flush in-flight
 requests
In-Reply-To: <931a03f8-9c8b-fec4-0f89-04321a906710@grimberg.me>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
 <931a03f8-9c8b-fec4-0f89-04321a906710@grimberg.me>
Message-ID: <35c68f2a-8198-7db6-c381-420ac996802a@oracle.com>

Hi Sagi

Thanks for your precious time for review and comment.

On 03/09/2018 02:21 AM, Sagi Grimberg wrote:

>> +EXPORT_SYMBOL_GPL(nvme_abort_requests_sync);
>> +
>> +static void nvme_comp_req(struct request *req, void *data, bool reserved)
> 
> Not a very good name...

Yes, indeed.

> 
>> +{
>> +??? struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
>> +
>> +??? if (!test_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags))
>> +??????? return;
>> +
>> +??? WARN_ON(!blk_mq_request_started(req));
>> +
>> +??? if (ctrl->tagset && ctrl->tagset->ops->complete) {
> 
> What happens when this called on the admin tagset when the controller
> does not have an io tagset?

Yes, nvme_ctrl.admin_tagset should be used here for adminq request.


> 
>> +??????? clear_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags);
>> +??????? /*
>> +???????? * We set the status to NVME_SC_ABORT_REQ, then ioq request
>> +???????? * will be requeued and adminq one will be failed.
>> +???????? */
>> +??????? nvme_req(req)->status = NVME_SC_ABORT_REQ;
>> +??????? /*
>> +???????? * For ioq request, blk_mq_requeue_request should be better
>> +???????? * here. But the nvme code will still setup the cmd even if
>> +???????? * the RQF_DONTPREP is set. We have to use .complete to free
>> +???????? * the cmd and then requeue it.
> 
> IMO, its better to fix nvme to not setup the command if RQF_DONTPREP is on (other than the things it must setup).

Yes, I used to consider change that.
But I'm not sure whether there is special consideration there.
If you and Keith think it is ok that not setup command when RQF_DONTPREP is set, we could do that.

> 
>> +???????? *
>> +???????? * For adminq request, invoking .complete directly will miss
>> +???????? * blk_mq_sched_completed_request, but this is ok because we
>> +???????? * won't have io scheduler for adminq.
>> +???????? */
>> +??????? ctrl->tagset->ops->complete(req);
> 
> I don't think that directly calling .complete is a good idea...

Yes, indeed.

Thanks a lot 
Jianchao
