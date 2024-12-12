Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4B8E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tg5VEq0yJ8noM0Og8YOsf3K6V8JDa3K56E8NocgrDRc=; b=NaJJqnEHOCPH1VZ+SLdH4K5K4o
	JPxtWBilsgOTm74xs7kvbGdCc33lN6lBvnFRHKaaak4dX/cI6jhLUzvxvHbr2kZ1lxa48BXzkuzzz
	3CICPTioULj+dK4ZT8lO12XSiylz6HYkpX5DlDDKAJr2qlbLE4uasVugWJPTuVDk5s30a78LtARCr
	snGr3r9AfXF8wTcdb1XQ7aqdGhizD0Nmrb0ENmjiOedy4bD7qla8YGlYXbw0Lxnc4pADWubvPhGc8
	MiCKblIZ3puc2yhSe+OA5O4ECiKykIxGQ5sKnh8NSnJZysmO0Opnmc8bcKO6DjQ6aJu0aj6fij9Au
	3WLBbUbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLidh-00000000POn-2zWE;
	Thu, 12 Dec 2024 12:49:57 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLide-00000000PNH-1x9r
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 12:49:56 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-aa67ac42819so88780566b.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Dec 2024 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734007793; x=1734612593; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tg5VEq0yJ8noM0Og8YOsf3K6V8JDa3K56E8NocgrDRc=;
        b=E3n9llxE6HmTq5TmeTrF21KuZT0wU9jlVvsLJnT/Dcb9zqGbuUQsDDxgfSemJXQLoJ
         tO3jqQoSf3Gbyv9ZQMKqYQeDGZWd5oDTrlbU3twtzuVOi6DQvFzFP0lW+5/XJIWdSJ4B
         kd2940v4qkEFfSkB2DtM3jqswqpqZ1Dw0EgpkDRXOT7kdnylQ6VIHdcbw9Evqc0vLVbR
         dzIGaojTwHjhukh1W+fOnzFXyRFFibj5mDmlrc4vFjxOHxYZOH1Y0gVPyqTMcGs8F2jh
         pqaNAH6W1Am9lRv7aqlKcM9gNwuWrKp1hQZPqETNVKJSFRkZFr90R5YuEoI8Dd/yRHR4
         X+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007793; x=1734612593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg5VEq0yJ8noM0Og8YOsf3K6V8JDa3K56E8NocgrDRc=;
        b=qwt9qfqJhSSELChMNcm6xc+MFMWjYtt9oP04qQLiDSZPVQsNyTNOrPtcGxCjLwkNzd
         LqeS/muSzm5kEjKdeAlS2uYHG4sUMnBv3DCZTNrQ38RBeSm4lzEW7+Y6PF1h4WDWh6UM
         SiezphKLnXFXHBU4kAbKRZ0UleBxk+jeQpkuE/aTRDZ7loRN0C9GW0CB4QT2SWzDqIea
         Z9NvlHkfo8YLolpRX8if0IjuR26KpklVHzmItJyV3bGIDp7j30huX2yl9g53dkvqF7/K
         fmjtOuwrJrbZuf5YxhmXJ+OKlrfSwVJD0/vbPdZSg1RmjWt4il0vaGjBjlCKqvLaC9Jd
         hW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk6Ev+yz5dEuynNuOFV7rf9rz7yDWufU4tD5f0+fBoyCtOAIgFj76DalXeQyfUIp/r+kkUZfpCMq8m@lists.infradead.org
X-Gm-Message-State: AOJu0YzZEaK5aqA5p4KFVqcVP6u2kwXtWWLENem4TxUcYQ7wqBjzgHyI
	RmnN+DtUx0c0f0AvJk0oGqp8oBE4yGrndLPAtxKlXwxhgRm/DuDAwFLR2vuOz1s5ABYXFWmHAPA
	FQFmU/FtjZvZBviaxMCDFaBKkN/ziyoRs0h1f0g==
X-Gm-Gg: ASbGnctZDYjDiA5UEou7vZMm0cB+9NY2eUPXoNEDv5J+61v9vQ9bdJVTcgi13ro7AVW
	eICb4JZC63qDTMTGcFgqzjgi/aIMI+XZzmrNnLno=
X-Google-Smtp-Source: AGHT+IGwU3vguTJLME4CwvjxCfurx+pt+saRHptWT2f3PF1VRg0uuyI2iBZN4cjqfO6jUQFDXqhpb7d7eeduiQeZgU0=
X-Received: by 2002:a17:907:90d5:b0:aa6:8781:9909 with SMTP id
 a640c23a62f3a-aa6c1b1cdbbmr336950166b.29.1734007792898; Thu, 12 Dec 2024
 04:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13662231.uLZWGnKmhe@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Dec 2024 13:49:15 +0100
Message-ID: <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Christoph Hellwig <hch@lst.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_044954_513448_538D06D9 
X-CRM114-Status: GOOD (  22.54  )
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

On Thu, 12 Dec 2024 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, December 12, 2024 6:59:20 AM CET Christoph Hellwig wrote:
> > On Mon, Dec 09, 2024 at 08:08:21PM +0530, Manivannan Sadhasivam wrote:
> > > >
> > > > The istory here is the the NVMe internal power states are significantly
> > > > better for the SSDs.  It avoid shutting down the SSD frequently, which
> > > > creates a lot of extra erase cycles and reduces life time.  It also
> > > > prevents the SSD from performing maintainance operations while the host
> > > > system is idle, which is the perfect time for them.  But the idea of
> > > > putting all periphals into D3 is gaining a lot of ground because it
> > > > makes the platform vendors life a lot simpler at the cost of others.
> > >
> > > No, I disagree with the last comment. When the system goes to low power mode
> > > (like S2R/hibernate), it *does* makes a lot of sense to put the devices into
> > > D3Cold to save power.
> >
> > Yes.  That's what the pm_suspend_via_firmware call in nvme_suspend is
> > supposed to catch.
>
> pm_suspend_via_firmware() is to distinguish different flavors of system
> suspend.

Right. This seems to somewhat work for ACPI types of systems, because
ACPI is controlling the low power state for all the devices. Based on
the requested system wide low power state, ACPI can then decide to
call pm_set_suspend_via_firmware() or not.

Still there is a problem with this for ACPI too.

How does ACPI know whether it's actually a good idea to keep the NVMe
storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
only for S2R and S2disk!?)? Especially when my laptop only supports
s2idle and that's what I will use when I close the lid. In this way,
the NMVe storage will certainly contribute to draining the battery,
especially when I won't be using my laptop for a couple of days.

In my opinion, we need a better approach that is both flexible and
that dynamically adjusts based upon the use case.

[...]

Kind regards
Uffe

