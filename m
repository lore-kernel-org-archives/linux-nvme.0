Return-Path: <SRS0=6Jtf=X4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9083C10F14
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 11:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA701215EA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2019 11:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmMXsHpw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISHaO3LT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA701215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MLo21m54Y2IrMw+2lhc3ab1/PoTbTLtQ/Ik3JdGhlEI=; b=hmMXsHpwKNPALY
	WyTmLGNK8z6ED3sHSK4AK6OsETLMjG4IMahIbo1aJgXFN4IACQfQBKkAK0yYUcjIB0I7VROKiQNSR
	XDkV0ZzC3TdtM8uOoiiG2EJu6ndQvdbcHP2RACFKrNjRSful5pGxrC2TF4zLGQIHbWC+WRnTPX2yv
	TCJBqZVAu+GsIDJ0jjhlFBR1KITSPgHNIq0z223OOrW1OTZOOdwkGqeLQE1X7VIlnYc+TW2FqX58V
	1Efa7TnXRFRYwo6xh/hJ9NDGsWxodMWFzgRno21qGKVNk7MR+zo5CfLlWpcTqUbPgWp+TsDMmUCD1
	1S7/CdxLxZBAKOMCuUbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFzdf-00085c-Na; Thu, 03 Oct 2019 11:51:19 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFzdd-000854-3D
 for linux-nvme@lists.infradead.org; Thu, 03 Oct 2019 11:51:18 +0000
Received: by mail-qt1-x844.google.com with SMTP id m15so3141529qtq.2
 for <linux-nvme@lists.infradead.org>; Thu, 03 Oct 2019 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6RkSF+zEbIf0w7SAZcShqKOpvOfQhtZAsRhpa5BVImI=;
 b=ISHaO3LTvvlhjT3/vRAEEn3AHGondFsxO9NDYKYxl9gKF2Y2nW3QPbACpaTmAuGoZx
 1JbM+XDef65wPuruTiPoIvLXij4CH/FpB+Ry4NM2E5uZOH/yT08jYS0z6cjOq6QLm8/b
 kmuFVwdk7zExUe2+js1ft+4gDYVqsSpWuAgG3cI2x1jb0nNnMMQjqO8nPSlA2tFwdYDP
 5bSDgiRwDg1R0Ks3Jhoo3zLgu2U59OEqcAM9lSp1ju8KGoRN29wiEIItTWT09/3nSCdq
 bb0RhrHF5MRi/VFaJuPrLuS+acNusc+/8mxhFZsJjzCJO7LbQjDcOtJi+FJ7HrYfHSdY
 Uq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6RkSF+zEbIf0w7SAZcShqKOpvOfQhtZAsRhpa5BVImI=;
 b=fYjjk57kCOVkwrGIKuwBpkj/axauOuti7WeXC0RxaBSpJg/nQSTn8gVBA1o2sMX44q
 4CwcuZwe9l04nK6SvPhZ0OuZSZ4wtPzjcOzzaW+ben+gmVirGmmy/EiEq22CgCI1JnkV
 9LC0y3XOM2DbLv7GOYINB0osrqXnugEq50Ts0dORPYDEB/cLs+HrKHYb3CDLEk39I3W4
 pra6yyC4+Q+IimEOg9qu9nYufYzkZCaZjKeZtIYjWYOHGMh6Vl8HdBzunmvF+3tQvOh2
 TDwksP1JNpz1RBQGnDtAB/sA6grAC29QqbGTsxReF6O4uznBexnBcrxavXIlcgmBP2Xd
 z+VQ==
X-Gm-Message-State: APjAAAVykQnt1EUD0Fucit7vjaeXYkGpI7od4A0stAyyyvWuNad3WYHN
 ZDOvQYcUjMmVfPfK24zPnc/3VqPYxYkIinux9AA9sw==
X-Google-Smtp-Source: APXvYqwj997WpvpwAB0/1CPiO7NekEFL+RjT02mA8l4CuA4qq2TeFlmmaBbAG6SmkuA8tAPgRg9hnr/hTknErIuK1v8=
X-Received: by 2002:ac8:2497:: with SMTP id s23mr9116787qts.329.1570103475265; 
 Thu, 03 Oct 2019 04:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
 <20191003114901.GA34459@C02WT3WMHTD6.fritz.box>
In-Reply-To: <20191003114901.GA34459@C02WT3WMHTD6.fritz.box>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 3 Oct 2019 13:51:03 +0200
Message-ID: <CAKv+Gu_YCRwvtc=QSu0V2i1GESxHv9ndkqe0cyJsDaL6LQATDw@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: retain split access workaround for capability
 reads
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191003_045117_170747_06D05A00 
X-CRM114-Status: GOOD (  19.17  )
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
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 3 Oct 2019 at 13:49, Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Oct 02, 2019 at 09:36:43AM +0200, Ard Biesheuvel wrote:
> > Recent changes to the NVMe core have re-introduced an issue that we
> > have attempted to work around in the past, in commit a310acd7a7ea
> > ("NVMe: use split lo_hi_{read,write}q").
> >
> > The problem is that some PCIe NVMe controllers do not implement 64-bit
> > outbound accesses correctly, which is why the commit above switched
> > to using lo_hi_[read|write]q for all 64-bit BAR accesses.
> >
> > In the mean time, the NVMe subsystem has been refactored, and now calls
> > into the PCIe support layer for NVMe via a .reg_read64() method, which
> > fails to use lo_hi_readq(), and thus reintroduces the problem that the
> > commit above aimed to address.
> >
> > Given that, at the moment, .reg_read64() is only used to read the
> > capability register [which is known to tolerate split reads, which is
> > not guaranteed in the general case, given that the NVMe BAR may be
> > non-prefetchable], let's switch .reg_read64() to lo_hi_readq() as
> > well.
> >
> > To ensure that we will spot any changes that will start using the
> > .reg_read64() method for other purposes, WARN() if the requested
> > offset != NVME_REG_CAP.
> >
> > This fixes a boot issue on some ARM boxes with NVMe behind a
> > Synopsys DesignWare PCIe host controller.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > Broken since v5.3, so if this gets fixed one way or the other, please
> > add cc: stable.
>
> Since 5.3?! 'git blame' says the code has been this way since 7fd8930f26be4,
> which was from 2015 during the 4.4 development cycle.
>

That may be true, but the box in question happily boots a v5.2 kernel.

> Please add a:
>
>   Fixes: 7fd8930f26be4 ("nvme: add a common helper to read Identify Controller data")
>
> to your change log above your sign-off, and remove the WARN_ON().

Sure.

Thanks,
Ard.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
