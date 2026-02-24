Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49D5F3C984
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LzM6lm2kJQo5tr5yoKF1wOmicBTjbrgnc0F1Y8P1f+w=; b=E1Cr62M6xKwoqbOx+l2oLTC7t1
	El/wwMTa/ghWPqwnALwwduiM9mVAV4N9ew/NMHjwlRHe7XiYYdAPjxO9rsThPNGOzC8x0sufqBMpE
	FLK51KCjbfR3S3v/fBoUNJJMsgjIV8IkZYfq3CrTk73ujzbXWUVeL3x5luWoVvB3kDig7sf7oOLwx
	LEMBdbclugEns/4ZNq9FcWv7FwxqhCDwK3x5L8O26pwVIqumf8igXEfClpQwL0Yl4ebbdpaaaPLid
	y0BK5SCXNjOr4cmpymKa9wVtdE1uVrfVdcP/0QAQd3vtKgq1DF2bcvBm4yua9FkPhX8fr5DpTUnT4
	zjoRPWow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutU6-00000002EHN-1GOt;
	Tue, 24 Feb 2026 14:33:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutU2-00000002EGi-3yMK
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 14:33:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37C0368C7B; Tue, 24 Feb 2026 15:33:51 +0100 (CET)
Date: Tue, 24 Feb 2026 15:33:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] nvme: set discard_granularity from NPDG/NPDA
Message-ID: <20260224143350.GC11710@lst.de>
References: <20260221033302.1451669-1-csander@purestorage.com> <20260221033302.1451669-6-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221033302.1451669-6-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_063355_124164_3119266F 
X-CRM114-Status: GOOD (  15.43  )
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

On Fri, Feb 20, 2026 at 08:33:00PM -0700, Caleb Sander Mateos wrote:
> +	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
> +		lim->max_hw_discard_sectors =
> +			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
> +	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
> +		lim->max_hw_discard_sectors = UINT_MAX;
> +	else
> +		lim->max_hw_discard_sectors = 0;
> +
> +	if (optperf & 0x2 && nvm && nvm->npdgl)
> +		npdg = le32_to_cpu(nvm->npdgl);
> +	else if (optperf & 0x1)
> +		npdg = (u32)le16_to_cpu(id->npdg) + 1;
> +	if (optperf & 0x2 && nvm && nvm->npdal)
> +		npda = le32_to_cpu(nvm->npdal);
> +	else if (optperf)
> +		npda = (u32)le16_to_cpu(id->npda) + 1;

This code looks like black magic.  This is mostly a fault of the spec for
using the weird matrix with unnamed values and the weird "0based" values.
Please add a comment referencing the figure in the spec that this
decodes.  And maybe also a from0based helper mirroring to0based in nvmet.

