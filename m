Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E46D637DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 04:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KLT+FmLSX7j9gjAovOtuYri7fNpkXsRxCGDLVouErXo=; b=vEVc5sV6zmPuB5wO8tlQDUqsF9
	caa05ENoUguruvFDnx1447vnblXn7DtMvF+kITuCdJQbX6egTmMKxB5yymXjV1JIvLx+gInaXWlJN
	azX2G7dWc94swBAmRK5+QNXs2VF/SZVhoF1rgxygRze6jCzlQ+8oGzJ+cQMLvuPVYSRm599rVC9BZ
	4fIwe3SowLDQXF6MBI/8TiNZ9Cyl2zCxV3a7Xv9s8GPuTeAlZiK6lF1RAyhGKXGpXp27qNIVmlXO6
	euC7g58DK6seXpAwyamalSd3mdITCiL6kCIANvc0seYSCyC76SBkGBdsTZPIc8B2xauQnt6nauLUS
	aQXRcRJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBRHA-00000008kMq-47xV;
	Thu, 14 Nov 2024 04:16:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBRH8-00000008kLI-1Eje
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 04:16:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0540268D0A; Thu, 14 Nov 2024 05:16:04 +0100 (CET)
Date: Thu, 14 Nov 2024 05:16:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: Re: don't reorder requests passed to ->queue_rqs
Message-ID: <20241114041603.GA8971@lst.de>
References: <20241113152050.157179-1-hch@lst.de> <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com> <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_201610_501255_C5299DD9 
X-CRM114-Status: GOOD (  16.90  )
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

On Wed, Nov 13, 2024 at 01:51:48PM -0700, Jens Axboe wrote:
> Thanks for testing, but you can't verify any kind of perf change with
> that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
> higher rates, which is substantial. But the reordering is a problem, not
> just for zoned devices, which is why I chose to merge this.

So I did not see any variation, but I also don't have access to a really
beefy setup right now.  If there is a degradation it probably is that
touching rq_next for each request actually has an effect if the list is
big enough and they aren't cache hot any more.  I can cook up a patch
that goes back to the scheme currently used upstream in nvme and virtio
that just cuts of the list at a hctx change instead of moving the
requests one by one now that the block layer doesn't mess up the order.


