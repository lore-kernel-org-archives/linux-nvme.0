Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359A606A321
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lABytviD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfjmgAZc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZS/+9RoeC/5ysy9/4XL0GzlvzEZI1ShMbYQDvBVHstM=; b=lABytviDxcxIofmHIF2kFj0oJ6
	/OMyGr3P8FkTh66lO8MZrsk6Y0HdoJ6AHRrx/3cRB20V2h/35YK8L6cU7oxitdmiqcu3pAaPS1rvO
	at6pOqsTubsQApnQhvYtIimEZNJJ5BwQEs/7H87b2Wgwvu0tCNHgnqnQuSR6hwAHdMaW1cWMu2J0/
	RmqTCNe58Brtc058/gAImL8QwWiA4SNOlkA4uLp4ZUp+kmVfFv8P0XQ+gvdwQgfz2zJlX1BhK5xgi
	VzX2DYPG3ytFHcXqrKEf7ieMnPJ9GxpdKoOtfV5Z6F2S137bM90dOUF2ECGZ3E9ws7wTNYbnk9WFX
	Q0tl5rsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA5B-0000000GfTF-2Yqz;
	Sun, 08 Nov 2026 21:05:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA59-0000000GfSu-1TnB
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:05:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BAAD761D29;
	Sun,  8 Nov 2026 21:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E061D1F0089F;
	Sun,  8 Nov 2026 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171942;
	bh=ZS/+9RoeC/5ysy9/4XL0GzlvzEZI1ShMbYQDvBVHstM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfjmgAZcN+KTHtaJb+IOc4fpE2cEcSNRbs+lXm0dyiKNSvElj8xbcRZ9BpGKuZVGU
	 I66byZGB+n6Q78sn0EEh/dnAmIpFSiHjU7ihfKb2yw7Fn0LVCoWWsl+5dG0DW9S1LV
	 nL6nKV/0TDijp06VZYnFRVXMl7kj+ozBQ4tpdswEU6t+iqSaSIGcE+RMxLkyphXmtY
	 FiixpQLdo1jqY3PTS72Y+BTtMgOundtsZZjurmFW9ZUkBoqQyOS4pLG8Lk9qLCbgww
	 8fBunvLUzmbrf5+ygTyhGvJTokKL+VfgG82VKCFELbq2iuCKvVz5l8+5kwJose9F3+
	 /eIeR7GTLgU2A==
Message-ID: <sashiko-outbox-204050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 20/29] scsi-multipath: provide callbacks for path
 state
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-21-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-21-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:05:41 +0000
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
- [High] scsi: scsi_multipath: scsi_mpath_available_path() ignores
  sdev->access_state
- [Medium] scsi: scsi_multipath: mpath_device access_state never updated
--

commit 6f83cc4eccb483172140b55837b87755b4421b91
Author: John Garry <john.garry@linux.dev>

scsi-multipath: provide callbacks for path state

This commit implements the .is_disabled, .is_optimized, and .available_path
multipath callbacks for SCSI multipath devices using sdev_state and
access_state.

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 4c965650c2bd3..2f47c39d82936 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -298,7 +298,56 @@ static struct bio *scsi_mpath_clone_bio(struct bio *=
bio)
>  	return clone;
>  }
> =20
> +static bool scsi_mpath_is_disabled(struct mpath_device *mpath_device)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =3D
> +				to_scsi_mpath_device(mpath_device);
> +	struct scsi_device *sdev =3D scsi_mpath_dev->sdev;
> +	unsigned char access_state =3D READ_ONCE(sdev->access_state) &
> +					SCSI_ACCESS_STATE_MASK;
> +
> +	if (READ_ONCE(sdev->sdev_state) !=3D SDEV_RUNNING)
> +		return true;
> +
> +	if (access_state =3D=3D SCSI_ACCESS_STATE_OPTIMAL ||
> +	    access_state =3D=3D SCSI_ACCESS_STATE_ACTIVE)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool scsi_mpath_is_optimized(struct mpath_device *mpath_device)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =3D
> +				to_scsi_mpath_device(mpath_device);
> +	struct scsi_device *sdev =3D scsi_mpath_dev->sdev;
> +	unsigned char access_state =3D READ_ONCE(sdev->access_state) &
> +					SCSI_ACCESS_STATE_MASK;
> +
> +	if (READ_ONCE(sdev->sdev_state) !=3D SDEV_RUNNING)
> +		return false;
> +
> +	return access_state =3D=3D SCSI_ACCESS_STATE_OPTIMAL;
> +}

[Severity: Medium]
Does scsi_mpath_is_optimized() disagree with mpath_device->access_state for
active/non-optimized paths?

scsi_multipath_sdev_init() initializes mpath_device->access_state to
MPATH_STATE_OPTIMIZED, and nothing updates it when sdev->access_state
changes:

lib/multipath.c:__mpath_find_path() {
	...
		switch(mpath_device->access_state) {
		case MPATH_STATE_OPTIMIZED:
		    if (distance < found_distance) {
			    found_distance =3D distance;
			    found =3D mpath_device;
		    }
		    break;
		case MPATH_STATE_NONOPTIMIZED:
	...
}

Because __mpath_find_path(), mpath_round_robin_path(), and
mpath_queue_depth_path() select paths using mpath_device->access_state
rather than mpdt->is_optimized(), an active/non-optimized path is still
treated as optimized during path selection.  Under the NUMA policy,
mpath_numa_path() then checks scsi_mpath_is_optimized() on every bio, sees
false, and calls __mpath_find_path() to rescan dev_list and pick the same
non-optimized path again on every I/O.

> +
> +static bool scsi_mpath_available_path(struct mpath_device *mpath_device)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =3D
> +				to_scsi_mpath_device(mpath_device);
> +	struct scsi_device *sdev =3D scsi_mpath_dev->sdev;
> +	enum scsi_device_state sdev_state =3D READ_ONCE(sdev->sdev_state);
> +
> +	if (sdev_state =3D=3D SDEV_RUNNING || sdev_state =3D=3D SDEV_QUIESCE ||
> +	    sdev_state =3D=3D SDEV_BLOCK || sdev_state =3D=3D SDEV_CREATED_BLOC=
K)
> +		return true;
> +
> +	return false;
> +}

[Severity: High]
Should scsi_mpath_available_path() also check sdev->access_state?

When all paths are in SDEV_RUNNING with an unusable ALUA state such as
standby, unavailable, or offline, scsi_mpath_is_disabled() returns true for
every path and mpath_find_path() returns NULL.  Because
scsi_mpath_available_path() still returns true for any SDEV_RUNNING device,
mpath_bdev_submit_bio() queues bios onto mpath_head->requeue_list instead
of failing them with bio_io_error(), leaving I/O stuck on requeue_list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D20

