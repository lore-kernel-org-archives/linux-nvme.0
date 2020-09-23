Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A20C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:32:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35B420791
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DTlk5BHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35B420791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5DBboy+KkCtXUE2OwvJoEDW/62AyJRob2B6H+buFCc0=; b=DTlk5BHa2cH8JQo6twze/ji4Z
	QpZ3S5rrM+xQElEN2G0+i7y1ebf30ZdzrjOn2v+k3+/lqqneo+rrNWkJ4iw3Frj7b8P6qIsZLjWzq
	86D2TsU98+60Io/dpD4V0gBvjjHzdhJaq3Xt2C3aGGLsxC4e5pjXVuntdUqAYPUjyJZgxxgK9dMe+
	yeAsIn9nTIQkwfZdKzZ0qZCuSQ/3I3vAmt7H/lVu3zct8BPwsUp99BGYRa08tFpISv3YDml8M/hcC
	AetQQ6cMQry+O+dWu4jpVUoffF6M0FY8peKGr7NtZ5SSIuSpyjsCONiDjO0RQehmrwUw/Xm4lOe29
	Nl0OJk8IA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL7gl-0005eh-7X; Wed, 23 Sep 2020 16:32:15 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL7ga-0005bK-GU
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 16:32:06 +0000
Received: from mail-pg1-f199.google.com ([209.85.215.199])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1kL7gX-0007RG-6G
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 16:32:01 +0000
Received: by mail-pg1-f199.google.com with SMTP id c3so382496pgj.5
 for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2020 09:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=1vu3RVWfaicSDRQ+g0gtPLuzJ9RQhK+defWMWWVa92E=;
 b=HmKyMQSOFrryPxEPPQv7C1bixvzMIDU0iQmnGMPETcWEcqHj0tKawWV+4+PMg/dQ/J
 HymtYajUWub8ld0yDZU762of73P7x4scq6MuITMYV777yoA87QtMaBm2+Po66OFXWpbk
 LMgPWy6ZSUgsPZuvvFuf0skmyPMTffsTSo239cz9Y+ZTBD31Si2JTD5D7eliG960sHjC
 +5jwbC7GokdiiPf1oSG0lSHjXSqHE1/oRIDWJ6sRyOkuqu8lsaseRk3kEoTMJFCSsYRq
 QcVT0U80QFf9g5wyDMt15GqTr/Ps9PMIl3+amhG0i9IzBVMvlE/muuh8/fTi1r6sUNXJ
 bsNg==
X-Gm-Message-State: AOAM530Nim+hu8h/aLD5CBx5SucCDk/jH06emGRXLm77XZOYJZpeig8Q
 ZqtcxKT7wpYgp/0k0o/1C4Qsgv+OOZah0fwFuRhONv3EL/znRV+azwwklTq0cQ82RjxULhnq+Ar
 UAml0p/3gI9IEQHJjRZODyV03AtilesOjZNeEf4EvqVVK
X-Received: by 2002:a63:d242:: with SMTP id t2mr494084pgi.47.1600878719602;
 Wed, 23 Sep 2020 09:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1x8FfYg8hrB4ZdorxoPEkweMi6AgmxrmxRWXUYcoDPMEIweTW2plxS2GzleY2EMpMxY5P7w==
X-Received: by 2002:a63:d242:: with SMTP id t2mr494053pgi.47.1600878719204;
 Wed, 23 Sep 2020 09:31:59 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id x3sm367548pgg.54.2020.09.23.09.31.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Sep 2020 09:31:58 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200923160327.GA2267374@bjorn-Precision-5520>
Date: Thu, 24 Sep 2020 00:31:53 +0800
Message-Id: <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_123204_666389_A9037C96 
X-CRM114-Status: GOOD (  26.97  )
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
Cc: Joerg Roedel <jroedel@suse.de>, "Jechlitschek,
 Christoph" <christoph.jechlitschek@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Keith Busch <kbusch@kernel.org>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[+Cc Christoph]

> On Sep 24, 2020, at 00:03, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> [+cc IOMMU and NVMe folks]
> 
> Sorry, I forgot to forward this to linux-pci when it was first
> reported.
> 
> Apparently this happens with v5.9-rc3, and may be related to
> 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> which appeared in v5.8-rc3.
> 
> There are several dmesg logs and proposed patches in the bugzilla, but
> no analysis yet of what the problem is.  From the first dmesg
> attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):

AFAIK Intel is working on it internally.
Comet Lake probably needs ACS quirk like older generation chips.

> 
>  [   50.434945] PM: suspend entry (deep)
>  [   50.802086] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x11e0f)
>  [   50.842775] ACPI: Preparing to enter system sleep state S3
>  [   50.858922] ACPI: Waking up from system sleep state S3
>  [   50.883622] nvme 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
>  [   50.947352] nvme 0000:01:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x11e0f)
>  [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
>  [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
>  [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
>  [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
>  [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
>  [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
>  [   50.947843] nvme nvme0: frozen state error detected, reset controller
> 
> I suspect the nvme "can't change power state" and restore config space
> errors are a consequence of the DPC event.  If DPC disables the link,
> the device is inaccessible.
> 
> I don't know what caused the ACS Violation.  The AER TLP Header Log
> might have a clue, but unfortunately we didn't print it.
> 
> Tangent:
> 
>  The fact that we didn't print the AER TLP Header log looks like
>  a bug in itself.  PCIe r5.0, sec 6.2.7, table 6-5, says many
>  errors, including ACS Violation, should log the TLP header.  But
>  aer_get_device_error_info() only reads the log for error bits in
>  AER_LOG_TLP_MASKS, which doesn't include PCI_ERR_UNC_ACSV.
> 
>  I don't think there's a "TLP Header Log Valid" bit, and it's ugly to
>  have to update AER_LOG_TLP_MASKS if new errors are added.  I think
>  maybe we should always print the header log.

I can attach TLP Header if there's a patch...

Kai-Heng

> 
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Fri, 04 Sep 2020 14:31:20 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 209149] New: "iommu/vt-d: Enable PCI ACS for platform opt in
> 	hint" makes NVMe config space not accessible after S3
> Message-ID: <bug-209149-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209149
> 
>            Bug ID: 209149
>           Summary: "iommu/vt-d: Enable PCI ACS for platform opt in hint"
>                    makes NVMe config space not accessible after S3
>           Product: Drivers
>           Version: 2.5
>    Kernel Version: mainline
>          Hardware: All
>                OS: Linux
>              Tree: Mainline
>            Status: NEW
>          Severity: normal
>          Priority: P1
>         Component: PCI
>          Assignee: drivers_pci@kernel-bugs.osdl.org
>          Reporter: kai.heng.feng@canonical.com
>        Regression: No
> 
> Here's the error:
> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01
> source:0x0000
> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error
> detected
> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected
> (Non-Fatal), type=Transaction Layer, (Receiver ID)
> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error
> status/mask=00200000/00010000
> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> [   50.947843] nvme nvme0: frozen state error detected, reset controller
> 
> -- 
> You are receiving this mail because:
> You are watching the assignee of the bug.
> 
> ----- End forwarded message -----


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
