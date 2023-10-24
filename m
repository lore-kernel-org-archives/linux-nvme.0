Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A24C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=brQpT58u78/q+COSWBul62CTjmYKrodNPaXRzmh7Sqg=; b=evncrOqinimZ5bXKaO8tHFtom+
	1G9P/XTDT+tazj7gWMmm+PoHDzyQGFH12QqqRsHV/m1r2/BlDZmK6mkoOI5mJ4VhllBCyaxbXOwl6
	eF5g8hLpA6pEKThls4NzVJMUL0xpOsToAFrJ4R6HlH4O6QUoS3gdJ5ZcokN4AoafNGQqXHxrbs2x8
	nHGgWHxQvN0uOkVf0oCGd5HOhWE7VBO5iORYdSJnH5q1Q46OndW+Q9FRreGQPS6uiOVzA9emNNxBY
	Rbq9+O1gMXLkL6uysTGz4SDbSghy2u8A9TwWEuiGTUj57hUEorn5BjMpxuUEFSMlfXTdAKjeJ1NCr
	Z9lqSp9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvIsI-00ABYj-05;
	Tue, 24 Oct 2023 14:59:18 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvIsE-00ABXN-1r
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 14:59:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6D027CE2C11;
	Tue, 24 Oct 2023 14:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB23C433C9;
	Tue, 24 Oct 2023 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159550;
	bh=aa4Ls/pdF9G/SIrSROntnz15DjH0eznKEP+phgpolfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEHqTEi7/hk1CoVb0pNsePlJvj7io3hZWecDvvgOhY/p3+JrE13VoA8nlZQkKQ1Kc
	 N20lmhhpnsGEXCM1klduXJ2WujtHjmFi5e7MJrQym02vVMvVUFDA19dR3ghXWH41GP
	 Y4gx3lXLVrc0CqAe9tClRLCA3ZciOc55PuR2esd4wYNeidzXtZlc1pbuOklmJZ6Qlr
	 Mh04yMnBSZJVKfU9vHb0zoc9inx07jnJQk/tT5ctQX+FeR+Vkfcjjdom45c6CU0XFT
	 hpURYPrIhUUWZzeT2/eUlSrN++ChljRi8XBmXqzCuzP0qqOPqke9NnVqqdAMiR2CTu
	 MBWiZPeqzbfFA==
Date: Tue, 24 Oct 2023 07:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v17 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <20231024075908.68730358@kernel.org>
In-Reply-To: <ZTfNfvtZz7F1up6u@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
	<20231024125445.2632-3-aaptel@nvidia.com>
	<ZTfNfvtZz7F1up6u@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_075914_792728_BDCE9EF6 
X-CRM114-Status: UNSURE (   7.92  )
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

On Tue, 24 Oct 2023 15:58:22 +0200 Jiri Pirko wrote:
> >+definitions:
> >+  -
> >+    type: enum
> >+    name: cap
> >+    entries:
> >+      - nvme-tcp
> >+      - nvme-tcp-ddgst-rx
> >+
> >+uapi-header: linux/ulp_ddp_nl.h  
> 
> Not needed.
> Hmm, Jakub, why this is not only allowed in genetlink-legacy?

Agreed that it's not needed here.
There's a non-trivial chance of name collisions between new families 
and existing headers under include/uapi/linux. Since this is a C/C++
-only artifact and "modern" languages will simply ignore it allowing it
seemed like the right choice.

> >+      -
> >+        name: pad
> >+        type: pad
> >+      -
> >+        name: rx-nvmeotcp-sk-add
> >+        doc: Sockets successfully configured for NVMeTCP offloading.
> >+        type: u64

Everything you have as u64 should now be uint, and pads can then go
away.


