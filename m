Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF2BC5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8HKjv+/0+21ElNzk7ACDSyFIduNQLMInSfgNaHUfto=; b=KKiSTrN9J5NRnsTUtg2rrrZwy6
	MWYbRD+qqxa4+gZCfv9dG2DQFpLPYQDnRzb4Pan/cAgmwvkQc6kVM7f7sNRREoMnE4lX5toDUVqLl
	/b+VEuzpQy/fhVJ8vP0WZOhtXARqOhDEypbRsu1uPyMbfLE8c/OSEyuK0DVqaE+MiEvyB6SgvAP0w
	32qxCX+OU1c5CArbMqbgvrAUBQgdiFCFkZQMKD1QQSii+KS7Mh5KJnLyM+C/LEeQzGMAYjMi4Pau+
	rPGhWQtjOKSe5nFP+snA25RvyTcibQ4uASKKo6kuGZrNS4vBHdaNOMNGhirXYX7MIhJlyxZPppWHE
	lVCXoHHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsKp-00000005crK-42Hs;
	Mon, 17 Aug 2026 08:04:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsKn-00000005cqt-0iFe
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:04:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91D6968CFE; Mon, 17 Aug 2026 10:04:35 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:04:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/4] nvme: factor namespace-head queue-limit update
Message-ID: <20260817080435.GA21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-2-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-2-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_010441_356379_9E9D1C97 
X-CRM114-Status: GOOD (  10.96  )
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

> +	/*
> +	 * queue_limits mixes values that are the hardware limitations
> +	 * for bio splitting with what is the device configuration.
> +	 *

A little nitpick despite already having reviewed this: we can reflow
this comments to use up all 80 characters now that the indentation
was reduced.


