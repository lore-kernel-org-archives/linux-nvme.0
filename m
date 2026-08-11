Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D4CC5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUTc7Zcj155tJxd99raX4BSfyhzHFcuoERsqLcAp6s8=; b=jjkn9cumMpkE/UY6jz0fze0ven
	wBooOdcPUjH71YqvHcjJpjJjbEq4B2WirviMPnEos7j7hhK55ucB9haLZZvIBh2k66W6tTxFAijwS
	X/aEZC5iXfgY34Iyiox5BdijNiMyq4QXAl9WMtk1vo+Y4WolyfeJsX0hil45ZS5vzzzPmvneiJ8Pb
	TBi8Sc7roelKoNQTHPxig1UYyLcQ9KyUvKD/wc1zF9IazK9PLUrOABV5avkJff49GM4azGEY1BJXX
	FLQPkkjFt8kg4AFCl42DXYLdrDmChBNrQ7ptMBNIWMWcBtO75KyYaB0tOfqlONyRAPnCvaPujXT13
	mCtGxRfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmFI-0000000E4gS-0XeM;
	Tue, 11 Aug 2026 13:10:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmFE-0000000E4gI-37rQ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 13:10:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E266B600AD;
	Tue, 11 Aug 2026 13:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333681F000E9;
	Tue, 11 Aug 2026 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786453815;
	bh=kUTc7Zcj155tJxd99raX4BSfyhzHFcuoERsqLcAp6s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbw1e4+U+WLxrNhN/6gi1lFWtY8ljZm7Vv2PhKDqTJBEX4Xny0SAB2PJOP28w+f8n
	 4X2yx7IQQJD6lAGeCrJvMR0xLzEHOoGydCaeiHxBJFVRfEvgm1a1w5nbq1HKU4x3V6
	 OvuXm2AHo7R9714oYew8uxNPGx287nfpEak+x+f+bMPQ4rS1kUo2mri97/B9UWTpYE
	 9g7/JRXY8uZY2dGgAuAlgWKWuhElALL00iz01qLlbRYVHhVdbhJxG6xlRGqmX7eaJR
	 NDVOyn3dFYkLNSuNQEd4DOWfdGHnwaNDzZCIhIHFXX+ehReZQnOlbtrUkSY3EWeIuO
	 fkfEiOWi0xLOQ==
Date: Tue, 11 Aug 2026 15:10:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <ansfMnm1WntoQRi_@ryzen>
References: <6a7a83ac.01d0871a.3a0d52.00bb.GAE@google.com>
 <20260811125310.165487-1-rihyeon8648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811125310.165487-1-rihyeon8648@gmail.com>
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

On Tue, Aug 11, 2026 at 09:53:10PM +0900, Rihyeon Kim wrote:

(snip)

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 04363b9c4489..e4d0eeccd846 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3601,6 +3601,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>  	nvme_uninit_ctrl(&ctrl->ctrl);
>  
>  out_put_ctrl:
> +	/* nvme_add_ctrl() failures skip the clear in fail_ctrl: above */
> +	ctrl->ctrl.opts = NULL;
> +
>  	/* Remove core ctrl ref. */
>  	nvme_put_ctrl(&ctrl->ctrl);
>  
> 
> base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
> -- 
> 2.43.0
> 
> 

Wouldn't a nicer fix be to change nvme_fc_ctrl_free() to look more like
nvme_tcp_ctrl_free(), i.e. something like:

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..2b4c222995ea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2359,19 +2359,22 @@ nvme_fc_ctrl_free(struct kref *ref)
                container_of(ref, struct nvme_fc_ctrl, ref);
        unsigned long flags;

+       if (list_empty(&ctrl->ctrl_list))
+               goto free_ctrl;
+
        /* remove from rport list */
        spin_lock_irqsave(&ctrl->rport->lock, flags);
        list_del(&ctrl->ctrl_list);
        spin_unlock_irqrestore(&ctrl->rport->lock, flags);

-       kfree(ctrl->queues);
-
        put_device(ctrl->dev);
        nvme_fc_rport_put(ctrl->rport);

        ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-       if (ctrl->ctrl.opts)
-               nvmf_free_options(ctrl->ctrl.opts);
+
+       nvmf_free_options(ctrl->ctrl.opts);
+free_ctrl:
+       kfree(ctrl->queues);
        kfree(ctrl);
 }

@@ -3593,8 +3596,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
        cancel_work_sync(&ctrl->ctrl.reset_work);
        cancel_delayed_work_sync(&ctrl->connect_work);

-       ctrl->ctrl.opts = NULL;
-
        if (ctrl->ctrl.admin_tagset)
                nvme_remove_admin_tag_set(&ctrl->ctrl);
        /* initiate nvme ctrl ref counting teardown */



However, I'm not familar with the fc driver, so this suggestion is untested.


Kind regards,
Niklas

