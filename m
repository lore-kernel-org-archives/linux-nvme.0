Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E407CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5b8FlvcwF1oSlCK1s61WlS96UO+TTTyUP2bkbBALAU=; b=E716OP28pJdd9Ut7xNTRtuQUlJ
	Y9zoTUFh3+YyeMdIbtw4LBqNesBKga3mum/iwEf8aQ8H5MiQsvLFnbQf0BNyNCfLBerBGO+Kp17BZ
	yZJqwBj70hA692eJwyLf8CIgRBLEenWEuUxmEwoTr5upi754uwWUrjWNC1lTyyg0rxZ+IKpY7XiFm
	Ef9bTmH71F5H1UFCJ9uzmqnGq1QIgxvySmhXh8Ay9RwsH2tfxzyp6c7I0kRLdypVL8oXxM3JwIdLC
	xzellbSPSRgBUfQE4JZL012vc0QHdoqbfnKWUDgWI0ULiUjWzUE3UqfHQV1UIP9n+AEL/muHygFbH
	R4IJSBqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntsbZ-00BVeQ-MP; Wed, 25 May 2022 15:07:21 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntsbW-00BVd0-SG
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 15:07:20 +0000
Date: Wed, 25 May 2022 17:07:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
	s=mail; t=1653491231;
	bh=rFHjdAfF0vz1/EFBNiyD0IsPskYLMYVsfnaqUJagK+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ4+397wV+yur3tcyedrqXlDlkbOodpY5/0kHi7EWFw7Ytp7g51swEj7WCXyxb9oX
	 95j+EaZrQ0fmy6EUJs0cymexxPa6Og5/U7x75SPFWY+2E9jpILiTVSYihazzU2B0ny
	 1nqeLKZ9ng/W9ou0jCLXZkgnDKnL6xgFhfhRsgXE=
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <b39c568b-338f-45bb-92f9-0175a909c3f8@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
 <20220428150644.GA22685@lst.de>
 <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
 <20220510070356.GA11660@lst.de>
 <6123b484-bf2c-49f0-a657-6085c7333b2e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6123b484-bf2c-49f0-a657-6085c7333b2e@t-8ch.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_080719_110091_38868543 
X-CRM114-Status: GOOD (  15.32  )
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

On 2022-05-10 12:20+0200, Thomas Weißschuh wrote:
> [..]
> > We could look into removing the min with
> > PAGE_SIZE * MAX_ORDER_NR_PAGES to try to do larger segments for
> > "segment challenged" controllers now that it could work on a lot
> > of iommu enabled setups.  But I'd rather have a very good reason for
> > that.
> 
> On my current setup (WD SN770 on ThinkPad X1 Carbon Gen9) frequently the NVME
> controller stops responding. Switching from no scheduler to mq-deadline reduced
> this but did not eliminate it.
> Since switching to HMB of 1 * 200MiB and no scheduler this did not happen anymore.
> (But I'll need some more time to gain real confidence in this)

So this patch dramatically improves the stability of my disk.

Without it and queue/scheduler=none the controller stops responding after a few
minutes. mq-deadline reduced it to every few hours.

With the patch it happens roughly once a week.

I'll still RMA the disk and see if the replacement changes anything.

Maybe some of the Western Digital employees here could take a look or check if
there is a new firmware available.
(The official updater requires Windows and there is no external documentation
about the firmware)

Not sure if a change from very broken to only slightly broken would be enough
of a good reason to be honest.

Thomas

