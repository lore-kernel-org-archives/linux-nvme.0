Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1B0CFD36C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 05:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RgkEIaYmSIgN/j0r5dDRltCfW2UohQiH4qvD0keignk=; b=jW7meTSDHKOARsaJ557FJpp4Ec
	2M2zsKJZAXoOUX/A6dWMWDdb3tiUNE/Mu/WvnoIYo0WxNrpi4sAVoaG/cNLt2RxtSWcVFsd+T2fxu
	MIPkWOp62oBfcJ9gpJmLe47Epo/pVtbMyjkmEHNCyvodVLBUTQBdMRyV2LmNKnTHWhj6rX5D0m6pe
	UPoCIAu1iSXQjVIgnNrjm1xaKV77kEK2IfGzl5Movpjz30CAHIqCQIt0ak14LcsztxNK2opYtWo1y
	u7PtS837tad1vF/Wi3iXKrX7VYm0nhTDZXHx5eNL8vu4OkbV7JUQxS/dJ3LNb3mt+uLsSxPCaVW1D
	s/rrSmYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNlAc-0000000ClFA-40SV;
	Tue, 25 Nov 2025 05:00:54 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNlAZ-0000000ClEk-2RgF
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 05:00:53 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b7636c96b9aso685295866b.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 21:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764046849; x=1764651649; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgkEIaYmSIgN/j0r5dDRltCfW2UohQiH4qvD0keignk=;
        b=ihGT7oyOG5EekBneQmlGbX6I66NrXvTZZVSGUYTCubE+UZeYiX2AxIXc0iTyc+y0Pt
         24gNPkKA+ve/yx261a/cNT7FkHFBaF03q7Obinlk9fIwPtK4xvIf9ippoMrSTIydkpm/
         NmvOtUkJNAOs+4vYY4c5qnDHlkiDbaD0kMAba5Rhqf7JapYp03axWwmtR3W+3hwMk0ZY
         qkg3OdoZdamOCfc4alARTNQoMQYaiHug6QKIMv2w1qZrL2IwZTuVS5bwjyZZk+EPlErU
         di3r9OMoOWY1zpr+JVz11SWOTE/0A4NJ7zOcggD5B1jFLklFi6eLbDWDrJureEqrKwwI
         TNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764046849; x=1764651649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgkEIaYmSIgN/j0r5dDRltCfW2UohQiH4qvD0keignk=;
        b=pKo6y3y7s58Yj9VI/hvZtfL0gWamQKND0C2npTNIB3EAXaFMDEg/ShUXkE9gKNQ5xc
         ZdBOFNva4hJDjbvXymhvHVWlr5+hTI95Yag7swuuN0x3i8Xl6IpbCjzH8bU6cOJIXz41
         AisXxKkfmWI1CSxJx9wEThKLvhE7oCKVCECfIUcb1hfBnz/TfXHXd9deiybRfW1ps7in
         51UcrpC/5jGURyymAxijes5yJmhty/23nqut25hdvB9FirI0tLUuSwzua2uTO2s7WVfv
         df8yuS36V6u/UHHwE07LA/hJQKJLaVRq67r/utwBuIrvx1IEuOLqLgynaz8ninVUmIGn
         t85w==
X-Forwarded-Encrypted: i=1; AJvYcCVxm/aYH15y7Zw+VWjDJXM+bgyUKeD13EoZP6zBJp6M4gTztbsaljPUAqL8s1uu8p9iy6m18BA8lvvk@lists.infradead.org
X-Gm-Message-State: AOJu0YzIF5qcfXGAAK1gL5XYd534Qsz1ac3znl8V0DN2U1H7d3Wls7sK
	1Yye75gp1RNgnpgWwGKI2ej1xIIfE8O58eqt24KXOMVVTZwIrDbPs5hE+rAIyeHXr7fJZ8A9YDL
	czSpKi7Xw7W9Kx3eI4DRKQXuBnXLKMWk=
X-Gm-Gg: ASbGnctptpU+AmX4uxwc4/bo5ymuhYjkGMBxAKbvmtF6qfzckoyqOT+H05J4o67YkH1
	ULfOllwz/gebNDyphrgthhRWOEnqgHYaNSUD8OwDfI/3ypRl0WZAFEjI+KXDq4DuTu/Cs+gnns8
	sNglO1lp+iXAZVVnjWIpcdusc+AP0xzUpCKf9mvwdw1OxmaGUH42VWTwjyXtmhMHm/nE9+60k7U
	hYur1Ocn4kCz9TjJTC5k9hCHWVbzuQTWAq0a/RWOerm2VvvqUQCEE+T/PMpKXiyIjL0uxi6toTd
	sZREjKvvlki+Ee9sOrY3iGFE8eYP89x9Mg27
X-Google-Smtp-Source: AGHT+IHlaXfGjOGCpgIzKRFn/PG3VXXHLz6/IwU5ZevNl3k4vvBiVkhNC4X8bL+NhWCjlFdBgdmMptIXWPYRrY2i67A=
X-Received: by 2002:a17:906:181b:b0:b76:bfa9:5ae7 with SMTP id
 a640c23a62f3a-b76bfa95b6amr192759466b.29.1764046848703; Mon, 24 Nov 2025
 21:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com> <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
 <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
 <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com> <CAKmqyKMjZWAvbc23JQ358kyWyJ0ZajHd8o0eFgF-i1eXX85-jA@mail.gmail.com>
 <14f4ee67-d1dc-4eb0-a677-9472a36ae3bc@oracle.com>
In-Reply-To: <14f4ee67-d1dc-4eb0-a677-9472a36ae3bc@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Nov 2025 15:00:21 +1000
X-Gm-Features: AWmQ_bkgAASdqK_4byjwJ9DXTwVH0wYVdnA1PBPJyGs2R0SyTlWoIYyHqbjO9pk
Message-ID: <CAKmqyKNJ3BsooptPxMAhrhQZnCVaq_gnnhCrv66+eoTpWvpOww@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251124_210051_681618_E683B03D 
X-CRM114-Status: GOOD (  56.55  )
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

On Thu, Nov 20, 2025 at 11:51=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 11/18/25 7:45 PM, Alistair Francis wrote:
> > On Sat, Nov 15, 2025 at 12:14=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 11/13/25 10:44 PM, Alistair Francis wrote:
> >>> On Fri, Nov 14, 2025 at 12:37=E2=80=AFAM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>
> >>>> On 11/13/25 9:01 AM, Chuck Lever wrote:
> >>>>> On 11/13/25 5:19 AM, Alistair Francis wrote:
> >>>>>> On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@o=
racle.com> wrote:
> >>>>>>>
> >>>>>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> >>>>>>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>>>>>
> >>>>>>>> Define a `handshake_sk_destruct_req()` function to allow the des=
truction
> >>>>>>>> of the handshake req.
> >>>>>>>>
> >>>>>>>> This is required to avoid hash conflicts when handshake_req_hash=
_add()
> >>>>>>>> is called as part of submitting the KeyUpdate request.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>>>>>> ---
> >>>>>>>> v5:
> >>>>>>>>  - No change
> >>>>>>>> v4:
> >>>>>>>>  - No change
> >>>>>>>> v3:
> >>>>>>>>  - New patch
> >>>>>>>>
> >>>>>>>>  net/handshake/request.c | 16 ++++++++++++++++
> >>>>>>>>  1 file changed, 16 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
> >>>>>>>> index 274d2c89b6b2..0d1c91c80478 100644
> >>>>>>>> --- a/net/handshake/request.c
> >>>>>>>> +++ b/net/handshake/request.c
> >>>>>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock=
 *sk)
> >>>>>>>>               sk_destruct(sk);
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +/**
> >>>>>>>> + * handshake_sk_destruct_req - destroy an existing request
> >>>>>>>> + * @sk: socket on which there is an existing request
> >>>>>>>
> >>>>>>> Generally the kdoc style is unnecessary for static helper functio=
ns,
> >>>>>>> especially functions with only a single caller.
> >>>>>>>
> >>>>>>> This all looks so much like handshake_sk_destruct(). Consider
> >>>>>>> eliminating the code duplication by splitting that function into =
a
> >>>>>>> couple of helpers instead of adding this one.
> >>>>>>>
> >>>>>>>
> >>>>>>>> + */
> >>>>>>>> +static void handshake_sk_destruct_req(struct sock *sk)
> >>>>>>>
> >>>>>>> Because this function is static, I imagine that the compiler will
> >>>>>>> bark about the addition of an unused function. Perhaps it would
> >>>>>>> be better to combine 2/6 and 3/6.
> >>>>>>>
> >>>>>>> That would also make it easier for reviewers to check the resourc=
e
> >>>>>>> accounting issues mentioned below.
> >>>>>>>
> >>>>>>>
> >>>>>>>> +{
> >>>>>>>> +     struct handshake_req *req;
> >>>>>>>> +
> >>>>>>>> +     req =3D handshake_req_hash_lookup(sk);
> >>>>>>>> +     if (!req)
> >>>>>>>> +             return;
> >>>>>>>> +
> >>>>>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
> >>>>>>>
> >>>>>>> Wondering if this function needs to preserve the socket's destruc=
tor
> >>>>>>> callback chain like so:
> >>>>>>>
> >>>>>>> +       void (sk_destruct)(struct sock sk);
> >>>>>>>
> >>>>>>>   ...
> >>>>>>>
> >>>>>>> +       sk_destruct =3D req->hr_odestruct;
> >>>>>>> +       sk->sk_destruct =3D sk_destruct;
> >>>>>>>
> >>>>>>> then:
> >>>>>>>
> >>>>>>>> +     handshake_req_destroy(req);
> >>>>>>>
> >>>>>>> Because of the current code organization and patch ordering, it's
> >>>>>>> difficult to confirm that sock_put() isn't necessary here.
> >>>>>>>
> >>>>>>>
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  /**
> >>>>>>>>   * handshake_req_alloc - Allocate a handshake request
> >>>>>>>>   * @proto: security protocol
> >>>>>>>
> >>>>>>> There's no synchronization preventing concurrent handshake_req_ca=
ncel()
> >>>>>>> calls from accessing the request after it's freed during handshak=
e
> >>>>>>> completion. That is one reason why handshake_complete() leaves co=
mpleted
> >>>>>>> requests in the hash.
> >>>>>>
> >>>>>> Ah, so you are worried that free-ing the request will race with
> >>>>>> accessing the request after a handshake_req_hash_lookup().
> >>>>>>
> >>>>>> Ok, makes sense. It seems like one answer to that is to add synchr=
onisation
> >>>>>>
> >>>>>>>
> >>>>>>> So I'm thinking that removing requests like this is not going to =
work
> >>>>>>> out. Would it work better if handshake_req_hash_add() could recog=
nize
> >>>>>>> that a KeyUpdate is going on, and allow replacement of a hashed
> >>>>>>> request? I haven't thought that through.
> >>>>>>
> >>>>>> I guess the idea would be to do something like this in
> >>>>>> handshake_req_hash_add() if the entry already exists?
> >>>>>>
> >>>>>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags=
)) {
> >>>>>>         /* Request already completed */
> >>>>>>         rhashtable_replace_fast(...);
> >>>>>>     }
> >>>>>>
> >>>>>> I'm not sure that's better. That could possibly still race with
> >>>>>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwr=
ite
> >>>>>> the request unexpectedly.
> >>>>>>
> >>>>>> What about adding synchronisation and keeping the current approach=
?
> >>>>>> From a quick look it should be enough to just edit
> >>>>>> handshake_sk_destruct() and handshake_req_cancel()
> >>>>>
> >>>>> Or make the KeyUpdate requests somehow distinctive so they do not
> >>>>> collide with initial handshake requests.
> >>>
> >>> Hmmm... Then each KeyUpdate needs to be distinctive, which will
> >>> indefinitely grow the hash table
> >>
> >> Two random observations:
> >>
> >> 1. There is only zero or one KeyUpdate going on at a time. Certainly
> >> the KeyUpdate-related data structures don't need to stay around.
> >
> > That's the same as the original handshake req though, which you are
> > saying can't be freed
> >
> >>
> >> 2. Maybe a separate data structure to track KeyUpdates is appropriate.
> >>
> >>
> >>>> Another thought: expand the current _req structure to also manage
> >>>> KeyUpdates. I think there can be only one upcall request pending
> >>>> at a time, right?
> >>>
> >>> There should only be a single request pending per queue.
> >>>
> >>> I'm not sure I see what we could do to expand the _req structure.
> >>>
> >>> What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
> >>> using that to ensure we don't free something that is currently being
> >>> cancelled and the other way around?
> >>
> >> A CANCEL can happen at any time during the life of the session/socket,
> >> including long after the handshake was done. It's part of socket
> >> teardown. I don't think we can simply remove the req on handshake
> >> completion.
> >
> > Does that matter though? If a cancel is issued on a freed req we just
> > do nothing as there is nothing to cancel.
>
> I confess I've lost a bit of the plot.

Ha, we are in the weeds a bit.

>
> I still don't yet understand why the req has to be removed from the
> hash rather than re-using the socket's existing req for KeyUpdates.

Basically we want to call handshake_req_submit() to submit a KeyUpdate
request. That will fail if there is already a request in the hash
table, in this case the request has been completed but not destroyed.

This patch is deconstructing the request on completion so that when we
perform a KeyUpdate the request doesn't exist. Which to me seems like
the way to go as we are no longer using the request, so why keep it
around.

You said that might race with cancelling the request
(handshake_req_cancel()), which I'm trying to find a solution to. My
proposal is to add some atomic synchronisation to ensure we don't
cancel/free a request at the same time.

You are saying that we could instead add a new function similar to
handshake_req_submit() that reuses the existing request. I was
thinking that would also race with handshake_req_cancel(), but I guess
it won't as nothing is being freed.

So you would prefer changing handshake_req_submit() to just re-use an
existing completed request for KeyUpdate?

Alistair

>
>
> --
> Chuck Lever

