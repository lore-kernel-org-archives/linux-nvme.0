Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2197BC05027
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Feb 2023 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dq60iPwMT9YyeuZYyBaeVXOCLyMD+LIZs+7sJUezDZU=; b=z3VCGjPsJIeDFW4qoa3jbr3Vye
	WD/Om/CdpDlqXNQaFfyRnhDfuEmOmbSQ2ApZ1encAKgTl4n1Mcb65HdvQqfhGnrSzlBMA+BrXn0D1
	KRthNcjTuvYcGcQap4nVJsssFFHJ/hd5aIILJajmS/+/a8zz70FFGsrox6wNSGf9zFYObZGFJm8rR
	vyOr+eSa/K2jR/tXh4W408igknQfjvk3OIkdYZcKb2c/jOPTTWuVaP1L/9SRpnWPxHtwi83A+Dclk
	Kb4j3a+625RnwLslWwC96i+ezgaGr2u5kHhbVmwtqC4rUwAGx1UVmsnbwZiu37L5wMmPMgKmDUbw2
	vaITPP+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTsaA-002R9j-IP; Sun, 19 Feb 2023 22:54:58 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTsa1-002R9B-SW
	for linux-nvme@lists.infradead.org; Sun, 19 Feb 2023 22:54:51 +0000
Received: by mail-pj1-x1030.google.com with SMTP id f8-20020a17090ac28800b00233d7314c1cso1437917pjt.5
        for <linux-nvme@lists.infradead.org>; Sun, 19 Feb 2023 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq60iPwMT9YyeuZYyBaeVXOCLyMD+LIZs+7sJUezDZU=;
        b=NZYxQ1+X02jZEYiaJJ0FEnR/k09pMGRnpL3WRKgxjY6VkopET8Pl1CsQTko02lD8yj
         HQSoD1Pkg26h3qdJvpRbyfl965FaQfcULt8lYHCNmVx2v+U29mXO7UcsE3q2+gF/rhP5
         wFYNuAmlMe/mCOOHD4HACmSCUNBZx6h6beDZu5LqD3GazOseUVpeN7zkVuIIQzChoItZ
         WnBDtK2BDNhVpkwIRJBEi4j2hw5zcoiaanvs+2rl/7Q6ecpPU9vHA3uLxnrxj52uKpfZ
         4n9IdSLdprAsyBO/gLc6822eWwciBp60bsJVPfjHpjz3oU0xAZIKk+EDJYxihW8EeO93
         Ls7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq60iPwMT9YyeuZYyBaeVXOCLyMD+LIZs+7sJUezDZU=;
        b=fXcmCkuvq/nSp71dquZfwFIx4ffE0NI2j02IydOIwbUoGoMYWixIfD3VQbdQaW+XBk
         s1fyVPVSpDYEu3fJT7RsGCDfPnDMk1nJ+oiAqAg0xioNfFDYgotnCUSjDMy0M3g83Ppx
         Z7amUcmC3VZw0HkE+5d766smcJm6hrJUReBQyTG3gJ2kxacnZMuyq9gg4ElijdRATm4v
         Dbkotsw7VHR6hPjnoV1lt1/KctYkJf1ArmOVU234iKHUxsylcRcJFYCRJfj2zlEawQQb
         uVMMk3djdReuJBWOSuye+KcxF4OwB5D3vz0bpH49STAVTl8DJQWuzvxJjNPoetjb2RqB
         nibA==
X-Gm-Message-State: AO0yUKXzXnhfyq9KgnwMEHFSNC79+KZmi4IpXWuQJvJS8PDDRLT3lYSQ
	fjHgISQStCyXCF1N89j7rm/BySPgMFB4Rxf01Gw=
X-Google-Smtp-Source: AK7set+kG+DUmbdPiJsfJTmx5/zd26OJWhuaT2epIMVOS6lpWkQvJxPNa1l7k/ybyAmYhUoo3ImINDAItkhm0F2qDbA=
X-Received: by 2002:a17:90b:2643:b0:232:d23a:8314 with SMTP id
 pa3-20020a17090b264300b00232d23a8314mr809903pjb.96.1676847288595; Sun, 19 Feb
 2023 14:54:48 -0800 (PST)
MIME-Version: 1.0
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp> <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
In-Reply-To: <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
From: Michal Berger <michallinuxstuff@gmail.com>
Date: Sun, 19 Feb 2023 23:54:37 +0100
Message-ID: <CACosJgyjgh+cz6nTrKWVQ9P8Z9_wJGWGQBOjae2MoJrZQ3RmTQ@mail.gmail.com>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230219_145449_964139_79353C2F 
X-CRM114-Status: GOOD (  17.11  )
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

Have there been any patches submitted for testing? I don't see any as
part of this thread nor at the bugzilla where the issue was initially
reported. :)

Regards,
Michal


pt., 17 lut 2023 o 22:23 Jens Axboe <axboe@kernel.dk> napisa=C5=82(a):
>
> On Thu, Feb 16, 2023 at 8:19 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Thu, Feb 16, 2023 at 10:28:55AM +0100, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> > > Hi, this is your Linux kernel regression tracker.
> > >
> > > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > > kernel developer don't keep an eye on it, I decided to forward it by
> > > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D2170=
37 :
> > >
> > > >  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> > > >
> > > > For the CMB-capable nvme ctrls, kernel was exposing couple of relat=
ed attributes under the sysfs. E.g.
> > > >
> > > >
> > > > # grep . /sys/class/nvme/nvme0/cmb*
> > > > /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> > > > /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> > > > /sys/class/nvme/nvme0/cmbloc:98
> > > > /sys/class/nvme/nvme0/cmbsz:524829
> >
> > The breakage is that the attributes are decided before we've setup the =
cmb
> > regions. I'll send a fix shortly.
>
> Michael, have you tested this? It's queued up for inclusion, but I don't
> see any evidence that this was tested.
>
> --
> Jens Axboe
>

