From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Nov 2018 10:06:55 +0100
Subject: [PATCH v3 11/13] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181122015615.15763-12-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-12-sagi@grimberg.me>
Message-ID: <20181122090655.GA27707@lst.de>

> +enum nvmet_tcp_send_state {
> +	NVMET_TCP_SEND_DATA_PDU = 0,
> +	NVMET_TCP_SEND_DATA,
> +	NVMET_TCP_SEND_R2T,
> +	NVMET_TCP_SEND_DDGST,
> +	NVMET_TCP_SEND_RESPONSE
> +};
> +
> +enum nvmet_tcp_recv_state {
> +	NVMET_TCP_RECV_PDU,
> +	NVMET_TCP_RECV_DATA,
> +	NVMET_TCP_RECV_DDGST,
> +	NVMET_TCP_RECV_ERR,
> +};

I think you can drop the explicit initialization for
NVMET_TCP_SEND_DATA_PDU.

> +struct nvmet_tcp_recv_ctx {
> +};

There are no users of this empty struct, so it can probably be
dropped..

> +	void (*dr)(struct sock *);
> +	void (*sc)(struct sock *);
> +	void (*ws)(struct sock *);

These looks very cryptic.  Can you please at least spell out the
full names as used in the networking code (data_ready, etc).

> +struct nvmet_tcp_port {
> +	struct socket		*sock;
> +	struct work_struct	accept_work;
> +	struct nvmet_port	*nport;
> +	struct sockaddr_storage addr;
> +	int			last_cpu;
> +	void (*dr)(struct sock *);
> +};

Same here.

> +	pdu->hdr.plen =
> +		cpu_to_le32(pdu->hdr.hlen + hdgst + cmd->req.transfer_len + ddgst);

Overly long line.

> +static struct nvmet_tcp_cmd *nvmet_tcp_reverse_list(struct nvmet_tcp_queue *queue, struct llist_node *node)

Way too long line.

Also this function does not reverse a list, it removes from a llist,
adds to a regular list in reverse order and increments a counter.  Maybe
there is a better name?  It would also seem more readable if the
llist_del_all from the caller moved in here.

> +{
> +	struct nvmet_tcp_cmd *cmd;
> +
> +	while (node) {
> +		struct nvmet_tcp_cmd *cmd = container_of(node, struct nvmet_tcp_cmd, lentry);
> +

Also shouldn't this use llist_entry instead of container_of to document
the intent?

> +		list_add(&cmd->entry, &queue->resp_send_list);
> +		node = node->next;
> +		queue->send_list_len++;
> +	}
> +
> +	cmd = list_first_entry(&queue->resp_send_list, struct nvmet_tcp_cmd, entry);
> +	return cmd;

Besides the way too long line this can be a direct return.  Then
again moving the assignment of this in would probably make sense
as well.

> +}
> +
> +static struct nvmet_tcp_cmd *nvmet_tcp_fetch_send_command(struct nvmet_tcp_queue *queue)

Another way too long line.  Please just fix this up everwhere.

> +	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +		cmd = nvmet_tcp_fetch_send_command(queue);
> +		if (unlikely(!cmd))
> +			return 0;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
> +		ret = nvmet_try_send_data_pdu(cmd);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_DATA) {
> +		ret = nvmet_try_send_data(cmd);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_DDGST) {
> +		ret = nvmet_try_send_ddgst(cmd);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_R2T) {
> +		ret = nvmet_try_send_r2t(cmd, last_in_batch);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_RESPONSE)
> +		ret = nvmet_try_send_response(cmd, last_in_batch);

Use a switch statement?

> +	if (queue->left) {
> +		return -EAGAIN;
> +	} else if (queue->offset == sizeof(struct nvme_tcp_hdr)) {

No need for an else after a return.

> +
> +	if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR))
> +		return 0;
> +
> +	if (queue->rcv_state == NVMET_TCP_RECV_PDU) {
> +		result = nvmet_tcp_try_recv_pdu(queue);
> +		if (result != 0)
> +			goto done_recv;
> +	}
> +
> +	if (queue->rcv_state == NVMET_TCP_RECV_DATA) {
> +		result = nvmet_tcp_try_recv_data(queue);
> +		if (result != 0)
> +			goto done_recv;
> +	}
> +
> +	if (queue->rcv_state == NVMET_TCP_RECV_DDGST) {
> +		result = nvmet_tcp_try_recv_ddgst(queue);
> +		if (result != 0)
> +			goto done_recv;
> +	}

switch statement?

> +	spin_lock(&queue->state_lock);
> +	if (queue->state == NVMET_TCP_Q_DISCONNECTING)
> +		goto out;
> +
> +	queue->state = NVMET_TCP_Q_DISCONNECTING;
> +	schedule_work(&queue->release_work);
> +out:
> +	spin_unlock(&queue->state_lock);

No real need for the goto here.

> +static void nvmet_tcp_data_ready(struct sock *sk)
> +{
> +	struct nvmet_tcp_queue *queue;
> +
> +	read_lock_bh(&sk->sk_callback_lock);
> +	queue = sk->sk_user_data;
> +	if (!queue)
> +		goto out;
> +
> +	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +out:
> +	read_unlock_bh(&sk->sk_callback_lock);
> +}

This should only need rcu_read_proctection, right?

Also no need for the goto.
