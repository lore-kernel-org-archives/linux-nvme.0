Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A012CEB64D7
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 00:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SN/hlkEtT439556aUYMeyg5okVvO4F8jT/j56Sxlyzo=; b=uoM5DfehiC4W60JEIsFtr5Xfax
	sHR5WCHrxhrbro1Trk4SSAxkpzfR/JIpxmtuFcUY09/VQw+Cn4/AV6j4304dajoxHmEseM9Eb5rP1
	HcO3aWxzmUq0UOIzpO5RhQIcBR2oDT/hfw9wCp6V+l+ymPTRq1k0dEUXjB05ZwhzIWYwidDJ6Y9ma
	sVGdjwwgTJbiiXLXYiN+HjuNPGcioYQGVHYz2JX6tIgEpY2bbT2kT6bE/6Zw6KMh20nkDpxRr3t2t
	I9AwgJBWU7xaJF5lxnr8mdhZ+YcflA9jTuWHRS2+sYmCfxeKjFBArMui8dvBAryvdU/120/W71Fun
	NzdOjt3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEfDR-00H66z-25;
	Thu, 29 Jun 2023 00:08:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEfDP-00H65f-02
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 00:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687997327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SN/hlkEtT439556aUYMeyg5okVvO4F8jT/j56Sxlyzo=;
	b=gvv6OruufXugCAHIJhCBDpyfA5Zw/ooLKNfXoqp5LiNHQ8G1Em/CFgaowqWNHJ4fNN93gY
	znLib7xyDGvejQGlhm27GCWF0empCgG/JK27pWcok02GYvAWtZhTMtUDabv6yaWUJ4aTl1
	hMksZOs1UxPMRc20Euc0f1I0//DNLAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-Tnpd1YoXP66rKp5nRexz1w-1; Wed, 28 Jun 2023 20:08:41 -0400
X-MC-Unique: Tnpd1YoXP66rKp5nRexz1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3B908E4686;
	Thu, 29 Jun 2023 00:08:40 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12DC3111F3B0;
	Thu, 29 Jun 2023 00:08:35 +0000 (UTC)
Date: Thu, 29 Jun 2023 08:08:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJzLf46lx4SiEfOA@ovpn-8-18.pek2.redhat.com>
References: <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
 <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_170851_127385_F02B96BA 
X-CRM114-Status: GOOD (  20.24  )
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

On Wed, Jun 28, 2023 at 08:35:04AM -0600, Keith Busch wrote:
> On Wed, Jun 28, 2023 at 09:30:16AM +0800, Ming Lei wrote:
> > That may not be enough:
> > 
> > - What if nvme_sysfs_delete() is called from sysfs before the 1st check in
> > nvme_reset_work()?
> > 
> > - What if one pending nvme_dev_disable()<-nvme_timeout() comes after
> > the added nvme_unquiesce_io_queues() returns?
> 
> Okay, the following will handle both:
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b027e5e3f4acb..c9224d39195e5 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2690,7 +2690,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
>  		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
>  			 dev->ctrl.state);
> -		return;
> +		result = -ENODEV;
> +		goto out;
>  	}
>  
>  	/*
> @@ -2777,7 +2778,9 @@ static void nvme_reset_work(struct work_struct *work)
>  		 result);
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>  	nvme_dev_disable(dev, true);
> +	nvme_sync_queues(&dev->ctrl);
>  	nvme_mark_namespaces_dead(&dev->ctrl);
> +	nvme_unquiesce_io_queues(&dev->ctrl);
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>  }

This one looks better, but reset may not be scheduled successfully because
of removal, such as, the removal comes exactly before changing state
to NVME_CTRL_RESETTING.

Thanks,
Ming


