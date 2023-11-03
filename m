Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B86C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2e73cmBDm/yr0/trFD+4OnowXeka72n8zInu0EDWWM=; b=Ip6+YV1IdVPuprUs105AiOxsYz
	11jFYR6va6OnGiyDL4CxYQvZ/vvGT/JlgvUGRbmgbzscNM9P5q2B7dFTcTgLhk7ibuGwbRdiimxWh
	DpjVHDcRnUCaZpGfm9EDr2IjRdYxOjYs5aAyFGURAhhIOBDrpIF75UAQFw6GFky9OgAmVIAoI1IVJ
	aIlkAqQ9zl+3lVBRxfM1TBKwdUIjVpsBjxuXmcAt6Cx4UhJ976qWWeLT/BdV6r/d9VAy1VZongCm7
	UvEU5z8zZ45NlLWUE33kgnnhbJ30u/d3K2cyTh/q8FhCmd3vmGi1EC3g06kv+tVF8vyGrZtOG78fl
	ZZQ3APxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyunb-00BXb2-1q;
	Fri, 03 Nov 2023 14:05:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyunW-00BXaX-0S
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 14:05:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8C4E67373; Fri,  3 Nov 2023 15:05:14 +0100 (CET)
Date: Fri, 3 Nov 2023 15:05:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Message-ID: <20231103140514.GA2395@lst.de>
References: <20231102141903.66515-1-hare@suse.de> <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de> <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de> <20231103091952.GA18200@lst.de> <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_070518_318315_F73FF7B1 
X-CRM114-Status: GOOD (  11.55  )
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

> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing 
> controller teardown") this is just for reducing the memory footprint.
> Wonder if we need to bother, and whether it won't be better to remove
> the whole thing entirely.

Well, Sagi added it, so I'll let him chime in on the usefulness.


