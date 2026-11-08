Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57669606A321
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1HAe1d50;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I++kCRa/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nx8NbrxCZOch5TiFRdnylBkuk4A6CeRjyr0fvH0GKvc=; b=1HAe1d50GnOWdCMlLYP9i7PV58
	nzuz70Jjg3UAaqp+T26aZ9/dEL0EddUu2Ks0NClJMbRXvryX9pDO2ozYm2psUlU0A7Ob7GkB6SYlX
	/H3cTdm0BGcJbJysLUZprMhj1WJ0PR/U6EfHxoEZ50J0TF5cAfuREYY+jCbXagWBhFHXpOLeomLue
	x1qV989+YE3tyc5QU95sz5MlchUPONypqHX+5l335jde1/3gXsX3EWLc/kItJpllDKqDZ9qG/e4TX
	1+ydhrnWeExXhp/dmgB/Lt18xkW4yh3TYHvhLWLNHJc1+2TYaoz/RbsaNe/oJF8MgtXJKDJwdVmCY
	JVixb2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA5w-0000000Gff6-04oV;
	Sun, 08 Nov 2026 21:06:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA5v-0000000Gfel-0YIe
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:06:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C17F1405EA;
	Sun,  8 Nov 2026 21:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FF11F0089F;
	Sun,  8 Nov 2026 21:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171990;
	bh=Nx8NbrxCZOch5TiFRdnylBkuk4A6CeRjyr0fvH0GKvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I++kCRa/bVOn81OGy5QqhKx6oH7GMCaJAG9ji53gMP6iYeuL2OsrG/2o8uxUvopNj
	 ZdE6IHHv+tD3E2S8EGx3iqguu1LFFH1vAEwCwwzCpIblM1Afkdasptx1xFh44tc7m2
	 r4F5/AcmFdUASdI0I+eS2bmTlmhJp7bDFp5S5AVUH+LP5cRB+vxp09ujWrTDw1TJ4P
	 2vhgXGMGppHSTzMW9LSZjBiAmVGh89qSID3ciWrC21dujQORWyA/CUN1S7ZkRXlPPn
	 iZkutQ6m+wsEjXHKR6rT3FMPoACDuiak/6+9vLWOa/VS3qFKfYvQ8YUCwtWg1g7/zy
	 4D1KEbNnkQjxg==
Message-ID: <sashiko-outbox-204054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/29] scsi-multipath: clear path when device is
 blocked
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-18-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-18-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:06:28 +0000
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
- [High] scsi: multipath: UAF and NULL deref in scsi_device_block() on
  removal race
- [High] scsi: multipath: NULL deref and UAF in scsi_device_block()
  during LUN scan
--

commit 6f23ec119648804e57ce4572c175483a5109ea7a
Author: John Garry <john.garry@linux.dev>

scsi-multipath: clear path when device is blocked

This commit introduces scsi_mpath_dev_clear_path() and calls it from
scsi_device_block() to clear the active multipath device path when a SCSI
device is blocked.

> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 36bc995e4e250..1950034f580f4 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
[ ... ]
> @@ -3037,6 +3038,8 @@ static void scsi_device_block(struct scsi_device *s=
dev, void *data)
>  		scsi_stop_queue(sdev);
> =20
>  	mutex_unlock(&sdev->state_mutex);
> +	if ((err =3D=3D 0) && sdev->scsi_mpath_dev)
> +		scsi_mpath_dev_clear_path(sdev->scsi_mpath_dev);
> =20
>  	WARN_ONCE(err, "%s: failed to block %s in state %d\n",
>  		  __func__, dev_name(&sdev->sdev_gendev), state);

[Severity: High]
Can calling scsi_mpath_dev_clear_path() after dropping sdev->state_mutex
race with __scsi_remove_device() and cause a use-after-free or NULL
pointer dereference on the multipath head?

scsi_block_targets() iterates target devices via starget_for_each_device()
without holding shost->scan_mutex.  Once scsi_device_block() unlocks
sdev->state_mutex, __scsi_remove_device() can transition sdev->sdev_state
from SDEV_BLOCK to SDEV_DEL and tear down the multipath head while
starget_for_each_device() still holds a reference to sdev:

CPU0                                  CPU1
scsi_device_block()
  mutex_lock(&sdev->state_mutex)
  __scsi_internal_device_block_nowait()
  mutex_unlock(&sdev->state_mutex)
                                      __scsi_remove_device()
                                        mutex_lock(&sdev->state_mutex)
                                        sdev->sdev_state =3D SDEV_DEL
                                        mutex_unlock(&sdev->state_mutex)
                                        ...
                                        scsi_mpath_remove_device()
                                          scsi_mpath_remove_head()
                                            scsi_mpath_put_head()
                                            scsi_mpath_dev->scsi_mpath_head=
 =3D NULL
  scsi_mpath_dev_clear_path()
    mpath_clear_current_path()        <-- use-after-free on mpath_head
    mpath_synchronize(mpath_head)     <-- NULL deref or use-after-free

Because scsi_mpath_remove_head() drops the reference on scsi_mpath_head
and sets scsi_mpath_dev->scsi_mpath_head to NULL while leaving
mpath_device.mpath_head dangling, mpath_clear_current_path() reads the
freed mpath_device->mpath_head and mpath_synchronize() dereferences a NULL
or freed mpath_head.

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 8e229357e62c5..67e9010d54782 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -240,6 +240,16 @@ static int scsi_multipath_sdev_init(struct scsi_devi=
ce *sdev)
>  	return 0;
>  }
> =20
> +void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
> +{
> +       struct mpath_device *mpath_device =3D &scsi_mpath_dev->mpath_devi=
ce;
> +       struct scsi_mpath_head *scsi_mpath_head =3D scsi_mpath_dev->scsi_=
mpath_head;
> +       struct mpath_head *mpath_head =3D &scsi_mpath_head->mpath_head;
> +
> +       if (mpath_clear_current_path(mpath_device))
> +               mpath_synchronize(mpath_head);
> +}
> +
>  static void scsi_mpath_clone_end_io(struct bio *clone)
>  {
>  	struct bio *master_bio =3D clone->bi_private;

[Severity: High]
What prevents scsi_device_block() from calling scsi_mpath_dev_clear_path()
while scsi_mpath_dev_alloc() is still initializing or freeing
sdev->scsi_mpath_dev during LUN scanning?

sdev is already linked onto starget->devices and set to SDEV_RUNNING in
scsi_add_lun() before scsi_mpath_dev_alloc() runs.  Inside
scsi_mpath_dev_alloc(), scsi_multipath_sdev_init() publishes
sdev->scsi_mpath_dev before scsi_mpath_head and mpath_device.mpath_head
are populated, and the error path in scsi_multipath_sdev_uninit() frees
sdev->scsi_mpath_dev before clearing the pointer:

CPU0                                  CPU1
scsi_add_lun()
  scsi_mpath_dev_alloc()
    scsi_multipath_sdev_init()
      sdev->scsi_mpath_dev =3D ...
                                      scsi_block_targets()
                                        ...
                                        scsi_device_block()
                                          scsi_mpath_dev_clear_path()
                                            mpath_clear_current_path()
                                              mpath_head->current_path[node]
                                              <-- NULL pointer dereference
    ...
    sdev->scsi_mpath_dev->mpath_device.mpath_head =3D ...

If scsi_mpath_dev_alloc() fails (for example when a LUN has no VPD page 83
device ID) and calls scsi_multipath_sdev_uninit(), a concurrent
scsi_device_block() also risks a use-after-free on sdev->scsi_mpath_dev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D17

