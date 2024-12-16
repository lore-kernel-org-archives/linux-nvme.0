Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA17E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLCUG42w9Rd2j2ctr/dQMjIHxW6uq1VaCrTcAGQt3vQ=; b=TH7JTM5RkVUbJuNHIAJfcHn0Nk
	8YVhA6nTH2TEH1nMq+yfDstprm8e1FPwMXwj1SZBur88YEDfyhzXa6KHnzVkBAtWTXzfG36TSvtbW
	LEQHnwfQHrchHYSGdBCdy1ZBtalXoR4lC4E1GskmWWy0plxlCirwlC6DH7njribI1UsGTB5QluvJv
	z8QIGEVWwQqhqFkW6Vk1vdAyU7n/pHVm/pwFxiQJljEvfd1j2nMw0sveidrm7xGzPRCF6EIPAo1Kw
	hGwfqwmkaW8AMUive6lujIxfdqHZMguEVN2yhU9A7VdajUXGLmlbhzYbttaypudKAbBZj9Pv8oZxV
	6AgLab2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNH0E-0000000B9O9-1Vfm;
	Mon, 16 Dec 2024 19:43:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNH0C-0000000B9Nk-26q9
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 19:43:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA3475C64FA
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 19:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C8C4CEDE
	for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734378215;
	bh=bLCUG42w9Rd2j2ctr/dQMjIHxW6uq1VaCrTcAGQt3vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R0Rs4OZkNJFFbVLkxGZkocsVxkqWzRWQUbF7JQOf7Ia5kzkKZIBNEyWgaYt0laS02
	 v6bniI96SOM8buGJQCOS6vEEsLRfDFYfBKQmQoOIpSJGsjEgO6zjMQj7tVbZYfXGND
	 gED7MAQU1bO1u8uSKJi2VEnV/U9unIpshjn5CHXmHnBB7iIZkB3wIqpgsDuRxb3Xn1
	 ktzzVZV20cTNjbxORcBPdnepF+e3UT5CP6Yv0UGUh6oIPYbwdOwOcRl3gKHjOsGk8k
	 GtDA9dkjnif9DXvhiaics/9Xy9KfVGCJxvRT8DRvppRDkvpMEp6s8cQgdR48iGT7OD
	 aJG2KRR6r1DLQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb9bbcc936so2404281b6e.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 11:43:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgMLW1LTHE2p3UDOQ5PWDgCqvS42qcB5m7j3+wH6Uvrv3+9NkuxlfAv4h2rCxIK360nvsJ5CGq2YEQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yyp51fXYSRj+jvUc7JeS+KH3CriSQPj+R/ycu+p6cVWM7/AQxBn
	Kysz+I1VXEz9HWrEn30sU0zI3Nh8BIvgaHijhW9UpSRJuTTt+0sz4m3tpBRT1AXwKfVbf4ohYDA
	ycAat0+bsyvccnvHoJ+5Ef+c1ULk=
X-Google-Smtp-Source: AGHT+IHBIkkg9ryeWoXUjvDA+eOStEt8YeUf9CRTqn6A5LAOHY0mQEKE5h0I8dvOns0NI/pgRtXFEf2n3JxCdyuWQY4=
X-Received: by 2002:a05:6808:2448:b0:3eb:60e9:eae1 with SMTP id
 5614622812f47-3ebcb33635dmr15143b6e.29.1734378214876; Mon, 16 Dec 2024
 11:43:34 -0800 (PST)
MIME-Version: 1.0
References: <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <Z2CCH5HAbx8ECDin@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Z2CCH5HAbx8ECDin@kbusch-mbp.dhcp.thefacebook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 20:43:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jfaNjgjNAQPa3QPNdU8BCoocsbo4Vfo5obTxcyTKOUWw@mail.gmail.com>
Message-ID: <CAJZ5v0jfaNjgjNAQPa3QPNdU8BCoocsbo4Vfo5obTxcyTKOUWw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Keith Busch <kbusch@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Christoph Hellwig <hch@lst.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Bjorn Helgaas <helgaas@kernel.org>, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_114336_626990_125FD5B0 
X-CRM114-Status: GOOD (  14.83  )
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

On Mon, Dec 16, 2024 at 8:40=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> > However, there is an additional concern that putting an NVMe device
> > into D3cold every time during system suspend on Android might cause it
> > to wear out more quickly.
> >
> > Is there anything else?
>
> I recall a previous reason for this behavior was because the resume
> latency was significantly faster if we don't prepare the device for D3,
> and the nvme protocol specific power states for some platforms was
> sufficiently low enough. Apparently this choice hasn't been universally
> optimal.

Thanks for chiming in!

I'm recalling some other reasons too (mentioned in one of my previous
messages), but overall this is a driver design choice, it is not done
to adhere to some general rule.

