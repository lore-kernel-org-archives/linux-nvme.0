Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A8CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Cc:
	References:Content-Type:Content-Transfer-Encoding:Date:Mime-Version:To:
	In-Reply-To:Message-Id:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ae4EIh4ONcbs6jvdEyBqGmmn/47kQ5NZ9WtLM72vbj8=; b=3TS8j43Sje6e5HEL/oaNf09rp1
	euzJPpL4vpd2RPAHArwiDxJs0S2nNWzfEqnjtzcA3bhlP3hkJiYpexNj1YmmJ6pZT0Vq2GX82JTjf
	E85GZwHJkmiBPmaDxZOCtqMs8E4hQ8C+AndYTEgR/N879pIClP3jHo4BnXPgFzcz3rL3eo5OrV2oF
	TrveyTKmFny+b0T8VGy8krCZttgvwM6CiT/8qUudBrNx9PGOvmIggb1vGUeKrgX4JKIFNj2F4VBnc
	MwvCQyLb4IHjRb6eQ+AFoCxzPaCFee9nQhDzHTQ8eAmpKhRyH93Uf3q+OBmIZZidMP1OSt8K+mMI2
	c+YYhHJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoyJ-00000007HhD-3tiz;
	Tue, 11 Nov 2025 14:03:47 +0000
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoyH-00000007Hgf-1mFG
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 14:03:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762869818;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ae4EIh4ONcbs6jvdEyBqGmmn/47kQ5NZ9WtLM72vbj8=;
 b=vaeq8iZqHTd7SDI8+3xNWw+UJ/e7nqiRyP94OXffRhAEzYdLV2ty6WLjtmPqFi2IfXCgk5
 KuOiSE/6pVTOyYBh67OQkITIT5taAmhf99i+eFvCltREX1Npf9tsH5sIs0bwb+1s2RpQXG
 fYxfJlAVfGzBpdnD+vycR/tmcuQX2kruGGaI26Xgc97PrAFiU5DL9nHCaEOiHs+5FUftaa
 pknXa2nvvbd3nWCqrwBCl0nyBtEKT4Br7COQ0JaQjyEl8XV3blTk+yOOmg3dRpob3WB9mU
 VifyUnNpGlYspa/zzvh0K5PdDr5F2xmg6rghZzE5cW2RHVarT4nLB4zzo0b6tQ==
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <ab181a42-ffe6-4d12-8b8d-7aca1069c59e@fnnas.com>
In-Reply-To: <aRNALUnnxzIuyHng@kbusch-mbp>
X-Lms-Return-Path: <lba+269134238+1320ee+lists.infradead.org+yukuai@fnnas.com>
To: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 22:03:33 +0800
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 22:03:35 +0800
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de> <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com> <aRM5UoApKZ9_V7PV@kbusch-mbp> <20251111134001.GA708@lst.de> <aRNALUnnxzIuyHng@kbusch-mbp>
Cc: "Matthew Wilcox" <willy@infradead.org>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, 
	<axboe@kernel.dk>, <yukuai@fnnas.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_060345_841274_00011398 
X-CRM114-Status: GOOD (  12.32  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2025/11/11 21:54, Keith Busch =E5=86=99=E9=81=93:
> On Tue, Nov 11, 2025 at 02:40:01PM +0100, Christoph Hellwig wrote:
>> On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
>>> Ah, so we're merging a discard for a device that doesn't support
>>> vectored discard. I think we still want to be able to front/back merge
>>> such requests, though.
>> Yes, but purely based on bi_sector/bi_size, not based on the payload.
> This should do it:
>
> ---
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3ca6fbf8b7870..d3115d7469df0 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -737,6 +737,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *p=
rev, struct bio *next,
>   {
>   	struct bio_vec pb, nb;
>  =20
> +	if (!bio_has_data(prev))
> +		return 0;
> +
>   	gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
>   	gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
>  =20
> --

This looks good.

Thanks,
Kuai

