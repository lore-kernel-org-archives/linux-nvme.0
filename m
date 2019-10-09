Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE8ECE58C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 22:17:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239D42190F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YfJv1IKh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S990ZtpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239D42190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ffigrLcQX5Z4ZJnjd2nC18tl5YsxrSp4Xg4w9HA+Y2c=; b=YfJv1IKhfcefUM
	Feqr2RqfNG0M3Py2ehIixQvu1jYpNpnZEu92ooA3hWkhgc6Kpn/ebdx9C89WK7hRsXWrVA54ehk8j
	smG7yhpKNyNSer4p1JHucGB1XFMVGPYQox/sIIHRDM2VFyD0lE4bihnWhVjhTmRGQWGyLzJCHtCN6
	KJEfVYQhqJGezu1hWQ1Zlp3HEMgFVFFRRa5HhQtumlGGl5EA4kvZtrqQRePE+BidzOkClMjTmvYzl
	hAUBfeGHS2WZ5B0nFFi7+9WrjgTKXLP+lO1knMxwFtU/tfsfpVOkn3cS2hFNMVy48Fk0pufjU9SzQ
	IYzcp8Ms4iypQc1V8lZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIKGp-0008F5-0I; Wed, 09 Oct 2019 22:17:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIKGm-0008Ef-PW
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 22:17:22 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 32AFB206BB;
 Wed,  9 Oct 2019 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570659440;
 bh=K+k72fcp+4Bp9jdYOpjx7BxUtFXIveVOtK1lbT5mR0Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S990ZtpDdrW7y3rQw34PT+ReoELxPvgGK9t9BRJhik6B/vPr79r7xOnUltJb2qJKe
 0+mSjjhsfj0ZOXSQsgpK4NbbIhV4KpYb7GHpiW7tzuuNHeVjuIfmB2r68nbBWTHagv
 P3MT4dSOtAuE8NK1D3e+Fb0lKB5A5tetQzLdzU7E=
Date: Thu, 10 Oct 2019 07:17:16 +0900
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v9 03/12] nvmet: add return value to
 nvmet_add_async_event()
Message-ID: <20191009221716.GD3009@washi1.fujisawa.hgst.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-4-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_151720_867385_17A37235 
X-CRM114-Status: GOOD (  18.61  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 09, 2019 at 01:25:20PM -0600, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> Change the return value for nvmet_add_async_event().
> 
> This change is needed for the target passthru code which will
> submit async events on namespaces changes and can fail the command
> should adding the event fail (on -ENOMEM).
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [logang@deltatee.com:
>  * fleshed out commit message
>  * change to using int as a return type instead of bool
> ]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Looks fine, but let's remove the version comments out of commit log if
we're applying this one.

Reviewed-by: Keith Busch <kbusch@kernel.org>

>  drivers/nvme/target/core.c  | 6 ++++--
>  drivers/nvme/target/nvmet.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3a67e244e568..d6dcb86d8be7 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -173,14 +173,14 @@ static void nvmet_async_event_work(struct work_struct *work)
>  	}
>  }
>  
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +int nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>  		u8 event_info, u8 log_page)
>  {
>  	struct nvmet_async_event *aen;
>  
>  	aen = kmalloc(sizeof(*aen), GFP_KERNEL);
>  	if (!aen)
> -		return;
> +		return -ENOMEM;
>  
>  	aen->event_type = event_type;
>  	aen->event_info = event_info;
> @@ -191,6 +191,8 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>  	mutex_unlock(&ctrl->lock);
>  
>  	schedule_work(&ctrl->async_event_work);
> +
> +	return 0;
>  }
>  
>  static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index c51f8dd01dc4..3d313a6452cc 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -441,7 +441,7 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>  		struct nvmet_subsys *subsys);
>  void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>  		struct nvmet_host *host);
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +int nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>  		u8 event_info, u8 log_page);
>  
>  #define NVMET_QUEUE_SIZE	1024
> -- 
> 2.20.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
