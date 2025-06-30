Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DB3C8302F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 22:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F1sYDNShdB+06sCJ84BRO2bPUNIHjiAunARjjFgiGns=; b=YDzz5hEzNy9LwnTlQF1ogg7DW+
	02sdejb6Zou8aEpMbwHXuwrHbtx2AjDp/tHRHae8Vzi9oXslcADQT8cg+lldVxbyj0OTS25chxY0g
	FzjJCEnVBiiSVHK6hIkfBkRezacOGvNnIwvP7fUoltiURGHb8iPuADgRKmSenj1M1zU8bFJpYFrUD
	hLvt0O5eHBfb5Y2Suw0IBypdqaQ8cCPyIWNWY5jx7B9z7DfWlVFlp9ftZQlGINIYeTdDtqGUupH4g
	LNqiNWuMZpvVBFxpBTML8QOgwgiHQRWFEQPifDyNNbwF/1Cc+O0o2KqM1fmqldM+XF9ZEX8zI7XNg
	0U74PkIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWMjn-00000003ZFe-2GYU;
	Mon, 30 Jun 2025 22:12:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWMbD-00000003YWT-1TUG
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 22:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751321016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1sYDNShdB+06sCJ84BRO2bPUNIHjiAunARjjFgiGns=;
	b=AbPQwDaaYi5lZl8DlriBNesZAt6cyvyT4x8wv+Jh4Hp67kAZIRIIpSsQU7OTsa8vwK0uZ5
	k326jS2QtVznC6ptM1dgUnJbD7h74+U+/H2mnsfQ/bzVX0cbl0hNb1lRV3/SYHrEYZV06S
	NrQMjG7RHYlosXybU1aJ+fxgLkjAul4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-V1CJww9XMkqeSuElV-mfGg-1; Mon, 30 Jun 2025 18:02:06 -0400
X-MC-Unique: V1CJww9XMkqeSuElV-mfGg-1
X-Mimecast-MFC-AGG-ID: V1CJww9XMkqeSuElV-mfGg_1751320925
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a43c1e1e6bso106645381cf.3
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 15:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751320925; x=1751925725;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F1sYDNShdB+06sCJ84BRO2bPUNIHjiAunARjjFgiGns=;
        b=w67KOIJRGm8lN9r41m/vJGDofCrKIarQevzhvBeLU/EC++9gYt8cfe7mqhZITQWScw
         bfDWwVjn/Sdy5oY2aMq94jYNp2I/Iu3eNC3ltVMGagxqoRDA/BJXHzqh2SmiWXsbwEEr
         T0ZjzRWcrxAPzrNCnOPr/KQd1Y2FnoqNLli4aXPUKLDphLaDCy8T1BHWzUMwbwwps0/x
         ZqnIIqnehqT1i4hhmSkpWqTqqEhNalPHV+EjdOIqfxx3eVW/bxaeWf3K7Lrswv6hafYY
         /oH2Uz7Z3mMQSYo/sXftMgzWsfX/MEIrR5BqlVVU+76ZQzaOsN0yZLOuqUE6fm/fjnOT
         nZMw==
X-Forwarded-Encrypted: i=1; AJvYcCVku+YFE+/50U4J7nk3RNKc96RHd8EiaOJkVsESXVl5YK+8L2FAnThSXmYnLy5wI6s9iK9c9MTG96tt@lists.infradead.org
X-Gm-Message-State: AOJu0YyjGo+YJt3xTK+jEC/XGA8lCcGt/HC0NITlw1l4rcwBJ/YBxbei
	gG6BPkQxWe2hzF1B6ie+hkF8c1WrLyMa8S3hp0ZuQu3J+wurCSAws8rgxTalakwUvo9dtQp5VcQ
	jAj5P/w+Fs4y/ufno4rc2cDS8miGKB3BF0SGLK45EEOPeAjiPrNuWcxb/28v/SSp1fV4y
X-Gm-Gg: ASbGncsNjzuRn0/Wo/0dP6McbD//F0MNAxjciV177il4BZUCizYkq6xItgaIj50U+WP
	5/O/wIAfqJJ1mUPKxLM9tl9xLZJO+0ytGISaZwcbsG3g1wkK2yADysMCn/Vh0XU+FvNcPWXdimP
	5brd+EZMDtKdUtjVRV6JXV20xJZgjnDjZtdAGgiSUlIoqhAIsAksHNvEG9IAaWlQOLESJz/KGwE
	LetepGvZMXM3hpMj+Iz7Wp8BoPgaBCCNAfzqlzBIphuJlilc/TsOAFI4jlCz7KlZjaSaX80PrWi
	EsO12Knln1/iDBYWCSvuxuv8aH9xvYmI8pjdhw8UluzpCfaGDflOcTLCvE5prTR+UJLT2uDNaex
	uJTb5nHS6Byc4wamb
X-Received: by 2002:a05:622a:1aa3:b0:494:9455:5731 with SMTP id d75a77b69052e-4a7fcd0a50dmr219040281cf.7.1751320925273;
        Mon, 30 Jun 2025 15:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl8Lp0HJdj/5CubO6LymZShiX5YgxAMs0JiwsT/sFHj3mnBG/ZbF1kylGa3wRxDA6ZElp2cQ==
X-Received: by 2002:a05:622a:1aa3:b0:494:9455:5731 with SMTP id d75a77b69052e-4a7fcd0a50dmr219039711cf.7.1751320924728;
        Mon, 30 Jun 2025 15:02:04 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443150adesm672823985a.26.2025.06.30.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:02:03 -0700 (PDT)
Message-ID: <91c3f5cb07df7b6de072e8af90709a803cf52042.camel@redhat.com>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
From: Laurence Oberman <loberman@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>, Oliver O'Halloran
 <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch
 <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, David Jeffery
 <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,  Jens Axboe
 <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>,  "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Jan Kiszka <jan.kiszka@seimens.com>, Bert Karwatzki <spasswolf@web.de>
Date: Mon, 30 Jun 2025 18:02:02 -0400
In-Reply-To: <SN6PR02MB41572B532608AD12685ED678D446A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
	 <SN6PR02MB41572B532608AD12685ED678D446A@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Evolution 3.40.4 (3.40.4-11.el9)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TVQNqqVJWXhYs9qubfMzgKoQZFZAZ2RVUr0q0Ec5tsk_1751320925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_150339_458291_54648321 
X-CRM114-Status: GOOD (  43.13  )
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

On Mon, 2025-06-30 at 20:33 +0000, Michael Kelley wrote:
> From: Stuart Hayes <stuart.w.hayes@gmail.com> Sent: Wednesday, June
> 25, 2025 1:19 PM
> > 
> > This adds the ability for the kernel to shutdown devices
> > asynchronously.
> > 
> > Only devices with drivers that enable it are shut down
> > asynchronously.
> > 
> > This can dramatically reduce system shutdown/reboot time on systems
> > that
> > have multiple devices that take many seconds to shut down (like
> > certain
> > NVMe drives). On one system tested, the shutdown time went from 11
> > minutes
> > without this patch to 55 seconds with the patch.
> 
> I've tested this version and all looks good. I did the same tests
> that I did
> with v9 [1], running in a VM in the Azure cloud. The 2 NVMe devices
> are
> shutdown in parallel, gaining about 110 milliseconds, and there were
> no
> slowdowns as seen in v9. The net gain was ~100 ms.
> 
> I also tested a local Hyper-V VM that does not have any NVMe devices.
> The shutdown timings with and without this patch set are pretty much
> the same, which was not the case with v9.
> 
> I did not repeat the more detailed debugging from v9 as reported
> here [2], since there is no unexpected slowness with v10.
> 
> For the series,
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> 
> [1]
> https://lore.kernel.org/lkml/BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com/
> [2]
> https://lore.kernel.org/lkml/SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> > 
> > Changes from V9:
> > 
> > Address resource and timing issues when spawning a unique async
> > thread
> > for every device during shutdown:
> >   * Make the asynchronous threads able to shut down multiple
> > devices,
> >     instead of spawning a unique thread for every device.
> >   * Modify core kernel async code with a custom wake function so it
> >     doesn't wake up threads waiting to synchronize every time the
> > cookie
> >     changes
> > 
> > Changes from V8:
> > 
> > Deal with shutdown hangs resulting when a parent/supplier device is
> >   later in the devices_kset list than its children/consumers:
> >   * Ignore sync_state_only devlinks for shutdown dependencies
> >   * Ignore shutdown_after for devices that don't want async
> > shutdown
> >   * Add a sanity check to revert to sync shutdown for any device
> > that
> >     would otherwise wait for a child/consumer shutdown that hasn't
> >     already been scheduled
> > 
> > Changes from V7:
> > 
> > Do not expose driver async_shutdown_enable in sysfs.
> > Wrapped a long line.
> > 
> > Changes from V6:
> > 
> > Removed a sysfs attribute that allowed the async device shutdown to
> > be
> > "on" (with driver opt-out), "safe" (driver opt-in), or "off"...
> > what was
> > previously "safe" is now the only behavior, so drivers now only
> > need to
> > have the option to enable or disable async shutdown.
> > 
> > Changes from V5:
> > 
> > Separated into multiple patches to make review easier.
> > Reworked some code to make it more readable
> > Made devices wait for consumers to shut down, not just children
> >   (suggested by David Jeffery)
> > 
> > Changes from V4:
> > 
> > Change code to use cookies for synchronization rather than async
> > domains
> > Allow async shutdown to be disabled via sysfs, and allow driver
> > opt-in or
> >   opt-out of async shutdown (when not disabled), with ability to
> > control
> >   driver opt-in/opt-out via sysfs
> > 
> > Changes from V3:
> > 
> > Bug fix (used "parent" not "dev->parent" in device_shutdown)
> > 
> > Changes from V2:
> > 
> > Removed recursive functions to schedule children to be shutdown
> > before
> >   parents, since existing device_shutdown loop will already do this
> > 
> > Changes from V1:
> > 
> > Rewritten using kernel async code (suggested by Lukas Wunner)
> > 
> > David Jeffery (1):
> >   kernel/async: streamline cookie synchronization
> > 
> > Stuart Hayes (4):
> >   driver core: don't always lock parent in shutdown
> >   driver core: separate function to shutdown one device
> >   driver core: shut down devices asynchronously
> >   nvme-pci: Make driver prefer asynchronous shutdown
> > 
> >  drivers/base/base.h           |   8 ++
> >  drivers/base/core.c           | 210 +++++++++++++++++++++++++++++-
> > ----
> >  drivers/nvme/host/pci.c       |   1 +
> >  include/linux/device/driver.h |   2 +
> >  kernel/async.c                |  42 ++++++-
> >  5 files changed, 236 insertions(+), 27 deletions(-)
> > 
> > --
> > 2.39.3
> > 
> 
> 

For the series:

Against 
Kernel 6.16.0-rc4-dirty on an x86_64

Difference of about 15 seconds to shutdown compared to almost 60
Same set of test I always run and stable and repeatable

Looks good again, although V9 also looked good until Mike Kelley found
his issues.
 
Tested-by: Laurence Oberman <loberman@redhat.com>



