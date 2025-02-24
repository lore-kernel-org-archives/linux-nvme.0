Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2BCC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vPv5G/51BYQ6AgmMPGEda5dbdXhtevdJgV7qgkZMygg=; b=WkFKTGPTjwSCja/s7OtVgkWMaJ
	k70muif0EVcKn8cCnKBIu2qbmoxSwARPvD68mg0xg6Tv8MizFDICj5camtYtqjK4Ro2Yj4CiqJITG
	/gBSvrwHHjuofx4/czja5q0LczwDO6oThBvPGW3sTr10MjMDYkHwzhorp2AYYipM3mkDzgFo7Qx4B
	yCPpOPcIXIyJ6y0yebt0eiWULVHG+8j/AAb73SrBPgmseqeQz3YrSuvLyuek3Z8DG4EyCVo72sfFb
	ig6ab2JjKesskODTCiwJBxTMq9B2tE9qctdrehTOGapySEltOaHtnZfy+mX36RMynIAOAB4sBvp2e
	7UCyM/wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh4V-0000000FOks-25Ul;
	Mon, 24 Feb 2025 22:37:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmh4S-0000000FOkH-3Pch
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:37:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F7B568C4E; Mon, 24 Feb 2025 23:37:01 +0100 (CET)
Date: Mon, 24 Feb 2025 23:37:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6/6] nvme-ioctl: simplify parameters
Message-ID: <20250224223700.GE15518@lst.de>
References: <20250224182128.2042061-1-kbusch@meta.com> <20250224182128.2042061-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_143704_990861_E43F6DFE 
X-CRM114-Status: UNSURE (   9.12  )
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

On Mon, Feb 24, 2025 at 10:21:28AM -0800, Keith Busch wrote:
> +		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(d->addr),
> +				d->data_len, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,

Overly long line here.

Otherwise this looks good.

