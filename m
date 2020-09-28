Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF19C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:26:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56EF21974
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wrRdHtI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56EF21974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EBcV22ep1NfB+/aH20pd2PHOtPcmigVoaakdFovah10=; b=wrRdHtI9+WucCPyOqxjt4WQ5s
	Waj4wmHx7QMGo69FkGIH8M6zYqVy+csE/GRywEFakEr0ZyjksLt3v1VM7SUkDvFriTjxVYqUQHYDC
	af7biOtNaZNOKyOo4Gg+eVqAse7zuh/gE5Ieeg7ITfw+vV6OCIlll84qr0QW/5hxp/WyiciEJ9WM6
	FTIrZV2cLT6n1jRBr6kapMig5P8Jx6vruYrBv9yFHyE0Qw9CfniPqVOdLhjtwAM6z570b9LDssV3F
	eh5I/FvTgeMYY/a/n6K90r85Uofy8I5zVU/V5ve3kRmNDtsCy3GdZynnT/lw8oXeb8xq12YH7WeW2
	6zxFKgHsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMu6W-0003Bb-8J; Mon, 28 Sep 2020 14:26:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMu6T-0003AI-Qg
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:26:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B509B68B02; Mon, 28 Sep 2020 16:26:06 +0200 (CEST)
Date: Mon, 28 Sep 2020 16:26:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 02/20] nvme: fix initialization of the zone bitmaps
Message-ID: <20200928142606.GA12705@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-3-hch@lst.de>
 <CY4PR04MB3751BD67B00FA6F6D3442E96E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751BD67B00FA6F6D3442E96E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_102610_001715_9138F7E4 
X-CRM114-Status: GOOD (  10.66  )
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

On Mon, Sep 28, 2020 at 02:16:34PM +0000, Damien Le Moal wrote:
> > +int nvme_revalidate_zones(struct nvme_ns *ns)
> > +{
> > +	struct request_queue *q = ns->disk->queue;
> 
> struct request_queue *q = ns->queue;
> 
> may be ?

That would indeed be a little shorted.  But both should work the same.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
