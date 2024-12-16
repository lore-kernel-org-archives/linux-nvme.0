Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3243E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=; b=FxGQzEuDgeI2OqsSR1usr7f57I
	JPZmJiEkU8CYs7p5xVIyfyrgXMtBAGQRUaKzO0Xt/e97OfALxStlJ9o7sAmT4gY+NlkllbYgj6ZzZ
	NMznWWPmitkx3occyp/t6QWOI3xLk4JPEx+Wk5E1fK1iXkZKble1QZrKsGdaBRWL4wWviQh8sxA63
	MtUiN5pFq818yvN+EN9wHsmKNMndl16r2FtgXSC0b2goGIybHmxZYkJEKpJb6Yicq/ske8ZNFLaRb
	JHXKfobRB3d6saWZ9CmuIl+ZgpkYJEfjmy/Rh5dqxqq9JtX8z2LafjTSh74GoUS1UjEYU7QQaOL5H
	fKo5Iy2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF4U-0000000Anh3-1vKz;
	Mon, 16 Dec 2024 17:39:54 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF4S-0000000Angd-1PXd
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 17:39:53 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-21619108a6bso32815905ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734370791; x=1734975591; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=;
        b=NZdsQMK9EnVT96yjVnv4WoA8ofkiLUR8aEwUYCwEGauSAoL2uvyPdGHgWkz8vTx6A9
         tvWEYvvy+mYAxn5h8Vqv/pKS8ykFWgAYdlHRT9WqH9/2mHP/RIOR1y7DPtu0U0RX2jQz
         v44xjKbTHWNOIRwJUKZ+L+e1ZCZK1m5p8ZaLYFXr1ElsVHun47bM1tK2M+GL4R8W1wSS
         qm/+m06cBOhGOtiFwacfkI7Pn8FQbtyyxpWXva7wmDNCIIAhoE6dntF4gKvuj3RY7K9J
         eWqpO3MBAPhraCMYYADJ3TU2nuXS2gdjXvGdN63ltR4E5ZraCS7a4tm5niWEj44K2Wt+
         S/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370791; x=1734975591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=;
        b=J71r2hc540tdhqmfgSg2uWTiXTOMiz9fJpew4KK6sQOMo1lV4OAzJxwZRFftDqGKPU
         XMMlckPkSgc8ZCF2K2SDG1YwA26+42evMY8do+eSwKfq6ctgf8b5mKGdd9ldWBomzr36
         OOgO9J/e53gkKKapWxAEfz0cjPHd1S/cHm/TnTVUI8qyHnFqKaOqZkvKCjvYUrk8f06b
         ActRpsZ+5sjWI4S9gZPDTykqUjdJ5i22iVHwAlt5yQ3nXgDiq+5UMJpev0nJVXoQxKpj
         LW9P7noOvjSaf1PC57gn4wRoQifD9YE9Sf7zM4cE4fc2NuMGCmncEw4eSENCiMLlLetC
         1AoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKlRFpMEF3ZEEprDJ1OLy4VjbKMMGoCVC7Vx61M4bOXmBWmrosiNjlHWgLwiuSa3sf2JnVjm/7Dp8i@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7tbZ3Hc5fVlSH9lbD4ebPObt2GfbMJ87DiZtRtfyzaHrWZsnD
	okKuwM27nIqrrbth2UfNJNhJJLuwxguQ9VzcFRraq4OEGruLh0b/7OECZ/n7cw==
X-Gm-Gg: ASbGncvFw0XWP6b7Pkf4AVyNpK9LcTSnYaJQD5SS8RajF5n2HgwNmZ9kWR9ROeDttTM
	VLA5anFqsgFCwdjoN5cU8MXu29+kIbNYIgXlQ4A2q2ZEWHAsMxJOz5sY3KslTZJ2I4X5L2LsFua
	8nObBkoUdhZ0Enn0CxEE8t67u+nsfqdDjY74vjuNS6Vj0A1/kqwlG6wAC7nwmcrci0I+4QnKOuE
	V8LwadgJD/ACTg9NjW9E/ec4GpWBCX+1aSD9dd7kVb6HeNFFRt6e8X4C7h7LiVJTFNq
X-Google-Smtp-Source: AGHT+IFQcMcDVID0W/UMwjtnX+YPifcFR9pDYG5iFdtJCREYhFobz06S5WtCY8l9lvzCnul9WOa+xQ==
X-Received: by 2002:a17:902:d4ca:b0:215:6b4c:89fa with SMTP id d9443c01a7336-2189298266fmr161242345ad.8.1734370791170;
        Mon, 16 Dec 2024 09:39:51 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5f3f1sm44322435ad.209.2024.12.16.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:39:50 -0800 (PST)
Date: Mon, 16 Dec 2024 23:09:45 +0530
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
Message-ID: <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
References: <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <20241216164830.36lpu6gfnapsdar4@thinkpad>
 <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_093952_395748_A39BA307 
X-CRM114-Status: GOOD (  26.25  )
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

On Mon, Dec 16, 2024 at 06:28:55PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:48 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > > > > We need a PM core API that tells the device drivers when it is safe to powerdown
> > > > > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > > > > applicable to other devices as well.
> > > >
> > > > Maybe I'm misunderstanding things, but I think the important part is
> > > > to indicate when a suspend actually MUST put the device into D3.  Because
> > > > doing that should always be safe, but not always optimal.
> > >
> > > I'm not aware of any cases when a device must be put into D3cold
> > > (which I think is what you mean) during system-wide suspend.
> > >
> > > Suspend-to-idle on x86 doesn't require this, at least not for
> > > correctness.  I don't think any platforms using DT require it either.
> > >
> >
> > On suspend-to-idle, yes D3Cold doesn't make sense,
> 
> Why?
> 

Because there is no requirement to remove power during S2Idle, isn't it?

From Documentation/admin-guide/pm/sleep-states.rst:

'This is a generic, pure software, light-weight variant of system suspend'.

> > but on suspend-to-ram it is pretty much required.
> 
> Well, I know for a fact that on x86 platforms ACPI S3 does not require
> putting devices into D3cold in general.
> 
> Why is it required for NVMe?
> 

But ACPI code currently calls pm_set_suspend_via_firmware() for S3 suspend. And
that causes NVMe to be powered down because of pm_suspend_via_firmware() check.

> > That applies to DT as well.
> 
> Again, why?

On DT systems if firmware supports both S2Idle and S2R, devices can be kept in
low power state during S2Idle and powered down during S2R.

The problem comes if the firmware only supports the former state.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

