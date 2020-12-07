Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD003C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:06:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBE523447
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 14:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBE523447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2QAx5+/Qnn5RMFHKfI0YcI1Alw+r1S6BbYhOEg/zMpE=; b=vy00GX9ZQGbxK4552r1hDuXrR
	MfDvvHC02qiSDljt6Y0FnuJ07vJUJVczngzZ/2ZbDwxSJUISjgisEgNEVcByXodnMQj9yUSlkULPN
	qNS9GLETNuk113kLV/kYiupYaNfyBxold5mU7kApVP0crQ2LW2pKAOdC+gKNKTKKQGN1BKcHZzQ95
	xgUkVbnibiUdufA2A4zWELIdrIVt5LY9td1lo+MnKL92nE+SzwVRWfMbPthvP/kg4wKSkJa/qPxKH
	rWN7usuOjjCl3ghW77Lp0zuuRJI0sqzskkoqur8p9YbSzZE4RAeVV6I7F7XndA7+NDBe/gFodx1nA
	voKcfn7DQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmH9r-0001WC-Fn; Mon, 07 Dec 2020 14:06:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmH9p-0001VT-73
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 14:06:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8538167373; Mon,  7 Dec 2020 15:06:26 +0100 (CET)
Date: Mon, 7 Dec 2020 15:06:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201207140626.GB31159@lst.de>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
 <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
 <20201201193823.GA3522@lst.de>
 <20201201204456.dt2niquyaqvuci4s@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201204456.dt2niquyaqvuci4s@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_090629_420838_CCBB3BE9 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 01, 2020 at 09:44:56PM +0100, Javier Gonz=E1lez wrote:
>> Devices in subdirectories of /dev/ are very rare and keep causing problem
>> with userspace tooling for the few drivers that use them, so I don't
>> think they are a good idea.
>
> Would something like nvmeXnYc work here or your prefer something
> different where we need to implement new, dedicated filters for
> user-space? I thing you suggested nvmegXnY at some point?

I think I suggested /dev/ng*, but maybe that is to short for the modern
times, so the above would work for me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
