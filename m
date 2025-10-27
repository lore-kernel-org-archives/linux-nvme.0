Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC3CCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zj9IGb/Ok619mk5R6elrfkvXOCMvUww1+DNFRuRfP8I=; b=ZiOKqqVisHA3xqYokdiyb4KZrT
	Fzw/VcsHlxk2fm+fZiEiLNhjvBOTQCz9upF8URnIp9cO2LejM4KmQC8oPNBRUOJSj+v4rUVnGjtLq
	L1y3DLmEcBJpAuXUYySNXmLbalT0TO1PQkv3MY+/pu+iflqOGzEA1vg5QvZkeQyXDJykuNE2Ho5tu
	VIm/lmLcLuhG2+gIivWqHWvz/JhNIwYWARuxKDJhXv/c7ukEHSXZbDaMiPcKMBQfxzuFoGtGzzvbZ
	5JljqVDdkYMmQx3SHxmtxPfYvYJBDWRT0JUDWWO00Ddza3gZ/v7eg80TBN4jW21figoDRIkKdTynU
	jatPpFmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIUf-0000000DL7x-1gdr;
	Mon, 27 Oct 2025 08:22:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIUe-0000000DL7p-3GWf
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 08:22:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D26B1601DF;
	Mon, 27 Oct 2025 08:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFD4C4CEF1;
	Mon, 27 Oct 2025 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761553339;
	bh=ql+BZhNvD24lFAr0m8oGRVb6NxzFtRyzqioXOwAhNrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuP+2aKO3ar4pbdjUcaMokMQO54MmE0odQM7D+wdywnTnF0mKUQKYcbcBOawGW6OG
	 Tv3Il0jJq//3vBQRCfwY/5RYESQR1uD1i0r6X5LIviRVSlIWDPr6cVbx0cQMgcKOMN
	 ApWOakX3ku9paZwpZjr7knCtPUh66YwHx1gv8jIb/ElHevhMu9exGzPZG6tlrcnW1J
	 u+l8UV+XPKZhuHEqsy9bez1xS7T+9nqokVY5Rf1aukVTLAo1RlD0kvJDYUAXowsLtn
	 lBR+o0X3Fk5WqpOH+jSQHDwn8jIKvI58mWnRdbtTVL3docQv+X0pNuFOGS9Z1Bsqdi
	 sU8UO/g6yEpeA==
Date: Mon, 27 Oct 2025 10:22:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027082215.GH12554@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <20251027074922.GA14543@lst.de>
 <20251027075738.GF12554@unreal>
 <20251027081142.GG12554@unreal>
 <20251027081658.GA15229@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027081658.GA15229@lst.de>
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

On Mon, Oct 27, 2025 at 09:16:58AM +0100, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 10:11:42AM +0200, Leon Romanovsky wrote:
> > BTW, one can reorganize pci_p2pdma_map_type to make sure that
> > PCI_P2PDMA_MAP_BUS_ADDR will be 2 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> > will be 3, so it will be possible to take 2 bits per-type instead of 3.
> 
> Maybe.  I'd be happy to leave this as-is and then see if we can optimize
> things once we grow more users.

Completely agree, thanks for the patience and review.

