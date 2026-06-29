Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5421C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAyiUwBMhn1WSR90Cj2k3s30VDjHU8igJCkAjSRvl4k=; b=YtsPd+4mbclmFpqWv06DNBNw+v
	OApvLWUTIt3e48GUmQ91Vmx/yogaKfKMvIbARwee91PEuQDEp7wmAt35+BaGP8EoWIfxpVKg5kWcu
	S2Tw6KtNcLZURpxUFBtKOYhRP5cpNGzt9BvOuB3NRpuWymHXi0eGHaOgunB89u4q/huB6z24QHlb3
	alh/rQaoRVlHGK6kQEzZp/Wu1bXZPRfVY44J7aPQ96XtZlkwU9R5chj8Y3Sl0PizXezUZwjz512s9
	QvRdYsFjSwPisBMAJvOzotN1gOnW4yJOMeKJfsZb8UYu49//WOIWG0ZVSOM8ziBtwySaedHSyASwB
	SM0IOegA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weLAW-0000000Fa4Q-0Tih;
	Mon, 29 Jun 2026 23:13:36 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weLAT-0000000Fa46-2ZA0
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 23:13:34 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-13b2b08a553so457691c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2026 16:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782774813; cv=none;
        d=google.com; s=arc-20260327;
        b=JvCjTB51FklGFMNFSoK2vubDZcvkR08C+0+QiMXHiBCorC1WJWUp4NEg8sUW2b+eyy
         fvHzy+VALE0jbB1S/+BKCo7ODHaJb9mrX86s/BrgWSfTinF0HhJ65pBwwEN4N5eBwFe+
         3JXbo1hsxsGVtNnEC9eB0+G4rw0A+17xwOKp9ezcLTuIULYW/GsFezvKTxiKHYVkD3sy
         YrSztecIcU90Ef4ycXkjiejo/LwSjnhJCeQKaSRcRwRZxaNRHDxA59I+PCm+uKOqV1rt
         rvHuUQpGB9XZ7YtYQLaNy/qsU8Y+UstkE8gyM26kflCYMqXavQOv1pOkqQHoXjmuFJ2F
         o+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MAyiUwBMhn1WSR90Cj2k3s30VDjHU8igJCkAjSRvl4k=;
        fh=x9iItr01B0JM/RsZHE6FEYpAlAIdzqqcXmPXtv4AU2I=;
        b=rTAjRUcRYdmknu66UAeX7jNvT6sTL+2waxKx4E8gKeBWqHIyJpwPA/kZqyBZ0rmGFM
         WgDpjJ0OlOdc8AMHjrL3R7nLmIvPdHDTqOiFX34LcssdbRZGLHgi7pa4MEKZI0tkUI2P
         /+TYWF/t/lN+//ZXb6M+KueE+2qOhQ7j/4RL7+V5OaHTDZ7d49g1h1H121wYQgklXXjy
         bjlX7u2pI1U6/Kbbps4aDUsrxta63F6NQqUdst6+3ufOB5Teb4H+H7P1/iObzPW3pKzx
         cOIJVxjrE/OKpdiajvrFpNT8fxXw5rHt5dIjbsN0MQftN2ss7LCHUXdw8yBKbBE7G0qx
         XN7w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782774813; x=1783379613; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAyiUwBMhn1WSR90Cj2k3s30VDjHU8igJCkAjSRvl4k=;
        b=XJsdEBg5CH18SfiU+Mj3enWfTz5Z4aR4bwAY0h4oooO8boZ/pjDBODl3XshLEUYrvv
         Q/4ujWwwq++/rsw5ibLSi8c/mYvkOBqK3+7ghwo8yvEyR45F/0/WHcUUO4E+Wc6xO3at
         xpXgGKalkmVIUfNch/oJaz/t2VYycE51KdkWrV4Xah9dQ580axMo6intIk1BqRYB+oLs
         OV2G4KY2RFacQDwvkf4m2frvQ6WBp9wvP9Vmbj4DwbodtUyfV2C9OfsK77BoG/COoXBT
         hVpODHCLoCrST0zZRTv9IQlbIoPeN6Ks/S2yoWQvUM4JDy5KIUDsVdkPI6LWhU/mRfCw
         PgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782774813; x=1783379613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAyiUwBMhn1WSR90Cj2k3s30VDjHU8igJCkAjSRvl4k=;
        b=srCkTRoWCOPQP0aNb+K4GfC0Wv8hfF9G16qMKxlNfnCqEXRolj1MyyAuu8p8WWAt0q
         RAKU4eGug51gO5zjZ4hZCPWL4jsz/ZQx+aAEfiQ3Rdl1ZJYtoimX75a3yv7lZ7QKZbSo
         KHbxvIh9EbrWz55otRmlhLLvga8B4guPXgtKgy/8I8bR3XWAHJDPl9MUrF5Rmb6XKvKe
         T3Z1aOslRaqBIVcghjHadI5QQ7bMmXGSw/IVTgXl9UfPhz0L7G7p/X/hYzxozBrbp35H
         GSCeTrgI5tXTnOhimuH0Q/UKDhvcxBkNnwzhbFoA27ARkzc4cVnNdEPnQxLWxBtzRrwo
         QWBg==
X-Forwarded-Encrypted: i=1; AFNElJ8B4XcvoQaar26eVNHh9sTCgSgvnqnENv/JoKHgUP1J876r4DuH2YODEX46JiVVJWJ6i/QtbXBAd7hq@lists.infradead.org
X-Gm-Message-State: AOJu0YxKjT9emtWNCvay+Jyx2FocOoWvMQndu8efs6JFytHvTvZB8Yh/
	QuW/n0wjmAP35hhDaCAo9JhpdrTP9Cy9/5EiQbxYWwuUow3Bf/jrx6aGyJGtGxnwN33nzoZdT68
	1cQbSLrV/DzZr5/tzJIt7rrcHRMyUryUGmx3FtHWj
X-Gm-Gg: AfdE7cniK43y5wQzukB2HLwFoX+yuKgVC9QGdsKP0JRUuwZ/FCdPjeuJ2TclXlBOZDF
	skYzIRlo2vmOH5kpRGgP95mAB5Up1lWQNqIdAW6Xa7FqRuHk4rMHROwU3Dq1sH7MolbT1KoBOEy
	2zMLcbCFMO0N21sytTKvYcpdx15ZEde0Uo5p0rzqv8VJI9HbQVvh0DmNAD6E0huI80FC9JxswsY
	ya/Zp4UIxbiEz8EF0pORtRjRZLcpIrnwM1eRJ13aQVraGzVG3D+Ehbls8M34Xy+zijph6oLvN5i
	nVGNUw==
X-Received: by 2002:a05:7022:ec7:b0:139:c7fb:ab66 with SMTP id
 a92af1059eb24-13b2a141a60mr901195c88.10.1782774812016; Mon, 29 Jun 2026
 16:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-8-nilay@linux.ibm.com>
 <20260626064335.GG10731@lst.de> <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
 <20260629124703.GB23417@lst.de>
In-Reply-To: <20260629124703.GB23417@lst.de>
From: Marco Elver <elver@google.com>
Date: Tue, 30 Jun 2026 01:12:55 +0200
X-Gm-Features: AVVi8CeNAFcXQR6t2aDkmprdyZHavA5d_2OH-9tHL2r2wz9wQHzxDWci-C1H30w
Message-ID: <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for nvme_subsystem::lock
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_161333_654328_CC24335C 
X-CRM114-Status: GOOD (  21.82  )
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

On Mon, 29 Jun 2026 at 14:47, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 26, 2026 at 08:09:52PM +0530, Nilay Shroff wrote:
> >>
> > yes correct, but this one is tricky as the list has to be inited
> > with non-zero value. Another way to fix this is by adding
> > context_unsafe wrapper around INIT_LIST_HEAD(). Again overuse of
> > those unsafe wrappers hinders readability.
> >
> > Would it make sense to introduce a helper, e.g. INIT_LIST_HEAD_UNSAFE(),
> > that simply wraps INIT_LIST_HEAD() with context_unsafe()? It would document
> > that this should only be used in cases where the caller knows the object
> > has not yet been published and therefore no concurrent access is possible,
> > such as during object initialization.
>
> I'll leave that to Marco and other core people, but I think this
> would be a lot better than the current version.

Initialization of guarded objects has gone through a few iterations,
so I don't want to open that can of worms again. I think the
infrastructure we have now provides various options (the scoped guard
machinery isn't the only way). You could just write:

/* Initializes unpublished lock-guarded variables. */
context_unsafe(
    INIT_LIST_HEAD(&subsys->nsheads);
    // ... other guarded var init in same block ...
);

context_unsafe() has a statement expression inside, so you can have
multiple statements in one context_unsafe() block.
And leave the mutex_init() where it was if you don't like the scoped_guard().

Although here you just have 1 INIT_LIST_HEAD() that needs that
treatment, so "context_unsafe(INIT_LIST_HEAD(...))" would do -- it's
just 9 chars more vs INIT_LIST_HEAD_UNSAFE(). And as soon as you have
several guarded variable initializations in a block, you can group
them as above.

If you introduce INIT_LIST_HEAD_UNSAFE(), that'll create more ways to
initialize guarded variables. I'm not against it if none of the other
ways work for you, but expanding the API surface also incurs a
complexity cost.

The simplest option is just adding __context_unsafe(init) as an
attribute to these init functions, although I see they do more than
just trivial initialization, so keeping context analysis enabled might
catch real bugs.

