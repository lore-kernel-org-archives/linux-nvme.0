From: emilne@redhat.com (Ewan D. Milne)
Date: Fri, 10 Aug 2018 16:50:29 -0400
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <20180809234814.14680-1-jsmart2021@gmail.com>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
Message-ID: <1533934229.7802.149.camel@localhost.localdomain>

OK, so with this patch applied on the target, I'm seeing undesirable
behavior on the NVMe/FC initiator side when the target is not configured.

Without this patch, if the NVMe/FC initiator and the NVMe/FC soft target
are booted, but the target is not configured, an attempt to connect on
the initiator via "nvme connect" will return from the CLI immediately,
and the connection attempts will commence, e.g.:

[  191.233854] nvme nvme1: Connect Invalid Data Parameter, subsysnqn "testnqn"
[  191.241650] nvme nvme1: NVME-FC{0}: reset: Reconnect attempt failed (16770)
[  191.249421] nvme nvme1: NVME-FC{0}: Reconnect attempt in 10 seconds

then if I configure the target, it will connect.  Great.

[  241.612730] nvme nvme1: NVME-FC{0}: controller connect complete

--

However, with this patch applied on the target, the nvme-cli connect
command on the intiator (with an unconfigured target) hangs:

[ 1516.041039] nvme            D ffff942449a1e970     0  1850   1849 0x00000080
[ 1516.048924] Call Trace:
[ 1516.051650]  [<ffffffffa46e1a88>] ? enqueue_task_fair+0x208/0x6c0
[ 1516.058451]  [<ffffffffa4d5fea9>] schedule+0x29/0x70
[ 1516.063989]  [<ffffffffa4d5d7f1>] schedule_timeout+0x221/0x2d0
[ 1516.070498]  [<ffffffffa46d1e2f>] ? ttwu_do_activate+0x6f/0x80
[ 1516.077017]  [<ffffffffa46d55b0>] ? try_to_wake_up+0x190/0x390
[ 1516.083525]  [<ffffffffa4d6025d>] wait_for_completion+0xfd/0x140
[ 1516.090228]  [<ffffffffa46d5870>] ? wake_up_state+0x20/0x20
[ 1516.096446]  [<ffffffffa46b902d>] flush_work+0xfd/0x190
[ 1516.102276]  [<ffffffffa46b5e20>] ? move_linked_works+0x90/0x90
[ 1516.108882]  [<ffffffffa46b92ef>] flush_delayed_work+0x3f/0x50
[ 1516.115429]  [<ffffffffc00c0cbd>] nvme_fc_create_ctrl+0x72d/0x7a0 [nvme_fc]
[ 1516.123201]  [<ffffffffc011c5b6>] nvmf_dev_write+0xa26/0xbef [nvme_fabrics]
[ 1516.130981]  [<ffffffffa48f6307>] ? security_file_permission+0x27/0xa0
[ 1516.138265]  [<ffffffffa483eba0>] vfs_write+0xc0/0x1f0
[ 1516.143997]  [<ffffffffa483f9bf>] SyS_write+0x7f/0xf0
[ 1516.149633]  [<ffffffffa4d6cdef>] system_call_fastpath+0x1c/0x21

[ 1508.006831] kworker/u384:3  D ffff94244dcad7e0     0   578      2 0x00000000
[ 1508.014736] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
[ 1508.021642] Call Trace:
[ 1508.024368]  [<ffffffffa4d5fea9>] schedule+0x29/0x70
[ 1508.029907]  [<ffffffffa4d5d738>] schedule_timeout+0x168/0x2d0
[ 1508.036422]  [<ffffffffa46a83f0>] ? __internal_add_timer+0x130/0x130
[ 1508.043515]  [<ffffffffa46ffc02>] ? ktime_get_ts64+0x52/0xf0
[ 1508.049847]  [<ffffffffa4d5f3bd>] io_schedule_timeout+0xad/0x130
[ 1508.056551]  [<ffffffffa4d603a5>] wait_for_completion_io_timeout+0x105/0x140
[ 1508.064421]  [<ffffffffa46d5870>] ? wake_up_state+0x20/0x20
[ 1508.070674]  [<ffffffffa494869b>] blk_execute_rq+0xab/0x150
[ 1508.076897]  [<ffffffffc00cd8cf>] __nvme_submit_sync_cmd+0x6f/0xf0 [nvme_core]
[ 1508.084958]  [<ffffffffc011b908>] nvmf_connect_admin_queue+0x128/0x1a0 [nvme_fabrics]
[ 1508.093718]  [<ffffffffc00bfac0>] nvme_fc_create_association+0x3a0/0x9c0 [nvme_fc]
[ 1508.102167]  [<ffffffffc00c00fe>] nvme_fc_connect_ctrl_work+0x1e/0x60 [nvme_fc]
[ 1508.110323]  [<ffffffffa46b88af>] process_one_work+0x17f/0x440
[ 1508.116831]  [<ffffffffa46b9a98>] worker_thread+0x278/0x3c0
[ 1508.123050]  [<ffffffffa46b9820>] ? manage_workers.isra.24+0x2a0/0x2a0
[ 1508.130333]  [<ffffffffa46c0a31>] kthread+0xd1/0xe0
[ 1508.135774]  [<ffffffffa46c0960>] ? insert_kthread_work+0x40/0x40
[ 1508.142574]  [<ffffffffa4d6cc37>] ret_from_fork_nospec_begin+0x21/0x21
[ 1508.149859]  [<ffffffffa46c0960>] ? insert_kthread_work+0x40/0x40

configuring the target does not help at this point.

I've haven't figured out exactly what is wrong yet, but thought I'd
bring this up...

Clearly, separate from the target side issue, having the initiator hang
regardless of what the target code is doing is a bad thing.  There's
supposed to be an admin queue timeout, but it didn't work here.

-Ewan

On Thu, 2018-08-09@16:48 -0700, James Smart wrote:
> Currently, if a targetport has been connected to via the nvmet
> config (in other words, the add_port() transport routine called, and
> the nvmet port pointer stored for using in upcalls on new io), and
> if the targetport is then removed (say the lldd driver decides to
> unload or fully reset its hardware) and then re-added (the lldd
> driver reloads or reinits its hardware), the port pointer has been
> lost so there's no way to continue to post commands up to nvmet
> via the transport port.
> 
> Correct by allocating a small "port context" structure that will
> be linked to by the targetport. The context will save the targetport
> WWN's and the nvmet port pointer to use for it.  Initial allocation
> will occur when the targetport is bound to via add_port. The context
> will be deallocated when remove_port() is called.  If a targetport
> is removed while nvmet has the active port context, the targetport
> will be unlinked from the port context before removal.  If a new
> targetport is registered, the port contexts without a binding are
> looked through and if the WWN's match (so it's the same as nvmet's
> port context) the port context is linked to the new target port.
> Thus new io can be received on the new targetport and operation
> resumes with nvmet.
> 
> Additionally, this also resolves nvmet configuration changing out
> from underneath of the nvme-fc target port (for example: a
> nvmetcli clear).
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2:
>   v1 could upcall with nvmet port pointer null (if command received
>   after the port was removed from nvmet). Added check at top of
>   async cmd rcv for null nvmet port and abort io on link if true.
> ---
>  drivers/nvme/target/fc.c | 128 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 120 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 5215dc48a7b7..fbbaf68ae54f 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -110,11 +110,19 @@ struct nvmet_fc_tgtport {
>  	struct list_head		ls_busylist;
>  	struct list_head		assoc_list;
>  	struct ida			assoc_cnt;
> -	struct nvmet_port		*port;
> +	struct nvmet_fc_port_entry	*pe;
>  	struct kref			ref;
>  	u32				max_sg_cnt;
>  };
>  
> +struct nvmet_fc_port_entry {
> +	struct nvmet_fc_tgtport		*tgtport;
> +	struct nvmet_port		*port;
> +	u64				node_name;
> +	u64				port_name;
> +	struct list_head		pe_list;
> +};
> +
>  struct nvmet_fc_defer_fcp_req {
>  	struct list_head		req_list;
>  	struct nvmefc_tgt_fcp_req	*fcp_req;
> @@ -132,7 +140,6 @@ struct nvmet_fc_tgt_queue {
>  	atomic_t			zrspcnt;
>  	atomic_t			rsn;
>  	spinlock_t			qlock;
> -	struct nvmet_port		*port;
>  	struct nvmet_cq			nvme_cq;
>  	struct nvmet_sq			nvme_sq;
>  	struct nvmet_fc_tgt_assoc	*assoc;
> @@ -221,6 +228,7 @@ static DEFINE_SPINLOCK(nvmet_fc_tgtlock);
>  
>  static LIST_HEAD(nvmet_fc_target_list);
>  static DEFINE_IDA(nvmet_fc_tgtport_cnt);
> +static LIST_HEAD(nvmet_fc_portentry_list);
>  
> 
>  static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
> @@ -645,7 +653,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>  	queue->qid = qid;
>  	queue->sqsize = sqsize;
>  	queue->assoc = assoc;
> -	queue->port = assoc->tgtport->port;
>  	queue->cpu = nvmet_fc_queue_to_cpu(assoc->tgtport, qid);
>  	INIT_LIST_HEAD(&queue->fod_list);
>  	INIT_LIST_HEAD(&queue->avail_defer_list);
> @@ -957,6 +964,83 @@ nvmet_fc_find_target_assoc(struct nvmet_fc_tgtport *tgtport,
>  	return ret;
>  }
>  
> +static void
> +nvmet_fc_portentry_bind(struct nvmet_fc_tgtport *tgtport,
> +			struct nvmet_fc_port_entry *pe,
> +			struct nvmet_port *port)
> +{
> +	lockdep_assert_held(&nvmet_fc_tgtlock);
> +
> +	pe->tgtport = tgtport;
> +	tgtport->pe = pe;
> +
> +	pe->port = port;
> +	port->priv = pe;
> +
> +	pe->node_name = tgtport->fc_target_port.node_name;
> +	pe->port_name = tgtport->fc_target_port.port_name;
> +	INIT_LIST_HEAD(&pe->pe_list);
> +
> +	list_add_tail(&pe->pe_list, &nvmet_fc_portentry_list);
> +}
> +
> +static void
> +nvmet_fc_portentry_unbind(struct nvmet_fc_port_entry *pe)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
> +	if (pe->tgtport)
> +		pe->tgtport->pe = NULL;
> +	list_del(&pe->pe_list);
> +	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> +}
> +
> +/*
> + * called when a targetport deregisters. Breaks the relationship
> + * with the nvmet port, but leaves the port_entry in place so that
> + * re-registration can resume operation.
> + */
> +static void
> +nvmet_fc_portentry_unbind_tgt(struct nvmet_fc_tgtport *tgtport)
> +{
> +	struct nvmet_fc_port_entry *pe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
> +	pe = tgtport->pe;
> +	if (pe)
> +		pe->tgtport = NULL;
> +	tgtport->pe = NULL;
> +	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> +}
> +
> +/*
> + * called when a new targetport is registered. Looks in the
> + * existing nvmet port_entries to see if the nvmet layer is
> + * configured for the targetport's wwn's. (the targetport existed,
> + * nvmet configured, the lldd unregistered the tgtport, and is now
> + * reregistering the same targetport).  If so, set the nvmet port
> + * port entry on the targetport.
> + */
> +static void
> +nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
> +{
> +	struct nvmet_fc_port_entry *pe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
> +	list_for_each_entry(pe, &nvmet_fc_portentry_list, pe_list) {
> +		if ((tgtport->fc_target_port.node_name == pe->node_name) &&
> +		    (tgtport->fc_target_port.port_name == pe->port_name)) {
> +			WARN_ON(pe->tgtport);
> +			tgtport->pe = pe;
> +			pe->tgtport = tgtport;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> +}
>  
>  /**
>   * nvme_fc_register_targetport - transport entry point called by an
> @@ -1034,6 +1118,8 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
>  		goto out_free_newrec;
>  	}
>  
> +	nvmet_fc_portentry_rebind_tgt(newrec);
> +
>  	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
>  	list_add_tail(&newrec->tgt_list, &nvmet_fc_target_list);
>  	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> @@ -1171,6 +1257,8 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
>  {
>  	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
>  
> +	nvmet_fc_portentry_unbind_tgt(tgtport);
> +
>  	/* terminate any outstanding associations */
>  	__nvmet_fc_free_assocs(tgtport);
>  
> @@ -2147,7 +2235,7 @@ nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req)
>  
> 
>  /*
> - * Actual processing routine for received FC-NVME LS Requests from the LLD
> + * Actual processing routine for received FC-NVME I/O Requests from the LLD
>   */
>  static void
>  nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
> @@ -2158,6 +2246,13 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>  	int ret;
>  
>  	/*
> +	 * if there is no nvmet mapping to the targetport there
> +	 * shouldn't be requests. just terminate them.
> +	 */
> +	if (!tgtport->pe)
> +		goto transport_error;
> +
> +	/*
>  	 * Fused commands are currently not supported in the linux
>  	 * implementation.
>  	 *
> @@ -2184,7 +2279,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>  
>  	fod->req.cmd = &fod->cmdiubuf.sqe;
>  	fod->req.rsp = &fod->rspiubuf.cqe;
> -	fod->req.port = fod->queue->port;
> +	fod->req.port = tgtport->pe->port;
>  
>  	/* clear any response payload */
>  	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
> @@ -2508,6 +2603,7 @@ static int
>  nvmet_fc_add_port(struct nvmet_port *port)
>  {
>  	struct nvmet_fc_tgtport *tgtport;
> +	struct nvmet_fc_port_entry *pe;
>  	struct nvmet_fc_traddr traddr = { 0L, 0L };
>  	unsigned long flags;
>  	int ret;
> @@ -2524,24 +2620,40 @@ nvmet_fc_add_port(struct nvmet_port *port)
>  	if (ret)
>  		return ret;
>  
> +	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
> +	if (!pe)
> +		return -ENOMEM;
> +
>  	ret = -ENXIO;
>  	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
>  	list_for_each_entry(tgtport, &nvmet_fc_target_list, tgt_list) {
>  		if ((tgtport->fc_target_port.node_name == traddr.nn) &&
>  		    (tgtport->fc_target_port.port_name == traddr.pn)) {
> -			tgtport->port = port;
> -			ret = 0;
> +			/* a FC port can only be 1 nvmet port id */
> +			if (!tgtport->pe) {
> +				nvmet_fc_portentry_bind(tgtport, pe, port);
> +				ret = 0;
> +			} else
> +				ret = -EALREADY;
>  			break;
>  		}
>  	}
>  	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> +
> +	if (ret)
> +		kfree(pe);
> +
>  	return ret;
>  }
>  
>  static void
>  nvmet_fc_remove_port(struct nvmet_port *port)
>  {
> -	/* nothing to do */
> +	struct nvmet_fc_port_entry *pe = port->priv;
> +
> +	nvmet_fc_portentry_unbind(pe);
> +
> +	kfree(pe);
>  }
>  
>  static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
