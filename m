Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E73FF512B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=; b=DTDtsthxZ6jZTEMmpIu8FQIfSH
	tULmO8lx9fwix+9nwXOrRqJH75aorBisgH32Tu07tmdsTCEGGP2QC931B6ozk1U+qPkt5hfag1zy/
	grs47kFlGWzzb9sT/bLDcrn9Q2azKGK1rpV8qT4vHPeOMvBZ2K59Yu35qtW+hGMtnBu0HbJQOjY88
	h9xlltMC/MmjaScRXHVWZ/UUnGNY1ePsGRA6PU+yvbqOFUANvG5iUmip65dxLt8WExe5bGppEKEwG
	39Fgs7lG9O+7DoOOL+ECtEJjoCTLYwtOhHvlBM9fzjvCvxQaFIQ73LAxmVpGX/IVIhSpUakuCWfgb
	xpS3Qy+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9bw-00000006ohE-2U9x;
	Tue, 07 Apr 2026 16:49:08 +0000
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9bt-00000006ogZ-0773
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 16:49:06 +0000
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-68240e0d925so109676eaf.1
        for <linux-nvme@lists.infradead.org>; Tue, 07 Apr 2026 09:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775580543; cv=none;
        d=google.com; s=arc-20240605;
        b=iD+A2ho/N1jTO7GXxv8j6vHQoSkkzI9EHx0HFySGLc1dvRvHEkidkEqxqnaKnjWj2g
         lsCWjaJHzSmHrr7Aed2kaGegmJVSWnj8Jr8Ow7AODqbUiY+zCCOj4n722ajK4cjSuUFk
         01m9JMr+SR4HpZxU74cXwgiX4Uf/1LgsgXthAHNM6Cd16UQI9WeCyORzNzCSaOHM+xps
         Ixbypm0ZIyjy0svJtwQ50Db0z3ZqnyrvGkOqKS+2mBzfKQbGe77yrtTuzpmm0DhrLHU5
         QPq0OpDJ3xy4Mg0vQhJk+4alAvxSjqXGp3/3SlAfoP4nkLVMFrySvBIDM/uT6Wfdms7J
         H8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=;
        fh=k8Grg+br4aY3jTdSyvPZkN3SE+a+Z7Pj/D0Q4ONX/Ww=;
        b=HYXGiP/0dabd/Mo3Nq2AkswuEa4/56+/TO/ssobA4wwanm1Vgy9rVt5mXXdI4e/qYJ
         SBN8SQG/z+8/pK166Jq9B2dUgWTENZEVJHzVvRmd2/x4reaGt3kTOnr6iwWosjT/WjKw
         CrqTwLqjBGzzFwmemiqLIv+0AQT3mjMrIO6Osbl6XNQv+734rEkHYl4fFsbZPCultEfc
         o3wEjvqk/yrWE96YtfSVuwd6AN71bBj1kUoh6R3ZRA1rx3izINDeir015ZkRw3AjJctN
         qx7Q2Qv/16EI58f2BnHvQtYEdp8cM7n/b0W/02NjU8SHXF4Ev1lfOJb3b4mzr7cfgEZ7
         Ei7Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775580543; x=1776185343; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=;
        b=YpEtQlFo+jLPo0vbeVBFpDD9v7fOuGQBvIYEBAtw0M/eFNO9fq3qVjJlNW0duh2sex
         kFHNDUUl4faS7B/YAWiLjM8kdm3X+vC9T60npRJcV3JjGTv+zW1vVSS06Dc8w/+CySmE
         tVB8MrKu6vaPIqYF/rX7poTUDcZnng03R3H0Nt8WsfhNlcnggB9TZ3jNlHg3d12rKy5E
         m4slSaSbjhJ3wV2gBt/t8OxoSLW/jInDlVuLsd4CbAzrD/eqTYwvLsYxVMQuda/3K7pN
         sj3/DbV+hujN5Y9bw73LrUR4kNqmYm/FK39NhwPLwnUs8vR9zGhdIdfrBMy8FtWZG2u4
         GshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580543; x=1776185343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lazOyKwXnU60c9GoYfvLsxP7atxxk5CZ7DnVJNd+0g0=;
        b=OTp/S3Zpw0vT9gbEk4pgtu9YGgUPSjlakI87Tx3HgT20suV5TI759wnFFoJy9vdAIi
         L+rrWF6rvQoOEQecGQ9fd1jd4AhM5gUOGyKs9ZxTzE/yHu2WqiXqmlNm5G2+Q0jFS9Ar
         7PiqiKdZkXM0LJ3LWW8jFz8Mszlqou7/mUNKYbBAc/BoGtej5cSpq05+4SEkUY7DtH3P
         +QtfYO3AE7/QXKtIX2G1c6jUJVqdhbjKTIIFd8f/OOX9wTb76AXFP9Lt0clCH3zD5J2b
         8vRjDDKFdV4O5l6nBLFb8EnMVPKdmJqa23vNZKwPxB45Z/1dAntc6enMW9vxp6YxMGi5
         4hmA==
X-Forwarded-Encrypted: i=1; AJvYcCVNZDqVj7oY6+R/WJcvHWyRuZdMYg7nilX89TgVcxUgxzep23R3m4deBcMYbZDeaZfilD/QXB/UuVK2@lists.infradead.org
X-Gm-Message-State: AOJu0YxCfegskDZQKk/UzrmvkEjiLFdQy1aDUBE94atl347e1YAtzdtb
	OZ1XtdikjHls8+T90TTCKUaMjz9nAUTI3L/ov3SHa7L1AN/ilmFcX6Mg4RccfXEP5Yxtg+KomBi
	gpgrYCIn3YaVw6j4FIt1E/Fi9h9+LXQJpG6NfVAA30Q==
X-Gm-Gg: AeBDievjSWeFnEyT1BZdP9QE7GBtq7rmMwadzRL91kes8wQ/CYvBqYHCcckxFzNtvfG
	likd7sq63qwKWeD4CdQsHYPEkucWeRS9hfrjEV4tiaqAmGIRGiBsAQ/du7qU6hKKDg1dtknoZJ6
	2ndnqPFH4tZReTFI15P7mUMTaRnJZl7QFNZnw3VB1mB22riiOORt29MHH6/3kB5eZnJhBqk3sIk
	FQWZcQQ7DSNBnlRbdUknRnMBQRUpRUVJppgUguy9kPAC3Tm1uLO3AVUaEVBTT5p6qu7hcqhuhcz
	Nh9mSxW7
X-Received: by 2002:a05:6820:858e:10b0:67c:3021:908a with SMTP id
 006d021491bc7-6821fa67067mr4123248eaf.3.1775580543405; Tue, 07 Apr 2026
 09:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-3-csander@purestorage.com> <adNUE67FpIGF_x7Q@infradead.org>
In-Reply-To: <adNUE67FpIGF_x7Q@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 09:48:52 -0700
X-Gm-Features: AQROBzCt_NO9LdYduvYfMd8GPp7cOALx7rkbussdP1UbmbwnR15kmHFzXdPpfAE
Message-ID: <CADUfDZqHyTDO6aYed+mtChU9m3iPgW=hghwfifuCV8Z_CzxoFQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as seed
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_094905_107635_557447F5 
X-CRM114-Status: GOOD (  11.05  )
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

On Sun, Apr 5, 2026 at 11:35=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Apr 03, 2026 at 01:41:05PM -0600, Caleb Sander Mateos wrote:
> >  void bio_integrity_setup_default(struct bio *bio)
> >  {
> >       struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
> >       struct bio_integrity_payload *bip =3D bio_integrity(bio);
> >
> > -     bip_set_seed(bip, bio->bi_iter.bi_sector);
> > +     bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sec=
tor));
>
> Should we simply switch bip_set_seed to take a bio bvec_iter argument and
> lift all this logic into it?  That feels a lot less fragile.

Perhaps I'm misunderstanding the suggestion, but how would that work
for initializing the seed from struct uio_meta in
bio_integrity_map_iter()?

bip_set_seed(bio_integrity(bio), meta->seed);

Thanks,
Caleb

