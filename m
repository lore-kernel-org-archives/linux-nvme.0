Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED51CD4F3D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZLHaDjdkr3447RtW+65AwS9huyVHPlYRX4Cr72oYWI=; b=fkA+j52crLXpV3YPl0XoYAhcU9
	EsxmtttfWcZevV+EV9vscGPKsx6WTe6ExTCg5BH0c7furxbzfyEpMi94XNkE+NXVVtPD25Kjj+Iqi
	9W5vvodtsmoDPg//4I3IFAdsQZgGj8k416oLlwLOGRriFKolkrMVkYIk/64L89BS0AsbVC9H7Z9Yy
	HgbttC+WFoPbpuMb6wcCXK7oX7EsBwZ45o7JVQR9w37XIhWkxurt6DezOFVjqDwo4FhiBq4pWFqSY
	zHv2Jo4Vld0pZCyZDRo/wbZzQ2dz5aZfennK2ek4Z1ODwnw/4UWO/16YmBcApwSnEE5IQg9QmwPZ4
	3Xc4Hzbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPksu-00000005KMw-3O7o;
	Wed, 20 May 2026 17:39:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPkst-00000005KMm-0b7N
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 17:39:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F1F76014B;
	Wed, 20 May 2026 17:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E877E1F00893;
	Wed, 20 May 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779298746;
	bh=9ZLHaDjdkr3447RtW+65AwS9huyVHPlYRX4Cr72oYWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1HXUFA2wWKGUcOvjBQgio0/DWYwFdGv+bnyqm2Li+UFNKeYOS3IRH58Zcvajr2Kw
	 C/yLSO4KVbSLCN/Pn7c7NMU1P5C/I+4QnamyoTV8qCfgZlDa6h5IUoHbx04bCGGLLc
	 WKZfTdiiFKTSrEv4rialmUtkZ/D6jwoIKgrtSDRwG37eJ84VeOgun8stx6TEHHvty8
	 pCyz8N8deAKxhqlFTm04yEIqHHDE9w9JLnpR5o834soqMpWWeYrk5VCQ7EsesYMxxx
	 9WPw2uMfgYlDndo0eWSRwItSX+fv9cVehoz8UUlukn8qgeRqKfGXrEDNZL+yZTBnGR
	 PzZ/KDhX2hC8w==
Date: Wed, 20 May 2026 11:39:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCHv2] nvme-pci: fix dma mapping leak on data setup error
Message-ID: <ag3xuDvbooOVqc4I@kbusch-mbp>
References: <20260519223329.1886456-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519223329.1886456-1-kbusch@meta.com>
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

On Tue, May 19, 2026 at 03:33:29PM -0700, Keith Busch wrote:
> We're leaking the initial DMA mapping during iteration if we fail to
> allocate the tracking descriptor for both PRP and SGL. Unmap the
> iterator directly; we can't use the existing unmap helper because it
> depends on the tracking descriptor being successfully allocated.

I hate to do another rapid respin here, but I gotta do it. The metadata
sgl setup also can leak for the same reason, so need to close that one
too. And there's also a leak for a P2P case that needs fixing. So v3
coming shortly.

