Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C569C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h5Z4x4TrHEM0QGCxwCBnlIpqGJNZ0Ok9H59ynJJgwTE=; b=BIGgCB+aU/LtAajL6JtboK1TAa
	crsl7D+DlaVB5aq4rMqj0L++IX8rWBi6SyTKAaP7mmQMxG3FnYsIsr3kKH+6JVeGKykqFZH3YLSdz
	4G69+UIw6e85ma/8c7DTLIHA6gAjualxV9/oudBx86O+Bklsgjw6WrY9A8fvRgv3uZejBdxBpxRj2
	VrA7OG8wbeyzqJtlGNnE6ruLh1dXFz/rwcnLu/gcZJfZy3A5Va0SD931Xf4pTwZnB0wNJu8t95sbE
	58XpeMIzPRajRAG/Rtk8Z3knJoqx8L6SEqfUOXbC6UO3ipV2L+et9WBuuMlnyQ7j1RMVOeZv0cw8t
	2UPJW7uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osrvx-00H7d0-Fi; Wed, 09 Nov 2022 20:44:29 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osrvm-00H7OT-Gl; Wed, 09 Nov 2022 20:44:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F3681B81F78;
	Wed,  9 Nov 2022 20:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145AC433D6;
	Wed,  9 Nov 2022 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668026655;
	bh=krm+75IOYB/iIhFh/VU9m61Q/TCK0v9yEKPn/PEB9xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbl0oWDNiPapNSR7NeSHk/ICzF6ywlXQzb+V/kH1H7MbuT6A3BBFNyFyCRWmEB48V
	 kPVgAwXkhEJUy5p+RtbYrMu2cssFZiklqtTSlMHNfO4ss4qlx9dq0ErKbNUqKjYyVP
	 FkkRQkx64oBvup3t/HeEj79VEHTNZabq2NlVwFqXxXWytKozx59vuHVnmMq7Ybv9uZ
	 EHJSJYlvgOqiK/EqD3z4+4pcPhd0rO3prbHhr4X5GRtr71996U26feNRaBOEHPhJIc
	 6uO2yEppYq+Lvk7uuA31bnwoFkn3dzAatP5247dYu8qR0BQubhx+W6mOPgbuGAJMvv
	 IpAP+ekGh6Xyw==
Date: Wed, 9 Nov 2022 13:44:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/12] nvme: move OPAL setup from PCIe to core
Message-ID: <Y2wRHHdAGHqJA/7Q@kbusch-mbp.dhcp.thefacebook.com>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108150252.2123727-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_124418_723642_B6636EC8 
X-CRM114-Status: GOOD (  14.98  )
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

On Tue, Nov 08, 2022 at 04:02:42PM +0100, Christoph Hellwig wrote:
> -#ifdef CONFIG_BLK_SED_OPAL
> -int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
> +static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  		bool send)
>  {
>  	struct nvme_ctrl *ctrl = data;
> @@ -2198,8 +2197,21 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
>  			NVME_QID_ANY, 1, 0);
>  }
> -EXPORT_SYMBOL_GPL(nvme_sec_submit);
> -#endif /* CONFIG_BLK_SED_OPAL */

It looks like you need to keep the #ifdef. The compiler knows it's not
used without it:

  drivers/nvme/host/core.c:2183:12: warning: 'nvme_sec_submit' defined but not used [-Wunused-function]
   static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,

> +static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
> +{
> +	if (!IS_ENABLED(CONFIG_BLK_SED_OPAL))
> +		return;
> +	if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
> +		if (!ctrl->opal_dev)
> +			ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
> +		else if (was_suspended)
> +			opal_unlock_from_suspend(ctrl->opal_dev);
> +	} else {
> +		free_opal_dev(ctrl->opal_dev);
> +		ctrl->opal_dev = NULL;
> +	}
> +}

