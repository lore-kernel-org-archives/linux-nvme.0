Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E95C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jiShGtojbtei6ru7Rg43iaSGCOOZGeuSo6qhSodDu4A=; b=xSJ22VZZIXaWcjovKgUvZPhfi4
	n3hMYX3O04prFxStaNzGCOmofgU77DyOkVdMQf7KbsTlmmSGqEw9bJBqcI+IsTHVGksa6+PRzbZoB
	jsqulzm2nyUc2Pb0IXawSedcIQyqkAfib62krzu5+5G6LkPp3FZ7kpbpVnjqWLMlFCsPssu16izH8
	iPoTg8fuNFLBNlTyQNVLtMb6KrbOY0bvb8IazWpWD55C5T3dJB2kO0Kuyb0qmeZCuWhYXiJktfzfV
	gppRVhCYltadcbfHi6IGO5e/DVF1wATW6BhHQ11QvO6XedESpM55axwOeRcLFG5sm0DHZMqosxLuJ
	sa53Ostg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjujr-0000000E7dl-2DKi;
	Wed, 15 Jul 2026 08:13:07 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjujh-0000000E7VZ-24Ed
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 08:12:58 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-69c7c8accffso6348645a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jul 2026 01:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784103175; cv=none;
        d=google.com; s=arc-20260327;
        b=YfQqsRTtwp3YdZLYI9uNhe7uGLjjPfVS/KkxhwYsmzj72ozYL0t9P+jvcW7RNqtxBV
         jFC6isvc41GRBOg5R248PyTZm20p5FVj1FOzREmM6KTfnT9vcBv0HsjsJCvvzaXdyYyO
         Ae+m4HjaWTEI4w+xWr+E7uOxLTNC8LUkY8A9/Yb8BlQDX/VzROogs12PSSHnyZ9Wgr+6
         bqoEm+JCwCfyV2yTrS3qMS00gtvD2mwS31XbLJsES+v6ul8YTuejf/eiHIC5n10vm4NG
         I3yGmdiSe4fhZsZll3LxyN3OKDHkXBGq0MXRe5pnhTLZ2amSpj0CL8L/CzvP4bzhjqv1
         bgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jiShGtojbtei6ru7Rg43iaSGCOOZGeuSo6qhSodDu4A=;
        fh=8kQKV2/zdMVWxyGFmVTlgTCwq9y9I7zF9ZMcCgbiBww=;
        b=F+kf7sP0VpifLrKq0zebBH7SwiPl35d8qnXx0Na4XgNjZUYg7vA0jRCcJIdLV7QBGL
         exUXXviyMWV+KTM491as1VewTJqzdQtuCllc3Pp1x80oN6tN2+1bY8ATkyK7aSxbqP7q
         3VUhJgyd5FNsM+HuMpXKZ+m1TzZy074nXn8mDgdwdTt1q7I4c3VCqdl0rqUbOt+hqu33
         X/R+HYLNo9yV7dJ6/heuFNKv19EAlu2IsREjfFbbhyIk+Sym2D9TXjMyYtT38Lt4U2hw
         lLNBjPcfW/fghuDY2ZdaLoRATJ9o+EJBlTRGQbljptolxt2WNoo1JMhrPhDO+bXGSGxX
         YoBA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784103175; x=1784707975; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiShGtojbtei6ru7Rg43iaSGCOOZGeuSo6qhSodDu4A=;
        b=VauhKyZNHFeCxPb4VTXd5mB/EQuw7ZK5TS77uUZSbFIH0mOGG2xN3ETi0VUoJSnHNZ
         7V++KqjeiUxIJMaTUNkvKV1KXvKXhwyO3bqEyDfpl43n6FZHBk5m+HjvIr+bcxf/Rh+W
         VU8n/CCtazW/5sBmCf2+qT/3rbtTLNcoHMtBjYtcS+JgmhRrr1dt3DPYRb4vpMGAC/ZA
         uFdkt3crvIo4lzS8Al4fgvJ/DuvMEm4K2Db8Uj8lyEmwwq1a+9Elbpw5S6ldm75mT6lX
         um/pU564b0ljrFgWbGp0nSunVkLvz8nhCo3JjDCxRCWg0xZ0oUx1cZu7OzX/1XJloW/l
         74sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784103175; x=1784707975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiShGtojbtei6ru7Rg43iaSGCOOZGeuSo6qhSodDu4A=;
        b=NNBvsRPVkoVDHVOS+mBfImVIpvirye6zBpwPWa+6QtoPGgNS4uf+vs7ZxN17q9ofZ+
         Nk38kO7GKI4vgkWF96TxA6EDDNFXKE8deljqLTsDmPKurjqK0sGGzVf+AOgiSYhwf8ny
         TP8730kn+tEbjuo2bjawGJ68y7jlgO07DCOrgMwVM1UjAEvgopK9UA7p1G0D4iLeIjvb
         sNU5E68qfZ76ppwM34SXUrXULUyfyWm1kOIoYpCXqFH5rcIVQ+rm1W22ESHC2z7jmIpe
         YQbC+rJCWobTMC0TIJz9j19ruO62zzcOidfymKTK3ae/Y3eEvcIStmuld1bMFvf5lcYH
         RKUg==
X-Forwarded-Encrypted: i=1; AHgh+RqrlIr9Q0vllC4ZQlrkhNjWcTwsxvYqlv4Ra8Tqbu72wBCWayTShMh5u4aka9s6c+X9qBMVy0aNinDv@lists.infradead.org
X-Gm-Message-State: AOJu0YxqPN1DVOcg0qeLLz7xJNWfDW7MfRe9fBSUfK5HpFEkyTDeKhfo
	R9JztGFKT3GOvoUjrTPeKtgkvCCTcd2BIQkkdoHhdx3tgqPCXmh2iNo+Yf5VoD5nGV1hfZhwNrN
	+VWZYqJPZ2vJgnjiu5rEixmriGYEdwyKaTeDabeX/tA==
X-Gm-Gg: AfdE7ckB4bPqh4K4NhJ2TZm8Dlb9A+YnU6t0DgWwaoEPVldT2buo+I7oiZ2lcBvWmCt
	lBPTOp8MLUAmLXai1h5yUwXGi5FsRRwLdoAe5rnM5wb6U8kdrBp7BDnF0Ca2qBy3PpLks/QuXqO
	t9tfNzY1EdP8eDL3frSQRzboljI2x/nfzuIXzdbNracgXfe1J0fCp0w77Wrn+3Tox0vYiFTAqpv
	+MZmHQajL6BdifJtYsyHONGJuX2tIXriNoZzjCsjuvsOlWW7xxB8wdZmr+cSzEPPB9hPFwNuw==
X-Received: by 2002:a05:6402:1464:b0:698:415d:3191 with SMTP id
 4fb4d7f45d1cf-69e199c3986mr993836a12.22.1784103175380; Wed, 15 Jul 2026
 01:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260523225629.3964037-1-coshi036@gmail.com> <ahcAaPTOH9ELlAA4@kbusch-mbp>
 <20260528084303.GA8199@lst.de>
In-Reply-To: <20260528084303.GA8199@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Wed, 15 Jul 2026 04:12:43 -0400
X-Gm-Features: AUfX_mzOTUpataKa65tmLFDMymggqLWs7nWGigjJF_wZK5tqZginPFYlTemD9CQ
Message-ID: <CACd_6n0yD0v7NN+11PU0FbN0SccAQWjATMYABsnY01u=k6XDAQ@mail.gmail.com>
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set Features
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_011257_566667_46458A8C 
X-CRM114-Status: GOOD (  21.45  )
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

Sorry for the delay - I was analyzing crashes and preparing patches, and
had a paper deadline. I'll respond promptly from now on.

> I suspect we're best off splitting out the admin and ns-command set
> specific parts of nvme_cmd_allowed into separate helpers.  And maybe use
> a switch statement on the command as nested ifs become cumbersome in the
> long run.

Agreed. v6:

- Split nvme_cmd_allowed() into nvme_admin_cmd_allowed(ctrl, c) and
  nvme_ns_cmd_allowed(ns, c, open_for_write), leaving nvme_cmd_allowed() a
  thin dispatcher, and switch on the command in the admin helper. Semantics
  unchanged.
- That fixes the long comment (it moves into the admin helper at a
  shallower indent). The nvme_uring_cmd_io() line is a caller, not the
  switch, so I'll hoist a local open_for_write there.
- ctrl stays: on the admin path ns is NULL (Keith's point), so it can't
  come from ns. Tokunori, a flags bit would encode the transport, but flags
  is about how the ioctl was invoked (vector / partition), so I'd rather
  keep ctrl - it lives in the admin helper, and the I/O helper uses ns.
- Keeping NVME_FEAT_AUTO_PST rejected - agreed there's no real reason to
  allow it.

I'll send v6 shortly.

Thanks,
Chao

On Thu, May 28, 2026 at 4:43=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, May 27, 2026 at 08:32:08AM -0600, Keith Busch wrote:
> > On Sat, May 23, 2026 at 06:56:29PM -0400, Chao Shi wrote:
> > > +                   switch (le32_to_cpu(c->features.fid) & 0xff) {
> > > +                   case NVME_FEAT_KATO:
> > > +                           if (ctrl->ops->flags & NVME_F_FABRICS)
> > > +                                   break;
> > > +                           fallthrough;
> > > +                   case NVME_FEAT_HOST_BEHAVIOR:
> > > +                   case NVME_FEAT_HOST_MEM_BUF:
> > > +                   case NVME_FEAT_NUM_QUEUES:
> > > +                   case NVME_FEAT_AUTO_PST:
> >
> > I may have been overly restrictive with suggesting AUTO_PST for this
> > filter. Messing with the other features will break something, but power
> > state is just user policy. The driver may undo the user setting on a
> > controller reset, but so what?
>
> There's really no point in allowing it.  Just as we should have never
> allowed low-level config of any kind, but unfortunately nvme admin
> commands are a horrible grab all.

