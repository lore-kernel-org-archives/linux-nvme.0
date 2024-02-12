Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA45C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JylcdLgVxzI5ajrBC5RdUK31pVUFau0QWGEQuWjgDFs=; b=pYnAgSrYvoiFbHSod3e7he6TuW
	iNMcRpvJmQ/5xLXa7bkuSdsHsMabeamkjiY9LOwiaOSkR19SHfKL7l7fnSVnLn5+zw4bG+cjtlro6
	pq9IPjaZbpWsyQK1pD4LUqpQ2aR0S0Gxj6U+ybDU3weES75EhX9gdnj5LWbepJtNHKh8d/eFPh+Yf
	3mxo1D3K8pJZUsE6Sjp1iRHs07sxu9If6r6nY8WJa46QR2+lpIuHquEmBP6FTU+eAFgWosup2SRP9
	KJr+BFBb3XXRbx20o/bxifAC1ae8XaHiEHRolu9jNhpUynT7239GwItw1u3HVVtOaDpEWwVGBG8cs
	WX23jt3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQHk-00000004Rp6-2qt5;
	Mon, 12 Feb 2024 06:59:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQHi-00000004RoV-01Ua
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 06:59:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FBAE227A87; Mon, 12 Feb 2024 07:59:19 +0100 (CET)
Date: Mon, 12 Feb 2024 07:59:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvmet: nvmet.h configfs helper cleanup
Message-ID: <20240212065919.GB17561@lst.de>
References: <20240211233949.18219-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211233949.18219-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_225922_212430_B5AF8CA8 
X-CRM114-Status: GOOD (  10.99  )
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

On Sun, Feb 11, 2024 at 03:39:49PM -0800, Chaitanya Kulkarni wrote:
> Functions to_nvmet_ns(), to_ana_group(), to_subsys(), to_host() and
> namespaces_to_subsys() are only used in target/configfs.c, move it 
> to the appropriate file instead of bloating common header.

Does it matter?  I find having the helpers to do a container_of right
next to the structures they are used on pretty helpful.


