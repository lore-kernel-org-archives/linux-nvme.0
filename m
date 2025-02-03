Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF250C02192
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=; b=MT/YPjEAB86hvoVkUuUOsvCtDM
	m6KZoUejkrFOqWkj4ZhyBLNsz/Chv3Y1N/nY0eZmMyrL6z8bHExtW8A+R5OiDANok5Y9/61eyKaDc
	f25mZ/W46diWiTUsYZ1VigcOiLWqvMYdz9CTtgsnOWpoTHE/xRqvW4IiQBQoaG/mmfc5P9uRDV3T2
	Eu1CjA6IPbL7earKdfzwV9zbdrZxzGsvctjjyBQrUaAtZP6Q+EdlPFjl5u9wgZtNGK0uDXXgDQLkM
	LzATE7tcTi2gSoLAfqE+2+EYM49fsSiB3OS+XN1kEFR1s0809nmhkjLVguwwjTREzG9wAfRx57xaK
	i7PLLLOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhbp-00000003puR-0aI4;
	Wed, 05 Feb 2025 15:46:37 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf3qx-0000000Gdw8-2bWU;
	Mon, 03 Feb 2025 21:19:36 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so8434291a91.2;
        Mon, 03 Feb 2025 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738617574; x=1739222374; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
        b=a+kdqapEh4NQrUVgZtOKupWvCFLFKkYhu6uyMoamXFtkknpspM5/qcimkwLpTA9/1q
         uQTe9Ld1+MDrkkOqX/fZq9pDeCA/RF0jPOqs2A+9nNpSMZv4Fa0bdkRfFnoDzgXarSjQ
         4ua/CkX1ISutFb6zYHQtBDRF3Z/E9Dl+Ed2JlJRfMKxsgF4g2NwDUXsZNwHgodW+5i0k
         3RR10ziwR3EhAU57X8FNQeS8SQ7qyivYMiML6Z8/oKkHwr1klm0HfiMJ8fl/A/n6qcj9
         mu9/rxPpvgvsk4G+h5+LtYm56FjeQIpNnEEcEBf63brPP+uCOuuq+lDJ7ii3iQNZGYs6
         K0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617574; x=1739222374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1RprFycDuHJldRn/ezrS+F5IM4jHFkaXUl211fTz08=;
        b=CLo1bnO5zZwkCdB5bwVhKbqOvTNjnUlk0y/UHqDaow14p/V3ixHYdvX0cXGxXWb/6Z
         U6kPTACYFOaaA3m0DOEd4gNJ6g2kQvEtBK5SLyb/38oYWY4H932E9iEmKkamoFT8ex7R
         M7rQZPJHatZAWxoAvHiXcH8QsAs0V9SMjBxN13Im7+sb39m7f7g5bRmwWlwTN7lw+aIB
         wSF5gT1XcLOsl5cKSSNzBxWNwu46zvHYk8WOIxD44iWmqEO22qrfaTAnrILLnyZIhH56
         OOeTFjx9gDdqs9DSJspHO3jTq1gOH1SOreIwJ6OeReEVPpmF5An9x14+cCWUV7fG/zWk
         YkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeQ1Im9l2uem0Ba80AArUqcrOSH3VlAhjWNAAYInDgxWwROHkS02vZQO6g9mRPEZN1tLbrC0EZFOxmhElyXz3L@lists.infradead.org, AJvYcCX9KfvrDK2cDIuFX/EWWU5KcOw7rJ99grPQX06F/GLzknEHFmK87DJrjDKCAQVSB75sXZ2RyS59vDUKQg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzulknbUmZqdejymyN7MMgRuqyHilri1Hxc6Mrgglh8WyiZVj1A
	4dobpNj/obuFdGY42Mj3YMlZCfTkuCIhXSirsvJocGEV0oKXc4Se8R0G+oPsJHGoKPW3LhHh0so
	/DExcEv0GopK0Vs++JOIfT65DeAU=
X-Gm-Gg: ASbGncsJFR578hQw57c4kSrDcPgcW8825kswhtYOysnkvSdb99HwN06TLV8KSujlpSQ
	PplpBeToxlKc+hTN4SdbXndjdU2OIBF3Ulf6064lohAEgCC29t7V726yRz+XeJ2AV8vDQIbLx
X-Google-Smtp-Source: AGHT+IG/z3EJhnf9SR0K4H9KlI981FGgmyEgJkvQWHpkkih0UJEnWjGg3KJxlOWE94AU8gGejkz3MNO9Uh3+nXXaTBI=
X-Received: by 2002:a17:90b:5146:b0:2ea:3f34:f18d with SMTP id
 98e67ed59e1d1-2f83abdebdfmr37965262a91.10.1738617574433; Mon, 03 Feb 2025
 13:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
 <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
In-Reply-To: <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 3 Feb 2025 22:19:23 +0100
X-Gm-Features: AWEUYZmGyX5TH9PuhG1vFlJR4zNh-9wcNWLcslfb_ZiDi-fTNv4o-akZqj7ScMc
Message-ID: <CAOi1vP_UTjuF5y5oEVquk45udBZ41WqxQpHufD5oK2wbQkobhA@mail.gmail.com>
Subject: Re: [PATCH 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_131935_689953_764A1E57 
X-CRM114-Status: GOOD (  21.76  )
X-Mailman-Approved-At: Wed, 05 Feb 2025 07:46:36 -0800
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

On Wed, Jan 29, 2025 at 10:03=E2=80=AFPM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 1/28/2025 10:21 AM, Easwar Hariharan wrote:
> > Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> > secs_to_jiffies().  As the value here is a multiple of 1000, use
> > secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplicati=
on.
> >
> > This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci w=
ith
> > the following Coccinelle rules:
> >
> > @depends on patch@
> > expression E;
> > @@
> >
> > -msecs_to_jiffies
> > +secs_to_jiffies
> > (E
> > - * \( 1000 \| MSEC_PER_SEC \)
> > )
> >
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >  drivers/block/rbd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> <snip>
>
> > @@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *p=
aram,
> >               break;
> >       case Opt_lock_timeout:
> >               /* 0 is "wait forever" (i.e. infinite timeout) */
> > -             if (result.uint_32 > INT_MAX / 1000)
> > +             if (result.uint_32 > INT_MAX)
> >                       goto out_of_range;
> > -             opt->lock_timeout =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> > +             opt->lock_timeout =3D secs_to_jiffies(result.uint_32);
> >               break;
> >       case Opt_pool_ns:
> >               kfree(pctx->spec->pool_ns);
> >
>
> Hi Ilya, Dongsheng, Jens, others,
>
> Could you please review this hunk and confirm the correct range check
> here? I figure this is here because of the multiplier to
> msecs_to_jiffies() and therefore unneeded after the conversion. If so, I

Hi Easwar,

I'm not sure why INT_MAX / 1000 was used for an option which is defined
as fsparam_u32 and accessed through result.uint_32, but yes, this check
appears to be unneeded after the conversion to me.

> noticed patch 07 has similar range checks that I neglected to fix and
> can do in a v2.

Go ahead but note that two of them also reject 0 -- that part needs to
stay ;)

Thanks,

                Ilya

