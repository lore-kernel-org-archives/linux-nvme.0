Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A76FCA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 14:08:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65FF20856
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 14:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X0d8a0Y1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6CRXgSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65FF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2rHzUQWiRe3F9H488yAdZQIv/qpiD2kRaA5aAijls9k=; b=X0d8a0Y13Cx4hk
	GvCNtqwh1PtMUwXk/ttOiVKePf7nUc9KwX0L0bnrtBX0IAoANGz00EYf3cs8R0znHN+rQmoRN5HrF
	rKD/QSVFjJQQrlBJZnomCXVPWlta9FlNKXTV6idxk1pi2fkr4WNpevgu/gj8EHvot/MB1Nzd/Uw3w
	S6aC0nd+gwxPHc+n/Z3YPGr/ak2QjMPZhC1Ze6Wlcul7QsoiUMgxdXp+pOIdfgfbfdO5LinMUJoY5
	2m0VnNyVlAMy9md8eibL3N7hBVf40hOtK5uRodGar8Oo33wGQM6p46nIvHFflGEXB7E+EAgK3evSU
	WcV8gx32S59lRjSIacYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPoeJ-0005YY-NQ; Wed, 30 Oct 2019 14:08:35 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPoeG-0005YC-Uo
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 14:08:34 +0000
Received: by mail-yb1-xb44.google.com with SMTP id q18so468520ybq.6
 for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2019 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1OlWOPJriabyyVtxCo3gW4qDibRk9EhEHuPHtaZr3j0=;
 b=a6CRXgSSfYSCoapEi0aMsU5fY74xtO1NHsJhOvMrCPsjpeElvXrJzYsXxDNa8UXEBV
 WFCw+eoSthLWob6XU39N5O5dH9UxGWyE9X6Pem2W2Ss0AYlMS5xQpCaeay+Q5Sj8aZ1W
 pLRjML5vkNuYQzJ4CcT/KPfYWEY+TCUOKxhYh7dAIVSWquaL7ktib+fM+oHG6/24/PHn
 3ZKInjhBc0G7he3OjXFS1A7fLSQEIQsIBYynu3nY78lH09WzcVXDjcMSsWtTjX2I2NB7
 QvIX0jM3SBARK0G5tTHc0awMohi/vbPe7hxi5t80SbShNYqSYLkhaNTGx4JwH6fWy2a0
 dE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1OlWOPJriabyyVtxCo3gW4qDibRk9EhEHuPHtaZr3j0=;
 b=mF0y4BV5t5/H5Wdo32j1+GsVsiWKDHHLUq47UqkjGLD3bv2rRKdZ20e5lAfSA38jFR
 rYC8pv+V3WLC/tYvGq4h+gZbsoeuUBXIJQOO+OoFyTRnwDeCbwvAnBrcFbJg1m1+OL6w
 Kdzh2G3rnuzf/PMCyHUYfzaZ3t04mwq8JNXaMoc2MtcJa0F+I6ppvUoo/Jbtpgi24Ig3
 xzFmko8uG3p3x1nv1s29jObxTOCwN9gLtZvW0SczMJix68PAlcXE15Pmo7aIQukafuZd
 LyM4Zxobl7wP9aQOXah9ZykKg4EQeYXptTWJ/QQn/JNYAmfavj8AgpmcjR62nv5z/wnh
 QzJQ==
X-Gm-Message-State: APjAAAWBe2DjpbGPC4CT239VBXzPmvzBnXhD/vSDwKCE1rWgNQ2s8jHB
 uMzU4Ig4Vv0Mdnk6w0lAcpkNYXuVAuOCNf2cIv0=
X-Google-Smtp-Source: APXvYqyq71AbKBEsLaZAldijTyTi+lpD99RXCknnqIzwrgSg3XxdTz/pkHxUyoENDlkxg1oYQHsMQXmAKncbzqSyZC0=
X-Received: by 2002:a25:d46:: with SMTP id 67mr3709081ybn.164.1572444510348;
 Wed, 30 Oct 2019 07:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <CANSCoS8HakAy6zHgEjDiYQ87z83RJy-OC9ZfktRJwr+9kgnFKw@mail.gmail.com>
 <20191030063233.GA16863@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191030063233.GA16863@redsun51.ssa.fujisawa.hgst.com>
From: Charles Machalow <csm10495@gmail.com>
Date: Wed, 30 Oct 2019 07:08:18 -0700
Message-ID: <CANSCoS895GAsmZQkvErgL+yDJ8wpNM3648RGrP6Ya0cEkTKVUg@mail.gmail.com>
Subject: Re: nvme_passthru_cmd64 has a 4 byte hole
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_070832_996472_7F191A99 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ah yes. I'd greatly prefer that. That way the new structure can likely
even be used with the old Ioctls and the 2nd u32 should just stay not
get set if used in the old flow

- Charlie Scott Machalow

On Tue, Oct 29, 2019 at 11:32 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Oct 29, 2019 at 09:43:20PM -0700, Charles Machalow wrote:
> > Hey all,
> >
> > I noticed (via some debug) that nvme_passthru_cmd64 seems to have a 4
> > byte hole that isn't currently accounted for in the struct:
> > From pahole:
> >
> > struct nvme_passthru_cmd64 {
> >         __u8                       opcode;               /*     0     1 */
> >         __u8                       flags;                /*     1     1 */
> >         __u16                      rsvd1;                /*     2     2 */
> >         __u32                      nsid;                 /*     4     4 */
> >         __u32                      cdw2;                 /*     8     4 */
> >         __u32                      cdw3;                 /*    12     4 */
> >         __u64                      metadata;             /*    16     8 */
> >         __u64                      addr;                 /*    24     8 */
> >         __u32                      metadata_len;         /*    32     4 */
> >         __u32                      data_len;             /*    36     4 */
> >         __u32                      cdw10;                /*    40     4 */
> >         __u32                      cdw11;                /*    44     4 */
> >         __u32                      cdw12;                /*    48     4 */
> >         __u32                      cdw13;                /*    52     4 */
> >         __u32                      cdw14;                /*    56     4 */
> >         __u32                      cdw15;                /*    60     4 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         __u32                      timeout_ms;           /*    64     4 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         __u64                      result;               /*    72     8 */
> >
> >         /* size: 80, cachelines: 2, members: 18 */
> >         /* sum members: 76, holes: 1, sum holes: 4 */
> >         /* last cacheline: 16 bytes */
> > };
> >
> > (Since I doubt we can functionally change the structure at this
> > point...)
>
> Well, there is no official kernel release using this structure,
> so I suppose even this late in the rc cycle, we can change it with
> appropriate justification. I think an alternative to padding is to make
> this a __u32[2] field, which should also be backward compatible with
> the 4 byte result passthrough.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
