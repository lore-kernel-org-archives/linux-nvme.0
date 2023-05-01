Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5910CC7EE30
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7Pk8Ej4vQ1H2k6nL31ivJlXtBmiYC2+PSsedngpU4o=; b=HL+6oHcQjcAr1doyAKVqrjq63O
	QQn4t56314fhBNDpEAdXAP0y/2ZHkcXwO34z3ekB1XU49dP2jF62B3en6gukVHpRsujCt9LCUy4vl
	RlwWidp0q+U9SiTmNQNAx8dKcISj+HsVqcnJr+ZMsq7i2h2P89IAuk4fjNTcvcW6FIELe9LWhy/I7
	uOkYYoYY8Z+K8fyQrWQWhLxlb3AAO8ELj3fon21uH5gJkzn6anctSnodRCIHylCysS+yEJbfbk43w
	dlAGL9mwcwAwHPRPzx/L5uN8Qr1g73ZB1staaqLmzkFbdwKF6mhAo+4bi4eAVM+WkbpWOJex+NTEy
	RvBRirSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZEy-00Gj1K-2D;
	Mon, 01 May 2023 19:31:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZEv-00GizI-06
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 19:31:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8D9D61F12;
	Mon,  1 May 2023 19:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DD0C433D2;
	Mon,  1 May 2023 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682969471;
	bh=yZTPkgjXn8jZDNAxbqseiaFvxDc8hw1TPYB6hr1/1W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fs8YrZ3oyy/mVoTB9xKjEfrgOYfZHaQAc6HZx/q4sQOy9x6LY0lLYKJKSQNsKhe6y
	 cIr1FcvDQXxqO6QMlh8B69OT37kuCUg+EMKN4i9nYGaekayb3+4mXkuzbWWYQRy/XJ
	 nIWIsevVbH5UunltqXjbbk/4goElO2s54vzir7lpdld8S24b3YfXTrTddE9+T0Q+vD
	 2fWDr1nRfmnaXX3+nzAz/5G92oYbipvG79k6m+KCVPaMDOknG6PyspW5X2xgNhofqp
	 UQrVTV76TT1EvVb9IgWpf0NqiBy5NMMOdj3Y0H8J541UIeYgGC5OxwuO/xPtwruV5x
	 rDv1iD2mxlVrA==
Date: Mon, 1 May 2023 13:31:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 0/3] nvme uring passthrough diet
Message-ID: <ZFATfIe1wDjSzAgq@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947@epcas5p3.samsung.com>
 <20230501153306.537124-1-kbusch@meta.com>
 <20230501190109.GA14341@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501190109.GA14341@green245>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_123113_113826_5DA469B2 
X-CRM114-Status: GOOD (  14.99  )
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

On Tue, May 02, 2023 at 12:31:28AM +0530, Kanchan Joshi wrote:
> On Mon, May 01, 2023 at 08:33:03AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > When you disable all the optional features in your kernel config and
> > request queue, it looks like the normal request dispatching is just as
> > fast as any attempts to bypass it.
> 
> Did a quick run, and it is not the case.
> For that workload [1], this one moves to 3.4M from 3M.

There's more to trim, more work to do. I was running not quite as
heavy a kernel config as I needed, but I've got something more
appropriate to experiment with now.

