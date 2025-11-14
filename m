Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E49FCD4F49
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 03:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6mtqdCrs5s13DdsY7nLARbcmjZ6uHESPgGUhdIcOCQ=; b=r2F6NsXwmjrrAFT2WBKlVz8kVc
	c9NuLjpRXD77JOfnrUt+JyPDI4OEwvCzFK/+SWIq4d3LwQQWxVcXm+FMlmUoHn78OBgigAfG+PJfp
	nVFO/5weyLqDGbcPFRJoMS+QWwEDiyF2kD9QQEEhKy+1JYUeKFRHuJGAX5+ObNnbk8Q+WqceHgZDg
	FYrVVUXpkqyXFqvlu+8bRJwMScuqRqBDaI/PoCwRuOYJeBIWynikZFq13FvwMWnbPu+Lcg+FwbmSo
	NkxjGNlegyPy5YSeAYd4YpINV6XZv/OGSL4VfnDVNUR3t23PJ8XK84SGIaH/f5fL75If4GZf66WKr
	C9JTHxJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJkjz-0000000BVGy-0Ah2;
	Fri, 14 Nov 2025 03:44:51 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJkjv-0000000BVGa-4AuR
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 03:44:49 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso2682163a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 19:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763091885; x=1763696685; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6mtqdCrs5s13DdsY7nLARbcmjZ6uHESPgGUhdIcOCQ=;
        b=ZKhNOqb8KDJz086JSJKZ9dMLWfbxtOr9BJ6qjtBQkHBnEcmOwho9iRAPi2cZskehTT
         zjgk5qj77JatFII902y+SYAgeSDMNY7HCEdSmy+PSeSE6OQ4PcTRAMMgZcThhiahjLy9
         TLoc4oE67Mz1ExRWRk9jTpwz3tTB5ZsMVDolNv/0tGxZQkh/lcQBbkFlu8G1G21zHj5K
         FE2wZZRM5/Q8RnOu3IYFlTSqMAXel+dvABWdS+sE8NNv35Br+qUVkMjdOxrEXtAVDY0T
         O1OTAHIEvy1/P2FOYK9K2EXwVTPV4VFXujmZesrUdBB6X50iAqwdRRHHYG6WDKND5gBl
         Httw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091885; x=1763696685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6mtqdCrs5s13DdsY7nLARbcmjZ6uHESPgGUhdIcOCQ=;
        b=MuSQZlbHJ1Zv8HoAsqLAZp5EgB3FO5N1iQTCaQKAGMpD2us6yAFIW7au/AXMPDyr5j
         6n5nwQcjy8kLMdcNyBAbQAksX1DNiXFYp5kv8QHNxq7DwRbMga1csnEj84CR8+Hw+aCl
         OuorG5yt5oAZaWdDaUGWfGb44+W8QU0PYflLEXoNPBcyVdQB7kFa5Vk27E1hVP6N94qY
         nB4twNMfrg9fzaitKJoTzB3lj8dYIAtCMIRzt9lOrlKJAk8+uOXsZV147mzqCRxmrrVb
         qsn5mFLFydFsMc4ZZ/a7Mhot8raT/eehDE6FmbhRF8SfBMeRm5YSNjCcS8L5UP90d10Y
         idnw==
X-Forwarded-Encrypted: i=1; AJvYcCW+g2hqFEGb0hjYCXgFZpawUR8FXDG/YlVzUmNme7LxbYsf5KbOMWO0dgZ4zkGPyfm67TyLvJu/4kAf@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+eE8KFFXUprQb+4/lnXKCS1NquBH4ymuITKCcsudPfF2x8LTr
	fw42KvcqYHXHJH1kvsbpeMIcOx6ztix+zAS9pAEI7jbcO3hZdldfN92zeofx7UYQJ3abJM4Mqgy
	Dge8CVXPP5aEUdoh5QQnZSJ+v9ybgBfA=
X-Gm-Gg: ASbGncvvzTUMjbCB1Lsg9mm4XG342xE03Lhl8oSc6qVMvrxt0KrvD3IOOfJ/RNdxyZA
	2E/rkykI3Ykfsg8VP72djMbJJqe+mrwDRD6g44kZzqH0jXGhGDwv5Sls7wdyEOzrMsQHIPQHdvu
	i1VVXEOorcA+6hrMS+JKl7cZ/MRBZE3wkahT6PJxUBPEnxwbb205mZyuHnsv+2OTghIU8BSt66N
	xf0EQebpge8T2hjK2negiJpnyjiyU51n60iuuR2AfkcSIESamxdyGLG1Ezvx94JB3n7AHhYmgV4
	zab4UAxfNXuiW0Q=
X-Google-Smtp-Source: AGHT+IFeY6ExbhnLix/V8V2HiLoJfg49zjUIkHAqrWQ16NjMplNdRqeUyyg/UCDy4n1WKY6+b/r4V6jK0pS5c2c7MTg=
X-Received: by 2002:a17:907:7fa9:b0:b70:7d61:b8a5 with SMTP id
 a640c23a62f3a-b7367b6f8afmr165505566b.62.1763091885372; Thu, 13 Nov 2025
 19:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com> <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
In-Reply-To: <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 14 Nov 2025 13:44:18 +1000
X-Gm-Features: AWmQ_bkh-hR1xTkgsN4bcSSt81jUJ1aCCzsHDAZD7xu3wz-1oUVwA9mDnPBItVQ
Message-ID: <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251113_194448_062012_268DA813 
X-CRM114-Status: GOOD (  40.20  )
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

On Fri, Nov 14, 2025 at 12:37=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 11/13/25 9:01 AM, Chuck Lever wrote:
> > On 11/13/25 5:19 AM, Alistair Francis wrote:
> >> On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>>
> >>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> >>>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>>
> >>>> Define a `handshake_sk_destruct_req()` function to allow the destruc=
tion
> >>>> of the handshake req.
> >>>>
> >>>> This is required to avoid hash conflicts when handshake_req_hash_add=
()
> >>>> is called as part of submitting the KeyUpdate request.
> >>>>
> >>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>> ---
> >>>> v5:
> >>>>  - No change
> >>>> v4:
> >>>>  - No change
> >>>> v3:
> >>>>  - New patch
> >>>>
> >>>>  net/handshake/request.c | 16 ++++++++++++++++
> >>>>  1 file changed, 16 insertions(+)
> >>>>
> >>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
> >>>> index 274d2c89b6b2..0d1c91c80478 100644
> >>>> --- a/net/handshake/request.c
> >>>> +++ b/net/handshake/request.c
> >>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk=
)
> >>>>               sk_destruct(sk);
> >>>>  }
> >>>>
> >>>> +/**
> >>>> + * handshake_sk_destruct_req - destroy an existing request
> >>>> + * @sk: socket on which there is an existing request
> >>>
> >>> Generally the kdoc style is unnecessary for static helper functions,
> >>> especially functions with only a single caller.
> >>>
> >>> This all looks so much like handshake_sk_destruct(). Consider
> >>> eliminating the code duplication by splitting that function into a
> >>> couple of helpers instead of adding this one.
> >>>
> >>>
> >>>> + */
> >>>> +static void handshake_sk_destruct_req(struct sock *sk)
> >>>
> >>> Because this function is static, I imagine that the compiler will
> >>> bark about the addition of an unused function. Perhaps it would
> >>> be better to combine 2/6 and 3/6.
> >>>
> >>> That would also make it easier for reviewers to check the resource
> >>> accounting issues mentioned below.
> >>>
> >>>
> >>>> +{
> >>>> +     struct handshake_req *req;
> >>>> +
> >>>> +     req =3D handshake_req_hash_lookup(sk);
> >>>> +     if (!req)
> >>>> +             return;
> >>>> +
> >>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
> >>>
> >>> Wondering if this function needs to preserve the socket's destructor
> >>> callback chain like so:
> >>>
> >>> +       void (sk_destruct)(struct sock sk);
> >>>
> >>>   ...
> >>>
> >>> +       sk_destruct =3D req->hr_odestruct;
> >>> +       sk->sk_destruct =3D sk_destruct;
> >>>
> >>> then:
> >>>
> >>>> +     handshake_req_destroy(req);
> >>>
> >>> Because of the current code organization and patch ordering, it's
> >>> difficult to confirm that sock_put() isn't necessary here.
> >>>
> >>>
> >>>> +}
> >>>> +
> >>>>  /**
> >>>>   * handshake_req_alloc - Allocate a handshake request
> >>>>   * @proto: security protocol
> >>>
> >>> There's no synchronization preventing concurrent handshake_req_cancel=
()
> >>> calls from accessing the request after it's freed during handshake
> >>> completion. That is one reason why handshake_complete() leaves comple=
ted
> >>> requests in the hash.
> >>
> >> Ah, so you are worried that free-ing the request will race with
> >> accessing the request after a handshake_req_hash_lookup().
> >>
> >> Ok, makes sense. It seems like one answer to that is to add synchronis=
ation
> >>
> >>>
> >>> So I'm thinking that removing requests like this is not going to work
> >>> out. Would it work better if handshake_req_hash_add() could recognize
> >>> that a KeyUpdate is going on, and allow replacement of a hashed
> >>> request? I haven't thought that through.
> >>
> >> I guess the idea would be to do something like this in
> >> handshake_req_hash_add() if the entry already exists?
> >>
> >>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
> >>         /* Request already completed */
> >>         rhashtable_replace_fast(...);
> >>     }
> >>
> >> I'm not sure that's better. That could possibly still race with
> >> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
> >> the request unexpectedly.
> >>
> >> What about adding synchronisation and keeping the current approach?
> >> From a quick look it should be enough to just edit
> >> handshake_sk_destruct() and handshake_req_cancel()
> >
> > Or make the KeyUpdate requests somehow distinctive so they do not
> > collide with initial handshake requests.

Hmmm... Then each KeyUpdate needs to be distinctive, which will
indefinitely grow the hash table

>
> Another thought: expand the current _req structure to also manage
> KeyUpdates. I think there can be only one upcall request pending
> at a time, right?

There should only be a single request pending per queue.

I'm not sure I see what we could do to expand the _req structure.

What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
using that to ensure we don't free something that is currently being
cancelled and the other way around?

Alistair

>
>
> --
> Chuck Lever

