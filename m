Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ED1C5DF63
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 18:23:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1408721848
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 18:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XwUy7zQH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2fQsqsbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9i7rGXtKiIbWAF77XYj0yPmLkxL16Wk4FHPL4rH3+BI=; b=XwUy7zQH5XKPsh
	D67TsOLKaAWwcoDpj9ZWNS5gajWd1Y6tQck2JHWvYgndcKvpERl48lJe4UdWKb8/twxgTUeu0vCgk
	TFxHGO0GWGpT2OzDcGfFZPZS+SDMaujVR9eOhcwGYdBenb0VGAU5UCExYmUXbMbvTXEJZrJ+9rOws
	1xglmIMC6svU9wvpnauY+YHB7wvnCZRMGVhWwdjH/MWvv1V1BvSHXPSaXKwNZO4f+ouSWWGi49fxl
	YAR2vRqgpgh2JEr/ZzbtWa0ECIDKS2MyshNTGgAULAx570e0+71fHXsDzFDDIn21WhYMaaaoTkt1l
	DY7X+okXa1FIo7t+dzPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSPy9-00007C-H6; Wed, 06 Nov 2019 18:23:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSPy6-00006m-BX
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 18:23:47 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 152A120869;
 Wed,  6 Nov 2019 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573064625;
 bh=NrZNbCYPFQKOTYSIaeYQqCu682wR5qwHA9joi8r1kL4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2fQsqsbSBv/iV03EhbpYVgtWhizMQdSc6duZEabWA1LBns7wOiI+cKrIoPGkfNXOa
 YSwxnn8DTi/IkbdbcHIly/msF+WMNGgUw2j02XVJlyvkNt66cK1vKDWQyWpLOH5wgE
 dNDVXHmfxO6I2gdBNxQ24jRTg4hAqjQzvPPCZmK8=
Date: Thu, 7 Nov 2019 03:23:39 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC PATCH] Workaround for discard on non-conformant nvme devices
Message-ID: <20191106182339.GE29853@redsun51.ssa.fujisawa.hgst.com>
References: <f220c69a-793d-9160-4f20-921c52748009@hasenleithner.at>
 <d96335fb-8907-6b5b-14e9-08eb1a796b0d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d96335fb-8907-6b5b-14e9-08eb1a796b0d@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_102346_415883_48086846 
X-CRM114-Status: GOOD (  19.18  )
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
Cc: linux-nvme@lists.infradead.org,
 Eduard Hasenleithner <eduard@hasenleithner.at>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 06, 2019 at 08:52:20AM -0800, Sagi Grimberg wrote:
> > As documented in https://bugzilla.kernel.org/show_bug.cgi?id=202665
> > there are lots of Linux nvme users which get IO-MMU related errors when
> > performing discard on nvme. So far analysis suggests that the errors are
> > caused by non-conformat nvme devices which are reading beyond the end of
> > the buffer containing the segments to be discarded.
> > 
> > Until now two different variants of this behavior have been observed:
> > The controller found on an Intel 660p always reads a multiple of 512
> > bytes. If the last chunk exceeds a page it continues with the subsequent
> > page. For a Corsair MP510 the situation is even worse: The controller
> > always reads a full page (4096) bytes. Then when the address is not
> > aligned to 4096 it will continue reading at the address given in PRP2
> > (which is most of the time 0).
> > 
> > This patch makes the nvme_setup_discard function always request a
> > multiple of a page size (4096) from the kernel for storing the segment
> > array. Since this makes the buffer always page-aligned the device
> > reading beyond end of a page is avoided.
> 
> This needs to come with a quirk for it.

Yeah, and have the broken ones to use the ctrl->discard_page so that you
don't need to worry about the alignment of the address kmalloc returns.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
