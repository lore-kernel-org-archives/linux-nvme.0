Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D1C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:33:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0EB2074A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="24XE62Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0EB2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GPhbCNd+ms0T1XcSQk8fXV+rjgjK34KS6lvdIZP6Cqo=; b=24XE62Kjovn/qu11bEA75LC2X
	jd10uxliSNeqs7LAZiW056O8JQqHR/QtxMHUrLspik7hoHkLwpN8WUWVLZKfURgEy/rMYw0Aq1Axc
	GH2TKFc0wY1btBxielOhBDeNuGN4+BYdJT9M7hCAzcE5dPDFvAZarpx2c/bfQIz1GOQlEynsVCN+y
	X7C1zkNi8MJ0M52/BC3bBUQjHmZ280vtMTgE0Bnz4cOjZvyHw0MzOYMvjuebL612VDF/R9VsahDDA
	DehUwswYID5CTzDPZU47Tp1gRCjhoszsMiutfmucNgWiThiBNgw31osDuovJJMfvCGQKYjtKaxDTD
	teQuXBntA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKRK-0004lW-HN; Tue, 29 Sep 2020 18:33:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKRI-0004l7-L8
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:33:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 179E067373; Tue, 29 Sep 2020 20:33:23 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:33:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 11/20] nvme: clean up the check for too large logic
 block sizes
Message-ID: <20200929183322.GE12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-12-hch@lst.de>
 <CY4PR04MB375140467CD740CD8E677FDAE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375140467CD740CD8E677FDAE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_143324_805510_C4D77E20 
X-CRM114-Status: GOOD (  10.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 28, 2020 at 02:50:27PM +0000, Damien Le Moal wrote:
> >  	if (ns->lba_shift > PAGE_SHIFT) {
> > -		/* unsupported block size, set capacity to 0 later */
> > +		capacity = 0;
> >  		bs = (1 << 9);
> 
> 		bs = (1 << SECTOR_SHIFT);
> 
> is cleaner I think.

Maybe, but then again it is existing code I didn't even touch.
And we have plenty of << 9 or >> 9, so we'd better address them
all together if we want to bother.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
