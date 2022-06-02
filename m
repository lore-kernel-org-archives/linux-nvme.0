Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B249C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1uMnlISx2BH2FDmsFQI7OUvNZMpq5HDzkPCAmnV1xo=; b=lhrgff1e6QXBSBL/bP4o+RcQRD
	8wa9E+BqybnHpnskyIgJnbKIpzxZL2KRfHPUS2gIaupSzpnvE7cgQv/EHsf/8YhiLMLN+w8VgJd/q
	2439rpUX+r6rmvXT+ZFiY1Ser/lMo8FBdJHj3CFccydtALu+CVehEoDIZKRjq8pG3mn+DMgqqzikc
	hir4C/pghORZ2boTS2OQZhuKJ/S020VMAspPczQZMdnjxLtqR71uyjXaFnuSFQkesF9zGEk1GUt3R
	WrLWcd17lq6wF5+6uY2mLkZ6x7kzhrNXSKMXk11Z+HPvYEam/CH+4FvWvH59vSOn21iLEpraRyU3F
	ukyGFRLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwfjV-0027Bg-DO; Thu, 02 Jun 2022 07:59:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwfjT-0027BC-Mf; Thu, 02 Jun 2022 07:59:03 +0000
Date: Thu, 2 Jun 2022 00:59:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <Yphtx84vMpkX+bsb@infradead.org>
References: <YphKZBtmtKFRNIPL@infradead.org>
 <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
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

On Thu, Jun 02, 2022 at 01:49:09AM -0600, Jens Axboe wrote:
> On 6/1/22 11:28 PM, Christoph Hellwig wrote:
> > The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:
> > 
> >   bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02
> 
> Eh, I can't pull from that... I used the usual git url with this tag.

Sorry, that was my push url.  The external facing one is:

git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-02

