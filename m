Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C36CCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iiTjJNto5b180B3ollqzmYVOhF8fUFEDZCeDW5FJ6nM=; b=WP/YZAh89637WYp6tzFF6JEWGk
	i15cFvXcKVCfAKapbgTSr4bJgFvAlYvHACqM9Ol9iEMLtvJPe7tIlo3p0Acu8mSMd+P23kAikUVkP
	I1cV+ZAVey2u8ljkiZRRQXJ4s15lUb5y8tLhxSC2F6n/t9O+QItKtqwpoiNptR8Js36tZ5lShT27+
	Aa/VLTMdZ7hg8HXgMVhydcDdxVd6xOJsKuT3ryln3Ko9k+cU/iVeLQ0y9q+/yXmGtkc1QS/WJgpFJ
	LPYVdQKg462PpceKNBafuK5uCcjouXOgnDyRoz0lBq6W0RCjXQGcqKeydJKJFn+nV6+BgCiI4JSWg
	T/DU13BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjfn-000000091iY-0gOy;
	Mon, 03 Nov 2025 01:47:55 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjfk-000000091i8-2HVm
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 01:47:53 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-63e393c49f1so3539111d50.0
        for <linux-nvme@lists.infradead.org>; Sun, 02 Nov 2025 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134471; x=1762739271; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiTjJNto5b180B3ollqzmYVOhF8fUFEDZCeDW5FJ6nM=;
        b=kDN1F7fGHAjU7X3egTsUwsrAg0URZ8kdcch4r8/fZolRsyZL2m3yK3fbqp/q5xeXiH
         PYLlqoLsCRCq8YRPQYQLlDODm+7HhyX9pEAp/BWMXs9j3GSNHIWsIhD2htLauYfGzzUL
         h9wQAvv+dIJmzZ3AqCOsRTvyiHQWOtT5xxDy0770TzepPqxsgo6XafN54ZOQ1jJNzCWI
         cZJVdEzqVfQYNohPzhgvhfqtDrxVvBbzKP0TmWczSac+U0LQW9oKZIdlB/VzKvkoJi/T
         eweMoBJLARM/4epqtUd3qmCcewapFiFvhgTaJMfHnck4XG0Qjb7yE1kJdwPq6yEkhzQ2
         Kp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134471; x=1762739271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiTjJNto5b180B3ollqzmYVOhF8fUFEDZCeDW5FJ6nM=;
        b=MqQiDTIdF7/ODrDSz9xOMos4DU/nNFOW1KboGXOsF2mnduP5NuLe86LKK6jaNPZzcL
         CenFJpI078MeblvB6CpOL7ik1tygCNaYgj8erMmBT3MqDO2xmaJHUYaY9bO2qGjOS1nf
         +V/gC7ScldNou3VwnAz8Y+P3nj6q4D3jB0QmQ33LjPcUTo9QdGaeUImYRYfFxleOGOm0
         1TyHW4HcuN7hIGo9v9Hh/2gmEyaIEsykgDnyKjpf0oZ4gBQlpS09gyLKlBdBtJ9Lvvpa
         U7ss/O+52j9W6mWurWVPGU56XLPn7G4lvq9S2WWGK6keeUtTkwS76ozv1KfEn1ED22UT
         8fkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/dyIR5+W04qfIaL7t/YmpASB0tkBbNAVKyofqlnyEk2jDcgN+0+NIlEyEQ4fAd/dCCUMk+762isfE@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7zhYuNsD9/lCp+fMBh/Tc012tptIjL2pVOTi5hhKGj7w9V+wV
	/vmJC+DREbeYc3DX7RVm1AOc1zQrZS5MI2WOiibAviNINWaua5/dsy7jcGTJnN0G1B6LzvO/hRe
	In0cYcJ5QDMYiE3QyBU2zHte8a9f7UPw=
X-Gm-Gg: ASbGncuHqzGSO5E7kDPmOqwtWV+ChUddb1aR4vKpJ1ynod45TtTjYZaJu0/Ruy7bLWY
	NgUvAMKQamHZk+bryzSkHSs25rd38FMc9Q5Otu4vnlQTOnjrL4hGWf7/HcMC6491PmPZ1Mw+O+r
	bGBeVQgWVjDbz+WvDeHxo0jfwZXdNdBO2ssywVQ/H6Kr4chGWEFI0/t1unmjif4bQCa9G6Y/fYr
	di3fUUL4kOXHWXHDi7pJTOQvl/8e5yuDDtDt6tEX1UxkzNpux1PgbiGXdP2aYuIKjsoGtZbuwdS
	GVHAAbkRnZfHU/ZH6KnhJGPaJw==
X-Google-Smtp-Source: AGHT+IHg3lV1tdMCqLOA4qQhZkQr0Tb0A3ETymH2M9xcUgAC/jEFPsBSuTrEOCTZ5597TZoN572CBcmPgfOPlOu5mOo=
X-Received: by 2002:a05:690e:1518:b0:63f:b082:4d5a with SMTP id
 956f58d0204a3-63fb0825418mr2711835d50.57.1762134471396; Sun, 02 Nov 2025
 17:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <20251031140541.GB17006@lst.de>
In-Reply-To: <20251031140541.GB17006@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 11:47:23 +1000
X-Gm-Features: AWmQ_bmAc1hVM3wcde6ERYGL7zprBagyx13YvD6LBE2RcY5YlTixr9EGWA5Kzqk
Message-ID: <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, hare@suse.de, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_174752_611450_73E35848 
X-CRM114-Status: GOOD (  16.40  )
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

On Sat, Nov 1, 2025 at 12:05=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Oct 30, 2025 at 01:51:14PM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing the queue ID to te sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> >
> > Note that only QID 0 (admin queue) is supported.
>
> Why pass the queue ID then instead of a boolean value?

I liked the explicitness of passing a queue ID instead of a bool and
it allows supporting more queues in the future if that changes in the
spec.

I can change it to a bool instead if that's preferred?

Alistair

>
> > +static ssize_t nvme_sysfs_replace_psk(struct device *dev,
> > +                                   struct device_attribute *attr, cons=
t char *buf,
> > +                                   size_t count)
>
> Overly long line.  And very inefficient annoyoing to modify indentation
> compared to:
>
> static ssize_t nvme_sysfs_replace_psk(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t co=
unt)
>
> > +     rc =3D kstrtoint(buf, 10, &qid);
> > +     if (rc)
> > +             return rc;
>
> Nitpick, but nvme style is to use the slightly more descriptive
> error and not "rc" which doesn't mean much in general.
>

