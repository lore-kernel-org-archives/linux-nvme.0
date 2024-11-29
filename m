Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF18D6EBEE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mn5m/Q/OH5xXV0mJt78NBQKeLm
	XCzdjVSVhNExIZy7foK69RB3PDVdBLg90VUxqVli89FbPhXL3HMFuCIdqomKWHuq1r/5sMgenEMaw
	DvJiRLVpYJNPy3HGrI0uRDKZpVduc7Y9of8NQrbmbsyqlWvkROb0JdWR1FPc58QCzdYkBqGlyl5zY
	jm255NJlQImL8A3fNTWMULCH633bmeY02jMQnSakb0tip4u1V385HOovH2NkfeJztkzugu0TnrPlR
	lgKDLCFWgX2sLX0aXZ0/+Y0gB1T1DvzJZQG+5lUfKLrsowTqWYUumjcR/9II6uaJCzWVWK0IqeA0E
	kiGfUg9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw68-0000000H92S-2fLM;
	Fri, 29 Nov 2024 08:11:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw5x-0000000H90B-13qo
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 08:11:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B587268CFE; Fri, 29 Nov 2024 09:11:18 +0100 (CET)
Date: Fri, 29 Nov 2024 09:11:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] nvme-tcp: no need to quiesec admin_q in
 nvme_tcp_teardown_io_queues()
Message-ID: <20241129081118.GC6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <7e662471e392c6b45fc37de94139e886c53c9cdd.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e662471e392c6b45fc37de94139e886c53c9cdd.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_001121_441460_47E478FD 
X-CRM114-Status: UNSURE (   9.55  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

