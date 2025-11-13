Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CDACCFA18
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 04:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ruk0C/2CNClZ5Kv+8DN1BbjisIWDyvg1zZIhMP8jZGE=; b=4hvFIc51K6FytYK4LYOkJUFYp6
	lpwVTWRw09Kqj3j4CmJ1gD6CiVM3kVymqCnIZoHalmyjAptVkS4GHBN6ruSMHK4Tam+mBcW8KXjpb
	eFHtkE11k9BPnLHnkL95DPFy396sUvOXbQU5OfgJZDiwar0T6wCitfshi1+EKwcjp/FzTOBKYX5oB
	nUVL7jjwpo10QEYUAbRWDLBrKRfV7ScAfitHBOr3ppg/O6hBBuyVFZjfl09+WsQF+aerWTq0NyhRD
	IUHY15CItD05FZQo1JXrybBsszprTpDbtpKooDv6LaLwq/Da0CMA6tTAGY6+pMVl1ZdIgLFhHUdw2
	nr0ilFig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJOX3-00000009ro9-3a5q;
	Thu, 13 Nov 2025 04:02:01 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJOX1-00000009rnm-1lr3
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 04:02:00 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso492208a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Nov 2025 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763006517; x=1763611317; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruk0C/2CNClZ5Kv+8DN1BbjisIWDyvg1zZIhMP8jZGE=;
        b=LdTZkGV51kMPcoUQm/S4nwldXeP7J/CurM8zYnQGa4Zm9hct0OQdQh+UGg/qe7yL3h
         mbmh7wV3Yu1T7IEI2WfWPyG+R46pcs9EvFEmRF0f3CivMHZLzRXe0GWqiNBUzNYJhsu9
         OOJ3huXOJUoO5Lz0SZkkqtAdPf1M0TunQ0i59QkW1GPLBW5c3rsietMxPnL8DgJXf8yJ
         sTU0fWQgyNdR8+RqVmIeGUHjKqTCVP0RSwUDy+XoXJNiOEs280EgiU6JWSUAoBOSL1yJ
         yz53RNSJ5xAjtMBBHxp/l9B/FIvAIOedXqPPEZxfRAwWBS8/CHWsgmpL4owM8ntAOblV
         KrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763006517; x=1763611317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ruk0C/2CNClZ5Kv+8DN1BbjisIWDyvg1zZIhMP8jZGE=;
        b=JgnaF4l3j6v1Y46+Ep53oZVEBwInzIG7tn2NkOq3UdBJhWy+iKiD94a6VQ/E0RJlv4
         471Wl2zSeOZcYg9MrtZMRPVDkXhek1c42zBCKBHoPnlwSxbMmFET8ZxhYGe1ev+qBitF
         xjCGjuY4NtGRibaY1Qld4yoprwgjMAl+tccAtW82XmZtrqwL6B+38IY7whw8360V0fPZ
         l24PTND58VllbjxQ32/2aXkAm25WyDWX9zv0tfpPx3PsUYDsE+sUch3XyrqRd6pqjA20
         +AgQyQTmsLZUKTHok5VIslw0ChQyDe/8PSSzgvXRFmnsKja/1R8KxQ7+4/6B1Yq/RFSn
         bJDA==
X-Forwarded-Encrypted: i=1; AJvYcCUpbmraHbRVHFnv/nkfQnVTKZwGI1NRF15D4JUftw4TQhNJhSzv7nzRLyRivQL+BS3izIrWB4GigCLt@lists.infradead.org
X-Gm-Message-State: AOJu0YzvK4AwhCZMoRpuwdknw+dV9geHMFHo2E/b0YzuOnFOSe5qRMGJ
	bRGoZmR3UQzPqTr7zmKFv9S8kA72Am4vWd5oFoXoYw0tgVvgG0zNmZNG048XQXZAJ/kEaxUuRBc
	ERXX+UFxqbYf+a9zcsNBVT57N18kGOd4=
X-Gm-Gg: ASbGncu0K57C5I/RnJAmxwDPAwYDa93KsfiOF1DAVvQZaBo3s2yqCoeEcmOoBvFycDo
	WqUEbf8aUWN6YBY0IL3eYHO2OERDD0AqWup+g0rRNWCG3KpXs9+yxxVQklC29cdZ+ICXhJz1Qik
	xpTNKZQqpmsWr+02V3SjgCYrAkcSiMAesnViugD+DwxLMe2Aj+djca/Q88O9kuLIGZQF+bBTxgL
	o374WeSFBsSxaK/riOONOXd7oe1LQVnshP49hHTCQk4YeDA6mYDcGSG/hqLjt0866/Q3ajsEg8k
	FLpDErZYRkqha/Y=
X-Google-Smtp-Source: AGHT+IFXLl7x2uJRLoXlx277Si5mBM8h/gS1p+bZUwni/MfCDjn87uckvcbYakQIrBl2+ZQGH9ohDAV+xs6EuIVqfj4=
X-Received: by 2002:a05:6402:510e:b0:643:18c2:124e with SMTP id
 4fb4d7f45d1cf-6431a392eebmr5125372a12.7.1763006517205; Wed, 12 Nov 2025
 20:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
 <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
 <20251112070256.GA5276@lst.de> <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
In-Reply-To: <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 14:01:30 +1000
X-Gm-Features: AWmQ_bkICN55tPuzDm6zLa1MtEfNqZymtOObpTTa8T2RNOSB_QTCazWXu8t0Tv0
Message-ID: <CAKmqyKNZj6gwPOBrjRk_vTJqpUTPTsHF5S0iQPgVPi4+NHP7uQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_200159_505265_04376556 
X-CRM114-Status: GOOD (  23.61  )
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

On Wed, Nov 12, 2025 at 5:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/12/25 08:02, Christoph Hellwig wrote:
> > On Wed, Nov 12, 2025 at 09:32:00AM +1000, Alistair Francis wrote:
> >>> I would suggest just allow writes to the 'tls_key' attribute; any
> >>> writes to that would trigger a replacepsk operation.
> >>
> >> I think the `tls_configured_key` is actually the better attribute to
> >> write to as that is the one that updates after a REPLACETLSPSK
> >> operation, see v2 patches which I'm sending now.
> >
> > Just saw Hannes reply here and saw why you did the current version
> > the way I did.  Hannes, please don't recommend weird ABIs that
> > make error checking and future extensibility impossible.
> >
> Hmm.
>
> 'tls_configured_key' prints out the value of
> ctrl->opts->tls_key, ie the key passed in from the 'connect'
> string. Normally this value will be empty,
> as the 'connect' command will pick up the TLS key from
> the keyring automatically.

`tls_configured_key` does print out the value of
`ctrl->opts->tls_key`. That's the key that is generated in
`nvme_auth_secure_concat()`.

`ctrl->opts->tls_key` is also the key that changes after a
REPLACETLSPSK operation. `ctrl->opts->tls_key` is what's used in
nvme_auth_set_dhchap_negotiate_data() to determine if we should issue
a NEWTLSPSK or a REPLACETLSPSK.

So `ctrl->opts->tls_key` (and hence `tls_configured_key`) seems like
the way to go

>
> 'tls_key' prints out the value of
> ctrl->tls_pskid, ie the value of the _negotiated_ key.

Is it possible you have `ctrl->tls_pskid` and `ctrl->opts->tls_key` mixed u=
p?

`ctrl->tls_pskid` is set by userspace via the nvme_tcp_tls_done()
callback. It's really more of the "configured" key as it's supplied by
userspace and doesn't change after a REPLACETLSPSK operation.

I'm not sure why the sysfs names are what they are, but
`tls_configured_key` seems like the negotiated key and `tls_key` is
configured by userspace.

>
> So why is 'tls_configured_key' key the better option?

`tls_configured_key` is the key that changes after a REPLACETLSPSK, so
it feels like that's the better place to trigger a REPLACETLSPSK.

> Personally I think that 'tls_key' is more 'natural',
> as we want to replace the negotiated key, not the
> configured key ...

I really think writing to the `tls_configured_key` to trigger a
REPLACETLSPSK is the way to go. It's the sysfs entry that changes
after a REPLACETLSPSK command. Writing to 'tls_key' and having it not
update just seems confusing.

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

