Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E6BC5ACD1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRhqpzlg5VxacVdAZ4Vnpg6i2uj+A8VOglhLhsTzpgs=; b=yOkwTQolLCNvLI6QOpXJ0tD+E3
	8U4PkfvozqwVMb1DQv43kqEVdCWf/O6SLRximiGkmjBn5vTt/rLp7K/J2RvTczD+DB0RENBt2PSJ6
	gaQS6KZ3DQU/GFZ0GO6VKmfwqzXt5Hfgy5MTBCk3die+UM6kGZf18aNB2SBVCyxfTWgRpvAX4ChUy
	Ge0bIXhgiVaqFJK38z4CRammctU6LUHqPrE9193Eq1g7+oQ6HkoieTr4aIQt1SdgOj9dWK4tnF+L7
	dyS+uEk7vFsrW+byrXwLzhO+pUkrQLc54oMY4NRpZMNRNpKsci6VOdPD3Ldfy0gi5wHGwoA8fGWQY
	DaeyEq3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT2f-0000000FAl9-093r;
	Fri, 20 Feb 2026 16:07:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT2d-0000000FAkM-2Kfo
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:07:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84DE668B05; Fri, 20 Feb 2026 17:07:41 +0100 (CET)
Date: Fri, 20 Feb 2026 17:07:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] nvme: update nvme_id_ns OPTPERF constants
Message-ID: <20260220160741.GC15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_080743_735109_519436CA 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, Feb 19, 2026 at 08:28:05PM -0700, Caleb Sander Mateos wrote:
> Since NVM Command Spec 1.1, OPTPERF comprises both bits 4 and 5 of
> NSFEAT in the Identify Namespace structure. Replace NVME_NS_FEAT_IO_OPT,
> which represented only bit 4, with NVME_NS_FEAT_OPTPERF_SHIFT and
> NVME_NS_FEAT_OPTPERF_MASK.

As you're deeper in this than me:  do the older specs require the
other bit to be cleared to zero and this is all compatible?  Or do
we need to guard it somehow?

Otherwise looks good.

