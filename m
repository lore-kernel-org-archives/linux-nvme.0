Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F1DC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LK2ME9Mn/IehlQ/rV1wNorQ4Rf
	nJAHd9vIIMwiIR71VeJgTl3JMp593ypVJCXFCyiFVQFhTd2I8qD1N9jputWpjALQ6OTAjyDt5Lakh
	Imi0IJWwJGmcU2pTE3korQpWU+A8sZ3dG4PxjKxZQMVKXSLcT/9b9hZBDA3NXM1zqVglzcBTgiVha
	M/L4NjqJfanCGjC1CN6u7553VxrA3zRH74uAaK9OreehNWRMKapreMm8LwTJSIGBi7lvUEnQ/oq9d
	9MYcRBLHmifi8VxXTEsoNViVwiI/VupLNAikAIyFpnLkmR9qspVWVoPIvdjuPlXzwZ8NZJPInegxG
	X/Z6yk2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3cj-003B83-03;
	Mon, 04 Dec 2023 07:44:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3cf-003B7Y-32
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 07:44:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5778F227A8E; Mon,  4 Dec 2023 08:44:07 +0100 (CET)
Date: Mon, 4 Dec 2023 08:44:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	kanie@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Message-ID: <20231204074407.GB29244@lst.de>
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me> <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_234410_186992_8FC62D71 
X-CRM114-Status: UNSURE (   9.45  )
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

