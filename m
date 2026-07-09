Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642BDC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ahVNdZvJ6zZzwfhyplt6slUu1a
	NwxR06LyRi1n9L89zI7eq1d/mDvSSQHtCV8HS2KmtatpbO8G8QnDtlCVNbZr2Az630lNYv9bCT/+i
	yJ7+g/+fcMdZ2yuIyLEpwzxT2qHzrLnMQGMcb6ZGse2TCTGrRPT3cDailsLE1GlqBZygLFs8fLMDG
	CxTnUiVrxu2H1A1mhau3gJkTVM3F6WvLpXzf+WUDYxegBJvIuLYPxPTnsNxZpffOxhKvZRSt8htVD
	2hKPCiHgeupBHy0+H+AvwMc6rCXDKKDvvgThb/FgTaVc0VWyWa8WM/179YwAchHyzBI9j/snTaBj2
	DlQjYmcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhpQ-000000016cr-1tKJ;
	Thu, 09 Jul 2026 06:01:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhpN-000000016cP-0sfO
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:01:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A37768D07; Thu,  9 Jul 2026 08:01:33 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:01:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH v4] nvme-rdma: hold nvme_rdma_device reference in
 remove_one
Message-ID: <20260709060130.GA16418@lst.de>
References: <20260704162757.1792325-1-zzzccc427@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704162757.1792325-1-zzzccc427@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_230141_416312_4496D7EC 
X-CRM114-Status: UNSURE (   9.27  )
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


