Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF478C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:52:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8AB20756
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ePHqA0n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8AB20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YnTmJel694n+B+Lh100UMEtFE8K6cInlfpF7k/kzG0E=; b=ePHqA0n20XtJAVS3cWKlrNOId
	KlDgUSqCA64cAbu9oPREs/QoAZpNOSRUIWa1RNbvWA5w/rHuhT1uIu4gqX5NlH/qYFmD+sjFF0F7U
	ljjTyTBUk1TwVQoGWp04MsMRYGotdwnqeopBT9jZeghSos83TWrRN4mVwNzKUmWhuYbjYHTVqGRLF
	4h/4kaEgOcG3vdtr4P66W1EcoYIKuG8X4uQjRuQArD5zvVt+cCaq1sDZmrD2NFsFBE6rFJnNuudA9
	NpdkahtgyRfDmEygruK45BmzxiW0wwiIYCuwz1+/7f8AGW4/mv9PdBGDnrfpfmCJMcjAYvcfmHW/2
	691XZZgWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPPyI-00051O-96; Mon, 05 Oct 2020 12:52:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPPyF-00050e-5v
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 12:52:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 84C6767373; Mon,  5 Oct 2020 14:52:01 +0200 (CEST)
Date: Mon, 5 Oct 2020 14:52:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
Message-ID: <20201005125201.GB1125@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005124500.6015-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_085203_324420_4E052E8B 
X-CRM114-Status: GOOD (  28.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 05, 2020 at 02:45:00PM +0200, Hannes Reinecke wrote:
> Currently namespaces behave differently depending on the 'CMIC'
> setting. If CMIC is zero, the device is removed once the last path
> goes away. If CMIC has the multipath bit set, the device is retained
> even if the last path is removed.
> This is okay for fabrics, where one can do an explicit disconnect
> to remove the device, but for nvme-pci this induces a regression
> with PCI hotplug.
> When the NVMe device is opened (eg by MD), the NVMe device is not
> removed after a PCI hot-remove. Hence MD will not be notified about
> the event, and will continue to consider this device as operational.
> Consequently, upon PCI hot-add the device shows up as a new NVMe
> device, and MD will fail to reattach the device.
> So this patch adds NVME_NSHEAD_QUEUE_IF_NO_PATH flag to the nshead
> to restore the original behaviour for non-fabrics NVMe devices.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c      | 10 +++++++++-
>  drivers/nvme/host/multipath.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      |  2 ++
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4459a40b057c..e21c32ea4b51 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -475,8 +475,11 @@ static void nvme_free_ns_head(struct kref *ref)
>  		container_of(ref, struct nvme_ns_head, ref);
>  
>  #ifdef CONFIG_NVME_MULTIPATH
> -	if (head->disk)
> +	if (head->disk) {
> +		if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags))
> +			nvme_mpath_remove_disk(head);
>  		put_disk(head->disk);
> +	}
>  #endif
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	cleanup_srcu_struct(&head->srcu);
> @@ -3357,6 +3360,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
>  #ifdef CONFIG_NVME_MULTIPATH
>  	&dev_attr_ana_grpid.attr,
>  	&dev_attr_ana_state.attr,
> +	&dev_attr_queue_if_no_path.attr,
>  #endif
>  	NULL,
>  };
> @@ -3387,6 +3391,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>  		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
>  			return 0;
>  	}
> +	if (a == &dev_attr_queue_if_no_path.attr) {
> +		if (dev_to_disk(dev)->fops == &nvme_fops)
> +			return 0;
> +	}
>  #endif
>  	return a->mode;
>  }
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 55045291b4de..bbdad5917112 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -381,6 +381,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	/* set to a default value for 512 until disk is validated */
>  	blk_queue_logical_block_size(q, 512);
>  	blk_set_stacking_limits(&q->limits);
> +	/* Enable queue_if_no_path semantics for fabrics */
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);

Well, that is blindly obvious from the code.  But why would we treat
fabrics special? 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
