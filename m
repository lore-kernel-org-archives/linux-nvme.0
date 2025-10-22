Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8431CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=; b=wagLJz9Tjd53mqFSNBZAfalVbd
	R+r+b2qQ1/3ZkL4Ht6yKaduO2ZECym5nY+SYzXMg+7ekCjTBaE0GI1CHGRGFlyzGM98GUGsy2jbll
	OAwAB9yCG6lNbHNVEHPSTpINnQeRZ+PlpNyoHy2dEdJuYvEApxIaFsDfyEn1fKAd/Wh01RW7quVev
	CUCWGgxl3iJKJOVhkwvx1TO7CG/zZw7fF5Pi4vFlFliw/r5t6mubHcIfXAq9rlhoGT47QfiI0FpSX
	vNUWJddXL+VRRa4bALnc+tleeieTV3PhSBWUDkx2Alz8NchCgVABGvBJxa7Z9Ny/oyi7FYfMB8Xvh
	LdjfCRmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWpn-00000002cF3-2whH;
	Wed, 22 Oct 2025 11:16:51 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWpl-00000002cDy-0rVB
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 11:16:50 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so8608823a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Oct 2025 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761131807; x=1761736607; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=;
        b=aC+a+pDZtK7i8XPMFOKwHtIzhb1z9l4X2BxBQhsAbe67KIBr9tt9E05O0KHWoyI6kL
         MpIDi8wESeT8vTs/oaAYDjwP7w0jujDBiVAl/7fbZU/XnsJONNab4xBC0IuoyoGUgQ+H
         s0Y5bIi7rUYgOVWqO8yg629U3cL27NLrGiqVgqJ2D/EK8l9aAQIaCWollloiOu454C7W
         gWwy+d/nn3MzB/33375egXP/R+69hxkDAA8pLI1Vou1Wzzezn5etkxa2uVajGswToQtd
         4hKkuwmcvXDstE0psu9m4JhF0uiSLb9did+/wDcJhES1MGyD7hirkGK4zq8bujdxp5UH
         q/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131807; x=1761736607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=;
        b=WPMMMpuRPEfZNwF7xmCm7n+7aqLuUjGwp4fWlpNPQ9lQup9dQSYaDAOJA2clJbLKV5
         maZmeLCXUBBobDnEEuAZKxjgLYcz81cF7WkrEewR6rQlTM2aeszCLdF88XAVo5+FndBZ
         L4HEAdqKmE92cl2dMY6aix6QGAfctN3gNYuJ+Cdszcf5DFPuvgSnBeHqXo0A6vRg/F/q
         4lVr5LoSIJKdjVxJcpCSqADeAF8qsUDgBoNzU2/EDwBCzLlDQ9nh6aewT+LNO9UCNMGG
         fMHavZJYvcohPZBO7KwwxMldB3wA+OHW8+Ly92xiPc3p9sFjk3ehTvwXrsiTO8gQnYXr
         1y7A==
X-Forwarded-Encrypted: i=1; AJvYcCVTXsL9n/2ooUlREWXh7WiPMe5EmdHQEAP49oMQZnNzTWXWkFiWyJkUhmx6PXhvsMajVIZ5DYaEJ6ro@lists.infradead.org
X-Gm-Message-State: AOJu0YxKgyliHLkKctMkaQh24XrsfTyqY290jNZk97EbkcgLnU21Nldn
	I3aroCddu7pYD178dQQ0dmU0GUX+18e0U7jcCaBOK81btlll4vVocx3AAROF3nF5J04z1S8gPHH
	MhG4O6RM+Q+t5Arxb58ge+OQxEx6UKdk=
X-Gm-Gg: ASbGncvxYklFR2e59zHd7tIwhRTC7jLFoC+r5WXNvNUIgUBnk8Bo//9KZGCF204HJpl
	EkjJsRygIbHm+WQ0Vc4z6T/S5co3B538wQ+snY0LE5i2KldAkhdGNBXARIgGAwu7rzu7v2BAmGu
	cWdUH+U9XUrHdFkdwhNGJt+qaoJrL0ETapp6yRLDL76rglMImIyqxhlZ3ThGeQ7G2rXAWXti0PI
	ycWCQxKAIKRykHQ7CK8xwdgORK3/9qrt1GIWCQai6wi3ngZtN+qSvqiXlxGueI2fH3pvwNcXzE2
	FLnQzFQ+nFxkWDHCOBnfMXO9tg==
X-Google-Smtp-Source: AGHT+IFeLMsqZpbHAvlJBzKIdahXOOBShjYQZyOY7ATbt5n7WHdXXR/ON08TB4hturxLMLEB0GOq3i/bLAd52DC8p3U=
X-Received: by 2002:a05:6402:13ca:b0:62f:8274:d6bd with SMTP id
 4fb4d7f45d1cf-63c1f626dd4mr21176233a12.8.1761131807215; Wed, 22 Oct 2025
 04:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com> <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
 <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com> <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
In-Reply-To: <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 21:16:19 +1000
X-Gm-Features: AS18NWBDgW-hay2VUeCdIjfUCzoI0NhxABO1jEUfCaPHUmJ8eBnU71SyICyiPWc
Message-ID: <CAKmqyKM-uX6_a+Ru01RD3-CwoucTN7P_sU+d=MEKSo2pxG_tDA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
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
X-CRM114-CacheID: sfid-20251022_041649_272909_57759FD2 
X-CRM114-Status: GOOD (  18.37  )
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

On Wed, Oct 22, 2025 at 4:56=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/22/25 06:35, Alistair Francis wrote:
> > On Mon, Oct 20, 2025 at 4:22=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> [ .. ]>>> @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void
> *data, int status, key_serial_t pskid,
> >>>                        ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >>>                key_put(tls_key);
> >>>                queue->tls_err =3D 0;
> >>> +             queue->user_session_id =3D user_session_id;
> >>
> >> Hmm. I wonder, do we need to store the generation number somewhere?
> >> Currently the sysfs interface is completely oblivious that a key updat=
e
> >> has happened. I really would like to have _some_ indicator there telli=
ng
> >> us that a key update had happened, and the generation number would be
> >> ideal here.
> >
> > I don't follow.
> >
> > The TLS layer will report the number of KeyUpdates that have been
> > received. Userspace also knows that a KeyUpdate happened as we call to
> > userspace to handle updating the keys.
> >
> Oh, the tlshd will know that (somehow). But everyone else will not; the
> 'tls_pskid' contents will stay the the same.
> Can we have a sysfs attribute reporting the sequence number of the most
> recent KeyUpdate?

Why do we want to reveal that to userspace though?

Realistically it should just be ~2^64 and it'll should remain the same
number, even after multiple updates

Alistair

> Cheers,
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

