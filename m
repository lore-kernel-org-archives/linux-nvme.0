Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6495BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUWJiAdYBjZ8HLz3oqciBqeoHxb85E3/8hDab3DlNpU=; b=y3zpe7KMcTH5oWcU2Aj/wlWmwk
	unrtfOnIlA+yyvSfPqSeoed8ml9vM0Nmiupirh0whcP74jvUlmIXb1SL30/SJOOS44GsHAa52Yhbx
	fOi9WJSxzScFj+pSg4j09G4FVUH8Nsv4k5EWPaEN2ruQxsAx8St7u74ZpIyocJKxBH/A5nn21UTKm
	l2zJp9iZeevET/UYBYfGGvGRczR9tA3J/W/IuDTDflaNHjQgwZzhcBiRvseVOe7Eu9qakQzKWoSvi
	wOc0DBbfKep/+ocay2M3aThU1ZcV5ONoFsfMs3oIrbrVS4wWlgPKY/jhg8ijZ0mIJgaO7EIp80BJU
	JkKuPPDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDAei-00GxiB-Jj; Thu, 27 Jan 2022 19:42:04 +0000
Received: from mail-yb1-f169.google.com ([209.85.219.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDAef-00GxhI-95
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 19:42:02 +0000
Received: by mail-yb1-f169.google.com with SMTP id r65so11815023ybc.11
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 11:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tUWJiAdYBjZ8HLz3oqciBqeoHxb85E3/8hDab3DlNpU=;
 b=EmDvhvoKS1FSp3Ru8Er46ZegMtPJCstSDXIJ1Fyf5f3XFr21QI3k4hG01n0xR7Eb7C
 z//VVMUYQvyiWcriekrp42pR42Kxu+yPQtUnWHE++0pLJUEnLsO//zwWrS7tL5w7Fef+
 WW2QtxbLqDKI92DK9WuFY0VzUauiIEjZsMdXbipaFzm0DpWvX4VcqJuamTJV79BCXVrc
 M5jrRuj1U0c7wRoHyLT7vb3fB+Z+qCkmqrfgPCUGVXzflarO6Fp1sYsosADx9v66xr2k
 P+M7wkCxt9pO4WJ0s/Mxx2wkhsB7VFkSO77WnL98jX8v+0aAuNSSyQcJedSFVZroBixc
 do5w==
X-Gm-Message-State: AOAM533SgIQ9ExBmOz6miM5VElMIdha9OSrdqamShVTsNkfjCGfJtKGx
 kQybYpclEbLD7/YljEbQQMuoR0XuV3N8Xn5BTQ0=
X-Google-Smtp-Source: ABdhPJzAhU7n3ZgYoHOfkBD/LcfHwCSoimS44ijemNODiKTXOullNscJyRSESbLShxWNqlBc8/CGkCUJ7F7JQJ0coWg=
X-Received: by 2002:a25:2fca:: with SMTP id v193mr7835374ybv.475.1643312518985; 
 Thu, 27 Jan 2022 11:41:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220127193000.GC2266713@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220127193000.GC2266713@dhcp-10-100-145-180.wdc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jan 2022 20:41:47 +0100
Message-ID: <CAJZ5v0jYGjcSjvASLvTG_vtGZWac7pmK73C0W3YBDN8io25Hkg@mail.gmail.com>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
To: Keith Busch <kbusch@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, 
 Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_114201_348368_91AC18AF 
X-CRM114-Status: GOOD (  34.10  )
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

On Thu, Jan 27, 2022 at 8:30 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jan 27, 2022 at 08:02:07PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 21, 2022 at 10:09 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> > > > Hi Keith,
> > > >
> > > > It is reported that the following commit
> > > >
> > > > commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> > > > Author: Keith Busch <kbusch@kernel.org>
> > > > Date:   Tue Jul 27 09:40:44 2021 -0700
> > > >
> > > >    nvme-pci: disable hmb on idle suspend
> > > >
> > > >    An idle suspend may or may not disable host memory access from devices
> > > >    placed in low power mode. Either way, it should always be safe to
> > > >    disable the host memory buffer prior to entering the low power mode, and
> > > >    this should also always be faster than a full device shutdown.
> > > >
> > > >    Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > >    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > >    Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > >
> > > > is the source of a serious power regression occurring since 5.15
> > > > (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> > > >
> > > > After this commit, the SoC on the affected system cannot enter
> > > > C-states deeper than PC2 while suspended to idle which basically
> > > > defeats the purpose of suspending.
> > > >
> > > > What may be happening is that nvme_disable_prepare_reset() that is not
> > > > called any more in the ndev->nr_host_mem_descs case somehow causes the
> > > > LTR of the device to change to "no requirement" which allows deeper
> > > > C-states to be entered.
> > > >
> > > > Can you have a look at this, please?
> > >
> > > I thought platforms that wanted full device shutdown  behaviour would
> > > always set acpi_storage_d3. Is that not happening here?
> >
> > Evidently, it isn't.
> >
> > Also that flag is about putting the device into D3, which need not be
> > necessary as long as the LTR is set to "don't care".
>
> The only NVMe spec guidance for a driver to initiate a controller
> shutdown is to prepare for D3 transition. If this platform wants a full
> device shutdown without D3, then I think we may need a quirk.
>
> We did a shutdown before because we didn't know any better and it's the
> safeset thing to do. That caused complaints for excessive resume
> latency, so now we have a platform indicator to tell us if we should,
> and we rely on that. Are you suggesting we instead consult the PCIe LTR
> in addition to ACPI storage properties?

Possibly.

The point is that there is a regression on this particular system
caused by the above change.  It needs to be dealt with this way or
another.  Doing an additional LTR check may be the way to go, but it
needs to be verified.

