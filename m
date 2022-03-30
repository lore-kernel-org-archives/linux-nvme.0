Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51292C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9LtN354uVuUYmVb2mASO8NEBFMkBKelxqOXNVRMI1A=; b=Ds2NGby5k06qfQOKlIylqtUopR
	ZTJwrGC6NvICme7ua7TaIYKp2gSexHNPxG5HibEsH0zn1enFik1CZKUfGuPAwvEnHzwqZ+AlwW5I6
	Wxza+NL6GsccbFzPAAU5r1T7qr3J07z7F5zhubTP46hcL89DEaXXRBRflJENI3N/WgtCBNdhgdGMG
	nkisnUNPwj59ZOwMkKsOL6Umr9v8eQCEOP/VTcpcjDAotztR/uABETnt1WCFH6XXBETu3FJ0cF9uR
	ruU/ObcuA72ADdOoCyaHQf+hMuhkelr5COREtlFY63HMY8t6WxTFrFzX9I227uwLgJiSwtO8ssbb6
	GQn9Ptow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZWGw-00FLKp-3G; Wed, 30 Mar 2022 11:13:54 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZWGt-00FLIE-2m
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 11:13:52 +0000
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-2e5e176e1b6so215260177b3.13
 for <linux-nvme@lists.infradead.org>; Wed, 30 Mar 2022 04:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h9LtN354uVuUYmVb2mASO8NEBFMkBKelxqOXNVRMI1A=;
 b=7yoagTUiN9qZ8m9f86CvgJq4YhKqQm4OaiFsbuqe4/38Hxm6SfQDVhdO6aBOJ1zqv0
 xOd+GRRl4adLJEO27vCnBU7pd7hvEE5XT/09Wp7gUjDb9ZGUvTTGz3c+3ohIPEsZiHMj
 36JbyzWzq2Jfm3ctPBVB8mG5GIE1AIlzJh4hJylgpSYjbQRP4FeCoKrfcstSdAlRRQo4
 c86w0ab2wBLZFOGqbtsOxAFOWCB5S7c0rzPmsD4OBDJ7me1b+7UgexDq4Ae8VLS5mUa8
 pdxgI74KNdLoT8ZHEW7Ev426YATOJu/8+wZmBFG4xh/7NaHIE/y5ktoo/mNY0qZRYFEk
 RsnQ==
X-Gm-Message-State: AOAM530dv2+QEFg4/SU8GfCWR2EmLtiIwhgHS8amSXCKW9PRXq5CgJs1
 0fb35Tw7+nzYQJAnxvoCCihdjvA5RuB34b6ZY1gbmnVx
X-Google-Smtp-Source: ABdhPJz63lQUAbKwHsXnq3i2ewkJOjPWbatjhaAuYA6ElUjLgJFwKEKLZx/MotMNC3w9/8M8yzIvMkWAo1h4DpMfPuc=
X-Received: by 2002:a81:6887:0:b0:2e6:126d:3102 with SMTP id
 d129-20020a816887000000b002e6126d3102mr35867153ywc.7.1648638821666; Wed, 30
 Mar 2022 04:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com>
 <YkO7d7Eel4BVQOy4@kbusch-mbp.dhcp.thefacebook.com>
 <20220330062516.GA24340@wunner.de>
In-Reply-To: <20220330062516.GA24340@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Mar 2022 13:13:30 +0200
Message-ID: <CAJZ5v0jUuv7+j5M7xKhC2BdNdj-t==f56GbSDK_Tfrr7=pMcLQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example
 implementation
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Tanjore Suresh <tansuresh@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_041351_133350_F86CA618 
X-CRM114-Status: GOOD (  19.56  )
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

On Wed, Mar 30, 2022 at 8:25 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Mar 29, 2022 at 08:07:51PM -0600, Keith Busch wrote:
> > Thanks, I agree we should improve shutdown times. I tried a while ago, but
> > lost track to follow up at the time. Here's the reference, fwiw, though it
> > may be out of date :):
> >
> >   http://lists.infradead.org/pipermail/linux-nvme/2014-May/000826.html
> >
> > The above solution is similiar to how probe waits on an async domain.
> > Maybe pci can schedule the async shutdown instead of relying on low-level
> > drivers so that everyone implicitly benefits instead of just nvme? I'll
> > double-check if that's reasonable, but I'll look through this series too.
>
> Using the async API seems much more reasonable than adding new callbacks.
>
> However I'd argue that it shouldn't be necessary to amend any drivers,
> this should all be doable in the driver core:  Basically a device needs
> to wait for its children and device links consumers to shutdown, apart
> from that everything should be able to run asynchronously.

Well, this is done already in the system-wide and hibernation paths.
It should be possible to implement asynchronous shutdown analogously.

