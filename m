Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4901C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:43:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810ED20706
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAUKOCyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810ED20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/tmrdjnRh6u7bLOidWg2AedlU7+0weTXXEuADS8bXMk=; b=bAUKOCyt9ogt1bwDPG63jYcTf
	7Du/tl0SZQgimLFN2in2zwF0eOvu/StnTQ1Q2AhzMqjz2850zU3r2AkiSP03g0OGhP/aSTVZ+oHCY
	bcjEipqSalR6x+pJeuGuWTBdxjtZOeFyTCqxO/f+CcLThMGezc5t/7Lh+hut/qjRnAfrCp+W4Ky7m
	e/Y1lOmhm4PwU7T/6C1oZywaoRjKZNciIgDA1j8nuWYDEvnt0q/w4d224kQQOe4bAr2NjpSqV1pDK
	NPGONOTPMAmw9zTjx8Dx38l64gTCLeZ92t39gcQCJ/e5Co8OzHSiVTwxa3PRI7F2OBp9mghIvpNy+
	2SacpAtDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnz7s-0003Vk-2v; Wed, 24 Jun 2020 06:43:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnz7o-0003U9-J1
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:43:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF64768AEF; Wed, 24 Jun 2020 08:43:09 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:43:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 RFC 6/6] nvme-core: fix deadlock in disconnect
 during scan_work and/or ana_work
Message-ID: <20200624064309.GG17594@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-7-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624001853.5408-7-sagi@grimberg.me>
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 05:18:53PM -0700, Sagi Grimberg wrote:
> From: Anton Eidelman <anton@lightbitslabs.com>
> 
> A deadlock happens in the following scenario with multipath:
> 1) scan_work(nvme0) detects a new nsid while nvme0
>     is an optimized path to it, path nvme1 happens to be
>     inaccessible.
> 
> 2) Before scan_work is complete nvme0 disconnect is initiated
>     nvme_delete_ctrl_sync() sets nvme0 state to NVME_CTRL_DELETING
> 
> 3) scan_work(1) attempts to submit IO,
>     but nvme_path_is_optimized() observes nvme0 is not LIVE.
>     Since nvme1 is a possible path IO is requeued and scan_work hangs.

I'm really worried about another flag outside the state machine.  If
we really need a multi-step deletion we should have
NVME_CTRL_DELETE_START, NVME_CTRL_DELETE_CONT or so states and run
this via the state machine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
