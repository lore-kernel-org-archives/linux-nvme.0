Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2B1D6EBED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zxo70XA5rxof2KzU6Ay7cPzHF4
	vly469PwAmmEUKm7gJ4eIRZKPt5srNT1u2zaMkQMQ6zMwZdKRKNvVEPjeZjNkfIFmVw3hdJ6F+iwA
	uC6wD26OhYYcDNnjA9IG9gOAl8r+xxvxmmMUKpCYD6OeQWhwghBfaL2UBFF1RPgL8wxVJXsz5J9Qd
	6VbxgfriUq55n2wv8wIUNkYysRx8OhdVgob6coRrPjwRiWLbT27sh2A6rp9Aaib92xBN+17lXMydG
	pUV1s831IOpyYGcJ916AbUNOkmjN+uN+iFIg/jwecOscubkAdvQ92ugGBg1qkMf1PPEzXpYAPQLgH
	V1meYQ5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw67-0000000H91b-1Pn3;
	Fri, 29 Nov 2024 08:11:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw5Q-0000000H8sx-3tYG
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 08:10:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DD0268CFE; Fri, 29 Nov 2024 09:10:42 +0100 (CET)
Date: Fri, 29 Nov 2024 09:10:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] nvme-tcp: fix the memleak while create new ctrl
 failed
Message-ID: <20241129081041.GA6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <d57573f42413b9e46fe227ef389e2f8a6971f1db.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57573f42413b9e46fe227ef389e2f8a6971f1db.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_001049_095862_6E81E376 
X-CRM114-Status: UNSURE (   9.68  )
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


