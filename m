Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8D9C43602
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=; b=v5etJpxUayf9gJefLH23EBGBgg
	6nIizQmeT1urVO7N8mImEymDNmzbNWpShvS1ZW5t7G3p1OfccudhK+8AdTWvlc/ul+pXDhfGaYzBs
	6fPcALjgOQkCo769MBFN0O1i/4yHjHMvfTSWXFzjX+16KYM6F0TFVezK6563Fqlmu3xh+0SL8zFwK
	ePXzl6XZx2WYLMWn7RfEr+DDMXPMUMXKu91gaUr1FMIm1+hOWvRwjU39z1m1PaPUmLCnaHEsQDId1
	PsNMCXCP0XpFsT8zKeReYo49bmDGK8rA1jkOethJVRafF4qBh4K67P+EgRDIkLwQPGcJdmXoft15u
	X+P1u8UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf135-00000002vRV-016Z;
	Wed, 01 Jul 2026 19:56:43 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf12z-00000002vPC-21ww
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 19:56:41 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-6a30c37a24fso46435eaf.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2026 12:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935795; cv=none;
        d=google.com; s=arc-20260327;
        b=mN/+tlDiNPJ/wYcSkTPVSQNCkB4c2WjjZTZG9mPH8RexY9j0C4cpAKbrlEnz9cQ8PF
         sdj5//HQyqdGab8QIS0+J1Hn7qvR8vAJU2VXYG9FHKmkP81VftSvC52pCxt3xbR6c8SR
         4tK2rVy7mPco8mLpUL36cAnutAgUEdGtUBjaJ/Y383A/MWFw4CWrfQCiTw/wdy4+SvPP
         IAazxBIswvh0GoEBhkABa4JtwBQEFyKUoPr55ydkkwcioBEsXwMdRwuKsq6Hj3Kz839g
         nYl6Bbdn0kTvRVIrIGwWp4AQyufZ9iiIrtTv2EdJww+7k2x4beIhNRDSODWxt3GiHYvQ
         3Tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=;
        fh=uVflTkq4cdw/2lGIZev5Z7cEVXF4Stq50FzNNf5vOEo=;
        b=oHwcrpZbeTr1SH6Og2VOBnF1kqh0ULzQpHXNI/v9acbe+zanXdnwLhR2sLltcGmBqm
         E37RwLgTBYUYKxtVmWiLOBo9KKtMCk+aueXGVGR8JN5aY53lRXHIiBC1XL1K5QDtSGHm
         Z7yPiAT5l2z1PSEf0eJjyvo7Bt5neBLh2DPBeehMHDlBflJooOpL2YES95YFf/xRqMZC
         BcMLNp2ep+4DofxYwqUvFz4UMNH7yVAvTmpvKZ4GFAixocdp32CTMV4BE3U2x6Od2GyJ
         HiqYbezJNue5dC+hlsZ/ucDxok5GEv13TOuuEMPjEbkykTQzj45rhp9d5O45soo7nR26
         Pzqw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782935795; x=1783540595; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=;
        b=fZ+mLaCymsQjyidzKppn/4GgFBp6sBZXc2hgkvRNWdBzLi+ZFhJ7GcJIPlCCEwBE9t
         0i5fPXKSRfIPOYgMyx31vXvJOpCZhspL4S/e7zKht6Nm4lPPfqyTEqycEjQ92KEbl1Nx
         SJxO2H0DGQdrMAx+Drz+870A5RXrooZGcBmYD7g6fDQkP22h722eVXOrL55jR5HeQAvt
         Qj0n8M1LWAhN3tg6Ob/vx7KLa/VwekwOYECUlySFVvMp1bqkkaPaoCecTiw//UafLgjO
         qyC0g30+/rsZ8GkHUAlTdeZv+r+WCSfahE6P5u+2JCdqjTgtraX41gb6oekVJ0SHb+Dv
         E95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935795; x=1783540595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=;
        b=X0Vdzzk1fAqAgbU0rxpeADdSiuzw2eT6bKdMjucRUjAD6JAu07aL99IJGW0pF4tFIQ
         632G+xNaX2x/4DeYkPb0J55+cffFOOa9sfmrlxhB3AM3o0hjyxXDPYfEcJvdC5nR8oj+
         JsmKDeLm/Av0r3AEcxiukaoLdggGwEWjRC42H5MecWuDoJ8urOQwlri+1MXL/fovAgk2
         fBTab8USABVCS/c6nU8LqDcnvYSEjYy2bP21vPW8F963JldkL0cr4xqCFP0vtNE7qM9p
         KOo/t6HUURF1OlnZ2puyZiPI9LR7uUHeRjuk+ZqgT90H9W3U2pgCn5VMVp/Efhyxus+/
         Ws1A==
X-Forwarded-Encrypted: i=1; AFNElJ/zd9ttOl49IbmuFf4iouyBunJJBc9GYG7BgFpJrK2U7cuFdZkQMJeR9tNlUnfD54jV5nSsDfO9zEM5@lists.infradead.org
X-Gm-Message-State: AOJu0YwAat5NFjMXmPAJ5VW8qoXaLDaT5lurUZ2ZkOYOINV2N3NGQPp4
	JEb8miVb7/bJiZ6lPSS1nj8XPPm0Z3c0wHbS+mVFbV3Slxfu+iUXjvoagDr4qVD19R/VjZOveR5
	4JnCQsE13qXjMdvXRm2vrGLi+zOO44ULVNH99LQhlemqWZD4hY2iWkzo=
X-Gm-Gg: AfdE7cnckkXe4g0bNhkB7T5cCBC4Y1qdbJc/tc9nrtulXMCcf4Iy7fvXrQiS7FO7Gp4
	57uO+XBDJv78sGYGaxJ8ZF/9LSk1CRvoi+IF3NsguTal7ezjoO85QAEZMdTA19udOEPBc1zIBtL
	dehUp9MFm4Hx/zPtbLtWluCAZm/PRg7rP4kULFZsiyMYW8LpXCqnSCXkeog+w/6YcDr2zIca0Gr
	oI3y7L9bWA2Q7u3yHQa0OLzn3V1MbUDn5Eo42lNDrX8m+kh8VjtFO/cyF+0YShXlPZOxTTX8dXQ
	53WxbETw
X-Received: by 2002:a05:6820:7705:b0:6a0:ee7d:80ea with SMTP id
 006d021491bc7-6a30974705amr995871eaf.0.1782935795443; Wed, 01 Jul 2026
 12:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260627054220.2174166-1-csander@purestorage.com> <20260627054220.2174166-2-csander@purestorage.com>
In-Reply-To: <20260627054220.2174166-2-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 1 Jul 2026 12:56:24 -0700
X-Gm-Features: AVVi8CcoTxYjhA4dG7f1i1JCHKMq7tvfJVmlu_uynO4PEoI0alXFMGjmDjqio0g
Message-ID: <CADUfDZqE6JLLbugK+qYe=XFSLV5zUwFEQ6qRqvJ-=uVs8OtfVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] block: use integrity interval instead of sector as seed
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_125637_698955_7258CF2A 
X-CRM114-Status: GOOD (  27.10  )
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

On Fri, Jun 26, 2026 at 10:42=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> bio_integrity_setup_default() and blk_integrity_iterate() set the
> integrity seed (initial reference tag) to the absolute address in the
> block device in units of 512-byte sectors. However, Type 1 and Type 2
> ref tags are actually the least significant bits of the integrity
> interval number. On devices with integrity interval size > 512 bytes,
> the ref tag seed thus isn't the correct initial ref tag. The ref tag
> seed is correctly incremented/decremented in units of integrity
> intervals in bio_integrity_map_iter(), bio_integrity_advance(), and
> blk_integrity_interval().
>
> For REQ_OP_{WRITE,READ}, blk_integrity_{prepare,complete}() covers up
> this ref tag seed discrepancy by adding/subtracting the difference
> between the initial integrity interval and ref tag values to/from each
> ref tag in the protection information. However, REQ_OP_ZONE_APPEND can
> also carry PI but doesn't go through blk_integrity_prepare() because the
> final data location on the zoned block device isn't known until the
> operation completes. As a result, the REQ_OP_ZONE_APPEND PI ref tags
> start from the ref tag seed, which isn't in integrity interval units.
> Subsequent reads of the appended blocks will fail to remap the ref tags
> from the expected integrity interval numbers to sector numbers.
>
> Additionally, NVMe and many SCSI transports support offloading ref tag
> remapping to the device by specifying the expected initial ref tag in
> the command. The kernel doesn't currently take advantage of this, always
> remapping ref tags in software for reads and writes and setting the
> expected initial ref tag to the integrity interval. Setting the ref tag
> seed in units of integrity intervals would be a prerequisite to allowing
> the kernel to skip the software remapping and pass the ref tag seed as
> the expected initial ref tag in the command.
>
> So compute the ref tag seed in units of integrity intervals instead of
> sectors to avoid relying on ref tag remapping for the conversion.

Martin, are you okay with this updated commit message? Would be nice
to get this fix in so auto-integrity works correctly for zone appends
on 4KB-integrity-interval devices.

Thanks,
Caleb


>
> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity.c | 3 ++-
>  block/t10-pi.c        | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index b23e2434d80c..d20f9002c7c9 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -102,12 +102,13 @@ void bio_integrity_free_buf(struct bio_integrity_pa=
yload *bip)
>
>  void bio_integrity_setup_default(struct bio *bio)
>  {
>         struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       u64 seed =3D bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR=
_SHIFT);
>
> -       bip_set_seed(bip, bio->bi_iter.bi_sector);
> +       bip_set_seed(bip, seed);
>
>         if (bi->csum_type) {
>                 bip->bip_flags |=3D BIP_CHECK_GUARD;
>                 if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
>                         bip->bip_flags |=3D BIP_IP_CHECKSUM;
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index a19b4e102a83..e58d5eb6cefb 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -308,18 +308,19 @@ static blk_status_t blk_integrity_iterate(struct bi=
o *bio,
>                                           struct bvec_iter *data_iter,
>                                           bool verify)
>  {
>         struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       u64 seed =3D data_iter->bi_sector >> (bi->interval_exp - SECTOR_S=
HIFT);
>         struct blk_integrity_iter iter =3D {
>                 .bio =3D bio,
>                 .bip =3D bip,
>                 .bi =3D bi,
>                 .data_iter =3D *data_iter,
>                 .prot_iter =3D bip->bip_iter,
>                 .interval_remaining =3D 1 << bi->interval_exp,
> -               .seed =3D data_iter->bi_sector,
> +               .seed =3D seed,
>                 .csum =3D 0,
>         };
>         blk_status_t ret =3D BLK_STS_OK;
>
>         while (iter.data_iter.bi_size && ret =3D=3D BLK_STS_OK) {
> --
> 2.54.0
>

