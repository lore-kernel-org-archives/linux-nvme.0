Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B044CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 06:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qefujM/Q160dpG9PzTUBTcYFJK
	+KIl6WvYCpH9HOlX/hvqQzDSy6HO2e5LS1inh11cqOleb6VYvKnGeFhedOp/4hcu7NXZ7aMcnEiT0
	oknOKtrxerVU5gy0IHw+YlqgIeTP2nF8Il07hYUdXwexwX0eksfHhDruCO90gdb3XHSNFH95W1koj
	srxwr0uEbAH7OpPTeoTaHJlhMgiRO2YDdJhGAg0rrUsKLi7lY9ooQ+d4CaWfuoxQSfwQZhB/bJCZb
	XtDynsf47KR3LKObngtCAJbxj9pMeOmTpNiddo0q79SJ13tvBij6MHui8q0V6pM4AV8P/B3Tn9R/c
	ftKS43JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4kJ-00000008EU0-1ANQ;
	Wed, 12 Nov 2025 06:54:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4kG-00000008ETQ-3lkw
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 06:54:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45E63227A88; Wed, 12 Nov 2025 07:54:14 +0100 (CET)
Date: Wed, 12 Nov 2025 07:54:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a
 reset
Message-ID: <20251112065414.GB4873@lst.de>
References: <20251111234519.3467440-1-alistair.francis@wdc.com> <20251111234519.3467440-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.3467440-2-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_225421_072895_83A1866D 
X-CRM114-Status: UNSURE (   9.17  )
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


