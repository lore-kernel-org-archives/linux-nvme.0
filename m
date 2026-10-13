Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA51CC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=s5UrAkTIPM9jG21H1VJVvcnHN/
	+MD8MM32Ra3m6JJW1c5bUQ+JevjmIXYe2HuPAyv/RQXtkR2z3iblgdbSATo/XMgrOMti8G3uMGBes
	5vJTI0V801rblVTwwafSkDUQQtiR2YiWQ0wmyRsNVtJe2O9D9ZNgcUJc3MV0ODp/o1+4aXILtVEED
	SzpjwRPQqe0ie1ubaATypNSACc/YSlGVDdg3C8/5/t8Dg/3bXK7cs+GE20pndkdu9PgPpuwEgJ9KQ
	WKgEczBz44OMx3cQB6wAZFDxe5/nYt0fuNtKA7bx3C1WrQuGoVBJZF+LYMUyUVx2jK5t7zVJXnA9k
	uFyuOQSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGddd-0000000D8YU-0P8E;
	Tue, 13 Oct 2026 14:37:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGddY-0000000D8VW-1CMu
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:37:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 047B7227A88; Tue, 13 Oct 2026 16:37:49 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:37:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	shinichiro.kawasaki@wdc.com, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: send namespace changed event after namespace is
 fully initialized
Message-ID: <20261013143748.GE15717@lst.de>
References: <20261002070249.338225-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002070249.338225-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073752_480686_A0FFD9BC 
X-CRM114-Status: UNSURE (   8.24  )
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


