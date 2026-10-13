Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF88CC6B0F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Mp2egTJzYUcrFs0fRbLDb4ZQkO
	7Q3HNyazzMIxzJPKAJbJxpuKlmtgWcUJbxu7dQWgC2/9x7bvtnOu3kDCNLLglEBsnKSAtCbsQZRDe
	Cl/gecmcWZR8+2FaMDPNLEaNIue0CFnkxjRL2ngZl6CKIp7Qe3kPuYhbUgAPModW1roZgYT5GgX2W
	P8XzXMqOGDb2CmsRGbeaDrPeX//ESKVgUd5KYYEHJgh5rTm3hRrL8inyOxLXd6/weMbK+/CcfJ0I9
	JAhDGVJ5dYypqtCtDanKS3M5+CLIrxtYkdfrzUUHdAl1r7IeCvJer24IgjvWXI/i7rB6f80BPOWBd
	kqdfepRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdVN-0000000D6FN-3dy7;
	Tue, 13 Oct 2026 14:29:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdVI-0000000D6Dn-0oYp
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:29:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7FDC227A88; Tue, 13 Oct 2026 16:29:16 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:29:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com, hare@suse.de, saravanand@crusoe.ai,
	sjpark@crusoe.ai, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v5 1/2] nvme-multipath: fix path state evaluation for
 failfast and ANA
Message-ID: <20261013142916.GA15192@lst.de>
References: <20261008141407.22992-1-kiyer@crusoe.ai> <20261008141407.22992-2-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008141407.22992-2-kiyer@crusoe.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072920_383189_89CFC2AC 
X-CRM114-Status: UNSURE (   8.42  )
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


