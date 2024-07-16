Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A12C3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 04:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NbzMK2iJixcuPOlXFlOtQj6JPf
	Sb658ycVZycvrvcEMy2YDGiLB3S5jJZFicq+LLqxAkFSDk8OM7UF5qfafY9kfxY7+WgrrRAFTyb/v
	Ft6Q9e8UlPn8KScCcI5ZWky9fL2VZgHulPtiRrMwBJoBFm4zjoBUmVUXUHZ7ELdXDbIpNmKZYczVK
	O0SlLzV6N3TDbwaKrgr6LIlHpMQ+4yy8m1hwPrcVgG5AQc2NotZDIG3hahtxdaywxLn7s0ESwL5s7
	Qve+5teoy2Qf2gFl9WRpvhnC6XEdWcITka/V0kelfr0cPEtaspK29Mciy2hZ3HZY0jnSTQYdPkZDr
	maD9KCag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTZrS-00000009I8K-1gGy;
	Tue, 16 Jul 2024 04:32:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTZrP-00000009I7g-1XBB
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 04:32:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18465227A87; Tue, 16 Jul 2024 06:32:16 +0200 (CEST)
Date: Tue, 16 Jul 2024 06:32:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: francis.p@samsung.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com,
	d.palani@samsung.com, sathya.m@samsung.com
Subject: Re: [PATCH] nvme-core: choose PIF from QPIF if QPIFS supports and
 PIF is QTYPE
Message-ID: <20240716043215.GA25487@lst.de>
References: <CGME20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db@epcas5p1.samsung.com> <20240715010157.2909958-1-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715010157.2909958-1-francis.p@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_213219_746097_DB8BD70C 
X-CRM114-Status: UNSURE (   8.45  )
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


