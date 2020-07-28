Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00808C433EA
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EC320714
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNrCyobp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EC320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rp8wGdjhyvddM1aH7rTJkLiuYldGVqyHpttAMXKQErs=; b=HNrCyobpNSz4vnWgijwR4ssw8
	0Ot2+GISGw8mwovB/LXIATUKktprYFYvCsAAI3n8JJfcvuX/zfwZXMaXfnkPbdoVGnFlBypWP1jUt
	JufAFkvDmH/moonVeFjZ9MlpULGxg5EYVcZOEXpLGmyepNMXV4VMQuG6snNtuGXiDgGjrSSmjKxy/
	ZftoujlzYWcxtj9lQRPikFngw2G+DoVfCy61MkmCvO3F9zAzrJ1daGiTMPcoHbwh6xb343iHBTcGk
	OEOXgxvIVVKlCHroIl08qN3G6V1z+rKOrk4K62yRzC3UZ3rm4Vig8CF81SVCd6rSrVS/umxhiQyyY
	KeSRS0Mcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0NBz-0001xi-Rc; Tue, 28 Jul 2020 10:50:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0NBx-0001x3-WB
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 10:50:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6825A68C4E; Tue, 28 Jul 2020 12:50:40 +0200 (CEST)
Date: Tue, 28 Jul 2020 12:50:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: fail non-ready command only for
 NVME_CTRL_DELETING_NOIO
Message-ID: <20200728105040.GC29442@lst.de>
References: <20200728054201.23184-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728054201.23184-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_065042_162437_49E4DB08 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 27, 2020 at 10:42:01PM -0700, Sagi Grimberg wrote:
> We allow NVME_CTRL_DELETING to accept I/O.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Christoph, another patch we want to fold into
> 97e9bb2b27bc ("nvme: fix deadlock in disconnect during scan_work and/or ana_work")
> 
> thanks...

Folded, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
