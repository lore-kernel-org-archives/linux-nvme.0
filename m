Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38273C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 17:23:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E35613BE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 17:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E35613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+IQ3vB6F1QDxTysrSE5azagCu221Qi1TGCZjwY4hLiA=; b=BsRMdAoGyOD7mw
	KikODGdP7R4hVc5TX1iZ8OvP+j24Htb5oyVdM3i49MiDh5+hPjdw6vo/hdLwoVxlcBiq+QpT3U+ya
	oCZEgRh8Dcp5zTldxMXG4aXGg8+ViGSrdTN/FvOHxGyTWAqSCRlSIfBKqu+OBz9ymUCLR/hMOjYIb
	NIJa/XO+pnlKGT7y6PhEf5YPCH0/maJXC4E5qjFzGx2UrVymZ+h8dK8semShxkYvlThqB8cSD8Klq
	PEMj6wlZC1famICvWSLmMceovUzs/WK2izYc23t5W9bE6X4O8n5vFkDfuF1JEVxijXaqc+28xRkuG
	LVO0EltK/ZhYXrqjOVIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmJj6-0083GU-BI; Thu, 27 May 2021 17:23:20 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmIJp-007NWz-Jo
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 15:53:11 +0000
Received: by mail-pf1-x432.google.com with SMTP id d78so887012pfd.10
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vTL0iStvAEdfVZeMvcmTz3ZRT93Zop98hYj5vXzf2CU=;
 b=XQrnyA5FvV57NNVVPyWFG7nmTNHQdFjxfOoT8yhlzZvLv68q+8z/2bWxEhFwSoxUx/
 fvEsWXC3IcKiClKm5nX1rFH+EmEEncXX/PY0LabaelazdhJsHMC+Cl7WLLkPXE8dtwSL
 Ar3o8/3Zf7s94Ts7p5qDfvoQbGYR1loNJtDPNxmqqO3ZSS7GP5vgjbsjTbpGNYGT47pF
 fPIz2wW0g+V1FHtXLaRjt5FmvHzzWxKTMjHGL7s01gUk77MXKKOy/5CX/mCrcxLzDrvp
 ed0d7FAKyr76w6ZjT67mtoqq2WeZObu7oTXpxno45TQi5teI44jwYa2EfkScB0DmGsio
 BzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vTL0iStvAEdfVZeMvcmTz3ZRT93Zop98hYj5vXzf2CU=;
 b=dck3aXty78JEB+EBjTO7Iu/5L/ZJny2EkmN6tKo58cURCFNQlOtGnELI4gnXSgEvCT
 XqRThZgufKpUtXEc4QiV+DlXcmTzIO7ml2l6BXjl0cUBULyg0avlW7c6N7e4sNH9HwoJ
 OYeR5ZNsChb/aMNujZWE7sEx4pvtkvbtzSUcyfe+47np8O8Zkerb+RTteR2CS5AOq54n
 u6OtObG898VFQf9sKZyAcQJlHi8gZsJNoV+khP4bPfcd74BQPmM8xy/iGP7F1HZc3tWJ
 HGi9veBPwQVzQLWYN5v66teOdGGBe8H9S5UEKfjcnaiorrR5L1bwPybB2rGYE1tnVo8y
 aXag==
X-Gm-Message-State: AOAM531FiZ4PGCEk/HMQvsmHKLX0ABIuxxnyYcMa9VZribJIlNDZqkgG
 Mak3lfZv2n308Iom496Y5HN7bSzIQdpCZlCkCbwd+ENCTzpI
X-Google-Smtp-Source: ABdhPJyqvbTU1B6lJZOH6ChNCAfe7VTuGLEe5r1kCIOx+aN1P3N/QktbzFzsxDh2lz8fKIzQlKicOLFj1bTy0zbdnOg=
X-Received: by 2002:a05:6102:2244:: with SMTP id
 e4mr3137199vsb.43.1622130775132; 
 Thu, 27 May 2021 08:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210527135941.7634-1-mario.limonciello@amd.com>
 <20210527143548.GA32170@lst.de> <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
In-Reply-To: <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 27 May 2021 10:52:43 -0500
Message-ID: <CAErSpo5za0x1fXm18YNzdNRFdaucVs=9Hhh2kqRS_baWos5Vgg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, 
 rrangel@chromium.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_085309_702996_3F572397 
X-CRM114-Status: GOOD (  23.62  )
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

On Thu, May 27, 2021 at 9:44 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
> On 5/27/2021 09:35, Christoph Hellwig wrote:
> > Adding Raul who has been asking for something like this as well.
>
> > I'd also really like to move nvme_acpi_storage_d3 out of the NVMe
> > driver.  The Microsoft document that the original document references
> > makes it very clear that this is not NVMe specific, but also covers
> > at least AHCI.  On top of that the platform simply can't know what kind
> > of PCIe device is in any given slot.  Last but not least this will also
> > allow us to add quirks for devices that fail to properly mark this
> > misfeature in the ACPI tables.
>
> +Bjorn
>
> Back when this feature was first submitted, that was actually the
> initial way that it was done, but Bjorn had preferred to see it move
> into the NVME driver directly:
>
> https://lore.kernel.org/linux-nvme/20200625173053.GA2694537@bjorn-Precision-5520/
>
> Bjorn, are you OK with this coming "back" to PCI based on Christoph's
> comments?

My point was that the PCI core can do nothing with this information,
so it doesn't seem like putting it in PCI doesn't really gain
anything.  The Microsoft document you reference ([1]) doesn't mention
PCI or PCIe.  As far as I know, there's no PCI spec that mentions
"StorageD3Enable".

I agree that [1] doesn't seem to be NVMe-specific, since it also
mentions SATA, so it might make sense to look for "StorageD3Enable"
somewhere other than the NVMe driver.  I'm just not convinced the PCI
core is the best place.  I have the impression that it's possible to
have non-PCI SATA or AHCI devices (correct me if I'm wrong), and
"StorageD3Enable" could apply to them as well.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
