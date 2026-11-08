Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8840606A31C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i8/tvf76;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBid533i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=41ovcgGt/hDkagMqctSqqa9jwlzfYOa7jbc6Drc6/4M=; b=i8/tvf76jxcOFeGYVpGuuQ/A3x
	DK7IJC1t+9ZI0bWUMGHFnJlu86ivA7AwdkOjdPg/Cj25nZXcP1Yb1idT8NZ06FcrANfuYKDjCXQ/4
	gOXhxV7lhRQ1rgy8/bIhe5oZBUJjbUFsxVwpxoPTaU/WGDP1bWuo9qqWxtzDU2zALPcadRksERRm6
	JjhhSp8GYYIt5XyGtbnYASFsLan+WR7XXLwpkxxh0ZAdgPtrqXyvocVHq7JW8x/kfYbJOUHCUkHLT
	bwqA0tyXBEMouFb+zdMx+PrT4YvDn/mcPL+rAT8W0szihnHSJIHfYdCEteOp3x9gJ+8HDH0ZZmcnU
	ShT/PA8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQAEW-0000000GhJv-25il;
	Sun, 08 Nov 2026 21:15:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQAEV-0000000GhJn-3eat
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:15:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67C4740302;
	Sun,  8 Nov 2026 21:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD97A1F0089F;
	Sun,  8 Nov 2026 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172523;
	bh=41ovcgGt/hDkagMqctSqqa9jwlzfYOa7jbc6Drc6/4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBid533i/0/fSOye+R55kjmqgMrjINDkjIcNCWh4xn/S5ob2paYa5xv4HPXymtWh2
	 eGXyN9ja5SLEOZ2e5noRHEZiaI8xja718C4yPB12k1YZs1Ee0nr0bV9GqOvhRokCs/
	 e06a1O8pNP90kOxm26/Qo49fJb5g6l9dFrXjLn+MrED5xUxcJ0UxTwmKvF64QPHd98
	 WbuKUwAWvkulJU1oW9kqL8q8CXtquL7su5IbNUX/IpLcsvmuIALaPH9uxPUdZv2GQX
	 1G6wE23xbCIAcTtLvYtokQyPCKcl40y3CYksVJxfAMze9CwwALNAmRFFnaK4t5b2Tu
	 AHF6mVWvqYvBA==
Message-ID: <sashiko-outbox-204067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 19/29] scsi-multipath: failover handling
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-20-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-20-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:15:22 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] scsi-multipath: infinite bio retry loop in
  scsi_mpath_clone_end_io()
- [Medium] scsi: multipath: premature master_bio publish in
  scsi_mpath_clone_end_io()
- [Low] scsi-multipath: commit message describes scsi_cmnd request
  failover
--

commit 8db30403f561c839e4114d28ecdf086eb7458c31
Author: John Garry <john.garry@linux.dev>

scsi-multipath: failover handling

This commit adds failover handling to scsi_mpath_clone_end_io() by
requeueing the master bio onto mpath_head->requeue_list and scheduling
requeue work when a cloned bio fails with blk_path_error().

> Failover occurs when the scsi_cmnd has failed and it is discovered that t=
he
> target scsi_device has transport down.
>=20
> For a scsi command which suffers failover, requeue the master bio of each
> bio attached to its request.

[Severity: Low]
This isn't a bug, but do these first two paragraphs describe an earlier
request-based design?  The patch handles failover in
scsi_mpath_clone_end_io() based on blk_path_error(clone->bi_status) and
does not inspect scsi_cmnd, check whether the scsi_device transport is
down, or iterate over bios attached to a request.

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 008bcafe73ad2..4c965650c2bd3 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -262,6 +262,20 @@ static void scsi_mpath_clone_end_io(struct bio *clon=
e)
>  {
>  	struct bio *master_bio =3D clone->bi_private;
> =20
> +	if (clone->bi_status && blk_path_error(clone->bi_status)) {

[Severity: High]
Can requeueing master_bio on every blk_path_error() without checking or
disabling the path cause an infinite bio retry loop?

blk_path_error() returns true for any status other than BLK_STS_NOTSUPP,
BLK_STS_NOSPC, BLK_STS_TARGET, BLK_STS_RESV_CONFLICT, BLK_STS_MEDIUM, and
BLK_STS_PROTECTION.  When a command fails with a status such as
BLK_STS_IOERR (for example, from ABORTED_COMMAND or DID_ERROR) while the
scsi_device remains in SDEV_RUNNING, scsi_mpath_is_disabled() stays false
and mpath_head->current_path[node] is not cleared.  mpath_requeue_work()
then calls submit_bio_noacct(master_bio) -> mpath_bdev_submit_bio() ->
mpath_find_path(), which repeatedly selects the same active path and
resubmits master_bio in an unbounded loop on kblockd.

> +		struct mpath_head *mpath_head =3D
> +				master_bio->bi_bdev->bd_disk->private_data;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&mpath_head->requeue_lock, flags);
> +		bio_list_add(&mpath_head->requeue_list, master_bio);
> +		spin_unlock_irqrestore(&mpath_head->requeue_lock, flags);
> +		bio_put(clone);
> +
> +		mpath_schedule_requeue_work(mpath_head);

[Severity: Medium]
Can releasing mpath_head->requeue_lock before bio_put(clone) and
mpath_schedule_requeue_work(mpath_head) cause a use-after-free on
scsi_mpath_head->bio_pool and mpath_head?

Because mpath_bdev_submit_bio() calls submit_bio_noacct(clone) while
current->bio_list is active, mpath_bdev_submit_bio() drops
mpath_head->srcu before __submit_bio_noacct() submits clone to the
underlying queue.  If clone fails during queue entry (such as on a dying
queue) or completes asynchronously after request teardown,
scsi_mpath_clone_end_io() runs without mpath_head->srcu or the underlying
q_usage_counter held.  Once requeue_lock is dropped, an already-running
mpath_requeue_work() on another CPU can dequeue and complete master_bio
 while the last device reference is being dropped:

CPU0                                  CPU1
scsi_mpath_clone_end_io()
  spin_lock_irqsave(&requeue_lock)
  bio_list_add(&requeue_list,
               master_bio)
  spin_unlock_irqrestore(&requeue_lock)
                                      mpath_requeue_work()
                                        bio_list_get(&requeue_list)
                                        submit_bio_noacct(master_bio)
                                          ...
                                            bio_io_error(master_bio)
                                      ...
                                      scsi_mpath_head_release()
                                        bioset_exit(&bio_pool)
                                        kfree(scsi_mpath_head)
  bio_put(clone)  <-- use-after-free
  mpath_schedule_requeue_work(
    mpath_head)   <-- use-after-free

Calling bio_put(clone) before acquiring mpath_head->requeue_lock and
calling mpath_schedule_requeue_work(mpath_head) while holding
mpath_head->requeue_lock avoids this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D19

