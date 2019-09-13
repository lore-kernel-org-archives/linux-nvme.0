Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF56C49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 14:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C76C206BB
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 14:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G9tESYlD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTbtg1TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C76C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HHPgSpX9JAZ7qaU7BJi4A6U0GADBDF2gLwz+U4ra1FA=; b=G9tESYlDKIDDls
	IrjfD5MyFwp0QbFWqneGUE36t6OEux/05Aqo49VaV79I3kIMdmgSf2tLx8rXuv6kH/RO+6JnTBqrC
	rjvnmIpi3ezvMXPVs3xBHPk3H5J2ZvOo1rH64Tn9Sejujl4x5qTRmEPMMrFSv+PaZrmn4x3926oCK
	khMT43fzZZO1UQuMaNPsFpVOXAKT198ytpzm9vt4ydq6EgRrlWbpvBcOkO+1twV0sy/WR73LD02Dp
	NVkN+hBSAp4TCDyQCh1+ZS7tnM35A460IOF99M/g3zJe9dD/2b3rms4CD5itKlkd8Wos7RhVDiCTM
	lSFjHPxkqba3Hd0x7+/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8mz5-0004Hr-VG; Fri, 13 Sep 2019 14:55:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8myj-0004G3-RC
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 14:55:35 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D638F20830;
 Fri, 13 Sep 2019 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568386516;
 bh=gRv/JNoOExhCth8WDVaxabmd1ZJsvKd307jPN5ebLfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iTbtg1TV0dNXPDpCpr5CgZCh60HqiLIYkwTgQr5KmKROONVtfis/Rx/X9wQfX4S/D
 G9y20dAHZq8M1CreVCCx8NbDUNpaIl2Z98hAv6oE136u8hm4E7ZhRloDV2KfL85XlC
 5EtCeGuaso5zck3A9S4xD7CKKQyxUhOWziXHQvcE=
Date: Fri, 13 Sep 2019 08:55:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Balbir Singh <sblbir@amzn.com>
Subject: Re: [PATCH 2/2] nvme/host/core: Allow overriding of wait_ready timeout
Message-ID: <20190913145513.GA17139@keith-busch>
References: <20190913024432.7705-1-sblbir@amzn.com>
 <20190913024432.7705-2-sblbir@amzn.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190913024432.7705-2-sblbir@amzn.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_075519_211047_30025D81 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 13, 2019 at 02:44:32AM +0000, Balbir Singh wrote:
> Largely for debugging purposes where controllers with large
> timeouts get stuck during reset.
> 
> Signed-off-by: Balbir Singh <sblbir@amzn.com>
> ---
>  drivers/nvme/host/core.c | 8 ++++++++
>  drivers/nvme/host/nvme.h | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 45b96c6ac2d5..fa7982dfe551 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -40,6 +40,11 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
>  MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
>  EXPORT_SYMBOL_GPL(nvme_io_timeout);
>  
> +unsigned int nvme_wait_ready_timeout = 0;
> +module_param_named(wait_ready_timeout, nvme_wait_ready_timeout, uint, 0644);
> +MODULE_PARM_DESC(wait_ready_timeout, "timeout in seconds for wait ready on reset");
> +EXPORT_SYMBOL_GPL(nvme_wait_ready_timeout);

There's no need to export this symbol.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
