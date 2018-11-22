From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Nov 2018 09:02:25 +0100
Subject: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <20181122015615.15763-14-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me>
Message-ID: <20181122080224.GA26504@lst.de>

A few reandom nitpicks:

> +static int nvme_tcp_verify_hdgst(struct nvme_tcp_queue *queue,
> +	void *pdu, size_t pdu_len)

Please use two tabs for indenting prototype continuations

> +	len = le32_to_cpu(hdr->plen) - hdr->hlen -
> +		((hdr->flags & NVME_TCP_F_HDGST) ? nvme_tcp_hdgst_len(queue) : 0);

Overly long line.  But it would be much cleaner with a local digest_len
variable anyway.

> +static enum nvme_tcp_recv_state nvme_tcp_recv_state(struct nvme_tcp_queue *queue)
> +{
> +	return  (queue->pdu_remaining) ? NVME_TCP_RECV_PDU :
> +		(queue->ddgst_remaining) ? NVME_TCP_RECV_DDGST :
> +		NVME_TCP_RECV_DATA;
> +}

This just seems to be used in a single switch statement.  Why the detour
theough the state enum?

> +{
> +	struct request *rq;
> +	struct nvme_tcp_request *req;
> +
> +	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
> +	if (!rq) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d tag 0x%x not found\n",
> +			nvme_tcp_queue_id(queue), cqe->command_id);
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		return -EINVAL;
> +	}
> +	req = blk_mq_rq_to_pdu(rq);
> +
> +	nvme_end_request(rq, cqe->status, cqe->result);

req seems unused here.

> +			nvme_tcp_queue_id(queue), pdu->command_id);
> +		return -ENOENT;
> +	}
> +	req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!blk_rq_payload_bytes(rq)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d tag %#x unexpected data\n",
> +			nvme_tcp_queue_id(queue), rq->tag);
> +		return -EIO;
> +	}
> +
> +	queue->data_remaining = le32_to_cpu(pdu->data_length);
> +	/* No support for out-of-order */
> +	WARN_ON(le32_to_cpu(pdu->data_offset));
> +
> +	return 0;

And here as well.

Also can we just WARN_ON on the offset?  

> +	ret = skb_copy_bits(skb, *offset,
> +		&queue->pdu[queue->pdu_offset], rcv_len);

More of this can go on th first line.

> +	if (unlikely(ret))
> +		return ret;
> +
> +	queue->pdu_remaining -= rcv_len;
> +	queue->pdu_offset += rcv_len;
> +	*offset += rcv_len;
> +	*len -= rcv_len;
> +	if (queue->pdu_remaining)
> +		return 0;
> +
> +	hdr = (void *)queue->pdu;

hdr is a struct nvme_tcp_hdr *, please use the right cast if we have
to cast - but then again queue->pdu probably should be a void pointer
so that we can use it everywhere without casts.

> +static void nvme_tcp_init_recv_iter(struct nvme_tcp_request *req)
> +{
> +	struct bio *bio = req->curr_bio;
> +	struct bio_vec *vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> +	unsigned int nsegs = bio_segments(bio);
> +
> +	iov_iter_bvec(&req->iter, READ, vec, nsegs,
> +		bio->bi_iter.bi_size);
> +	req->iter.iov_offset = bio->bi_iter.bi_bvec_done;

This code seems largely identical to that in nvme_tcp_init_send_iter
except for passing READ vs WRITE.  Please use a common helper.

> +		/*
> +		 * FIXME: This assumes that data comes in-order,
> +		 *  need to handle the out-of-order case.
> +		 */

That sounds like something we should really address before merging.

> +	read_lock(&sk->sk_callback_lock);
> +	queue = sk->sk_user_data;
> +	if (unlikely(!queue || !queue->rd_enabled))
> +		goto done;
> +
> +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +done:
> +	read_unlock(&sk->sk_callback_lock);

Don't we need a rcu_dereference_sk_user_data here?

Also why not:

	queue = rcu_dereference_sk_user_data(sk);
	if (likely(queue && queue->rd_enabled))
		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
	read_unlock(&sk->sk_callback_lock);

	
> +static void nvme_tcp_write_space(struct sock *sk)
> +{
> +	struct nvme_tcp_queue *queue;
> +
> +	read_lock_bh(&sk->sk_callback_lock);
> +	queue = sk->sk_user_data;
> +
> +	if (!queue)
> +		goto done;
> +
> +	if (sk_stream_is_writeable(sk)) {
> +		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +	}
> +done:
> +	read_unlock_bh(&sk->sk_callback_lock);

Same here:

	queue = rcu_dereference_sk_user_data(sk);
	if (queue && sk_stream_is_writeable(sk)) {
		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
	}
	read_unlock(&sk->sk_callback_lock);

(there are a few more places where rcu_dereference_sk_user_data should
be used, skipping them now).

> +static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
> +{
> +	queue->request = NULL;
> +}
> +
> +static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
> +{
> +	union nvme_result res = {};
> +
> +	nvme_end_request(blk_mq_rq_from_pdu(req),
> +		NVME_SC_DATA_XFER_ERROR, res);

This looks like odd formatting, needs one more tab.  But
NVME_SC_DATA_XFER_ERROR is also generally a status that should be
returned from the nvme controller, not made up on the host.


> +		if (queue->data_digest)
> +			nvme_tcp_ddgst_update(queue->snd_hash, page, offset, ret);

Overly long line, please stick to 80 characters.

> +	if (req->state == NVME_TCP_SEND_CMD_PDU) {
> +		ret = nvme_tcp_try_send_cmd_pdu(req);
> +		if (ret <= 0)
> +			goto done;
> +		if (!nvme_tcp_has_inline_data(req))
> +			return ret;
> +	}
> +
> +	if (req->state == NVME_TCP_SEND_H2C_PDU) {
> +		ret = nvme_tcp_try_send_data_pdu(req);
> +		if (ret <= 0)
> +			goto done;
> +	}
> +
> +	if (req->state == NVME_TCP_SEND_DATA) {
> +		ret = nvme_tcp_try_send_data(req);
> +		if (ret <= 0)
> +			goto done;
> +	}
> +
> +	if (req->state == NVME_TCP_SEND_DDGST)
> +		ret = nvme_tcp_try_send_ddgst(req);

Use a switch statement here?

> +static void nvme_tcp_free_tagset(struct nvme_ctrl *nctrl,
> +		struct blk_mq_tag_set *set)
> +{
> +	blk_mq_free_tag_set(set);
> +}

Please drop this wrapper.

> +static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
> +		bool admin)
> +{

This function does two entirely different things based on the admin
paramter.

> +static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	nvme_tcp_stop_queue(ctrl, 0);
> +}

This wrapper seems a bit pointless.

> +static int nvme_tcp_start_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	return nvme_tcp_start_queue(ctrl, 0);
> +}

Same here.

> +int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)

Shouldn't this (or anything in this file for that matter) be static?

> +	if (ctrl->queue_count > 1) {
> +		nvme_stop_queues(ctrl);
> +		nvme_tcp_stop_io_queues(ctrl);
> +		blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl);
> +		if (remove)
> +			nvme_start_queues(ctrl);
> +		nvme_tcp_destroy_io_queues(ctrl, remove);
> +	}

Overly long line above.  Could be easily solved with an early return..

> +static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	nvme_tcp_teardown_ctrl(ctrl, true);
> +}

Pointless wrapper.

> +static void nvme_tcp_set_sg_null(struct nvme_command *c)
> +{
> +	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +
> +	sg->addr = 0;
> +	sg->length = 0;
> +	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> +			NVME_SGL_FMT_TRANSPORT_A;
> +}
> +
> +static void nvme_tcp_set_sg_host_data(struct nvme_tcp_request *req,
> +		struct nvme_command *c)
> +{
> +	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +
> +	sg->addr = 0;
> +	sg->length = cpu_to_le32(req->data_len);
> +	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> +			NVME_SGL_FMT_TRANSPORT_A;
> +}

Do we really need nvme_tcp_set_sg_null?  Any command it is called
on should have a request with a 0 length, so it could use
nvme_tcp_set_sg_host_data.

> +static enum blk_eh_timer_return
> +nvme_tcp_timeout(struct request *rq, bool reserved)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
> +	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
> +
> +	dev_dbg(ctrl->ctrl.device,
> +		"queue %d: timeout request %#x type %d\n",
> +		nvme_tcp_queue_id(req->queue), rq->tag,
> +		pdu->hdr.type);
> +
> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
> +		union nvme_result res = {};
> +
> +		nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
> +		nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
> +		return BLK_EH_DONE;

This looks odd.  It's not really the timeout handlers job to
call nvme_end_request here.


> +	if (rq_data_dir(rq) == WRITE) {
> +		req->curr_bio = rq->bio;
> +		if (req->data_len <= nvme_tcp_inline_data_size(queue))
> +			req->pdu_len = req->data_len;
> +	} else {
> +		req->curr_bio = rq->bio;
> +		if (req->curr_bio)
> +			nvme_tcp_init_recv_iter(req);
> +	}

The curr_bio setup is duplicated in both branches.
