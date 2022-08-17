Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C5FC25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6QBF8OUU8w0EMBfU5E9Y1uiD/NcvMC8accXIwQQECM0=; b=n0epMi2ZSiBvwvVrugz8gf98e8
	s8+Ff2J7Zj0blNUJ0Es5NzSr7tMsjLoQkD+a7W4QFoo+YEjo21EjSPXYYjWIns4TmCma1QHic+xqA
	9rrIXXvyTxAWZKu8Qkapr3ETvlThDE0q08AKVOo3XdbHQZ+yycejMSLt33UV/q7IjT2wVv3h+h4+3
	/r9NtzrApmW4m9dh7o0Aof70D3osU/R778yaKZrLNx/M32ow5f0Oob4lGjBTdmv3aS+xhEmaK1q13
	S82IoXj5/9uCwyd/efG5x6oceNu18wcS7R9wCoBUMKWTJegkglsKDr/2HtCepPw16ulKx8Nsvrqrr
	HleebZ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOHlG-001iyY-Je; Wed, 17 Aug 2022 12:03:02 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOHlD-001ixF-GE
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 12:03:01 +0000
Received: by mail-ed1-x52a.google.com with SMTP id b16so17198580edd.4
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6QBF8OUU8w0EMBfU5E9Y1uiD/NcvMC8accXIwQQECM0=;
        b=Kbpe8F04LfFeg75euDy4hW+5X9Vjk0c5vTGN+38syf9GnoRt8pbKyaVNnmv5fmTCNk
         HlOPQqKaqAYBQMSvEZLf9I60FRXyRoPFD8ZCeCaMsstiKpIlEs0c+kR+aFYeVsz3ZKFB
         ZZvU9GG9S02FtZK/gwsgrjYa3zh/57Pa5SNGBaHnUxlatsfv5E0BGAS7rMnPO+5bBort
         73Kb7uS55ZPWKPP11pFoXFwxf4ha9yC0E/MBcf6ZVkxZF42zxWgHVUVpuFXhPZ5n+9vP
         U1BHWkBNERyIio8tpMpRZYlLdtPOIcWU3C4x/V+hmEV/u3AoBrmCFKayONJTUYA4wt/G
         nuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6QBF8OUU8w0EMBfU5E9Y1uiD/NcvMC8accXIwQQECM0=;
        b=QA6EuhD9Wr0NWKVbWfVuEB3QixAuqueCFXE7NYxEX/4w32JYlk3pCuk3JiMOUF/xqw
         v2GQU8BO9tZbpCDpp6yJIMsU5hhvhUD21T80//3DZKCeebZ9qPytXvlhpRYkV2yr1qfj
         JAD5MpaLMXfwlziMsXwwLvVPRV2AGM02b1iAt8vVwU+1+PhGAR1lZNu+c4OeP5GKwFS0
         iSEI7IaNyznab0YQBhOOtyG3+2eaPW25XRiJKF3E+QsljfBFBMTbaL+4MTfysA1dpQmk
         b5aiz9FPtYTTZTNktS6eHMVD/bAEbWW6Zo5wKiUwjsvUypW7tEHU7UakBzY+kRv4cNwj
         pDkA==
X-Gm-Message-State: ACgBeo2QKa9JqmnoFbLLnUuGD2K32DwkYa0IKW1DHsF8uXU1Q5dVwpvY
	bRNhL6+y0wwpyQxEUtDhpHU=
X-Google-Smtp-Source: AA6agR4TmWchQrV9/rpL/dcNvKrGk0AHACleyZyoz0eilW/dtlO1i1O5TanqRUYeEQRrXbUm+kr9jA==
X-Received: by 2002:a50:9f44:0:b0:445:dfca:87da with SMTP id b62-20020a509f44000000b00445dfca87damr1991538edf.105.1660737777226;
        Wed, 17 Aug 2022 05:02:57 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id fn4-20020a1709069d0400b00730bbd81646sm6629934ejc.87.2022.08.17.05.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:02:55 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Wed, 17 Aug 2022 14:02:54 +0200
Message-ID: <3177256.oiGErgHkdL@opensuse>
In-Reply-To: <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com> <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com> <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_050259_582578_538A65EB 
X-CRM114-Status: GOOD (  31.17  )
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

On mercoled=C3=AC 17 agosto 2022 11:44:09 CEST Sagi Grimberg wrote:
> >> Therefore, I have two questions: am I right about thinking that the pa=
ges
> >> mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL?
> >=20
> > I think you are correct.
>=20
> It is correct. It is the same model for the linux scsi target, sunrpc
> etc.

I'll try to address the comments from the two last messages from Keith and=
=20
Sagi with this email (I replied yesterday to Chaitanya).

=46irst of all: good to know that it is the same model for other subsystem.=
 This=20
is useful to know. Thanks!

> >> If so, can anyone with more knowledge than mine please say if my chang=
es
> >> make
> >> any sense?
> >=20
> > I think it does make sense.

Thanks, I'm glad I was not wrong :-)

> > I like the code simplification, though this use
> > was't really paying the kmap penalty since, as you mentioned, this is=20
never
> > highmem.

Correct, however everybody like code simplification. I added a couple of=20
sentences to kmap_local_page() documentation in highmem.rst. They clearly=20
state that, when users know that pages cannot come from Highmem, they may=20
better prefer page_address().

The changes to nvmet-tcp started with trying to convert kmap() / kunmap() t=
o=20
kmap_local_page() /kunmap_local(), but it ended up to code shortening and=20
simplification with a plain use of page_address().=20

Obviously, due to my little experience with kernel developing and less than=
=20
little knowledge of this protocol I had to ask whether or not I was right i=
n=20
identifying the site of the allocations.

The reasons why I had to use page_address() will be clearer reading what=20
follows...

> Yes, its the same code-path. Would be great if we still had an
> abstraction that would do the right thing regardless of highmem or
> not like kmap provides though.

It would be great and it is already possible (this is why Thomas Gleixner=20
created this kmap_local_page() API) but here we have a huge issue. kmap() a=
nd=20
kmap_atomic() have recently been deprecated and they shouldn't any longer b=
e=20
used in new code: https://lore.kernel.org/all/20220813220034.806698-1-ira.w=
einy@intel.com/ ("[PATCH] checkpatch: Add kmap and kmap_atomic to the=20
deprecated list").

kmap_local_page() always does the right thing: users can call it with or=20
without HIGHMEM enabled, in-atomic (also in interrupts) or in preemptible=20
contexts, they can take page faults.=20

It doesn't require global lock for synchronization and doesn't require glob=
al=20
TLB invalidation when the kmap's pool wraps and doesn't block waiting for f=
ree=20
slots.=20

Nice, isn't it?

However, with nvmet-tcp we cannot easily use kmap_local_page() because it=20
comes with a major problem: it's local to the thread. If users handed the=20
kernel virtual addresses returned by this function to other threads, the=20
pointers would be invalid.

Here kmap() and kunmap() call sites are in two different workqueues.=20
Therefore, there is no way to convert kmap() to kmap_local_page(), unless t=
his=20
code is heavily refactored.

Knowing that the pages cannot come from Highmem avoids this refactoring and=
 in=20
the meantime it allows us to delete the kmap() and kunmap() calls sites.

> > You should also remove the cmd's 'nr_mapped' field while you're at it,
> > otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().
>=20
> Not remove nr_mapped because we use it to know the iovec entries, but
> we can just remove the WARN statement.

Ah, OK. I'll take care of this too. That was not my first concern when I di=
d=20
the RFC. The "real" patch must also address this detail.

@Chaitanya:

Since this is a mere simplification and shorten of code, I suppose I can sk=
ip=20
the performance tests. Ira and I have still hundreds of call sites with kma=
p()=20
and kmap_atomic() which we should care of, therefore we prefer to leave alo=
ne=20
everything that is not strictly necessary for the deprecated API deletions.

Thanks to you all,

=46abio



