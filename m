Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4BFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 18:06:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A2323741
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 18:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A2323741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LCOU1Blu5WWGBAsglG1BB8elaMQ0KMDtpbbe+DC+L2E=; b=ImuWZUN4qsqm3ts3djW4Thd64
	lf9LpFbK6vVqF9E6S+UhuPTQCzWMsDf4ALjJEFMzlJZAscoLfyTsRouDQSFOgNzlGkJFtp5VZ+1kg
	ZB2+2ppbWpOEkU5KXneJnozwszbheV2nB16/h41lmIjId8xc1lsIqAYbJNu4okv4m8HWcrMyampbZ
	66g+KKQmKLSvPUSRSIHVpUyTGxzg5X9h1siTfK9zzhTCgYn/VnsjOVV96bNvBN4+w9BXetvkhgF3L
	aUWSXVnhoLcavw7R3wcBiwZmaUhSwd1/A3nE/X+AlRsl3uwKAn1ua6hvnvb5steW8g0ZrN7dyMky9
	JImulCmBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l070Y-0000iO-Sl; Thu, 14 Jan 2021 18:06:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l070V-0000hA-J9
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 18:06:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 643A023741;
 Thu, 14 Jan 2021 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610647562;
 bh=4el5QT/zGGohtz3VaF5HnCU9OaZ86zjdyTpAdnLNG2s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JkRd3W7E3Tthr4VxsGrKroQkRbhfXwlp8fzm8duKTreTuHjP3r+La/qCblHbhIMcF
 J9YhQQJixg77YYI74clqHa+ELf3+CQElZ4XPMTvCVyn0FE13/awzGmAt69H3aL+x6F
 RAAI1XIAHi7Xmh5ReHoW41Oxtfs4oEWUXmLmaP+g+xr14X5/N1UmtLilQVx6o3Y2Nk
 7CdqsbrukxItM7g5/netKkTErPiLORdCEPphcLUlp3iA5026+jp7gl19PmjClUV++k
 Zn0xk548Fy7ytZcqWbSTlr1wnjnbG6z21EwLRzZU6IPoh4/+C2pLPkmVoEH0qN7XCC
 PZjEtXFjiCbsA==
Date: Thu, 14 Jan 2021 10:06:00 -0800
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] nvme: allow use of cmb on v1.4 controllers
Message-ID: <20210114180600.GA1511435@dhcp-10-100-145-180.wdc.com>
References: <20210114132441.193782-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114132441.193782-1-its@irrelevant.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_130603_701683_A0246642 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: Jens Axboe <axboe@fb.com>, Klaus Jensen <k.jensen@samsung.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 14, 2021 at 02:24:41PM +0100, Klaus Jensen wrote:
> @@ -1795,6 +1796,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	if (dev->cmb_size)
>  		return;
>  
> +	vs = readl(dev->bar + NVME_REG_VS);
> +
> +	if (vs >= NVME_VS(1, 4, 0)) {
> +		if (!NVME_CAP_CMBS(dev->ctrl.cap))
> +			return;
> +
> +		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
> +	}
> +
>  	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>  	if (!dev->cmbsz)
>  		return;
> @@ -1805,6 +1815,19 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	bar = NVME_CMB_BIR(dev->cmbloc);
>  	bar_size = pci_resource_len(pdev, bar);
>  
> +	if (vs >= NVME_VS(1, 4, 0)) {
> +		cmbmsc = pci_resource_start(pdev, bar);

Shouldn't this have a '+ offset' in case the CMB doesn't start at the
beginning of the bar?

> +		cmbmsc |= (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
> +
> +		/*
> +		 * Writing the low bits may cause the controller to check the
> +		 * validity of the 52 bit controller base address in the CMBMSC
> +		 * register, so write the high bits first.
> +		 */
> +		writel(cmbmsc >> 32, dev->bar + NVME_REG_CMBMSC + 4);
> +		writel(cmbmsc, dev->bar + NVME_REG_CMBMSC);

hi_lo_writeq()?

This should probably come after we've verified the '(offset > bar_size)'
check below so that we're not enabling these capabilities before we know
if they're within the BAR.

> +	}
> +
>  	if (offset > bar_size)
>  		return;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
