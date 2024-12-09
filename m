Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB4E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itSBN0bq6LK05k7YU0X/0pbXDAuLGqboA/6J9a7m8cg=; b=ehfxZDGsSEVhHVhb1AKI4MWwmF
	dJAOm4oxp9DYmCIGJmUWRax86WYQqvA3mGzBbv3LAYlqJsDoB8dNQ04SNQfq3I7ysqJgSEdWR0Bia
	UJey/btCblAfwPd94atazPzo6GPxmSm7qUNJy5CwS8yBLBU5U8TYn4cLqow7YKpNNsXvwddmnQ8Js
	PN+7bhlZHwl/An5/+d7Ue+fTlmmEgCl8OBdjKWpU6jexNFds4nIT16vHqiYnP+kkXwjo+Qr1h7z6V
	zA/taTILHNagy1xDhzapZKGd2y5nruVlR/GZ5HlYT+mze09B5HoIGcEInk01dXSNdgrC/VuFFZO+n
	xyndEzbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdRE-00000007rG1-3lhe;
	Mon, 09 Dec 2024 13:04:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKd7p-00000007lcd-3VFk
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 12:44:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB39C68D09; Mon,  9 Dec 2024 13:44:25 +0100 (CET)
Date: Mon, 9 Dec 2024 13:44:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <20241209124425.GA14066@lst.de>
References: <20241206221801.790690-12-kbusch@meta.com> <202412071144.9uXFLnls-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412071144.9uXFLnls-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_044434_012210_BD2AC7B9 
X-CRM114-Status: GOOD (  10.98  )
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

On Mon, Dec 09, 2024 at 12:05:27PM +0800, kernel test robot wrote:
> >> drivers/nvme/host/core.c:2187:11: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
>     2187 |         } while (i++ < fdp_idx);
>          |                  ^
>    drivers/nvme/host/core.c:2160:7: note: initialize the variable 'i' to silence this warning
>     2160 |         int i, n, ret;
>          |              ^
>          |               = 0
>    2 warnings generated.

Yeah, looks like this is uninitialized.  Did I mention I hate these
variable length log entries in nvme?  They've already been a major
pain in ANA before..


