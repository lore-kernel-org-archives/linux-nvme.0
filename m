Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22693CDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 04:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8di0iredMFwN6ESsoYaq9hOsbtaJBv+rRbxTL/SdYSE=; b=NnaVd7KeIayEPwKnIQYoGlMokx
	zS0iKxld2MZIS+8vtl3+aLWnlxBLqJH3E0coaK5rDnjhlKDkWBe64H/6XLzjUYSzNuDKaiCsgz7Od
	xXPV4mEGjHTCj2SjwcHXV6xm0GB1be+Tr6yWJv4yPf0SuaMf+0/jEKnIFkVdL/lpH2OBD/PyAr/cc
	otgO+pmpto3uQ1wOEeqdJEhYaJl5WRzWYb8Cj4pyfxrwSHAQgA59+3sBxZg+/93P4a/F4Fd3RAcab
	NVIsI8pxQFBHcDp+f6zSpOUDRdgzrTLU/dBwSlH7v+MgCnSuO83R5ezV529FqbQST2cMFB6Bjhs4J
	mBN9eLZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqnRc-00HNZP-1a;
	Thu, 12 Oct 2023 04:37:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqnRY-00HNXu-17
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 04:37:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E98606732D; Thu, 12 Oct 2023 06:36:52 +0200 (CEST)
Date: Thu, 12 Oct 2023 06:36:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231012043652.GA1368@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_213704_554073_EA109CFE 
X-CRM114-Status: GOOD (  20.29  )
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

On Wed, Oct 11, 2023 at 11:04:58AM -0600, Keith Busch wrote:
> > > Given the way things are in NVMe, I do not find a better way.
> > > Maybe another day for commands that do (or can do) things very
> > > differently for nlb and PI representation.
> > 
> > Fixing just a subset of these problems is pointless.  If people want
> > to use metadata on vendor specific commands they need to work with
> > NVMe to figure out a generic way to pass the length.
> 
> NVMe already tried to solve that with NDT and NDM fields, but no vendor
> implemented it. Maybe just require SGL's for passthrough IO since that
> encodes the buffer sizes.

How is that going to help us with metadata where neither we, nor most
devices support SGLs?

> I don't think it's reasonable for the driver to decode every passthrough
> command to validate the data lengths, or reject ones that we don't know
> how to decode. SG_IO doesn't do that either.

I don't want that either, but what can we do against a (possibly
unprivileged) user corrupting data?

SCSI has it much either because it has an explicit data transfer length
(outside the CDB) instead of trying to build it from information that
differs per opcode.  One of the many places where it shows that NVMe
is a very sloppy and badly thought out protocol.

