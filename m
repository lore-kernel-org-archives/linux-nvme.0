Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B9AC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uz+mUi40nTGIQa3Y0qA1+Y4N2KKnpbatMMtJGH6JlZU=; b=TKyL30xxCmsIrZyRVOrYy2hAWX
	SZo0DAblZy0imWlkFYyImsMJTNip+REbA5LeNzWlqe+XFhyDOH9ItbSgH03QkH0aQasxMADyaekm8
	qITNUGOh1G32IonTgP82U9gntcCtppFqPu3buzgWOI+0rYx/bEzBTwuEP/3GJTEJAa1Lhl/rfoeLa
	m1qHxBv3OlE6jlBjYCR93sczN/6uBuQnhSqGUKmeB1VeIEEWvVHePy5T14I7p1KgHgO2Y93Kt0ruG
	sC5uxCuOdtsOGO1MWlEnXHDsbYqAP5DjI4H/2CxWooxUqLzNKa8G1xccZ7MNZ4J+BEhCi3eqvgFVx
	xkdgxM5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onM11-0069Jk-76; Tue, 25 Oct 2022 15:38:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onM0y-0069Ip-41
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:38:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DC1E68BEB; Tue, 25 Oct 2022 17:38:47 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:38:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Clay Mayers <Clay.Mayers@kioxia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Message-ID: <20221025153846.GA24661@lst.de>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com> <20220929223955.3275715-2-clay.mayers@kioxia.com> <20221017132359.GA23141@lst.de> <96244e61f9b94ed3aff59f3f14ecdca4@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96244e61f9b94ed3aff59f3f14ecdca4@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_083852_319483_1AF2D322 
X-CRM114-Status: GOOD (  17.41  )
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

On Tue, Oct 18, 2022 at 08:12:59PM +0000, Clay Mayers wrote:
> What happens today is a warning is logged and the log page is left
> unread.  The patch closes that gap allowing ZDC AENs to be enable
> and handled in user space for things like RocksDB's ZenFS.  Kernel
> clients will also need a way to handle them, but can't that be a
> different patch series?

The problem is how the NVMe AENs work - the are raised and then the
AEN command completion is delivered and they are cleared by reading
the log page.  But if we deliver them to userspace, we lose the pending
state of the AEN for the kernel.  Right now that is not an issue,
but we lose all chance of ever making use of that information in
the kernel.  So maybe the answer is to handle the AEN in the kernel,
read the changed zones log in the kernel, and then send an uevent
for all changes zones to userspace.

