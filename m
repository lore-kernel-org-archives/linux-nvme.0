Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E938C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 05:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxH9FevIp7CUsiuRDMadvyZfE1qVigtBKowvnCNAuQA=; b=m/ktlO3ZOrM7sA8xcdEEFJGOuO
	fRuhKyj5sh6qVXVGY6TXsuBYtik30grKb8mHOOkcdaj+ef3anp54WBSVLVQRI/yB09pszaFFsapdY
	s3tbgKoLzHkz7AYUwVsvrsgOVO5eze2rAGFkt2q56m/QDfXYSZ81JxeX/6ipGKIkev2oIEZNOt0xh
	Kq3GaN+o8y+NPgGM3WNVPli6GuqLh8+EAMuW7CgMh0H5zSDShIJJ9jx8AkKzfNcfAgqvLMvwP1Uuv
	IXuriMr5cXjHLlsxfYRZgVKDQivAKw7oLBNd1oZUEd1gH16NWqNo1Me9jB6FCJh102gXiENHN/I/0
	nsXZSToA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuSp5-00GhbD-AH; Fri, 27 May 2022 05:47:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuSp2-00GhZo-6w
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 05:47:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 496C668AFE; Fri, 27 May 2022 07:47:28 +0200 (CEST)
Date: Fri, 27 May 2022 07:47:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: set controller enable bit in a separate write
Message-ID: <20220527054727.GA14930@lst.de>
References: <20220526135721.390434-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526135721.390434-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220526_224740_439587_08B72B1E 
X-CRM114-Status: GOOD (  13.26  )
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

This looks sensible.

On Thu, May 26, 2022 at 03:57:21PM +0200, Niklas Cassel wrote:
> @@ -2227,6 +2227,16 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>  	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
>  	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> +
> +	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush write to device (required if transport is PCI) */
> +	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CC, &ctrl->ctrl_config);
> +	if (ret)
> +		return ret;

Maybe we do eventually want a reg_write32_nonposted, but for now I
think this is sufficient.


