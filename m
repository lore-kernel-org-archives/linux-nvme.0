Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF52C19F38
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jy5UzyKzocsSx5cSXomfjfFL//CTemBkcuebkephmC0=; b=p81oc6xygoW+OvhrVKtXIsucmS
	xH3HZTyHcyftzGiSOGGgp/wQOrCJPWQvLqegvzDHU7ToqMFFOSUjj5Y0ZCESisJrXlYs8L+eBYvLF
	7G0z7EP++9HD+GlSKZbKC7Y6Z9tZco0L7wQITSOnmc84G5MYw18s+Svm7h7x3sS7yvEBSlfs3yASW
	ANbYlMnnwowX7FBMsK1y7DTc4aPiT1UWiringCm2My4EwLwgfeaXT6GGA9TxmB68Am2WPERVgMPWV
	O6tunewckQF2wqqBffvmzvDz07FaTpqb4Ep/ZsIDV69PfDRT1cFveQr8737LuZDu37kSrfbrMdyeg
	F1MJPmWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJEp-00000004FJM-1aLp;
	Wed, 26 Feb 2025 15:22:19 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnBqn-00000002gwC-3Bbr
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 07:29:03 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-aaec111762bso484833066b.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 23:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740554939; x=1741159739; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy5UzyKzocsSx5cSXomfjfFL//CTemBkcuebkephmC0=;
        b=PCdJVfFe2SxQ+ZIrPFniWXavWD0EgMd1ooh8kxweCCcq+aXmcpbLv5x5+Se6nAwUa7
         FJW3+UKe1RMQ1QNIpLWDdwpwRCGYXfW+Z0ofgMlhWUD5qNJjAu3KHwsESKK+k23Um5Dl
         lQVD8yIou6LSNCBAXnVuJU4E7s/tKbGqf7B51f77D4uKa4blH6KNXhYf8QE+eczlHlBE
         mn3WnJGABCzvRJQzZymyYHT0VQ9K10GOmX6t7zb4ynMd7g5XSusxPfSMrmRwHbimoDRr
         oIMlndELH7wkac8vH6WT3d04LeDU7c+xu/DNhw+wCcV7ova8hIBAsJO/jz2sA188EO95
         p0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740554939; x=1741159739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy5UzyKzocsSx5cSXomfjfFL//CTemBkcuebkephmC0=;
        b=J1QKb1MTOMc3q0N887c3d0aWBlfUZ1F9ICB6jIEaK3TV7K10g9JDruipN1Aqpb5Vg7
         RJMqRv0M7vP/cQo37TWBuBrdli2Rrc8BgOEPyIHjIs8iTT+FRuI433g1s1X1vh+AVl/u
         5TVpXtQw/cM2esEOZmfIJdxUAkUAWPK8MKGlsvgXe5LR1ChQ1+bVpOHGvIPaIvMvGBrR
         /f5cBNho6WVqJwXJikw4wZsSPWN+hCm3RKs6kl3kMk76Tfo/CQNwmzrNCvL3+Nb0n8/2
         BNBShs+jDRdhUmpxzHfffxcnwnd4tP3I7De/LED9AtGa4O4H5zPhnah3lepY7hDJ0Wzv
         +Ipg==
X-Forwarded-Encrypted: i=1; AJvYcCUvT6lzFvKEohNqZZvmQW8y4tD8Ci5gMmc8gX5FWCo2K7C+6xK353X8MclDKu/lfDln5mIe31A+Mxzi@lists.infradead.org
X-Gm-Message-State: AOJu0Yzegurnr0PNTkChXwnGEL3b49Grgk1Eyd4+7E8jYwHX7XtgnaeD
	Q0pQwPfArsbW+N09JRauuDw5K4p1nZRqOtgHjNMYvUK5Umhc5qHwxpETtaGw3j9wZ/TJQqL2Ifj
	noCSzVQpkT+EqRt1p+E8kU5HQe6qRn/Ad1thxvw==
X-Gm-Gg: ASbGncsYpRmYXfnTlAbyWJZxLfJ9vPyPl6ZV/r63CPR88o6Afc+r6BKapLC7+v/k7jU
	JTcsg9d289ssVUhq6LfsIQ8BYQTrQ9zfVknbOBY+PFz/OPMos4EmwtO1SpgJ+pp+S9mdNJZTKbP
	Ep8qvSiA==
X-Google-Smtp-Source: AGHT+IFYP8Tba+z3P6zhrfLVohTtXs/BwRHQBKKRVXu59ZSzqEPbWtjoPmnK2n59Ee5Tugvqu0RIdPnu12lt6iEjWaU=
X-Received: by 2002:a17:906:18b1:b0:ab6:ed8a:601f with SMTP id
 a640c23a62f3a-abeeed1123amr202024966b.12.1740554939189; Tue, 25 Feb 2025
 23:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
In-Reply-To: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 26 Feb 2025 08:28:48 +0100
X-Gm-Features: AQ5f1JpekOKemtGu2BHsnbGs6fr563e7jHjxxRB5HZ2bESNce9YNZRbPCIKk9Cc
Message-ID: <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, Frank.Li@nxp.com, 
	James.Bottomley@hansenpartnership.com, Julia.Lawall@inria.fr, 
	Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	broonie@kernel.org, cassel@kernel.org, cem@kernel.org, 
	ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr, 
	dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org, 
	dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org, 
	dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com, 
	hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com, 
	ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev, james.smart@broadcom.com, 
	jgg@ziepe.ca, josef@toxicpanda.com, kalesh-anakkur.purayil@broadcom.com, 
	kbusch@kernel.org, kernel@pengutronix.de, leon@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org, 
	perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de, 
	sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org, 
	sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_232902_116745_009BDE4A 
X-CRM114-Status: GOOD (  25.66  )
X-Mailman-Approved-At: Wed, 26 Feb 2025 06:39:23 -0800
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

On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 25/02/2025 =C3=A0 21:17, Easwar Hariharan a =C3=A9crit :
> > Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> > secs_to_jiffies().  As the value here is a multiple of 1000, use
> > secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplica=
tion
> >
> > This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci w=
ith
> > the following Coccinelle rules:
> >
> > @depends on patch@ expression E; @@
> >
> > -msecs_to_jiffies(E * 1000)
> > +secs_to_jiffies(E)
> >
> > @depends on patch@ expression E; @@
> >
> > -msecs_to_jiffies(E * MSEC_PER_SEC)
> > +secs_to_jiffies(E)
> >
> > While here, remove the no-longer necessary check for range since there'=
s
> > no multiplication involved.
>
> I'm not sure this is correct.
> Now you multiply by HZ and things can still overflow.

This does not deal with any additional multiplications. If there is an
overflow, it was already there before to begin with, IMO.

> Hoping I got casting right:

Maybe not exactly? See below...

> #define MSEC_PER_SEC    1000L
> #define HZ 100
>
>
> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>
> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
> {
>         return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
> }
>
> int main() {
>
>         int n =3D INT_MAX - 5;
>
>         printf("res  =3D %ld\n", secs_to_jiffies(n));
>         printf("res  =3D %ld\n", _msecs_to_jiffies(1000 * n));

I think the format should actually be %lu giving the below results:

res  =3D 18446744073709551016
res  =3D 429496130

Which is still wrong nonetheless. But here, *both* results are wrong
as the expected output should be 214748364200 which you'll get with
the correct helper/macro.

But note another thing, the 1000 * (INT_MAX - 5) already overflows
even before calling _msecs_to_jiffies(). See?

Now, you'll get that mentioned correct result with:

#define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)

Still, why unsigned? What if you wanted to convert -5 seconds to jiffies?

>         return 0;
> }
>
>
> gives :
>
> res  =3D -600
> res  =3D 429496130
>
> with msec, the previous code would catch the overflow, now it overflows
> silently.

What compiler options are you using? I'm not getting any warnings.

> untested, but maybe:
>         if (result.uint_32 > INT_MAX / HZ)
>                 goto out_of_range;
>
> ?
>
> CJ
>
>
> >
> > Acked-by: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.or=
g>
> > Signed-off-by: Easwar Hariharan <eahariha-1pm0nblsJy7Jp67UH1NAhkEOCMrvL=
tNR@public.gmane.org>
> > ---
> >   drivers/block/rbd.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3=
b92390818e8fa5a58 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
> >   #define RBD_OBJ_PREFIX_LEN_MAX      64
> >
> >   #define RBD_NOTIFY_TIMEOUT  5       /* seconds */
> > -#define RBD_RETRY_DELAY              msecs_to_jiffies(1000)
> > +#define RBD_RETRY_DELAY              secs_to_jiffies(1)
> >
> >   /* Feature bits */
> >
> > @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *=
work)
> >               dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
> >                    rbd_dev);
> >               mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> > -                 msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SE=
C));
> > +                 secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
> >       }
> >   }
> >
> > @@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *p=
aram,
> >               break;
> >       case Opt_lock_timeout:
> >               /* 0 is "wait forever" (i.e. infinite timeout) */
> > -             if (result.uint_32 > INT_MAX / 1000)
> > -                     goto out_of_range;
> > -             opt->lock_timeout =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> > +             opt->lock_timeout =3D secs_to_jiffies(result.uint_32);
> >               break;
> >       case Opt_pool_ns:
> >               kfree(pctx->spec->pool_ns);
> >
>
>

