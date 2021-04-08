Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C128C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:44:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E068C610F8
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E068C610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k9xmzU2bbDW7orj+Uj7V4aBDteTizGEuRj4KzxxHDAE=; b=efl1J1g7WqIjCJJU7OQirf8EQ
	iDIU1Z05YPP3SP2YHmu2+0mS9fCdSwPqzpR8dwDbOtYompuHq0H/4RZtadlZB/A+IVwQ5v/q3ojy2
	aqVPXRsuuc3fWw3ewDFS+ErPimQ3K+ot9p5vpHMZ489La5fzyE38zoVx3MG2ohgnoeumBDP7Lv64P
	dzks5q2f1xH+Y/k6Dpf2atv/L+z9F6HhgjA2FDab8US43GCD7CHvxyA6upFHueDj14x5PKzg74cCy
	mWgpquZY1IWyRKLB4L6N+Oc43b2HjxaT1SINmzEcBxsy2hzNdf1OlSxVgHKQzx88sJlDobPcgcZxm
	afWLvlXDw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUdNU-009OZf-UC; Thu, 08 Apr 2021 22:43:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUdNP-009OZE-1a
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 22:43:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07F93610C7;
 Thu,  8 Apr 2021 22:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617921829;
 bh=XkAv8Y1juhyUTlp+5FrKN8XWYycoc0S8qKE6fxebRew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gJm/KjOYXqKYMKWq7FmOjrRlrn0iGDjs2DHkp5vRqrPNLQxHEKOVM/E8ksIp8YCMI
 2ANVKt9ATzoO5e+jwsfeZzmDsKCrYCDgqH3JGnY33AtuQP7wEK//t7hbt5JqrdOpL1
 oce7g+fq7h4tAHKWLLNs9jXqMEbqO3D6LmBxJp+F2fEb2dgt0SqzHMuD59Q4d8S1t2
 u/p0cYBvt4ODpQvEjJw+Tyg0W9BDDG2RnN1IZVvGZe5UPkpGyDJi/Cz0j2h1tb+a5D
 S5DdzOsNupVOGfyL0Hi/8qFzarr+GlMu81A3i3P/MAT/k2LhT/6T8yTyFJqtncGpWi
 tfelmdFBpW8UA==
Date: Fri, 9 Apr 2021 07:43:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: nvme ioctl refactor and generic per-namespace char device
Message-ID: <20210408224347.GB28814@redsun51.ssa.fujisawa.hgst.com>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_234351_271837_927BC924 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

On Thu, Apr 08, 2021 at 02:08:29PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series picks up the generic per-namespace character device
> from Minwoo and Javier with a few small fixed, but rebases them on
> an ioctl refactoring I had pending, which cleans up a lot of the
> lower level code.

Patches 1-12 look good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
