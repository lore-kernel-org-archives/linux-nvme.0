Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D5CDB47D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 03:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7t2DoNtcV24/ozxexHncGakDm5oHzVicZ0DjyBh3Gc=; b=xGYH1apkRH5zlo2EmItdYZ4i9p
	2hsLvl9kZtwzGIip+v92oqc2AYOxDKktPvCeRtO3yWaK/cyec0wGRXgXUBP6BDEzsWGe6b2CWX1A6
	aU4cOken3P0qDTOICRPe84c08Jq3mKP+9Qte2hR7bl0/U7zrJVKxSTppgsvpOtzEztJAxFJVYbMg0
	qgHoQaRbEFrNxAiftU0m+bQjA7MfOXyoKDae7JXebB71hSSOuwvUaDZEPsD4VF015ZXSaG8ehNmLA
	2hi0me048MaDsCXh34twJqERM8KvYHpc4YbOicK6FsmkT+swBQf2NVZ8dyykGCPrcBVeqUiiTQZL0
	TbH5hlXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJkmn-0000000BVXf-0xF3;
	Fri, 14 Nov 2025 03:47:45 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJkmk-0000000BVX9-0gje
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 03:47:43 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-b735487129fso219543966b.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 19:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763092060; x=1763696860; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7t2DoNtcV24/ozxexHncGakDm5oHzVicZ0DjyBh3Gc=;
        b=PuXSpgtTERFQuEUATZ5HUcgyBJ7XwKd60q8o8YnhDQkaBDG5r4qxo79248841d3Af6
         beTpOlRPj3G9XWcK+bq9TODvbK902LPwzSWWZpsbNghxwQKU/JFrxx89mGDd47rQX5e8
         GdrezT4SnzycXvO0dGfbmmcO9DZBgExFDF3j5H3RWCczCVoLreivvlU5NPAXip+/9+Nw
         ppaq8D4Q1HWB42egX5QNakwOTVdLMsTUIfuVm9z4+/kKt2l77V9GpM2wb0fqZSiOhQpf
         4KlHTBJkCxJ77Oe4dpCsDFIdmAxkkRliNUKOj+aa/JfvA1dWkHajbDtxHI5FCYLHFm+S
         nFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763092060; x=1763696860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l7t2DoNtcV24/ozxexHncGakDm5oHzVicZ0DjyBh3Gc=;
        b=UyUvUimJW/MrURYTfuBZUAc5/QnHJkkCGKFsUxgTFXdtRqPUx2aZpL9htQAvAlHaHT
         +4A0OAYuhOIW6kOzIYv+MS4FQ724FNEkSiR7msd8w0uQX0KMiraVY1MiQa3/TXGJ1EAm
         kffBsXVGIaBFws9PU8LjERuXHiEbM1gw5Ly3qO1wGZ4Xx0NpiSQ4pULFA6FXEx0zW65B
         l+dbU5H/pzcRpRHKFIpXdKv0AvvP17BM6HzQ2t2di1yEP2rDMXojLLH3KxcqQY7HwlK9
         NNRyotyw6STR2rmM+nirpDl2yFZjDPXV/K89/9KXb/I7rj7BlSqmYGubs7T7AHdFfdOL
         xq4A==
X-Forwarded-Encrypted: i=1; AJvYcCX8oUQSbcm5SFn5oPa58CByExRiX5elNHLsTphA3zE4Eu/Ti/C/AK7q0E0Ulf5xVQyCl+NPB8bcKQAM@lists.infradead.org
X-Gm-Message-State: AOJu0YxywBG1JnMkxCT5XBovU1iI+9mS5VdoHtYBALSFiexSI0oZO343
	J44mBh/tdsmpUsba44y/XkHaavZ0NG/NCvzp7+SvB9cjlVl8qyBZ1yw2UkWQk9h/GJupdFA69oy
	Tew/dOCuaRx/fDriwNVxWqtqrFM/38B4=
X-Gm-Gg: ASbGncttFf4gxK+oMjQNykkPexkmHpTqhAS2/fFXgWZp5x0KoUO/Zi6rDxFwMkO0znE
	yWWmGWE/FU93aU5Duz4IZAFDSaxg1s+OTJiE9CHGyS2jokjcxfZDicdrAHQJ84VBJ06R/jzXM8W
	VwStxStpmCIGjeZjqMSUTmQmF/zLon8rfDk70oPw4Zj5yESzsFUj2LAQqPj84tScVwzatIMkMlU
	AZIR/VuEKS6zKxR24qTxSRzBtf9FMC9W9WxMM4d4p1WHcy4er+ET4UCiGymWHiAMpaG8gHq8Xkt
	ngZWe0WTYOoPHZc=
X-Google-Smtp-Source: AGHT+IF5PRAiYYpUTpCzEfNDz7NRiU+jv//r2Jm9Y2s7ebq/lV+2kfZao0nn9vu8AlHKq7GySSaXI0Ri6JKvx8DRr+o=
X-Received: by 2002:a17:907:da9:b0:b73:222b:4c9b with SMTP id
 a640c23a62f3a-b736782c55bmr142894166b.23.1763092060042; Thu, 13 Nov 2025
 19:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com> <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
 <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com>
 <2019e372-c079-4230-97ba-a3299ced0474@suse.de> <CAKmqyKOBr2eV6AeWH6SHz_UX4ciKgdf3zGJ9LMHEOuFz55kO+A@mail.gmail.com>
 <11987de2-b1ae-4a80-ba16-bf6c795bc1e2@suse.de>
In-Reply-To: <11987de2-b1ae-4a80-ba16-bf6c795bc1e2@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 14 Nov 2025 13:47:13 +1000
X-Gm-Features: AWmQ_blOhDECOlF0c9hmXCLOUmRQYGpjGacDgZxEDbOD4jIZz8TfTaTfj4GdBHY
Message-ID: <CAKmqyKOtg9EE-hUCw_g9W10BfoHjsEZnYaum1r9-F+h2S=nurQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_194742_228994_07600C90 
X-CRM114-Status: GOOD (  41.16  )
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

On Thu, Nov 13, 2025 at 10:45=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 11/13/25 13:22, Alistair Francis wrote:
> > On Thu, Nov 13, 2025 at 5:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 11/13/25 03:08, Alistair Francis wrote:
> >>> On Wed, Nov 12, 2025 at 5:08=E2=80=AFPM Hannes Reinecke <hare@suse.de=
> wrote:
> >>>>
> >>>> On 11/12/25 00:45, alistair23@gmail.com wrote:
> >>>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>>
> >>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>>>> ---
> >>>>> v2:
> >>>>>     - New patch
> >>>>>
> >>>>>     drivers/nvme/host/sysfs.c | 2 +-
> >>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> >>>>> index 29430949ce2f..6d10e12136d0 100644
> >>>>> --- a/drivers/nvme/host/sysfs.c
> >>>>> +++ b/drivers/nvme/host/sysfs.c
> >>>>> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struc=
t kobject *kobj,
> >>>>>             !ctrl->opts->tls && !ctrl->opts->concat)
> >>>>>                 return 0;
> >>>>>         if (a =3D=3D &dev_attr_tls_configured_key.attr &&
> >>>>> -         (!ctrl->opts->tls_key || ctrl->opts->concat))
> >>>>> +         !ctrl->opts->concat)
> >>>>>                 return 0;
> >>>>>         if (a =3D=3D &dev_attr_tls_keyring.attr &&
> >>>>>             !ctrl->opts->keyring)
> >>>>
> >>>> ??
> >>>>
> >>>> How can you have a configured TLS Key for secure concatenation?
> >>>
> >>> I'm not sure I follow
> >>>
> >>> `ctrl->opts->tls_key` is directly set at the end of the
> >>> `nvme_auth_secure_concat()` function, so it will be set for secure
> >>> concatenation.
> >>>
> >> Right, sorry. Of course you are right.
> >>
> >> But I'm still a bit unsure about the interface here; just writing
> >> anything into it doesn't feel like the correct way of doing it.
> >
> > I'm happy to change that.
> >
> > I was thinking a bool, so basically write 1 to trigger
> >
>
> I would like to keep the interface consistent, so as it's displaying
> a key serial number it should also accept a key serial number on writing.
> (Or '0', which is 'invalid key serial number');

But you don't know what the new key serial will be

>
> >>
> >> I would rather modify the interface to allow a key serial number (or 0=
).
> >> That would allow us to modify the configured key, which currently is
> >> fixed for the lifetime of the connection.
> >
> > Wouldn't a configured key (`tls_key`) be changed via the tlshd
> > interface, not writing a key serial to sysfs?
> >
>
> We would need to figure out the effects of REPLACETLSPSK with secure
> concatenation.
> Clearly for secure concatenation the resulting key is generated from
> the secure key material negotiated during authentication. So the only
> valid keys here should be generated keys, not persistent ones.
> But in order to have _new_ generated keys we need to run authentication.
> Consequently the key serial number can't be known when starting a
> REPLACETLSPSK operation, and we need to write '0' into the
> tls_configured_key attribute to a) reset the generated key and b)
> start the authentication protocol.
> That will then generate a new key, which will be visible via
> 'tls_configured_key'.
>
> So all good, methinks.

Ok, so trigger a REPLACETLSPSK when the user writes `0` to
`tls_configured_key`. I can do that

Alistair

>
> >> And writing '0' would reset the configured key, reverting to automatic
> >> key selection.
> >> Having such an interface would actually be beneficial, as it would
> >> remove some limitations from the current interface.
> >
> > Anyway, I'm not sure your vision conflicts with allowing "write 1 to
> > `tls_configured_key` to trigger a REPLACETLSPSK"
> >
>
> Please don't use '1'. As mentioned earlier, I would like the sysfs
> attribute to represent entries in the keystore (by displaying the key
> serial number). '1' _is_ a valid number, and so the interface will try
> to lookup a key with serial number '1'.
> (And failing to do so :-)
> '0' is _not_ valid key serial number, so writing '0' is equivalent to
> 'disable that key'.
>
> Cheers,
>
> Hannes--
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

