Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D021DCD5BB1
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gmLwLQPHp3fRnhcCW3TnNhr5isSsd9ildExb8RQPYkg=; b=fIMuCESJGgpdFRCu1Zk8rTdJRr
	NN2dj3UJ6CZoOdSpJUNr1blY2eO+HsoEMhaKepXhMgSEWp9E0nF+MJ5fjw5TvucNcPx9oXuNuta3t
	6FCR7bpmym3ao0dVz40jjcNPtkecwkqyEFgvoAvZKZdjsdLEOziIrhejn/3TAE1c474zd1F/zng3g
	kD9BYWQOg2GtgDUrwXcnNg8JzJbuQNDI0v8ah9SfWiwCfkA4Px6Q0yQOneUU8rcFZhx/SJFq5N5Jq
	Q1nEUZffR7IpRevTlL/dzr1Eg2rsrRT3ZAe9tPSUg+nlm+CP+SZRvP/Gq3e2MgxjmqRvMY9m23c3q
	siJDIXLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQOlT-0000000AkeN-2u5P;
	Fri, 22 May 2026 12:14:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQOlS-0000000Akda-03Z9
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 12:14:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7F5E68BFE; Fri, 22 May 2026 14:14:01 +0200 (CEST)
Date: Fri, 22 May 2026 14:14:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chao Shi <coshi036@gmail.com>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all
 transports
Message-ID: <20260522121401.GC21338@lst.de>
References: <20260515071248.2689513-1-coshi036@gmail.com> <ag4Y5R1X0gkZbU-g@kbusch-mbp> <20260521082549.GA11208@lst.de> <ag8Y5c3sjYFZzan5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8Y5c3sjYFZzan5@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_051406_196990_07116645 
X-CRM114-Status: GOOD (  13.43  )
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

On Thu, May 21, 2026 at 08:38:29AM -0600, Keith Busch wrote:
> This command is already special since we filter for it on the completion
> side. We may want to selectively filter other Set Feature commands too.
> For example, we don't want user space turning on Host Dispersed
> Namespace Support, because this driver is not going to correctly react
> to that one either.

True.  So maybe start filtering out all these things will go wrong
commands.  Chao, can you start on that for keep alive?  We can then
extend it as needed.

