Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A893C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8cx8uZ/hP0l3rzF7IGA4xT8TUBgpJ61rkW18xmsYuYQ=; b=HWvIA4H9C1TuRDT9aEIi2fyxmN
	KWTYGhJjcqGVW9xWQL7/3Xb1H/2aloFusa/dCyg770A90ceyOw2MWUrPfMLwbWJtifLhFIFm0UgOu
	5x3AZf9jOIRVg9o2CprUwT1o3jNToE8D5uW5aQ1NM66tl6eSxSTRADdWAopOi85Q7Wm1HU46lOQ04
	Qds4DLtifpJe/ofMwnek/A79XQ3RqYgS1YgnsXbyFa6eYBnFSI5bHuxLIeUyfmUW2gh6zSuHwrPkE
	Eidzsl1/lw5jV7VMNPchksxEmeeC4sqXTnGM4fDChMG+D3g4fsxVC1X2adpFqkQv4r+f7a5iJbQjL
	IsgxBnsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkCV-0000000BdWx-2cpr;
	Tue, 13 May 2025 07:37:19 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkB8-0000000BdJx-0XuG
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:35:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6909EA4C8B7;
	Tue, 13 May 2025 07:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBDBC4CEE4;
	Tue, 13 May 2025 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121753;
	bh=it058GSJsV8nGvpmAQhb944E+uouOnF1lFpRUt50UKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piDB4V2KGfq6qQtn1QKvV9etcQ68Y7/f8qhOwvMiqjwVp7wRU1LkC+uCIdWcjG2pf
	 UUqoZ7ffXfPGA703EzKYxRu7QD2S01nkTzQtLmeMYOJc2kv2Bj8Zo2AXpxnt/T+H/W
	 POqirsqkZAxxqj9gVP7Of6oY8NFznBrYLFXh16AINEte48Foaat47QvIH9+RdW0ZVs
	 ze5Y1nBSgeI45O+L+/nQSp0sUVeCvJNWKaGusaXjmW/lBmQI6DzWGmm2Ksi0HsnTgD
	 L4p3EDk8XmAKqcdHrc14F6bwigC7zd5L28uTVCmmnUCXZNPmoYXMtSX+hs1uJywEVU
	 nr0xG6GTfA7Qg==
Date: Tue, 13 May 2025 10:35:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/7] nvme-pci: rename the descriptor pools
Message-ID: <20250513073548.GI22843@unreal>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513070025.830930-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_003554_228847_927ED739 
X-CRM114-Status: GOOD (  11.38  )
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

On Tue, May 13, 2025 at 09:00:20AM +0200, Christoph Hellwig wrote:
> They are used for both PRPs and SGLs, and we use descriptor elsewhere
> when referring to their allocations, so use that name here as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 84 ++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>

