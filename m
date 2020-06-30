Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A198C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 13:36:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9D1206B6
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 13:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZZcktUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9D1206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZSbWWvWnYtiOuRGvUcFgTgijMuKnJ2kP1C7Zq7b4J+M=; b=oZZcktUVr9j3IMxviUjDWnXO/
	PaZOwCXxrkskpFJ9adAt1WdY0dosA01Gv1BD2EpWQ7cMOS9nHr8REyY4oY0uOu4PXI11Fkzd+vkH3
	dDSRs/wazv1wicPd+/mhjkEojinAJ+F09r0/JExJAu+2GQeAZtD8JytKhupd3WZa29uHTftW6vmet
	AomzEdgWVCOwLfO5IFkVf4rlkAFpulgb4oR9wfxYoub93VMuWGz06l409Ex3GV8UmLinwrJYVWV5q
	GVorLRKdNp8B+r/BJ9julBEkUEbVmuhlUkGx/Pzo3V3EEMK0F5oSomd02Ti1sH/dEdzgtycBFJqRd
	10qLLEhJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGQy-0005WN-Dp; Tue, 30 Jun 2020 13:36:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGQn-0005Pr-42
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 13:36:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 019CF68B05; Tue, 30 Jun 2020 15:36:09 +0200 (CEST)
Date: Tue, 30 Jun 2020 15:36:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
Message-ID: <20200630133609.GA20809@lst.de>
References: <20200630122923.70282-1-mheyne@amazon.de>
 <20200630133358.GA20602@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630133358.GA20602@lst.de>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Amit Shah <aams@amazon.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 30, 2020 at 03:33:58PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 30, 2020 at 12:29:23PM +0000, Maximilian Heyne wrote:
> > Controller ID's (cntlid) for NVMe devices were introduced in version
> > 1.1.0 of the specification. Controllers that follow the older 1.0.0 spec
> > don't set this field so it doesn't make sense to validate it. On the
> > contrary, when using SR-IOV this check breaks VFs as they are all part
> > of the same NVMe subsystem.
> > 
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > Cc: <stable@vger.kernel.org> # 5.4+
> 
> The first hunk looks ok, the second doesn't make sense as fabrics
> was only added with NVMe 1.2.2.  I can fix it up when applying if you
> are ok with that.
> 
> But you guys really shouldn't be doing SR-IOV with 1.0 controllers
> independent of this..

And actually - 1.0 did not have the concept of a subsystem.  So having
a duplicate serial number for a 1.0 controller actually is a pretty
nasty bug.  Can you point me to this broken controller?  Do you think
the OEM could fix it up to report a proper version number and controller
ID?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
