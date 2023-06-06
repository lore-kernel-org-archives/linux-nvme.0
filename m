Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2F4C7EE2A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XZnUqfGVZwo9vlQNApdagMl1Tcok+/+t2NZNcSYyGN4=; b=D62EaIMD+RAVHtOQBwfZCDPWJ5
	IcobtbL+qD7l9uXtGLjmBQSRKGgJI3FHoWwQRO6Zbo2N7DZIihi0pOSQRM8Pn0FhVBMFUnCjfuMeD
	uwRCDo9+7HrQ8+Rph1+O70tssttbpwr35HVcdNVPvQkj1QO5bc+kVcm5KlriiUu8034VvgD6rdnIQ
	PhbGnLHty3I40lnEQkuf0RqDcjhigYbU3+7WlFDkRAy2UNHbUyROS4Y8Js/amvAo37UWWH/pa5dBR
	bd1SzS6DwA4yt1pkFqRH1sGUu9TAadCWFsVGD24L3Zne3n4kSlQyYanusemKluxh8Lv9gFmeQsXvb
	7nT9JrFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rw0-000lyr-35;
	Tue, 06 Jun 2023 08:20:56 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Rvu-000lw3-1w;
	Tue, 06 Jun 2023 08:20:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 89E7C63CC135;
	Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id w2bdPD93IvhE; Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 14A1D616B2CD;
	Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X5LSD106M-YC; Tue,  6 Jun 2023 10:20:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D62D563CC135;
	Tue,  6 Jun 2023 10:20:46 +0200 (CEST)
Date: Tue, 6 Jun 2023 10:20:46 +0200 (CEST)
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
	linux-um <linux-um@lists.infradead.org>, linux-scsi@vger.kernel.org, 
	linux-bcache@vger.kernel.org, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nvme@lists.infradead.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-nilfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>
Message-ID: <766259639.3687124.1686039646763.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606073950.225178-26-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-26-hch@lst.de>
Subject: Re: [PATCH 25/31] ubd: remove commented out code in ubd_open
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove commented out code in ubd_open
Thread-Index: XkjrL/wptcQ24bQlPJHDQOJLYTpcmQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_012053_094379_38B8F9AB 
X-CRM114-Status: GOOD (  11.92  )
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
> This code has been dead forever, make sure it doesn't show up in code
> searches.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 7 -------
> 1 file changed, 7 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 8b79554968addb..20c1a16199c503 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1170,13 +1170,6 @@ static int ubd_open(struct gendisk *disk, fmode_t =
mode)
> =09}
> =09ubd_dev->count++;
> =09set_disk_ro(disk, !ubd_dev->openflags.w);
> -
> -=09/* This should no more be needed. And it didn't work anyway to exclud=
e
> -=09 * read-write remounting of filesystems.*/
> -=09/*if((mode & FMODE_WRITE) && !ubd_dev->openflags.w){
> -=09        if(--ubd_dev->count =3D=3D 0) ubd_close_dev(ubd_dev);
> -=09        err =3D -EROFS;
> -=09}*/

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

