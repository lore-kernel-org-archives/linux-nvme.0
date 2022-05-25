Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYx7oKhsk2ZvtXw63Ck7t75fszLdHRQwxnB2rlz3dBQ=; b=i/FAO0AJK7oGFfJE2f0LfTm25E
	uNZJMMH8zcIlbbs0SFNuI2dfZNStbNkv19iOiahrDpltEeq/KCbUwED2Hrj7GSH2npEdcL1Uy+EZD
	SunfSrC+NwSqD1VNbiTGjZL3Sh+h1GFeBI5WOsaOT55MJZ46NgW1Leaww4or2QYTn9QCgJKgFnKD9
	kTNYyQFLxB0ChEnh8LqEqVi/o5XisJL3tbHAAkKF1gNdCRRGV8aSWAVjD/e9eD5RZqOnsbSyYB6CG
	AjyGqNGwn1QV9bhrmK3fSs1CJe8gDDoCpLZ9MuzLOxTGtvqx4Xj3pdZ39/kq2GZRMtyKno8eTQ3a6
	e+mjwifQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nttni-00Bomh-Sp; Wed, 25 May 2022 16:23:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nttne-00BolL-TD
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 16:23:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54E3767373; Wed, 25 May 2022 18:23:42 +0200 (CEST)
Date: Wed, 25 May 2022 18:23:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready
 Enhancements
Message-ID: <20220525162342.GA2200@lst.de>
References: <20220518064040.3223894-1-hch@lst.de> <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com> <20220518150044.GA1359@lst.de> <YoeA1Lh9oxwyao2S@x1-carbon> <Yoeh8KyvZbOPOrqy@kbusch-mbp.dhcp.thefacebook.com> <Yo5W96ivET39WVXf@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5W96ivET39WVXf@x1-carbon>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_092355_128830_6A5802F0 
X-CRM114-Status: GOOD (  15.72  )
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

On Wed, May 25, 2022 at 04:19:04PM +0000, Niklas Cassel wrote:
> Right now we do not write CC.CRIME bit _before_ the controller is enabled.
> We set CC.CRIME and CC.ENABLE at the same time, which strictly speaking
> is not according to spec.
> 
> Should we perhaps consider splitting the write up into two,
> the first write sets everything except the enable bit,
> and the second write sets everything + the enable bit?

Actually various other CC bits require that as well.  It hasn't been
an issue so far, but we might as well fix it.  That being said to
properly fix it we'd have to read back a register after setting
CC bits to flush posted writes as well.

