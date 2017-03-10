From: bkenward@solarflare.com (Bert Kenward)
Date: Fri, 10 Mar 2017 16:42:06 +0000
Subject: [PATCH RFC 2/4] nvme-fabrics: add target support for TCP transport
In-Reply-To: <20059e99-1bb5-e865-015b-1c588607718b@suse.de>
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
 <5b315c79-53a4-090d-db5e-dbbc3f333793@solarflare.com>
 <20059e99-1bb5-e865-015b-1c588607718b@suse.de>
Message-ID: <ea0c3e4b-ebe0-29f4-0cc8-38144162c93e@solarflare.com>

On 10/03/17 14:49, Johannes Thumshirn wrote:
> Hi Bert,
> 
> some initial comments inline

Thanks for all these Johannes.
 
> On 03/10/2017 12:31 PM, Bert Kenward wrote:
>> Introduce the target side of an experimental proof of concept NVMe
>> Fabrics transport running directly over TCP. This is intended to
>> provide good performance over any interface.
>>
>> At present most work is deferred to workqueues for simplicity, but
>> it may be possible to avoid this in some situations and thus reduce
>> the latency.
>>
>> Memory is currently allocated as zero-order pages. It's possible
>> that using higher order pages may be desirable, trading potential
>> allocation latency for less fragmented SKBs on transmit.
>>
>> Cc: Ripduman Sohan <rip.sohan at verrko.com>
>> Cc: Lucian Carata <lucian.carata at cl.cam.ac.uk>
>> Signed-off-by: Bert Kenward <bkenward at solarflare.com>
>> ---
> 
> Can you avoid the forward declarations?

I'll see what I can move around to do so.

> Why aren't you using an sg pool here?

An excellent question, with no good answer.... I shall change this.

>> +		pr_err("command %#x received but req_init_failed\n",
>> +				request->cmd.common.opcode);
>> +}
>> +
>> +
> 
> Nit, double newline

Thanks.
 
>> +static void connection_swork(struct work_struct *work)
>> +{
>> +	struct nvmet_tcp_connection *connection;
>> +	struct nvmet_tcp_request *request = NULL;
>> +	struct scatterlist *sg;
>> +	struct nvmet_req *req;
>> +	int count = 0;
>> +	int rc;
>> +
>> +	connection = container_of(work, struct nvmet_tcp_connection, swork);
>> +
> 
> Emulating kthreads with workqueues?

Yes, I suppose. Depending on the workload the work items may be short.
Would there not be a latency impact from using a kthread here?

>> +
>> +		if (count++ > 10) {
>> +			cond_resched();
>> +			count = 0;
>> +		}
> 
> Please re-queue yourself and don't do this cond_reched() tricks.

Makes sense, thanks.
 
>> +	connection->workqueue = alloc_ordered_workqueue("nvmet-tcp-l%04x-c%04x",
>> +			0, listener->wq_index, wq_index);
>> +	if (!connection->workqueue) {
> 
> rc =  ERR_PTR(-ENOMEM);
> goto err_free_connection;

Thanks.
 
>> +	}
>> +
>> +	listener_get(listener);
>> +
>> +	rc = nvmet_sq_init(&connection->nvme_sq);
>> +	if (rc)
>> +		goto err;
> 
> goto err_destroy_wq?

Thanks again...

> err_destroy_wq:
>> +	destroy_workqueue(connection->workqueue);
> 
> err_free_connection:

... and again.

>> +static void listener_rwork(struct work_struct *work)
>> +{
>> +	struct nvmet_tcp_listener *listener;
>> +	int count = 0;
>> +	int rc;
>> +
>> +	listener = container_of(work, struct nvmet_tcp_listener, rwork);
>> +
>> +	while (1) {
>> +		rc = listener_accept(listener);
>> +		if (rc)
>> +			break;
>> +
>> +		if (count++ > 10) {
>> +			cond_resched();
> 
> Why are you only calling cond_resched() every 10th accept?

For bad, arbitrary reasons. Would you suggest re-queueing after each
accept or continuing until there are no more connections to accept?

> [...]
> 
>> +	rc = kstrtou16(disc_addr->trsvcid, 0, &port_in);
> 
> Do you plan to allocate a well known port for NVMe over TCP?

It would make sense, yes, but that's something that would be better
handled via a standardisation process.
 
>> +/*
>> + * NVMET ops
>> + */
>> +static int nvmet_tcp_add_port(struct nvmet_port *nvmet_port)
>> +{
>> +	struct nvmet_tcp_listener *listener;
>> +	static u16 wq_index;
>> +	int rc;
>> +
>> +	if (!try_module_get(THIS_MODULE))
>> +		return -EINVAL;
>> +
>> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
>> +	if (!listener) {
> 
> goto put_module;
> 
>> +		module_put(THIS_MODULE);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	listener->wq_index = wq_index++;
>> +	listener->workqueue = alloc_ordered_workqueue("nvmet-tcp-l%04x", 0,
>> +			listener->wq_index);
>> +	if (!listener->workqueue) {
>> +		rc = -ENOMEM;
>> +		goto err;
> 
> goto free_listener;
> 
>> +	}
>> +
>> +	INIT_WORK(&listener->rwork, listener_rwork);
>> +	INIT_WORK(&listener->relwork, listener_release_work);
>> +	kref_init(&listener->kref);
>> +	listener->nvmet_port = nvmet_port;
>> +	nvmet_port->priv = listener;
>> +
>> +	rc = listener_sock_create(listener);
>> +	if (rc < 0)
>> +		goto err;
> 
> goto destroy_listener_sock;
> 
>> +
>> +	mutex_lock(&nvmet_tcp_listener_mutex);
>> +	list_add_tail(&listener->list, &nvmet_tcp_listener_list);
>> +	mutex_unlock(&nvmet_tcp_listener_mutex);
>> +
>> +	return 0;
>> +
>> +err:
> 
> destroy_listener_sock:
> 
>> +	listener_sock_destroy(listener);
> 
> free_listener:
> 
>> +	kfree(listener);
> 
> put_module:
>> +	module_put(THIS_MODULE);
>> +
>> +	return rc;
>> +}
>> +

Thanks for all the above.

>> +	if (cmpxchg(&request->state, NVMET_TCP_REQ_AWAITING_RESPONSE,
>> +		    NVMET_TCP_REQ_SENDING_RESPONSE) ==
>> +	    NVMET_TCP_REQ_AWAITING_RESPONSE)
>> +		goto valid;
>> +
>> +	if (cmpxchg(&request->state, NVMET_TCP_REQ_AWAITING_CMD,
>> +		    NVMET_TCP_REQ_SENDING_RESPONSE) ==
>> +	    NVMET_TCP_REQ_AWAITING_CMD)
>> +		goto valid;
>> +
>> +	pr_err("Unexpected request state %d\n", request->state);
>> +	return;
>> +
> 
> Can you please invert the above logic and jump to an invalid label?

Ah yes. That's rather a lot nicer.
 
>> +static int __init nvmet_tcp_init(void)
>> +{
>> +	request_cache = kmem_cache_create("nvmet_tcp_request",
>> +			sizeof(struct nvmet_tcp_request), 0, 0, NULL);
> 
> 	if (!request_cache)
> 		return -ENOMEM;

Thanks.

Bert.
