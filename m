Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65801C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 12:08:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAC7225A9
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 12:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAC7225A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lblIUGm6oYOKJvI737UHJ95iBPaF8l2nu1aZTp8taXg=; b=3PrUD0VL8XuVi0Jtb+wKhcUPW
	PL4e8qgWtAbs7PVKbiV1KJNiX7Q7ZqBnE85HWU3+i9sb3OPIcn7B1t46lTX/k08cZK17so7STZ+MZ
	RwI60KyYgwT8LoqkygZmdquEbazyfsEWYarrFvXZpZI/iN2cZydfO9OOtKMK1HYP60C8/0K/P5JHf
	lQJCsaXgJtvdTh9bkrXEvdOXA3zT1Rwoi2TWbLmIEOyxxzmunX69rvQ5pL9QPZwcf+tBUb+UkYKXn
	Di07HvUmcPUK/qyVs5WEp8IusiVgHU/QMGbsJ68ie8Pll/tGIMx3VOlb+/ws4Zz3cPd4aKMR81SrQ
	TSMcg+Brw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl9sj-0003gR-0p; Fri, 04 Dec 2020 12:08:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl9se-0003fx-MB
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 12:08:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8315C67373; Fri,  4 Dec 2020 13:08:03 +0100 (CET)
Date: Fri, 4 Dec 2020 13:08:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201204120803.GA20727@lst.de>
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl> <20201204110847.GU201140@mail-itl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204110847.GU201140@mail-itl>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_070808_872082_C5C4F589 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: Juergen Gross <jgross@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
 Christoph Hellwig <hch@lst.de>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 04, 2020 at 12:08:47PM +0100, Marek Marczykowski-G=F3recki wrot=
e:
> culprit: =

> =

> commit 9e2369c06c8a181478039258a4598c1ddd2cadfa
> Author: Roger Pau Monne <roger.pau@citrix.com>
> Date:   Tue Sep 1 10:33:26 2020 +0200
> =

>     xen: add helpers to allocate unpopulated memory
>     =

> I'm adding relevant people and xen-devel to the thread.
> For completeness, here is the original crash message:

That commit definitively adds a new ZONE_DEVICE user, so it does look
related.  But you are not running on Xen, are you?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
