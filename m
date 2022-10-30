Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270AFFA3744
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 07:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=epWZp7+n/LdHlubYh0wXdjBpaPV4LUucoKHnuQNmE0U=; b=ELqRbRIjJfZyEV4D7jNQR+Oma7
	wjUNSjmG+BeUp+BMk7layjP98Chvj1yCQvWxpopXDHDx4OgcDliE9bioMrG2eD2t5zodZRYzkbiKr
	YeHt0RISxLw0rN1Kojnc9gUTl6A7GpwZrbUyE67GqZpHQlW+PvecbD0HfqnyaeE/m+qep6PrbN3RD
	C5pCyS1fRl+JVH50EGp9F5EYbfKgPTSB2dcDZtb4E78RnbsljpqM0eDyYM7x9ewrAiGLPTV5XTNaI
	dPQ7Dj0ZvCu8Ey7hvAfH7ZsoKWPuJJtnRjPb2+f5JsrEuQLOfU8WrEMBNEsFLr5qQQQ2e7xixV2zb
	TXH+EJgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op2u8-00Dn4U-9J; Sun, 30 Oct 2022 07:38:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op2u5-00Dn2R-Mz
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 07:38:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F36F268AFE; Sun, 30 Oct 2022 08:38:42 +0100 (CET)
Date: Sun, 30 Oct 2022 08:38:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jinlong Chen <nickyc975@zju.edu.cn>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 2/3] blk-mq: remove blk_freeze_queue
Message-ID: <20221030073842.GC4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <e21821b72fe9df4f187c1321dd38587138cd1aaa.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21821b72fe9df4f187c1321dd38587138cd1aaa.1667107410.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_003845_912874_2D5AE985 
X-CRM114-Status: GOOD (  12.21  )
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

On Sun, Oct 30, 2022 at 01:26:45PM +0800, Jinlong Chen wrote:
> Nobody is calling blk_freeze_queue except its alias, so remove it.

So while we really do not need both names - the queue freezing is also
used for non-mq drivers, so the naming without the mq is actually the
slightly more correct one.  But for that it should also move out of
blk-mq.c, so I'm not really sure touching this right now is all that
helpful.

