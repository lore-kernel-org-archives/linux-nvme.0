Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B9C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:22:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB1620738
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OVA6IG1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB1620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rv1v7erPGlrAaUZdLbReqFcxKGTRJ7WmdoI9sfcWoYg=; b=OVA6IG1dmItB48tVvYpqWTUWj
	GK4jVfiuOyce677DWLZHAqMUvtxx0lDvDqc5kKmyURQSmr8DsEBOq1Tv9jX+t3jn0VsDy/0Z2n2yu
	WdiUMqeehVTQmOGPq1Mi6gOrHhaX3QVXnaNT7EuWg8F0RTHaP42V1TplhmZUnrN17EJuctoFyggt5
	bv5tcIvctcyGBEk9qXYfht/TKjWQ2ME8GHxdS5CuVPlpeKAlHoH9pySZ7z8e0OR4vhE3/bSOZsTvq
	Z7fticobqxvQVIzdgoq3EGBxjlVIF1Y8BFLLp+aMSby/JbCoLNgKifd9cz1ujBOlFwqbI5oVm34Zw
	7zr4UcstQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k90RS-0007hy-Gb; Fri, 21 Aug 2020 06:22:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k90RP-0007hQ-Td
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 06:22:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DE55268AFE; Fri, 21 Aug 2020 08:22:17 +0200 (CEST)
Date: Fri, 21 Aug 2020 08:22:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
Message-ID: <20200821062217.GC28559@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_022220_108307_EB15BA8B 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 01:45:50PM -0700, James Smart wrote:
> I still dislike any random ioctls coming in while we're still initializin=
g =

> the controller.

Agreed.

> =A0 Looking at the flow - I wouldn't want them to be allowed =

> until after nvme_init_identify() is complete. Especially if the ioctls ar=
e =

> doing subsystem or controller dumping or using commands that should be =

> capped by values set by nvme_queue_limits().=A0=A0 But, if we're going to =

> allow nvme_init_identify the admin_q needs to be unquiesced.
>
> So I'm still voting for the admin queue exception.

And I really don't like the admin queue special case.  What is the
advantage of letting user space passthrough I/O commands in at this
point in time?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
