Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CADFCCD19F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 01:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=; b=LzqikdFTLNjbrb+ZECuU0aL2N1
	7xV+HahMHmaSscK0IbTqgjejl8TCBcjjlaUGngG2f8BSmGWK/WisJ9xQlGj9RNQ1hKee/oDzGYSMn
	qx4hS7ziPBNAWk0O/s0WxmKw9UclzzA+vRDId/SKCA9f/PRmadqQ3kJJZG0m/TiAaIFskyCfOnVXc
	yEeUeGeEe7UKfTMJaAA/JaBhqNLH1F0H2QKcNNFfuvQ61tYQYRNhufzMiGz/gR6PAHJaQiQ6rUvRr
	fktbZnZ0pKUCmSOGgK8IsMX3jeGXHF8yEVyhgnOd5lhrdExltmYbnpzJfy2frkc1PJE0jMX7DxgyR
	dzyrX7+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB0lU-0000000FQCU-0s4A;
	Tue, 21 Oct 2025 01:02:16 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB0lR-0000000FQC7-2hJt
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 01:02:14 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b457d93c155so757121666b.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761008531; x=1761613331; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=;
        b=EhpjvxAcmHnRzLcyyod+ihEtOIjhgrVjaNZYYxyJypbct190fl3reFA/Q/PpCrAjQI
         pILD1JqZAOgZRbVOEl1XvU1eb8wngGwcCKYR2IKkF24f2iao23bgfpEY8M/+bqfYx0J/
         eq2+OAvKkWFVWF9hbtptotmT1aykuG4BQzAspGJjPMXphnoqo3s32mwdWPl6Hq+ak3xT
         WXWoBdrbcidh9ScXJ6HB7SpiPVySaAL/ze9x1dGgkDOfjbncGlhOL8vZMN5AYI3zP7y5
         qSTeXUoGvc189iRW2XSCjYuM1bar7UuJoMiR4cpmLPBOIOS1Z4YqWm86F1lcmnV8lpFm
         N4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761008531; x=1761613331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdrgppHkZAyxxVFGpYMxDncigVmTn7Xgn5GmJmM4fFM=;
        b=HnUg0CQ2GGdH0yXfE2E2kWI717oyQjwccoCQQTGpIuILVGiRHYAxD8RRAbyY0JJzzR
         zsw5fWlQWNYHuiwOLloGVysgrRbtX0+aPi3KYvO6YvWJEqaWkrwh16CzVQgWVGx5oede
         FmExQHj96PD1eQkRuPGFVH6C10ibSVPm7YJWgCbUleoyhbcqkKGYNJaw+lk8YQ9IGLNn
         JoEr9P/fThGNsl7BNfCsUN4759mMZ8k1QvUva2EwmuVQVCnFMjt95d6Tu2wgHgXbM6we
         T6CkqgbWrGlR229M2WcgRLQu88Jbkj/I2BxJRtd+eDOqhuJqBKbLzlEr1fFl69qK219e
         hYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuC+p99xI6iOg4h4D+TavsjgItGusKZ1N7Z2M38uXSEpgCjLbxaRoHBcCAoMYxgC7NA8E7LvlisM1T@lists.infradead.org
X-Gm-Message-State: AOJu0YxtZPQzMHp5A6yrrHO1Epq9nIMKl9aZwNuzx92tluUHh25Y73fB
	t9c9b7oN+3MzRMqGfMYxs/FlqQHormxV3AX3SfcStx6kiDoy0UH2ONKcsRKTlTLA6lWTMKTwwTw
	nN+CnwDi1cC0QPZmHG4bYwP6Ixs5+hPg=
X-Gm-Gg: ASbGncsLPVrSUIkZh81ooYqPnwgnFAPOQ4FJrwv9sAPagLAqj/iKkweorNR3QVvDlFr
	oMUoN6c408lZM+Ju13tZUSMVjCNb8JDWCCXjnFjYzeToZ/Yz7eDe6iR/P+spnEwTA6jdDF4IjJ5
	Z5/NQa05ClyVwxC3az/whDjvkO+YbuT2rCW6S/F+Bl7N7UmR2gOyAQ7Hk6CvDnp6/g6hbFZUqDo
	7bZSzApvsxLHsfJgsY6vqpJ7IvIzL8EpePRRyT30WhS1s0pUXK5TV5iJYksWP4ZcBbfiHQyWBJp
	dzKwvxm/pSC1hEo=
X-Google-Smtp-Source: AGHT+IEKUvPReN1WIc8WWqIkjL1j43sIvxC4HgtgT3kVUG9Iyo7fRBo0aTHcqpyZOi9DM/GsvtqbZf+qS2DkcF9tE4g=
X-Received: by 2002:a17:907:a07:b0:b3b:f19:ac7c with SMTP id
 a640c23a62f3a-b647443cef7mr1691282766b.36.1761008531342; Mon, 20 Oct 2025
 18:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
In-Reply-To: <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Oct 2025 11:01:45 +1000
X-Gm-Features: AS18NWDiepjJ-jRwTWQwDakRt00NDvcpR1iprtqV_ILiMUcAXQFVJU3hWPRHcZA
Message-ID: <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
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
X-CRM114-CacheID: sfid-20251020_180213_719979_15C6C5B2 
X-CRM114-Status: GOOD (  27.09  )
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

On Tue, Oct 21, 2025 at 3:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/17/25 06:23, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The TLS 1.3 specification allows the TLS client or server to send a
> > KeyUpdate. This is generally used when the sequence is about to
> > overflow or after a certain amount of bytes have been encrypted.
> >
> > The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> > can be sent by the TLS client or server at any time. This includes
> > when running NVMe-OF over a TLS 1.3 connection.
> >
> > As such Linux should be able to handle a KeyUpdate event, as the
> > other NVMe side could initiate a KeyUpdate.
> >
> > Upcoming WD NVMe-TCP hardware controllers implement TLS support
> > and send KeyUpdate requests.
> >
> > This series builds on top of the existing TLS EKEYEXPIRED work,
> > which already detects a KeyUpdate request. We can now pass that
> > information up to the NVMe layer (target and host) and then pass
> > it up to userspace.
> >
> > Userspace (ktls-utils) will need to save the connection state
> > in the keyring during the initial handshake. The kernel then
> > provides the key serial back to userspace when handling a
> > KeyUpdate. Userspace can use this to restore the connection
> > information and then update the keys, this final process
> > is similar to the initial handshake.
> >
>
> I am rather sceptical at the current tlshd implementation.
> At which place do you update the sending keys?

The sending keys are updated as part of gnutls_session_key_update().

gnutls_session_key_update() calls update_sending_key() which updates
the sending keys.

The idea is that when the sequence number is about to overflow the
kernel will request userspace to update the sending keys via the
HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
keys and initiates a KeyUpdate.

> I'm only seeing a call to 'gnutls_handhake_update_receiving_key()'.
>
> But I haven't found the matching function
> 'gnutls_handshake_update_sending_key()' in current gnutls.
> So how does updating of the sending keys work?

gnutls_session_key_update() calls update_sending_key() which updates
the sending keys.

When updating the sending keys we want to send a KeyUpdate request,
which is why it's a different flow.

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

