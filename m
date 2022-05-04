Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89692C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFIh1CyhYoOEEs8kbWR5yCunmbCgcWGITL6fTjmMnQw=; b=KYgaaQr23fEGwsgpSysdqE4vpv
	xJ++ySlACIKNPiZmuo9fozyNXOMhiIUn0hZzjBdK7dySps9PglZ95BeXahegjcNiG99uxJ6RuMAtm
	fitfPq3BAlSRhICHzqW/iwmeNFgUkbFZioDd6xVvbM3cnw5GS8NBSv087Gy4GHQ6onGFpwpm5MDGb
	68Cw2In8j1fWFPo57NeP3O/BBEjwnv9Lgh9g5/9dgWKPypo0bGZzdsOfrvzPdfSwgvrEkZpkMH4L8
	hm4ZznYEram6NRtIGOmP97n5QraX3/070lSusSCLGLyEKrnJ6UZJubCYQnBRlgd7knUVNOGluL2eQ
	Bx94wyTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmAhA-009eRE-Ap; Wed, 04 May 2022 08:49:16 +0000
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmAh7-009eNy-BQ
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 08:49:14 +0000
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-edf3b6b0f2so162637fac.9
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vFIh1CyhYoOEEs8kbWR5yCunmbCgcWGITL6fTjmMnQw=;
 b=g3ePdZbj07z/SQtZ3q6Rvxl3hsnUQAUpl5+QnU/2JrBT5r6FbJnGqMdBolz8IJYg/a
 MnPEplvJnmewM04s9hF7speIY4qJveoHobQV4IiZQ3BPczLXKnYohQHLx5mxO7+cqyB2
 FTkJSbHIOs64B5/Dq2JQwiyYBt9EWvy3GEEA7JM0EwcvsYHrrUYbsTdrUESd4T0+77It
 g8SYWDsbdnQX3zKUVrmHv6EUWSDWU7GzP9lmDfebbBYw0oGgUxJeuAwCSVA9KR+mXFTk
 /AMqtYj4N0RR6o6yQCPoYXrNsYt6JlLNYN2lSOqRFSMWpD/LhNLsqGKXTJxY30nWaYwj
 pcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vFIh1CyhYoOEEs8kbWR5yCunmbCgcWGITL6fTjmMnQw=;
 b=3dBkMsWq1eMMx8P7IvG/wN097Cxpapt0kw6A5Noxi6JM2HNkaLqAJXFE7LhFUxFfgm
 nd2qhN66EvueAtVWuMK5N95PqjR4jq6CgiaJKfEsVwArolMEGOjEmSb8qKE+Di8qHzLY
 6O1lAOZf3RQYL6uwBZ4kCRBYbQfxGIlFnh1Vv6oKBkf0eKBfKpqvyrP7B9Bqsg3f73Sd
 IbHH3AzGXZiAJ/d+rXAs3gwpvIUN2Y/9fmhMhBc5FhHhW/3JhFn/gjFi14XgZMNkt7kt
 Jx+Eab1vOlrrIAYF78Iq2cAzBg+gZEIyUpIN24jCpirgyypJKR8qEkwub0ycGuKuKPHB
 78UA==
X-Gm-Message-State: AOAM530fhvQHUhdIqpwVOnP34J3SWmL0rs1xqKAgEywF9Hsmj1RxMDda
 GoroC5RxR0afNjWJXT/8vRVJUsms4grJVb1tyCU=
X-Google-Smtp-Source: ABdhPJwEx0kAfrKjWjHXKJcaJcRGuuwzouzNqXc0CoN/T++pLVvZwPv9SFOZUZ531V61Al+1pH/gUzwuBPJSvDTlur0=
X-Received: by 2002:a05:6870:c392:b0:e9:f20:fa8a with SMTP id
 g18-20020a056870c39200b000e90f20fa8amr3234278oao.15.1651654140641; Wed, 04
 May 2022 01:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220503184831.78705-1-p.raghav@samsung.com>
 <CGME20220503184912eucas1p1bb0e3d36c06cfde8436df3a45e67bd32@eucas1p1.samsung.com>
 <20220503184831.78705-2-p.raghav@samsung.com> <20220503205202.GA9567@lst.de>
 <CA+1E3rKe6G8UC9Pzkm4Wbu50X=TT5tise8g6umduhj1eTbN0+w@mail.gmail.com>
In-Reply-To: <CA+1E3rKe6G8UC9Pzkm4Wbu50X=TT5tise8g6umduhj1eTbN0+w@mail.gmail.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 4 May 2022 08:48:35 -0700
Message-ID: <CA+1E3rKdAWAKbEGugpWGNrxVQ7FzPLEPsCyT63nhqWTWTum5oQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] fs,io_uring: add infrastructure for uring-cmd
To: Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Stefan Roesch <shr@fb.com>, 
 gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_014913_418613_F5D646D8 
X-CRM114-Status: GOOD (  14.06  )
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

> > @@ -27,7 +27,6 @@ struct io_uring_sqe {
> >         union {
> >                 __u64   addr;   /* pointer to buffer or iovecs */
> >                 __u64   splice_off_in;
> > -               __u16   cmd_len;
> >         };
> >         __u32   len;            /* buffer size or number of iovecs */
> >         union {
> > @@ -64,16 +63,19 @@ struct io_uring_sqe {
> >                 __u32   file_index;
> >         };
> >         union {
> > -               __u64   addr3;
> > -               __u64   cmd;
> > +               struct {
> > +                       __u64   addr3;
> > +                       __u64   __pad2[1];
> > +               } small;
>
> Thinking if this can cause any issue for existing users of addr3, i.e.
> in the userspace side? Since it needs to access this field with
> small.addr3.
> Jens - is xattr infra already frozen?

If this breaks anything, we can avoid that by not touching addr3 at all.
And instead keep "__u64   __pad2[1]" and  "__u8    cmd[0]" in the union.
That means 72 bytes of space, but it is enough for the new nvme struct
(nvme_uring_cmd) which is also 72 bytes.
Does this sound fine?

