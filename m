Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82684C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5q+V3Ge+X8xb4VMAig7hZ3XzCSyiMe/fOAa2iPpHwkw=; b=uN1ZsT6vsHoQ6f+6HXtdFR7RJg
	bFWXx8GLxtr3UJSHXEb+KqGSRvYjdwfuJQfhAryVolb9vpfbQo/yD2VJyCpcB15suU3eFuvoxyLvT
	PUrRMGbu+ElCcZ+oAm9+TWUgyjmT3WbhH0Gn0bGU6CxaGfjdAWhlL3IEMqxNLw2QaKTg8kvsMrdGY
	KPvEYTJF5PD9zWspZUfjH2pu1iR9wcdF4zrHV4wj5b2eNEFigC/4nvp2fpPUqjFtBdYcUhCYwUEHC
	ibGspks5/YQyKiiUQEdkaPEKvAUH2Z3s+AqIdabNFII4Q7SMBjgwRHrvKTCHfNef05WKKFp4kzIfY
	k5rAfI1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1r1H-00000001V2p-1AD2;
	Mon, 07 Apr 2025 18:16:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nVZ-00000000k8U-3ouS
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:31:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E68A867373; Mon,  7 Apr 2025 16:31:21 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:31:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gechangzhong@cestc.cn, zhang.guanghui@cestc.cn,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250407143121.GA11876@lst.de>
References: <bd5f2f8a-94f0-43b0-af02-565422d12032@cestc.cn> <20250403144748.3399661-1-shaopeijie@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144748.3399661-1-shaopeijie@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_073130_090406_7E61B6EF 
X-CRM114-Status: UNSURE (   9.36  )
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

I had another look at this patch, and it feels wrong to me.  I don't
think we are supposed to create sockets triggered by activity in
a network namespace in the global namespace even if they are indirectly
created through the nvme interface.  But maybe I'm misunderstanding
how network namespaces work, which is entirely possible.

So to avoid the failure I'd be tempted to instead revert commit
1be52169c348 until the problem is fully sorted out.

