Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03178C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:49:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD98160F56
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD98160F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZZrLtjwjEJ3IPsG9yhz+Qsv7Mbcxqz9ceN0wVwrxJA=; b=y4GzeDC2CnLUc4R0p0P3WTqYpV
	VhKjzEAVr7kXb+hb4TXUphOOAWKKRQSQekiUAL68SBvGd6SGsPqcrY4QTNopH0VjjQy/rC78JOlrj
	PgAPhrOmMUAS3fsaOCuy7vF9Ecl03vJCzbtEh8Apjxx9GmFCBEBKj+0lzNZCmxdPE2WbnwUL91SZ8
	OkQQg76Mo3gsPPBqrQFo3BOg+4mB60ccEQmjCM6t5/i0ogEp2cmbk8pDSa+LE0SeCbk2MXBgSfSLc
	CmiSprmZOs9K8N83VM+Ns7jQJrrMYXYvQ6Ga6iSukkxJv+cAKEuuPU7OlctORieRVCr/CMhlanho9
	cWpqla5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi4TL-003g8x-8m; Wed, 03 Nov 2021 00:49:47 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi4Sz-003g3W-3O
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 00:49:26 +0000
Received: by mail-pl1-x62e.google.com with SMTP id n8so1372507plf.4
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kZZrLtjwjEJ3IPsG9yhz+Qsv7Mbcxqz9ceN0wVwrxJA=;
 b=JRgj/olnX5KG4c7O7Xm0Jry+oiIPPVRs0ttrw6gNfqqnI1KamWVto+1Pxon2fIWDB1
 x1F3THYxTFa5CE7AzpmpAplt8VFcFKfqy3d3MAGp0s5nJkBUy9JedsZ+4OS6KUAKM+vB
 DvCegoQKw1vFIw4wXLe3UECLM26Wd75Cn2MgSkM0NOQW/tEUxE7RV1jJdp+3GjtYuyB8
 qk4COR6f2KXYi8/R57t9nLZVLeQ2fx8WIoFzd2PpFjGLiu6nnZ/mrHGax9Rr3YH4SIxn
 s76DGqePmbOMyvjyajU4ySIeJgRloDb6/b5JkF/zEIEF+UPqSUTfuYb6YiGVu536BR06
 QRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kZZrLtjwjEJ3IPsG9yhz+Qsv7Mbcxqz9ceN0wVwrxJA=;
 b=4nCq2yMpnOa8asji0u+45xjYW1f22QjFD+3aDCabc9WTPzKlIssYr03qpT89R83+5D
 3lZWlpnL96e5Gy4EsN3lnT7/SO3w5971hTVc0sXRNroKdKdoQOnzsYbUBlIenosNzuq+
 G5e35R9ll+qtDRnAjSDu95eTPPcv3jI/jAUtm6NM0yrLigUZA0RboeywdcdDtQcbbyxS
 m6Aou9aec0g921hsgE7u1pEk88p6GyeRdJmWxCumwVLHUTbqzIkN/GdaW2+Sb1Vp6Bha
 YDfB2J3KeReoUbcYYVi9lN/ygTM0SpL+834rYQCqgjhBTOrvzx15MjhKGevRiQDMqDrD
 BBww==
X-Gm-Message-State: AOAM530Yy6eLs8+IZOm64Y6EhxVyT122r5UsjiJGs/XALH981euxb6hJ
 Mnq3fa1b4w8lql0HwU6ym+jHNKK6wADZzgTdmO43mg==
X-Google-Smtp-Source: ABdhPJwbP41jEB/HwdZ/jyTpqMsXVbZeJ+GyahtI6BJWNgrRKpi/yor5GNtI40x53AU7YBTd151lFNCU4w2eHv7w/mI=
X-Received: by 2002:a17:90b:3b88:: with SMTP id
 pc8mr10700972pjb.93.1635900563928; 
 Tue, 02 Nov 2021 17:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-7-mcgrof@kernel.org>
 <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com>
 <YYHTejXKvsGoDlOa@bombadil.infradead.org>
In-Reply-To: <YYHTejXKvsGoDlOa@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 2 Nov 2021 17:49:12 -0700
Message-ID: <CAPcyv4h1dqBm71OQ_A5Qv4agT3PhV7uoojmSB1pEpS-CXaWb5w@mail.gmail.com>
Subject: Re: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early
 failures
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>, 
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
 Minchan Kim <minchan@kernel.org>, 
 Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org, 
 Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com, vigneshr@ti.com,
 Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 "Weiny, Ira" <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mtd@lists.infradead.org, 
 Linux NVDIMM <nvdimm@lists.linux.dev>, linux-nvme@lists.infradead.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_174925_219948_BA158010 
X-CRM114-Status: GOOD (  24.54  )
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

On Tue, Nov 2, 2021 at 5:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 05:13:48PM -0700, Dan Williams wrote:
> > On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > If nd_integrity_init() fails we'd get del_gendisk() called,
> > > but that's not correct as we should only call that if we're
> > > done with device_add_disk(). Fix this by providing unwinding
> > > prior to the devm call being registered and moving the devm
> > > registration to the very end.
> > >
> > > This should fix calling del_gendisk() if nd_integrity_init()
> > > fails. I only spotted this issue through code inspection. It
> > > does not fix any real world bug.
> > >
> >
> > Just fyi, I'm preparing patches to delete this driver completely as it
> > is unused by any shipping platform. I hope to get that removal into
> > v5.16.
>
> Curious if are you going to nuking it on v5.16? Otherwise it would stand
> in the way of the last few patches to add __must_check for the final
> add_disk() error handling changes.

True, I don't think I can get it nuked in time, so you can add my
Reviewed-by for this one.

