Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B7C021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 00:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bnTC/douU5sWo6Bb9ry/ZlH2yFq4zqGKeUVmF1TYKvU=; b=Ld28VJgD6MvBjZ8W7YEYB+XQ5T
	OOvvmwxGYGRwbLv/PlkScrvmCu3/YhlIsejtjoNeKGkg7pnjx0bvSua8m6H2ZzhspiyknwJ1t1zzx
	PC+wX3ZQZoEHvy4qe80zbWwhg4smXKrpB4CBSWZvooPLN8VIRc5emerRZQSEbCCtCuiJXD5NdqQTA
	8K1QcGmu9HhoGcBGGPK8CRjke+pC1EXU3NXAHS3+vTPvLN2yJFExdXIefA4Zh3FCrbLsTtR3yKUyO
	8Sw1LC7awznX5dCSMGuLzpGbh7WSdxe2rCUO3SkaGrrGN/4mRR0BEuWKDWK1UNmHkuUhuHFi5eXe3
	KcU75sMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmikb-0000000FcFR-3DN2;
	Tue, 25 Feb 2025 00:24:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmikY-0000000FcEr-3YSZ
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 00:24:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4537F5C540A;
	Tue, 25 Feb 2025 00:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C03C4CED6;
	Tue, 25 Feb 2025 00:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740443077;
	bh=s9AubUqdramGpjA8lgQWKWNWaT1wRkkghen5U5eiCUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY1g8LL/GC+LvEPADM+IgOAwSlCZPEvasSikEKi1L3Fp7Pogcy40nzhIMolFkiQzI
	 r9YbAV5QV4z1Q7o57hFrjA5EidwmLuwsYdmrj17XFMDSkZqkyRxBHnj0KKIj/uc4uX
	 PmQRKPXpjTDOY9h2WeRrQ1gm5DUM489nN15QGTF8LXafS/mbdpDgAGZ1d1xPT4kyT7
	 0cQh4eUrIG/tqAnGzwkIDOpusuG1Wm0cNIZLXcjx0BZXlUffu3DZfS+GD2S0w8/f0Q
	 e4Ajk068SlgDMaHLcMBRtOaG96YB4H3cWavAKAn1GVu08J01oFtSA3rmtcubUANjlI
	 m+XTQKGdIhJTQ==
Date: Mon, 24 Feb 2025 17:24:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Message-ID: <Z70Nw_RQ5C1sHiCV@kbusch-mbp>
References: <20250212170444.16138-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_162438_925706_0FBB5DCD 
X-CRM114-Status: GOOD (  14.89  )
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

On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> Here is a small patchset that is developed during my investigation of
> a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> SSD), which is because of the SSD's too-small CMB block (512KB only).
> 
> The first patch is a fix of the PCI DMA registration error handling
> codepath, which is just a observation-based patch (because my disk is
> only NVMe 1.2 compliant, and the register cleaned up here is only added
> in NVMe 1.4).
> 
> The second patch really fixes the warning by testing the CMB block
> against the memory hotplugging alignment requirement (which the CMB
> block of my SSD surely cannot satisfy -- the alignment requirement is
> usually 2M with SPAREMEM_VMEMMAP enabled and even larger in other cases).

Applied to nvme-6.14 with the suggested changes in patch 2 folded in.

