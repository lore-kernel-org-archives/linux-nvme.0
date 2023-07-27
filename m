Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E2AC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=omUaDYixzWjtTMpLHRqhT6EXYqbxVHZ/m0JLSVt+zRU=; b=AYMQzEHdob8lEawsXznFfwr2yD
	AYcFhWga+26bkSpyHK+VsgI7MkaQ3Kw9ZmF8XksYrWMCku7WSocvE3DW09kb47o1F3fCIQAtvQBLV
	BedOzfhKAdsPQwsXx8VWUVhp3Gv4xe718DpRtZw1So0f0iW0aRGyd7VFYTzAHzQhV6AzXdnuoMO69
	2vtkEYSa6majxW17YLsqDKV3Q7jsaotGXXTT6fB46LFmCF+OWPnNk/UFBk3U67Bdz3eVPN/X8ujJ/
	3eZDk9d4hA1iMwV4tHgG09oE7QXkS5c5xbrEYP7iNy7JDOKEfQg24Ul3MAPAo9n0SkrriCT7nmI2j
	2vMky9zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOyHJ-00D0Ev-03;
	Thu, 27 Jul 2023 10:31:29 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOyFu-00D071-0x
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 10:30:03 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d129edb8261so2840974276.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Jul 2023 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690453800; x=1691058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omUaDYixzWjtTMpLHRqhT6EXYqbxVHZ/m0JLSVt+zRU=;
        b=kR/E8OXTGyuAcMVnK2KQrLklJTZJIbjeBJSeT2sIhGPM65Oruur9kofklO6ietHDy9
         iN+Yk3uFFi0DCH5b+KIEtuBcPluVBtavpypaR5WD07CSqNhopnv+R23ky6tSh9IjXGJk
         GzdeqRWRPgntqPs3w/iwM7pGLzDbKoIc/aZkfpT2kgbAlhsGaHHBFI9ifZTJ75RImlBN
         m18KEttAN2mbFemlm21ARI+oQPZWhQ5ZKjtL1LwA/zUs5OtenG40a77AVnpCBMgIji09
         cexZ5ek/pfpL8k5LTc7yy93lENk2O4UsiIb8Ws8buCdDhR4wb5xCwrRekry+fPBuluvl
         CgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453800; x=1691058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omUaDYixzWjtTMpLHRqhT6EXYqbxVHZ/m0JLSVt+zRU=;
        b=FcmGlavz2c+zWYbI6fqc6Bsum0A9mWlaSdPorkTOZMmNneNoCWXojoxMuQwhCnq19t
         fbyn7lu5xtwg2wbjMIWwa08dxMk07EA7uBreii5a2WqPzZz50daALb3J2HPV8BH5SQT6
         UdEibPXghmLQt0VPwV+DvYL4Zc/9/fTu0Bw4Mk8Svm6v6QXHxqE4ZQ+ZKwftqg4w7TyP
         RXuqFYmaF1q5mtPyLunCTG5/ng9jAYgGCiBdC3rUA1IsqTtG7UoZZ+CYXYmtlMhJu82y
         hlHqScireyC7ivJy9vu0lxBB34R9Zq4T7FNGq9PmiXtLBv5UVAh+bpJkOA2ITcbPhkaQ
         oXZg==
X-Gm-Message-State: ABy/qLbctA9+nmp00WBuGnAphQbjUU44AyRV2+d6+WygJy33QqaCaZcx
	JMr/WhRcPy26/VBor5Q7LrQmCZ2G1TOox0uf1ys=
X-Google-Smtp-Source: APBJJlHBlYlPNCAOaUQmX7sCh/RdKgzYXiRFfLFaMRkHkke9meK1yv0x0Ok78z4gqgOSPSppdBIT7tY7YrKsz3aQ6Jo=
X-Received: by 2002:a25:3617:0:b0:d1f:8809:ffa1 with SMTP id
 d23-20020a253617000000b00d1f8809ffa1mr2701868yba.27.1690453800151; Thu, 27
 Jul 2023 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9@epcas5p4.samsung.com>
 <20230627183629.26571-3-nj.shetty@samsung.com> <20230720074256.GA5042@lst.de>
In-Reply-To: <20230720074256.GA5042@lst.de>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Thu, 27 Jul 2023 15:59:49 +0530
Message-ID: <CAOSviJ3oDSHk2HXyRZa=A43vCxh-n2YkyuW-qXNq-q=i6bNacQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/9] block: Add copy offload support infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	willy@infradead.org, hare@suse.de, djwong@kernel.org, bvanassche@acm.org, 
	ming.lei@redhat.com, dlemoal@kernel.org, gost.dev@samsung.com, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_033002_340647_A393ECD9 
X-CRM114-Status: GOOD (  15.71  )
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

On Thu, Jul 20, 2023 at 1:12=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> > Suggested-by: Christoph Hellwig <hch@lst.de>
>
> Hmm, I'm not sure I suggested adding copy offload..
>
We meant for request based design, we will remove it.

> >  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
> >  {
> >       if (req_op(rq) =3D=3D REQ_OP_DISCARD)
> > @@ -303,6 +310,8 @@ static inline bool bio_may_exceed_limits(struct bio=
 *bio,
> >               break;
> >       }
> >
> > +     if (unlikely(op_is_copy(bio->bi_opf)))
> > +             return false;
>
> This looks wrong to me.  I think the copy ops need to be added to the
> switch statement above as they have non-trivial splitting decisions.
> Or at least should have those as we're missing the code to split
> copy commands right now.
>

Agreed, copy will have non-trivial splitting decisions. But, I
couldn't think of scenarios where this could happen, as we check for
queue limits before issuing a copy. Do you see scenarios where split
could happen for copy here.

Acked for all other review comments.

Thank you,
Nitesh Shetty

