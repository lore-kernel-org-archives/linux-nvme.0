Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9243C7EE2E
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Jun 2023 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4/53SHCNgfwoHtdQh8Kkygq7GQ
	1igTFcyxMtnK3UW2UmUHBsyTkn8NF5RnkUE3lZt9MG7eCkVwfJFdMBrclDRR4a1R+NOF8LvuwdVQq
	pc0UFPrGWkoa1WYFeNNJfaA6e6FTQwBTkLHEE7Zid86D+VQ0857UmJQeM75014CJob82x2nsPTsgh
	W08gQfYdvZuLPy8bc6rvDfCxI7kahkKTGSSzyII7mIKl2GuCt8FcFo5pnTOZ2AA/Z5MRUoaYYDkyV
	wtXrpnox6cNEEgyV8uPcEHxOFuxE1DzxtV7gb4cXSqXfhLcV54AqOJdIpPXd9B2RlbIiCKAgNVWEh
	mFtjWBhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7sPR-00FP7c-2i;
	Sat, 10 Jun 2023 06:49:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7sPO-00FP6u-16
	for linux-nvme@lists.infradead.org;
	Sat, 10 Jun 2023 06:49:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2026468C4E; Sat, 10 Jun 2023 08:49:06 +0200 (CEST)
Date: Sat, 10 Jun 2023 08:49:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: add request polling helper
Message-ID: <20230610064905.GA2131@lst.de>
References: <20230609204517.493889-1-kbusch@meta.com> <20230609204517.493889-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609204517.493889-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_234910_546423_CC41EAC2 
X-CRM114-Status: UNSURE (   7.71  )
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

