Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A4DCCA46C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OWjQ+JMkdsgQH9g8pfOryjl8kCo9EVJkAXAGrmcac34=; b=xlxVfpTVQb0+IkuoboCSjNG/BA
	3U4O4sH33RYRqo3lKdbZodK2l3yopEzQeC+nZeo7sZhxSZ78ZToA85BOqiB0ins3Shb3xNCUZLnSC
	brPgtOOcYx9vY7Mj/vYhrk5Qzsnt+dMS8i4iXY89x+6CECcRysxRYFK5DXFaEqiIuEgc3ogzxqiYj
	/I7hgHLbW9ZYzZweng0FJUoBH5MT+1+HxiAe3ZRdbMZsOa3zAyz1SDarAUW+BgT4hcfftv+5gW7SW
	cC6aL+nG+wHJONbIhvZm3qD0ay4xiTGuJpYhasFlubGg8K8w7Sxsfo2yv39rgBH9AaSlSNHkqR7HK
	rquX8qQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeIE-00000006Z1e-3MT4;
	Mon, 19 Oct 2026 03:44:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeID-00000006Z1Y-31hm
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:44:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 38CD6432A7;
	Mon, 19 Oct 2026 03:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FCB1F000C4;
	Mon, 19 Oct 2026 03:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792381449;
	bh=OWjQ+JMkdsgQH9g8pfOryjl8kCo9EVJkAXAGrmcac34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaTIRHMIPwxLvLzS0YPV67qDMuNmq3cSIQMFYNIMVbmJ4rId3HhZlyMRkmIZrCBkP
	 0nOecx1E5ABNbgiWV8Q07gWT/EFdfWDIQy5U5tVVgI6Oqp0KJ5MuSCyZDmfgi9g2UW
	 TNWgEx6iIeSMmLFXtyL8312BWRJuYelGHL0BGUvatTqvkoOuK3qt82HC9FeNb95O/Q
	 ODaZwm7U0DoW8n/uqFljOSIkbwpvj3ciB1mVCfZ5MocIrWrSpTuaBn6C2tvwp75VXC
	 46yuc4LIBvCxzVe0WgB/GsjHXnQXbrZa4vAiz7ikp99493G0smiwc4TUUnEdehj8y8
	 Wz8yRWq1YHT9A==
Message-ID: <sashiko-outbox-176586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] nvmet: translate placement identifiers of writes
 to write streams
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019033624.402337-11-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-11-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:44:08 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvmet: bi_write_stream lost on chained bios in nvmet_bdev_execut=
e_rw()
--

commit ee4faa4396ddf960be1a3f58157a725fb3691c6f
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: translate placement identifiers of writes to write streams

This commit translates NVMe Data Placement Directive placement identifiers
on write commands into block layer write streams on the backing block
device when FDP is enabled on the namespace.

> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index f2d9e8901df4e..ff480f9ab9906 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -300,6 +300,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *=
req)
>  	bio->bi_iter.bi_sector =3D sector;
>  	bio->bi_private =3D req;
>  	bio->bi_end_io =3D nvmet_bio_done;
> +	if (req->cmd->rw.opcode =3D=3D nvme_cmd_write &&
> +	    nvmet_fdp_enabled(req->ns)) {
> +		bio->bi_write_stream =3D nvmet_fdp_write_stream(req);
> +	}
> =20
>  	blk_start_plug(&plug);
>  	if (req->metadata_len)

[Severity: Medium]
What happens when a write command spans multiple bios in
nvmet_bdev_execute_rw()?

When req->sg_cnt exceeds BIO_MAX_VECS (or bio_add_page() otherwise fills
the current bio), the for_each_sg() loop allocates a new chained bio:

	for_each_sg(req->sg, sg, req->sg_cnt, i) {
		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
				!=3D sg->length) {
			struct bio *prev =3D bio;
			...
			bio =3D bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
					opf, GFP_KERNEL);
			bio->bi_iter.bi_sector =3D sector;

			bio_chain(bio, prev);
			submit_bio(prev);
		}

Since bio_alloc() initializes bi_write_stream to 0 and bio_chain() does
not copy bi_write_stream from prev, won't all subsequent chained bios for
the write command be submitted with bi_write_stream set to 0 instead of
the stream returned by nvmet_fdp_write_stream(req), preventing them from
merging with the initial bio and routing the tail of the write to the
default stream instead of the host-selected reclaim unit?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019033624.4023=
37-1-kanie@linux.alibaba.com?part=3D10

