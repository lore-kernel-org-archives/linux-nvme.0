Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C941ACCA46C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=28bjjq6gTNLcxrRGoX14l1GcvL1/KnL0XHm0BNTHHNk=; b=DziJ2j1dNAqXu3ezSnbMymaSsQ
	hXJPoWHSPDuLAtOXjlSsxe0PzZTo5R9fKISJ0FXJthhZkPcL/Vi2h+me7s23wDxHi2saXw8gLRlNj
	YsegDxZ1LHgX8J3eplvWOCoPhfWzSBGbITXVRnyJHJITfq3yHvyJRDVMI4XOD5HC2LAzoB4CuGeHy
	3QV7HmjhGxC3bSEkxZsA4U6CCIoz5OG2e93WpVVJwpbG1sIlr0NyHu9M7FXrixSrjy4Akcg2irf8w
	imsUja9RGVsCp0A+AHINjnYhdTUY4+y8btVG6eNIlvhH6TwAXM/wMy4yQ7dFTR3nb71ny22BDnd2s
	Ii8UP/3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeMZ-00000006ZEq-2rJW;
	Mon, 19 Oct 2026 03:48:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeMW-00000006ZEj-3in9
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:48:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B55F40935;
	Mon, 19 Oct 2026 03:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE3D1F000C4;
	Mon, 19 Oct 2026 03:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792381716;
	bh=28bjjq6gTNLcxrRGoX14l1GcvL1/KnL0XHm0BNTHHNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSA48cCufRdSz+aFxZYrHRFMqAj47dONN2yRh9XJrdAHnjACdIO2hhTYWIUOCnVgt
	 RlleeG9ZOGqvrJRqrfRmMUtgysK8wJ+UvlkreB2yaHA+km9jV1ib8HYiO0PVw8Ndz3
	 L4u8Inmjo2HTRp49EDesPtrVs6YerRcfCMVYq5S9+agdmhCz7+odZQVBcRU8NFd/3a
	 Q10YlveORHGoFc/GAJPpyKTCYk+drJRTuSaJOA+u8HQOyvCLZL23KltWjO3oVlm3Ee
	 GvWVHIDfRCvMYSmUfItrBEG/mFT0TXZULOMPqx/L9C9IsyZXLjXiQE7JphLBg4UMbF
	 vO9mge2BWTSMQ==
Message-ID: <sashiko-outbox-176589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] nvmet: add an FDP write translation tracepoint
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019033624.402337-12-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-12-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:48:36 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] nvmet: trace_nvmet_fdp_write_translate() called on non-directive=
 writes
- [Medium] nvmet: missing bi_write_stream copy on chained bios in nvmet_bde=
v_execute_rw()
--

commit 910a51c080606805fab754e08158c76023d49e00
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: add an FDP write translation tracepoint

This commit adds the nvmet_fdp_write_translate tracepoint to the bdev write
path to report the placement identifier from a write command and the backing
write stream it is translated to.

> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index ff480f9ab9906..139be9edad969 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c

[ ... ]

> @@ -302,7 +303,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *=
req)
>  	bio->bi_end_io =3D nvmet_bio_done;
>  	if (req->cmd->rw.opcode =3D=3D nvme_cmd_write &&
>  	    nvmet_fdp_enabled(req->ns)) {
> +		u16 pid =3D le32_to_cpu(req->cmd->rw.dsmgmt) >> 16;
> +
>  		bio->bi_write_stream =3D nvmet_fdp_write_stream(req);
> +		trace_nvmet_fdp_write_translate(req, pid, bio->bi_write_stream);
>  	}

[Severity: Medium]
Should trace_nvmet_fdp_write_translate() only be called when the write
command actually carries the Data Placement Directive?

The commit message notes that the tracepoint "reports the placement
identifier carried by a write command with the Data Placement Directive
and the backing write stream it is translated to."

In drivers/nvme/target/nvmet.h, nvmet_fdp_write_stream() checks the
directive type before treating the upper 16 bits of req->cmd->rw.dsmgmt
as a placement identifier:

static inline u8 nvmet_fdp_write_stream(struct nvmet_req *req)
{
	u16 control =3D le16_to_cpu(req->cmd->rw.control);
	u16 pid;

	if ((control & 0xf0) !=3D (NVME_RW_DTYPE_DPLCMT & 0xf0))
		return 0;

	pid =3D le32_to_cpu(req->cmd->rw.dsmgmt) >> 16;

In nvmet_bdev_execute_rw(), however, trace_nvmet_fdp_write_translate() is
invoked for every nvme_cmd_write to an FDP-enabled namespace without
checking whether req->cmd->rw.control specifies NVME_RW_DTYPE_DPLCMT.

When a host issues an ordinary non-directive write (or a write with a
different directive type) to an FDP-enabled namespace, won't this still
fire the tracepoint and report the upper 16 bits of req->cmd->rw.dsmgmt
as pid alongside write_stream=3D0, making non-directive writes
indistinguishable from directive writes whose placement identifier failed
translation?

[Severity: Medium]
Also in nvmet_bdev_execute_rw(), what happens when a write with the Data
Placement Directive spans more than BIO_MAX_VECS (256) scatterlist
segments and has to be split across chained bios?

Later in nvmet_bdev_execute_rw(), if bio_add_page() cannot fit all
segments into the initial bio, a continuation bio is allocated and
chained:

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

Because bio_alloc() initializes bi_write_stream to 0 and bio_chain() does
not copy prev->bi_write_stream, the continuation bios keep
bi_write_stream =3D=3D 0 while trace_nvmet_fdp_write_translate() reports th=
at
the request was translated to the initial bio's stream.

As a result, blk_rq_merge_ok() will reject merging the continuation bios
with the initial bio due to the mismatched bi_write_stream, and
nvme_setup_rw() will submit the remainder of the write to the backing
device without NVME_RW_DTYPE_DPLCMT (placing it into default stream 0).
Should prev->bi_write_stream be copied to each chained bio in
nvmet_bdev_execute_rw()?

> =20
>  	blk_start_plug(&plug);

[ ... ]

>
>
>

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019033624.4023=
37-1-kanie@linux.alibaba.com?part=3D11

