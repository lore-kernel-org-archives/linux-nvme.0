Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DE1C6FA82
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 05:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IpPnYaGLF+OoL5hO/jFb4NakKlMg5vVO41InGl4bWns=; b=xIt5iJbRzpV3fNdvbQ7GYS66bH
	J22/ehWEYytbVcj4MDr9u4KjqyyOToJ6xPY8NYDNWmyZrV44VuZTWC4k+s2C/QmbOc0i6EJFuIWTR
	dj2qA0laUjImYIlYAcIaCaUV7tqG9jhPDjLqxJ7ZDg2w/wOYiN86b/8fsP4s84k8QUEqSBus2dAsD
	Y9iMkt9S7jllMTi0VMELGL/uJaojaZ0rtr4Bgkfi8yTwQKT4lCZATvIEVJazaIc8mwCjMwGssl+P4
	ZxGaYDkALyXNW52xy7vwvUa5q78j5VtDxLYwarC8UB25qoY/ZFI0jF4FAOATt36NKUdOCrF1U2JFd
	I25INmpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt87-006TNt-7Y; Sat, 10 Sep 2022 05:34:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWt83-006T6g-Ny
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 05:34:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 254CB68B05; Sat, 10 Sep 2022 07:34:04 +0200 (CEST)
Date: Sat, 10 Sep 2022 07:34:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	j.granados@samsung.com, javier.gonz@samsung.com
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <20220910053403.GA23158@lst.de>
References: <20220909163307.30150-1-joshi.k@samsung.com> <CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com> <20220909163307.30150-2-joshi.k@samsung.com> <YxtwiDE0amT5DuNt@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxtwiDE0amT5DuNt@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_223407_948314_19D16D2C 
X-CRM114-Status: GOOD (  13.86  )
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

On Fri, Sep 09, 2022 at 10:57:44AM -0600, Keith Busch wrote:
> On Fri, Sep 09, 2022 at 10:03:06PM +0530, Kanchan Joshi wrote:
> > +bool nvme_admin_cmd_allowed(u8 opcode, fmode_t mode)
> > +{
> > +	/* allowed few read-only commands post the mode check */
> > +	switch (opcode) {
> > +	case nvme_admin_identify:
> > +	case nvme_admin_get_log_page:
> > +	case nvme_admin_get_features:
> > +		return (mode & FMODE_READ);
> 
> Some log pages have read side effects, like Namespace Changed List or anything
> latched to RAE. That opcode seems a little more dangerous than the others in
> the whitelist.

Yes.  Some of the log pages (e.g. the persistent error log, or the LBA
status log) are also getting really close to covert channels.  Can we
please have really good justifications for why we'd whitelist anything
on the admin side?

