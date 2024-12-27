Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD3E7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2024 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLk1BoQaNKqolqfTEW1uRNWFBso/pq2CWF95iM/pcGg=; b=z2MR5L/RBZbFBI516+RwfMZKiv
	mti285YfFlKHJ2SSie25FXBNN8TF5F3X346xsmnQGa/lmf3+QyVFW3QYLEkrK4//hZA5rD8HlDESX
	5FESO4TKXF3ZcFmRJkCzDT9R3MTw6My/qiPyxOBSQ1u8nFbKF7WrX0GGMnpFs18WsC2fgfifD/vQu
	DlnQsntTyuRDO8IxIpk3bILHKl5Cyy47G4QGd8wDD0/CUzlO+RqffQFD5zjEFW4lzKT2s9qeMxkBz
	lH6vpKrYgssxInHkoakWnczveTl4cpqM2SDD1ViSx/7VV7mSqgRuwpsweJgEX+KVIs5P6BKn9o1lj
	mlPabnpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRHmE-00000000xY4-2ccI;
	Fri, 27 Dec 2024 21:21:46 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRHmB-00000000xXM-2nRC
	for linux-nvme@lists.infradead.org;
	Fri, 27 Dec 2024 21:21:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0B07AA41A32;
	Fri, 27 Dec 2024 21:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00142C4CED0;
	Fri, 27 Dec 2024 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735334502;
	bh=Sx7P8Jb2kh88MNci6jSEu1HF6EzRH6eagWIX3budWKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrtaHm9C7VhpZGgjA6gno5FR/7oJLXAodIER+BPMtoG0/y3j5Fn6xp5ITakLYy0FP
	 GYh0XC3sBy95RT9knr38w8QsjiJaVTEFKQNpl3HVKEIBzsHcBq1rBZBcuO3UP2rIXJ
	 3JDBdzilsN+mFf7U1DtF5QDyV6wwLVTovkECEdhyMTsAtIa/Qz14+X2olcXTUQxqRl
	 ihksMpQCF4F7fqfjmderRr8bxlTSCR/oSW6qMIuPRbh0hVa7+jYAvu/nPRoSX9Kcfm
	 gNtOMJOWoPz6vxm3d/zAbibAQHZwT/0C+2bPCxoYsWGDQxoHBXq9wq0j9R8gSWNuZu
	 Blh2JGchb6NGg==
Date: Fri, 27 Dec 2024 14:21:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH v2] nvmet: propagate npwg topology
Message-ID: <Z28aY_dTId9EAANM@kbusch-mbp.dhcp.thefacebook.com>
References: <20241218023325.3671826-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218023325.3671826-1-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241227_132143_777444_35A69D33 
X-CRM114-Status: UNSURE (   6.20  )
X-CRM114-Notice: Please train this message.
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

On Tue, Dec 17, 2024 at 06:33:25PM -0800, Luis Chamberlain wrote:
> Ensure we propagate npwg to the target as well instead
> of assuming its the same logical blocks per physical block.
> 
> This ensures devices with large IUs information properly
> propagated on the target.

Thanks, applied to nvme-6.13.

