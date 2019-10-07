Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F50ECE58C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59ABB2084D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSmXJhlp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlHkqsAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ABB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gKox7kyLKSaEcZgc34xtUBcFQFUL2X2dmvNCmesJP3w=; b=bSmXJhlpr53R3A
	qEgF1N/j7Od8xXtyGTiIB1JQ7Yz8BUy2rX1fBcWEojU5sL2Y7VsaTxfb6wOvALoNAmavfSvzsxGxd
	bPqxVlyp9v/eObHRRvIqpVmmnw6t7T83FYI3VQgktkP2OCmnmWSTfjJdu8kl99/LWJEEmIZP8hLG7
	y5ej2JGOzO8Wc6xBEx9jUqeu3T586Cg6A168fVSoCbojqEoiugKSwOqh5+jUe9mxyXJV0BC7RSls2
	m59YCiY2ne2XovkYyjfRclnHv/Mxeye8ilN5vK7bV3yPtXmMVO0JYajIAANhtexMiOyB6nZDCmi8y
	dv1pbSiwREbA5nkwGqfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHSw7-0005Df-6i; Mon, 07 Oct 2019 13:20:27 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHSw4-0005Cs-Eh
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 13:20:26 +0000
Received: by mail-wr1-x441.google.com with SMTP id o18so15227457wrv.13
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YaJJ4Ep4RplK89MbLnaosbbpArL7R3G2Cn/bHfBbabU=;
 b=AlHkqsATvHvgnS27HFmI4GUSbfBRRfMtIDMu1UcdZZhc2snNj/aiGBc5trtnwdCmi1
 gLRszCAn/kpfRyCbyXc2zyCe64c/DO2z98AWUvexXKwXJ2hyy2AwsrX5xhMUs4UEf9EV
 fB78cZWYj0XGZd7Wm/au6NTexqJI0V0q8j++bGRQhw8A4FFqT/iMzu+cAGSHgS6r4nIW
 AUBs1MMFB1KxFvvBNwn/NkEqvl/mV6u+bLiwrzuqbCLAAB4z9LESOdA5kgAvYvKKzSDv
 JPCAdm0rMXElxopMYuclrhI0TnJ1rJIJcy7Klb+OYcJ+Jrya8GdCbENHaXjOTMfTafJl
 sx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YaJJ4Ep4RplK89MbLnaosbbpArL7R3G2Cn/bHfBbabU=;
 b=UW0172aOYWoM7FbPbvgcCtviVgftZ6l9FtAUlQwzv/E7yv+F1usAmW2yrpJQIA+kx2
 MliTi+4gGershAy0mCriAFUjPCpTK5Hm9cuKdeThYQGDwIOvCbn3FciRxyAADXo8L0dJ
 iAuQSOFFnkUrkM1E3knTgE8h35Br6vzIvAlTz1CB2YVeSTOZtgagMZdV97OwBUcHRrgT
 FZvCqqkH2qIUUJzGoOsRNPT3I8RyUMnLUxvEClTdQMfBiT4eY+LznYEht3pS75gQnMmQ
 w9UKpzoOKlib0kcRiI7oRo6+qdGm3P7vRWd+2ZQ6NlyuFHJeumFXxaIWD8+ksXuHqpeO
 3Agw==
X-Gm-Message-State: APjAAAUsPESWwNHciBtNO3IThXQRROCFqunD8t/VgPPYLsIFWrdBl39e
 9soRrhD+T7WETVgJqnxTlGbFVql2oThDxdHGKYZm/w==
X-Google-Smtp-Source: APXvYqw/u26SbY8DkyElzKzUHiinl8GM/LRdzCnjTHdmnWDDPvE6lzypd3+RL1UuTwZyvXsJo4Xbs6ryvgDCqDRqyzU=
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr23578780wru.246.1570454422537; 
 Mon, 07 Oct 2019 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191007114253.30735-1-ard.biesheuvel@linaro.org>
 <20191007120721.GA21060@lst.de>
 <CAKv+Gu_mYpopYMCiq=TqHBkzZoRLJD_0Xi8J0GB8+sCHJSmK9A@mail.gmail.com>
 <20191007122738.GA24804@lst.de>
 <CAKv+Gu8cyR6Wcp4bSy4iDs0ALfzvOBwNmqx-_SbiPwwSGSFZVA@mail.gmail.com>
 <20191007124843.GA53339@C02WT3WMHTD6>
In-Reply-To: <20191007124843.GA53339@C02WT3WMHTD6>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 7 Oct 2019 15:20:11 +0200
Message-ID: <CAKv+Gu-2yBVx2sh1wZ4d8+eJ8ffc44be86=FNt6K4euh+J1+OA@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: retain split access workaround for capability
 reads
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_062024_522810_FB0A51FA 
X-CRM114-Status: GOOD (  25.51  )
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

On Mon, 7 Oct 2019 at 14:48, Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Oct 07, 2019 at 02:32:43PM +0200, Ard Biesheuvel wrote:
> > On Mon, 7 Oct 2019 at 14:27, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Mon, Oct 07, 2019 at 02:24:58PM +0200, Ard Biesheuvel wrote:
> > > > > If you interconnect doesn't support 8-byte MMIO read/write TLPs you
> > > > > have a much deeper problem, as this will break all drivers using
> > > > > readq/writeq.  And we currently only have compile time detection for
> > > > > readq/writeq, not runtime so you'll have to invent a scheme if this
> > > > > works at all or not.
> > > >
> > > > Sure. But the practical reality is that the hardware in question
> > > > (including the Apple controller) worked perfectly fine until commit
> > > > 7fd8930f26be4 introduced a readq() call into a file that had
> > > > deliberately been switched to using lo_hi_readq() because readq()
> > > > doesn't work reliably for all hardware we would like it to support.
> > > > Theorizing about *why* readq() doesn't work reliably in which
> > > > particular case doesn't seem that useful to me, given how trivial the
> > > > fix is.
> > >
> > > My point here is that if it isn't the PCIe device that is broken like
> > > in the apple case, but your interconnect you have a problem that can't
> > > be fixed just in the nvme driver.  We have tons of other drivers relying
> > > in readq/writeq working if it is available.  You'll need to find a more
> > > general workaround, independent of the fact that we have a few NVMe
> > > controllers that always need this workaround.  And at least for NVMe
> > > the spec specically allows split 32-bit access at least.
> >
> > OK, that is good to know. Mind you, I used 'interconnect' in the
> > abstract sense, meaning whatever sits between the CPU doing the read
> > and the 64-bit register in the BAR space.
> >
> > But I fail to see your point. Why is it relevant for deciding whether
> > to apply a NVMe fix if the affected hardware can or cannot use other
> > types of PCIe devices? Note that I am not proposing some hacky
> > workaround to be applied, but just to stick with the workaround that
> > was already accepted (and I'm pretty sure that this Apple hardware got
> > broken too with commit 7fd8930f26be4)
>
> The point is the reasoning in the changelog does not justify *this* patch. If
> you change the wording to not mention your host controller, and instead just
> refer to the previous NVMe behavior (and modify your comment accordingly), then
> we should be fine.
>
> If you explain this patch by saying it's to fix a host controller, then the
> patch is no longer sufficient on it's own and should be fixed elsewhere,
> perhaps by providing a special pci_ops structure for your controller.

Fair enough. Any suggestions for the wording of the comment?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
