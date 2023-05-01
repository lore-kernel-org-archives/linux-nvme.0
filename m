Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A501C77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 04:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uhv9UX+qmXFAwQHd5oO4XmdcXA
	778zqvbsWy2/iz3/85wmJPZ4MeKrGJQlFAXy7R2XqaptkUNHrUhYx5yuc1m28f3+hPdou4UqCVIRc
	8ufmEZYelgT6E9u6phh+oUh0viMVwNH31jDr7tbg5Lb8IJ81v5s/nzBiNn7tReSSm1c9FQkzFc1pM
	IHnWF4IoBLF0HPjMMH+dTzPNew2Rtu7gor93ODBLtD+lGdhx1MMb2gEhzjpUT+DGPDpieYiHK/Xyx
	4i90agxa8hKjRekBuqW/IEBVKsNvpW8FP7oDjGCsI+fR8sCgbKALa9bWYEIF4DTFudJzooo5vpugs
	jcz6urrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptL9e-00FER2-2J;
	Mon, 01 May 2023 04:28:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptL9b-00FEPq-0v
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 04:28:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C95668B05; Mon,  1 May 2023 06:28:39 +0200 (CEST)
Date: Mon, 1 May 2023 06:28:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
	leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
	hch@lst.de, kbusch@kernel.org
Subject: Re: [PATCH v3 1/4] io_uring: Create a helper to return the SQE size
Message-ID: <20230501042839.GA19673@lst.de>
References: <20230430143532.605367-1-leitao@debian.org> <20230430143532.605367-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430143532.605367-2-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_212847_491019_1E82D4C5 
X-CRM114-Status: UNSURE (   9.46  )
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

