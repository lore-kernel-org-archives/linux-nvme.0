Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CB5CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8mc7PEqKOdaKhhTWaiaacMdTM34oWGDw4sC0YwwFDk=; b=DWGSkf8Tc5B2tWd0XfkYVXZo6x
	CI2pr9+hDVTq54H9FHmKGf2T94xJ5+7haDhA/qpkd+bkGCIvgWyCkzimbD1dWgijOa76Em2/ts2+0
	vdM85HCVjNKmpqNYoUaXUPsd63tXxta4jZRr8z0ssa4YX8B9WLf6wEwAstalZ34p/YLanEAV2ZlaJ
	QX+j/MjZS4Sk/F59tGVhEUfyUj5CvrSI+pUdAmupFZ6abkC3msX9giMOqMav5YO9ZwHdBYrdOyYqz
	NmusHmYnvHK/3Dd3VyDF+vlRM9eNA+1O8Ud6IQeBEOLwlAlSEFGweMPBbKWCv8RYMDAvj89c2XQFI
	1StEPj5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBiYr-00000004bDl-41e6;
	Wed, 22 Oct 2025 23:48:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBiYq-00000004bDd-1Ttr
	for linux-nvme@bombadil.infradead.org;
	Wed, 22 Oct 2025 23:48:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=w8mc7PEqKOdaKhhTWaiaacMdTM34oWGDw4sC0YwwFDk=; b=LqrKk9q8V4rT+23nJsgwYYl5ws
	iUWvl0H/oyzvNbyL527018ul/9WixKeXlVCOlD4FPlf6Db4xk94Tk4gE9vip46qO9pX1h9ExCtrbY
	QTC86603H22B4LLyQ1ax9KlrH1fl/LhBWZrdyWjWWVNSm2bls5Fl24nbodgUUa/fspahzGeYNqm3V
	bA5KqsHRPVqvlVp5ICTM7KnRPwEzwlpx09ocvdKrIpwOf1dEJ4pE+XwaBEEjns6MY45wYewZPeUtq
	rxNE8hJUVbGj7m5kB1ZrOcOuHZsJ5XkgJA6inJqr2OynJ/CQ6ABIXVdgQYWdmuTL4hXLlphrtPVcq
	Ii9mlb+Q==;
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBhh7-00000000uuw-1yul
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 22:52:39 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso248460a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Oct 2025 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761176883; x=1761781683; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8mc7PEqKOdaKhhTWaiaacMdTM34oWGDw4sC0YwwFDk=;
        b=gw64zb4hkKmuvRgBW/dm3U5FkE5TjAjFmEHYd1jqrurI1YPwvs7Agd91BrDiEkV3U0
         eSLEMIHOQIzTcGbnsmHwXRf3zs7ziC5jRMix2UP8P+aHgInTsJyEUQnXdzxW7VkT9bpE
         WjFEAC/DqgQYs0YpfgkpBfBkJU7RSnj4mUFRIVbXrfZnxVe7EalLNyuWs5W+wcXG6NmP
         X5uBkrLpvUcS76mUuHiB/kPwf7tQFcBEU1BzvBK6mB1QNFiDoukI/2PP1E0X7Rq8izvq
         1Js3YqEI/WZt6hN+WGLw9IwtNwc5krfdbiAYwHdZLmgpE26QCdAkvCkoGhQnAM032B+w
         L7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176883; x=1761781683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8mc7PEqKOdaKhhTWaiaacMdTM34oWGDw4sC0YwwFDk=;
        b=WUleieMl7Afp1v/6i22iC5a9xe9EzeLIp/rZyLFMVjaFXZQR4lqc8M+GMmwyRiMPLw
         ofkkyIdXinBdNAAoswwJKhlwTm8UR0J2s6HFKVnyBK+D30DK+Wkdpuk2A2bFTL+xETYm
         ZCv8cWJw7OnrYNG6riKsZ/RYyEW1gUciZwMrSRELE7OH6pHaQzDfzIpkXx+RG12d2JYr
         MR24U37dO5EjzkOnmbBNYBtDOR19VzLV8DmbfxTNuvzIejzFPxXRzq/9BJQJmZgN+Aag
         zcRt8+OGUiq900OhBUv9IunH5tGcvToeQYVFW5tOGADbqkyQlt+ns5dBTBuH8eStBxAe
         lScw==
X-Forwarded-Encrypted: i=1; AJvYcCUY8RphNMiX7skhPr+tMUo5QKZq0s9twC48YuepwFOucvXqVCisX0qgOgitim/A8iZGLpqN1ppenTsW@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0wx2FPdg2voCp8a4KFkBzv+SnZmfxRSXnnp7tZyY6gBuNpSJj
	VSzBU/GEyQdJA7SUkFDOLGQZRHoqgm9bOd7/MupPZfIrcw55n5tCqQ28NchwU3Q7RSYp/qQjdjX
	J96yTcAjJtjG0vfecgVH6MeUBvH+vqgc=
X-Gm-Gg: ASbGnctsgDioF7P8BXKa1Y1sKipkJBdbM9htnQC2xL/vaPmyCFoqhRyhPO21S/Q94X9
	gwy02eBHS39dT/05f+SSAqltTKair1yw4R8JhfTUXNJlzmypsHw+GH0kkSPwz8IMLwh1HQycUgI
	b484hwWxUPubZORD4Bx5TTRQYfjuB7nSLzqFwf5d63PebGIGijXUQOeVyq1JQJlv77ytWiUOTL4
	f8e7ElSp67xY/KouxnC91MqzTa67fIZ7NA0BnzJJWYAzx3vsMudAbX8eGeQpQHaKXxPcF3VNzV1
	/jwOTEmdPxBZ160=
X-Google-Smtp-Source: AGHT+IFPvjCt3lhgdIMR/r39w4zk8tY3v7Ryh/JdZW1xA1CBJlkaCdErToOC3Wg0Fzc0bAc9ofaTJC6DzyBMlI3b854=
X-Received: by 2002:aa7:c958:0:b0:636:a789:beb9 with SMTP id
 4fb4d7f45d1cf-63c1f6dc078mr15321500a12.37.1761176882672; Wed, 22 Oct 2025
 16:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-5-alistair.francis@wdc.com> <e7d46c17-5ffd-4816-acd2-2125ca259d20@suse.de>
 <CAKmqyKMsYUPLz9hVmM_rjXKSo52cMEtn8qVwbSs=UknxRWaQUw@mail.gmail.com>
 <CAKmqyKNSV1GdipOrOs3csyoTMKX1+mxTgxnOq9xnb3vmRN0RgA@mail.gmail.com> <7afb2fc0-0da5-4539-a1a4-87360186cf65@suse.de>
In-Reply-To: <7afb2fc0-0da5-4539-a1a4-87360186cf65@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:47:36 +1000
X-Gm-Features: AS18NWAK6TMWNZNySx8pysumGySsDeNzwXFu97eObXc75NSy-iZ6pjnX1U1P9V0
Message-ID: <CAKmqyKPuESAp3nGJNDSw13_TnQLtfjSEAUdFyKrtww46ytJdEw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] net/handshake: Support KeyUpdate message types
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_235237_735099_A6737D3C 
X-CRM114-Status: GOOD (  25.92  )
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

On Wed, Oct 22, 2025 at 5:03=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/22/25 06:40, Alistair Francis wrote:
> > On Tue, Oct 21, 2025 at 1:19=E2=80=AFPM Alistair Francis <alistair23@gm=
ail.com> wrote:
> >>
> >> On Mon, Oct 20, 2025 at 4:09=E2=80=AFPM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>>
> >>> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>
> [ .. ]>>>> @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct
> tls_handshake_args *args, gfp_t flags)
> >>>>    }
> >>>>    EXPORT_SYMBOL(tls_client_hello_psk);
> >>>>
> >>>> +/**
> >>>> + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on =
a socket
> >>>> + * @args: socket and handshake parameters for this request
> >>>> + * @flags: memory allocation control flags
> >>>> + * @keyupdate: specifies the type of KeyUpdate operation
> >>>> + *
> >>>> + * Return values:
> >>>> + *   %0: Handshake request enqueue; ->done will be called when comp=
lete
> >>>> + *   %-EINVAL: Wrong number of local peer IDs
> >>>> + *   %-ESRCH: No user agent is available
> >>>> + *   %-ENOMEM: Memory allocation failed
> >>>> + */
> >>>> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args,=
 gfp_t flags,
> >>>> +                          handshake_key_update_type keyupdate)
> >>>> +{
> >>>> +     struct tls_handshake_req *treq;
> >>>> +     struct handshake_req *req;
> >>>> +     unsigned int i;
> >>>> +
> >>>> +     if (!args->ta_num_peerids ||
> >>>> +         args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
> >>>> +             return -EINVAL;
> >>>> +
> >>>> +     req =3D handshake_req_alloc(&tls_handshake_proto, flags);
> >>>> +     if (!req)
> >>>> +             return -ENOMEM;
> >>>> +     treq =3D tls_handshake_req_init(req, args);
> >>>> +     treq->th_type =3D HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
> >>>> +     treq->th_key_update_request =3D keyupdate;
> >>>> +     treq->th_auth_mode =3D HANDSHAKE_AUTH_PSK;
> >>>> +     treq->th_num_peerids =3D args->ta_num_peerids;
> >>>> +     for (i =3D 0; i < args->ta_num_peerids; i++)
> >>>> +             treq->th_peerid[i] =3D args->ta_my_peerids[i];
> >>> Hmm?
> >>> Do we use the 'peerids'?
> >>
> >> We don't, this is just copied from the
> >> tls_client_hello_psk()/tls_server_hello_psk() to provide the same
> >> information to keep things more consistent.
> >>
> >> I can remove setting these
> >
> > Actually, ktls-utils (tlshd) expects these to be set, so I think we
> > should leave them as is
> >
>
> Can't we rather fix up tlshd?
> It feels really pointless, erroring out on values which are completely
> irrelevant for the operation...

It's not that simple.

For example when we call "done" for a handshake or KeyUpdate we call
tls_handshake_done() in the kernel, which calls
tls_handshake_remote_peerids(). So the kernel expects the remote
peerids to be set.

I think there's a lot of value in re-using the existing flows (as a
KeyUpdate is similar to a handshake), but the existing flows expect
remote peerids to be set. We could duplicate everything just to remove
that requirement, but I don't think that's the right approach.

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

