Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902D606A330
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w4KqE2bA;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYwhhnIh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sWwPqXhlmntuXUkmWAS3xXf73mGRjYTurrM/bmufH18=; b=w4KqE2bAsVZP1GqDFnzXxQaCnE
	TwawOTUZPhimonYm07G37Rwv3O7yMJOpiFV2hB6VtWYR5ZqnIbcqYHv+vTl0UVsBF98i5/J3oyXTo
	FF/eGjcTvdLCMtIGuRn22cVFZLzud6AFQxwV9r/eKjQ5QxRFoY7v2UewY9JdO7Jzraof8Nwjiaf8X
	vKVXTG8tWSzX4XmJAB7qp12gzepGZvg4ybnlLlqGH4EYJevj/0mVrVYFuV0odu6KChy5+hYOzWo2h
	ng6b8yvKPmzX2yRI4occ52cCMLeGom8M6eR3voyVb+7Vd9GL8NnPJoct+/G20m/9D10g6N/GdH8UY
	leGcCLGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA9C-0000000GgSx-0GKw;
	Sun, 08 Nov 2026 21:09:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA9B-0000000GgSf-1YUm
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:09:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA507405B7;
	Sun,  8 Nov 2026 21:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B005A1F0089F;
	Sun,  8 Nov 2026 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172192;
	bh=sWwPqXhlmntuXUkmWAS3xXf73mGRjYTurrM/bmufH18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYwhhnIhUDVzC+Us+jgoJW6E6aB17f64W6EpdC5Uuk5ivqUNUwHlWdZEdmJOtgWFn
	 GksLjtfrh6ndctFAOYF7uZxqwfmV9wKFuEDXkv6PnLbTBr/BgEK34V0vVMYmGIuZ7K
	 5IVH4TJSarMcgafusFIdBsUtqSl82psWiK+NcVe/T1wFqb+AX1RaPciP9ONKCdEfKH
	 Sv4Hlr0zNpg1p7WDdxMGVUjGEa9xwuGFKLt+Ycbuqkp+9QhRXyUG+p/z0Oz6nix6pV
	 NSLSnET0py2lcpBrgKKogotacm4o0wV7BJYCH0c4Kdz6/n81fyjR/mpzYlnFBBEwGv
	 3+vi09A7PB+qA==
Message-ID: <sashiko-outbox-204064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 22/29] scsi-multipath: update request for terminal
 request queuing error
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-23-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-23-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:09:51 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] scsi-multipath: NULL dereference on bio-less request in
  scsi_mpath_end_request_no_update()
--

commit 6015c0421ae4c77548304e8f223ec4e93492aa00
Author: John Garry <john.garry@linux.dev>

scsi-multipath: update request for terminal request queuing error

This commit adds scsi_mpath_end_request_no_update() and calls it from
scsi_queue_rq() when a multipath request fails with a terminal queueing
error, updating active request counts and I/O statistics.

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 93a4545f1dbf7..bec6dd94f3be8 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -614,6 +614,41 @@ bool scsi_mpath_end_request(struct request *req, blk=
_status_t error,
>  	return false;
>  }
> =20
> +void scsi_mpath_end_request_no_update(struct request *req, blk_status_t =
error)
> +{
> +	struct scsi_cmnd *scmd =3D blk_mq_rq_to_pdu(req);
> +	struct scsi_device *sdev =3D scmd->device;
> +	struct bio *clone =3D req->bio, *master =3D clone->bi_private;
> +	struct block_device *bi_bdev =3D master->bi_bdev;
> +	unsigned int nr_bytes;
> +
> +	/* Don't generate error logs if we are going to try another path */
> +	if (blk_path_error(error))
> +		req->rq_flags |=3D RQF_QUIET;
> +
> +	if (scmd->flags & SCMD_MPATH_CNT_ACTIVE) {
> +		struct Scsi_Host *shost =3D sdev->host;
> +
> +		atomic_dec_if_positive(&shost->mpath_nr_active);
> +	}
> +
> +	if (!(scmd->flags & SCMD_MPATH_IO_STATS))
> +		return;

[Severity: High]
Can clone->bi_private cause a NULL pointer dereference when req->bio is
NULL?

blk_kick_flush() initializes fq->flush_rq with flush_rq->bio set to NULL
and copies REQ_DRV (which REQ_MPATH aliases) into flush_rq->cmd_flags:

block/blk-flush.c:blk_kick_flush() {
    ...
	flush_rq->cmd_flags =3D REQ_OP_FLUSH | REQ_PREFLUSH;
	flush_rq->cmd_flags |=3D (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
    ...
}

Unlike scsi_mpath_start_request() and scsi_mpath_end_request(), which
only dereference req->bio when SCMD_MPATH_IO_STATS is set,
scsi_mpath_end_request_no_update() dereferences req->bio unconditionally
at function entry before checking SCMD_MPATH_IO_STATS.  If a flush
request hits a terminal queueing error in scsi_queue_rq() (such as when a
path is transport offline), this crashes.  Deferring the req->bio and
clone->bi_private dereferences until after the SCMD_MPATH_IO_STATS check
would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D22

