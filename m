Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3431EF54AC6
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOrPkY3bsGlmHCBSd7W2OUbyWriDJMaMBnGxuw2XRMM=; b=HtKYK7vLLxEzGL7MjQYn5kdMp4
	ToD8U0eNB/bOxo5fnQrko61S7h33BbBT1fhr/4N4ic5K9mOB3yOtnyvDsHe3NYgqsjM+YU34Frdqz
	XYfsSYz6rxbKOsNC/TlVBqb4EnOWgccr4M4tREHnasQ1iiTHSPMod4i5QUnL3mu1dQbiJN6fc9TuO
	dS5ARgRB7GY7jL0Os//Kb0GIVWUTIqTp/5VQYnzcuCZSvb3oSr5JPoPSmt2tA+qWgSt5GU93nkwkf
	QdN/89WMYtsP1P0M3RhQ9dym7n6PsGjbbXH7svAtJnzbUyhmQ4nEXiH4/skZIBvJQ2xSayJ36ay9F
	+6pw/2Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w52w5-00000001fic-0Laq;
	Tue, 24 Mar 2026 14:40:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w52w3-00000001fhu-17bC
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 14:40:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C86441A38;
	Tue, 24 Mar 2026 14:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB81C2BCB5;
	Tue, 24 Mar 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774363246;
	bh=QsUM4AaoWAJ6Duqz0b/ac5qONFjO3dFtd6bjcD+Lakk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5IdS4Un5DoUWzsnA4/oOhLECgnDY64Kz/1wxRdil0BEqukrMG4hVc6AU75I1u8S+
	 My7HNMn6ASDpU5JSLjy8JnKiP9cO5yOvCS+v8IdyMuge1w+tBQwDK1Dvd4/jBMPVHy
	 L1pUdzky533xCnAF8LtMW/GS3XMm2gNDmrkQtxviRvNNFpoBSJstuDtWP5HabqWWgj
	 LmYzWXjyt6PoJBPqlCWFntAsf6N1AmeNA8FGCSXbU/I/EetbQRT4sgoakWHIAx+E3K
	 M7fETVG+JituyLONoU2Gz/bD4AtbX50Ra9bgYp49omsoyjqqP3pGNwK6ic/3DmoNGX
	 szhGwjd9Rkbiw==
Date: Tue, 24 Mar 2026 08:40:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, axboe@kernel.dk, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-multipath: enable PCI P2PDMA for multipath
 devices
Message-ID: <acKibPVk578SwyFR@kbusch-mbp>
References: <20260323234416.46944-1-kch@nvidia.com>
 <20260323234416.46944-3-kch@nvidia.com>
 <20260324064937.GB1409@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324064937.GB1409@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_074047_329747_F7460D22 
X-CRM114-Status: GOOD (  14.36  )
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

On Tue, Mar 24, 2026 at 07:49:37AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 23, 2026 at 04:44:16PM -0700, Chaitanya Kulkarni wrote:
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index ba00f0b72b85..c49fca43ef19 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -737,6 +737,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> >  		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
> >  	if (head->ids.csi == NVME_CSI_ZNS)
> >  		lim.features |= BLK_FEAT_ZONED;
> > +	if (ctrl->ops && ctrl->ops->supports_pci_p2pdma &&
> > +	    ctrl->ops->supports_pci_p2pdma(ctrl))
> > +		lim.features |= BLK_FEAT_PCI_P2PDMA;
> 
> This assumes all controllers support P2P, but we allow matching
> over different transports.  So you'll need to do the same scheme
> as for MD RAID that checks that every member supports P2P.

If that is a possible setup, then you could add a path that is non-P2P
capable sometime after the MD volume was setup with P2P supported, so
that case might need special handling to notify the stacking device of
the new limits.

