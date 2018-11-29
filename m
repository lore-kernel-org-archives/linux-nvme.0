From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 29 Nov 2018 02:16:21 +0200
Subject: [PATCH v4 11/13] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181127231615.9446-12-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181127231615.9446-12-sagi@grimberg.me>
Message-ID: <4ad0ce00-46a6-9aff-44ba-6c4374a9386e@mellanox.com>

hi Sagi,


> +static inline void nvmet_tcp_put_cmd(struct nvmet_tcp_cmd *cmd)
> +{
> +	if (unlikely(cmd == &cmd->queue->connect))
> +		return;

if you don't return connect cmd to the list please don't add it to it in 
the first place (during alloc_cmd). and if you use it once, we might 
think of a cleaner/readable way to do it.

why there is a difference between regular cmd and connect_cmd ? can't 
you increase the nr_cmds by 1 and not distinguish between the two types ?

> +
> +	list_add_tail(&cmd->entry, &cmd->queue->free_list);
> +}
> +
> +static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
> +{
> +	return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
> +}
> +
> +static inline u8 nvmet_tcp_ddgst_len(struct nvmet_tcp_queue *queue)
> +{
> +	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
> +}
> +
> +static inline void nvmet_tcp_hdgst(struct ahash_request *hash,
> +		void *pdu, size_t len)
> +{
> +	struct scatterlist sg;
> +
> +	sg_init_one(&sg, pdu, len);
> +	ahash_request_set_crypt(hash, &sg, pdu + len, len);
> +	crypto_ahash_digest(hash);
> +}
> +
> +static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queue *queue,
> +	void *pdu, size_t len)
> +{
> +	struct nvme_tcp_hdr *hdr = pdu;
> +	__le32 recv_digest;
> +	__le32 exp_digest;
> +
> +	if (unlikely(!(hdr->flags & NVME_TCP_F_HDGST))) {
> +		pr_err("queue %d: header digest enabled but no header digest\n",
> +			queue->idx);
> +		return -EPROTO;
> +	}
> +
> +	recv_digest = *(__le32 *)(pdu + hdr->hlen);
> +	nvmet_tcp_hdgst(queue->rcv_hash, pdu, len);
> +	exp_digest = *(__le32 *)(pdu + hdr->hlen);
> +	if (recv_digest != exp_digest) {
> +		pr_err("queue %d: header digest error: recv %#x expected %#x\n",
> +			queue->idx, le32_to_cpu(recv_digest),
> +			le32_to_cpu(exp_digest));
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
> +{
> +	struct nvme_tcp_hdr *hdr = pdu;
> +	u8 digest_len = nvmet_tcp_hdgst_len(queue);
> +	u32 len;
> +
> +	len = le32_to_cpu(hdr->plen) - hdr->hlen -
> +		(hdr->flags & NVME_TCP_F_HDGST ? digest_len : 0);
> +
> +	if (unlikely(len && !(hdr->flags & NVME_TCP_F_DDGST))) {
> +		pr_err("queue %d: data digest flag is cleared\n", queue->idx);
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	sg = &cmd->req.sg[cmd->sg_idx];
> +
> +	for (i = 0; i < cmd->nr_mapped; i++)
> +		kunmap(sg_page(&sg[i]));
> +}
> +
> +static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct kvec *iov = cmd->iov;
> +	struct scatterlist *sg;
> +	u32 length, offset, sg_offset;
> +
> +	length = cmd->pdu_len;
> +	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
> +	offset = cmd->rbytes_done;
> +	cmd->sg_idx = DIV_ROUND_UP(offset, PAGE_SIZE);
> +	sg_offset = offset % PAGE_SIZE;
> +	sg = &cmd->req.sg[cmd->sg_idx];
> +
> +	while (length) {
> +		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
> +
> +		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
> +		iov->iov_len = iov_len;
> +
> +		length -= iov_len;
> +		sg = sg_next(sg);
> +		iov++;
> +	}
> +
> +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
> +		cmd->nr_mapped, cmd->pdu_len);
> +}
> +
> +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
> +{
> +	queue->rcv_state = NVMET_TCP_RECV_ERR;
> +	if (queue->nvme_sq.ctrl)
> +		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
> +	else
> +		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> +}
> +
> +static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
> +	u32 len = le32_to_cpu(sgl->length);
> +
> +	if (!cmd->req.data_len)
> +		return 0;
> +
> +	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
> +			  NVME_SGL_FMT_OFFSET)) {
> +		if (!nvme_is_write(cmd->req.cmd))
> +			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +
> +		if (len > cmd->req.port->inline_data_size)
> +			return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
> +		cmd->pdu_len = len;
> +	}
> +	cmd->req.transfer_len += len;
> +
> +	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
> +	if (!cmd->req.sg)
> +		return NVME_SC_INTERNAL;
> +	cmd->cur_sg = cmd->req.sg;
> +
> +	if (nvmet_tcp_has_data_in(cmd)) {
> +		cmd->iov = kmalloc_array(cmd->req.sg_cnt,
> +				sizeof(*cmd->iov), GFP_KERNEL);
> +		if (!cmd->iov)
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	sgl_free(cmd->req.sg);
> +	return NVME_SC_INTERNAL;
> +}
> +
> +static void nvmet_tcp_ddgst(struct ahash_request *hash,
> +		struct nvmet_tcp_cmd *cmd)
> +{
> +	ahash_request_set_crypt(hash, cmd->req.sg,
> +		(void *)&cmd->exp_ddgst, cmd->req.transfer_len);
> +	crypto_ahash_digest(hash);
> +}
> +
> +static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu;
> +	struct nvmet_tcp_queue *queue = cmd->queue;
> +	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
> +	u8 ddgst = nvmet_tcp_ddgst_len(cmd->queue);
> +
> +	cmd->offset = 0;
> +	cmd->state = NVMET_TCP_SEND_DATA_PDU;
> +
> +	pdu->hdr.type = nvme_tcp_c2h_data;
> +	pdu->hdr.flags = NVME_TCP_F_DATA_LAST;
> +	pdu->hdr.hlen = sizeof(*pdu);
> +	pdu->hdr.pdo = pdu->hdr.hlen + hdgst;
> +	pdu->hdr.plen =
> +		cpu_to_le32(pdu->hdr.hlen + hdgst +
> +				cmd->req.transfer_len + ddgst);
> +	pdu->command_id = cmd->req.rsp->command_id;
> +	pdu->data_length = cpu_to_le32(cmd->req.transfer_len);
> +	pdu->data_offset = cpu_to_le32(cmd->wbytes_done);
> +
> +	if (queue->data_digest) {
> +		pdu->hdr.flags |= NVME_TCP_F_DDGST;
> +		nvmet_tcp_ddgst(queue->snd_hash, cmd);
> +	}
> +
> +	if (cmd->queue->hdr_digest) {
> +		pdu->hdr.flags |= NVME_TCP_F_HDGST;
> +		nvmet_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
> +	}
> +}
> +
>
snip


> +static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> +		struct socket *newsock)
> +{
> +	struct nvmet_tcp_queue *queue;
> +	int ret;
> +
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
> +	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> +	queue->sock = newsock;
> +	queue->port = port;
> +	queue->nr_cmds = 0;
> +	spin_lock_init(&queue->state_lock);
> +	queue->state = NVMET_TCP_Q_CONNECTING;
> +	INIT_LIST_HEAD(&queue->free_list);
> +	init_llist_head(&queue->resp_list);
> +	INIT_LIST_HEAD(&queue->resp_send_list);
> +
> +	queue->idx = ida_simple_get(&nvmet_tcp_queue_ida, 0, 0, GFP_KERNEL);
> +	if (queue->idx < 0) {
> +		ret = queue->idx;
> +		goto out_free_queue;
> +	}
> +
> +	ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
> +	if (ret)
> +		goto out_ida_remove;
> +
> +	ret = nvmet_sq_init(&queue->nvme_sq);
> +	if (ret)
> +		goto out_ida_remove;

please add a goto free_connect_cmd:

nvmet_tcp_free_cmd(&queue->connect);

to avoid memory leak in error flow.

> +
> +	port->last_cpu = cpumask_next_wrap(port->last_cpu,
> +				cpu_online_mask, -1, false);
> +	queue->cpu = port->last_cpu;
> +	nvmet_prepare_receive_pdu(queue);
> +
> +	mutex_lock(&nvmet_tcp_queue_mutex);
> +	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
> +	mutex_unlock(&nvmet_tcp_queue_mutex);
> +
> +	ret = nvmet_tcp_set_queue_sock(queue);
> +	if (ret)
> +		goto out_destroy_sq;
> +
> +	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +
> +	return 0;
> +out_destroy_sq:
> +	mutex_lock(&nvmet_tcp_queue_mutex);
> +	list_del_init(&queue->queue_list);
> +	mutex_unlock(&nvmet_tcp_queue_mutex);
> +	nvmet_sq_destroy(&queue->nvme_sq);
> +out_ida_remove:
> +	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
> +out_free_queue:
> +	kfree(queue);
> +	return ret;
> +}
> +
>
