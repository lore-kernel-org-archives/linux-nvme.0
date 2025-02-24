Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C569BC021BB
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzqC6j6pvE0AFhhV+TXEGa8wenF4Swzkhl2lQ3BBtIs=; b=nclk1rqsQ5CszD3DqsFyhwowQn
	As7siV9kwvWsib2aWRrJhUtYPtcXERTgWjBKyZ0P8GP4FtTqyEiyMyFKAZ/7LNzEIAY9oNh2AD/MV
	UroKOp6S/hdl7MpCB5Pe+bL5TvxUvdC0eACIgJjiAM66MGOJcogBb/o04K2LAMXu3Vzfv8agKyc0n
	WTGqBjPVrp2cRMk9nVWgTmQ5rFgAhNrYgmH2MT0wedVe/jPPPmYmrdGOWmdj8rfrvCJsocXJxnGHu
	6CY3GRiqf1WLp4RANcqrckpUi65ujln+hQ2Yiul5EHkR30IEa+X0LCUe/L8bFJbnlFDmGOqad9aRR
	t8dGQ1Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmawi-0000000EOuC-1PS2;
	Mon, 24 Feb 2025 16:04:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmawf-0000000EOtA-2HGL
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 16:04:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C936F68BFE; Mon, 24 Feb 2025 17:04:31 +0100 (CET)
Date: Mon, 24 Feb 2025 17:04:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <20250224160430.GB4701@lst.de>
References: <20250220235101.119852-1-xizhang@purestorage.com> <20250224143350.GB1406@lst.de> <Z7yIQzPhgD1Elx-H@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yIQzPhgD1Elx-H@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_080437_728890_F1D255F7 
X-CRM114-Status: GOOD (  17.25  )
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

On Mon, Feb 24, 2025 at 07:54:59AM -0700, Keith Busch wrote:
> On Mon, Feb 24, 2025 at 03:33:51PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> > > When using kernel registered bvec fixed buffers, the "address" is
> > > actually the offset into the bvec rather than userspace address.
> > > Therefore it can be 0.
> > 
> > How is that actually going to work?  Who is interpreting that address?
> 
> io_import_fixed() treats the address as an offset into its bio_vec.

Ah, yes.  This is in nvme_uring_data and read from the SQE.  I thought
we were further down.

