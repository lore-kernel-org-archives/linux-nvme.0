Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEACEC8758
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atXeRfE0mDVD+y4O/MdfuuYUpZQSWnCC9q6t9PO21FY=; b=1sC5hVABn2Dkw2o+Qrwp3PjOy1
	DrMbWSkxebDm3ZPTrZZzXdHKjEp954B7OBGnV0Wv3mVTy+8NSQJayYPitIzQ/TYAXFiFJpAqT+cWq
	APE7h/llGRNBH2n5knXBh+Fr04ofaENAv6twbhLkufqe4ELh1DYb+HjbH/gZGVpFGQMysCMPZQqbD
	Yv/OXu+HqROyhUSJ8WvZshUsSj+iebhhvZiM7LQTGTJ8BDbQKiAiVDelJxwqE4/jJRzILNdiQ8QYg
	xPb42lcb71lDUUOIAhH+ZxYcVIU70Odwj9dqVt3nw2VpKesnZETFUaHhnExhWExcZ6xVIq3lCsVZW
	GJcNWONw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeLjG-00CeyX-38;
	Thu, 07 Sep 2023 20:35:54 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeLjD-00CeyD-0X
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 20:35:52 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401b393df02so16131925e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Sep 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694118947; x=1694723747; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atXeRfE0mDVD+y4O/MdfuuYUpZQSWnCC9q6t9PO21FY=;
        b=MWCs+sA74itB6k6EtaLOGqRY6e6GF5XGnjS0U1fhQMEs00DDttFXvPwHl0AhOdAc0Z
         9B9E37Sl7drGHO9afrYFr+Z7A5IWEm8A/HhNC533bYgvSCDdowAwB9aQtIHj2CzsphCB
         Ek1H0GOtr+6q0xsG+3+UPIgInvl1iJ8BIXpMTVMBDzy9LO+KhvOze7iKEDqhlqxqMWeA
         0tRpIgfSPDjAbpC5UGjZVyk+yrYBcThqFFcRlUTuNaowseaOn766bxxB0kGY2FVUu7h9
         A96V656irclv6rGGmI+FYcCoLkqcj7CxEZaPxEvhAyKEn5/UkrXIeuHoBGhYe94BGBKC
         VBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694118947; x=1694723747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atXeRfE0mDVD+y4O/MdfuuYUpZQSWnCC9q6t9PO21FY=;
        b=HuLZyPSkct/EyKbRhLM0wSkntYhVStXm5yDwB0uW2FYApLmlB9GhxUKmPoFJVTqYYq
         SwyWa3iTtFmoZE+WR/pTyIeeumnzq+PM3Boa05XRitY9b5D7ANnVw0IgVK+/xskAH/a1
         Cmwc9u2PYFs1tggeTFhOqtzxsVhEKnEPkzh8ag2Ql6zIEGJzjh8peq43820EsJG2LgUM
         jUTPXAESmwYU/BdsFwW+tMjKXeXUNTgQ9YDbp0ZQmrGiX/Ifi6mk2WlllVZ2F8CLdwoG
         g8F9ZKCtXcDfDzLKRYHlOnT+PXAeHW25G2WaVCY4sZjQ3YDxF3+Ph1f8rpwcfdhAOheO
         3ojA==
X-Gm-Message-State: AOJu0YwZtUlQo+nLLFVYOg54lEEj5GSOZhFFHtZRgmxOrmm3cXVIJ3H3
	b4SYIALQTWXW4T80+44Q2HXiUkpYNej0ONV2wJE=
X-Google-Smtp-Source: AGHT+IHQgKl78meaetXXT4xDY6BAAubYGNNjBqHcpuJus5so0qj1XzRqjTQ54486HMH4q7jsDqsjZ/s2AkNIq4meyWU=
X-Received: by 2002:a1c:7914:0:b0:401:daf2:2737 with SMTP id
 l20-20020a1c7914000000b00401daf22737mr500707wme.30.1694118946632; Thu, 07 Sep
 2023 13:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814070213.161033-1-joshi.k@samsung.com> <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com> <ZPH5Hjsqntn7tBCh@kbusch-mbp>
 <20230905051825.GA4073@green245> <ZPduqCASmcNxUUep@kbusch-mbp>
 <20230906154815.GA23984@green245> <ZPnvM3kNSHVA8x6Y@kbusch-mbp>
In-Reply-To: <ZPnvM3kNSHVA8x6Y@kbusch-mbp>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 8 Sep 2023 02:05:20 +0530
Message-ID: <CA+1E3rLrj+hWr-c2n-9dX=fQj_-Ch2tgZQfwrc1BNL5orMbyYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough metadata
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, vincentfu@gmail.com, ankit.kumar@samsung.com, 
	gost.dev@samsung.com, stable@vger.kernel.org, 
	Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_133551_221877_FF93926C 
X-CRM114-Status: GOOD (  25.95  )
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

On Thu, Sep 7, 2023 at 9:11=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Wed, Sep 06, 2023 at 09:18:15PM +0530, Kanchan Joshi wrote:
> > Would you really prefer to have nvme_add_user_metadata() changed to do
> > away with allocation and use userspace meta-buffer directly?
>
> I mean, sure, if it's possible. We can avoid a costly copy if the user
> metabuffer is aligned and physically contiguous.

Seems possible, but that does not really solve the actual problem
(which is not performance) this patch is for.
It will require replicating big code of blk_rq_map_user_iov() for
integrity metadata and map the pages into bip.
But since the user-space meta buffer can be unaligned (and bunch of
other conditions present there), it has to make the meta copy in
kernel-space.
And we will be back to where we started - how to avoid corruption into
kernel memory.

Same situation for the case when we are dealing with
extended-lba-format and interleaved user-buffer is unaligned. .

Handling both these anyway requires adding the kind of code/checks
mentioned in the previous patch.
Do you see another way?

While I agree there is value in avoiding the meta copy in general and
I can look into it, but that should be a separate effort (with focus
on performance).

> > Even with that route, extended-lba-with-short-unaligned-buffer remains
> > unhandled. That will still require similar checks that I would like
> > to avoid but cannnot.
> >
> > So how about this -
>
> There's lots of bad things you can do with this interface. Example,
> provide an unaligned single byte user buffer and send an Identify
> command.

Not sure I follow. Do you mean the patch does not handle these cases?

> We never provided opcode decoding sanity checks before because it's a
> bad maintenance burden, adds performance killing overhead, couldn't
> catch all the cases anyway due to vendor specific and future opcodes,
> and harms the flexibility of the interface.

Given the way things are (integrity schemes, cdw12 etc.), I do not see
a way to avoid opcode checks.
Flexibility is not getting reduced in the previous patch. All the
other commands (beyond read/write/compare/append) remain untouched.
And metadata-io is not the fast path at the moment (given memory
allocation, bunch of extra things by blk-integrity, bunch of extra
things done by device etc.).

>The burden is usually on the
> user for these kinds of priviledged interfaces: if you abuse it, "you
> get to keep both pieces" territory.

Not sure I got that. Have you seen the crash mentioned in this cover
letter: https://lore.kernel.org/linux-nvme/20230811155906.15883-1-joshi.k@s=
amsung.com/
A simple unprivileged read by a rogue application can wreck other
applications/system at the moment.
Is it fine to keep the status quo?

