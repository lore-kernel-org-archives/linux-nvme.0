Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262AC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 16:03:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEC860560
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 16:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DEC860560
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DnQMfa06hY+oe9Fayj1jkqtbBH7rlmmvwdaKwUrGxmU=; b=a3xKOuB/9CipvC
	jSjnIdYggsSZyT0IAMbAYuBnpW0qV9kLK7fYJU+WbEdnEeU2UnyIGbIHBaHCi07OcSpjqu7v9J6FW
	J/qLyriCZlVf/T7em0iqO1mVlYF7ilK2LBu+QZhJ4I6wk6YdNNnGXG78osuvlcurxc4IsN4PuYw6J
	piRNT2fJtPEUIs+Av6OHX5nW5ifaKaxw74VGOguIA7icFTav9yabpNWB9EkhLm+DRurJoJNr0dlaY
	xcWkGCE+GjQiko65f5WDpXUsU5gyyR/7hSpIW3G4j+GRqb2m6UldH5yb67WLeqqqf3BXclh4IFkzO
	psk6rVWpsbKcn6bhEHDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD7je-001Mgt-82; Mon, 09 Aug 2021 16:02:42 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD7bM-001J9K-Ke
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 15:54:10 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MN5S1-1mVTIW3az7-00IyZp for <linux-nvme@lists.infradead.org>; Mon, 09 Aug
 2021 17:54:05 +0200
Received: by mail-wm1-f51.google.com with SMTP id
 k5-20020a05600c1c85b02902e699a4d20cso342300wms.2
 for <linux-nvme@lists.infradead.org>; Mon, 09 Aug 2021 08:54:05 -0700 (PDT)
X-Gm-Message-State: AOAM532tg1Zu5oTjOCcvtiir4aElAxJbEc430OsJwxE16V68hT36yEO3
 YvDOScPygyBFrqmBh2v8v7FOOyVk9hdDSERQH8Q=
X-Google-Smtp-Source: ABdhPJxT0yKvMScCuSM5mX0/pHNPJqTgaibyLzMpop7c1RuOHf6jBj6MvjaxYCBC2EisGFhulbP0Oz2p87620piCEYc=
X-Received: by 2002:a05:600c:3641:: with SMTP id
 y1mr17186790wmq.43.1628524445543; 
 Mon, 09 Aug 2021 08:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <202108051646.vdMMUBea-lkp@intel.com>
 <YQ7GVu1TqpqbHZOb@infradead.org>
 <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
 <YRE7vCyn9d1ClhRm@infradead.org>
In-Reply-To: <YRE7vCyn9d1ClhRm@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Aug 2021 17:53:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bDeJ56uk74qWxPjyuZwaDf-0mCsH3D5bP+yXWLKLGtA@mail.gmail.com>
Message-ID: <CAK8P3a1bDeJ56uk74qWxPjyuZwaDf-0mCsH3D5bP+yXWLKLGtA@mail.gmail.com>
Subject: Re: [asahilinux:nvme/dev 13/17] drivers/nvme/host/pci.c:2249:2-3:
 Unneeded semicolon
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sven Peter <sven@svenpeter.dev>,
 linux-nvme@lists.infradead.org
X-Provags-ID: V03:K1:KrOLrf9jvwt2dOWGAYQmYXrK+aMUPm1Ag5Faz9ghGYESchHKpU1
 ghxtxowGyxyTxJKHGUaa6f64JGSp+EATtaGpGIMvHmhshMWOmYmw/YACUutSRsbhM7TyF88
 o92/zxEs426c6Fm7j6N583L0mXslsVksBGrh4sNQr5wm1o7yEBr1clekqpEkKfUQc0Oe/o2
 Chwh3WnAuXxRCGqdugmvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:All+Ra1wkfs=:wueZoss74/S/Ok+Msea7u9
 Rm+zHeUck27zJTw57TxNbveiVhQIYU13nHN7Q8laS6uXH5/Ufjv+AbvAnl8jT+4Z3YMBKVBMt
 DwHR5InYzkpjiWPgVcIV9pLn7HLEBJDDtb8QzUvriRhdWw419yN8DVaQlCPQW/E9camyQsYNL
 AwSX4tazs2Gd1OyVjRUNw/YaYn6rDDxapq5EfSTafqaL+zhvhFivcUptfHGnbgbfeZpNtPTcj
 X7tJVwDFldQXuzrMaFjWvZNXBAtuDb22LZ7GkdX7fPk8C5PAEPBqCkb1vp+YRc6ZzgkoSw/ro
 Kd44P7b9F0ZTS0LQDUDWYy7jECRyU2oWIj5VqWzQvkRcLHgTGsNSdqSWRykRwwzvsIjCPREIl
 Lx68ifxDSQRqO3TnLY8UI4OrfC3GMJ1NrPKag9sTIflk6EB9SiCkVKP89qrgzZrRNP9pk5AN4
 2vhA+JPaznvCa5eOp/PruaijZ189UORZIo2MYyaNXEsXhFmf8LHUnty8dRKmGb7PPuT/m5Vp0
 UAeA/bjhKm22H7whzMUxnD+1Ngv8aboMFf/Od/0bqDu1a46TrgLlVh50j8gcTyRwvNGrjL6AU
 OEI8627H1ZOKnnmI7ffIxKoINq16FPjuZFbHzD/wg8P0BZRv3oDLoNRFIeJQTE3Mtpn6VzOpl
 DN0HtK7L+We5r9Oe304U5RWT98JRYQVZN6gX25S1/wNhqETDaC/yJW0b8owIjQv7QzsnSLQBj
 BfKanEaJ4YI9erXcG68Y0Z8r2+xxLYaFXDTr2AITlGTYTTy8yLtAP0tE6mccqkusxrRUg6GAL
 x3B7/UX7ZdW5hNGgjcC300uJMbk3U+J9q5ZtME7Vy2ilTmNgpAfrNKRUaSXAeaW4vFILu0p
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_085409_020113_69E79B4D 
X-CRM114-Status: GOOD (  28.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 9, 2021 at 4:29 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 09, 2021 at 12:02:55PM +0200, Arnd Bergmann wrote:
> > Do you have any further suggestions? Should we just duplicate
> > the driver and then simplify the platform version as much as possible
> > as you suggested above, or try to share some of the code according
> > to my original plan?
>
> Yes, please duplicate it.  The tradeoff between absolute performance
> requirements and various bits of broken consumer hardware already
> is hard enough as-is that we don't need to support apples frankenchip
> in the same codebase.
>
> Note that I suspect you can probably drop a whole lot of the duplicate
> code for the apple driver.  I doubt it supports things like CMB, HMB
> T10 protection information, shadow doorbells, SGLs, etc.

Ok, fair enough. That will probably also help adding some of the
special bits that are still not implemented. I was originally thinking
that this driver could be used with other SoCs that want to support
NVMe without having a full PCIe host, but it is quite likely that nobody
else other than Apple will ever do it this way.

> Also given that it only supports a single I/O queue there is no need
> to support read queues or poll queues or any kind of queue mapping.

This one seems possible to get added in the future. Also the HMB
support, since Apple currently has their own non-standard way
of doing the same thing from their firmware, using a boot-time memory
carve-out. But since the code is already there for the PCIe version,
I suppose that could both be added back in the future.

> Also can one of you look how PRPs are actually used by MacOS?  Given
> that this device always seems to be behind a IOMMU creating one entry
> per page seems rather weird given that the apple_nvmmu_tcb structure
> already contains the full length.  Maybe it actually ignores all but
> the first PRP?

I'll leave this up to Sven to answer. He also wrote the iommu driver,
so he probably has a good idea of what is going on here already.

      Arnd

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
