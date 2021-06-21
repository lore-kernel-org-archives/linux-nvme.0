Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F0C49EA2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177CA6135F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 16:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177CA6135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QfcRn4v1H5liG1X5WH2PmY0NGSveMI6bvjO13yIW+d4=; b=QUHrrazx0+86Mt
	R4HGGNuYE4XcgwdDiU9DbfQ9MAGiIdxBVKDKwxRmztCvNhw1xt2f33UIwGoo5Zjj3sKYvH11PkDlS
	BTuMKKgVrHFXiRXpdM76DE3hqis1W9KBCWys6a+Lqi1DCLR+s1M7tD52cr16hTOhRDjLPV5C6aJ49
	I/sC+K41u0hW/RXzEMVVfJVxVCGd5ejbzWTeLDYmwL2aFBjettkyAUROvIpCrexK1iXuKwZ474K66
	NwgKrUGXa5oufDhZvmebfHThH02aTFYzsxy3C98k/7+6Q9JAjFkv4j23dY2/Okla9g4zIuWgqrdZc
	XaGa6R34u1ZK7hfZK/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvMey-004593-UG; Mon, 21 Jun 2021 16:20:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvMev-00456v-L1
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 16:20:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 75A4468B05; Mon, 21 Jun 2021 18:20:20 +0200 (CEST)
Date: Mon, 21 Jun 2021 18:20:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: add comment to not use kobj_to_dev()
Message-ID: <20210621162019.GA7655@lst.de>
References: <20210621030940.22286-1-chaitanya.kulkarni@wdc.com>
 <20210621053251.GA4360@lst.de>
 <20210621161743.GB1268033@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621161743.GB1268033@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_092025_879421_F4ACC288 
X-CRM114-Status: GOOD (  17.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 21, 2021 at 09:17:43AM -0700, Keith Busch wrote:
> On Mon, Jun 21, 2021 at 07:32:51AM +0200, Christoph Hellwig wrote:
> > On Sun, Jun 20, 2021 at 08:09:40PM -0700, Chaitanya Kulkarni wrote:
> > > Add a comment in nvme_ns_id_attrs_are_visible() and
> > > nvme_dev_attrs_are_visible() not to replace container_of() with
> > > kobj_to_dev(). Since use of kobj_to_dev() makes code harder to read.
> > > 
> > > Suggested-by: Keith Busch <kbusch@kernel.org>
> > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > 
> > Err, no.  This code is completely obvious as is, and if people keep
> > sending these stupid patches we need to start blacklisting them.
> 
> People will continue to send these patches as long as
> scripts/coccinelle/api/kobj_to_dev.cocci keeps warning about it.

Maybe we need to fix that instead?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
