Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B04C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4LjJiQvQrEw8ixJLoVbOh7Vk+psYJgH0ZFhL2p51xM=; b=t1IZY8CQRACDz+rOmCal59bA1j
	8bX5+HXF7W9NqcZ7dZbvXdWII0TQUh9Yz50M4h059vk3V+XCw1fi/RCkCcZRUdYjKPcz4RHHHGqFg
	DZO0K7Cnx3TNfFU2rHNCxt5xaZW+eM/j70VwHVKL5r5hZns8vYolDy+NlBdRvHg4Stz98DaqD/Ca1
	qPa+GkZvzV0/HRMB3G32Dd50iNNxRHa51OJFn9GG9aGcxCtsmzpozB0Zy3tfsdSER9xfFpGDSDcFa
	mpHagY2EA2bbPgeReKNGsOfV6UqUnv349zYe0lRWIOJUIqsJ+2l6dsd1uMfBCU9wUIyPr3uyNc+Tf
	2SehZl8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAnl2-009UdP-0u;
	Wed, 06 Dec 2023 08:59:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAnkz-009Ucp-1d
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 08:59:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 161D4227A8E; Wed,  6 Dec 2023 09:59:46 +0100 (CET)
Date: Wed, 6 Dec 2023 09:59:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 4/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <20231206085945.GC24484@lst.de>
References: <20231206081244.32733-1-dwagner@suse.de> <20231206081244.32733-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_005949_687141_B8795381 
X-CRM114-Status: GOOD (  30.08  )
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

On Wed, Dec 06, 2023 at 09:12:44AM +0100, Daniel Wagner wrote:
> libnvme is using the sysfs for enumarating the nvme resources. Though
> there are few missing attritbutes in the sysfs. For these libnvme issues
> commands during discovering.
> 
> As the kernel already knows all these attributes and we would like to
> avoid libnvme to issue commands all the time, expose these missing
> attributes.
> 
> The nuse value is updated on request because the nuse is a volatile
> value. Since any user can read the sysfs attribute, a very simple rate
> limit is added (update max every 5 seconds). A more sophisticated update
> strategy can be added later if there is actually a need for it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/core.c  | 28 ++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h  |  2 ++
>  drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index caa52c2f57c8..e7dd64ee1653 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1663,6 +1663,33 @@ static void nvme_ns_release(struct nvme_ns *ns)
>  	nvme_put_ns(ns);
>  }
>  
> +int nvme_ns_update_nuse(struct nvme_ns_head *head)
> +{
> +	static DEFINE_RATELIMIT_STATE(_rs, 5 * HZ, 1);
> +	struct nvme_id_ns *id;
> +	struct nvme_ns *ns;
> +	int srcu_idx, ret = -EWOULDBLOCK;
> +
> +	if (__ratelimit(&_rs))
> +		return 0;

Can you add a comment on the ratelimiting here?

> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (!ns)
> +		goto out_unlock;
> +
> +	ret = nvme_identify_ns(ns->ctrl, head->ns_id, &id);
> +	if (ret)
> +		goto out_unlock;
> +
> +	head->nuse = le64_to_cpu(id->nuse);

This looks like the wrong thing to do for the non-multipath nodes,
which should be able to go straight to the ns.

I'd move this to sysfs.c, and then do a similar trick to say
nvme_send_pr_command to directly use the ns for the non-multipath
nodes, and do what you're doing here for the multipath nodes.

>  static struct attribute *nvme_ns_id_attrs[] = {

And I duess the _id is not correct now, I'd just drop it.


