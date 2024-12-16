Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B211E77180
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KESVQtKZqZa3Yfy4tilcv/lLnaFc43UVwOF5TEnaANw=; b=YZNgNoKB4yHfl9TAL+rAuPWqsC
	SLE0plUsA0SxiWzw79Lr+0wXgjvKDLR3DY+I4qd7GSYfPwQ8inYnDgxF720dlgTpvw+JUfJH6AsS1
	RPAMmS9FQtYyNMkcUxdDW65QsKSJAbB3ikpr/556V0tq8A34ZB2hW7mMN5V1MERHiU2wNPkRcN+Id
	Aa6xOUkCo67sF1AIylkvn6GN6yqT+lbxpkyQlWEmmUR6b7CtMSdIaOQPh3aQ/Wo5TK8rI7KZbHPFN
	8qktUrvOQ5sVjPYYdftZHyXlGe07cvKwmVBDG4I9k/LeK8AdEXbQhMEkfn0sUoWvzb/JxOWJfmjeW
	WN1IDOzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEd3-0000000AjAu-0tbl;
	Mon, 16 Dec 2024 17:11:33 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEcl-0000000Aj8i-3GNF
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 17:11:17 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21628b3fe7dso33870595ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734369074; x=1734973874; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KESVQtKZqZa3Yfy4tilcv/lLnaFc43UVwOF5TEnaANw=;
        b=hCfNK2YwxB+xao0bRydfQz8hCBdbSINBgFZz/sdJWgOwom12aGtEPvXgdUvOeF75cv
         MNA+WXN8GXyykCI8F5JpMIgtUrv5KBQeb24x8jdd5kq6KtUPnz7Ms/FArRXVfMhGVycI
         je8qZsHRzG81Y2lPO0fuSk+BnS3arQdzXI1ebfNfkhqK5MinEoJSqIUJGVXna/LAk0hH
         +KHXQVZ9PJBvE+SVW6KXmYGPfbxS7zsvjc6CXnS6sVX5fgZBY6tkEOOp1KTgJrbiCXby
         kNZ8l32CRChcx+hkCSKtqrpN1tNkozBMBMShupF9bw4NKDzunca4VptjqqqeKAUlSSk1
         g7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369074; x=1734973874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KESVQtKZqZa3Yfy4tilcv/lLnaFc43UVwOF5TEnaANw=;
        b=nsFQe0CfvSbXhdkr82fDBuy6t5+44PN+SrzVhV5P4KJFlDzNrfVlykxwUfXgA/H5hq
         m2qEDTIEK6y/MVgpIwVVizlFeUV36Si42bp7hffrWbfXKUeAFcFT3Vd6Dv6cAOFeSA0K
         39nf+6T+/lI24jJYUL6jnkeNE2q7fNOwHEq4jI1G7vRI5NWN2FgnLc/0L3/V+QygK/mk
         Y8Sg2MwKY9bPjT83GO/z3c6KuM/l8aAYLzZY8CUw2oDJDsMQ7O57AVVETdK9l12nSSOd
         fAlapaOH65jPghX/lGFSfdTicNd5PWBWtAv0VB661V+EHddHKnBmpbZA15qmu7YbIhr3
         j4fA==
X-Forwarded-Encrypted: i=1; AJvYcCUtjuaybWNUTv69bK50V/jOynr/8ouqntichbZN/n17wEnAxioGKUJWqcywGLDm/WZJ0bQQGPlZp7T0@lists.infradead.org
X-Gm-Message-State: AOJu0YyoQrrWvu1Mm24I2Y70NDmF1yKjbDAbEKOL6GX8iS9yKt2yTigg
	qwzmYmZbDS8+QEfDFAnhA68U2v0ETnAnTU9RErMseOcJUX9o6VeWF3CLwM6I9g==
X-Gm-Gg: ASbGnctmUpiG1eszKPIRt9RbTulq6LNcQgjHHEUkbebW1D6XBWbJOtZDsY0glzMUjLk
	4rzX6wotpITN/vShzzMjomnCrePgnu+PD2DyxkFKbnUaIHz9BLO/IZjPdomqSvWyZtA6VKRsk1R
	mYdkhbko5pf6j3MDE/DdKkIGDZC9Y7TCt9kEC+Sws+N3hal5CitaysEaSnlXlUuPuD7RqwYTPc9
	dSvW/w4qkjWWSrCIE5O6v8wXmBUdai2LrBCMo81ek3T5HcUSqgtHweoFv0ngO1SEgv5
X-Google-Smtp-Source: AGHT+IGuw2osrWwyy8PDxgoa5NFmZ8dgBrl4BEXKTy6du57U+4dL9QoOD0UuDYSbH38/mphybyPo2Q==
X-Received: by 2002:a17:903:32cf:b0:215:54a1:8584 with SMTP id d9443c01a7336-218929c3970mr177479665ad.17.1734369074480;
        Mon, 16 Dec 2024 09:11:14 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50aadsm45034765ad.156.2024.12.16.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:11:14 -0800 (PST)
Date: Mon, 16 Dec 2024 22:41:08 +0530
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
Message-ID: <20241216171108.6ssulem3276rkycb@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_091115_840534_9DAFCF42 
X-CRM114-Status: GOOD (  61.53  )
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

On Mon, Dec 16, 2024 at 05:24:40PM +0100, Rafael J. Wysocki wrote:
> On Sat, Dec 14, 2024 at 7:30 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 12, 2024 at 4:14 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > > Right. This seems to somewhat work for ACPI types of systems, because
> > > > > ACPI is controlling the low power state for all the devices. Based on
> > > > > the requested system wide low power state, ACPI can then decide to
> > > > > call pm_set_suspend_via_firmware() or not.
> > > > >
> > > > > Still there is a problem with this for ACPI too.
> > > > >
> > > > > How does ACPI know whether it's actually a good idea to keep the NVMe
> > > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > > > > only for S2R and S2disk!?)? Especially when my laptop only supports
> > > > > s2idle and that's what I will use when I close the lid. In this way,
> > > > > the NMVe storage will certainly contribute to draining the battery,
> > > > > especially when I won't be using my laptop for a couple of days.
> > > > >
> > > > > In my opinion, we need a better approach that is both flexible and
> > > > > that dynamically adjusts based upon the use case.
> > > >
> > > > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > > > but I don't really know enough about the PM core to drive it
> > > > (as the reply from Rafael to my mail makes pretty clear :))
> > >
> > > I'm here to help.
> > >
> > > Let me know what exactly you want to achieve and we'll see how to make it work.
> >
> > I'll try to summarize the requirement here since I started this thread:
> >
> > Problem statement
> > =================
> >
> > We need a PM core API that tells the device drivers when it is safe to powerdown
> > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > applicable to other devices as well.
> >
> > Drivers are relying on couple of options now:
> >
> > 1. If pm_suspend_via_firmware() returns true, then drivers will shutdown the
> > device assuming that the firmware is going to handle the suspend. But this API
> > is currently used only by ACPI. Even there, ACPI relies on S2R being supported
> > by the platform and it sets pm_set_suspend_via_firmware() only when the suspend
> > is S2R. But if the platform doesn't support S2R (current case of most of the
> > Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe won't be
> > powered down draining the battery.
> 
> So my question here would be why is it not powered down always during
> system-wide suspend?
> 
> Why exactly is it necessary to distinguish one case from the other
> (assuming that we are talking about system-wide suspend only)?
> 

To support Android like usecase with firmware that only supports
suspend-to-idle (Qcom platforms). This usecase is not applicable right now, but
one can't just rule out the possibility in the near future.

And the problem is that we need to support both Android and non-Android systems
with same firmware :/

> There are drivers that use pm_suspend_via_firmware() to check whether
> or not something special needs to be done to the device because if
> "false" is returned, the platform firmware is not going to remove
> power from it.
> 
> However, you seem to be talking about the opposite, so doing something
> special to the device if "true" is returned.  I'm not sure why this is
> necessary.
> 

Because, since 'false' is returned, drivers like NVMe are assuming that the
platform won't remove power on all DT systems and they just keep the devices in
low power state (not powering them down). But why would I want my NVMe in DT
based laptop to be always powered in system suspend?

> > If the platform is using DT, then there is no entity setting
> > pm_set_suspend_via_firmware().
> 
> That's true and so the assumption is that in this case the handling of
> all devices will always be the same regardless of which flavor of
> system suspend is chosen by user space.
> 

Right and that's why the above concern is raised.

> > So NVMe will be kept in low power state all the
> > time (still draining the battery).
> 
> So what would be the problem with powering it down unconditionally?
> 

I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
will wear out the NVMe devices if used in Android tablets etc...

> > There were attempts to set this flag from
> > PSCI [1], but there were objections on setting this flag when PSCI_SUSPEND is
> > not supported by the platform (again, the case with Qcom SoCs). Even if this
> > approach succeeds, then there are concerns that if the platform is used in an
> > OS like Android where the S2Idle cycle is far more high, NVMe will wear out
> > very quickly.
> 
> I see.
> 
> > So this is where the forthcoming API need to "dynamically adjusts
> > based upon the use case" as quoted by Ulf in his previous reply. One way to
> > achieve would be by giving the flexibility to the userspace to choose the
> > suspend state (if platform has options to select). UFS does something similar
> > with 'spm_lvl' [2] sysfs attribute that I believe Android userspace itself makes
> > use of.
> 
> Before we're talking about APIs, let's talk about the desired behavior.
> 
> It looks like there are cases in which you'd want to turn the device
> off completely (say put it into D3cold in the PCI terminology) and
> there are cases in which you'd want it to stay in a somewhat-powered
> low-power state.
> 
> It is unclear to me what they are at this point.
> 

I hope that my above explanation clarifies. Here is the short version of the
suspend requirement across platforms:

1. D3Cold (power down) - Laptops/Automotive
2. D3hot (low power) - Android Tablets

FWIW, I did receive feedback from people asking to just ignore the Android
usecase and always power down the devices for DT platforms. But I happen to
disagree with them. Let me know if I was wrong and I should not worry about
Android usecase as it is for the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

