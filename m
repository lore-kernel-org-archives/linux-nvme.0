From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 27 Dec 2017 14:20:55 +0800
Subject: [PATCH v2] nvme-pci: allocate device queues storage space at probe
In-Reply-To: <20171225120526.29303-1-sagi@grimberg.me>
References: <20171225120526.29303-1-sagi@grimberg.me>
Message-ID: <20171227062048.GA27546@ming.t460p>

On Mon, Dec 25, 2017@02:05:26PM +0200, Sagi Grimberg wrote:
> It may cause race by setting 'nvmeq' in nvme_init_request()
> because .init_request is called inside switching io scheduler, which
> may happen when the NVMe device is being resetted and its nvme queues
> are being freed and created. We don't have any sync between the two
> pathes.
> 
> This patch changes the nvmeq allocation to occur at probe time so
> there is no way we can dereference it at init_request. Also modify
> nvme_alloc_queue to return a status value instead of the nvmeq itself
> (since it no longer allocates the nvme_queue struct).
> 
> [   93.268391] kernel BUG at drivers/nvme/host/pci.c:408!
> [   93.274146] invalid opcode: 0000 [#1] SMP
> [   93.278618] Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace fscache sunrpc ipmi_ssif vfat fat
> intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
> kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iTCO_wdt
> intel_cstate ipmi_si iTCO_vendor_support intel_uncore mxm_wmi mei_me
> ipmi_devintf intel_rapl_perf pcspkr sg ipmi_msghandler lpc_ich dcdbas mei
> shpchp acpi_power_meter wmi dm_multipath ip_tables xfs libcrc32c sd_mod
> mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops ttm drm ahci libahci nvme libata crc32c_intel nvme_core tg3
> megaraid_sas ptp i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
> [   93.349071] CPU: 5 PID: 1842 Comm: sh Not tainted 4.15.0-rc2.ming+ #4
> [   93.356256] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
> [   93.364801] task: 00000000fb8abf2a task.stack: 0000000028bd82d1
> [   93.371408] RIP: 0010:nvme_init_request+0x36/0x40 [nvme]
> [   93.377333] RSP: 0018:ffffc90002537ca8 EFLAGS: 00010246
> [   93.383161] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
> [   93.391122] RDX: 0000000000000000 RSI: ffff880276ae0000 RDI: ffff88047bae9008
> [   93.399084] RBP: ffff88047bae9008 R08: ffff88047bae9008 R09: 0000000009dabc00
> [   93.407045] R10: 0000000000000004 R11: 000000000000299c R12: ffff880186bc1f00
> [   93.415007] R13: ffff880276ae0000 R14: 0000000000000000 R15: 0000000000000071
> [   93.422969] FS:  00007f33cf288740(0000) GS:ffff88047ba80000(0000) knlGS:0000000000000000
> [   93.431996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   93.438407] CR2: 00007f33cf28e000 CR3: 000000047e5bb006 CR4: 00000000001606e0
> [   93.446368] Call Trace:
> [   93.449103]  blk_mq_alloc_rqs+0x231/0x2a0
> [   93.453579]  blk_mq_sched_alloc_tags.isra.8+0x42/0x80
> [   93.459214]  blk_mq_init_sched+0x7e/0x140
> [   93.463687]  elevator_switch+0x5a/0x1f0
> [   93.467966]  ? elevator_get.isra.17+0x52/0xc0
> [   93.472826]  elv_iosched_store+0xde/0x150
> [   93.477299]  queue_attr_store+0x4e/0x90
> [   93.481580]  kernfs_fop_write+0xfa/0x180
> [   93.485958]  __vfs_write+0x33/0x170
> [   93.489851]  ? __inode_security_revalidate+0x4c/0x60
> [   93.495390]  ? selinux_file_permission+0xda/0x130
> [   93.500641]  ? _cond_resched+0x15/0x30
> [   93.504815]  vfs_write+0xad/0x1a0
> [   93.508512]  SyS_write+0x52/0xc0
> [   93.512113]  do_syscall_64+0x61/0x1a0
> [   93.516199]  entry_SYSCALL64_slow_path+0x25/0x25
> [   93.521351] RIP: 0033:0x7f33ce96aab0
> [   93.525337] RSP: 002b:00007ffe57570238 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   93.533785] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f33ce96aab0
> [   93.541746] RDX: 0000000000000006 RSI: 00007f33cf28e000 RDI: 0000000000000001
> [   93.549707] RBP: 00007f33cf28e000 R08: 000000000000000a R09: 00007f33cf288740
> [   93.557669] R10: 00007f33cf288740 R11: 0000000000000246 R12: 00007f33cec42400
> [   93.565630] R13: 0000000000000006 R14: 0000000000000001 R15: 0000000000000000
> [   93.573592] Code: 4c 8d 40 08 4c 39 c7 74 16 48 8b 00 48 8b 04 08 48 85 c0
> 74 16 48 89 86 78 01 00 00 31 c0 c3 8d 4a 01 48 63 c9 48 c1 e1 03 eb de <0f>
> 0b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 f6 53 48 89
> [   93.594676] RIP: nvme_init_request+0x36/0x40 [nvme] RSP: ffffc90002537ca8
> [   93.602273] ---[ end trace 810dde3993e5f14e ]---
> 
> Reported-by: Yi Zhang <yi.zhang at redhat.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Changes from v1:
> - removed left-over kfree of nvmeq in nvme_free_queue
> - change nvme_alloc_queue to return status value instead of nvmeq pointer
> - removed the old condition of existance of nvmeq before calling nvme_alloc_queue
>   for the admin queue (which assumed nvme_alloc_queue is allocating the nvmeq storage space)
> 
>  drivers/nvme/host/pci.c | 63 ++++++++++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f26aaa393016..48c5fb864a61 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -75,7 +75,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
>   * Represents an NVM Express device.  Each nvme_dev is a PCI function.
>   */
>  struct nvme_dev {
> -	struct nvme_queue **queues;
> +	struct nvme_queue *queues;
>  	struct blk_mq_tag_set tagset;
>  	struct blk_mq_tag_set admin_tagset;
>  	u32 __iomem *dbs;
> @@ -365,7 +365,7 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>  				unsigned int hctx_idx)
>  {
>  	struct nvme_dev *dev = data;
> -	struct nvme_queue *nvmeq = dev->queues[0];
> +	struct nvme_queue *nvmeq = &dev->queues[0];
>  
>  	WARN_ON(hctx_idx != 0);
>  	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
> @@ -387,7 +387,7 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>  			  unsigned int hctx_idx)
>  {
>  	struct nvme_dev *dev = data;
> -	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
> +	struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];
>  
>  	if (!nvmeq->tags)
>  		nvmeq->tags = &dev->tagset.tags[hctx_idx];
> @@ -403,7 +403,7 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
>  	struct nvme_dev *dev = set->driver_data;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	int queue_idx = (set == &dev->tagset) ? hctx_idx + 1 : 0;
> -	struct nvme_queue *nvmeq = dev->queues[queue_idx];
> +	struct nvme_queue *nvmeq = &dev->queues[queue_idx];
>  
>  	BUG_ON(!nvmeq);
>  	iod->nvmeq = nvmeq;
> @@ -1046,7 +1046,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
>  static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_dev *dev = to_nvme_dev(ctrl);
> -	struct nvme_queue *nvmeq = dev->queues[0];
> +	struct nvme_queue *nvmeq = &dev->queues[0];
>  	struct nvme_command c;
>  
>  	memset(&c, 0, sizeof(c));
> @@ -1282,7 +1282,6 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
>  	if (nvmeq->sq_cmds)
>  		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
>  					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
> -	kfree(nvmeq);
>  }
>  
>  static void nvme_free_queues(struct nvme_dev *dev, int lowest)
> @@ -1290,10 +1289,8 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
>  	int i;
>  
>  	for (i = dev->ctrl.queue_count - 1; i >= lowest; i--) {
> -		struct nvme_queue *nvmeq = dev->queues[i];
>  		dev->ctrl.queue_count--;
> -		dev->queues[i] = NULL;
> -		nvme_free_queue(nvmeq);
> +		nvme_free_queue(&dev->queues[i]);
>  	}
>  }
>  
> @@ -1325,10 +1322,8 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
>  
>  static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
>  {
> -	struct nvme_queue *nvmeq = dev->queues[0];
> +	struct nvme_queue *nvmeq = &dev->queues[0];
>  
> -	if (!nvmeq)
> -		return;
>  	if (nvme_suspend_queue(nvmeq))
>  		return;
>  
> @@ -1384,13 +1379,10 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
>  	return 0;
>  }
>  
> -static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
> -							int depth, int node)
> +static int nvme_alloc_queue(struct nvme_dev *dev, int qid,
> +		int depth, int node)
>  {
> -	struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq), GFP_KERNEL,
> -							node);
> -	if (!nvmeq)
> -		return NULL;
> +	struct nvme_queue *nvmeq = &dev->queues[qid];
>  
>  	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
>  					  &nvmeq->cq_dma_addr, GFP_KERNEL);
> @@ -1409,17 +1401,15 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>  	nvmeq->q_depth = depth;
>  	nvmeq->qid = qid;
>  	nvmeq->cq_vector = -1;
> -	dev->queues[qid] = nvmeq;
>  	dev->ctrl.queue_count++;
>  
> -	return nvmeq;
> +	return 0;
>  
>   free_cqdma:
>  	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq->cqes,
>  							nvmeq->cq_dma_addr);
>   free_nvmeq:
> -	kfree(nvmeq);
> -	return NULL;
> +	return -ENOMEM;
>  }
>  
>  static int queue_request_irq(struct nvme_queue *nvmeq)
> @@ -1592,14 +1582,12 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
>  	if (result < 0)
>  		return result;
>  
> -	nvmeq = dev->queues[0];
> -	if (!nvmeq) {
> -		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
> -					dev_to_node(dev->dev));
> -		if (!nvmeq)
> -			return -ENOMEM;
> -	}
> +	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
> +			dev_to_node(dev->dev));
> +	if (result)
> +		return result;
>  
> +	nvmeq = &dev->queues[0];
>  	aqa = nvmeq->q_depth - 1;
>  	aqa |= aqa << 16;
>  
> @@ -1629,7 +1617,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  
>  	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
>  		/* vector == qid - 1, match nvme_create_queue */
> -		if (!nvme_alloc_queue(dev, i, dev->q_depth,
> +		if (nvme_alloc_queue(dev, i, dev->q_depth,
>  		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
>  			ret = -ENOMEM;
>  			break;
> @@ -1638,7 +1626,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  
>  	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
>  	for (i = dev->online_queues; i <= max; i++) {
> -		ret = nvme_create_queue(dev->queues[i], i);
> +		ret = nvme_create_queue(&dev->queues[i], i);
>  		if (ret)
>  			break;
>  	}
> @@ -1894,7 +1882,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>  
>  static int nvme_setup_io_queues(struct nvme_dev *dev)
>  {
> -	struct nvme_queue *adminq = dev->queues[0];
> +	struct nvme_queue *adminq = &dev->queues[0];
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	int result, nr_io_queues;
>  	unsigned long size;
> @@ -2020,7 +2008,7 @@ static void nvme_disable_io_queues(struct nvme_dev *dev, int queues)
>   retry:
>  		timeout = ADMIN_TIMEOUT;
>  		for (; i > 0; i--, sent++)
> -			if (nvme_delete_queue(dev->queues[i], opcode))
> +			if (nvme_delete_queue(&dev->queues[i], opcode))
>  				break;
>  
>  		while (sent--) {
> @@ -2209,7 +2197,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  
>  	queues = dev->online_queues - 1;
>  	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
> -		nvme_suspend_queue(dev->queues[i]);
> +		nvme_suspend_queue(&dev->queues[i]);
>  
>  	if (dead) {
>  		/* A device might become IO incapable very soon during
> @@ -2217,7 +2205,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		 * queue_count can be 0 here.
>  		 */
>  		if (dev->ctrl.queue_count)
> -			nvme_suspend_queue(dev->queues[0]);
> +			nvme_suspend_queue(&dev->queues[0]);
>  	} else {
>  		nvme_disable_io_queues(dev, queues);
>  		nvme_disable_admin_queue(dev, shutdown);
> @@ -2470,8 +2458,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
>  	if (!dev)
>  		return -ENOMEM;
> -	dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void *),
> -							GFP_KERNEL, node);
> +
> +	dev->queues = kcalloc_node(num_possible_cpus() + 1,
> +			sizeof(struct nvme_queue), GFP_KERNEL, node);
>  	if (!dev->queues)
>  		goto free;

Hi Sagi,

This patch introduces a new kernel oops:

[  367.718782] BUG: unable to handle kernel NULL pointer dereference at 0000000000000108
[  367.727530] IP: nvme_suspend_queue+0x2b/0xb0 [nvme]
[  367.732970] PGD 474fdd067 P4D 474fdd067 PUD 473052067 PMD 0
[  367.739288] Oops: 0002 [#1] SMP
[  367.742790] Modules linked in: sunrpc vfat fat btrfs intel_rapl sb_edac intel_powerclamp coretemp xor zstd_decompress kvm_intel zstd_compress kvm xxhash irqbypass raid6_pq crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd sg ipmi_ssif shpchp glue_helper iTCO_wdt iTCO_vendor_support mxm_wmi acpi_power_meter mei_me ipmi_si pcspkr ipmi_devintf lpc_ich dcdbas mei ipmi_msghandler wmi dm_multipath ip_tables sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci nvme libata crc32c_intel tg3 nvme_core megaraid_sas i2c_core ptp pps_core dm_mirror dm_region_hash dm_log dm_mod
[  367.807134] CPU: 6 PID: 1819 Comm: sh Not tainted 4.15.0-rc5+ #4
[  367.813834] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
[  367.822378] RIP: 0010:nvme_suspend_queue+0x2b/0xb0 [nvme]
[  367.828400] RSP: 0018:ffffb8c7426d7ce0 EFLAGS: 00010013
[  367.834227] RAX: 0000000000000000 RBX: ffffa03ec729ce80 RCX: 0000000000000000
[  367.842187] RDX: 0000000000000001 RSI: 0000000003540740 RDI: ffffa03ec729ce90
[  367.850148] RBP: ffffa03ec729ce90 R08: 000000000000005d R09: 0000000000000000
[  367.858108] R10: 0000000000000357 R11: 0000000000000018 R12: 0000000000000000
[  367.866069] R13: 000000000000000d R14: ffffb8c7426d7f00 R15: 0000000000000000
[  367.874030] FS:  00007f2b03540740(0000) GS:ffffa03e37cc0000(0000) knlGS:0000000000000000
[  367.883058] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  367.889469] CR2: 0000000000000108 CR3: 0000000307322003 CR4: 00000000001606e0
[  367.897430] Call Trace:
[  367.900161]  nvme_dev_disable+0xbc/0x3f0 [nvme]
[  367.905207]  ? pci_conf1_read+0xb2/0xf0
[  367.909488]  ? pci_read_config_dword.part.10+0x64/0x80
[  367.915221]  ? pcie_capability_read_dword+0xa3/0xc0
[  367.920664]  pci_dev_save_and_disable+0x26/0x50
[  367.925719]  pci_reset_function+0x34/0x60
[  367.930193]  reset_store+0x4f/0x80
[  367.933988]  kernfs_fop_write+0xfa/0x180
[  367.938365]  __vfs_write+0x33/0x170
[  367.942258]  ? __inode_security_revalidate+0x4c/0x60
[  367.947798]  ? selinux_file_permission+0xda/0x130
[  367.953047]  ? _cond_resched+0x15/0x30
[  367.957227]  vfs_write+0xad/0x1a0
[  367.960924]  SyS_write+0x52/0xc0
[  367.964527]  do_syscall_64+0x61/0x1a0
[  367.968612]  entry_SYSCALL64_slow_path+0x25/0x25
[  367.973762] RIP: 0033:0x7f2b02c21ab0
[  367.977747] RSP: 002b:00007ffd44e44108 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  367.986194] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2b02c21ab0
[  367.994155] RDX: 0000000000000002 RSI: 00007f2b03545000 RDI: 0000000000000001
[  368.002116] RBP: 00007f2b03545000 R08: 000000000000000a R09: 00007f2b03540740
[  368.010076] R10: 00007f2b03540740 R11: 0000000000000246 R12: 00007f2b02ef9400
[  368.018037] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[  368.025998] Code: 0f 1f 44 00 00 41 54 55 48 8d 6f 10 53 48 89 fb 48 89 ef e8 c8 bc 23 df 44 0f b7 63 52 66 41 83 fc ff 74 66 48 8b 43 08 48 89 ef <83> a8 08 01 00 00 01 b8 ff ff ff ff 66 89 43 52 c6 07 00 0f 1f
[  368.047071] RIP: nvme_suspend_queue+0x2b/0xb0 [nvme] RSP: ffffb8c7426d7ce0
[  368.054742] CR2: 0000000000000108
[  368.058445] ---[ end trace e9187fc9f9e8f0d6 ]---


-- 
Ming
