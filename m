Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BDC432BE
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 22:57:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A065E6109E
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 22:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A065E6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RfE48sMYJi/KQMQUQeZa0BMxmvLYb8yGDWuc3O7LMac=; b=whFPEa0Pj5GpM6
	6Hq0vKKgJQfodqglNmPokv+4CK9MACLbqTEkJYcvqlPCOQkaqh7SfLGNAs8JCVjEMns7k6r4Fs+rm
	f/1Zw3gCVRicNGrhzJ9SIK7w8OlEO4Zx2bn9s2BkuQgQgZHs6bNfnZN/kKFSiqhfUIyQrAXrx8/kf
	tFMbPfftcTKIC9CggwmmwCcEDiYAX/HjKUr6sWj6ymLtHvl+yLncIyzCJ5uww2t6yEfJhtdnFj2Wh
	Vz+lpEGGAlm8W+YWQVBonsZcWOeNsMicR/mmsrjUt0i5PsVrlqoTuBZ4AhjQ4YupQQeyX7DN9X3kT
	szy5mH6Lo5nKZnOKT74Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGqyV-009gVz-8U; Thu, 19 Aug 2021 22:57:27 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mGqyR-009gVU-HW; Thu, 19 Aug 2021 22:57:23 +0000
Date: Thu, 19 Aug 2021 15:57:23 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/9] nvme: use blk_mq_alloc_disk
Message-ID: <YR7h0w6rJc9GYpaf@bombadil.infradead.org>
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816131910.615153-2-hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 16, 2021 at 03:19:02PM +0200, Christoph Hellwig wrote:
> Switch to use the blk_mq_alloc_disk helper for allocating the
> request_queue and gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1478d825011d..a5878ba14c55 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3762,15 +3759,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
>  		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>  			ns->head->instance);
> -	ns->disk = disk;
>  
>  	if (nvme_update_ns_info(ns, id))
> -		goto out_put_disk;
> +		goto out_unlink_ns;
>  
>  	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
>  		if (nvme_nvm_register(ns, disk->disk_name, node)) {
>  			dev_warn(ctrl->device, "LightNVM init failure\n");
> -			goto out_put_disk;
> +			goto out_unlink_ns;
>  		}
>  	}

This hunk will fail because of the now removed NVME_QUIRK_LIGHTNVM. The
last part of the patch  then can be removed to apply to linux-next.

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
