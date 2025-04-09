Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548BBC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUNACYB7ZQ6lX8QcuM3N+m4K+jQ+syftIy3C0OOnZGc=; b=fZ39RJ1LJ2SpZ8wEE2DFii1Cvs
	0nL3Y+VGi6NhPZ1qjIvZaaMcKcbaJXWhL1Z/K89eGrbG6pBktrGthWcitMkpBAh5hmKFxX+6lySLO
	jlCmdEx50Qu+dy3LOhvTtXbeuoFIw9PPa1pHxk6Lq+gR6JAW2/PW/gZg5fwrO67UZtm20bP3K7rFZ
	RAsY+XhB3YWxfwpgbu5aLBNmmWKtD1dlEDIF907ux9IIg5+ptN7aOW3PlbTbDeX7M/qKjb5MWjVoL
	ERdJsfr941nXxFfHegPiIJc+FbZG1agZCxVnanZUvRXrRPxmcR0Qjjj1l9U8yl78RseaUH1r9HAaH
	roKQhMZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2afJ-00000008FrR-29uZ;
	Wed, 09 Apr 2025 19:00:49 +0000
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2afH-00000008FqC-068w
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 19:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744225246; x=1775761246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUNACYB7ZQ6lX8QcuM3N+m4K+jQ+syftIy3C0OOnZGc=;
  b=JPdFcZmqpSR2JXbPT4e9ncslodaLvbc5snw1By66UP6HcWMVqWEdBQtn
   ph32aibXDSBF+3ycFBMipUAOjsQ8WcDHeDz0iqNLffauFNHo1QXst+VpI
   VAXhATXKBAsWEpXj/Zf7DRKJ9rP7xJVQvh83fUn9t3m99ffIZ3nZcC5DL
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="189739463"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 19:00:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:8487]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id ab1dab9e-4ded-407e-9ade-34655e86e8e0; Wed, 9 Apr 2025 19:00:42 +0000 (UTC)
X-Farcaster-Flow-ID: ab1dab9e-4ded-407e-9ade-34655e86e8e0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 19:00:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 19:00:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <kbusch@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <shaopeijie@cestc.cn>
Subject: Re: [PATCH] nvme-tcp: Fix use-after-free of netns by kernel TCP socket.
Date: Wed, 9 Apr 2025 11:59:37 -0700
Message-ID: <20250409190031.38942-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409084446.GA2771@lst.de>
References: <20250409084446.GA2771@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.41]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_120047_104688_B425ACD0 
X-CRM114-Status: GOOD (  10.89  )
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

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 9 Apr 2025 10:44:46 +0200
> Thanks, applied to nvme-6.15.

Thanks!

> 
> > To fix such problems, let's hold netns ref by sk_net_refcnt_upgrade().
> > 
> > We had the same issue in CIFS, SMC, etc, and applied the same
> > solution, see commit ef7134c7fc48 ("smb: client: Fix use-after-free
> > of network namespace.") and commit 9744d2bf1976 ("smc: Fix
> > use-after-free in tcp_write_timer_handler().").
> 
> I wish the netns APIs would be a little more robus to prevent these
> bugs from creeping in everywhere..

Can't agree more!

Actually, last year I tried to clean up such APIs to prevent this type
of issue.
https://lore.kernel.org/netdev/20241213092152.14057-1-kuniyu@amazon.com/

I'll revise this in this cycle once the fix reaches net tree.

