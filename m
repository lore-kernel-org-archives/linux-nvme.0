Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D61C5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HhZbDVY2Qk1X52ixfBovkVz8ZhdXn7Kdve+KA4TAbhg=; b=Zdi4wlSuAOonAg8YNf1elkaxqg
	DywsKta1aHA5tVpgZN1dkFvBVKrs6BFI4Rw47PWN/fWUmCe5c6caGnVPTiX7f63U9qXheSyfxecBL
	xwJxgiyc+WEeajJJ8ZvNstVlWSg/Rq+4D4bKuXUyHwZpxknnGKkdjt39WaqPr7M5u7RcptZWWDoYh
	wfJ1yZTNS9CXE+9uxXgchDw1fkPQMB+E+egSwqs0yyq7yUGKUlMRGqS7qtWtn1lOp82AhJ1KUK5qL
	jm1QvfQAfzwI7MmMK15K5dfAgAZ5zmdL3vdoEvyiZAszSNeUVMOdOxGISLBNoGhQzzvkw/o02tM3q
	b3BX/myA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtrtu-0000000EojB-1S9i;
	Tue, 11 Aug 2026 19:12:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtrtt-0000000Eoir-1WJG
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 19:12:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D3BCD43831;
	Tue, 11 Aug 2026 19:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9DA1F000E9;
	Tue, 11 Aug 2026 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786475556;
	bh=HhZbDVY2Qk1X52ixfBovkVz8ZhdXn7Kdve+KA4TAbhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OBFhOEL9jfBB8N+XFrbk3ca93Tj/CnfORQBOb6ATNez0XRU/brUyyaMkrKDL9usOS
	 yuPQfa0OutB/0or4v2KC82TRvU1hS8wraQX4GJt+ZXG/HOKWo5O8AAXKphDTNibvbu
	 zTH40gq0ElzlZmwIY9ELJ5yXgy2O56kATkpcdrXRu1u5M7Y3T5zM3pD1ZLeevo10Z7
	 23Unu8P0D3WUeg/AWk+99IreQjKKsjAOyALbEO6jhgZquqTns6fT+ObNIYs7SGYyzj
	 oM/I6LgSuo7wEO0OJGRE6bqWJ7BQ25+UlPA54Y38KbANzH8xlc/QS0P7TZP7zsfBdh
	 F5PRGnjdrkGFA==
Date: Tue, 11 Aug 2026 13:12:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: wenxiong@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com,
	wenxiong@us.ibm.com
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
Message-ID: <ant0I66BcAugTyGX@kbusch-mbp>
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810235034.544797-1-wenxiong@linux.ibm.com>
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

On Mon, Aug 10, 2026 at 07:50:34PM -0400, wenxiong@linux.ibm.com wrote:
>  static int nvme_ns_head_open(struct gendisk *disk, blk_mode_t mode)
>  {
> -	if (!nvme_tryget_ns_head(disk->private_data))
> +	struct nvme_ns_head *head = disk->private_data;
> +	struct nvme_ns *ns;
> +	int srcu_idx;
> +
> +	if (!nvme_tryget_ns_head(head))
>  		return -ENXIO;
> +
> +	/* Get module reference from any available path */
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (ns && !try_module_get(ns->ctrl->ops->module)) {
> +		srcu_read_unlock(&head->srcu, srcu_idx);
> +		nvme_put_ns_head(head);
> +		return -ENXIO;
> +	}
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +
>  	return 0;
>  }
>  
>  static void nvme_ns_head_release(struct gendisk *disk)
>  {
> -	nvme_put_ns_head(disk->private_data);
> +	struct nvme_ns_head *head = disk->private_data;
> +	struct nvme_ns *ns;
> +	int srcu_idx;
> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (ns)
> +		module_put(ns->ctrl->ops->module);
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +
> +	nvme_put_ns_head(head);
>  }

The result of nvme_find_path() is just the current path at the moment,
so I don't think this is right.

I think you need the head to hold a module reference on every path the
head has, so the module_get/put should be in nvme_mpath_add_disk and
nvme_mpath_remove_disk.

