Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B077AC3ABB2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RQglW+4Rsrwa9D9MOIO65MfYyDQzThJsOm/0bRzGPTk=; b=N+VHKPHwc+X0MHF5TlsDiCZV+D
	DEd7DkSNETFLpwmfJQ4do/HkNjNKiOqFgxoMmRCEA0fja9nwgJROXCiQR2wbzlyTcFya3uozDCyyx
	IKLmkpcEJ6SBlW6JMERVqD5QPBu8UFL1US2YqTafSwuMowMmmocxHgUGXcDed4M2SIdnQUH/jDT6d
	tACTpz+sxaI+FGDkkAY7G4b5Wi/YegTquuU06kfJhXGo3X4OeflQVCqlg38jIGcquJRh2VP7B9ftx
	P3GVHer6utVVgfOHBddTxv6Pb5ciTfVL7Z7nIJMn87iNQZTc0JHTW51Pl/OLrNnqJ25AjCXtLm+QC
	Pl88D/GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq5zi-00000003I0Q-0nho;
	Mon, 16 Sep 2024 07:17:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq5zf-00000003Hys-0HzI
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 07:17:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F79E227AAD; Mon, 16 Sep 2024 09:17:48 +0200 (CEST)
Date: Mon, 16 Sep 2024 09:17:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Jeffery <djeffery@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, ens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: use per device timeout waits over depending
 on global default value
Message-ID: <20240916071747.GA16514@lst.de>
References: <20240913134430.5416-1-djeffery@redhat.com> <20240913134430.5416-5-djeffery@redhat.com> <ZuRXc8uj7J2CBDE-@kbusch-mbp> <CA+-xHTG8_T8hXzF5uC4wFCHxZSrg18t0dzwNeh+RdDEjORh_1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-xHTG8_T8hXzF5uC4wFCHxZSrg18t0dzwNeh+RdDEjORh_1w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_001755_269833_6FC774F4 
X-CRM114-Status: GOOD (  11.75  )
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

On Fri, Sep 13, 2024 at 02:36:45PM -0400, David Jeffery wrote:
> The expansion of nvme to be a remote storage interface means different
> namespaces provided by the same controller can have very different
> characteristics.

You can do the same over PCIe attachment.  But that doesn't really
chnge that the fundamental relevant abstraction level in NVMe is
the controller here.


