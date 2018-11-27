From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 27 Nov 2018 02:05:14 +0200
Subject: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
 <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
Message-ID: <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>

+static enum blk_eh_timer_return
>>> +nvme_tcp_timeout(struct request *rq, bool reserved)
>>> +{
>>> +??? struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>>> +??? struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
>>> +??? struct nvme_tcp_cmd_pdu *pdu = req->pdu;
>>> +
>>> +??? dev_dbg(ctrl->ctrl.device,
>>> +??????? "queue %d: timeout request %#x type %d\n",
>>> +??????? nvme_tcp_queue_id(req->queue), rq->tag,
>>> +??????? pdu->hdr.type);
>>> +
>>> +??? if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
>>> +??????? union nvme_result res = {};
>>> +
>>> +??????? nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
>>> +??????? nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
>>> +??????? return BLK_EH_DONE;
>>
>> This looks odd.? It's not really the timeout handlers job to
>> call nvme_end_request here.
>
> Well.. if we are not yet LIVE, we will not trigger error
> recovery, which means nothing will complete this command so
> something needs to do it...
>
> I think that we need it for rdma too..


yes we do. and we've patches in our pipe.

I'm thinking on a wider change in the error/recovery flows but might 
send it "as is" meanwhile.


>
> ...
>
> The rest of the comments will be addressed in the next submission..
