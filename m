Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04D7C54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=avaoqQUXxX9oUMSN+JYXv35pK1GslmAZHtJunApYpO4=; b=fFMwQcZyJdMpsJMI+QUzdbMrcF
	tlUNEtRfXohdoVJSQOSNHYeyfdlVm3DzLXuEi1KrlrbgymmvD6W3Cuko2v5Pf6d9aE0ZzTyfvP0OZ
	5VaUda+NTUMceD3J01Jh7lGOUUngVrnykmWfY7iMFWNLSqqOWzkN0EYKGydnmPBfOTalXsuot2RwY
	hx0HbPpPAc85sJZ3ihqG8spwxWl1aphlmEyapDccT82BtZo4CCI/sC5tX0QavHTueoheGuC5iDT/0
	ouhQEny2xVpjfe6u3uIrcqmJmygtHIWx3W5xgjlUpfNFoWlMu4kGj4sJvTzCWgyhI9amLZT5QH4JW
	TyzOfOcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6vG-00000001Fcn-0MHa;
	Thu, 22 May 2025 14:29:26 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6j2-00000001E7d-0c6z
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 14:16:50 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so894535a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 May 2025 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747923407; x=1748528207; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avaoqQUXxX9oUMSN+JYXv35pK1GslmAZHtJunApYpO4=;
        b=UhlLiFaAPXAiyVD2Y0wnePckHeiM1c8XOmtFPT6VemZrh5eq+dOe1NdZfG5np53Lbg
         YtXlz4/cQwilzAGFUeWccVfjesz4yfk7njpNhoyFAEjeDIh8nqMM8AsXiYATIyBQd/Fo
         52ZqZwB0VXrq1zBK7LKUywmOBPTplwmAFDYjJXqBPt9EpSVOnyd3T426eskfgNu/C+9l
         /Zm6B5p769lQOG8U9vzHF3BD0GYok8OYg0TrdfDZBY4CyDMXfg2/uNQO2sAfFskZ10d7
         lntCVElYOygogDbRnZRmyw8R6dorqliin/HfGUZF3jtsdxYn7GlOqNX+GaELZj+kOUOP
         6VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747923407; x=1748528207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avaoqQUXxX9oUMSN+JYXv35pK1GslmAZHtJunApYpO4=;
        b=MoR54knLWRxt+dcf6V0gfI0bDqnbw6reYn3QePalv5FwauuMvd/4DrqfU2p6h1lmRZ
         CN0IPzqWJVuniJXY4h1hSf2cE/tq3F3+iVlhx/tq1WhqRvMZZdy4IfoSNa804aoe1Hrw
         //Lv6CWm+jth289dtLvEaLEv9yU3pBwcRG1kpvtC/dAYgu2uu5Rar24zQGmj0oe0wXc4
         cNtMvPbnkiv4BfiQQXeVK9us/SGHf8vN5wEbGg7mhupPz5dUt/0IC/Z7+WzfL+AHRBvz
         ffAMNs7/Bv09H1u5uWP8vOBYyjdM7Oe9D4Xl5G2iarl6FRIrpC3dt0SPkFv6zXjykj1t
         TZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJdsVJFUp6g8IIGvbz7DNaL7dmzGM0hPnLpDhjf1DpbGIGfJG+L31mWzIuN6g389aB6Ylw4T1BpJ0/@lists.infradead.org
X-Gm-Message-State: AOJu0YynKDyBZpQNl3QIqqune+Gk/p1jsWG7ZUJ1gJpKVwoZHLnWbrm/
	IzTG2M4UKKvQ/xdY3n+tLGXTaE24NdJRH5ndJa5rVAdBs917cr1f3lweO8CnKMEQ/1ZXvLeE5+z
	nkLCmx+EeV3pi1uyAWXg6lDFRdf6Bb3rnnRlbXRYuQg==
X-Gm-Gg: ASbGnctSr3CD4jOhl7Z2WWkWntV2B5eCpnhM5LfcIlcj59D42x20mBTjN8rkUqcnduQ
	zWKSe41SPqLvEcikFfZDBoghzOUG5XE6/pu9Jo7NqGIpCbZR2/cf/h/3ZAOLuiAL0YbtZ4FmV3P
	LJAqR3Mbi7H2BtMex9TwnerICQ6NTCars=
X-Google-Smtp-Source: AGHT+IFn230/PKJZsGRuxo11zZ+JeSHOoNGGnfIVQoI+Qv70Y452zzlcAff+q1itAyKInAytfcjBAK7DbbYzYCCyHpM=
X-Received: by 2002:a17:903:2f43:b0:231:d156:b271 with SMTP id
 d9443c01a7336-231d43a65e7mr131841975ad.5.1747923406935; Thu, 22 May 2025
 07:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp> <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
 <aC6oR90OFDSITndh@kbusch-mbp>
In-Reply-To: <aC6oR90OFDSITndh@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 May 2025 07:16:35 -0700
X-Gm-Features: AX0GCFvNqnF_XxkcA7L7Svsfe06zE1TUnGBTF3YyWXFV7MLgXmZgc53gSM_Pbfs
Message-ID: <CADUfDZoA2dRfzEQ-uaTUfVQ+QYa-7RGfUZGYGpCmXDJVSt97UA@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_071649_079367_1AFE4F3E 
X-CRM114-Status: GOOD (  14.78  )
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

On Wed, May 21, 2025 at 9:30=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> > For the record, that change broke Linux hosts sending DSM commands to
> > our NVMe controller, which was validating that the SGL length exactly
> > matches the number of data bytes implied by the command. I'm sure
> > we're in the minority of NVMe controller vendors in aggressively
> > validating the NVMe command parameters, but it was unfortunate to
> > discover this change in Linux's behavior.
>
> This is a fabrics target you're talking about? I assume so because pci
> would use PRP for a 4k payload, which doesn't encode transfer lengths.
> All the offending controllers were pci, so maybe we could have
> constrained the DSM over-allocation to that transport if we knew this
> was causing problems for fabrics.

Yes, fabrics. I would be fine with always mapping the full 4K data
length for PCI but using the exact length of the ranges for fabrics.

Best,
Caleb

