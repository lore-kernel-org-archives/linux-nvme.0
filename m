Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3AFE7716A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlgMCaOaC31D3cOsxfoNKxD9p5p+eSeVRC9kaoau9Mk=; b=WfcPEUrPpuyefO8ydHU2u87gR7
	ZEKK4GeEVhHsSVx7dAXm5Nx6b6nFDmYFwmeDuq5vOFGbiswG84KzQEGpZ2m+RBip2ut2UufB8tcrt
	K1d6H1/UG4iAxMHoCLCU64ucWM+8EZ6L9s6eG7FL5Zda0LtKe80rjqjSKNQDuzEAhy4xOHY4Av4N6
	jaYVRYzuf6iOJP4l10cY+MNw8Oyfr9RAO3Bf5IhydsyodFIMF+1LXyRxqPVkLEudPVSDDzQG1LGm4
	OB6jlpM983IJhNR57KcOJ0ZXT2y+qYn+Rgn+D1MFf2RPTF1StaY0X570vrkGfAYTAv7C7Hf/Q7GBN
	vtcM74Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLgU-00000005q53-32Dn;
	Sat, 14 Dec 2024 06:31:26 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLfc-00000005pxe-2gFf
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 06:30:34 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2074451b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2024 22:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734157830; x=1734762630; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZlgMCaOaC31D3cOsxfoNKxD9p5p+eSeVRC9kaoau9Mk=;
        b=L7mWMjwEIMfqyfPZQ8F3OqcVN0mijjaEK1nI1MFwixpyIt3BZv2dhSCAA1xf/HNiVb
         8wu8Hk/fFXQnd2Xzl+vfhM4C+Std5bC5m0gqEG+Tgl7okChl7hNFS0CERkj9FOhfwmVu
         31v2EAc1XLDgNn27yJXxuZalZoR0GX3T+6uV3J3Eoc/3RCDStjKsjmvRkSOBNHcP/QRU
         JOPbASaj4dr2+T2Rx+0TsBHNGGzSg1FrGI+HISODeepKkzhrh2mrs7bJV9KZoszZBX+V
         ndQdXJSww9h4sZObSiwJsvKgQhJJJkGu2rhOztXlmbj5UxGllN8y/uG+Phw3XHQIrp3n
         Bqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734157830; x=1734762630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgMCaOaC31D3cOsxfoNKxD9p5p+eSeVRC9kaoau9Mk=;
        b=HOyjChqfBUPdcwuVWXBRg1kPFJLRh9TF1Ql1hb9uWG/+jtFPEWyqKVxj63QlSoZM82
         oA47nOttpkXkfX5F3aBtuP5GbS2hrSCNAvtgxMnIQC6nnR7UgtrAVbjPSSsNdiSx2U/8
         +JVNagN/zaJjZmRZDZhhLXJIgKOpWCDDaD64qKbIPj27snljQol7NkoYokeHpbgC75g9
         OkVH30AOBxCbmR+hPiOw1v76AOghHSMj68LR8qFBJ0x2dProVG5bJNwW7zjiSmPlF7FN
         7kquitpBJcQhpklybzVbhu7fDHBiRUAO3JMeauL40EB/ClqYP3BUf7ofSK7Pkerwvua8
         nhBw==
X-Forwarded-Encrypted: i=1; AJvYcCWZh63IOvmOxZFzt7lTeiL2vL7EtSYen5vX3uArHQAXTKtwcoVb20jc+vl6IMAHWvv4N7B9W4idU2sF@lists.infradead.org
X-Gm-Message-State: AOJu0YzDunSUrPQDyarpRDNo3P0M0gcaLzy9LYeTgNuW7DD0l74h/Vu1
	H9c/hmOnXazuxnoBCyX9Zm+r2rL/A41scoW63KaovlkLOLRYLMhlXgnpLX+UiQ==
X-Gm-Gg: ASbGnctyRkX9OlqqU8AR1qdM5Y+1KZXLYFNhR+KmBB7aSl25KVqC13NmKXE3fvfF8AK
	gu8LT65Q2c/noVp88v4I2neMPRJYsFEzWbGncZY5RfwwUh0GddrOWtjxOgKR4xfmJoCHOX+Ad6d
	M1erClSRjqd2rzrOGQPctM9B+GrjUgTNnZ0rxLzorJihf1lFc/jM2FrDTHoZdnfkfNXGNG2K6IO
	eqfvuIrj/w6/R0ts8A45RtoqgTNrBxZfehwZ0j9Ti9coiZgJLcqsM4mUNH3SBX1+rjg
X-Google-Smtp-Source: AGHT+IF1qZdiCv20zyVSp63JMQBIBSxSIe0ltCHbfrxCz8Ri2Bw6xNnbLmKF0vNlQnSnOzeS4RTRJQ==
X-Received: by 2002:a05:6a00:2e89:b0:724:d758:f35 with SMTP id d2e1a72fcca58-7290c0def31mr7842131b3a.2.1734157830253;
        Fri, 13 Dec 2024 22:30:30 -0800 (PST)
Received: from thinkpad ([120.56.200.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcdf56sm805168b3a.182.2024.12.13.22.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 22:30:29 -0800 (PST)
Date: Sat, 14 Dec 2024 12:00:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_223032_695709_066D0E0D 
X-CRM114-Status: GOOD (  36.61  )
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

On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 12, 2024 at 4:14 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > Right. This seems to somewhat work for ACPI types of systems, because
> > > ACPI is controlling the low power state for all the devices. Based on
> > > the requested system wide low power state, ACPI can then decide to
> > > call pm_set_suspend_via_firmware() or not.
> > >
> > > Still there is a problem with this for ACPI too.
> > >
> > > How does ACPI know whether it's actually a good idea to keep the NVMe
> > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > > only for S2R and S2disk!?)? Especially when my laptop only supports
> > > s2idle and that's what I will use when I close the lid. In this way,
> > > the NMVe storage will certainly contribute to draining the battery,
> > > especially when I won't be using my laptop for a couple of days.
> > >
> > > In my opinion, we need a better approach that is both flexible and
> > > that dynamically adjusts based upon the use case.
> >
> > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > but I don't really know enough about the PM core to drive it
> > (as the reply from Rafael to my mail makes pretty clear :))
> 
> I'm here to help.
> 
> Let me know what exactly you want to achieve and we'll see how to make it work.

I'll try to summarize the requirement here since I started this thread:

Problem statement
=================

We need a PM core API that tells the device drivers when it is safe to powerdown
the devices. The usecase here is with PCIe based NVMe devices but the problem is
applicable to other devices as well.

Drivers are relying on couple of options now:

1. If pm_suspend_via_firmware() returns true, then drivers will shutdown the
device assuming that the firmware is going to handle the suspend. But this API
is currently used only by ACPI. Even there, ACPI relies on S2R being supported
by the platform and it sets pm_set_suspend_via_firmware() only when the suspend
is S2R. But if the platform doesn't support S2R (current case of most of the
Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe won't be
powered down draining the battery.

If the platform is using DT, then there is no entity setting
pm_set_suspend_via_firmware(). So NVMe will be kept in low power state all the
time (still draining the battery). There were attempts to set this flag from
PSCI [1], but there were objections on setting this flag when PSCI_SUSPEND is
not supported by the platform (again, the case with Qcom SoCs). Even if this
approach succeeds, then there are concerns that if the platform is used in an
OS like Android where the S2Idle cycle is far more high, NVMe will wear out
very quickly. So this is where the forthcoming API need to "dynamically adjusts
based upon the use case" as quoted by Ulf in his previous reply. One way to
achieve would be by giving the flexibility to the userspace to choose the
suspend state (if platform has options to select). UFS does something similar
with 'spm_lvl' [2] sysfs attribute that I believe Android userspace itself makes
use of.

2. Making use of pm_suspend_target_state to differentiate between suspend states
and powering down the devices only during PM_SUSPEND_MEM (S2R). But this also
suffers from the same issue as mentioned above (when platform doesn't support
S2R).

TLDR: We need a PM core API that that sets a sane default suspend state for the
platform and also allows dynamically changing/overriding the state (by taking
inputs from userspace etc...). This API should also forbid override, if the
platform has limitations (like if it requires powering down the devices all the
time (x13s laptops)). Finally, this API would be used by the device drivers to
decide when to safely power down the devices during suspend.

@Ulf/others: Please chime in if you don't agree with anything I said above.

- Mani

[1] https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-driver-ufs#n1041

-- 
மணிவண்ணன் சதாசிவம்

