Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0676CAC598
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Sep 2025 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwxczvPwBg4Uyzbb2S+36YkOcrWK5ImeOLTlbGUhTaE=; b=bNcBXYEutl2fD/+ytaErDwI1WU
	2nWIdkJ2lsdwNyB+WMfc1FcoGehHcbcBOIkcLMsCbKlObRfJsYTI6QMMR0AGr797kY0x/Vf3JH1RI
	m5V16H0YJ4dXAQ8Y/OtoI7GhIpB2lM9VH8JaKRS7qk/Qsrj93oUFiXNwtahxgiYp3c+HbbZWGcCFF
	bE+zrfnzhcjJ2LZOua0GvLIuWrBj984pBc7zkcqhgdRJURTYqqzme0x0IDxsvm/IwHgWb/R5eH8o+
	X54xYmb++krN7Eoy9SW59v6tsl5fD7/ALsO0pkopA79mHPcm3q+1kqe4YtqYfKZSr31uGtBCsPtXi
	wNqdrB6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uypqb-0000000B3Nd-3LFX;
	Wed, 17 Sep 2025 10:57:13 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uypqa-0000000B3MO-0Ddl
	for linux-nvme@lists.infradead.org;
	Wed, 17 Sep 2025 10:57:13 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b0473327e70so499724566b.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Sep 2025 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758106630; x=1758711430; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwxczvPwBg4Uyzbb2S+36YkOcrWK5ImeOLTlbGUhTaE=;
        b=f37PQ3Pk08xos9WWst3G1D7Qw1zLkK037bebK7YOAzPTc+LozA/69EWPdZLkzky6xn
         TpMfjFInA7Ohnz69et8Ok/CbUqXRqeUiYEhIpNNfUuk0hZx1CsHayY2/GjjA91zB5P6p
         BruHTxcBCp9xSvPH4tl5hlYrl3Kkec6YkMfhgrWQlVw2jFyutZ7EFgI7eUlkq/9lSFcB
         HQeEwpm1I7KBhG8LjCYj2q1PgVD8MZ5+lT/hwixg76brAOzA3rWzEQzYmupVE8VSjKL6
         H1CMhzcVD3A41C5zsenrbOM0GRr7cqYfsR6XZcg5i2w/pjLVvCfPVmLtooX67NzlnzY0
         aXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106630; x=1758711430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwxczvPwBg4Uyzbb2S+36YkOcrWK5ImeOLTlbGUhTaE=;
        b=eKRSbZ1ZPiAunsjf/6HaYAYCAHe6OyZ9J3u6f2p++QBPOb42D9flC8tFwnT+VBSZXa
         IV/G0JkxoTEN09yp2A0FBX8ylO8Ld9hlKmynnA/hhpnV0iLWo9kR0bdj5O86bmEeSFo8
         H6+VR40kAY3fM7yIsRDk/hWYzhJITY0cGremPQ+/pGg1DeVHFzQs+KRglVRvcjWRW2kT
         02BP3NUTZcS3ao7jmRNATKnS13iCm23GsBQ2jS1N9aGB1zSzd3oto4iHeY88zg6oOyam
         Bb+u/JzMW0H9x3VmdwcMHWGBrZPJQlHxzAWA1QgQF/pr4s9ZZPyaguLJ46yhBxMxgcH9
         YNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXCgsQdQCKvXFenfJ3H1b55uJ33rPHcKsg3aTh2akMMJ3KjUIk58KIxteKSZDW4y6brr+ay7EAu68J@lists.infradead.org
X-Gm-Message-State: AOJu0YwoXNCVHGc9dzTlLOMKMbk2X7sDaYj/477tkTO2dexKARjzp2Rp
	48M918myPIpTiuk7k1FD7IcXmiTMgwqXVvmBlG/QGsvs3f16w35c2Ls5PbzaDJbt8bVdWf2he0l
	2yad8goWSBL4iKaSNkORdtD9ZaKZdphA=
X-Gm-Gg: ASbGncuxh4z7HSmgRmq4DsPgrLRQiGWqunAXrewKz0P/NbVVzOT9/qZwV+8IAFsj7Ub
	lco/qWddY4k0CZXhAtqtenWUFhpOj0LZIZmWoqygDs7u/+KlA1fp1uLnygyLqwWBx8u1ifF1KOd
	DDHW/frmch0t8tqnwsaaaiDjZZFmOBXH/2+hT2FhJ0xEdIT+BVbEKhNvq9pIEPBsx8PIuu8uOvD
	qHFIiX+NXmQpEGEt1hSsl8eNhdYN8co++9fmw==
X-Google-Smtp-Source: AGHT+IFRxj/9mtl/X+fIrakzsiy5Ocq5giy1UUqC3+OR/MDKcOd65B6+Mg4kPuXc5cy2Khkk6gzSVw2BB+E/UtAWaGo=
X-Received: by 2002:a17:907:3cc9:b0:b12:162:8347 with SMTP id
 a640c23a62f3a-b1bb2d0f441mr214182466b.16.1758106630039; Wed, 17 Sep 2025
 03:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-7-alistair.francis@wdc.com> <f1a7b0b5-65e3-4cd0-9c62-50bbb554e589@suse.de>
 <CAKmqyKM6_Fp9rc5Fz0qCsNq7yCGGb-o66XhycJez2nzcEs5GmA@mail.gmail.com> <e168255c-82a0-4b9a-b155-cb90e6162870@suse.de>
In-Reply-To: <e168255c-82a0-4b9a-b155-cb90e6162870@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 Sep 2025 20:56:42 +1000
X-Gm-Features: AS18NWCp6hE9_gHHY9RNWcNThlN_Ck6Xfvl_Pbkl6uhBvEylonTEL18YHTqIeJc
Message-ID: <CAKmqyKMLP7hOi4FNhBET9XfoNZv4MZ3OsSRA0=B42C3+Q7P1jA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
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
X-CRM114-CacheID: sfid-20250917_035712_105690_8A3716A7 
X-CRM114-Status: GOOD (  31.67  )
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

On Wed, Sep 17, 2025 at 8:12=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/17/25 05:14, Alistair Francis wrote:
> > On Tue, Sep 16, 2025 at 11:04=E2=80=AFPM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>
> [ .. ]
> >> Oh bugger. Seems like gnutls is generating the KeyUpdate message
> >> itself, and we have to wait for that.
> >
> > Yes, we have gnutls generate the message.
> >
> >> So much for KeyUpdate being transparent without having to stop I/O...
> >>
> >> Can't we fix gnutls to make sending the KeyUpdate message and changing
> >> the IV parameters an atomic operation? That would be a far better
> >
> > I'm not sure I follow.
> >
> > ktls-utils will first restore the gnutls session. Then have gnutls
> > trigger a KeyUpdate.gnutls will send a KeyUpdate and then tell the
> > kernel the new keys. The kernel cannot send or encrypt any data after
> > the KeyUpdate has been sent until the keys are updated.
> >
> > I don't see how we could make it an atomic operation. We have to stop
> > the traffic between sending a KeyUpdate and updating the keys.
> > Otherwise we will send invalid data.
> >
> Fully agree with that.
> But thing is, the KeyUpdate message is a unidirectional thing.
> Host A initiating a KeyUpdate must only change the _sender_ side
> keys after sending a KeyUpdate message to host B; the receiver
> side keys on host A can only be update once it received the
> corresponding KeyUpdate from host B. If both keys on host A
> are modified at the same time we cannot receive the KeyUpdate
> message from host B as that will be encoded with the old
> keys ...

Correct

>
> I wonder how that can be modeled in gnutls; I only see
> gnutls_session_key_update() which apparently will update both
> keys at once.

gnutls_session_key_update() only updates our keys [1]. You can use the
GNUTLS_KU_PEER flag to set `request_update` to update all keys.

> Which would fit perfectly for host B receiving the initial KeyUpdate,
> (and is probably the reason why you did that side first :-)
> but what to do for host A?

Patch has been sent and reviewed, just hasn't been merged yet:

https://gitlab.com/gnutls/gnutls/-/merge_requests/1965

>
> Looking at the code gnutls seem to expect to read the handshake
> message from the socket, but that message is already processed by
> the in-kernel TLS socket.
> So either we need to patch gnutls or push a fake handshake
> message onto the socket for gnutls to read. Bah.

Correct, patch is pending (see above)

1: https://gitlab.com/gnutls/gnutls/-/blob/master/lib/tls13/key_update.c#L2=
45

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

