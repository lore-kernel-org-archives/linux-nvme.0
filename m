Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B54C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKzIWMKgH2eFCpqCwaLEX/JBPTfFT3c4kI9KZSUzxOk=; b=wPMLGtmFP5YuYVFiWVElw3wnj7
	IfeRsklTIIlXmFguj37H7O1OycTYyNNUPp3cIuwB7ZkGyl6yvJZwEirL4A3NtwITEYYG0d6dx0p97
	AjH4V/ruvqpAAOpAbtQo3speGETjN5L80xisJ2XEmHX2adiEbvpuQPI7zpwjnBW0FHUOshEtLRX0/
	oNW5COmdjkuemLLhQL2PpUHWLSthM+SL+3XD1GdL4NeAskE3nzTQv2HsM73CdCo4KHRYC7B2HY48q
	V4DfbV0wzMvQZ1bf7psiQ/Nbpyj/Lm+tAMJeOpe2xBj0aeABTIIqv8nLyT+5zh4a8xugewdpk2HVj
	mL/3Wv4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rzg-000nAN-1n;
	Tue, 06 Jun 2023 08:24:44 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rzd-000n86-0f;
	Tue, 06 Jun 2023 08:24:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A2DC56081100;
	Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id siZzZpJorNJf; Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 34240616B2CF;
	Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YeogKuuY1hxw; Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E97466081100;
	Tue,  6 Jun 2023 10:24:38 +0200 (CEST)
Date: Tue, 6 Jun 2023 10:24:38 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, 
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	dm-devel <dm-devel@redhat.com>, 
	linux-block <linux-block@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-bcache <linux-bcache@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-nilfs <linux-nilfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>
Message-ID: <318049918.3687133.1686039878761.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606073950.225178-24-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-24-hch@lst.de>
Subject: Re: [PATCH 23/31] mtd: block: use a simple bool to track open for
 write
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: use a simple bool to track open for write
Thread-Index: X/xlpyhSf8bloXE5HNEoh3ox5Q1J9Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012441_546787_ED789AB4 
X-CRM114-Status: GOOD (  14.83  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> Instead of propagating the fmode_t, just use a bool to track if a mtd
> block device was opened for writing.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/mtd/mtd_blkdevs.c    | 2 +-
> drivers/mtd/mtdblock.c       | 2 +-
> include/linux/mtd/blktrans.h | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index f0bb09fde95e3a..bd0b7545364349 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -208,7 +208,7 @@ static int blktrans_open(struct gendisk *disk, fmode_=
t mode)
> =09ret =3D __get_mtd_device(dev->mtd);
> =09if (ret)
> =09=09goto error_release;
> -=09dev->file_mode =3D mode;
> +=09dev->writable =3D mode & FMODE_WRITE;
>=20
> unlock:
> =09dev->open++;
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index a0a1194dc1d902..fa476fb4dffb6c 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -294,7 +294,7 @@ static void mtdblock_release(struct mtd_blktrans_dev =
*mbd)
> =09=09 * It was the last usage. Free the cache, but only sync if
> =09=09 * opened for writing.
> =09=09 */
> -=09=09if (mbd->file_mode & FMODE_WRITE)
> +=09=09if (mbd->writable)
> =09=09=09mtd_sync(mbd->mtd);
> =09=09vfree(mtdblk->cache_data);
> =09}
> diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
> index 15cc9b95e32b52..6e471436bba556 100644
> --- a/include/linux/mtd/blktrans.h
> +++ b/include/linux/mtd/blktrans.h
> @@ -34,7 +34,7 @@ struct mtd_blktrans_dev {
> =09struct blk_mq_tag_set *tag_set;
> =09spinlock_t queue_lock;
> =09void *priv;
> -=09fmode_t file_mode;
> +=09bool writable;
> };

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

