From: nirranjan@chelsio.com (Nirranjan Kirubaharan)
Date: Thu, 23 May 2019 21:43:43 -0700
Subject: [PATCH] nvme-rdma: Fix a NULL deref when lesser io queues are
 allocated.
In-Reply-To: <033ac067-29b1-30ff-6ad0-5e13510649bd@mellanox.com>
References: <2936d0e0de627fce13f78fca2ef93960aab0d929.1558534119.git.nirranjan@chelsio.com>
 <bf05c7f8-7a97-5e67-3476-b92c698a23a9@mellanox.com>
 <20190523075524.GA15479@chelsio.com>
 <06d347cc-7df6-c2b3-2edf-88a53db3c12d@mellanox.com>
 <20190523114157.GA9479@chelsio.com>
 <033ac067-29b1-30ff-6ad0-5e13510649bd@mellanox.com>
Message-ID: <20190524044341.GA5129@chelsio.com>

On Thursday, May 05/23/19, 2019@17:35:09 +0300, Max Gurtovoy wrote:
> I'll take deeper look on it next week but please try the new attached patch
This new patch holds good for the minimal testing I did, with target allocating
lesser queues.

> 
> On 5/23/2019 2:41 PM, Nirranjan Kirubaharan wrote:
> >On Thursday, May 05/23/19, 2019@14:14:25 +0300, Max Gurtovoy wrote:
> >>I see.
> >>
> >>probably we need to review again read/write/poll queues patches.
> >>
> >>can you try the attached untested patch ?
> >Using the attached patch, it works if I dont use the write/poll queues,
> >even when target allocates lesser queues.
> >
> >I see the below panic, if I use poll queues with target allocating
> >less than the requested queues.
> >
> >[161557.300219] RIP: 0010:blk_mq_map_queues+0x92/0xa0
> >[161557.312476] Code: 39 05 26 76 02 01 0f 46 c3 39 d8 74 19 89 c0 41 8b 04 84 43 89 04 bc eb a3 5b 5d 41 5c 41 5d 41 5e 31 c0 41 5f c3 89 d8 31 d2 <f7> f5 41 03 55 0c 43 89 14 bc eb 86 66 90 66 66 66 66 90 55 b8 ff
> >[161557.347031] RSP: 0018:ffffa04fc3d57ce8 EFLAGS: 00010246
> >[161557.360280] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >[161557.375517] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff924d47c11810
> >[161557.390701] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff924f143451e0
> >[161557.405828] R10: ffff924d47c03980 R11: 0000000000000000 R12: ffff924f143451e0
> >[161557.420882] R13: ffff924f14af4028 R14: 0000000000010120 R15: 0000000000000000
> >[161557.435919] FS:  00007f4566a31740(0000) GS:ffff92506fa00000(0000) knlGS:0000000000000000
> >[161557.451938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >[161557.465622] CR2: 00007ffdf1ef99d8 CR3: 000000042213a000 CR4: 00000000000006f0
> >[161557.480765] Call Trace:
> >[161557.491147]  nvme_rdma_map_queues+0x9e/0xc0 [nvme_rdma]
> >[161557.504360]  blk_mq_alloc_tag_set+0x1bd/0x2d0
> >[161557.516666]  nvme_rdma_alloc_tagset+0xd6/0x2a0 [nvme_rdma]
> >[161557.530108]  nvme_rdma_setup_ctrl+0x362/0x7a0 [nvme_rdma]
> >[161557.543410]  nvme_rdma_create_ctrl+0x29a/0x3d8 [nvme_rdma]
> >[161557.556754]  nvmf_dev_write+0xa18/0xbff [nvme_fabrics]
> >[161557.569687]  vfs_write+0xad/0x1b0
> >[161557.580718]  ksys_write+0x55/0xd0
> >[161557.591689]  do_syscall_64+0x5b/0x1b0
> >[161557.602941]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >[161557.615575] RIP: 0033:0x7f4566536c60
> >[161557.626678] Code: 73 01 c3 48 8b 0d 30 62 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 3d c3 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb 01 00 48 89 04 24
> >[161557.661257] RSP: 002b:00007ffdf1ef99d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >[161557.676897] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4566536c60
> >[161557.692124] RDX: 000000000000005c RSI: 00007ffdf1efae70 RDI: 0000000000000003
> >[161557.707378] RBP: 00007ffdf1efae70 R08: 0000000000000000 R09: 00007f45664940fd
> >[161557.722648] R10: 00007ffdf1ef95a0 R11: 0000000000000246 R12: 000000000000005c
> >[161557.737848] R13: 0000000000000037 R14: 000000000000000b R15: 000000000064f5e0
> >
> >>On 5/23/2019 10:55 AM, Nirranjan Kirubaharan wrote:
> >>>On Thursday, May 05/23/19, 2019@10:21:46 +0300, Max Gurtovoy wrote:
> >>>>On 5/23/2019 7:51 AM, Nirranjan Kirubaharan wrote:
> >>>>>Return error -ENOMEM when nvmf target allocates lesser
> >>>>>io queues than the number of io queues requested by nvmf
> >>>>>initiator.
> >>>>why can't we live with lesser queues ?
> >>>In nvme_rdma_alloc_io_queues() ctrl->io_queues[] are already filled
> >>>assuming all the requested no of queues will be allocated by the target.
> >>>
> >>>>I can demand 64K queues and the target might return 4 and it's fine
> >>>>for functionality.
> >>>>
> >>>>where is the NULL that you see ?
> >>>In nvme_rdma_init_request() accessing unallocated queue_idx of
> >>>ctrl->io_queues[] causes NULL deref.
> >>>
> >>>[  703.192172] RIP: 0010:nvme_rdma_init_request+0x31/0x140 [nvme_rdma]
> >>>[  703.192173] Code: 55 31 ed 53 48 8b 47 60 48 89 f3 48 8d 48 08 48 39 cf 0f 84 fb 00 00 00 48 03 28 48 05 f8 02 00 00 be c0 0d 00 00 48 8b 55 20 <4c> 8b 22 48 89 83 28 01 00 00 ba 40 00 00 00 48 8b 3d a9 7b 42 f4
> >>>[  703.192174] RSP: 0018:ffff9c36835bfc38 EFLAGS: 00010282
> >>>[  703.192192] RAX: ffff8eb49c8b92f8 RBX: ffff8eb5a6e50000 RCX: ffff8eb49c8b9008
> >>>[  703.192192] RDX: 0000000000000000 RSI: 0000000000000dc0 RDI: ffff8eb49c8b9008
> >>>[  703.192193] RBP: ffff8eb5ad3c50e0 R08: 00000000119b9400 R09: ffff8eb5831d9520
> >>>[  703.192194] R10: ffffc83e119b9400 R11: ffffc83e119b9800 R12: ffff8eb49c8b9008
> >>>[  703.192194] R13: ffff8eb5831d9480 R14: 0000000000000000 R15: ffff8eb5a6e50000
> >>>[  703.192195] FS:  00007fd6613bb780(0000) GS:ffff8eb5afbc0000(0000) knlGS:0000000000000000
> >>>[  703.192196] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>[  703.192197] CR2: 0000000000000000 CR3: 00000004646a4005 CR4: 00000000003606e0
> >>>[  703.192197] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>[  703.192198] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>[  703.192199] Call Trace:
> >>>[  703.192206]  blk_mq_alloc_rqs+0x1f0/0x290
> >>>[  703.192207]  __blk_mq_alloc_rq_map+0x46/0x80
> >>>[  703.192209]  blk_mq_map_swqueue+0x1dd/0x2e0
> >>>[  703.192210]  blk_mq_init_allocated_queue+0x3c8/0x430
> >>>[  703.192211]  blk_mq_init_queue+0x35/0x60
> >>>[  703.192213]  ? nvme_rdma_alloc_tagset+0x1bb/0x330 [nvme_rdma]
> >>>[  703.192214]  nvme_rdma_setup_ctrl+0x420/0x7b0 [nvme_rdma]
> >>>[  703.192215]  nvme_rdma_create_ctrl+0x29a/0x3d8 [nvme_rdma]
> >>>[  703.192218]  nvmf_dev_write+0xa18/0xbff [nvme_fabrics]
> >>>[  703.192222]  vfs_write+0xad/0x1b0
> >>>[  703.192224]  ksys_write+0x5a/0xd0
> >>>[  703.192228]  do_syscall_64+0x5b/0x180
> >>>[  703.192231]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>>[  703.192232] RIP: 0033:0x7fd660cddc60
> >>>[  703.192233] Code: 73 01 c3 48 8b 0d 30 62 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 3d c3 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb 01 00 48 89 04 24
> >>>[  703.192234] RSP: 002b:00007ffe8f58d928 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >>>[  703.192235] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd660cddc60
> >>>[  703.192236] RDX: 000000000000004d RSI: 00007ffe8f58e9a0 RDI: 0000000000000003
> >>>[  703.192236] RBP: 00007ffe8f58e9a0 R08: 00007ffe8f58e9ed R09: 00007fd660c3b0fd
> >>>[  703.192237] R10: 00000000ffffffff R11: 0000000000000246 R12: 000000000000004d
> >>>[  703.192237] R13: 000000000151a500 R14: 000000000151a600 R15: 00007ffe8f58e9e0
> >>>
> >>>>>Signed-off-by: Nirranjan Kirubaharan <nirranjan at chelsio.com>
> >>>>>Reviewed-by: Potnuri Bharat Teja <bharat at chelsio.com>
> >>>>>---
> >>>>>  drivers/nvme/host/rdma.c | 9 ++++++++-
> >>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>>
> >>>>>diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> >>>>>index f383146e7d0f..187007d136cc 100644
> >>>>>--- a/drivers/nvme/host/rdma.c
> >>>>>+++ b/drivers/nvme/host/rdma.c
> >>>>>@@ -641,7 +641,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> >>>>>  {
> >>>>>  	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> >>>>>  	struct ib_device *ibdev = ctrl->device->dev;
> >>>>>-	unsigned int nr_io_queues;
> >>>>>+	unsigned int nr_io_queues, nr_req_queues;
> >>>>>  	int i, ret;
> >>>>>  	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
> >>>>>@@ -670,9 +670,16 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> >>>>>  		nr_io_queues += ctrl->io_queues[HCTX_TYPE_POLL];
> >>>>>  	}
> >>>>>+	nr_req_queues = nr_io_queues;
> >>>>>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
> >>>>>  	if (ret)
> >>>>>  		return ret;
> >>>>>+	if (nr_io_queues < nr_req_queues) {
> >>>>>+		dev_err(ctrl->ctrl.device,
> >>>>>+			"alloc queues %u < req no of queues %u",
> >>>>>+			nr_io_queues, nr_req_queues);
> >>>>>+		return -ENOMEM;
> >>>>>+	}
> >>>>>  	ctrl->ctrl.queue_count = nr_io_queues + 1;
> >>>>>  	if (ctrl->ctrl.queue_count < 2)
> >>diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> >>index 5a4ad25..d0cc981 100644
> >>--- a/drivers/nvme/host/rdma.c
> >>+++ b/drivers/nvme/host/rdma.c
> >>@@ -641,7 +641,8 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> >>  {
> >>  	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> >>  	struct ib_device *ibdev = ctrl->device->dev;
> >>-	unsigned int nr_io_queues;
> >>+	unsigned int nr_io_queues, nr_req_queues;
> >>+	unsigned int default_queues, poll_queues = 0, write_queues = 0;
> >>  	int i, ret;
> >>  	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
> >>@@ -651,29 +652,38 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> >>  	 * optimal locality so we don't need more queues than
> >>  	 * completion vectors.
> >>  	 */
> >>-	nr_io_queues = min_t(unsigned int, nr_io_queues,
> >>-				ibdev->num_comp_vectors);
> >>+	default_queues = nr_io_queues = min_t(unsigned int, nr_io_queues,
> >>+					      ibdev->num_comp_vectors);
> >>-	if (opts->nr_write_queues) {
> >>-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> >>-				min(opts->nr_write_queues, nr_io_queues);
> >>-		nr_io_queues += ctrl->io_queues[HCTX_TYPE_DEFAULT];
> >>-	} else {
> >>-		ctrl->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
> >>-	}
> >>-
> >>-	ctrl->io_queues[HCTX_TYPE_READ] = nr_io_queues;
> >>-
> >>-	if (opts->nr_poll_queues) {
> >>-		ctrl->io_queues[HCTX_TYPE_POLL] =
> >>-			min(opts->nr_poll_queues, num_online_cpus());
> >>-		nr_io_queues += ctrl->io_queues[HCTX_TYPE_POLL];
> >>-	}
> >>+	if (opts->nr_write_queues)
> >>+		write_queues = min(opts->nr_write_queues, default_queues);
> >>+	if (opts->nr_poll_queues)
> >>+		poll_queues = min(opts->nr_poll_queues, num_online_cpus());
> >>+	nr_io_queues += write_queues + poll_queues;
> >>+	nr_req_queues = nr_io_queues;
> >>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
> >>  	if (ret)
> >>  		return ret;
> >>+	if (nr_req_queues <= nr_io_queues) {
> >>+		/* set the queues according to host demand */
> >>+		ctrl->io_queues[HCTX_TYPE_READ] = nr_req_queues - poll_queues;
> >>+		if (write_queues)
> >>+			ctrl->io_queues[HCTX_TYPE_DEFAULT] = write_queues;
> >>+		else
> >>+			ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> >>+					nr_req_queues - poll_queues;
> >>+		if (poll_queues)
> >>+			ctrl->io_queues[HCTX_TYPE_POLL] = poll_queues;
> >>+
> >>+	} else {
> >>+		/* set the queues according to controller capability */
> >>+		ctrl->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
> >>+		ctrl->io_queues[HCTX_TYPE_READ] = nr_io_queues;
> >>+		ctrl->io_queues[HCTX_TYPE_POLL] = 0;
> >>+	}
> >>+
> >>  	ctrl->ctrl.queue_count = nr_io_queues + 1;
> >>  	if (ctrl->ctrl.queue_count < 2)
> >>  		return 0;

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5ee75b5..f924451 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -247,6 +247,9 @@ struct nvme_ctrl {
>  
>  	struct page *discard_page;
>  	unsigned long discard_page_busy;
> +
> +	unsigned int nr_write_queues;
> +	unsigned int nr_poll_queues;
>  };
>  
>  enum nvme_iopolicy {
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5a4ad25..5e90e92 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -641,39 +641,56 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>  {
>  	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>  	struct ib_device *ibdev = ctrl->device->dev;
> -	unsigned int nr_io_queues;
> +	unsigned int nr_io_queues, nr_req_queues;
> +	unsigned int default_queues, poll_queues = 0, write_queues = 0;
>  	int i, ret;
>  
> -	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
> +	default_queues = min(opts->nr_io_queues, num_online_cpus());
>  
>  	/*
>  	 * we map queues according to the device irq vectors for
>  	 * optimal locality so we don't need more queues than
>  	 * completion vectors.
>  	 */
> -	nr_io_queues = min_t(unsigned int, nr_io_queues,
> -				ibdev->num_comp_vectors);
> +	default_queues = min_t(unsigned int, default_queues,
> +			       ibdev->num_comp_vectors);
>  
> -	if (opts->nr_write_queues) {
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -				min(opts->nr_write_queues, nr_io_queues);
> -		nr_io_queues += ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
> -	}
> -
> -	ctrl->io_queues[HCTX_TYPE_READ] = nr_io_queues;
> -
> -	if (opts->nr_poll_queues) {
> -		ctrl->io_queues[HCTX_TYPE_POLL] =
> -			min(opts->nr_poll_queues, num_online_cpus());
> -		nr_io_queues += ctrl->io_queues[HCTX_TYPE_POLL];
> -	}
> +	if (opts->nr_write_queues)
> +		write_queues = min(opts->nr_write_queues, default_queues);
> +	if (opts->nr_poll_queues)
> +		poll_queues = min(opts->nr_poll_queues, num_online_cpus());
>  
> +	nr_io_queues = default_queues + write_queues + poll_queues;
> +	nr_req_queues = nr_io_queues;
>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>  	if (ret)
>  		return ret;
>  
> +	if (nr_req_queues <= nr_io_queues) {
> +		/* set the queues according to host demand */
> +		ctrl->io_queues[HCTX_TYPE_READ] =
> +				nr_req_queues - poll_queues - write_queues;
> +		if (write_queues) {
> +			ctrl->io_queues[HCTX_TYPE_DEFAULT] = write_queues;
> +			ctrl->ctrl.nr_write_queues = write_queues;
> +		} else {
> +			ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> +					ctrl->io_queues[HCTX_TYPE_READ];
> +		}
> +		if (poll_queues) {
> +			ctrl->io_queues[HCTX_TYPE_POLL] = poll_queues;
> +			ctrl->ctrl.nr_poll_queues = poll_queues;
> +		}
> +		nr_io_queues = nr_req_queues;
> +	} else {
> +		/* set the queues according to controller capability */
> +		ctrl->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
> +		ctrl->io_queues[HCTX_TYPE_READ] = nr_io_queues;
> +		ctrl->io_queues[HCTX_TYPE_POLL] = 0;
> +		ctrl->ctrl.nr_write_queues = 0;
> +		ctrl->ctrl.nr_poll_queues = 0;
> +	}
> +
>  	ctrl->ctrl.queue_count = nr_io_queues + 1;
>  	if (ctrl->ctrl.queue_count < 2)
>  		return 0;
> @@ -739,7 +756,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
>  		set->driver_data = ctrl;
>  		set->nr_hw_queues = nctrl->queue_count - 1;
>  		set->timeout = NVME_IO_TIMEOUT;
> -		set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
> +		set->nr_maps = nctrl->nr_poll_queues ? HCTX_MAX_TYPES : 2;
>  	}
>  
>  	ret = blk_mq_alloc_tag_set(set);
> @@ -1791,8 +1808,7 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
>  	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
>  	set->map[HCTX_TYPE_DEFAULT].nr_queues =
>  			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	set->map[HCTX_TYPE_READ].nr_queues = ctrl->io_queues[HCTX_TYPE_READ];
> -	if (ctrl->ctrl.opts->nr_write_queues) {
> +	if (ctrl->ctrl.nr_write_queues) {
>  		/* separate read/write queues */
>  		set->map[HCTX_TYPE_READ].queue_offset =
>  				ctrl->io_queues[HCTX_TYPE_DEFAULT];
> @@ -1800,17 +1816,19 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
>  		/* mixed read/write queues */
>  		set->map[HCTX_TYPE_READ].queue_offset = 0;
>  	}
> +	set->map[HCTX_TYPE_READ].nr_queues = ctrl->io_queues[HCTX_TYPE_READ];
> +
>  	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
>  			ctrl->device->dev, 0);
>  	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
>  			ctrl->device->dev, 0);
>  
> -	if (ctrl->ctrl.opts->nr_poll_queues) {
> +	if (ctrl->ctrl.nr_poll_queues) {
>  		set->map[HCTX_TYPE_POLL].nr_queues =
>  				ctrl->io_queues[HCTX_TYPE_POLL];
>  		set->map[HCTX_TYPE_POLL].queue_offset =
>  				ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		if (ctrl->ctrl.opts->nr_write_queues)
> +		if (ctrl->ctrl.nr_write_queues)
>  			set->map[HCTX_TYPE_POLL].queue_offset +=
>  				ctrl->io_queues[HCTX_TYPE_READ];
>  		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
