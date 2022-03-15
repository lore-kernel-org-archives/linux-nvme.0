Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AB9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0R5m+EH7tdLPC19RCmiRSGuL2oC24ic/NbSQEGCz7aQ=; b=32Sk4Tx1bQVVHgSc4Qi0CjFsa/
	RD9s0Z+vFg2H/CtGXQLEcgP4tyHNvBSw0L+MhUf6Pc/GUkTMS2rjee9WfSKkmALa35/LRfEKt3lBn
	SQrIkjx7EIWivAkGugW9pYK6YRqeoZfM3s8RQeuLpENIuDmEsrkKmbUJ6Hv6DhO6TEn9Z+1DiRdHj
	C38w6O80fpSdsH+M69bTwpb2XtAwC4urQDHRxolWjhWYHpaOJhSOkJmdsyEm28dsnj+4XdYZdCJ0T
	Z/qaTL7iZWyEuARIzOPnoxPpdUUddG597jYjUcMFda31FHYKxd4jwokdhAQRva3kdGKoL72eFjfE4
	QVjZUa9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU91Y-009ifi-Gp; Tue, 15 Mar 2022 15:23:48 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU91V-009idz-Nh
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 15:23:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 86D88B81161;
 Tue, 15 Mar 2022 15:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E8C340E8;
 Tue, 15 Mar 2022 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647357822;
 bh=zq8YQvdi0Sn2vf+Arv4Q7x9sigoB/0npcS/5NzMHlUc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6fGjNIxwLrl+gbqKO4fUkC7+DHF5OQ8/kHU6hOvjPqgGF/JFMAD7iY4aci9CZNI/
 h6S6oFaeDBDHs9cSPMjHMdAX8rhWa7l0PsBI9Cy9meuBjJcJjKh9iT5e3IeJYo/dhc
 VmbnL61/MGBjjZQZnQz2B4477HGjrkPII91n3cqX9Z3gJcMn8rmgoyzInOS64PL3Sz
 IZBHR+tUfZvN7FDLgzKZdpkYQamh0v0NElMCJp+1YTEp9qm19PRnJkLgS9n3KoG8ZS
 mE1dqmQMCT1qQPux/6/jGtBFP8VFsKVoFgoa2PGnshsCitc2dzHZUvIGPsIsfJVi4W
 7YvsoUj9kLQyg==
Date: Tue, 15 Mar 2022 09:23:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: warn about shared namespaces without
 CONFIG_NVME_MULTIPATH
Message-ID: <YjCvfMplVsxKk3yd@C02CK6Q3MD6M>
References: <20220315145141.2586124-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315145141.2586124-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_082345_978001_36FFBD50 
X-CRM114-Status: GOOD (  16.84  )
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

On Tue, Mar 15, 2022 at 03:51:41PM +0100, Christoph Hellwig wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 8fb89d0624fc5..e733c48de2e90 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2092,6 +2092,7 @@ static void loop_remove(struct loop_device *lo)
>  	del_gendisk(lo->lo_disk);
>  	blk_cleanup_disk(lo->lo_disk);
>  	blk_mq_free_tag_set(&lo->tag_set);
> +
>  	mutex_lock(&loop_ctl_mutex);
>  	idr_remove(&loop_index_idr, lo->lo_number);
>  	mutex_unlock(&loop_ctl_mutex);

This unrelated change sneaked into your patch. :)

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd9878671d734..75f7c53a67811 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3879,6 +3879,14 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  					nsid);
>  			goto out_put_ns_head;
>  		}
> +
> +		if (!multipath && !list_empty(&head->list)) {
> +			dev_warn(ctrl->device,
> +				"Found shared namespace %d, but multipathing not supported.\n",
> +				nsid);
> +			dev_warn_once(ctrl->device,
> +				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
> +		}

The recent release pattern suggests 5.20 will be the last of the 5.x tags
before seeing 6.0, but my understanding is that's at the discretion of Chief
Penguin. Unless you know already, perhaps warning with 5.21 is more clear that
removing this capability happens after 3 more releases.

