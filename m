Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6710C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 28 May 2022 05:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5z4X3VbV1ERwlpYgge4j0mYuM3a8YK5x4ctdB2oZR4=; b=2iDFKTVIDmy9w+s/U6lUyocXHu
	PEStzke5ujL7iQtAPoZHr02XohneuqlztfLu/uQLqt+K7pPTF9U/PysGtW7h61sHjqBXj4h5//U0q
	aJo59abli9coufpnSJVeOYr2vjxGrGgZTNt27UvPsvQF0f49y8cg/ZI1qBoMIeadQrmU+Iszy/AMz
	r57xMwjJe2+hGghhnW5zNpJs+qNotQ8qpDm8gp6Jl5C4jGO4Vv9kzPGmWc24dvdapOT386EO/iO8q
	KrDv/yw2PkHDtED6y9RHPzeLpKgLKgYOVwtw/oS5KBBQHgY4FbnjrICXHfa5SsuIYmB7JGY5yNpgT
	4OkwqxGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuopI-001TaC-AW; Sat, 28 May 2022 05:17:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuopE-001TZQ-RH
	for linux-nvme@lists.infradead.org; Sat, 28 May 2022 05:17:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B41A168AFE; Sat, 28 May 2022 07:17:15 +0200 (CEST)
Date: Sat, 28 May 2022 07:17:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: wenxiong@linux.ibm.com
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org,
	hare@suse.de, wenxiong@us.ibm.com
Subject: Re: [PATCH 1/1] nvme-multipath: show wrong nvme ns after dlpar a
 nvme device
Message-ID: <20220528051715.GA13549@lst.de>
References: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_221721_074532_92746DFB 
X-CRM114-Status: GOOD (  15.70  )
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

On Fri, May 27, 2022 at 10:49:37AM -0500, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> If we have an active partition/namespace on nvme device, nvme device driver
> won’t release these controller IDs/Namespaces IDs when dlpar remove.

What is a dlpar?

> So we got the wrong nvme devices names if nvme device driver still use old
> subsystem id as controller id when dlpar add it back. We expect to see new
> nvme devices with new controller IDs/Namespace IDs.

What is wrong?

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d464fdf978fb..945974ceef3c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -495,7 +495,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	head->disk->fops = &nvme_ns_head_ops;
>  	head->disk->private_data = head;
>  	sprintf(head->disk->disk_name, "nvme%dn%d",
> -			ctrl->subsys->instance, head->instance);
> +			ctrl->instance, head->instance);

No, this is broken.  The name needs to refer to the subsystem instance
as otherwise we will run into naming conflicts.

