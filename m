Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE0C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECE3206E3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BpnDX9XY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovkwk+3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECE3206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9fspIpePuplMLlr3L5AoEl+YxcYS0zpbYn5l3SoRsrA=; b=BpnDX9XYDjuoGvHY72+D7frYb
	vzZCDswpxOq345YQbXG/iSZAe5t+tvZMEJPUwheBdqxNSYeaIn/WdxwOE5cB1xe+SCTaBJO0HhScb
	RoBVTMgvUJrzy40eEU/XQYoNC8NnwiCfdIDG+qna7UbKIGkAWfIVD65EMGA0iT4Yw+x4lBlrE1Ns/
	hI3pBQka/6n4XBEUnW1sDb7aAD/StBdAXjP79a5diGqIY8+gVK3DvOkafMpKICHMJKM8DG85kI+91
	ucHmW2kFwrt9fmt0/2xVDm/2LoWVoajmBnEU1uq0HI6eV8AhyFK7bRAJladhzYFvbWpc8itlgePQC
	FzJ1y5xqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyubQ-0007Wt-KS; Fri, 24 Jul 2020 10:06:56 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyubO-0007W0-4c
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 10:06:55 +0000
Received: by mail-vs1-xe44.google.com with SMTP id s20so4619184vsq.5
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nx9Us6fvE/iUsMsXh7T0pNo8U/ECZ5BCyqR2VoGQYII=;
 b=ovkwk+3I/iXk5jeFsY/WfnMEn0KEmtJFr5cU2ehK7tZhja2S1NphgiLhEvk7cqabv8
 N/1LOxgGvFFkl5RHpq3VVezuT9G15haWTj1gtmF3+1EdOBR+sjZ9vRynRxsvYGxi7H0b
 nfWNe4y7aUhgWKpJ8jYDqcRl0RqZSBCdG1xdVuNmHPy8y/Ga3m9NkM4JNtDnpP1Ozxl3
 X+IIXCu3HpzX8bjyf5z1qVyriIzXccruUVD6bROhwWklNyLoivuFVHmX4AcUb+tQqUiA
 yoBeN4/sGSiWq6/f3tA+cBJDO+tV0Tuy8UmlH76iiA0d+kwCaS/6NNHIR6P6t3dhKhGx
 iyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nx9Us6fvE/iUsMsXh7T0pNo8U/ECZ5BCyqR2VoGQYII=;
 b=Z406rA60hxqNLnIYLLaN7CMSw+SLKodWf/BIMYMqwToSeS2klYRElF8u5mP+Mae9IB
 9oY7JQc2BXwpE+FdQHWz1agqq1vjl7X+JgM6j4HeAjJBAM2ja0f/6vXtXuTQkM4N85vT
 tjgVstDcKpZjxFHFlYa0b7j8bR5lNlNDpAtsxhyC9dmKNCEWxw2Z7p/OAaSRVjTjcc3q
 YlmzPFsISUQ0nNmEPVqFvXT+ll8d5lfwoA9a1hJOvOjr0GhmLPPlnu0H3eJfik70oPIO
 uWiRkWcxkHu0L2M/BA7TAGq5nos+Wbz+h12DV2U1YSZKn68b+z99naSxlp3y4FQag6qz
 Sy1g==
X-Gm-Message-State: AOAM5305Hxq9/uuMqEPv5zciHiczvZowi+HV4yKkqycNHGzKNPSm973h
 JJZJEGRNrD5Lalg5NfqaiO5pdnsraALby9LplF961w==
X-Google-Smtp-Source: ABdhPJzjAIzGCHxSmawe/s8/Yy73C5qRzVM8Z655PkkXpf4XprbiEn9AMqVYCsAPbxBykzM4342UssUmkeVanoFaBEc=
X-Received: by 2002:a05:6102:126a:: with SMTP id
 q10mr6577066vsg.35.1595585211891; 
 Fri, 24 Jul 2020 03:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
In-Reply-To: <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 24 Jul 2020 12:06:15 +0200
Message-ID: <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_060654_246438_5013FEAC 
X-CRM114-Status: GOOD (  17.35  )
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
Cc: Rui Feng <rui_feng@realsil.com.cn>, linux-pci <linux-pci@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Adrian Hunter <adrian.hunter@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 16 Jul 2020 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 16, 2020 at 4:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > +       /* Continue with the SD express init, if the card supports it. */
> > +       resp &= 0x3000;
> > +       if (pcie_bits && resp) {
> > +               if (resp == 0x3000)
> > +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> > +               else
> > +                       host->ios.timing = MMC_TIMING_SD_EXP;
> > +
> > +               /*
> > +                * According to the spec the clock shall also be gated, but
> > +                * let's leave this to the host driver for more flexibility.
> > +                */
> > +               return host->ops->init_sd_express(host, &host->ios);
> > +       }
> > +
> >         return 0;
> >  }
>
> Does this need an additional handshake or timeout to see if the
> device was successfully probed by the nvme driver?
>
> It looks like the card would just disappear here if e.g. the nvme driver
> is not loaded or runs into a runtime error.

You are correct! In principle, the card would not be detected (it
doesn't disappear as it never gets registered). Instead, it's left in
"half-initialized" state, waiting for the nvme driver to take over.

I simply didn't want to go that far, to introduce synchronizations
steps between the nvme driver and mmc driver, but rather started
simple. Perhaps we can discuss these things as improvements on top
instead?

What do you think?

Kind regards
Uffe

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
