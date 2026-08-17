Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AADAC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfQLRO6q9qA+V9YV58Gg3v+PRHYkUkEi7kRvktH/jNU=; b=Z5ZO2f6cB5wrNbJun91G7S61H6
	/akC86y7NsCEsTB7wjRVp9eW1ULT+oFJKtXORCjeV/d0TrvLSYREj5Vma3xLvkz72R/cPNG8Kdzsc
	Pfga8ku0XDnjzwypKHcrh6vwsQwqIrgYxQkVe4YDygSpGC+fTr9Zo1qinOlm7GCWuhqJ0LdQq90Oe
	PFCfb09AGuj0mMFV7VK42MB9f08K5qMHtnZEe/LH5gRQA+mP8xR5AFkxrmbnwy8tiX3S4pJST2D8P
	SbQ7n+2ZsMGcbgaDvJ0FKTtw8WHB2GH341gJwF3Rkfr1nR0d18MzB98yWE9aD2oB/7M9NYaL3kLgP
	J+XQBKPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsLk-00000005cwn-0Z2g;
	Mon, 17 Aug 2026 08:05:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsLi-00000005cwR-1f8t
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:05:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52E2B68CFE; Mon, 17 Aug 2026 10:05:34 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:05:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/4] block: factor block size and alignment handling
 out of blk_stack_limits
Message-ID: <20260817080534.GB21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-3-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-3-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_010538_587261_AB45FF50 
X-CRM114-Status: UNSURE (   9.95  )
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

Some of this could use the additional space on the lines due to reducing
the indentation, but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


