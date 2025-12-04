Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E1ED1F9AE
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idCFnFrcUwTtb74aqgqX3OChCwMLLJI8Rgwiu4DAog0=; b=tMke+AGFGTqHKXZir3UI0T1K2N
	c0uSCCozlxVvTFOC/KEZAnMmwznEmhVELy0nuqoLncj12I9X2r+aUFLiLniideYf6lC6RHKL5ioTA
	Tab1cajDwsMh78ajYsgeI1qCkJRl92n2xzH3hW7YPujvOMwdAOJNHy/LHP0QTrBC8T8c6GXVg3vPI
	ro6AGtRSPlyxajOsSLPufLGzH4wOtXJIj2cJ/TiAcLYjyXQFNHaEZBi5DC12prGdpJW8oelKarhSY
	aWl6WZyPiGwH1zdVG7V7xpAZS/hyqYUQ4bk9fDB8/wLRNFZi0erUpQ9fzYJ/8YdOtzoBewJGCqDeU
	P9SpTEHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6oH-00000007rBd-0lAl;
	Thu, 04 Dec 2025 10:43:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6oF-00000007rBA-2kX4;
	Thu, 04 Dec 2025 10:43:39 +0000
Date: Thu, 4 Dec 2025 02:43:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 03/11] block: move around bio flagging helpers
Message-ID: <aTFl290ou0_RIT6-@infradead.org>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
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

On Sun, Nov 23, 2025 at 10:51:23PM +0000, Pavel Begunkov wrote:
> We'll need bio_flagged() earlier in bio.h in the next patch, move it
> together with all related helpers, and mark the bio_flagged()'s bio
> argument as const.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Maybe ask Jens to queue it up ASAP to get it out of the way?


