From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 25 Nov 2018 01:10:59 -0800
Subject: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181122080224.GA26504@lst.de>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
Message-ID: <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>


>> +static enum nvme_tcp_recv_state nvme_tcp_recv_state(struct nvme_tcp_queue *queue)
>> +{
>> +	return  (queue->pdu_remaining) ? NVME_TCP_RECV_PDU :
>> +		(queue->ddgst_remaining) ? NVME_TCP_RECV_DDGST :
>> +		NVME_TCP_RECV_DATA;
>> +}
> 
> This just seems to be used in a single switch statement.  Why the detour
> theough the state enum?

I think its clearer that the calling switch statement is switching on
an explicit state...

I can add the queue an explicit recv_state that would transition
these states like the target does, would that be better?

>> +		/*
>> +		 * FIXME: This assumes that data comes in-order,
>> +		 *  need to handle the out-of-order case.
>> +		 */
> 
> That sounds like something we should really address before merging.

That is an old comment from the first days where the
spec didn't explicitly state that data is transferred in
order for a single request. Will drop the comment.

>> +	read_lock(&sk->sk_callback_lock);
>> +	queue = sk->sk_user_data;
>> +	if (unlikely(!queue || !queue->rd_enabled))
>> +		goto done;
>> +
>> +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> +done:
>> +	read_unlock(&sk->sk_callback_lock);
> 
> Don't we need a rcu_dereference_sk_user_data here?

If I'm protected with the sk_callback_lock I don't need
it do I? I wander if I can remove the sk_callback_lock
and move to rcu only? That would require careful look
as when I change the callbacks I need to synchronize rcu
before clearing sk_user_data..

It seems that only tunneling ulps are using it so I'm not
sure that the actual user should use it...

> Also why not:
> 
> 	queue = rcu_dereference_sk_user_data(sk);
> 	if (likely(queue && queue->rd_enabled))
> 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> 	read_unlock(&sk->sk_callback_lock);

That I'll change...

>> +static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>> +{
>> +	union nvme_result res = {};
>> +
>> +	nvme_end_request(blk_mq_rq_from_pdu(req),
>> +		NVME_SC_DATA_XFER_ERROR, res);
> 
> This looks like odd formatting, needs one more tab.  But
> NVME_SC_DATA_XFER_ERROR is also generally a status that should be
> returned from the nvme controller, not made up on the host.

Well.. the driver did fail to transfer data... What would be a
better completion status then?

>> +	if (req->state == NVME_TCP_SEND_CMD_PDU) {
>> +		ret = nvme_tcp_try_send_cmd_pdu(req);
>> +		if (ret <= 0)
>> +			goto done;
>> +		if (!nvme_tcp_has_inline_data(req))
>> +			return ret;
>> +	}
>> +
>> +	if (req->state == NVME_TCP_SEND_H2C_PDU) {
>> +		ret = nvme_tcp_try_send_data_pdu(req);
>> +		if (ret <= 0)
>> +			goto done;
>> +	}
>> +
>> +	if (req->state == NVME_TCP_SEND_DATA) {
>> +		ret = nvme_tcp_try_send_data(req);
>> +		if (ret <= 0)
>> +			goto done;
>> +	}
>> +
>> +	if (req->state == NVME_TCP_SEND_DDGST)
>> +		ret = nvme_tcp_try_send_ddgst(req);
> 
> Use a switch statement here?

The code flow is expected to fallthru as the command sequence continues
such that I don't need to "re-call" the routine...

For example, for in-capsule write, we will start in SEND_CMD_PDU,
continue to SEND_DATA and then to SEND_DDGST (if data digest exists)..

>> +static void nvme_tcp_free_tagset(struct nvme_ctrl *nctrl,
>> +		struct blk_mq_tag_set *set)
>> +{
>> +	blk_mq_free_tag_set(set);
>> +}
> 
> Please drop this wrapper.
> 
>> +static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
>> +		bool admin)
>> +{
> 
> This function does two entirely different things based on the admin
> paramter.

These two were left as such from my attempts to converge some
code over in the core.. I can remove them if you insist...

>> +int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
> 
> Shouldn't this (or anything in this file for that matter) be static?

Again, leftovers from my attempts to converge code...

>> +static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
>> +{
>> +	nvme_tcp_teardown_ctrl(ctrl, true);
>> +}
> 
> Pointless wrapper.

nvme_tcp_delete_ctrl() is a callback.

>> +static void nvme_tcp_set_sg_null(struct nvme_command *c)
>> +{
>> +	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>> +
>> +	sg->addr = 0;
>> +	sg->length = 0;
>> +	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>> +			NVME_SGL_FMT_TRANSPORT_A;
>> +}
>> +
>> +static void nvme_tcp_set_sg_host_data(struct nvme_tcp_request *req,
>> +		struct nvme_command *c)
>> +{
>> +	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>> +
>> +	sg->addr = 0;
>> +	sg->length = cpu_to_le32(req->data_len);
>> +	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>> +			NVME_SGL_FMT_TRANSPORT_A;
>> +}
> 
> Do we really need nvme_tcp_set_sg_null?  Any command it is called
> on should have a request with a 0 length, so it could use
> nvme_tcp_set_sg_host_data.

We don't..

>> +static enum blk_eh_timer_return
>> +nvme_tcp_timeout(struct request *rq, bool reserved)
>> +{
>> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +	struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
>> +	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
>> +
>> +	dev_dbg(ctrl->ctrl.device,
>> +		"queue %d: timeout request %#x type %d\n",
>> +		nvme_tcp_queue_id(req->queue), rq->tag,
>> +		pdu->hdr.type);
>> +
>> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
>> +		union nvme_result res = {};
>> +
>> +		nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
>> +		nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
>> +		return BLK_EH_DONE;
> 
> This looks odd.  It's not really the timeout handlers job to
> call nvme_end_request here.

Well.. if we are not yet LIVE, we will not trigger error
recovery, which means nothing will complete this command so
something needs to do it...

I think that we need it for rdma too..

...

The rest of the comments will be addressed in the next submission..
