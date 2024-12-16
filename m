Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D1AE77183
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24uKmyZVWF8evhYqYWPMA24bfYzbIub4ravNwBFgH4M=; b=wHajTi4gUU06WfUT80RdGF/Cs0
	0Zl2RKfAJTJ/Ms37oiea7Far/a6ZxZiEltPU31ecGoZ9EBOHAseF291ziez+bmiLLN/QMXHzy7nbg
	CHlhxX4z/L1hsGLJDnY/zgrHmM3vwM+MXEh2GuQyjwgbtMxFnGAMsq5dh2PL74qdsAWge692+tcX/
	uXj/My6V06xf14yFxb+El1lFlPh8QJQ+SEQQqg6kDnEOcs1+AqODrexBK0NW8jj/0HewrNYaL69FC
	b+7W9dzPffRuzkAGaRlpFdopNnSueUa1eFpMGwsmKfQxDvNE8hekxeEHshtm/tDhqUzboFkrGdNTL
	beGrBDvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFIx-0000000Aq7s-1BiN;
	Mon, 16 Dec 2024 17:54:51 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEB9-0000000Adax-1fr9
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 16:42:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C4EA3A4188E
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 16:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C7C4CEDE
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367362;
	bh=/YZL8BCWUrGgnBHMRhMJrndei+MItSBCpjXPuhiodx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ltJu+eJeR3GVPWDizkM77lXgowRdcSjeVfd5GPbD227yBIXxqu2EAYCE39iRRdUt4
	 SpSB9VFKQcfVlXU/V/oMfWNazpYQ7e81rSLUbIHctVeIagYKBNKrky7f9MAa8LC0Oj
	 tTOQmJ7ZryVejBv6bhG8HJPeR2a9aNgpznsVCAE9z8VxSvQUsiPhdJWc/dIzYx/hxr
	 0CEHhhkbIyhImMh6SMZC3KuRVYxq82JmoJKdhvOujrJ9I1QM3nFxkrgaN+6A/9W3bS
	 Jjzi5snzhCdVCbQZpKNfo9bDa7gV72cCFX5paBnp5fFA3gCKc1tHsTVr1Lu+DFm3VZ
	 N+3FE7AcN9hHw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ebb1652729so1454898b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 08:42:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz2039H9eP5UjvaBsjBy+gK7W792exzYOb8vK0CW/Y8FMjKgF2lRUbR30PKnUJoAB9YmBf2M9qU6uj@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8DQ05/TAk+TatswV7phtq5PYHXaY2Oe+/IFqlRFct7hQP6D5F
	+DemXxuvfq77JmJqowd4Dna7EqZ/Q6LS7ehsTD5opAuPPT5aZ3E+dOGI6syB2UkjTCh6PHaY5OR
	jnQGs3ws/bzAw4pWtPHsdBVNOVe8=
X-Google-Smtp-Source: AGHT+IHnMZjbo2UVibBmoMUnEzobdQTlLjR1cy109pM5/JrqwIVhmYAJg7QJ9Vp9yf3MkZqDb3PPIJV5mlF0UqPv0JE=
X-Received: by 2002:a05:6808:1887:b0:3eb:556e:dde6 with SMTP id
 5614622812f47-3eba6867bb5mr6716314b6e.12.1734367361510; Mon, 16 Dec 2024
 08:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
In-Reply-To: <20241216162303.GA26434@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 17:42:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Message-ID: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Christoph Hellwig <hch@lst.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_084243_580762_9D5EFDFE 
X-CRM114-Status: GOOD (  16.84  )
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

On Mon, Dec 16, 2024 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > We need a PM core API that tells the device drivers when it is safe to =
powerdown
> > the devices. The usecase here is with PCIe based NVMe devices but the p=
roblem is
> > applicable to other devices as well.
>
> Maybe I'm misunderstanding things, but I think the important part is
> to indicate when a suspend actually MUST put the device into D3.  Because
> doing that should always be safe, but not always optimal.

I'm not aware of any cases when a device must be put into D3cold
(which I think is what you mean) during system-wide suspend.

Suspend-to-idle on x86 doesn't require this, at least not for
correctness.  I don't think any platforms using DT require it either.

In theory, ACPI S3 or hibernation may request that, but I've never
seen it happen in practice.

Suspend-to-idle on x86 may want devices to end up in specific power
states in order to be able to switch the entire platform into a deep
energy-saving mode, but that's never been D3cold so far.

