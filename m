Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F55CE8D6B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kMxLwILvWXZ7dbmttnGFrVCum5cT9l7fiN/tvvIxhZ8=; b=AXNRzqmxwj2AztR+QFLIiJ93Oe
	TyazZF1neDt6gFE1nYWbGwsXpQOSCVNeFarDmQ1+0s8/ivc8iO0lCiblrdm9IQ1bl788FX1O8bfvl
	afMglgfsh3Le8hKQocsGPP9PY/oeIPHsGHzuU00t4/LHDDSG/fl04BvPEZDEuHFp8YYjQlI5zOKV3
	xuJW9D6fCmtnqDAkrixFNd9pS8NiYcbyZ0e2wxxv+1liSLGJb9Q/aLR+mp4oa5xgGh9PP+FcBA44V
	xn41EbNWAYxum1xA5th2NX9dqELgd4bqbRC53YxB8JFROXBPlh6xrVJUlmH75Tolls1Z98OtD6qI7
	0HPFlsSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL9xZ-0000000H5Lf-3EkG;
	Tue, 18 Nov 2025 00:52:41 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL9xU-0000000H5JO-35ws
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 00:52:37 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b72cbc24637so846753466b.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 16:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763427154; x=1764031954; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMxLwILvWXZ7dbmttnGFrVCum5cT9l7fiN/tvvIxhZ8=;
        b=SgkqxJERnME5WWKST8DAd8FBaTePDmgzKLHdnctZg5D2eI5U+OHMNCXmAve9GUsL10
         3ZYe13fvCgyG/hQRlsWpALZRKwcvDjKSNR3r9XDydVUke7GFU0+UXjvapsouWwCEIxbU
         5VFdg/2b/WjAqgGmOO1iDY7zvd4wV1Scfy2CyAZ2uUGAgYvZ+V9jQImCOH3JE5qsDhom
         u104fBwxr3AGD0aAdktE8aZUrvyrOaJoudLzK5FEoddqNnSu9bvVvCxJFvY6MojYifoy
         g1r7UPLenSYnsynIAFhXMFAhmXLUGHh5eEHuAIc+L5URHssh4Ttcv1DqtYeQhE3BJdkq
         1Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427154; x=1764031954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMxLwILvWXZ7dbmttnGFrVCum5cT9l7fiN/tvvIxhZ8=;
        b=LtxnIKe0tNFJgxTRufF2j0b5ksW0lEdXH5S1VERgKh8c5wZXqEMoSc8rGXqf4iFWm9
         uuSaIyO8IbpGmJiINh4M5b2Ok4IYKqwslIjHYcD11cF7QvxPMPULUBzp5Fzc9tms+2aL
         m/+iDdQTxB+nbwGmWqPZmvtME3DALZ6rZ9BuHzezBC6uxPjYNud9omGa0lgdWWBGhIyE
         EWJvX5jDrb677wD6jyroo/MhfuemH3KruXaO04U1Dq1/TLN3KLtKRbYTksqXmQKQT3Uj
         twJMrjXL+3VwT60yWXqZNYCjUjY29duYoY7HxLXF7gTTRXMAV3BHHqhkdq0aR+FIZ7Vo
         M78g==
X-Forwarded-Encrypted: i=1; AJvYcCVNMxLk3IeBPIlfnz9x2dWKlEqoCjos1j5ebY8/aiaffPXhOOHkw8rgn0kt9Y/J7Vu7TXHulIPty9r4@lists.infradead.org
X-Gm-Message-State: AOJu0YwwO4tm16XpyZ4Ctl/gNE+6U7G5NhY5S9MNRK6mUAi3HC8OKTjT
	uj+GOpcnrS8Rk6b1u3N/AaLa8hhshHqKBpkDtQyiIOYrTw7IkWCSoM750JlfIlbDdcncpN3MYSn
	8MResAlLRsrrT3MQCN+PC7a666OIc9Fg=
X-Gm-Gg: ASbGncuKYau0kavEWuR35ENKmqOBw9n50cVAdP4g7IDuVfJaNa3kb/02SwSXqZlzMxK
	lyQv5VX4A4QKckMSON1NQTq8d9/Wa7mQaNYUtDZcbj5TdvxRw8p0iwN/tVUGW3xZ8Ul86gImWAJ
	/QpjLCBbQ2jdNvZ/JRwoREAVpI0CImvjG0lr1hVgG8ODvqtVuFsxdQzu7WIm6WeJYC2rQuGOYuj
	+PUJQ9NUyBZrunO3cBpVghZgEIJsFt64ZTsWNh/WaHS4MCQnAdq76KAJcnSTtLeXYGsJkF9E8SE
	M6Rgf/+SxyV+frc=
X-Google-Smtp-Source: AGHT+IH8tViwb5K0LyeAE96fEq4dMqXTyxJcAUQXJZAZNItZG1fYCKjwlkjZM+7fJCXvO20kH2zntt+dfYOS1Q8Bbo0=
X-Received: by 2002:a17:907:3e8c:b0:b73:22fe:3abc with SMTP id
 a640c23a62f3a-b73678cba23mr1520014566b.28.1763427154322; Mon, 17 Nov 2025
 16:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-5-alistair.francis@wdc.com> <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
In-Reply-To: <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Nov 2025 10:52:07 +1000
X-Gm-Features: AWmQ_bkJg4qvKpxNLWZT28F1kI8uku4zNIMIH4hchf7fD8GJn5ljJeGR-C5vfQs
Message-ID: <CAKmqyKNViQjZHyftdj7anoF1Wsf9qeRZQiZ9yfM_FsJAcmx7jg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_165236_800798_B51F5568 
X-CRM114-Status: GOOD (  32.33  )
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

On Fri, Nov 14, 2025 at 5:15=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/14/25 05:58, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing  a zero to the sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - Only trigger if a 0 is written to `tls_configured_key`
> >   - Add documentation
> > v2:
> >   - Trigger on any value written to `tls_configured_key`
> >
> >   Documentation/ABI/testing/sysfs-nvme | 13 +++++++++++
> >   drivers/nvme/host/sysfs.c            | 34 +++++++++++++++++++++++++++=
-
> >   2 files changed, 46 insertions(+), 1 deletion(-)
> >   create mode 100644 Documentation/ABI/testing/sysfs-nvme
> >
> > diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/t=
esting/sysfs-nvme
> > new file mode 100644
> > index 000000000000..16aaf0dca9e2
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-nvme
> > @@ -0,0 +1,13 @@
> > +What:                /sys/devices/virtual/nvme-fabrics/ctl/.../tls_con=
figured_key
> > +Date:                November 2025
> > +KernelVersion:       6.19
> > +Contact:     Linux NVMe mailing list <linux-nvme@lists.infradead.org>
> > +Description:
> > +             The file is avaliable when using a secure concatanation
> > +             connection to a NVMe taget. Reading the file will return
> > +             the serial of the currently negotiated key.
> > +
> > +             Writing 0 to the file will trigger a PSK reauthentication
> > +             (REPLACETLSPSK) with the target. After a reauthentication
> > +             the value returned by tls_configured_key will be the new
> > +             serial.
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index 6d10e12136d0..7ff9a5053c3f 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -806,7 +806,39 @@ static ssize_t tls_configured_key_show(struct devi=
ce *dev,
> >
> >       return sysfs_emit(buf, "%08x\n", key_serial(key));
> >   }
> > -static DEVICE_ATTR_RO(tls_configured_key);
> > +
> > +static ssize_t tls_configured_key_store(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     const char *buf, size_t count)
> > +{
> > +     struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> > +     int error, qid;
> > +
> > +     error =3D kstrtoint(buf, 10, &qid);
> > +     if (error)
> > +             return error;
> > +
> > +     /*
> > +      * We currently only allow userspace to write a `0` indicating
> > +      * generate a new key.
> > +      */
> > +     if (!qid)
> > +             return -EINVAL;
> > +
> > +     if (!ctrl->opts || !ctrl->opts->concat)
> > +             return -EOPNOTSUPP;
> > +
> > +     error =3D nvme_auth_negotiate(ctrl, 0);
> > +     if (error < 0)
> > +             return error;
> > +
> > +     error =3D nvme_auth_wait(ctrl, 0);
> > +     if (error < 0)
> > +             return error;
> > +
> > +     return count;
> > +}
> > +static DEVICE_ATTR_RW(tls_configured_key);
> >
> >   static ssize_t tls_keyring_show(struct device *dev,
> >               struct device_attribute *attr, char *buf)
>
> Hmm.
> Now we are just running (re-) authentication, but that does
> not affect the TLS connection (which continues to use the
> original key). So you would need to reset the connection
> here to re-establish a new TLS connection.

Is the connection supposed to be reset? I don't see any mention of
that in the spec

>
> Also: if the authentication fails you need to tear down
> the connection (cf NVMe Base Spec 2.1, section 8.3.4.5.1
> Protocol Operations).

Ah good point

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

