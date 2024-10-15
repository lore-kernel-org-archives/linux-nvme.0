Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14550CFC267
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 04:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NWUx0nuL1F+nna5NO6DUR8aey7
	XG6E+8wbVVypmP/2M5c9TuCYSLNsMxNopnvR7fhnhQ30lxiJP7MUWAlHGmgkiZPv1rLtIFhE14Qjy
	uB6h6lVj8O3w+C3YS/T/uQ+gtfmHJAY2IUmG0jS782xbOyLHSCKFGv58Iu3ATTWxYZyZSxgUUtiNZ
	CVvzIEzIZzNS7DLyn6Gl5yEHdICI6doK02Jqr6H/1ATdbA3oVCtoCo4xQZd3dAHVW50KpJoTPOBb3
	b4Uj7v95to/Ln03EorpNb5dm7KegdXQ22q9rSn7dI7uFdrw9nmF768Q5CJtzD6BpXuktTV1Lf75se
	WmTxec0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Za0-0000000740C-1ZzD;
	Tue, 15 Oct 2024 04:54:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZZt-000000073xp-0yKR
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 04:54:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 017A7227AA8; Tue, 15 Oct 2024 06:54:31 +0200 (CEST)
Date: Tue, 15 Oct 2024 06:54:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: parse reservation commands's action and
 rtype to string
Message-ID: <20241015045431.GB18058@lst.de>
References: <20241014101458.80491-1-kanie@linux.alibaba.com> <20241014101458.80491-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014101458.80491-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_215437_420804_F2DF9EE7 
X-CRM114-Status: UNSURE (   9.01  )
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


