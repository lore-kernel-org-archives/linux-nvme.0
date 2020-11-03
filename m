Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFEAC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17886206F1
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 15:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I4R/O8Nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17886206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8ZKDHpBYCdmN4UK79jhOl/aip/UbunyVkx+d7oopJHY=; b=I4R/O8Nj1XYjVmhmW9+hfM1Te
	mRHEkt3NT1bRiPHQbT5OBG5KYomtiLqzQ69MfrFkimIia6VS69sTjbIQ5LipPi++MocdKEF/bSl/X
	Wu4o4yN9dQ2yore8SsrShlbdm/TI5f/Pib9RoT6fax9QwqhjDZRieLetO2xyBoq2L/ag7VxDgJiyY
	D+yCAoAxKL5tRqCd48kawd79i+MHcXiJjFZGkKqY0QhJpEyCwPWHdX1cinZ0LdfdToX3zL6kH/+PM
	eQa2qMvlrWaAkFrpDD8AZP17LNWAnB7ok0KGUWeGfJhOzpAf8kTkqifWiHZjuUrYB9+sETFo/fPy4
	JkXFYH27g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZyCO-0001Bg-D1; Tue, 03 Nov 2020 15:26:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZyCK-0001At-Sc
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 15:26:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF72F6736F; Tue,  3 Nov 2020 16:26:09 +0100 (CET)
Date: Tue, 3 Nov 2020 16:26:09 +0100
From: "hch@lst.de" <hch@lst.de>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201103152609.GA10928@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
 <20201103090628.GA15656@lst.de>
 <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_102613_092931_4AA90A2D 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 03, 2020 at 03:10:19PM +0100, Javier Gonzalez wrote:
> One question here is that we are preparing a RFC for a io_uring passthru
> using the block device. Based on this discussion, it seems to me that
> you see this more suitable through the char device.
>
> Does it make sense that we post this RFC using the block device? It
> would be helpful to get early feedback before starting the char device.

If you wan to send the RFC with the block device that is ok.  But I
think the separate character device is pretty trivial, at least for
NVM command set derived command sets like ZNS (for others we'll need
to finish the Command Set Independent Identify Namespace TP first).

> I see that this does not make much sense for the other non-supported
> features in this patch (i.e., !po2 zone size and zoc). Since this is
> very much like PI today, is it OK we add these the same way (capacity 0)
> and then move to the char device when ready?

I'd rath avoid adding more of that capacity 0 mess if we can.  Especially
as the character device should be really easy to do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
