Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6D0C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Dec 2023 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sI6jF1PlnN/uCKJ4yvn5wFUQedj2/8WiL+FgozzdWI0=; b=lZYFkGKcBk3SJuHPSb53ewsNEv
	XIdAlN5gLFvNNA3vRQ9vappcC+zdA0y6WFCagOnU2E1zlIPVkO+jAgNYVav2EhV9Ax9V+Goqp/vdy
	/Et3eWamuT/TRbR26bxO+SRNEt1GLJA42UDzScwFg32O5OnsUPvGlnQiVMQq0g0wGO5rba//QuWUZ
	qeICZIYyoc7TmR/04zSiUYR6BRLVY97mYNPL7WbQIh5STZI7VAO1wdgRjsviVVdE8JTB/XzOAUxZ7
	1o8OgCxD6yG2n4CVk05jq+T2oyL1jppRYJYqQVwMKzQlScJ82mgiQmmWa/UWb+c5D3V0O2YEsd9BW
	N0vGXjLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r98Tg-00ESDc-0n;
	Fri, 01 Dec 2023 18:43:04 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r98Tb-00ESCA-1B
	for linux-nvme@lists.infradead.org;
	Fri, 01 Dec 2023 18:43:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A559FCE27C9;
	Fri,  1 Dec 2023 18:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A93C433C7;
	Fri,  1 Dec 2023 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701456176;
	bh=Lr/5S23HyH9+H9WBmLOsJqtgoXJc2MP8bGmF/5tuDPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBJ3atBQofnN7kHgb7nGGuIxXBhLEQNPI/JC7u8XvCJsrBHEWFYm/AX9okviwg5cZ
	 Du3rCyxCwQt+kWP31FM8YAF1jY6k+SkjrR7v50ydPZyPjp8pmcilHAXnc8pcrVHZgx
	 K5i5gvhFHjUVznARCN9u1d6EqnKhgjvflcX7A4Rcdumrnl+QKTvqhGkH+f047eB0pk
	 kNOfYfnZeeSbI3TRdguPB/hAiV/kdXTIwasdy1XwVvsS1pGRRyU1zOngjDz7tAo88J
	 OnYbGNX19fXfcBN/xNp9tpldAW6Pn2yjzEvMTz7YKBaD0/hUIzVTIbqLXLyKrJJ9h0
	 urxmA8yoEahhA==
Date: Fri, 1 Dec 2023 11:42:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	ming.lei@redhat.com
Subject: Re: [PATCHv5 0/4] block integrity: directly map user space addresses
Message-ID: <ZWopLQWBIUGBad3z@kbusch-mbp>
References: <CGME20231130215715epcas5p33208ca14e69a68402c04e5c743135e6c@epcas5p3.samsung.com>
 <20231130215309.2923568-1-kbusch@meta.com>
 <e3c2d527-3927-7efe-a61f-ff7e5af95d83@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c2d527-3927-7efe-a61f-ff7e5af95d83@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_104259_586432_26E63CA8 
X-CRM114-Status: GOOD (  18.29  )
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

On Fri, Dec 01, 2023 at 04:13:45PM +0530, Kanchan Joshi wrote:
> On 12/1/2023 3:23 AM, Keith Busch wrote:
> > From: Keith Busch<kbusch@kernel.org>
> 
> This causes a regression (existed in previous version too).
> System freeze on issuing single read/write io that used to work fine 
> earlier:
> fio -iodepth=1 -rw=randread -ioengine=io_uring_cmd -cmd_type=nvme 
> -bs=4096 -numjobs=1 -size=4096 -filename=/dev/ng0n1 -md_per_io_size=8 
> -name=pt
> 
> This is because we pin one bvec during submission, but unpin 4 on 
> completion. bio_integrity_unpin_bvec() uses bip->bip_max_vcnt, which is 
> set to 4 (equal to BIO_INLINE_VECS) in this case.
> 
> To use bip_max_vcnt the way this series uses, we need below patch/fix:

Thanks for the catch! Earlier versions of this series was capped by the
byte count rather than the max_vcnt value, so the inline condition
didn't matter before. I think your update looks good. I'll double check
what's going on with my custom tests to see why it didn't see this
problem.
 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 674a2c80454b..feef615e2c9c 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -69,15 +69,15 @@ struct bio_integrity_payload 
> *bio_integrity_alloc(struct bio *bio,
> 
>          memset(bip, 0, sizeof(*bip));
> 
> +       /* always report as many vecs as asked explicitly, not inline 
> vecs */
> +       bip->bip_max_vcnt = nr_vecs;
>          if (nr_vecs > inline_vecs) {
> -               bip->bip_max_vcnt = nr_vecs;
>                  bip->bip_vec = bvec_alloc(&bs->bvec_integrity_pool,
>                                            &bip->bip_max_vcnt, gfp_mask);
>                  if (!bip->bip_vec)
>                          goto err;
>          } else {
>                  bip->bip_vec = bip->bip_inline_vecs;
> -               bip->bip_max_vcnt = inline_vecs;
>          }
> 
>          bip->bip_bio = bio;

