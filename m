Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88402E77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPKil53zJMQTuGu7JP6g+ZjxO5tZnTK+oPeNDzMy0CM=; b=vNRcu2lm4Uo0pxfnE4oml+30Dw
	O6LI4XNzVzcdKy6QYS9IMukHb1Nj2g6PDmBqq8kojeViwgy/KN8mFdrgCL9/zziRqiZKCDWryhdFZ
	taCGvZdr9Yc+tdi0ImTS4fpJMA4NafrDoJgqORfZ72Xg1mqqM7+2VglL2dS5o2TMyqAnWKZa19BXP
	1sh8AQhv2jDVR7h1ym7m6YLIX7Ur0bAY/4xBlPSFkZfgoUFJYlCsO837+mioHSX8ox4WGlnDtn8to
	y5zK21g4MHI0NWRDRVn7Sne58wZJKhqPFdo0mGkh9F4ZFcFmsvqGOtb8zReEmlWFP/eLR8xuq0mAT
	QolkmCsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKezZ-00000008FKj-2ocC;
	Mon, 09 Dec 2024 14:44:09 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKez0-00000008F8p-0T9X
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 14:43:35 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-725aa5c597cso3253574b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733755413; x=1734360213; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cPKil53zJMQTuGu7JP6g+ZjxO5tZnTK+oPeNDzMy0CM=;
        b=Stq+MI9OeZEGcRmbrA7ybPpYkHY+wPCf1QFXI6I4DUVClsuXpQnVD69qWoUC3YaW+c
         aFQ2VK1ymgHD236SicyjXCwVUKF9BELAhy2hDltnBWMcgZGDalonO497JkKk4k+D3q/x
         IV8/okihigA/ueD1XGOnkZvJpnAfgdtB/KcgzWxylhOWoEtB3qglIGxNAS2yBuC+pzEk
         X9Off5EwNZR13BpNYL84S8s1vpwlqC2rJkXmLLZx3uEtTBdJwThygmpgbRVRMFgNRVbm
         lt9SHQ1mqWMvwHee9Ch5euxXGGxAihYp/c+M8VCsVwnKYX9m/oFH2PoEIrFa8lP3DWHG
         KqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755413; x=1734360213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPKil53zJMQTuGu7JP6g+ZjxO5tZnTK+oPeNDzMy0CM=;
        b=Ijf2a6Nk9tMLdJFGlAYV8ut9GLkVRxb+CFppsyYWPpgvxtZt0QjLbF1LlXJWRyKFa3
         /yRNj/T4aCNZMC29s3FKaPkpfft1Vx+R+AZmU6bV3zWiINaHzENz3HatxP15CVfREgvk
         +l6Y6X1KMtLx8jchCbjHYBUOCoq4+z9ubqWJPy+tNCEQqiEF8yxv/mN2CYQb0LpVJlHw
         5qHZvSOIR1eUrpLoef6CsH6OpI55F7H/akGdSotq97xZFeWF1IqPqp+RtI9PbJuh3ZRR
         HK5Ivivp7K+Qo1m27odGViJbBZnXAJe5zXdtBMaLdfsp1XN0puf7ZN0YhEQjVuhmj2Ck
         py3g==
X-Forwarded-Encrypted: i=1; AJvYcCVY3zT1+8XCIJBnmTVfHzQuvXCasYjqQNoSWksFWoN3fDMJRNcbjL1p3yKP3X79P101cmqpxjAfI7JG@lists.infradead.org
X-Gm-Message-State: AOJu0YyPMIojdkrHS0yexCqEr3/q01FokIdqGe2JlJDyFm9aYHrRrI6I
	LSUa1jV7UgBEBnFKv8hucaUWxG96vy6GOE1ce677CvBPZI63EHHry3/ulwsF5w==
X-Gm-Gg: ASbGncuI0Hybpdcy/LGnyuEPqg2fbEpgFxnSf9u8hQB1UUq6QTnx6O6t9C8XEiFLDfo
	3qumdvOrzlgxXREAeQe2+XIv/XxL16yUvd5EuQYgDqdaaBA5KU+FLI9wxV35Feingy4+MnUe0zG
	kk11/5je3PJhzCgs0MzAYOnqi9Uy5Bj57UcVf9RcHe/+b6DI94OiUyJWS5ZIAjCzN+mLcXJ/n1Y
	i03fuxZM9lEzpZFXFoclRW3VDqXIngsAuRlDR1G9GW+fi+AHQkrQ7Fmtuzr
X-Google-Smtp-Source: AGHT+IFhDJY8qBSudpuC5SW1dvlmPLuMBxgm32mHRvomRt0QePig1p1TQxqzGAM1xjiCsccNrl5yhw==
X-Received: by 2002:a05:6a00:1990:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-7273cb1adb0mr934437b3a.13.1733755413078;
        Mon, 09 Dec 2024 06:43:33 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7260adb61acsm1233305b3a.94.2024.12.09.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:43:32 -0800 (PST)
Date: Mon, 9 Dec 2024 20:13:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209144314.ow2qgrhiwr23qw6g@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241206014934.GA3081609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206014934.GA3081609@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_064334_169385_0C4655A0 
X-CRM114-Status: GOOD (  24.92  )
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

On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 05, 2024 at 05:29:00PM -0600, Bjorn Helgaas wrote:
> > On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > > PCI core allows users to configure the D3Cold state for each PCI
> > > > > device through the sysfs attribute
> > > > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > > > allow/disallow the PCI devices to enter D3Cold during system
> > > > > suspend.
> > ...
> 
> > > We did attempt to solve this problem in multiple ways, but the
> > > lesson learned was, kernel cannot decide the power mode without help
> > > from userspace. That's the reason I wanted to make use of this
> > > 'd3cold_allowed' sysfs attribute to allow userspace to override the
> > > D3Cold if it wants based on platform requirement.
> > 
> > It seems sub-optimal that this only works how you want if the user
> > intervenes.
> 
> Oops, I think I got this part backwards.  The patch uses PCI PM if
> d3cold_allowed is set, and it's set by default, so it does what you
> need for the Qualcomm platform *without* user intervention.
> 
> But I guess using the flag allows users in other situations to force
> use of NVMe power management by clearing d3cold_allowed via sysfs.
> Does that mean some unspecified other platforms might only work
> correctly with that user intervention?

The 'unspecified platforms' would be Android devices making use of NVMe, which
is not a reality now but a possibility in the future. But even when it happens,
it won't be a problem for Android as it has userspace knobs to control the power
state of the storage devices (as like how it controls UFS power states today).

UFS Reference:

'/sys/bus/platform/devices/*.ufs/spm_lvl' documented in:
Documentation/ABI/testing/sysfs-driver-ufs

- Mani

-- 
மணிவண்ணன் சதாசிவம்

