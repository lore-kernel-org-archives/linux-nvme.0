Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472FDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 20:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmUfgVpQ36b0SdRPjDc0eK3YP+PsSOY6Op8d02v8SRM=; b=hSnkG9YJGaH/gMxzYPPb+QA2Gb
	JKBz1nVmR2bw8I5GMjFuKlp0iNyVNnRIhOy5j7AqpeBbiKNTPq3WxpHfpDiRZvVQmqQJosO61hgL1
	sIzsCJxV7O2HQeM64a9yZ6wz1bEY+0HQqmzZnQYHrFzzCWhvATF2+ozVHL33QwE3/1iqxF17L8RDE
	Y0qmOuXkXXiubaDPVB3S2Z0sunMDum9Ixgw/dNXGhexU3hCZ6FIWlOfJFmtwbpzUMNrj9XFa3bbey
	eO+lCXyWf85IEjCi2xE6QA/Wl4RJWdSt9wE4VO2+RO2/LFsqsAOsiB1Aqe2CX6Ef+hoDgUnMVqpFM
	kSigxkbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK4Gh-004Wwz-71; Tue, 15 Feb 2022 20:17:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK4Ge-004Wv8-06
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 20:17:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A045F68AA6; Tue, 15 Feb 2022 21:17:38 +0100 (CET)
Date: Tue, 15 Feb 2022 21:17:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215201738.GA26945@lst.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_121744_228385_04EBB125 
X-CRM114-Status: GOOD (  12.46  )
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

So, I think in th short run setting GD_DEAD is the right thing as a
non-invasive fix, but I'd rather do it in blk_set_queue_dying to also
cover the other drivers with a similar pattern.  blk_set_queue_dying
is never used for cases where q->disk isn't valid so that should be
fine.

In the long run I think we just need to remove the fsync_bdev in
del_gendisk or at least make it conditional.

