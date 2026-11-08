Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF2606A322
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gxdkWW+H;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8/5i403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E5pMI9aRdzG1jMHGQKjfhPH5Hs+3ONX21rBiT60hvnE=; b=gxdkWW+HhmW2cGTMeMXpC/qNkN
	dCrGkO8VE7yIhQaBIog0OCN+BtFbpmuecArNQrg2uiFx7yXsf9AFwjsBBt5Kz/KLYoWKArBoEEB0i
	X+25W/Oz/QgdVl566Myka18iROkX+LQ2V7NJYEUDUz7ZEVkifBkIz6ReahYEyiUM9EJYt4V9KK8ky
	jKboM269f+4sbJ81hETvzZKLCFouinjI2GifeW4YzOlHSvXgh3b5/cHioUc1eb84kES5M2BVyJenY
	uuE6Z3UUIGLPbvuhbpCXDgmOvUg1+0Rbz9pcbic1QdAKKnLW1aRX4DgZfqE7p213aWPpoBOvlXnfn
	Yom6kuzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQAQr-0000000GigV-3Hc0;
	Sun, 08 Nov 2026 21:28:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQAQp-0000000GigA-1K69
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:28:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B12260D31;
	Sun,  8 Nov 2026 21:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F061F0089F;
	Sun,  8 Nov 2026 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794173286;
	bh=E5pMI9aRdzG1jMHGQKjfhPH5Hs+3ONX21rBiT60hvnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8/5i403KKG8DLFHzJ0mWEm1BcPUtbvIM0gU8pl4BinDKS1VyI/stx083wZb2KU7Y
	 0dxB236TYlgXmKbi3/5y/MPTfx3PM6H652OB/ZVG50iIZXzRHDsA5+M5zViJs6By94
	 lyjF+RRCDbgdmsGh/yVY7VyjlMTyGj9Ylao46aqwUAUIBMoIlEh58VEaOTZ21hIuRN
	 MtFyjD1cgWFK9AW3CE1BFMdnFcjyE7oBqvDmIj1Cf8pP6MzNnIatZosDjjq/rRfVmP
	 27oK7ySaQ5ubxSOvRLRmd80vkeotBSwqGDX/pz8IeSl0nGxGNITXmr/ijD7NNCVNwV
	 TWHfTFN2le69A==
Message-ID: <sashiko-outbox-204075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 21/29] scsi-multipath: add
 scsi_mpath_{start,end}_request()
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-22-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-22-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:28:05 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] scsi: multipath: premature bio completion in
  scsi_mpath_end_request()
- [Medium] scsi-multipath: mismatched bdev I/O accounting in
  scsi_mpath_end_request()
--

commit 29255340e39c30a34f5cb1da674871fdd2c627ea
Author: John Garry <john.garry@linux.dev>

scsi-multipath: add scsi_mpath_{start,end}_request()

This commit adds scsi_mpath_start_request() and scsi_mpath_end_request()
to track per-host active multipath requests for the queue-depth I/O policy
and perform block device I/O accounting on multipath requests.

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 2f47c39d82936..93a4545f1dbf7 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -545,6 +545,75 @@ void scsi_mpath_put_head(struct scsi_mpath_head *scs=
i_mpath_head)
>  }
>  EXPORT_SYMBOL_GPL(scsi_mpath_put_head);
> =20
> +void scsi_mpath_start_request(struct request *req)
> +{
> +	struct scsi_cmnd *scmd =3D blk_mq_rq_to_pdu(req);
> +	struct scsi_device *sdev =3D scmd->device;
> +	struct scsi_mpath_device *scsi_mpath_dev =3D sdev->scsi_mpath_dev;
> +	struct scsi_mpath_head *scsi_mpath_head =3D
> +				scsi_mpath_dev->scsi_mpath_head;
> +	struct bio *clone =3D req->bio, *master;
> +	struct mpath_head *mpath_head =3D &scsi_mpath_head->mpath_head;
> +	struct gendisk *disk =3D mpath_head->disk;
> +
> +	if (mpath_qd_iopolicy(&scsi_mpath_head->iopolicy) &&
> +	    !(scmd->flags & SCMD_MPATH_CNT_ACTIVE)) {
> +		struct Scsi_Host *shost =3D sdev->host;
> +
> +		atomic_inc(&shost->mpath_nr_active);
> +		scmd->flags |=3D SCMD_MPATH_CNT_ACTIVE;
> +	}
> +
> +	if (blk_rq_is_passthrough(req) || !blk_queue_io_stat(disk->queue))
> +		return;
> +
> +	if (!clone) {
> +		scmd->flags &=3D ~SCMD_MPATH_IO_STATS;
> +		return;
> +	}
> +
> +	if (scmd->flags & SCMD_MPATH_IO_STATS)
> +		return;
> +
> +	master =3D clone->bi_private;
> +
> +	scmd->flags |=3D SCMD_MPATH_IO_STATS;
> +	scmd->start_time =3D bdev_start_io_acct(master->bi_bdev, req_op(req),
> +				jiffies);
> +	scmd->start_bytes =3D blk_rq_bytes(req);
> +}
> +
> +bool scsi_mpath_end_request(struct request *req, blk_status_t error,
> +				unsigned int nr_bytes)
> +{
> +	struct scsi_cmnd *scmd =3D blk_mq_rq_to_pdu(req);
> +	struct scsi_device *sdev =3D scmd->device;
> +	struct block_device *bi_bdev =3D NULL;
> +
> +	if (scmd->flags & SCMD_MPATH_IO_STATS) {
> +		struct bio *clone =3D req->bio, *master =3D clone->bi_private;
> +
> +		bi_bdev =3D master->bi_bdev;
> +	}

[Severity: Medium]
Can scsi_mpath_start_request() and scsi_mpath_end_request() account I/O
against different block_device structures when a merged request completes
partially?

scsi_mpath_clone_bio() directs all clone bios to the underlying path
disk's part0 while storing the original bio in clone->bi_private.
Contiguous clone bios from adjacent partitions on mpath_head->disk can
therefore be merged into a single request on sdev->request_queue.

When that request starts, scsi_mpath_start_request() calls
bdev_start_io_acct() on the first bio's master->bi_bdev and sets
SCMD_MPATH_IO_STATS.  If a partial completion advances req->bio past the
first bio (returning true from blk_update_request()), the final call to
scsi_mpath_end_request() re-derives bi_bdev from the remaining bio's
master->bi_bdev and calls bdev_end_io_acct() on the second partition,
leaking in_flight on the first partition and underflowing it on the
second.

Accounting against mpath_head->disk->part0 in both functions (or saving
the accounted block_device) would keep the start and end calls paired.

> +
> +	if (blk_update_request(req, error, nr_bytes))
> +		return true;
> +
> +	if (scmd->flags & SCMD_MPATH_CNT_ACTIVE) {
> +		struct Scsi_Host *shost =3D sdev->host;
> +
> +		atomic_dec_if_positive(&shost->mpath_nr_active);
> +	}
> +
> +	if (!(scmd->flags & SCMD_MPATH_IO_STATS))
> +		return false;
> +	bdev_end_io_acct(bi_bdev, req_op(req),
> +			 scmd->start_bytes >> SECTOR_SHIFT,
> +			 scmd->start_time);
> +
> +	return false;
> +}

[Severity: Medium]
Does calling blk_update_request() before updating shost->mpath_nr_active
and calling bdev_end_io_acct() complete master_bio too early?

blk_update_request() runs bio_endio(clone) -> scsi_mpath_clone_end_io(),
which either schedules mpath_head->requeue_work on a path error or calls
bio_endio(master_bio).  Because mpath_head->disk is bio-based,
__submit_bio() drops its queue reference as soon as
mpath_bdev_submit_bio() returns, so nothing pins bi_bdev once master_bio
completes:

CPU0                                  CPU1
scsi_mpath_end_request()
  blk_update_request()
    ...
      scsi_mpath_clone_end_io()
        bio_endio(master_bio)
                                      blkdev_put()
                                      bdev_del_partition()
                                        ...
                                        bdev_free_inode()
                                          free_percpu(bdev->bd_stats)
  bdev_end_io_acct(bi_bdev, ...)
    <-- use-after-free on bi_bdev

In addition, when scsi_mpath_clone_end_io() triggers failover or a
caller immediately submits dependent I/O under MPATH_IOPOLICY_QD,
mpath_queue_depth_path() reads shost->mpath_nr_active before this request
has decremented it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D21

