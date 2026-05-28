Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21638CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4LyCv8RjGPHcvKE7LfJI6yw0w/
	uBOqbGnq2sohEYnw+rcPMzdJCg6uUyouHrZPdu6YpeCqxEjWIHig8hSlxkPJXooJh3lIejg08l6K2
	pN6jIG7ynifBVz/5JfTzNBVg2YtLotcmboO/95EZHzQspHQFT0aI6tZ+3Xt3fU5izRBlf1e1P9P96
	Iq6+vRP4DS/krJI7r6S7oeKhJZsWY9MPpsnXxwM3AOdSQg1kO3spdqs5wRYNLVi7odY6C7Dc2NgwJ
	kCd5KOnWRAVus8sGCiAvx1tv3dyQbk6YwrNt5xkZvAqA5igJAs+/zhmSIKOcJ3scOCtAD4hlitIP/
	GuktmELg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW7N-00000005O2k-2ldf;
	Thu, 28 May 2026 08:29:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW7L-00000005O2B-0GFV
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:29:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 918E168BEB; Thu, 28 May 2026 10:29:23 +0200 (CEST)
Date: Thu, 28 May 2026 10:29:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCHv3 2/2] nvme: add support multipath passthrough iostats
Message-ID: <20260528082923.GC6893@lst.de>
References: <20260528010041.1533124-1-kbusch@meta.com> <20260528010041.1533124-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528010041.1533124-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_012927_240293_4D67091C 
X-CRM114-Status: UNSURE (   8.17  )
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


