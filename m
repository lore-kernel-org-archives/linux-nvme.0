Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50C3C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O61EjxMo4VH4KuZjMjlLvfi0uK
	xhUzMW21fpnDg3GmJ5YZZafzl9wdhFsmCyOwRnZOK46kHoM+ZUZbgNeI6j6MH70AzkwgKuMXWXnqP
	IdJbejnuWDSSKhza9NarR3feMA0QyPUuksPBLW55PiHp7Tnn0v4gMQuBbkRFJ+NNOQmYag0dAST1W
	zKESCQW9bp4isHL/LKDvRDH8RuUkk1jf9cWqCA13FUbAJ4gO4r4hAilAJ9iaYWVl5ZOm07wL+viZ2
	f9LsTxHZlZLbcx2wuKbt8+zQhvKeE/2Tlgyiq50ZdtO8c3R4wLuJLKCYHKdB8ofcLWNzpkvbspWre
	uLx2uDkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAvT-008zPD-1T;
	Tue, 24 Oct 2023 06:30:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAvR-008zN2-1I
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 06:30:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D7B56732D; Tue, 24 Oct 2023 08:29:50 +0200 (CEST)
Date: Tue, 24 Oct 2023 08:29:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-keyring: add MODULE_LICENSE()
Message-ID: <20231024062949.GB8472@lst.de>
References: <20231023230052.31161-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023230052.31161-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_233001_583400_438B80DD 
X-CRM114-Status: UNSURE (   9.80  )
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

