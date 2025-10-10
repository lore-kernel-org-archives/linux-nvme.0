Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8415CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Content-Transfer-Encoding:Mime-Version:To:From:Subject:Message-Id:Date:
	Content-Type:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0MiOo3WSgIW2qQCc7HRq1AiQtHg7u0CQa9HH+QPTGtU=; b=gRJ1xAz+dMCuxISvwLnRtSvSZ7
	cS7aTnxx8ajqH4NzxBNxB34C8v/EP9JOk0wvBM9c4i2Mpt2RHzFmZokp1XrQPpH3esTvVPD4GNoW1
	dg2VBNsK5MioeO6ARLunFq/OFgZDTJfnVPHxiFocljgBCCu7iZItWDvCGPXyzz09TlQgr3+O9c2cL
	mt+Gd96HWi5ISUxCBqzLZsyPaQJPzsS29hNa1S9pnBi9X/2as96gRfTM7GEcAdKyvg4jIs2QPgckt
	Wpuxixi9CLeChPxTg0BZ/rAz6gSzpRPSZIc4mNT4tiokIEjczqQILtzzvdcn8ncJT/s6CWr7kWgiI
	nBVnTPTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7CsZ-00000008WrW-0xfc;
	Fri, 10 Oct 2025 13:09:51 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7CsW-00000008Wr8-0aTE
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 13:09:49 +0000
Received: from localhost (<unknown> [66.187.232.140])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id f31c8cba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Oct 2025 15:09:43 +0200 (CEST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Oct 2025 09:09:41 -0400
Message-Id: <DDEO0BSS5INQ.2ZOZ4S1W81SQF@bsdbackstore.eu>
Subject: Re: [PATCH 0/2] Fix usage of configshell-fb module
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: =?utf-8?q?Stephan_M=C3=BCller?= <stephan.mueller@phys.ethz.ch>,
 <linux-nvme@lists.infradead.org>, <hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
In-Reply-To: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_060948_521137_47CBE9FA 
X-CRM114-Status: GOOD (  12.40  )
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

On Thu Oct 9, 2025 at 12:45 PM EDT, Stephan M=C3=BCller wrote:
> Hello
>
> These patches are necessary on Debian 13 with configshell v.2.0.0.
> Calls to "configshell_fb.node.ConfigNode" are no longer possible, when
> importing "configshell_fb".

Newer configshell versions should improve backward compatibility, but
yes, the new module name "configshell" is preferred.

>
> 1. From configshell-fb v2.0.0 on, the module is actually named
> configshell. This already fixes the Debian issue and also works on
> Debian 12 with configshell-fb v1.2.8.
>
> 2. They now explicitly export module symbols, so we should use
> those instead of referring to file names. This is more cosmetic
> thing.
>
>   Have a nice day
>   stephan
>
> Stephan M=C3=BCller (2):
>   Use preferred module name
>   Use exported configshell symbols
>
>  nvmetcli | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


Tested on Fedora rawhide with configshell 2.0.2

ACK

Maurizio

