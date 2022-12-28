Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15F3C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L44cxfhQPFCzkCqKeSBLFXIo5CPG4foHwnhz4JuSsaE=; b=TRpQvgXOt0sOfygO5J+Oi96JnU
	mCzZW9bAa94W0E3QIpWPmgtFE/EJUEOu4KCH1kCWuAgrcruuR4T8qromGvEY+Qg7cY6Fi0fTKEC+3
	sSmA6nTHfT7MspHxJn347Pkj87MHnQpWV82TcfXuY6AjjQAqnieJxmFk+ygoMH80E0E3FyPbtb3b7
	+6oPKn4m5ifht01lFNcbZyHyPo6HSJEA4sqzX4SxkUAdWKJ69njUn16o9eF5g5V8A6NMIBy6t08oU
	6QGNdngqfA7OthjRORUiWBhMeHsU4ewWO7q8cG2UGfc9wwmjtiCzfAvMNfq+X1tVf0RQkzkZuyoR/
	WwOKYoww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZ1G-006EZx-VW; Wed, 28 Dec 2022 16:11:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZ17-006EPn-17
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 16:11:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91F6F68C7B; Wed, 28 Dec 2022 17:10:50 +0100 (CET)
Date: Wed, 28 Dec 2022 17:10:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
	Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
Message-ID: <20221228161050.GA849@lst.de>
References: <20221225103234.226794-1-hch@lst.de> <20221225103234.226794-3-hch@lst.de> <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_081057_242527_C746D5E6 
X-CRM114-Status: GOOD (  14.17  )
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

On Sun, Dec 25, 2022 at 01:19:43PM +0200, Sagi Grimberg wrote:
> But if you want to patches 1+2 to be taken before 3+4, I'd make sqsize
> to be a 0's based value of q_depth after we subtract one entry for queue
> wraparound. So others would not get affected from patches 1+2. Then in
> one batch make all assignments to sqsize 1's based like in patch 3 and
> change nvme_alloc_io_tagset at the same time.

1 doe not make any difference in the 0s based vs not values,
they just reduce the queue size by 1 intentionally.

