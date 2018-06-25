From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Jun 2018 18:23:50 +0300
Subject: [PATCH V2 2/2] nvmet: implement flush all support
In-Reply-To: <20180625053933.14967-3-chaitanya.kulkarni@wdc.com>
References: <20180625053933.14967-1-chaitanya.kulkarni@wdc.com>
 <20180625053933.14967-3-chaitanya.kulkarni@wdc.com>
Message-ID: <b5678aff-de24-31ee-643e-3571e5e6d26d@grimberg.me>



On 06/25/2018 08:39 AM, Chaitanya Kulkarni wrote:
> This patch implements the flush command behavior described in
> "NVMe 1.3a  TP 4035" for NSID value of FFFFFFFFh. Now flush command
> applies to all the namespaces attached to the controller processing the
> Flush command when the value 0xFFFFFFFF is set in the NSID field.
> 
> We introduce a new structure "nvmet_flush_work" for executing flush
> commands on the several namespaces simultaneously, for that we also add
> a new nvmet_subsys member to keep the track of currently active namespace
> "active_ns". We update this "active_ns" member in
> nvmet_ns_enable()/nvmet_ns_disable(). For each namespace, we create
> a nvmet_flush_work object and assign appropriate call back based on the
> ns-type, i.e. bdev or file and issue it through high priority system
> workqueue.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/target/admin-cmd.c   |  2 +-
>   drivers/nvme/target/core.c        | 70 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/io-cmd-bdev.c | 29 ++++++++++++-
>   drivers/nvme/target/io-cmd-file.c | 14 +++++++
>   drivers/nvme/target/nvmet.h       | 16 +++++++
>   5 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index e2c6f8b39388..2ad52e5cdaed 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -256,7 +256,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   			NVME_CTRL_ONCS_WRITE_ZEROES);
>   
>   	/* XXX: don't report vwc if the underlying device is write through */
> -	id->vwc = NVME_CTRL_VWC_PRESENT;
> +	id->vwc = NVME_CTRL_VWC_PRESENT | 1 << 2 | 1 << 1;
>   
>   	/*
>   	 * We can't support atomic writes bigger than a LBA without support
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index f0e8b8250344..6b7529cc592b 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -371,6 +371,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
>   	}
>   
> +	subsys->active_ns++;
>   	nvmet_ns_changed(subsys, ns->nsid);
>   	ns->enabled = true;
>   	ret = 0;
> @@ -412,6 +413,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>   	mutex_lock(&subsys->lock);
>   	nvmet_ns_changed(subsys, ns->nsid);
>   	nvmet_ns_dev_disable(ns);
> +	subsys->active_ns--;
>   out_unlock:
>   	mutex_unlock(&subsys->lock);
>   }
> @@ -544,6 +546,67 @@ int nvmet_sq_init(struct nvmet_sq *sq)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_sq_init);
>   
> +static void nvmet_flush_all_work(struct work_struct *w)
> +{
> +	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
> +	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
> +	struct nvmet_flush_work *work;
> +	u16 status = NVME_SC_SUCCESS;
> +	struct nvmet_ns *ns;
> +	int cnt = 0, i;
> +	int max_ns;
> +
> +	req->ns = NULL;
> +
> +	mutex_lock(&subsys->lock);
> +	max_ns = subsys->active_ns;
> +	mutex_unlock(&subsys->lock);

newline here.

> +	work = kmalloc_array(max_ns, sizeof(*work), GFP_KERNEL);
> +	if (!work) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ns, &subsys->namespaces, dev_link) {
> +		/* only process namespaces present prior to flush command */
> +		if (cnt > max_ns)
> +			break;
> +		percpu_ref_get(&ns->ref);
> +		rcu_read_unlock();

why unlock/lock inside the iteration? nothing here can possible block.

> +
> +		work[cnt].req.ns = ns;
> +		work[cnt].req.cmd = req->cmd;
> +		work[cnt].status = 0;
> +		if (ns->file)
> +			INIT_WORK(&work[cnt].work, nvmet_file_flush_all_work);
> +		else
> +			INIT_WORK(&work[cnt].work, nvmet_bdev_flush_all_work);
> +
> +		queue_work(system_highpri_wq, &work[cnt].work);
> +		cnt++;
> +		rcu_read_lock();
> +	}
> +	rcu_read_unlock();
> +
> +	flush_workqueue(system_highpri_wq);

I say lets keep the system_wq like we normally have done for file flush
so far...

> +
> +	for (i = 0; i < cnt; i++) {

flush each work as you iterate, no need to flush the entire workqueue.

> +		if (work[i].status)

warning/error print?

> +			status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		percpu_ref_put(&work[i].req.ns->ref);
> +	}
> +	kfree(work);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +static void nvmet_execute_flush_all(struct nvmet_req *req)
> +{
> +	INIT_WORK(&req->work, nvmet_flush_all_work);
> +	schedule_work(&req->work);
> +}
> +
>   static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>   {
>   	struct nvme_command *cmd = req->cmd;
> @@ -553,6 +616,12 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>   	if (unlikely(ret))
>   		return ret;
>   
> +	if (unlikely(nvmet_cmd_flush_all(req))) {
> +		req->execute = nvmet_execute_flush_all;
> +		req->data_len = 0;
> +		return NVME_SC_SUCCESS;
> +	}
> +
>   	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
>   	if (unlikely(!req->ns))
>   		return NVME_SC_INVALID_NS | NVME_SC_DNR;
> @@ -1077,6 +1146,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   	INIT_LIST_HEAD(&subsys->namespaces);
>   	INIT_LIST_HEAD(&subsys->ctrls);
>   	INIT_LIST_HEAD(&subsys->hosts);
> +	subsys->active_ns = 0;
>   
>   	return subsys;
>   }
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index e0b0f7df70c2..1edbea435982 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -48,6 +48,15 @@ static void nvmet_bio_done(struct bio *bio)
>   {
>   	struct nvmet_req *req = bio->bi_private;
>   
> +	if (unlikely(nvmet_cmd_flush_all(req))) {
> +		struct nvmet_flush_work *w =
> +			container_of(req, struct nvmet_flush_work, req);
> +
> +		if (req->b.inline_bio.bi_status)
> +			w->status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		return;
> +	}
> +
>   	nvmet_req_complete(req,
>   		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
>   
> @@ -111,7 +120,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
>   }
>   
> -static void nvmet_bdev_execute_flush(struct nvmet_req *req)
> +static struct bio *nvmet_bdev_init_flush_bio(struct nvmet_req *req)
>   {
>   	struct bio *bio = &req->b.inline_bio;
>   
> @@ -121,6 +130,24 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>   	bio->bi_end_io = nvmet_bio_done;
>   	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
>   
> +	return bio;
> +}
> +
> +static void nvmet_bdev_execute_flush(struct nvmet_req *req)
> +{
> +	struct bio *bio = nvmet_bdev_init_flush_bio(req);
> +
> +	submit_bio(bio);
> +}
> +
> +void nvmet_bdev_flush_all_work(struct work_struct *work)
> +{
> +	struct nvmet_flush_work *w =
> +		container_of(work, struct nvmet_flush_work, work);
> +	struct nvmet_req *req = &w->req;
> +	struct bio *bio;
> +
> +	bio = nvmet_bdev_init_flush_bio(req);

Is this reusing the req->bio for multiple submissions?

I don't think that submit_bio needs to be executed from a work context.

>   	submit_bio(bio);
>   }
>   
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index b59b6e73d09a..4fcf4cd938d8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -207,6 +207,20 @@ static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
>   	queue_work(file_wq, &req->work);
>   }
>   
> +void nvmet_file_flush_all_work(struct work_struct *work)
> +{
> +	struct nvmet_flush_work *w =
> +		container_of(work, struct nvmet_flush_work, work);
> +	struct nvmet_req *req = &w->req;
> +	u16 status = NVME_SC_SUCCESS;
> +	int ret;
> +
> +	ret = vfs_fsync(req->ns->file, 1);
> +	if (ret < 0)
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +	w->status = status;
> +}
> +
>   static void nvmet_file_flush_work(struct work_struct *w)
>   {
>   	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 7f599496c8e9..1af564aae56c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -168,6 +168,7 @@ struct nvmet_subsys {
>   
>   	struct list_head	namespaces;
>   	unsigned int		max_nsid;
> +	unsigned int		active_ns;
>   
>   	struct list_head	ctrls;
>   
> @@ -298,6 +299,12 @@ struct nvmet_async_event {
>   	u8			log_page;
>   };
>   
> +struct nvmet_flush_work {
> +	struct work_struct	work;
> +	struct nvmet_req	req;
> +	u16			status;
> +};

Something doesn't make sense to me. req has a work in it, and also
status. Why do you need this structure and not simply allocate
reqs array instead?

--
+static void nvmet_flush_all_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_req *r, *reqs;
+	u16 status = NVME_SC_SUCCESS;
+	struct nvmet_ns *ns;
+	int cnt = 0, i;
+	int max_ns;
+
+	req->ns = NULL;
+
+	mutex_lock(&subsys->lock);
+	max_ns = subsys->active_ns;
+	mutex_unlock(&subsys->lock);
+
+	reqs = kmalloc_array(max_ns, sizeof(*req), GFP_KERNEL);
+	if (!work) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &subsys->namespaces, dev_link) {
+		/* only process namespaces present prior to flush command */
+		if (cnt > max_ns)
+			break;
+
+		percpu_ref_get(&ns->ref);
+		r = reqs[cnt];
+		r->ns = ns;
+		r->cmd = req->cmd;
+		r->rsp.status = 0;
+		if (ns->file)
+			INIT_WORK(&r->work, nvmet_file_flush_all_work);
+		else
+			INIT_WORK(&r->work, nvmet_bdev_flush_all_work);
+
+		schedule_work(&r->work);
+		cnt++;
+	}
+	rcu_read_unlock();
+
+	for (i = 0; i < cnt; i++) {
+		r = reqs[i];
+
+		flush_scheduled_work(&r->work);
+		if (r->rsp.status)
+			status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		percpu_ref_put(&r->ns->ref);
+	}
+	kfree(work);
+out:
+	nvmet_req_complete(req, status);
+}
--
