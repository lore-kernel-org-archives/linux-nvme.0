Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF0FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T17rE1FfaFGs+s/SUcMbi3oAi6w8dixBkDWNVOTA66k=; b=s1cuLhLYCSrG27Y1/zzdpuAgrm
	Ga1+new4pMad/QSSaiLvwy7j9x4g1XNf4aOOZhfbUdTFFsO3I1BbP49nXIv43dAPB4mnIL/xlR71g
	t+X1w0jHM089YlJuiZP+R+6CNmDdchcQlo+fDDIsIH4vXC2FgwD3wddl3BQit4bVZB1Ym8cTPcjkc
	5vOMnkTtzXvwL8yC6eDbsBhQCxX/Zsvg7HnZH2+9J4SPljT6pFzgVjhvlgV7A79520IROBU4WZs6w
	nzY3Kfyrd5vGo7qPI5P2XHqxdvM5FeyJm1UQdTNWiZHCTgJeJimZaq9SK0OhifyRK9oyavdz05QkF
	1f5mMFoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqsMZ-00CO8v-VM; Tue, 17 May 2022 08:15:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqsMX-00CO7o-7p
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 08:15:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4CAE267373; Tue, 17 May 2022 10:15:21 +0200 (CEST)
Date: Tue, 17 May 2022 10:15:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH 2/3] nvme: enable uring-passthrough for admin commands
Message-ID: <20220517081520.GA14308@lst.de>
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125@epcas5p2.samsung.com>
 <20220517053147.7925-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517053147.7925-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_011525_462182_D9FB8B4C 
X-CRM114-Status: GOOD (  10.62  )
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

On Tue, May 17, 2022 at 11:01:46AM +0530, Kanchan Joshi wrote:
> Add a new opcode NVME_URING_CMD_ADMIN that userspace can use.
> Wire up support for the case when this is issued over generic char
> device node (/dev/ngXnY).

I would really prefer not adding this to the per-namespaces nodes.
The do something controller specific on the namespace node patter is
a massive pain both in terms of code and semantics.

