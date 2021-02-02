Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A71C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 18:01:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FE464E3D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 18:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FE464E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0xE82TgYi8JGOCD2j2xxlpsZnGTtOCruSYECUickYMw=; b=KpTWlKbGMek7xhW+XZVFWUQDp
	4JpsuJUyYx3KMZMja7PUEm4WoQOg20eb2KYNM31gR+y0HmwY3a40joRpfht8aBjLMjrnHja5yAHS+
	alG19QZc0b0CEvxcmqNo46b00btO1ZAHXmpK/VQtCdtQz0y4IRpJnh4fdB5jENtetgplMx/LymoP1
	bb12Kv2Hs8pEu+jCeovXzLiDrHzFwhQAa2GHZSVePAeCooA75lysdsvMl2UtUp3bPHVVKLdvJIFUw
	R/4f3Q5aseV+thmcGSg30216YeHc3/bnz4ovLAvkic8Jfy8WUvu55gZSNosmuYT0aypd86UfuQXzE
	TQActo7eg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6zzB-00024X-Bu; Tue, 02 Feb 2021 18:01:09 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6zz8-000242-P3
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 18:01:07 +0000
Received: by mail-yb1-xb32.google.com with SMTP id s61so18029377ybi.4
 for <linux-nvme@lists.infradead.org>; Tue, 02 Feb 2021 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v4jAtr3w+KdVnMekpGEVkBsIg1dKPD9qhThdBp+S/l0=;
 b=FQ7IY4mh+nYpIKM0TbDjFg2JoaOKUnc9PM1kdDo+KL1Cs1mIV97aJhZQ+lnE7/cS35
 6zg+ndi7ZMkt+wtmb6Q3SX8MNhU4CWO/ywhyPnKbD9h/BZn1tiCdQfUXTCASSLEFCUuO
 eO64hfgBrtT2RmtPq+Z8sIgIUez/+rDZ+9QDAmZt17TXIYmA+jNOvqg/vyhB8lo1LNjm
 02fi44eXdzBKISazTQ5JtcuehQzraBZm6DmB2VZNTKlmFFMpSVO7x8OzRiU+Qwj2T0XP
 e/B+CSjLRLcCjeWjUm7ekPX7oBLQU/rYOR4Uo9/qdx1ZOShEw8v5t7sctdwUMgWKih0e
 l65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v4jAtr3w+KdVnMekpGEVkBsIg1dKPD9qhThdBp+S/l0=;
 b=OQXimYUQZnaLLWd4daI5/KwSPkrc6I+3dKw11S5Mr7BOPOCtbo5ze68OrcXbCriXnZ
 oatwB9Z4jg5hxPb3B0LJwewo5gLi/TEBEP7oiqodUKtOwQ6sozMCKFkVUCDvFD7n16or
 ov+2cmvwwbJMFXIYkh7KAcSptzkxJbIfg+NpTTw4bMVK4t09jEDseOFmouOpOFlIP8bw
 lEzpzBHKiyojcjkmfSHeyRgbm32QKGhvky+325zY94kKstxXqGyYPP9SNopvVHDmP2E1
 59PApkyFV6qHlNX3V+pR6kAZHU9n/I1Rh41YV9gQsC736ezulYMlwyV/c1hYSAEv9dm/
 kUTQ==
X-Gm-Message-State: AOAM5336WAyilAugQCthwxURCa0SqkzF9X0eOW1k1TEiNO+dkuQPsr5J
 cJq8EoSmw14tvQ6aqplKoXXGNwcBYTvRiiAuSKs=
X-Google-Smtp-Source: ABdhPJwkbvEbSU5cXXHfCmdD7X9SOuvrzPZ7/hIWOP+T0GImF/6eC+Xwn+3saCPR12kXniMMzTsP+EZj+GdVvLN5Gvk=
X-Received: by 2002:a25:ba13:: with SMTP id t19mr34846787ybg.129.1612288863285; 
 Tue, 02 Feb 2021 10:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-2-borisp@mellanox.com>
 <20210201173548.GA12960@lst.de>
In-Reply-To: <20210201173548.GA12960@lst.de>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 2 Feb 2021 20:00:51 +0200
Message-ID: <CAJ3xEMjLKoQe_OB_L+w2wwUGck74Gm6=GPA=CK73QpeFbXr7Bw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 01/21] iov_iter: Introduce new procedures for
 copy to iter/pages
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_130106_842206_B0CC18E6 
X-CRM114-Status: GOOD (  21.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Or Gerlitz <ogerlitz@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 David Miller <davem@davemloft.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 1, 2021 at 7:38 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Feb 01, 2021 at 12:04:49PM +0200, Boris Pismenny wrote:
> > +static __always_inline __must_check
> > +size_t ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> > +{
> > +     if (unlikely(!check_copy_size(addr, bytes, true)))
> > +             return 0;
> > +     else
> > +             return _ddp_copy_to_iter(addr, bytes, i);
> > +}
>
> No need for the else after a return, and the normal kernel convention
> double underscores for magic internal functions.

ack for the no-else-after-a-return

Re the double underscoring, I was not sure, e.g the non-ddp counterpart
(_copy_to_iter) is single underscored

> But more importantly: does this belong into the generic header without
> and comments what the ddp means and when it should be used?

will look into this, any idea for a more suitable location?

> > +static void ddp_memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
>
> Overly long line.  But we're also looking into generic helpers for
> this kind of things, not sure if they made it to linux-next in the
> meantime, but please check.

This is what I found in linux-next - note sure if you were referring to it

commit 11432a3cc061c39475295be533c3674c4f8a6d0b
Author: David Howells <dhowells@redhat.com>

    iov_iter: Add ITER_XARRAY

> > +size_t _ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> > +{
> > +     const char *from = addr;
> > +     if (unlikely(iov_iter_is_pipe(i)))
> > +             return copy_pipe_to_iter(addr, bytes, i);
> > +     if (iter_is_iovec(i))
> > +             might_fault();
> > +     iterate_and_advance(i, bytes, v,
> > +             copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
> > +             ddp_memcpy_to_page(v.bv_page, v.bv_offset,
> > +                                (from += v.bv_len) - v.bv_len, v.bv_len),
> > +             memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
> > +             )
> > +
> > +     return bytes;
> > +}
>
> This bloats every kernel build, so please move it into a conditionally built file.

ack

>  And please document the whole thing.

ok

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
