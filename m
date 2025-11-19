Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F49CCF2564
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=loI2m1i6xyLqte3KlXwI/N6FlLk9b2LOtEWlW5hvUIk=; b=DbmlAvj1ywmhnJ69jWkfFl06NI
	7bpJp20nThCEzKAHuu1x4J4KYHVMH5/h2TyOYGIzlA46+4ac60xPBSNmNw9gcqTQLyJnTGp5b+TvX
	sWYbJP+8j3wADnyCFNsMUPg8KW96BLQrbEQLfpQ2+Uf3sS/qChkFz1sLkIgdZ4lgzwnibJ0zjGhjT
	XvrTxU0rrfB7zjBVYtJ6KckBVogdfP9JnjW5TF2CNunF5q2fqv8D9cRNqFjgrGp7eK6rGhFmeu/VR
	sT39/UsASEkULK70/kQj9losZ9GnOV+mTW4uA1XvT95BWHG9CJ70QWvyIrUAnH9p1EWDUKP5G5h/0
	3tOJJM5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLWKp-00000001J9z-1xSj;
	Wed, 19 Nov 2025 00:46:11 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLWKi-00000001J8k-3JeQ
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 00:46:09 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so11346412a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Nov 2025 16:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763513163; x=1764117963; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loI2m1i6xyLqte3KlXwI/N6FlLk9b2LOtEWlW5hvUIk=;
        b=hsgQszRiLUy6FzqdNjsigNbcd1ZyVp1JB5Y9PWTmyTdcCGd0ye6J4kBg0Bt1YXDshf
         WXhk7iKMFGUtDZHxc+W1D0lkM8L5TKubG9hPh1gt8JjbwQlU7WXn5TIBECYxW9ttWGjg
         LR9oE79WT7oJtGPnXmL1PDACznCjDf/FhaGiwt6AkQu1QSQjR0NDjmUsP1zIYo69bCGC
         SpmeOvvNAEFEzP5nf7NTWYY2Vk/5BvzZYCM1yMmkR9jClEjiJr4LLnVKoTnAq0mUv7PC
         Z4iVkqZSvsfOZhEcMZkk3zRfHyPB+BuTT3TDojPQXpseBH1WrtQcDzUfE6hpeQrA4tPJ
         xkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763513163; x=1764117963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=loI2m1i6xyLqte3KlXwI/N6FlLk9b2LOtEWlW5hvUIk=;
        b=a3RFAluHyP8QnN/drgfbkpl7J0g5KKTZqNMbCbIF4psZMiNwnnQQpvuefnTV1yKB1C
         oLr+TMHyQpoP18PqXrcXBZ6vhE6EWMcABWBYBC1Ths9mgmtLcRoVVHaiJ+UIyLr1yPSl
         pIKPaYsw1b8IeoLnYU8hhNoahbAgevI9Hqdt2OAEc4AZ35OrqbO8Grl2weh5nPSK0iBx
         IuL6DLPHsAfCEKpYOUILTkp+8ds6eSuOa76R+35Md52I10GKSJM5y8JGra3HR3JocxDG
         Hg8Wy9P1RaowTAe+nVgNi3Ft/WalNTAEQnXu08f9Pl9VB/4sC9c6P/SGA34Y6ZZaE8DP
         5VSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMaqw/dJtH8i6QGxUQEEfEezAK+jleAH4tOvBBfttp8NVSBuBiVa643u+js+aT7R3//c72E8DEzlqy@lists.infradead.org
X-Gm-Message-State: AOJu0YyMOJwgxARTvPYWgGaLE3IQzTExGt0sUd5eIHxJML8DD1BpMlz3
	84KFI4T/eUbQsu5sLBjzP9WCVBCrXhl5oBmrPSa0dewAg4FnwFvlLpHwW3o8+LTdK0F7UuJm7iN
	0IRj+bgCWfNyy7PJUiszCod5n0SvLGDE=
X-Gm-Gg: ASbGnctCnxJOLOK9BT1vSg23pEPwZ/1/RLZ/AgjuVYjnfHU0StBG3anDzFG3DVXkpBf
	xx4+fDFz/9ZoZJCaiDNB6S7BxerAbpstc+1PcAyYmRchmrXaM2/jlt6HlDmP0/vIcHCPvpXO3nc
	ccE+GE2lth2scQlXQ8794/h/hKGSJAGwFWLklko/xSoZX3Nuft/FfdmJqlUrh6OCFkVIODB9tUh
	H2btZRFKSwByoM3O3JBeY63gX1/QX+nwXjVJcRcYZUwTsgGfg2YrJ5Bd7wK2YCP6iR/2N7x+OCr
	Jq37Ep7FFFiiuHv/3tTWbUO1uE8cFKnHVA8R
X-Google-Smtp-Source: AGHT+IHKMqkDthFKtYfvCVwMYSITSXJVaoUFOv3eLMP9EBqh8xFPyDn9xeDCWp1fry5+1S+80eX3hQ6WLWmiyUtz3wA=
X-Received: by 2002:a17:906:594a:b0:b73:68f5:41af with SMTP id
 a640c23a62f3a-b7368f54466mr1465687166b.51.1763513162635; Tue, 18 Nov 2025
 16:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com> <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
 <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com> <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com>
In-Reply-To: <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Nov 2025 10:45:36 +1000
X-Gm-Features: AWmQ_bk8QCuKCQLb67DqdaocyJffENaewjAIfRWVrYKjotLKWyJRkrS5UCmlPPw
Message-ID: <CAKmqyKMjZWAvbc23JQ358kyWyJ0ZajHd8o0eFgF-i1eXX85-jA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251118_164604_873023_D1F66E27 
X-CRM114-Status: GOOD (  47.26  )
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

On Sat, Nov 15, 2025 at 12:14=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 11/13/25 10:44 PM, Alistair Francis wrote:
> > On Fri, Nov 14, 2025 at 12:37=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 11/13/25 9:01 AM, Chuck Lever wrote:
> >>> On 11/13/25 5:19 AM, Alistair Francis wrote:
> >>>> On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>>
> >>>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> >>>>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>>>
> >>>>>> Define a `handshake_sk_destruct_req()` function to allow the destr=
uction
> >>>>>> of the handshake req.
> >>>>>>
> >>>>>> This is required to avoid hash conflicts when handshake_req_hash_a=
dd()
> >>>>>> is called as part of submitting the KeyUpdate request.
> >>>>>>
> >>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>>>> ---
> >>>>>> v5:
> >>>>>>  - No change
> >>>>>> v4:
> >>>>>>  - No change
> >>>>>> v3:
> >>>>>>  - New patch
> >>>>>>
> >>>>>>  net/handshake/request.c | 16 ++++++++++++++++
> >>>>>>  1 file changed, 16 insertions(+)
> >>>>>>
> >>>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
> >>>>>> index 274d2c89b6b2..0d1c91c80478 100644
> >>>>>> --- a/net/handshake/request.c
> >>>>>> +++ b/net/handshake/request.c
> >>>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *=
sk)
> >>>>>>               sk_destruct(sk);
> >>>>>>  }
> >>>>>>
> >>>>>> +/**
> >>>>>> + * handshake_sk_destruct_req - destroy an existing request
> >>>>>> + * @sk: socket on which there is an existing request
> >>>>>
> >>>>> Generally the kdoc style is unnecessary for static helper functions=
,
> >>>>> especially functions with only a single caller.
> >>>>>
> >>>>> This all looks so much like handshake_sk_destruct(). Consider
> >>>>> eliminating the code duplication by splitting that function into a
> >>>>> couple of helpers instead of adding this one.
> >>>>>
> >>>>>
> >>>>>> + */
> >>>>>> +static void handshake_sk_destruct_req(struct sock *sk)
> >>>>>
> >>>>> Because this function is static, I imagine that the compiler will
> >>>>> bark about the addition of an unused function. Perhaps it would
> >>>>> be better to combine 2/6 and 3/6.
> >>>>>
> >>>>> That would also make it easier for reviewers to check the resource
> >>>>> accounting issues mentioned below.
> >>>>>
> >>>>>
> >>>>>> +{
> >>>>>> +     struct handshake_req *req;
> >>>>>> +
> >>>>>> +     req =3D handshake_req_hash_lookup(sk);
> >>>>>> +     if (!req)
> >>>>>> +             return;
> >>>>>> +
> >>>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
> >>>>>
> >>>>> Wondering if this function needs to preserve the socket's destructo=
r
> >>>>> callback chain like so:
> >>>>>
> >>>>> +       void (sk_destruct)(struct sock sk);
> >>>>>
> >>>>>   ...
> >>>>>
> >>>>> +       sk_destruct =3D req->hr_odestruct;
> >>>>> +       sk->sk_destruct =3D sk_destruct;
> >>>>>
> >>>>> then:
> >>>>>
> >>>>>> +     handshake_req_destroy(req);
> >>>>>
> >>>>> Because of the current code organization and patch ordering, it's
> >>>>> difficult to confirm that sock_put() isn't necessary here.
> >>>>>
> >>>>>
> >>>>>> +}
> >>>>>> +
> >>>>>>  /**
> >>>>>>   * handshake_req_alloc - Allocate a handshake request
> >>>>>>   * @proto: security protocol
> >>>>>
> >>>>> There's no synchronization preventing concurrent handshake_req_canc=
el()
> >>>>> calls from accessing the request after it's freed during handshake
> >>>>> completion. That is one reason why handshake_complete() leaves comp=
leted
> >>>>> requests in the hash.
> >>>>
> >>>> Ah, so you are worried that free-ing the request will race with
> >>>> accessing the request after a handshake_req_hash_lookup().
> >>>>
> >>>> Ok, makes sense. It seems like one answer to that is to add synchron=
isation
> >>>>
> >>>>>
> >>>>> So I'm thinking that removing requests like this is not going to wo=
rk
> >>>>> out. Would it work better if handshake_req_hash_add() could recogni=
ze
> >>>>> that a KeyUpdate is going on, and allow replacement of a hashed
> >>>>> request? I haven't thought that through.
> >>>>
> >>>> I guess the idea would be to do something like this in
> >>>> handshake_req_hash_add() if the entry already exists?
> >>>>
> >>>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags))=
 {
> >>>>         /* Request already completed */
> >>>>         rhashtable_replace_fast(...);
> >>>>     }
> >>>>
> >>>> I'm not sure that's better. That could possibly still race with
> >>>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrit=
e
> >>>> the request unexpectedly.
> >>>>
> >>>> What about adding synchronisation and keeping the current approach?
> >>>> From a quick look it should be enough to just edit
> >>>> handshake_sk_destruct() and handshake_req_cancel()
> >>>
> >>> Or make the KeyUpdate requests somehow distinctive so they do not
> >>> collide with initial handshake requests.
> >
> > Hmmm... Then each KeyUpdate needs to be distinctive, which will
> > indefinitely grow the hash table
>
> Two random observations:
>
> 1. There is only zero or one KeyUpdate going on at a time. Certainly
> the KeyUpdate-related data structures don't need to stay around.

That's the same as the original handshake req though, which you are
saying can't be freed

>
> 2. Maybe a separate data structure to track KeyUpdates is appropriate.
>
>
> >> Another thought: expand the current _req structure to also manage
> >> KeyUpdates. I think there can be only one upcall request pending
> >> at a time, right?
> >
> > There should only be a single request pending per queue.
> >
> > I'm not sure I see what we could do to expand the _req structure.
> >
> > What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
> > using that to ensure we don't free something that is currently being
> > cancelled and the other way around?
>
> A CANCEL can happen at any time during the life of the session/socket,
> including long after the handshake was done. It's part of socket
> teardown. I don't think we can simply remove the req on handshake
> completion.

Does that matter though? If a cancel is issued on a freed req we just
do nothing as there is nothing to cancel.

Alistair

>
>
> --
> Chuck Lever

