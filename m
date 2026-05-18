Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E097CD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0mY7LD7OyVC2kAtU5ioF76ET8fivrF5JdvHHCOOossY=; b=TEmFKx3Fw7tO1VPhPMmaHFHRKl
	q3G7wiXn7CxnKW//to3+jWcndBmV6BRz4lQoceyJzunYXkX/Zc3IDCAHoUuCGY4PzxNP3PZZa/F2W
	gcqdo/7u4MIIVksa+gICTmA/F3R4oxonFYn8WmyMvG2QSlwBObXjE0Fse53n4jSAz1AevcmazIWDu
	d+OShoFGI79ul4ZDGo3pZ1IZvNqQrM5zoqKxUER51aCvGCFcmHOfcAGJJOlTot/LCsekPDkPjNU0U
	qFuhO3qfEm1tx569w7inV5yl2oWF49op9ftsz5nQARFaEzE8YOg4rRae+ODTB/E8D3RpGAt1ehiY0
	qBKuXLgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqyQ-0000000EMnO-2LYx;
	Mon, 18 May 2026 05:57:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqyN-0000000EMmk-2Esb
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 05:57:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F9E268C4E; Mon, 18 May 2026 07:56:59 +0200 (CEST)
Date: Mon, 18 May 2026 07:56:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao S <coshi036@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to
 pr_debug
Message-ID: <20260518055659.GC10368@lst.de>
References: <20260427003457.1264511-1-coshi036@gmail.com> <20260507054809.GA19796@lst.de> <CACd_6n3s+Y+xdsuQVja=t1RUEdro2yQRyJyjpqFcd9_pF98OzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n3s+Y+xdsuQVja=t1RUEdro2yQRyJyjpqFcd9_pF98OzA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_225703_714897_0907F9D7 
X-CRM114-Status: GOOD (  12.47  )
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

On Sat, May 16, 2026 at 11:54:49PM -0400, Chao S wrote:
> On Thu, May 07, 2026 at 07:48:09AM +0200, Christoph Hellwig wrote:
> > What is "semantic mutation of Identify Namespace responses" [...]
> 
> The emulated controller returns a mutated Identify Namespace on
> rescan (flbas META_EXT, lbaf.ms != 0, dps == 0) -- the host-unaware

What does "mutated" mean here?


