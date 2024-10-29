Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303D8D339A3
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 07:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sb8N/PNA7HaH1R9Mq5COug/dyn
	Mmj6KUm7Xk9JMH9w5cFNYZUgq/XR4Yma1vYaQK59Au54tkQijULWetenkUw99d7JDLF0+0oor2ZHq
	isBnwBEl1OAmVIRBSXeEFUGy/xjF2Qs3AJLAJFF7bNnRzmViZIm1ix3hLiMPsbvHioYrQ4qK3c4mV
	DkzVwDBERSQxQlK1wfepEE2fpaRneiGJxxMbesAz9g+tYppK440klb62NSiA60htPqq67fMd/A63q
	1VtEN3FRKCmF/iqSJ9TajrXyIaF/FmdyuqDxRVYp/GuLtrzXksvpETdMwbopKsONC61Zs+LWIOspW
	A5fwd3Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gu1-0000000DYWD-1Yqb;
	Tue, 29 Oct 2024 07:44:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gp4-0000000DXBT-3grE
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 07:39:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5CE4227A88; Tue, 29 Oct 2024 08:39:21 +0100 (CET)
Date: Tue, 29 Oct 2024 08:39:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, anuj20.g@samsung.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: re-fix error-handling for io_uring
 nvme-passthrough
Message-ID: <20241029073920.GA22316@lst.de>
References: <20241028205253.2054407-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028205253.2054407-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_003927_078446_EF41BECD 
X-CRM114-Status: UNSURE (   8.79  )
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

