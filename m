Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D2EECE58C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 12:48:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD87720867
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 12:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uqv7JGni";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjp2YQSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD87720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZKTeDsywWg5+zygqXpgdpHz4lzyibulx5ujjoSLlkg=; b=Uqv7JGniJJD3Qt
	KR7CxIqGAw9Ty87NexXggBvzHA3+90g9CUpIvtVoshncagzTBRuHA7v6VDjYejSTDSI101EBhUDOZ
	m6LVvtyfGFA336UUbK/SrdZo2mMdzr+FiIB6rgJ+mELw6VoYDso5QOPWs7p8eN+m48qms+6RBo7Bv
	nCP/o1hUCxvbiGmP4jhnSFKFEggdLlTpah60LNaR3UE9u8yC+rqxE7Fmgazy2hri94py117hzbR3H
	ufTbo4jf2b7KU8yRxkHWx+rFnbXdb5l4R70BVkB38YyIGhFbEbS9lLMt//ihXQF+l/c49Ywm7dHGr
	2dBL3DO0Xk5QNYc3qTRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHSRX-00068a-Gl; Mon, 07 Oct 2019 12:48:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHSRR-000682-WC
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 12:48:49 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F82A20867;
 Mon,  7 Oct 2019 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570452525;
 bh=w7mo3IWMYbV3u8KgcWU0LeBRkWAOqm+vrId+OShjgTs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pjp2YQSMwwEcF9lzBzBIDOTR0p0TEvDwFTEL5Oq9XbjEaDywaPIid8zB1CdfzdlXf
 BjObsiYgEnvveTmpoWS+Yyu3TlBKiQ/hLEbgyAb5IX6i4IVzhiNUNE9hHtSCpxmAiy
 3sKGLXCYyafeTFubUU11UNO3HW0e5e2TeKj2j8j0=
Date: Mon, 7 Oct 2019 06:48:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] nvme: retain split access workaround for capability
 reads
Message-ID: <20191007124843.GA53339@C02WT3WMHTD6>
References: <20191007114253.30735-1-ard.biesheuvel@linaro.org>
 <20191007120721.GA21060@lst.de>
 <CAKv+Gu_mYpopYMCiq=TqHBkzZoRLJD_0Xi8J0GB8+sCHJSmK9A@mail.gmail.com>
 <20191007122738.GA24804@lst.de>
 <CAKv+Gu8cyR6Wcp4bSy4iDs0ALfzvOBwNmqx-_SbiPwwSGSFZVA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8cyR6Wcp4bSy4iDs0ALfzvOBwNmqx-_SbiPwwSGSFZVA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_054847_940205_08788718 
X-CRM114-Status: GOOD (  22.76  )
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
Cc: axboe@fb.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 07, 2019 at 02:32:43PM +0200, Ard Biesheuvel wrote:
> On Mon, 7 Oct 2019 at 14:27, Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Oct 07, 2019 at 02:24:58PM +0200, Ard Biesheuvel wrote:
> > > > If you interconnect doesn't support 8-byte MMIO read/write TLPs you
> > > > have a much deeper problem, as this will break all drivers using
> > > > readq/writeq.  And we currently only have compile time detection for
> > > > readq/writeq, not runtime so you'll have to invent a scheme if this
> > > > works at all or not.
> > >
> > > Sure. But the practical reality is that the hardware in question
> > > (including the Apple controller) worked perfectly fine until commit
> > > 7fd8930f26be4 introduced a readq() call into a file that had
> > > deliberately been switched to using lo_hi_readq() because readq()
> > > doesn't work reliably for all hardware we would like it to support.
> > > Theorizing about *why* readq() doesn't work reliably in which
> > > particular case doesn't seem that useful to me, given how trivial the
> > > fix is.
> >
> > My point here is that if it isn't the PCIe device that is broken like
> > in the apple case, but your interconnect you have a problem that can't
> > be fixed just in the nvme driver.  We have tons of other drivers relying
> > in readq/writeq working if it is available.  You'll need to find a more
> > general workaround, independent of the fact that we have a few NVMe
> > controllers that always need this workaround.  And at least for NVMe
> > the spec specically allows split 32-bit access at least.
> 
> OK, that is good to know. Mind you, I used 'interconnect' in the
> abstract sense, meaning whatever sits between the CPU doing the read
> and the 64-bit register in the BAR space.
> 
> But I fail to see your point. Why is it relevant for deciding whether
> to apply a NVMe fix if the affected hardware can or cannot use other
> types of PCIe devices? Note that I am not proposing some hacky
> workaround to be applied, but just to stick with the workaround that
> was already accepted (and I'm pretty sure that this Apple hardware got
> broken too with commit 7fd8930f26be4)

The point is the reasoning in the changelog does not justify *this* patch. If
you change the wording to not mention your host controller, and instead just
refer to the previous NVMe behavior (and modify your comment accordingly), then
we should be fine.

If you explain this patch by saying it's to fix a host controller, then the
patch is no longer sufficient on it's own and should be fixed elsewhere,
perhaps by providing a special pci_ops structure for your controller.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
