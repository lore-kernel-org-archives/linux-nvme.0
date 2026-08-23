Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A0C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Sumuq7XF9L8e+DVLhwpykgWETOyOmaRyOkiLPlP+mQ=; b=oFugAMC36GPezIh0b2ZnNWIBFk
	BdHsphVYcnMZdQA3NkUOtPYUc/8JHPyO1VpA2ionZwQD/RRruziyzV84CpQfljWUoRV161atlchlB
	u31wqT1u1UvMnEz4QyPTOLGXAd4nppoMaQl3RzkoIR1HoW+OcyA/TzrR8AXr+R0DlBDhw4Nav0HSY
	0JfEW6aggipjWIdbL0peqR1jyYw2bnZACEt2XJ9m8oQ3X1Z7USNavA+M0TV9MYvJQ3JCytofVzL4/
	hT2CYsvmvGj2UcwFYdoVpI8ccuLpI98Txh+43/oh3//FO0/uJTrXFybRWEQgmvKe1gvTRWZGq2996
	JGnFNdMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwD3-0000000EvlW-2fSo;
	Sun, 23 Aug 2026 00:37:13 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwD1-0000000EvlB-1cHQ
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:37:12 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so2856276a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787445429; x=1788050229;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Sumuq7XF9L8e+DVLhwpykgWETOyOmaRyOkiLPlP+mQ=;
        b=SpGG+9QIRerz2fsOJiHGuf+kXRDVKtHbMSxQGiWXc2ewNkj0Pq1Xp2d91aZLMCdTD/
         vMSvm7FbYkHpPJ0HiKtOKHjt3merds6RaIRTGs91F/zjnCpKiOpdqW5GfAegZePs41Me
         0CgBl055RtGfXaLRQCi2s+sEYz4shR08Qcl6k9csA12h2leUiidKF0bAzh+rZMZ3vnuu
         nuxnKA5tKl9cucwUu3gGf0n9ugEZjeawu4FFN59NL0ywbz+x92xOmJFQOMvl3XeNU1Ft
         Nt7CBz3d25V2ec/IaARQB8WTULfzZ9nUpbDLHRt2Dv4N04xpxWiuQuOLD73ByMb7UaFp
         guUQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSHU4pfc67HU2+sIFO371IqKmrOnyGo6WOfPtnurWw6hmkJwl0Glt+lfIMwGU0BmMOyBUBIBwssjx6@lists.infradead.org
X-Gm-Message-State: AFuF++lJPawHMPTe1So/Fw75bNsiOzCIliOQF5i1ucRN2UuC2ZAIacuE
	c/AJXxE0WnCwae0ylIWPAR98JAvb2KSxbRTdNKUV1AR9JOULBmh6wLNykDdb9Q==
X-Gm-Gg: AR+sD12f0KbShzMDxQyaKszMUhR6poDjt/Ln0inbyXqhGTm0j4fSNAZfn2mzGUbYv2/
	q5MZzdY/+Sn5lNIIGDzUxW8BGMVEc/sWe/ItOenIbki6wIAWeewf3m6DyBIKPXC7eqNlAbTONBV
	sd7z0rQkE4tHRiSmOv/Q6tN+Q2qNBDZo4jtTR0AaKDnMUNVDSKFfny0YW+txSFbRQP+5cbrk4LP
	otr0XmNcOH1Mw9Fx6qosi/tF2rGGjQuG7RE+YhU6fvkV63ZzyGj0lopVdMNjDVQu12wKeX3wf8M
	SEq+XiLy6rH8j1w1cp1LO58L5ZDX/+rBn4mpxvp/tamgyKLHRwvuj52OGFrPqPk11FGfEz6Zjao
	GL8RMLpmDA019cbSpjzsDct5wPqfOwVmEoGkNblLc4PdC7Db2Dulghlh9ybXOgeXmIhU3IZDgiI
	sRI6Kxvc5Uc0Ty3RHZT59jm3ImXMxl0skDUsXJ4jYc/Bl3IgWglsRWiok7CmVbFB4DlJ3lRiIn2
	MU/nfgT8B4cqAe/j3rtGBM=
X-Received: by 2002:a05:6402:3547:b0:6a3:6b8f:94ce with SMTP id 4fb4d7f45d1cf-6a42f13c1a1mr17933590a12.3.1787445428993;
        Sat, 22 Aug 2026 17:37:08 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1ccf69sm460504a12.25.2026.08.22.17.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:37:08 -0700 (PDT)
Message-ID: <23bfe700-6692-4785-9de4-b46845b9e271@grimberg.me>
Date: Sun, 23 Aug 2026 03:37:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma: fix ib_device removal race that hangs PCI
 unbind
To: Casey Chen <cachen@purestorage.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260806211822.317074-1-cachen@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260806211822.317074-1-cachen@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_173711_473241_8199F0A0 
X-CRM114-Status: GOOD (  37.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 07/08/2026 0:18, Casey Chen wrote:
> nvme_rdma_remove_one() samples nvme_rdma_ctrl_list once, then blocks in
> flush_workqueue(nvme_delete_wq). A connect can publish a controller on
> the same ib_device during that window: nvme_rdma_find_get_device()
> matches on node GUID in nvme_rdma's private device_list and never
> consults ib_core unregistration state. Such a controller is never
> deleted, so its rdma_cm_ids keep a reference on the cma_device.
>
> ib_clients are removed LIFO, so nvme_rdma_remove_one() runs before
> cma_remove_one(), which then waits for that reference forever. Removing
> the RDMA interface underneath live NVMe-oF connections:
>
>    echo 1 | sudo tee /sys/bus/pci/devices/0000:2a:00.1/remove
>
> wedges the unbind permanently:
>
>    INFO: task tee:164872 blocked for more than 200 seconds.
>    task:tee             state:D stack:0     pid:164872 ppid:164870 flags:0x00004002
>    Call Trace:
>     <TASK>
>     __schedule+0x4b4/0xf90
>     schedule+0x5a/0xc0
>     schedule_timeout+0x105/0x110
>     ? cma_process_remove+0x1f9/0x240 [rdma_cm]
>     __wait_for_common+0xc7/0x1f0
>     ? usleep_range_state+0xb0/0xb0
>     cma_remove_one+0x50/0xb0 [rdma_cm]
>     remove_client_context+0x88/0xc0 [ib_core]
>     disable_device+0x8a/0x160 [ib_core]
>     __ib_unregister_device+0x42/0xa0 [ib_core]
>     ib_unregister_device+0x22/0x30 [ib_core]
>     mlx5r_remove+0x39/0x60 [mlx5_ib]
>     auxiliary_bus_remove+0x18/0x30
>     device_release_driver_internal+0x18f/0x1f0
>     bus_remove_device+0xbc/0x120
>     device_del+0x154/0x3d0
>     ? devl_param_driverinit_value_get+0x29/0x90
>     mlx5_rescan_drivers_locked.part.0+0x78/0x1c0 [mlx5_core]
>     mlx5_unregister_device+0x34/0x50 [mlx5_core]
>     mlx5_uninit_one+0x45/0x110 [mlx5_core]
>     remove_one+0x4e/0xc0 [mlx5_core]
>     pci_device_remove+0x39/0xa0
>     device_release_driver_internal+0x18f/0x1f0
>     pci_stop_bus_device+0x68/0x90
>     pci_stop_and_remove_bus_device_locked+0x28/0x40
>     remove_store+0x75/0x90
>     kernfs_fop_write_iter+0x147/0x1d0
>     vfs_write+0x2af/0x410
>     ksys_write+0x5f/0xe0
>     do_syscall_64+0x35/0x80
>     entry_SYSCALL_64_after_hwframe+0x4b/0xb5
>     </TASK>
>
> Because the unbind stalls mid-teardown the netdev is never unregistered,
> so userspace keeps reconnecting over the interface and loses the race
> again.
>
> Mark the nvme_rdma_device dying before sampling nvme_rdma_ctrl_list and
> test it in two places:
>
>   - nvme_rdma_find_get_device() refuses a dying device, so later connects
>     fail early. A re-probed HCA (same GUID, new ib_device) gets a fresh
>     nvme_rdma_device.
>
>   - nvme_rdma_create_ctrl() re-tests it under nvme_rdma_ctrl_mutex before
>     publishing and deletes the controller instead if set, covering a
>     connect that obtained the device before the flag was stored.
>
> ->dying is stored before nvme_rdma_remove_one() takes
> nvme_rdma_ctrl_mutex and the publisher tests it under that same mutex,
> so a publisher either lands on the list before the walk or observes
> ->dying. One sweep remains sufficient.
>
> Reproduced on a 6.6 based kernel by removing and rescanning the mlx5
> interface carrying the NVMe-oF RDMA connections in a loop, with IO
> running and a userspace daemon reconnecting the controllers throughout.
> The hang is racy: most removals complete normally, and only one that
> lands while a connect is in flight leaves the sysfs write stuck in D
> state with the trace above. With this patch the loop ran clean: removals
> complete and the controllers reconnect after the following PCI rescan.
>
> Fixes: e87a911fed07 ("nvme-rdma: use ib_client API to detect device removal")
> Signed-off-by: Casey Chen <cachen@purestorage.com>
> ---
>   drivers/nvme/host/core.c |  1 +
>   drivers/nvme/host/rdma.c | 49 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cb93ada4376a..374968145f56 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -277,6 +277,7 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
>   		nvme_do_delete_ctrl(ctrl);
>   	nvme_put_ctrl(ctrl);
>   }
> +EXPORT_SYMBOL_GPL(nvme_delete_ctrl_sync);
>   
>   static blk_status_t nvme_error_status(u16 status)
>   {
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 01743ae01466..b3ea54280e50 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -53,6 +53,8 @@ struct nvme_rdma_device {
>   	struct list_head	entry
>   		__guarded_by(&device_list_mutex);
>   	unsigned int		num_inline_segments;
> +	/* set under device_list_mutex when removal starts */
> +	bool			dying;

No need for the comment IMO.

>   };
>   
>   struct nvme_rdma_qe {
> @@ -378,6 +380,18 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
>   
>   	mutex_lock(&device_list_mutex);
>   	list_for_each_entry(ndev, &device_list, entry) {
> +		if (READ_ONCE(ndev->dying)) {
> +			/*
> +			 * Removal has already sampled nvme_rdma_ctrl_list, so
> +			 * a controller created here would never be deleted.
> +			 * A re-probed device with the same node GUID is a
> +			 * distinct ib_device and gets a fresh
> +			 * nvme_rdma_device below.
> +			 */
> +			if (ndev->dev == cm_id->device)
> +				goto out_err;
> +			continue;
> +		}

Again, code is self explanatory.

>   		if (ndev->dev->node_guid == cm_id->device->node_guid &&
>   		    nvme_rdma_dev_get(ndev))
>   			goto out_unlock;
> @@ -2378,6 +2392,24 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr, opts->host->nqn);
>   
>   	mutex_lock(&nvme_rdma_ctrl_mutex);
> +	if (READ_ONCE(ctrl->device->dying)) {
> +		mutex_unlock(&nvme_rdma_ctrl_mutex);
> +		/*
> +		 * Removal already walked nvme_rdma_ctrl_list, so publishing
> +		 * now would leave this controller behind and stall
> +		 * cma_remove_one() forever. ->list is still empty, so
> +		 * nvme_rdma_free_ctrl() leaves opts for nvmf_create_ctrl().
> +		 * nvme_init_ctrl() left two references and
> +		 * nvme_delete_ctrl_sync() consumes only the one that
> +		 * nvme_uninit_ctrl() drops, so put the other here.
> +		 */
> +		dev_info(ctrl->ctrl.device,
> +			 "hca %s is being removed, aborting connect\n",
> +			 dev_name(ctrl->device->dev->dma_device));
> +		nvme_delete_ctrl_sync(&ctrl->ctrl);
> +		nvme_put_ctrl(&ctrl->ctrl);
> +		return ERR_PTR(-ECONNREFUSED);
> +	}

I think that this check can be called in nvme_rdma_setup_ctrl() before 
calling
nvme_start_ctrl() which already has an error path no?

Again, I don't think that the commends are helpful. You are checking 
"dying" and
failing if it is set, its kinda make sense. The explanations can stay in 
the commit msg.

>   	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
>   	mutex_unlock(&nvme_rdma_ctrl_mutex);
>   
> @@ -2409,9 +2441,16 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
>   	struct nvme_rdma_device *ndev;
>   	bool found = false;
>   
> +	/*
> +	 * Stop handing this device out to new queues, and stop new controllers
> +	 * from being published on it, before sampling nvme_rdma_ctrl_list
> +	 * below. Pairs with the READ_ONCE() of ->dying in
> +	 * nvme_rdma_find_get_device() and nvme_rdma_create_ctrl().
> +	 */

Same comment for code comments.

>   	mutex_lock(&device_list_mutex);
>   	list_for_each_entry(ndev, &device_list, entry) {
>   		if (ndev->dev == ib_device) {
> +			WRITE_ONCE(ndev->dying, true);
>   			found = true;
>   			break;
>   		}
> @@ -2421,7 +2460,15 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
>   	if (!found)
>   		return;
>   
> -	/* Delete all controllers using this device */
> +	/*
> +	 * Delete all controllers using this device. ->dying is stored before
> +	 * nvme_rdma_ctrl_mutex is acquired here, and nvme_rdma_create_ctrl()
> +	 * checks it while holding that same mutex, so the two orderings are
> +	 * exhaustive: a publisher that got the mutex first is on the list and
> +	 * is deleted below, and one that gets it afterwards observes ->dying
> +	 * and tears its controller down itself. No controller can be added
> +	 * behind this walk.
> +	 */

same comment.

>   	mutex_lock(&nvme_rdma_ctrl_mutex);
>   	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
>   		if (ctrl->device->dev != ib_device)
>
> base-commit: bf881dd20062db5e951a0d0703cb476df8c9fdee


