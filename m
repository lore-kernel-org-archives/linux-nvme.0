Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6257C47404
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 12:27:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876DD2070B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sOAIg9Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876DD2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JHAp0uD2ixdLUAhnVYU25lvRFoQQx6Lmiipq7R2dCI4=; b=sOAIg9Z9en6Zgi
	Gdl5DRTbHUWqduGOSCU3GSxELwS7tbnWzukbFkqEPbzFxXw4Xj41BoE94fwQqngnnmddDNUxLMeSR
	aqChhwsOtWWGUPLgqlPDrqft7n4XC4cTwr/1O2t7iUHpmyFnxznRZamTnbL6bNizX5DdX4tC+c6MN
	56cxgZNLRu3wOIMz7IpyY6Z31+X7i5zz625GeKyKPX/GkqNzp8WxvqnCzP+/um/1o1jnBrtdrwiBu
	Ek1dtLq0IaVPYOPOwRMl28cMvkC6b7PAq/dusaJs1amklbdVyZ+sPDLXdibbz6hMbw3JZ6tOYnGdD
	S9P/WVR1xJVulI8Jch9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHS77-000570-EG; Mon, 07 Oct 2019 12:27:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHS74-00056e-Cb
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 12:27:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7D0AE68B20; Mon,  7 Oct 2019 14:27:38 +0200 (CEST)
Date: Mon, 7 Oct 2019 14:27:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] nvme: retain split access workaround for capability
 reads
Message-ID: <20191007122738.GA24804@lst.de>
References: <20191007114253.30735-1-ard.biesheuvel@linaro.org>
 <20191007120721.GA21060@lst.de>
 <CAKv+Gu_mYpopYMCiq=TqHBkzZoRLJD_0Xi8J0GB8+sCHJSmK9A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_mYpopYMCiq=TqHBkzZoRLJD_0Xi8J0GB8+sCHJSmK9A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_052742_571665_4DE4EC9E 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: sagi@grimberg.me, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 07, 2019 at 02:24:58PM +0200, Ard Biesheuvel wrote:
> > If you interconnect doesn't support 8-byte MMIO read/write TLPs you
> > have a much deeper problem, as this will break all drivers using
> > readq/writeq.  And we currently only have compile time detection for
> > readq/writeq, not runtime so you'll have to invent a scheme if this
> > works at all or not.
> 
> Sure. But the practical reality is that the hardware in question
> (including the Apple controller) worked perfectly fine until commit
> 7fd8930f26be4 introduced a readq() call into a file that had
> deliberately been switched to using lo_hi_readq() because readq()
> doesn't work reliably for all hardware we would like it to support.
> Theorizing about *why* readq() doesn't work reliably in which
> particular case doesn't seem that useful to me, given how trivial the
> fix is.

My point here is that if it isn't the PCIe device that is broken like
in the apple case, but your interconnect you have a problem that can't
be fixed just in the nvme driver.  We have tons of other drivers relying
in readq/writeq working if it is available.  You'll need to find a more
general workaround, independent of the fact that we have a few NVMe
controllers that always need this workaround.  And at least for NVMe
the spec specically allows split 32-bit access at least.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
