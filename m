Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96072C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 17:02:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6395A20738
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 17:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KOAkx9e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6395A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0pQyyG3wMbHmgm7teyAuGAixDQstffMS3ww1aJZJexI=; b=KOAkx9e/rPDfNfnf/GeMvpLwE
	b66S1yq2g9081e7Avj6H7lpx44YiEepnR5cM5l6cb5sBZ4L8JjrM5OncTkj5r7X0VGlRwYVmmEUt9
	uu50wDnaPuEIYOnyg6Xg1bp6OWOrTiRHD1mdWrc31z3MugzlCuu4zZGb3vsVkSuSMvatTB5qYFJyc
	55zFyiH/dn5AOQmQhU1GAmFQsYs+A8lFsQGuolv11OFQRXzZKbuoKJ3bQcFVcoKVgxm1G8rtlyTzz
	70s4tV9km3j9IaqfowMlC15gLZsGxENI6D/JjY4lXbjQWt4RG4Pp4s9Ci+nOq9/QbXb3zeFbFNQ5h
	3RKyQCT/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo8n0-0007kv-0I; Wed, 24 Jun 2020 17:02:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo8mv-0007i0-KJ
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 17:02:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 65A5768BFE; Wed, 24 Jun 2020 19:02:11 +0200 (CEST)
Date: Wed, 24 Jun 2020 19:02:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed
 fields in initializers
Message-ID: <20200624170211.GA25230@lst.de>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
 <20200624164441.GA24816@lst.de>
 <20200624165746.GA394355@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624165746.GA394355@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 04:57:48PM +0000, Niklas Cassel wrote:
> On Wed, Jun 24, 2020 at 06:44:41PM +0200, Christoph Hellwig wrote:
> > This looks good to me, but I'd rather wait a few releases to
> > avoid too mush backporting pain.
> 
> Chaitanya made me realize that about half of the nvme functions
> are using "struct nvme_command c" on the stack, and then memsets
> it, and half of the nvme functions are using an initializer.
> 
> IMHO, using an initializer is more clear.
> 
> memset has to be used if the function needs to reset an
> existing struct, but in none of the functions that I've seen,
> are we given an existing nvme_command that we need to reset.
> All the functions that I've seen declares a new nvme_command
> on the stack (so an initializer makes more sense).
> 
> What do you think about me unifying this later on?

I like the initializers a lot.  But as I said I'd rather wait a
bit for now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
