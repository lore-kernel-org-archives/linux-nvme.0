From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 10 Mar 2017 15:49:02 +0100
Subject: [PATCH RFC 2/4] nvme-fabrics: add target support for TCP transport
In-Reply-To: <5b315c79-53a4-090d-db5e-dbbc3f333793@solarflare.com>
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
 <5b315c79-53a4-090d-db5e-dbbc3f333793@solarflare.com>
Message-ID: <20059e99-1bb5-e865-015b-1c588607718b@suse.de>

Hi Bert,

some initial comments inline

On 03/10/2017 12:31 PM, Bert Kenward wrote:
> Introduce the target side of an experimental proof of concept NVMe
> Fabrics transport running directly over TCP. This is intended to
> provide good performance over any interface.
> 
> At present most work is deferred to workqueues for simplicity, but
> it may be possible to avoid this in some situations and thus reduce
> the latency.
> 
> Memory is currently allocated as zero-order pages. It's possible
> that using higher order pages may be desirable, trading potential
> allocation latency for less fragmented SKBs on transmit.
> 
> Cc: Ripduman Sohan <rip.sohan at verrko.com>
> Cc: Lucian Carata <lucian.carata at cl.cam.ac.uk>
> Signed-off-by: Bert Kenward <bkenward at solarflare.com>
> ---

[...]


Can you avoid the forward declarations?


> +static int nvmet_tcp_add_port(struct nvmet_port *nvmet_port);
> +static void nvmet_tcp_remove_port(struct nvmet_port *nvmet_port);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);
> +static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl);
> +
> +static struct nvmet_fabrics_ops nvmet_tcp_ops = {
> +	.owner            = THIS_MODULE,
> +	.type             = NVMF_TRTYPE_TCP,
> +	.sqe_inline_size  = NVMET_TCP_MAX_REQ_DATA_SIZE,
> +	.msdbd            = 1,
> +	.has_keyed_sgls   = 0,
> +	.add_port         = nvmet_tcp_add_port,
> +	.remove_port      = nvmet_tcp_remove_port,
> +	.queue_response   = nvmet_tcp_queue_response,
> +	.delete_ctrl      = nvmet_tcp_delete_ctrl,
> +};

[...]

> +static int request_create_sgl(struct nvmet_tcp_request *request, u32 len,
> +		int *nents)
> +{
> +	struct scatterlist *sg;
> +	struct page *page;
> +	int page_count;
> +	int i;
> +
> +	page_count = DIV_ROUND_UP(len, PAGE_SIZE);
> +
> +	if (!page_count) {
> +		request->scatterlist = NULL;
> +		return 0;
> +	}
> +
> +	sg = kmalloc_array(page_count, sizeof(struct scatterlist), GFP_KERNEL);

Why aren't you using an sg pool here?

> +	if (!sg)
> +		return -ENOMEM;
> +
> +	sg_init_table(sg, page_count);

[...]

> +		pr_err("command %#x received but req_init_failed\n",
> +				request->cmd.common.opcode);
> +}
> +
> +

Nit, double newline

> +static int connection_recv_from_sock(struct nvmet_tcp_connection *connection,
> +		void *buf, size_t buf_len)
> +{

[...]

> +static void connection_rwork(struct work_struct *work)
> +{
> +	struct nvmet_tcp_connection *connection;
> +	int count = 0;
> +	int rc;
> +
> +	connection = container_of(work, struct nvmet_tcp_connection, rwork);
> +
> +	while (test_bit(NVMET_ACCEPT_REQUESTS, &connection->flags)) {

See comment below

[...]

> +static void connection_swork(struct work_struct *work)
> +{
> +	struct nvmet_tcp_connection *connection;
> +	struct nvmet_tcp_request *request = NULL;
> +	struct scatterlist *sg;
> +	struct nvmet_req *req;
> +	int count = 0;
> +	int rc;
> +
> +	connection = container_of(work, struct nvmet_tcp_connection, swork);
> +

Emulating kthreads with workqueues?

> +	while (test_bit(NVMET_SOCK_CONNECTED, &connection->flags)) {
> +		if (!request)

[...]

> +
> +		if (count++ > 10) {
> +			cond_resched();
> +			count = 0;
> +		}

Please re-queue yourself and don't do this cond_reched() tricks.

> +	}
> +
> +	connection_put(connection);
> +}

[...]

> +static struct nvmet_tcp_connection *connection_create(
> +		struct nvmet_tcp_listener *listener,
> +		struct socket *socket)
> +{
> +	struct nvmet_tcp_connection *connection = NULL;
> +	u16 wq_index;
> +	int rc = 0;
> +
> +	connection = kzalloc(sizeof(*connection), GFP_KERNEL);
> +	if (!connection)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&nvmet_tcp_connection_mutex);
> +	wq_index = listener->conn_wq_index++;
> +	mutex_unlock(&nvmet_tcp_connection_mutex);
> +
> +	connection->workqueue = alloc_ordered_workqueue("nvmet-tcp-l%04x-c%04x",
> +			0, listener->wq_index, wq_index);
> +	if (!connection->workqueue) {

rc =  ERR_PTR(-ENOMEM);
goto err_free_connection;

> +	}
> +
> +	listener_get(listener);
> +
> +	rc = nvmet_sq_init(&connection->nvme_sq);
> +	if (rc)
> +		goto err;

goto err_destroy_wq?

[...]


err_destroy_wq:
> +	destroy_workqueue(connection->workqueue);

err_free_connection:

> +	kfree(connection);
> +	listener_put(listener);
> +
> +	return ERR_PTR(rc);
> +}
> +

[...]

> +static void listener_rwork(struct work_struct *work)
> +{
> +	struct nvmet_tcp_listener *listener;
> +	int count = 0;
> +	int rc;
> +
> +	listener = container_of(work, struct nvmet_tcp_listener, rwork);
> +
> +	while (1) {
> +		rc = listener_accept(listener);
> +		if (rc)
> +			break;
> +
> +		if (count++ > 10) {
> +			cond_resched();

Why are you only calling cond_resched() every 10th accept?


[...]

> +static void listener_sock_destroy(struct nvmet_tcp_listener *listener)
> +{
> +	if (!listener->sock)
> +		return;
> +
> +	kernel_sock_shutdown(listener->sock, SHUT_RDWR);
> +	sock_release(listener->sock);
> +
> +	listener->sock = NULL;
> +}

[...]

> +	rc = kstrtou16(disc_addr->trsvcid, 0, &port_in);

Do you plan to allocate a well known port for NVMe over TCP?


[...]

> +/*
> + * NVMET ops
> + */
> +static int nvmet_tcp_add_port(struct nvmet_port *nvmet_port)
> +{
> +	struct nvmet_tcp_listener *listener;
> +	static u16 wq_index;
> +	int rc;
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -EINVAL;
> +
> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
> +	if (!listener) {

goto put_module;

> +		module_put(THIS_MODULE);
> +		return -ENOMEM;
> +	}
> +
> +	listener->wq_index = wq_index++;
> +	listener->workqueue = alloc_ordered_workqueue("nvmet-tcp-l%04x", 0,
> +			listener->wq_index);
> +	if (!listener->workqueue) {
> +		rc = -ENOMEM;
> +		goto err;

goto free_listener;

> +	}
> +
> +	INIT_WORK(&listener->rwork, listener_rwork);
> +	INIT_WORK(&listener->relwork, listener_release_work);
> +	kref_init(&listener->kref);
> +	listener->nvmet_port = nvmet_port;
> +	nvmet_port->priv = listener;
> +
> +	rc = listener_sock_create(listener);
> +	if (rc < 0)
> +		goto err;

goto destroy_listener_sock;

> +
> +	mutex_lock(&nvmet_tcp_listener_mutex);
> +	list_add_tail(&listener->list, &nvmet_tcp_listener_list);
> +	mutex_unlock(&nvmet_tcp_listener_mutex);
> +
> +	return 0;
> +
> +err:

destroy_listener_sock:

> +	listener_sock_destroy(listener);

free_listener:

> +	kfree(listener);

put_module:
> +	module_put(THIS_MODULE);
> +
> +	return rc;
> +}
> +

[...]

> +	if (cmpxchg(&request->state, NVMET_TCP_REQ_AWAITING_RESPONSE,
> +		    NVMET_TCP_REQ_SENDING_RESPONSE) ==
> +	    NVMET_TCP_REQ_AWAITING_RESPONSE)
> +		goto valid;
> +
> +	if (cmpxchg(&request->state, NVMET_TCP_REQ_AWAITING_CMD,
> +		    NVMET_TCP_REQ_SENDING_RESPONSE) ==
> +	    NVMET_TCP_REQ_AWAITING_CMD)
> +		goto valid;
> +
> +	pr_err("Unexpected request state %d\n", request->state);
> +	return;
> +

Can you please invert the above logic and jump to an invalid label?

[...]

> +static int __init nvmet_tcp_init(void)
> +{
> +	request_cache = kmem_cache_create("nvmet_tcp_request",
> +			sizeof(struct nvmet_tcp_request), 0, 0, NULL);

	if (!request_cache)
		return -ENOMEM;




-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
