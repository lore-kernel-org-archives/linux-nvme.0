Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8026BCD5BB2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=; b=rcU6qcfEITxZEOnPOMK3hG+kxS
	gRAnXt7cDKZbm2eANL+LplwpnjGXvG2BVUtH/x9E9R74sAjsGR0OjGTT0Rx8FOBzk3WUbBPPq27GX
	bTzQOYVEwGp3ydxQif6b4EEjLhQAE5boinwGOSXDIo2xOTwGNUnV9QQYccnqSHL9NW8QyTxfzjBws
	sfxh3Brr1vR9En5o68+/9DlFFMvbA8Tw6E+XrNIg1ut6e8PXt6Db5ChKN4nljOeVPsArXRhHkd8E3
	+CTtEd5ZX/yNxFTok+8AYThuqO1GAPfFn866VLoPnuSaEAFa8R0a85GEJ35YEB2EM5W3fM6u0jlhc
	zRrDFVTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJUR6-0000000AGhD-2vYf;
	Thu, 13 Nov 2025 10:20:16 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJUR4-0000000AGgn-1Cgf
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 10:20:15 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b7277324054so80354766b.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763029212; x=1763634012; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=;
        b=iCC8wug4RMxdrLF0e0wzFpsPT44No0HeXvll1LqAeId0FHo8fHUTaT6QpGKLYK1ABX
         N39jmrdOzllYV3jceR0qefZ/t+WvpNyjmKYU14HtXw1LABVoAw7VoxQF9YhSWShEcS1b
         TQiL5OycXexp3KMtQeH11lrM2Nmuxm+jbD5GnV3qjETF2M9T7M2Yn3SGhCJOlqeyL1j0
         sAKOud3q3basJdjc0N3C7P+H+za+8RFWho7trPzYmUSCMVByuqxth+SZGMOprXjhCD3G
         NlI6BoIoOq2wBdBo0ZRDcQFvr4pI+ALpYDWkdfsJrDsx/0i1ejEDXx2WPXsUh+rm7Frp
         jiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029212; x=1763634012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=;
        b=ut9eIbTsAYkzf+kv5fn94PC/evHsFjZSG0Vew409I4YW1pBM6wG1CpuDyCj4M0TWM9
         8XYaRgWelBmpH5VYxMAJKqA9r5m1yUj94oW79OU2mJPUVx/ZYMAFifFfqtO3s6TXw0xo
         EEWOfRTXQX+Aq4a2C+t1dxWUSvJmlEH3lu1GcfHYSmnyueJmfTyvDoK5bDkpbz2QtYKe
         m6OfU49y61kqiWK12SjGS1qFr+qIEdN2eO3M+fyDlZF/vE6kA0Plq3ZARpYPPwrU7ETF
         bwjgA3/aAiC4QWiMv+Sunc8L3br+CDsfElHCEtrCifVWV2y1WuTViX4JpS24s+RHK8xZ
         fKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEbQU7LYqvn1wpHkGEKZeNxouE1iHhIbEhk5BAGjS1u+m9BdHgCIvg/MCP1W9AVo2sZfJdLsK/Aqy7@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5Tg40yEQ5VVjLysACoVSZzsWRrhp3DdslhBxCMZYkokpcqd01
	UBvOju6A98jCWllWCbg9nzWyI5ng0yWiJ4ubk7ON2Ocjy3T4rw4xTUtv/4mmBT0A4TSzs4TWYUz
	rbgenStfl0+zAOZ0xdgvTxsQLma2aL08=
X-Gm-Gg: ASbGncvuuMV9CguTRkJthEBEheRX84+fNriNwpvBO/IpEZDcXg3Q2EaANJMDNDLsZyC
	IttvQRlpmtpoWXoCC/Ks1XhV8U3EEQXPss/VoOfS5O01JdgPdSYFmeSK9AMzgBMibNPVdmnVHrm
	mpU2ENT+557D7r5VoKND77dCUsRitVMr9LW0hdyyhhvUPlRJX6quM52BP8i92N4KZCOenet+MAS
	41eQhCdoLUN4PQ6Oatdf0z1xqheB4Lr2mTzyvKHdFxlfxz09kVRwCQV7nfQSD1F/qxMjvnH7fDL
	iJNZk8nHHAt5BWA=
X-Google-Smtp-Source: AGHT+IHW+MEeffc/pTPQLmL7Dde2CnR8q/jO4iZvJp6R/AepiIuZRquQtp0We7AMZrEbstFQ9LYr74m01iZsJkJ+N6k=
X-Received: by 2002:a17:906:f58a:b0:b72:6d3e:848f with SMTP id
 a640c23a62f3a-b7331a372c0mr637454366b.19.1763029212208; Thu, 13 Nov 2025
 02:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
In-Reply-To: <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 20:19:45 +1000
X-Gm-Features: AWmQ_bkRDLojedW15PfOpNiK2JsU2DoevPnRuJfyF_0Rq1ckrKQa8VpTESFPsDE
Message-ID: <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_022014_353833_A88AED81 
X-CRM114-Status: GOOD (  36.22  )
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

On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Define a `handshake_sk_destruct_req()` function to allow the destructio=
n
> > of the handshake req.
> >
> > This is required to avoid hash conflicts when handshake_req_hash_add()
> > is called as part of submitting the KeyUpdate request.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> > v5:
> >  - No change
> > v4:
> >  - No change
> > v3:
> >  - New patch
> >
> >  net/handshake/request.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 274d2c89b6b2..0d1c91c80478 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
> >               sk_destruct(sk);
> >  }
> >
> > +/**
> > + * handshake_sk_destruct_req - destroy an existing request
> > + * @sk: socket on which there is an existing request
>
> Generally the kdoc style is unnecessary for static helper functions,
> especially functions with only a single caller.
>
> This all looks so much like handshake_sk_destruct(). Consider
> eliminating the code duplication by splitting that function into a
> couple of helpers instead of adding this one.
>
>
> > + */
> > +static void handshake_sk_destruct_req(struct sock *sk)
>
> Because this function is static, I imagine that the compiler will
> bark about the addition of an unused function. Perhaps it would
> be better to combine 2/6 and 3/6.
>
> That would also make it easier for reviewers to check the resource
> accounting issues mentioned below.
>
>
> > +{
> > +     struct handshake_req *req;
> > +
> > +     req =3D handshake_req_hash_lookup(sk);
> > +     if (!req)
> > +             return;
> > +
> > +     trace_handshake_destruct(sock_net(sk), req, sk);
>
> Wondering if this function needs to preserve the socket's destructor
> callback chain like so:
>
> +       void (sk_destruct)(struct sock sk);
>
>   ...
>
> +       sk_destruct =3D req->hr_odestruct;
> +       sk->sk_destruct =3D sk_destruct;
>
> then:
>
> > +     handshake_req_destroy(req);
>
> Because of the current code organization and patch ordering, it's
> difficult to confirm that sock_put() isn't necessary here.
>
>
> > +}
> > +
> >  /**
> >   * handshake_req_alloc - Allocate a handshake request
> >   * @proto: security protocol
>
> There's no synchronization preventing concurrent handshake_req_cancel()
> calls from accessing the request after it's freed during handshake
> completion. That is one reason why handshake_complete() leaves completed
> requests in the hash.

Ah, so you are worried that free-ing the request will race with
accessing the request after a handshake_req_hash_lookup().

Ok, makes sense. It seems like one answer to that is to add synchronisation

>
> So I'm thinking that removing requests like this is not going to work
> out. Would it work better if handshake_req_hash_add() could recognize
> that a KeyUpdate is going on, and allow replacement of a hashed
> request? I haven't thought that through.

I guess the idea would be to do something like this in
handshake_req_hash_add() if the entry already exists?

    if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
        /* Request already completed */
        rhashtable_replace_fast(...);
    }

I'm not sure that's better. That could possibly still race with
something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
the request unexpectedly.

What about adding synchronisation and keeping the current approach?
From a quick look it should be enough to just edit
handshake_sk_destruct() and handshake_req_cancel()

Alistair

>
>
> As always, please double-check my questions and assumptions before
> revising this patch!
>
>
> --
> Chuck Lever

