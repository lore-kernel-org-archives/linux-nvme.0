Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA114C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9KxxV9NPaarLjUn6WnSeaJ1unQjijG7pUlU5QRc31c=; b=1sYd5xWS091QljlTpeOU9JGcEE
	bHVaCBaQESptVn2+/Wn/lbuhZ07JlXMTO43+ApxovZZt/eDU6LZfMyDj8TCoR5nAcRPL+tr0EPcY2
	FybzdbV7yis4ZXVJDvPdd7guHMDhQmPx7aSe/75rgoVkGe2GW3cXZI4pN6tCkQ3hxfsrOeRXFDwJ4
	r5oPL8B8G5hcBWeMFKpwuGnR9ubyAsQcjfbszvQCRqEihumJQawO+wcF1ospZmhPBjDboTx87XOU/
	t8bEcbCzEYyKL5ob5xNynqjlux7aJAoERI0MbDyYOMNhp0p+19B97fNmdeEII9Ewd7pnoQqcbWiZ/
	xj+8Iobg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1notTY-008eQf-C6; Wed, 11 May 2022 21:02:28 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1notTU-008eNE-UN
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 21:02:26 +0000
Received: by mail-io1-xd2f.google.com with SMTP id e3so3358121ios.6
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t9KxxV9NPaarLjUn6WnSeaJ1unQjijG7pUlU5QRc31c=;
 b=H+FMOTettN+fuJtHKZqvo9EElI2NN1SPK4306s/OFHXEpdYb2w8lMqMB9SYcHYzNYK
 fPb27VOOqwfpDDqp5639NElcCyMRqOxbTyvlNIvswSaV2AJihPzGq1xo3mRDRoBbdY9Z
 ieamvJCGxKnz7laf6bu3Els3to1eswUjqz7BPVzm8ZEFjlu+mFmArNAeeZ61qgI+39xf
 jp6z/bpGJfGdnhddB5JrTTHjNlonTnbTOU1XAcwGupZCq+QMV5rdjheyamVoOumzLFj6
 uChw2lg4VDkyw1fMCaQlWP3tiyel2InlZRfoUFjbHjqsH2+sUFi5PugWTKBosWZmIjeT
 dhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t9KxxV9NPaarLjUn6WnSeaJ1unQjijG7pUlU5QRc31c=;
 b=mos8U5D3My7E+RgVhJEaf5uNaQxEOWzMZRHa9IDK+5lJg/8wd1xxpRpL1t5MGhc5/h
 hWwwEmzoY9vyJaFmiajgEajd1AaNtyWD976FkYeJuX2j5KM9QogHosrwDZxjRcMSXnFq
 UsmlVRTgoyyZBGbXDWmcG4bD2dkM5rVTxomQ3mUdS90kVhaPq1uOACsSqA4zNt525c2p
 JAV8NHeqxnN4oSjMn183NhaB/syjxoukG8enLoQTyhLhUTliz3jCxqBZr8cD6R8IoTrQ
 XguuxGDLLY7fx9AIP38E8M2q5+DtbY9K+Cg2Yc0YTPNDIEXCotbbmr0KXfpfW/U+nK0Z
 6G/Q==
X-Gm-Message-State: AOAM5326V1Ue5gJG/FYfFkrC+3aYaPghtXQnQblBT+T/qjBhbd5f2cp9
 CdMsh+sRfkwBZueaXR3Uts5KIGXqiKXEryWJsoCCUg==
X-Google-Smtp-Source: ABdhPJwmnOOxYv5I7CBMV+/A8hb0Ch9gPYppkXgsf55Nobqofhk/HsYU3WHgCMZG16BXcmY0HTddv62MCMTE6GPSIAQ=
X-Received: by 2002:a05:6638:34a2:b0:32b:7d4f:8932 with SMTP id
 t34-20020a05663834a200b0032b7d4f8932mr13504775jal.317.1652302939471; Wed, 11
 May 2022 14:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
 <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
 <YmzqrqfVLQ9/4KXp@kroah.com>
 <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
In-Reply-To: <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
From: Tanjore Suresh <tansuresh@google.com>
Date: Wed, 11 May 2022 14:02:08 -0700
Message-ID: <CALVARr71u8VD0+zaWbm=6A-1_6gO=bYUm7OM4K5b6kOVz09XOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_140225_025598_90CA16FA 
X-CRM114-Status: GOOD (  37.15  )
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

Greg

On Mon, May 2, 2022 at 12:13 PM Tanjore Suresh <tansuresh@google.com> wrote:
>
> On Sat, Apr 30, 2022 at 12:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > A: No.
> > Q: Should I include quotations after my reply?
> >
> > http://daringfireball.net/2007/07/on_top
> >
> > On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> > > Rafael,
> > >
> > > That is a good observation, however, many of the use cases in data
> > > centers (deployment of devices in data centers) do not exploit device
> > > power management. Therefore, I'm not sure that is the right way to
> > > design this.
> >
> > Yes it is, enable device power management and use that interface please.
> > Devices in data centers should of course be doing the same thing as
> > everyone else, as it actually saves real money in power costs.  To not
> > do so is very odd.
> >
>
> I guess we are intermixing the  terminology of device power management
> with shutdown.
> My second, third reasoning in my previous e-mail, thought it brings
> out that difference. Maybe not.
> I will try one more time, my thought process on this one.
>
> This patch is only for shutdown. The shutdown can be done in a system
> in various flavors,
> (this may include a power being pulled from the system components when
> all the devices
> are quiescent and it can also be soft shutdown, where power is not
> removed from the system, but system
> could be attempting a reboot)
>
> The device power management allows the device to bring down any
> devices that may be idle to various power states that
> device may support in a selective manner & based on the transition
> allowed by the device. Such a transition initiated by
> the system can be achieved using the 'dpm' interface for runtime power
> management (more for extending laptop battery life).
> It can also be exploited for system sleep models (suspend and resume -
> where state is preserved and restarted from where it left off
> --> More applicable for laptops/desktops). That does not mean data
> center devices cannot exploit, but they worry about slight latency
> variation in any
> I/O initiated to any device. Such power management could introduce
> more latency when it transitions from one state to another.
> Therefore, the use case is more apt for Laptops, in certain cases
> desktops in my opinion or understanding.
>
> The shutdown entry point has been traditionally different and the
> semantics is that the whole system is going down to a
> quiescent state and power may be pulled or may not be, IMO, i am
> seeing both are independent requirements, in my view.
> Let me know if I am mistaken. I am not sure why we should break the
> shutdown semantics as understood by driver developers and
> overload it with dpm requirements?
>

I have not seen additional comments, I request your help
in moving this further, please. If i have missed something,
Please let me know.

Thanks
sureshtk



> Thanks
> sureshtk
>
>
> > thanks,
> >
> > greg k-h

