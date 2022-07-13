Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3071C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 05:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8F9asmchbHoMtKx4dWhxDQzOKwtT1HulJnrCajrND54=; b=0twkVxaHmjxfp3aEY1Or4Yi1gL
	56gN8+BXklX0VYFK9OUwRcDekyoYq5wITar0AZyRTwfPe9Jt3sR44hOoYs2SGyf9Ml00NTrsS2jvZ
	1mchL98aJgjpHiQrRTH6uAwwKZ+j/ujSVguh+WKE50qXDEVI6SujSsDyqnt2Q1zgXJIvixVsKerq2
	9/9tFQmAag2MgyWdqKzyxvtayR98HLn9RuGKIwDO3UwE54UZvxE4JRlh4Izt2/wBiAQky9nlDXrmm
	rhZVs0wiW5yZ9Bg6jHv9xGHkTY8Ou84HaYqWxxdGJel5XhF6rd1GQIco/Xkq/9la2No+Q8gYp1cSb
	LiP6INMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBV3K-000Hmp-Oq; Wed, 13 Jul 2022 05:36:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBV3H-000HjF-Lp
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 05:36:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82B0E68AA6; Wed, 13 Jul 2022 07:36:33 +0200 (CEST)
Date: Wed, 13 Jul 2022 07:36:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Message-ID: <20220713053633.GA13135@lst.de>
References: <20220711110155.649153-1-joshi.k@samsung.com> <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com> <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de> <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_223647_904534_BDE0D8FD 
X-CRM114-Status: GOOD (  15.93  )
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

On Tue, Jul 12, 2022 at 11:13:57PM +0300, Sagi Grimberg wrote:
> I think the difference from scsi-generic and controller nvme passthru is
> that this is a mpath device node (or mpath chardev). This is why I think
> that users would expect that it would have equivalent multipath
> capabilities (i.e. failover).

How is that different from /dev/sg?

> In general, I think that uring passthru as an alternative I/O interface
> and as such needs to be able to failover. If this is not expected from
> the interface, then why are we exposing a chardev for the mpath device
> node? why not only the bottom namespaces?

The failover will happen when you retry, but we leave that retry to
userspace.  There even is the uevent to tell userspace when a new
path is up.

