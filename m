Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01CFE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=; b=KfaLGQGqDJDSRdWj8J+7QjgmdT
	+DkFOpH2HAer/VBmf4ehvrtSAj5KY+grye+8PZ19yBWQTQKXG3ii4HRW12jABZTqFFSjDk63GqDG4
	yE4In1w5tTh9jFa+W2zl9btFT6gS61L7KTdwPj6Q+koebTi4n+7Xs/EgJO2V9W5yjNAJLr8wspqIE
	XzptK8XdV9boR7bcs0Q9Rn9B866Uwq9TwYmO8AlimSsSuuYq7FKeWsH75ib5VCV5pBdBO+Ohwvj77
	q4JxLAFdfhVaKd/K38z9zJwNE3Isl2mJ6N7PWyq8IUUrpi6gS5ziMzvxHW8UggotzW4wK7siQIvLc
	/uIA0ZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNQNM-0000000CKXL-3ZFO;
	Tue, 17 Dec 2024 05:44:08 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNQ6S-0000000CHK5-3VVp
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 05:26:42 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21654fdd5daso40239585ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 21:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734413199; x=1735017999; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=;
        b=p8MkaSRCx4jMK34ahg+DNL+T9kH+hfH0VvL/fLwr/F8E8uGUqCLcnhpgDHcMUf+yJ2
         M/bSrJ4PcZULNCVrE9aQAyfAmZd0+1Kr2/e9cOWdNRuxtArz0cfHaonKr5s3fSPI/x2P
         3otD/vgatHMwFYBZOMQGb6YCCYfSC9RLFGFZjhqIi74qV5dUklhkeXjrpWoPNQ/j+E/r
         Xi6CQeTDO01cGliRj39j4M2aWmNtLXZsQtm7LxiDsGvNQ+egEnOV3am/Eoh8wJL27AKs
         fZabFeuSwfa7FHhqC48+1wB8cElrcP/f+gDfk+dwf9kw+8qNJ8eILfnGPHiK8AZUVMlL
         odgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734413199; x=1735017999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXnSoYy/DcLGpfJd7nHDxONKuV/9hhaVZ6r9SGdxcq8=;
        b=wypWhft7xAuoUIA/xHt29gVi6Q77jm0njaITFwIN1VjXfrVX0oEhRS6JrGu5jHW3YJ
         OYCxk25P8/u9ujFcBZqYhH+7yG8mZXR0rWPBzAhV69+w4KzMW1AY1WTl5xAsALug4J7L
         mJtHcf97zyJLLYTbNu1oNv8OaqkEW5VJ+ZMYdjK11lkiwSnYbtozprbdT6ef/LJzrAgH
         hi+5r9taR/7vgMryxb4W9nP6xODFA0xJtly2Dh0sy1/pSiC8hti4kA/TAKJWtFazsG3G
         EIiZML1dquYlOT4n8TUPteWU4TmEQsOLYrfqPy9Mhl6dhfkjiLo8C5aHNCUKpiIXNffq
         Lwkg==
X-Forwarded-Encrypted: i=1; AJvYcCWfcPkT41AUjRqDS6FBj9KM0HWnX819CZA32xWA+7R/9917S1hMQMVRg1uDoAx7F+6PgCfjXKjJfogF@lists.infradead.org
X-Gm-Message-State: AOJu0YzW6ttq326R/PJGNrpQNJMgfaJr2VaECTtob1CO1EMEkdJ3MHhc
	JuEoYqUJ8/K3Sw4fQIUUYkw5PgXrHALfQXcruNHOoJqUpZW2zk5fhB14az1vmQ==
X-Gm-Gg: ASbGncscpiF0mLl5FFBfe1lyTEQYapdwr7qG9e/u0nwPAzNcnF3EgoUZZ8TvaGfX7Hk
	tJD6V9hXFo/DIGlDd+2DdOTaYCr1VsPp/aXry/xJhJxQUsqTlEp//JGvlQMV4+7YwSfx9BjoosD
	1j3bNUbrJ4j2+VSp0tiJ+qdByWqY+Dvp2lpXs+QQbpxT+81eSkRkFOn7btF2lzM9hbjlvxEsGdG
	0UIhvLVKpgJYmG5DX/JcqVtf0SRWKGIWQHoNtUtFe6NtZebKcBiMYE5Hm0uVHbTOnLF
X-Google-Smtp-Source: AGHT+IFsS3IZ2kuJoYYT9J6yaDIHOOQEb5x9/0WrwBJTXWku1ZLygnZo3QdYaoEU12xrzijDxxrz1Q==
X-Received: by 2002:a17:902:c952:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-21892a785b7mr178520425ad.51.1734413199463;
        Mon, 16 Dec 2024 21:26:39 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc305dsm9094176a91.52.2024.12.16.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 21:26:38 -0800 (PST)
From: manivannan.sadhasivam@linaro.org
X-Google-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, `@thinkpad
Date: Tue, 17 Dec 2024 10:56:32 +0530
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
Message-ID: <20241217052632.lbncjto5xibdkc4c@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_212640_919572_3EB22092 
X-CRM114-Status: GOOD (  51.54  )
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

On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:

[...]

> > There is also a case where some devices like
> > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to be
> > powered down in order for the SoC to reach its low power state (CX power
> > collapse in Qcom terms). If not, the SoC would continue to draw more power
> > leading to battery draining quickly. This platform is supported in upstream and
> > we keep the PCIe interconnect voted during suspend as the NVMe driver is
> > expecting the device to retain its state during resume. Because of this
> > requirement, this platform is not reaching SoC level low power state with
> > upstream kernel.
> 
> OK, now all of this makes sense and that's why you really want NVMe
> devices to end up in some form of PCI D3 in suspend-to-idle.
> 
> Would D3hot be sufficient for this platform or does it need to be
> D3cold?  If the latter, what exactly is the method by which they are
> put into D3cold?
> 

D3Cold is what preferred. Earlier the controller driver used to transition the
device into D3Cold by sending PME_Turn_Off, turning off refclk, regulators
etc... Now we have a new framework called 'pwrctrl' that handles the
clock/regulators supplied to the device. So both controller and pwrctrl drivers
need to work in a tandem to put the device into D3Cold.

Once the PCIe client driver (NVMe in this case) powers down the device, then
controller/pwrctrl drivers will check the PCIe device state and transition the
device into D3Cold. This is a TODO btw.

But right now there is no generic D3Cold handling available for DT platforms. I
am hoping to fix that too once this NVMe issue is handled.

> > > > > > If the platform is using DT, then there is no entity setting
> > > > > > pm_set_suspend_via_firmware().
> > > > >
> > > > > That's true and so the assumption is that in this case the handling of
> > > > > all devices will always be the same regardless of which flavor of
> > > > > system suspend is chosen by user space.
> > > > >
> > > >
> > > > Right and that's why the above concern is raised.
> > >
> > > And it is still unclear to me what the problem with it is.
> > >
> > > What exactly can go wrong?
> > >
> > > > > > So NVMe will be kept in low power state all the
> > > > > > time (still draining the battery).
> > > > >
> > > > > So what would be the problem with powering it down unconditionally?
> > > > >
> > > >
> > > > I'm not sure how would you do that (by checking dev_of_node()?). Even so, it
> > > > will wear out the NVMe devices if used in Android tablets etc...
> > >
> > > I understand the wear-out concern.
> > >
> > > Is there anything else?
> > >
> >
> > No, that's the only concern.
> 
> OK
> 
> I think we're getting to the bottom of the issue.
> 
> First off, there really is no requirement to avoid putting PCI devices
> into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> platforms, PCIe devices are put into D3(hot or cold) during
> suspend-to-idle and I don't see why this should be any different on
> platforms from any other vendors.
> 
> The NVMe driver is an exception and it avoids D3(hot or cold) during
> suspend-to-idle because of problems with some hardware or platforms.
> It might in principle allow devices to go into D3(hot or cold) during
> suspend-to-idle, so long as it knows that this is going to work.
> 

Slight correction here.

NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
state on its own, not all the time. It has some checks [1] in the suspend path
and if the platform/device passes one of the checks, it will power down the
device.

DT platforms doesn't pass any of the checks, so the NVMe driver always manages
the power state on its own. Unfortunately, the resultant power saving is not
enough, so the vendors (Laptop/Automotive) using DT want NVMe to be powered down
all the time. This is the first problem we are trying to solve.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c#n3448

> However, there is an additional concern that putting an NVMe device
> into D3cold every time during system suspend on Android might cause it
> to wear out more quickly.
> 

Right, this is the second problem.

> Is there anything else?

We also need to consider the fact that the firmware in some platforms doesn't
support S2R. So we cannot take a decision based on S2I/S2R alone.

I think there are atleast a couple of ways to solve above mentioned problems:

1. Go extra mile, take account of all issues/limitations mentioned above and
come up with an API. This API will provide a sane default suspend behavior to
drivers (fixing first problem) and will also allow changing the behavior
dynamically (to fix the second problem where kernel cannot distinguish Android
vs other OS).

2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use of the
existing behavior in the NVMe driver. This would only solve the first problem
though. But would be a good start.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

