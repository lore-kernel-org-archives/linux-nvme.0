Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6CBC49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:50:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914A120650
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ByU7Sjcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914A120650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/NRlo2qYXyTzVdN8rmS+Izhwfe5BHjgjb8G/cSjjV4w=; b=ByU7SjcrPNf/aI
	H5g9AOeCZhZUVw+I1LbBRD77QWbdl/nAWLLrt8oXpHehkxYrVSi87r0fECeGIDfqQYzaukrS4eAhB
	BGGLOgUXbX520Ns0iGTLo+mD7Iu6+O2A8ZOwZVvtscnDfPhwVzkAgTj6M/wPXGpGDClN5z/OpHQ57
	+Qxll3Q/HOMH+cVRbAcDYWxlx0d7MV0X12NtW4QPIglEt4D5EW0Z24P2ZwOXWXnZIIUHXbB9TFXq3
	Ohfth8lGcV/OxQ6KKoNet06qEBz4LFhv9gZ0pyqswC5Mkd+9DoIQw6xPeMl04EFtn2FbiQHuLXtEO
	6iF7zGUq5VVGu99zyJSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9llm-0007Uz-1Q; Mon, 16 Sep 2019 07:49:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9llg-0007Fj-GG
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 07:49:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 87D9168B05; Mon, 16 Sep 2019 09:49:48 +0200 (CEST)
Date: Mon, 16 Sep 2019 09:49:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Balbir Singh <sblbir@amzn.com>
Subject: Re: [PATCH v2 1/2] nvme/host/pci: Fix a race in controller removal
Message-ID: <20190916074948.GB25606@lst.de>
References: <20190913233631.15352-1-sblbir@amzn.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190913233631.15352-1-sblbir@amzn.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_004953_014603_4F4F534C 
X-CRM114-Status: GOOD (  23.66  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 13, 2019 at 11:36:30PM +0000, Balbir Singh wrote:
> This race is hard to hit in general, now that we
> have the shutdown_lock in both nvme_reset_work() and
> nvme_dev_disable()
> 
> The real issue is that after doing all the setup work
> in nvme_reset_work(), when get another timeout (nvme_timeout()),
> then we proceed to disable the controller. This causes
> the reset work to only partially progress and then fail.
> 
> Depending on the progress made, we call into
> nvme_remove_dead_ctrl(), which does another
> nvme_dev_disable() freezing the block-mq queues.
> 
> I've noticed a race with udevd with udevd trying to re-read
> the partition table, it ends up with the bd_mutex held and
> it ends up waiting in blk_queue_enter(), since we froze
> the queues in nvme_dev_disable(). nvme_kill_queues() calls
> revalidate_disk() and ends up waiting on the bd_mutex
> resulting in a deadlock.
> 
> Allow the hung tasks a chance by unfreezing the queues after
> setting dying bits on the queue, then call revalidate_disk()
> to update the disk size.
> 
> NOTE: I've seen this race when the controller does not
> respond to IOs or abort requests, but responds to other
> commands and even signals it's ready after its reset,
> but still drops IO. I've tested this by emulating the
> behaviour in the driver.
> 
> Signed-off-by: Balbir Singh <sblbir@amzn.com>
> ---
> 
> Changelog:
> - Rely on blk_set_queue_dying to do the wake_all()
> 
>  drivers/nvme/host/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b45f82d58be8..f6ddb58a7013 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -103,10 +103,16 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>  	 */
>  	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>  		return;
> -	revalidate_disk(ns->disk);
>  	blk_set_queue_dying(ns->queue);
>  	/* Forcibly unquiesce queues to avoid blocking dispatch */
>  	blk_mq_unquiesce_queue(ns->queue);
> +	/*
> +	 * revalidate_disk, after all pending IO is cleaned up
> +	 * by blk_set_queue_dying, largely any races with blk parittion
> +	 * reads that might come in after freezing the queues, otherwise
> +	 * we'll end up waiting up on bd_mutex, creating a deadlock.
> +	 */
> +	revalidate_disk(ns->disk);

The patch looks fine to me, but the comments looks a little strange.
How do we trigger the partition scan?  Is someone opening the device
again after we froze it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
