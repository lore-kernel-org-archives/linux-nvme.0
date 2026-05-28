Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B639CD5BD5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jejFI2rQcjf1ACYXtKx6LiGJu+
	LdV6YwynWdguEwihR5y2g5s+mmlUAie4Uf0PivdHFj+HYAhFVohlicd5zOseTO0b0QpKp/rExYfDj
	OWFQc+LFcI95XHpskrcEZHx9RafH35rgY9OXBNm5rLGjNg6drFgTIxfuaRoChHRn2dIvHXdv6ih6I
	lYZHy3Hayg22kUKOacf71baeqCSV9ySAn/EKHYaA2GvDWYeYjllwcfvRK4EuATLHl6/mScAnZ1Pjo
	PgJc4EXWdNeyF6mrwk+6pQEzHaO3xlof/0NLQAw5ay1YplCsZ/yD7ICgEZ282Fk2NITDSYMc5X2s+
	7bBXEdZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW7C-00000005O0j-2J2m;
	Thu, 28 May 2026 08:29:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW79-00000005O0N-1Dqb
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:29:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 511A668B05; Thu, 28 May 2026 10:29:10 +0200 (CEST)
Date: Thu, 28 May 2026 10:29:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCHv3 1/2] block: export passthrough stats enabled
Message-ID: <20260528082910.GB6893@lst.de>
References: <20260528010041.1533124-1-kbusch@meta.com> <20260528010041.1533124-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528010041.1533124-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_012915_471374_BA1FED41 
X-CRM114-Status: UNSURE (   8.07  )
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

