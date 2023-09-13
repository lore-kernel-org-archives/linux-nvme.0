Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDAACA5537
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5tN0G/GOKnrc4DvPUqe72mcRRs+o+aCK9wguT3jCVk=; b=LycXKzvjEJdwIOrKZgxV5KkwGs
	C61LlTJCzsua/73IAPMpVE/iEZgYgA17Bmdf4hnL1KQj72nElDRUfmnW3YYuElvaFiiz6guLql6UL
	7x20sIw3ti6RT/zQNP8PRTkInx8YwFZb92yoLUyJyKXTYfy3MIDYnowLWQu9YAp38rwlKLSEYxiwf
	s8AvbGEV09dmS9VCJZfmHbBzhGk2HNUCFhfa87dL9i3tUty5eQBItzh2zXxbaZywpHbeB8F8UTP8N
	PFgTL4jCGdMUs4TFpWGZkpzNMCJxslCDQeu0FbHi1hVRy4Hc9EARi9NUHthR/Ntp7u8017XSNRIZO
	gyKojmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNS0-005ev8-1D;
	Wed, 13 Sep 2023 10:50:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNRw-005euM-34
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:50:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C954967373; Wed, 13 Sep 2023 12:50:15 +0200 (CEST)
Date: Wed, 13 Sep 2023 12:50:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	=?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
	Felix Yan <felixonmars@archlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <20230913105015.GA30644@lst.de>
References: <20230912214733.3178956-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912214733.3178956-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_035025_152283_E2B148BB 
X-CRM114-Status: GOOD (  24.25  )
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

On Tue, Sep 12, 2023 at 02:47:33PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some devices are reporting controller ready mode support, but return 0
> for CRTO. These devices require a much higher time to ready than that,
> so they are failing to initialize after the driver starter preferring
> that value over CAP.TO.
> 
> The spec requires that CAP.TO match the appropritate CRTO value, or be
> set to 0xff if CRTO is larger than that. This means that CAP.TO can be
> used to validate if CRTO is reliable, and provides an appropriate
> fallback for setting the timeout value if not. Use whichever is larger.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217863
> Reported-by: Cláudio Sampaio <patola@gmail.com>
> Reported-by: Felix Yan <felixonmars@archlinux.org>
> Based-on-a-patch-by: Felix Yan <felixonmars@archlinux.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 48 ++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c

> +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)

I don't think the NVME_CAP_CRMS_CRWMS check here makes sense, this
should only need the NVME_CAP_CRMS_CRIMS one.

> +	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> +		u32 crto;
> +
> +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
> +		if (ret) {
> +			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * CRTO should always be greater or equal to CAP.TO, but some
> +		 * devices are known to get this wrong. Use the larger of the
> +		 * two values.
> +		 */
> +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> +		else
> +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));

Should we at least log a harmless one-liner warning if the new timeouts
are too small?

