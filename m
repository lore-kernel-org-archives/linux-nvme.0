Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E46C001DE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 01:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCUZXa6Es9cQ4BNJVCoepAZWTfjEQbGJfd5gyEMjDHY=; b=HP+vPQUgGxtH67k2m0VVnUfQaT
	jloC2q1bNuslY4B1jv92IpJuXt50B6kNUrRo1Q11q7/3SISse5l/KOsa/1XNv43QqlefXJkbKORsm
	Aa2XLAAbiM1LrHrX7fr5zXl+xgPP9mDjVzDlAHXVq0QUD1U/eQV7YaFWPuqerFR9g8KR4UYTWNqaP
	Ft3SCwy6wVjoLcR1BbWy9TcGCIsM0fm9wxYOwC0LM0OO4VySVxSjS183isqlDKrjilLZa8qczEYir
	soWB/kSNcAe8xWhgYP4/7QWowDH6aV1UhUqrrrHdAZ/SfAmtaAmpwqKF43Rtfxs2REtYL3FGLzkoJ
	RebHp3Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOpxB-00BsYy-04;
	Thu, 27 Jul 2023 01:38:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOpx5-00BsYb-35
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 01:38:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690421882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCUZXa6Es9cQ4BNJVCoepAZWTfjEQbGJfd5gyEMjDHY=;
	b=dTg+52vLQca4pGkIcL7hh/MhQXZ8Lu/XsBgvqTafeaPjPdDXUnk3yJwa/zFJP29IlM269w
	IEyDHtXCx8LwuRmfIiiY33uXBlwc++5Ut+Xy3b5ykzUwwiS243Ue+6Rq0T2PGmzZOu4Sy2
	0965+SLagEdis/U+x4vmIqlKe1fmDqI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-3I2i7xz8OWi1yKD4j1jZUQ-1; Wed, 26 Jul 2023 21:36:01 -0400
X-MC-Unique: 3I2i7xz8OWi1yKD4j1jZUQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b2fb9770so3394111fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jul 2023 18:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690421760; x=1691026560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCUZXa6Es9cQ4BNJVCoepAZWTfjEQbGJfd5gyEMjDHY=;
        b=Mih79qngB2VyxxPs8wfrvwobgLo6DXiv6E/W0ZmEX6sxO8llhYn7usycU8LYkdwIL0
         1K1lw/0B0Y/m0ByobhqYBhS5nGG8JwaKoFh4lS5OAE0pz3qkIZVnqYzYap/S5gtBZGE5
         XezmhnWO4s/nvwyTmhC6Pm9Rq6z3X/tHGY80tCAiwGG7ehEu9COlH2/vZhqG7LnFo9Yz
         SK02209EJdgc/uTXqVmaTKv6ZoUUuBUUJPU77ml1JWeQB8lukUyDryZHBRggJiWVjGx6
         r2zH2AheS4GT8OeAqIpzEEA/KCZ8bELHBA5WK+MVll7/2s5YwCI0yWZI2tX1mFlfaIas
         amUA==
X-Gm-Message-State: ABy/qLYJa8iCFDHWVFy8nq3k4HjFLM1aiRdMkfD1DzolaUbZ5CZ0ZALK
	uMkQOPdi/vFOuBLx4zDxTbSoLgPqZzJB6zI9jy4h4oOpeLwhcacJWfWwgGn7ZduILUlMlWngUAI
	8nyRArG9lgcaeLLUKnZi9f28JBEPIkrEFxPIahs2g0D0=
X-Received: by 2002:a2e:3c0a:0:b0:2b6:d5af:1160 with SMTP id j10-20020a2e3c0a000000b002b6d5af1160mr504303lja.28.1690421760506;
        Wed, 26 Jul 2023 18:36:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFOBFQF4i/nZSntWWaD41JKuv+ZwZOZuSnOHmDG5Prss7RR2wy97DAUUPM01iVMkjKje9SUMtVFJEwvlJHi8co=
X-Received: by 2002:a2e:3c0a:0:b0:2b6:d5af:1160 with SMTP id
 j10-20020a2e3c0a000000b002b6d5af1160mr504291lja.28.1690421760080; Wed, 26 Jul
 2023 18:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss> <ZMHIrcv+GyqB4FfM@ovpn-8-16.pek2.redhat.com>
In-Reply-To: <ZMHIrcv+GyqB4FfM@ovpn-8-16.pek2.redhat.com>
From: Guangwu Zhang <guazhang@redhat.com>
Date: Thu, 27 Jul 2023 09:37:05 +0800
Message-ID: <CAGS2=YpVe=4mPnUNVd4mvcsaL66wUv0TPhSAf_MB9jAbbSOJKA@mail.gmail.com>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <dwagner@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_183804_083799_2E1A6EF1 
X-CRM114-Status: GOOD (  17.41  )
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

Hi,

Can not reproduce the bug with our test environment.

5.14.0-344.el9.x86_64
b0:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller PM173X

# nvme sanitize-log /dev/nvme0
Sanitize Progress                      (SPROG) :  65535
Sanitize Status                        (SSTAT) :  0
Sanitize Command Dword 10 Information (SCDW10) :  0
Estimated Time For Overwrite                   :  4294967295 (No time
period reported)
Estimated Time For Block Erase                 :  4294967295 (No time
period reported)
Estimated Time For Crypto Erase                :  4294967295 (No time
period reported)
Estimated Time For Overwrite (No-Deallocate)   :  0
Estimated Time For Block Erase (No-Deallocate) :  0
Estimated Time For Crypto Erase (No-Deallocate):  0

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E5=9B=9B 09:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 26, 2023 at 01:52:04PM +0200, Daniel Wagner wrote:
> > FYI, I got a a bug report [1] with a 'stack smashing detected' when run=
ning
> > 'nvme sanitize-log /dev/nvme0' on Debian. Originally, it was reported a=
gainst
> > udisk. udisk recently added libnvme which does now a sanitize-log call,=
 so this
> > problem might exists for a while.
> >
> > We figured out that an older kernel such as 4.19.289 work but newer not=
 (it's a
> > bit hard for the reporter to test all combinations on his setup due to =
compiler
> > changes etc.).
> >
> > There was a bit of refactoring in v5.2 which could be the cause of the =
stack
> > smash, because saw this recent fix:
> >
> >  b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data=
")
>
> This commit only fixes DMA UNMAP direction for integrity data, but is
> there integrity data involved for 'nvme sanitize-log /dev/nvme0'?
>
>
> Thanks,
> Ming
>


--=20
Guangwu Zhang
Thanks


