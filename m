Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6733BC3ABD9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6aaHbjEGJZYeBWUz6NxyGmQmblUjWo7YOivqDbVpadk=; b=MzwA6TU8pV+kx5ozjt/zH73wTO
	dAw0SwGEdwroF8/r7AWgJT4X4EnswEvKMUYTdVkBaFlhsQrtf4ehbZ9XNDjWuSlpEguJ6R/qY1GhC
	h5QTHMB1UJrdYRkdI1qabMZvYO0VK0Uq2UoqSgOxLsVuznW+gRJZoT8qxnCZS/EHLKVVYgN4ClDp6
	Q2R4M3HYckYa4FBeN7m2LfSAbEdBE0zl4ey5Xrbwl0CtkcFHbipRbQQAo81Sxl97QopG3GBCRRgTZ
	zD/ZUvuLdDEzLUI/5fjYihny9Rxvsbzl8wGIj/91h/8RP+nvYRrkYaJ9bv8h+cai8e882Xk6OEOin
	5fuC4HNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEri2-0000000CoM9-44SK;
	Tue, 13 May 2025 15:38:22 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEreR-0000000Cno8-3fwp
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 15:34:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 33DFBA4D8A7;
	Tue, 13 May 2025 15:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7267CC4CEE9;
	Tue, 13 May 2025 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747150478;
	bh=gEEIuEBeIR/917g9T3uDyl7+AAv6MYhearKZBjlLfWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jff0I0857Z7B5jn//gGLTiVT6HiMuWARv0mJl04kTEQQavaOeWN3TvY97fjUdNf6k
	 p20ztLKzgjNvgud6urPG78qqNScsdL3/2PLH4OD8uz6RX/3A+wW4FHplvcCysEqizq
	 yggEAlU2H3R0RUXolTR17jVa7E9rsEI/GNnd6weqfBWlL16ksaNlwm4ZUE56WYDn9C
	 /GL/ckMtmpvGylYLa3Qej7gL3DZwHSy4QawptHBRWA0eDFQ3mnwTZcItE046McORgL
	 R//xZ7EuDFqjDkzAVh65BdEpOkGt5H8Q3eSEEcl1QA+EMhXHlYkbRLEn2ZKLmmhVBv
	 +vJ2rtXhnq5Aw==
Date: Tue, 13 May 2025 09:34:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: misc cleanups for nvme-pci
Message-ID: <aCNmjMm5aYQFE91s@kbusch-mbp>
References: <20250513070025.830930-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070025.830930-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_083439_981068_3CC200DF 
X-CRM114-Status: GOOD (  10.52  )
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

On Tue, May 13, 2025 at 09:00:16AM +0200, Christoph Hellwig wrote:
> this has misc cleanups for the nvme-pci I/O code.  Most of this was done
> as part of the new DMA API work.  Which then clashed with the per-node
> dmapools, so I'll try to get it out now instead of having to do another
> rebase.  As part of that this also includes minor tidyups for the new code
> from the per-node dmapools.

Series looks good. Just a minor optimization suggestion from me for
patch 5, and commit log issue Kanchan mentioned for patch 2.

Reviewed-by: Keith Busch <kbusch@kernel.org>

