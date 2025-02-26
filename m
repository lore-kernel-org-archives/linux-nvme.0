Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD049C19F32
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qd/P01QUb5F02hWZoi0IIwP5a5sgbN5wVj3NeUV9KKE=; b=ANVhVP9qVU8mTWDQv8HVbsnqAa
	fuGJ5VASY0+YS+9U8ZIwGDR6UlGbIkn0ZWGmfuidDBHQ0utNHtFV6CPpt5DGZF/7X4iE01lGMoHgn
	TX0DJT40P7eCk380xx+40ievwyBOBX+VEDkt9ydaB7wQQwRfqCa6KCa/3pTvhiismlI6LUBwSdwBv
	XA+oX2lnb53UIj1ggZ29wnEPsu2WjbVnLeB38VApNCLL7CHbwieHXcn39YwlfWkSNc+i0dvyZZVbu
	QabomgFgUkdbOb5Ewa9zqVCDpHqpgNoVxmHmwqyUhWTquprSB4CRFWdfXLwlIeSUpmBUIpv+28KPy
	/LhRPvsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJEr-00000004FLK-04Jl;
	Wed, 26 Feb 2025 15:22:21 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnCnd-00000002sv0-2VnW
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 08:29:51 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1311142766b.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 00:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740558588; x=1741163388; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd/P01QUb5F02hWZoi0IIwP5a5sgbN5wVj3NeUV9KKE=;
        b=QkQqb03S3f9rN0vz2G0b6dLEy47bZC3R7CB4lRmvlFsYDqYF+8JOFK1j8cIm17O7gx
         V8HTR1P+J14SF4vsB50lwM54VZYRrWo8XsNSXpHEY6vO+vuPDWs1FZgZHKmce7NRCu9D
         UIasJB8p1/dC9mPbT3AkSiPMI1sN5j8frttYYocu4M0Ys+SabcJ6XRUb2z2rgHOBaBfR
         FDuGci63VORxLiVlhanQoPae+ruW9RGVp/yLEVNVED139eEUm+oquR8ilHl02TLlWoby
         7NK/r1QVkua3+uOsRfbcSLnXy4Gbj72XN0LN+kXboyRCR28Z8mD1qxKRaKM/O9XEmGAx
         OzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740558588; x=1741163388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd/P01QUb5F02hWZoi0IIwP5a5sgbN5wVj3NeUV9KKE=;
        b=I6bpXAI6Lq+WOuDSeqKqpyxjnSgc5Mwg1imZmgwhlbbY3nFKG+8DR0K4xF+5mKKGmm
         uCpbrDHbMI4hH4lC3OT603Ff1k9vLE/1hRINPsKapjh4Rwn1AVFLulEbtKHWQmSK5aPJ
         oQDQsKmSxbnLx3Yh5VQ2HKB1IYem9evY/HNArJiOn0MK3RJJfSwZC/ozw+h0dX9XGp4W
         3+VfOq3aWOVUOgEp8B7TV2nSeJu47QEVdTsaVjKNsyxDx6OnsaZbPhGbzoIW/VkhYWXj
         PmM1f0IadHupt3Vr22iIc3g61Q2fHq/oMe5hw21va37raD0pjrs64ACi706Rljpp86T8
         Pgkw==
X-Forwarded-Encrypted: i=1; AJvYcCX0OBS/DC3vuKd2WoDMoSKn7jWswmsV6ru/X1SRm+Fs4Eki0olgJN1Pq/IvW2nBjmkS6d39GYkUgE3L@lists.infradead.org
X-Gm-Message-State: AOJu0YxdNQPwMIvuWRqgmVkMoLyYwtb1jn8EZYOUb6AxK5c7U/0EoGgH
	cGcmzMIwWON/wu6GPQKPVX3h7wjfmMPmVYMIIJzGv17f93lvC6O+MurbNeStyClW0zkXDg3LV6Q
	KhHdUhHvj+iKEw/TQYwQ8AEJsVQ0+ZzzccoOcEg==
X-Gm-Gg: ASbGnctayHsrT8T1C5KEJm0eY+AlJSOOhXyYfVWDkFQHALE6AC1J14hRSfm6Ttx0iYT
	MSH2PH+RDtzLvb8dnKde0MDzpEW4XAF+Q4qy0BGjwUubLBU3xOC0VR1PIzQvxt/4d4KLqOcG3Q8
	4KguO6CA==
X-Google-Smtp-Source: AGHT+IHCBmf3hFVyDRWrbNjNMJpg3u3tAe5Gkum3edJXg5+W5jYzpdGCY2CkRcaqBj3q4FkgF3ZBCF2Ur/l8ZS65ls8=
X-Received: by 2002:a17:907:7711:b0:ab7:c152:a3ca with SMTP id
 a640c23a62f3a-abed0c66952mr598124866b.6.1740558587743; Wed, 26 Feb 2025
 00:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr> <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
 <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
In-Reply-To: <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 26 Feb 2025 09:29:36 +0100
X-Gm-Features: AQ5f1Jrr13SgxwVjT6ysFNM9oHlwZl6dEEKFUrutAasFQHuednVFm1EELk7zLLU
Message-ID: <CAPjX3Fc1UuWvih_krriaF32aPCbGP0SPg2TSrBA8Xb7a=Ozc5Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Frank.Li@nxp.com, James.Bottomley@hansenpartnership.com, 
	Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org, 
	axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org, 
	ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr, 
	dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org, 
	dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org, 
	dsterba@suse.com, eahariha@linux.microsoft.com, festevam@gmail.com, 
	hch@lst.de, hdegoede@redhat.com, hmh@hmh.eng.br, 
	ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com, 
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
X-CRM114-CacheID: sfid-20250226_002949_640104_02D6052A 
X-CRM114-Status: GOOD (  34.29  )
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

On Wed, 26 Feb 2025 at 09:10, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 26/02/2025 =C3=A0 08:28, Daniel Vacek a =C3=A9crit :
> > On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
> > <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
> >>
> >> Le 25/02/2025 =C3=A0 21:17, Easwar Hariharan a =C3=A9crit :
> >>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> >>> secs_to_jiffies().  As the value here is a multiple of 1000, use
> >>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multipli=
cation
> >>>
> >>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci=
 with
> >>> the following Coccinelle rules:
> >>>
> >>> @depends on patch@ expression E; @@
> >>>
> >>> -msecs_to_jiffies(E * 1000)
> >>> +secs_to_jiffies(E)
> >>>
> >>> @depends on patch@ expression E; @@
> >>>
> >>> -msecs_to_jiffies(E * MSEC_PER_SEC)
> >>> +secs_to_jiffies(E)
> >>>
> >>> While here, remove the no-longer necessary check for range since ther=
e's
> >>> no multiplication involved.
> >>
> >> I'm not sure this is correct.
> >> Now you multiply by HZ and things can still overflow.
> >
> > This does not deal with any additional multiplications. If there is an
> > overflow, it was already there before to begin with, IMO.
> >
> >> Hoping I got casting right:
> >
> > Maybe not exactly? See below...
> >
> >> #define MSEC_PER_SEC    1000L
> >> #define HZ 100
> >>
> >>
> >> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
> >>
> >> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
> >> {
> >>          return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
> >> }
> >>
> >> int main() {
> >>
> >>          int n =3D INT_MAX - 5;
> >>
> >>          printf("res  =3D %ld\n", secs_to_jiffies(n));
> >>          printf("res  =3D %ld\n", _msecs_to_jiffies(1000 * n));
> >
> > I think the format should actually be %lu giving the below results:
> >
> > res  =3D 18446744073709551016
> > res  =3D 429496130
> >
> > Which is still wrong nonetheless. But here, *both* results are wrong
> > as the expected output should be 214748364200 which you'll get with
> > the correct helper/macro.
> >
> > But note another thing, the 1000 * (INT_MAX - 5) already overflows
> > even before calling _msecs_to_jiffies(). See?
>
> Agreed and intentional in my test C code.
>
> That is the point.
>
> The "if (result.uint_32 > INT_MAX / 1000)" in the original code was
> handling such values.

I see. But that was rather an unrelated side-effect. Still you're
right, it needs to be handled carefully not to remove additional
guarantees which were implied unintentionally. At least in places
where these were provided in the first place.

> >
> > Now, you'll get that mentioned correct result with:
> >
> > #define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)
>
> Not looked in details, but I think I would second on you on this, in
> this specific example. Not sure if it would handle all possible uses of
> secs_to_jiffies().

Yeah, I was referring only in context of the example you presented,
not for the rest of the kernel. Sorry about the confusion.

> But it is not how secs_to_jiffies() is defined up to now. See [1].
>
> [1]:
> https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/jiffies.h=
#L540
>
> >
> > Still, why unsigned? What if you wanted to convert -5 seconds to jiffie=
s?
>
> See commit bb2784d9ab495 which added the cast.

Hmmm, fishy. Maybe a function would be better than a macro?

> >
> >>          return 0;
> >> }
> >>
> >>
> >> gives :
> >>
> >> res  =3D -600
> >> res  =3D 429496130
> >>
> >> with msec, the previous code would catch the overflow, now it overflow=
s
> >> silently.
> >
> > What compiler options are you using? I'm not getting any warnings.
>
> I mean, with:
>         if (result.uint_32 > INT_MAX / 1000)
>                 goto out_of_range;
> the overflow would be handled *at runtime*.

Got it. But that may still fail if you configure HZ to 5000 or
anything above 1000. Not that anyone should go this way but...

> Without such a check, an unexpected value could be stored in
> opt->lock_timeout.
>
> I think that a test is needed and with secs_to_jiffies(), I tentatively
> proposed:
>         if (result.uint_32 > INT_MAX / HZ)
>                 goto out_of_range;

Right, that should correctly handle any HZ value. Looks good to me.

> CJ
>
> >
> >> untested, but maybe:
> >>          if (result.uint_32 > INT_MAX / HZ)
> >>                  goto out_of_range;
> >>
> >> ?
> >>
> >> CJ
> >>
>
> ...

