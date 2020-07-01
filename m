Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8061DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 13:12:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E11E20772
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 13:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ksJ518bT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E11E20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+EpfapEoY6vPGOOFn+IQWTMUmwzn7iPGHQBpr6GUwPw=; b=ksJ518bT8vmBoUYgSiTnFVekl
	12PsJNXEnIrfgeNuSjo4KFfLN6hevNZOkGo3QMnIM+1+gayb3z/e6ImCWb5I3IFairPJgu1ORXJtL
	cvo4wptPUUh5JsrUyqvEXXJSMBI9o2q711bweHievpHgPhuS7aBUVM9H8oyArBe8UYMm/Nv/XJmU1
	1yoeMHrZpEI9Jooy8gJBWsjv9zKXEUDbIM2ZLV0HQ5K4QxZhZ/cE2qOPpcfWMLlJJ8jYw4qxz7So2
	dqsFcFYUIVS7Fq7S/WichV/ZDASa5Lc/XXOxqBpSQFxgYn8PtR24wslAiQaBD1MUCOkY8NQqQZpo5
	y93gk/Deg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqcXc-0005Qx-Em; Wed, 01 Jul 2020 13:12:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqcXW-0005Q4-Gu
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 13:12:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D767268B02; Wed,  1 Jul 2020 15:12:35 +0200 (CEST)
Date: Wed, 1 Jul 2020 15:12:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200701131235.GA17919@lst.de>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_091238_783021_2015B36D 
X-CRM114-Status: GOOD (  21.83  )
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
Cc: kbusch@kernel.org, Matthew Wilcox <willy@infradead.org>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[willy: a comment/request on the xa_load API below]

On Tue, Jun 30, 2020 at 07:25:16PM -0700, Chaitanya Kulkarni wrote:
> This patch replaces the ctrl->namespaces tracking from linked list to
> xarray and improves the performance.

The performance improvement needs to be clearly stated here.

>  static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
>  {
> +	struct nvme_id_ctrl *id;
>  	struct nvme_ns *ns;
> +	int ret = 0;
>  
> +	if (xa_empty(&ctrl->namespaces)) {
>  		ret = -ENOTTY;
> +		goto out;
>  	}
>  
> -	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
> -	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
> -		dev_warn(ctrl->device,
> -			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
> +	/* Let the scan work finish updating ctrl->namespaces */
> +	flush_work(&ctrl->scan_work);
> +	if (nvme_identify_ctrl(ctrl, &id)) {
> +		dev_err(ctrl->device, "nvme_identify_ctrl() failed\n");
>  		ret = -EINVAL;
> -		goto out_unlock;
> +		goto out;
> +	}
> +	if (le32_to_cpu(id->nn) > 1) {
> +		dev_warn(ctrl->device,
> +		"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
> +		goto out;
>  	}

This code doesn't make any sense at all.  Why does a patch changing
data structures add new calls that go out on the wire?

> +	struct nvme_ns *ns;
> +	XA_STATE(xas, &ctrl->namespaces, nsid);
>  
> +	rcu_read_lock();
> +	do {
> +		ns = xas_load(&xas);
> +		if (xa_is_zero(ns))
> +			ns = NULL;
> +	} while (xas_retry(&xas, ns));
> +	ns = ns && kref_get_unless_zero(&ns->kref) ? ns : NULL;
> +	rcu_read_unlock();

This looks pretty weird, but I think the problem is one in the xarray
API, as for the typical lookup pattern we'd want an xa_load with
external RCU locking:

	rcu_read_lock();
	ns = xa_load_rcu(&ctrl->namespaces, nsid);
	if (ns && !kref_get_unless_zero(&ns->kref))
		ns = NULL;
	rcu_read_unlock();

instead of duplicating this fairly arcane loop in all kinds of callers.

> -	down_write(&ctrl->namespaces_rwsem);
> -	list_add_tail(&ns->list, &ctrl->namespaces);
> -	up_write(&ctrl->namespaces_rwsem);
> +	ret = xa_insert(&ctrl->namespaces, nsid, ns, GFP_KERNEL);
> +	if (ret) {
> +		switch (ret) {
> +		case -ENOMEM:
> +			dev_err(ctrl->device,
> +				"xa insert memory allocation\n");
> +			break;
> +		case -EBUSY:
> +			dev_err(ctrl->device,
> +				"xa insert entry already present\n");
> +			break;
> +		}
> +	}

No need for the switch and the detailed printks here, but we do need
actual error handling.

>  static void nvme_ns_remove(struct nvme_ns *ns)
>  {
> +	struct xarray *xa = &ns->ctrl->namespaces;
> +	bool free;
> +
>  	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>  		return;
>  
> @@ -3740,12 +3749,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  			blk_integrity_unregister(ns->disk);
>  	}
>  
> -	down_write(&ns->ctrl->namespaces_rwsem);
> -	list_del_init(&ns->list);
> -	up_write(&ns->ctrl->namespaces_rwsem);
> +	xa_lock(xa);
> +	__xa_erase(xa, ns->head->ns_id);
> +	free = refcount_dec_and_test(&ns->kref.refcount) ? true : false;
> +	xa_unlock(xa);
>  
>  	nvme_mpath_check_last_path(ns);
> -	nvme_put_ns(ns);
> +	if (free)
> +		__nvme_free_ns(ns);

This looks very strange to me.  Shoudn't this be a normal xa_erase
followed by a normal nvme_put_ns?  For certain the driver code has
no business poking into the kref internals.

>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>  					unsigned nsid)
>  {
> +	struct xarray *namespaces = &ctrl->namespaces;
> +	struct xarray rm_array;
> +	unsigned long tnsid;
> +	struct nvme_ns *ns;
> +	unsigned long idx;
> +	int ret;
>  
> +	xa_init(&rm_array);
> +
> +	xa_lock(namespaces);
> +	xa_for_each(namespaces, idx, ns) {
> +		tnsid = ns->head->ns_id;
> +		if (tnsid > nsid || test_bit(NVME_NS_DEAD, &ns->flags)) {
> +			xa_unlock(namespaces);
> +			xa_erase(namespaces, tnsid);
> +			/* Even if insert fails keep going */
> +			ret = xa_insert(&rm_array, nsid, ns, GFP_KERNEL);
> +			switch (ret) {
> +			case -ENOMEM:
> +				pr_err("xa insert memory allocation failed\n");
> +				break;
> +			case -EBUSY:
> +				pr_err("xa insert entry already present\n");
> +				break;
> +			}
> +			xa_lock(namespaces);
> +		}
>  	}
> +	xa_unlock(namespaces);

I don't think you want an xarray for the delete list.  Just keep the
list head for that now - once we moved to RCU read side locking some
of this could potentially be simplified later.

>   */
>  void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  {
> -	struct nvme_ns *ns, *next;
> -	LIST_HEAD(ns_list);
> +	struct xarray rm_array;
> +	unsigned long tnsid;
> +	struct nvme_ns *ns;
> +	unsigned long idx;
> +	int ret;
> +
> +	xa_init(&rm_array);
>  
>  	/*
>  	 * make sure to requeue I/O to all namespaces as these
> @@ -3919,11 +3950,30 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	if (ctrl->state == NVME_CTRL_DEAD)
>  		nvme_kill_queues(ctrl);
>  
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_splice_init(&ctrl->namespaces, &ns_list);
> -	up_write(&ctrl->namespaces_rwsem);
> +	xa_lock(&ctrl->namespaces);
> +	xa_for_each(&ctrl->namespaces, idx, ns) {
> +		tnsid = ns->head->ns_id;
> +		xa_unlock(&ctrl->namespaces);
> +		xa_erase(&ctrl->namespaces, tnsid);
> +		/* Even if insert fails keep going */
> +		ret = xa_insert(&rm_array, tnsid, ns, GFP_KERNEL);
> +		if (ret) {
> +			switch (ret) {
> +			case -ENOMEM:
> +				dev_err(ctrl->device,
> +					"xa insert memory allocation\n");
> +				break;
> +			case -EBUSY:
> +				dev_err(ctrl->device,
> +					"xa insert entry already present\n");
> +				break;
> +			}
> +		}
> +		xa_lock(&ctrl->namespaces);
> +	}
> +	xa_unlock(&ctrl->namespaces);

Same here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
