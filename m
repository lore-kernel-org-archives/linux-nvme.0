Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20AAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMtoTH4KXb9/bTw7WbFTfDKtAYnaYWLPkK9ORA5XOvk=; b=Tyw6ijmHyOp4EpxhC5GQBzaqIK
	Lo9w0gTxTyTlPg0gQo17I6a8v4r2oveqAZjVWWTvFAGsmqdZlCGdBBP32EuI16zGrjBUpu4/a9A5o
	hgD4QXii5oONhRMELEswUjXynP6ozcQhtMyZgcElzj21kNHJx0GvSsqc5xUUYzai6+KedK6HZwuUh
	FhNzyFj0XY4Xo7pUO/yp0j5qpBZI2S9bIRd4X2g3fg+q6aqhfvh+0MM6jNgnFGxm5r6NZek6KAJkl
	uHFmSy2+8KKHfciSrSRbWH8iUXhUDX3avEl6Zs79XKl2i4sH3xxd96xYczEbEBRMqrg+ZTSAIM9+3
	I1nyO5hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzwZx-009b3l-1U; Wed, 22 Dec 2021 08:02:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzwZu-009b2M-2Y
 for linux-nvme@lists.infradead.org; Wed, 22 Dec 2021 08:02:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BB02268AFE; Wed, 22 Dec 2021 09:02:20 +0100 (CET)
Date: Wed, 22 Dec 2021 09:02:20 +0100
From: "hch@lst.de" <hch@lst.de>
To: Clay Mayers <Clay.Mayers@kioxia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier@javigon.com" <javier@javigon.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>
Subject: Re: [RFC 02/13] nvme: wire-up support for async-passthru on
Message-ID: <20211222080220.GA21346@lst.de>
References: <2da62822fd56414d9893b89e160ed05c@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da62822fd56414d9893b89e160ed05c@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_000226_300596_18E5CB0C 
X-CRM114-Status: GOOD (  10.87  )
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

On Tue, Dec 21, 2021 at 09:16:27PM +0000, Clay Mayers wrote:
> Message-ID: <20211220141734.12206-3-joshi.k@samsung.com>
> 
> On 12/20/21 19:47:23 +0530, Kanchan Joshi wrote:
> > Introduce handlers for fops->async_cmd(), implementing async passthru on
> > char device (including the multipath one).
> > The handlers supports NVME_IOCTL_IO64_CMD.
> >
> I commented on these two issues below in more detail at
> https://github.com/joshkan/nvme-uring-pt/issues

If you want people to read your comments send them here and not on some
random website no one is reading.

