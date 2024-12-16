Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0153DE77180
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uf/C35BwQBTRlT0IeaFUKw9xJGt6H8iM2xKqt61L0Gc=; b=t6UPahwxz4WwWbKMgyCB8nYCao
	rnvj2Ajn3cegX6hySjGF5864ghALq6qM5KLkgW3fzY+lii2TVkV4NVVKiSOlCJMLLeK5dgu2BYNxa
	vYR5Msj65cAItdKqui1S6E7ElJWnv8kG4lVltRZqzhepFOMftuTS1/vzA6E/LzxYmxMxCB9dtuKuw
	sIs57dljraK2M6KEHKYbbeBT+FqVAic1aedGieoHMBVRlaBqzTVRhBDHkRh1IsstjoBnRlF7LiIxt
	tP6/5lQsCElFo60q6TX3OecI+YnWO/VhaPNuyiVIcBM541b6sFX4Xc+FfW6ZJncoeb0Kqnm+tJVTS
	R9CweZwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEGu-0000000Aeih-3s23;
	Mon, 16 Dec 2024 16:48:40 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEGs-0000000Aehh-08Pf
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 16:48:39 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2163b0c09afso38189735ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734367717; x=1734972517; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uf/C35BwQBTRlT0IeaFUKw9xJGt6H8iM2xKqt61L0Gc=;
        b=mg1UyBAi5Huh+dwJaWPi41UM0zrQXfiRViNIh/8AW1nKt36hlZQnk3XYEdfSNNlwNg
         C0XA5ZHxYLZPOGd6dP17ufSZmJ7vf7t9FFBNvpxikt68tK3Ml8ePw04FkhZJb/0nW+QY
         f4SECe25F89eWN4ZRGinyYySNauJ5JMmqdurGyhTzRmpF8yOjyGhqDL21upbuR2+pDE8
         +af2mJN4TAFmpHR7Uh1AWQfa+WYv4JARIR6c6+HNjrhigmQyYZryRtq+JEvVYgrGHnZ7
         W3ho5Q6h8dQgGoYc9X73amOMgR/ezY/imNZD7A8q6Q2cr2Cg27dRlfhr61Drz3R8P4+/
         2jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367717; x=1734972517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf/C35BwQBTRlT0IeaFUKw9xJGt6H8iM2xKqt61L0Gc=;
        b=AOWh/noIIBJTzUQmi9+KQZRGlLUi20c/rixha0npAiHf3hSDj7NSeb4xrBeaVRdAi5
         fD9Pyf2/GWcsc2Z70FqKPR/947dCldPnsrk53UqdR9N8jYt5jOHfQO2Nf9JU33Ba46Wl
         kdULTzyU6b9WNH+lGgaZEvr1dzjlteqkHSA0j0P4CxGz8P/I9Mp4BurzLrXEKGVzBzmY
         qG7ko4++3kyueEzO7AozSQgmt7PYbTHOuSc//HGHwqMkBUOcUkfinsQRkZzrO7jbjP8T
         ZRRIM9s5nTBQW0+tzj/dvL03Jk3qhih5wnJH2yM/wLqMwAGya7m84k3/a1EfZqS+034A
         nS7A==
X-Forwarded-Encrypted: i=1; AJvYcCXtCbkC5HLHJ66SOJGvSaUaY5Kv0JtVkdc8kXab85D8wpACYVVIAHjDifQUOTorI4NKOj6Dusbn6NQu@lists.infradead.org
X-Gm-Message-State: AOJu0Yybiv/jB9GFD0S4QHUd5NoK9FmAnarKviLRc0d4x6naCqlTdU4i
	V+a9NL1B1K6V7kzxNjAgWefG2TFT2o2j60xkyEtLB+1LllVhXxxZGKm7Z5X6Qg==
X-Gm-Gg: ASbGncsGtq5psu8bbmLpJLBtM4O9WvU8zZJa15W6oh91uhL8qVskbqO+8snS0LQ0SLJ
	AiUUUF2//9w1CakUC3856rWmXPW4TyLQs4Shg1mVi9qVQOJeR7gQ/40/chYtly7ciYX4mgc72AD
	pqsUfeN/G0WGtg2owH5cnEldWfjz87qN5/Ica8/ixf3+GiBKT//+dRm+fXMdMLk4u6ifif5s9hd
	E2gpu5O7HP/id9yjAdhbFAXIE1j1O972uBraM2g53pXeKpc1RqXPRkJGyAtq061cpkM
X-Google-Smtp-Source: AGHT+IEbjZhCC60l4mXiJWyw0YJq9ctEYxooGkv/o7bOg9yFa29PqtrzXCLZoknekW9tg22tCtP5pg==
X-Received: by 2002:a17:902:ccd2:b0:216:26f1:530b with SMTP id d9443c01a7336-21892a70579mr183783695ad.51.1734367717333;
        Mon, 16 Dec 2024 08:48:37 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e510a9sm44948185ad.167.2024.12.16.08.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:48:36 -0800 (PST)
Date: Mon, 16 Dec 2024 22:18:30 +0530
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
Message-ID: <20241216164830.36lpu6gfnapsdar4@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_084838_116750_AE4C5733 
X-CRM114-Status: GOOD (  19.89  )
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

On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > > We need a PM core API that tells the device drivers when it is safe to powerdown
> > > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > > applicable to other devices as well.
> >
> > Maybe I'm misunderstanding things, but I think the important part is
> > to indicate when a suspend actually MUST put the device into D3.  Because
> > doing that should always be safe, but not always optimal.
> 
> I'm not aware of any cases when a device must be put into D3cold
> (which I think is what you mean) during system-wide suspend.
> 
> Suspend-to-idle on x86 doesn't require this, at least not for
> correctness.  I don't think any platforms using DT require it either.
> 

On suspend-to-idle, yes D3Cold doesn't make sense, but on suspend-to-ram it is
pretty much required. That applies to DT as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

