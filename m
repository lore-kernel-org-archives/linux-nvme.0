Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CEAC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uzjBF4L1kdtDGwfaj+p66fHZ3xZG9riE5qCZwHUFQuI=; b=pbG7Gc5HC/tuXmwW5Kk2Ds9aST
	SSfQakdlpWXufTfopsRE0BSZQ5jXSOl2Prlh4RNvvFLsv1RHiq/kknz5dLDqd1vVbrE+hX8qrJpgK
	blF+HFTZoQPz0/8D8OM08vxSnyiMLYGjhZiaoZb/Z7g/4drFgSgk5G4ysdndMLHAivUyDCyK+wmjz
	xogDitoCY8H1DTeaB6BaL+YCglrSUP8hsfdUx0SPqWJwUNRHOO8COdci7/bdD6G125d1llEbpT6hX
	b1s1cW3WFGcGYD1mik2Bd8qFfEmZQ4j5T5EJ/gWBttQi1z04lQ5pHNQJ68ii6I4KBWz9C3ubj195B
	Qlp+onwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp0DK-00000007JQH-2gsl;
	Wed, 29 Jul 2026 09:04:34 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp0DH-00000007JPN-3P0s
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 09:04:32 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so568940a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 02:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785315870; cv=none;
        d=google.com; s=arc-20260327;
        b=RIhpBerVxv7GH6XEg5YALNmEiSUjpz56AknnyRV1taDNzfSL/B1Gvmha61P/gBRyWQ
         E1XsY4f1Wgvw+yi5gdsAFsr5zt/hfAPFWXs+ImyI7jQSMw5gcs6xYeBoBMmb8UWSuUDh
         Vf7fTOLU2E9XY7pCYagc/NgDPpK8Dc2ETgskl4XorC3oMU0ubo1TUwDjpsRyeylYVgO9
         /9hnj5pvubGCOsayknz4oB3WIxRgp2loIkbpDi1Cz121OBTDyyqO/Pls0iEACgMpqGw+
         ROqEipj0fBQCUxODH5cWCsuD/xskUbEhuajBDxnSWDONbdP2B/5TkxzREzrGqkaukKxP
         f8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uzjBF4L1kdtDGwfaj+p66fHZ3xZG9riE5qCZwHUFQuI=;
        fh=GXeVxhtqC3W4kQdHEwHAl6bi1UL5Z+NBJsJKnmkN7BQ=;
        b=BKPmBA/rKRWwANOfpHyVpzX/1yCX9jvFiXubEGXX8Am1H5l5nH/NRvoJKD7RyIMW3B
         +QK4mrNdd9Md4mPQgzfTpSJ1Kr1lsuqAjcBATA9V9nDzwMCd3xHt3aBoK5290YN4AlNf
         rqoI6pTU4isusPOhuJnvsyrlYQkPvbQ0IB8AgpccUC26kq1FV0coPBjh/bMcTMhQ4BRM
         7zTCvyzjHQZLestE4zADAKR6XpziWdoeo7Sjgif/x3QPNksAY+4gc1oMBpVX9MIb9pEg
         ZqFKw9GvI6xIw/e9hgErd4OkrJXrwaSuEwg1e6pDjUqcVuZY0pbEXXKHSfYw4EOGyJG4
         17uA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785315870; x=1785920670; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzjBF4L1kdtDGwfaj+p66fHZ3xZG9riE5qCZwHUFQuI=;
        b=PWzQcLYHpqBU7x2i31dvP7QQzZbVOQgAXsk+Z/xihUCVdMaLmn1zUzr1ke9R8MQZH3
         tGqy08Ai8BhQCOMxm6gYkOW755q6R/GigVvFQorQuIX/lOtl0revUq0NTEJjPq0SSFvH
         jgQwCg6yRMdjaJH5A1jZT/4c4Bu2HvFbH2Wf+3YgvA7xl90TYEuVTbXkD6rnoOOtr3+y
         +6bNfDOfWb6CBrbCsqYaWFi2jyPx2u8oShtuWkaYtoFX0a3HBNW3xcqCMGnUgBCAOtu9
         GGovp2FeEAp5PbQ9GcgYq4KBIyWHDi/X0BhuVtcnmIICNa2GSuJhsLlhiAJQSfZp+Feg
         RlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785315870; x=1785920670;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uzjBF4L1kdtDGwfaj+p66fHZ3xZG9riE5qCZwHUFQuI=;
        b=fh6zGpVYtOjA0qgvw3yxXP7LrsZYfrysklC7FySbwMApUn1blPF6Wnfr3x3kHwUPxa
         n6rq6aT51uP7sxu8kd9QenDeAuciLOXqeLtLWYBQ//fY1UQB0yBY7kMYN/DzUjwa/YH2
         2OadMTJDd52jZsrHe1dMMkxhBx8fLlZTk2hz+zG0UBWlzbKY5pQs2OshMcCVyeAdZdLQ
         ka3ZiWKk6OQ+vG4IIYGqVjlnhwgy9p5lFOoieqM5V7TBrF0ZJfTX+nw25qg3SGM9zWvG
         tlsChJ4W2QzkB3vvmyiIw3Nukat3+oHCFNHsmQw17+GU4CgYa5D5OsSMbu8bjm7FGxkC
         E91Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVwp25jKcODNJOMSqB6gSVbLNsfN37BjNpbcUlMLLAvazLuymtlUKJbSE6Tu8C22QRZ+ETK2H2Q/Uv@lists.infradead.org
X-Gm-Message-State: AOJu0YzhUK9T76cclHgKHnpYYzQ4ggOii5Hd/G2NmgsyiCx72NhgAdxX
	qy6T2Zdd2lmsZNFkI4bUMneKPB6D+tMfGPUn35ccBydKZkM6/Mk3ER4S/yYpbRMgdJkqJ8kjzaL
	v2wnFdQL5+rS4yLupWYDP5FrzjhXocaUbOTjooV3ynxMjwszdrIuiW56k
X-Gm-Gg: AR+sD1089rKmNs4emuE9+9PERHSd6+T+J9iLEJqCOElWDOxnKQ5yVQQXzCxb3VK2S0U
	g7VdyTCbuSQh8ASVWqo4xhI2dPAqDr0dKBqNVXXmdba1iZY3gHO+wNXMGN5hc0ppIvCE5w2wWa2
	S8WlESku3JWymZTLN98BGgbAyJVBqgVAquIwDVaXhzyiprL5MSi4j9KN5qRPKDgQnBQla0jqTK4
	Kpn7V9vTc0gSGYxtj0jjPiQHPK3hsq1bfi/5uKBYapPbtyP2bi/XDBPa8TfGSXDR7M1PmD0axo9
	OSawwVcm98t9Hgv9Rnp+FeSJSLDBNTgnfs9HDm9hPNOeRC8GFrJPaXTmEfda+jQZWqI/QNqvz/c
	f
X-Received: by 2002:a17:90b:4b12:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-38f834f9c9emr1591170a91.8.1785315869078; Wed, 29 Jul 2026
 02:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260713115444.465704-1-nilay@linux.ibm.com> <amjp4ymLa-u9iO_U@kbusch-mbp>
In-Reply-To: <amjp4ymLa-u9iO_U@kbusch-mbp>
From: Marco Elver <elver@google.com>
Date: Wed, 29 Jul 2026 11:03:52 +0200
X-Gm-Features: AUfX_myBV-mOBNaq4vDcn_jZSiCfqMAUHABNds2KnZdUP0jfYN-5_3M__IjjwHc
Message-ID: <CANpmjNN2+m7O206xFDRwyCoihsEr9J972pOFSa5Uc=xx6kkTHw@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Support Clang context analysis for NVMe host drivers
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, 
	bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_020431_880496_A82483ED 
X-CRM114-Status: GOOD (  16.31  )
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

On Tue, 28 Jul 2026 at 19:41, Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Jul 13, 2026 at 05:24:01PM +0530, Nilay Shroff wrote:
> > Marco Elver (1):
> >   list: Permit context-unguarded access with list_empty_careful()
> >
> > Nilay Shroff (19):
> >   list: introduce LIST_HEAD_GUARDED
> >   nvme: update nvme_passthru_end() signature
> >   nvme: add context annotations for nvme_passthru_{start|stop}
> >   nvme: add context annotations for nvme_ns_head::srcu
> >   nvme: remove redundant initialization of nvme_ns_head::requeue_list
> >   nvme: add context annotations for nvme_ns_head::requeue_list
> >   nvme: add context annotations for nvme_ns_head::current_path
> >   nvme: add context annotations for nvme_dev::shutdown_lock
> >   nvme: remove redundant initialization of delayed_removal_secs
> >   nvme: add context annotations for nvme_subsystem::lock
> >   nvme: add context annotations for nvme_ctrl::ana_lock
> >   nvme: add context annotations for nvme_subsystems_lock
> >   nvme: add context annotations in fabric.c
> >   nvme: add context annotations for nvme_queue::sq_lock
> >   nvme: add context annotations in rdma.c
> >   nvme: fix context analysis warning in rdma.c
> >   nvme: add context annotations in tcp.c
> >   nvme: fix context analysis warning in tcp.c
> >   nvme: enable context analysis support for nvme host driver
> >
> >  drivers/nvme/host/Makefile    |  1 +
> >  drivers/nvme/host/core.c      | 14 ++++++++---
> >  drivers/nvme/host/fabrics.c   |  4 ++--
> >  drivers/nvme/host/ioctl.c     |  2 +-
> >  drivers/nvme/host/multipath.c |  9 +++++--
> >  drivers/nvme/host/nvme.h      | 44 ++++++++++++++++++++++++-----------
> >  drivers/nvme/host/pci.c       | 22 ++++++++++++++----
> >  drivers/nvme/host/rdma.c      | 25 ++++++++++++--------
> >  drivers/nvme/host/tcp.c       | 15 ++++++++----
> >  include/linux/list.h          |  9 +++++++
>
> Looks good to me.
>
> It doesn't look like there's a single source for updating list.h, so any
> concern with taking this series through the nvme tree?

I think that's fine; conflicts should appear in -next, but I don't see any yet.

