Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A714CE77180
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/3RDmiAbaUTnKLxfa3aWSBTsFl0GkYE1GdgILacxf8=; b=KoDeDmWUoPXgsyWy6jGn6wDoZE
	ETd140VV3R8p6YwBmNuMbfnWe38adprnvuO6gp9nNoCieh+gOjltwhzzc0DI4UU5XV+6WIdIjp/L7
	hPw3JNLBAyfvtbYdEks55kilJpIXGsI+BOVMBEGl4506J/LWbeqYISDS+MFQeapeIvRiWBx6eMXDm
	sJb5RFW+MAewR2HOjXw7M1IdtZTgcBfaWCJFdMF035WFVNi4qqCMNd631kYALYdSTEyiCOcrJQAtR
	MPxL01sVFIlOyVcf0yJFEfDqbWdGvOiei6FSxdlTadhW5tgNumq4ewPfiqJs6mwsMXkBt4O3VuVEy
	dRML+Dnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEu7-0000000Am6d-1WiP;
	Mon, 16 Dec 2024 17:29:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEu5-0000000Am69-0ziH
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 17:29:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A91ACA4194E
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 17:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADF6C4CEDF
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734370148;
	bh=uO4RvUIsNNGHSqvi9NWA9W+sJAdveK70mBR5/s2dV7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QlnvwOofwMc2xXqXM79nNYMvdaL2/aqroltkRgfKLvUN9F7yYdB+NGwyKgk4JZIf7
	 7VaBVkrHNqDQIrMGxyq//QbJjOalGFYk4YEzDg36qwXzqYmifHwLZbRl4Rw+mGwLh9
	 1qXvB9XbtDxmJ1ujr5bqX50qpqVmMOPHuNr+a+UYI8UIKGX7qwuDH6P/su6JCc05hn
	 kLPh5mjprCsDgGh9TxpKuiXhzS5wn38yjkCcm4JhQs+dORvspvWYTaLy3uF1eB4QDH
	 6AWlS6+LbNwTmC/LoKxhu4AuIqoSUCxIzzy+jhOmoOgAHZ9XsxpfFxm/IFE3WVjZXC
	 lg6YlY+5IjAPA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ebadbb14dcso1336540b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 09:29:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl7kp6FK6hZJbM0gqyS58qWvZu1LMjZQUsVAp7NUCJNwidsEB46ztGCVMxf470qgt1eIldOVlH5jRS@lists.infradead.org
X-Gm-Message-State: AOJu0Yw10ZBjblyK94VlV1Ctzl6TTRe1rVZ73L9Wi01h8/Ek+MkTnHBa
	QlU/CQrJvIIp7A3l2+wAmc5CFtz34rI0NZpB+miHwq+6IExcCBAcfO2v1BiCbdIrrOGUXYaogcN
	gqbzSTz7siEV4sUCDpOk6FZGFOBI=
X-Google-Smtp-Source: AGHT+IF3TcMdugshcb0ACvJieCHGeXkqH6Ge96ABjnS17IHSgmIjjh7HLYyc+Hm2VaaAjnQEBPZdSgJ7BTojcSgiNNU=
X-Received: by 2002:a05:6808:189e:b0:3eb:66d7:a33e with SMTP id
 5614622812f47-3eba67f9917mr8762730b6e.5.1734370147442; Mon, 16 Dec 2024
 09:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com> <20241216164830.36lpu6gfnapsdar4@thinkpad>
In-Reply-To: <20241216164830.36lpu6gfnapsdar4@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 18:28:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
Message-ID: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_092909_416947_86302A26 
X-CRM114-Status: GOOD (  21.95  )
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

On Mon, Dec 16, 2024 at 5:48=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > >
> > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote=
:
> > > > We need a PM core API that tells the device drivers when it is safe=
 to powerdown
> > > > the devices. The usecase here is with PCIe based NVMe devices but t=
he problem is
> > > > applicable to other devices as well.
> > >
> > > Maybe I'm misunderstanding things, but I think the important part is
> > > to indicate when a suspend actually MUST put the device into D3.  Bec=
ause
> > > doing that should always be safe, but not always optimal.
> >
> > I'm not aware of any cases when a device must be put into D3cold
> > (which I think is what you mean) during system-wide suspend.
> >
> > Suspend-to-idle on x86 doesn't require this, at least not for
> > correctness.  I don't think any platforms using DT require it either.
> >
>
> On suspend-to-idle, yes D3Cold doesn't make sense,

Why?

> but on suspend-to-ram it is pretty much required.

Well, I know for a fact that on x86 platforms ACPI S3 does not require
putting devices into D3cold in general.

Why is it required for NVMe?

> That applies to DT as well.

Again, why?

