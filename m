Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6321CC00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHl/gTL2TD8JhbGUTV/3Jap8t1AfGGr5PHeWNdjOgng=; b=lcJutiBWCHTtQ1WBAq72AxUQjl
	lV3GZpntRe9HE6zKOu0ASJZxyjKqI2Bg+J0IEwYtn/qcRigP4ZjQLq1pBjlIEn2VQMmvKU9ALnCKi
	KHO+RsrAQhSyPyEEQEUftOlYp170toyMG44iejtvSM7/XbOpKzgpJP/tyF7fSMf+VHjcwjgYbl1mq
	lPBm/qruGQHS+SnKFQn56+g+V3T2g7fB/psCvyNvyU7RW056msY3nVvqqUbGvn4MGNtw/zO+sdIHy
	RgdwW+lQzrn3T1DKpIOu0kS0XSwwBqXECg5ol+2+kE9CVQBDJtDiky0WB9adf6yuZWB5FVUbii9QZ
	kkVKFYNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBWI-0092aF-0B;
	Tue, 24 Oct 2023 07:08:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBWF-0092ZW-2t
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 07:08:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 312F767373; Tue, 24 Oct 2023 09:08:00 +0200 (CEST)
Date: Tue, 24 Oct 2023 09:07:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <20231024070759.GE9847@lst.de>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com> <20231016060519.231880-1-joshi.k@samsung.com> <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com> <ZTBNfDzxD3D8loMm@kbusch-mbp> <20231019050411.GA14044@lst.de> <ZTKN7f7kzydfiwb2@kbusch-mbp> <20231023054456.GB11272@lst.de> <ZTaOzORdmFwxCW1c@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTaOzORdmFwxCW1c@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_000804_080274_F69896BD 
X-CRM114-Status: GOOD (  19.23  )
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

On Mon, Oct 23, 2023 at 09:18:36AM -0600, Keith Busch wrote:
> On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
> > Yes, you need someone with root access to change the device node
> > persmissions.  But we allowed that under the assumption it is safe
> > to do so, which it turns out it is not.
> 
> Okay, iiuc, while we have to opt-in to allow this hole, we need another
> option for users to set to allow this usage because it's not safe.
> 
> Here are two options I have considered for unpriveledged access, please
> let me know if you have others or thoughts.
> 
>   Restrict access for processes with CAP_SYS_RAWIO, which can be granted
>   to non-root users. This cap is already used in scsi subsystem, too.

Well, that's sensible in general.

>   A per nvme-generic namespace sysfs attribute that only root can toggle
>   that would override any caps and just rely on access permissions.

And that I'm not confident about as long as we can only use the broken
PRP scheme on NVMe.

