Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E199EC48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZoVh706DGYj3IGQqcjEkFGEvHLyifaYuFVMk5H0idI=; b=OWVL3qyG5jbcABBeBvTsePUNCU
	YKYG8xT0J59CectOg8pgbbBYH3BfoCxhZClpS4XyzvPGFmzVo7/l4Q7Z6CjtfkLa0DNW6FJt++/eG
	Cc/BDaRftqBLpnAgihUnWoQIao3OfRD+CBVwuj1jwxqnFKmK5mcckQ3CRQfWE+mRY4uTmihoE8ddg
	A9hLDoXsa+As8DpFP9aOhx4I1GYQF3Iv2w0uriEaMd24iVMfKldnLIX56y+80so+lcTDMD+qm2S/3
	+iq3SPAcQquY7gLFRm3W1KxTiBJIGBNtGKIzW4zgQiovifmmpKxDZck5dmmTkOIrLwNGeKjcJvAnw
	Td6zJ9iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQPM-00000004SHd-3IFu;
	Mon, 12 Feb 2024 07:07:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQPK-00000004SH5-1iOl
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:07:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79819227A87; Mon, 12 Feb 2024 08:07:09 +0100 (CET)
Date: Mon, 12 Feb 2024 08:07:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] nvme: Add a new exported function
 nvme_ctrl_shutdown_start()
Message-ID: <20240212070708.GB17718@lst.de>
References: <20240207214044.2374295-1-jallison@ciq.com> <20240207214044.2374295-5-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207214044.2374295-5-jallison@ciq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_230714_615430_14B73A85 
X-CRM114-Status: GOOD (  16.96  )
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

Normally we'd just say add a new helper instead of exported function.

On Wed, Feb 07, 2024 at 01:40:43PM -0800, Jeremy Allison wrote:
> Sets the shutdown bit but doesn't wait for ready.
> Use from nvme_disable_ctrl(). Export nvme_wait_ready()
> so we can call it from drivers/nvme/host/pci.c.

The nvme_wait_ready export seems unrelated to the nvme_disable_ctrl
changes.  But looking at the next patch, it seems like a helper that
wraps nvme_wait_ready with the shutdown-specific flags would seem
useful over open coding them anyway.

>  
>  int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>  {
>  	int ret;
>  
> -	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
> -	if (shutdown)
> -		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
> -	else
> +	if (shutdown) {
> +		ret = nvme_ctrl_shutdown_start(ctrl);
> +	} else {
> +		ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>  		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
> +		ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);

Please avoid the overly long line here.

Looking at the result after the series, nvme_disable_ctrl now has two
entirely separate code flows for the shutdown vs !shutdown case.  To me
this suggested we should just split it into a nvme_disable_ctrl that does
the non-shutdown disable, and a nvme_shutdown_ctl that does
nvme_ctrl_shutdown_start + the shutdown version of nvme_wait_ready and
let the callers do the 'if (shutdown)' for the cases where it is needed.

