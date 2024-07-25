Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CF3C3DA5D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u1qXkjROW7KjPU4DSeaXivAUTvOHYsqVpEaoCYpMneU=; b=ySs6/XnCcK6q3aflikk44Dxj5L
	jJiiEF4sNgQ/iDnresM2vT2Sh7tOUQe1+LYbkzMQF93A2Sj25XyLUKZzv6qUyHQQZS0II9eSeA+1r
	Eqaaq9xC4Oa9Bh1zyMMUr/rmUEDwQ9Gnxr5MnNWJpbaSpzt6qmZOqmc8Pf3TPqOQZuXivJji8kAfQ
	fyNTOqyyHBFZJFTFdWHfOogr6QmrRo/bTlpqOURImG9A75ktlDUbEFyNyD1RGsXZ2NfhkbI5EKrxm
	2DAHkExxVo7en0zeFShrw0/eDwQ5037vqGaK4oOTM11qo9/1UxOif8uj3QIockeq65IXbIpH7Zjxr
	KVTl3qJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzTO-00000001GeG-49CZ;
	Thu, 25 Jul 2024 14:29:38 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzTK-00000001Gcb-3fZh
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 14:29:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 15086CE10F7;
	Thu, 25 Jul 2024 14:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807BDC116B1;
	Thu, 25 Jul 2024 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917772;
	bh=YPVwZISppMNNtJugbjRyRBJF+SaRqxTdU9F8rN/Mnkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0uEhNqgT5Few0Nfy/+a6Yu5XDnK3jQeKnhnYFP/IeX6rFYlhAPtm33PyE1ymY9Ko
	 4zy0S/xGEKohwF54s5rCiqdQdLCGe6emL8Cgmneo/wkcErL0++/wUZ2Ct3MbO+wMKi
	 1kVXXGBazcHEC/x3sRi4x2FpLKemi8cL4Fi63rvcI6koIv4ND757aMlUl3oA/xh0wt
	 l5oDgc6OZwSEl3wbWWiwQY8Rs32Ixv0adT6z1sYBb1LosFZgziBIfhYJ0MJ3vZVDPG
	 o+ht2mJ9b62en7rLGxONFGfjeh2YPA2DC01VNL0ktc1v6Fb0QmSgmsKJnkjyYHuFD3
	 j02P+8i+PVgfQ==
Date: Thu, 25 Jul 2024 08:29:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <ZqJhSZw7Gww4SBTE@kbusch-mbp>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_072935_109502_E0D61818 
X-CRM114-Status: UNSURE (   9.87  )
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

On Wed, Jul 24, 2024 at 01:31:14PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> nvme_map_data() is called when request has physical segments, hence
> the nvme_unmap_data() should have same condition to avoid dereference.

Thanks, applied to nvme-6.11.

