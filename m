Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F27C87FDC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4AyxSeVCWLu668XQQXcZmNRbTvqm+XfWnbYRI3bfM+o=; b=S3twV+6xi/Eivmmh9sznxCUrAK
	zApiLEpZZBtrDcpNTLtxDCvl+AEJqpPyk+656vbquckkIMJdimOYodyb01d5PZO6/CQQA5hbM+94C
	P5st2WPVu3gkBboD5Px/pkgm33NW2s5mVi8VGD7BUOM8THIzPF5qSSQchYAR6zwEfeWENagy8lTTx
	VPJYhwtwF7DBLQ+fDVtSVGetW0TT1myp5P3OzJnHGr41GwXHP1zakN9sUlF9AgZbvQ5ebS4AkInEp
	nZA0Mp04b8IT8L+uzZfM+nBp7eyrI9wsX3tkLA8CJL0heeLV4lSQzJL95ReGd1hr5jUEO4bxl4Q7a
	M9OwxN7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ffm-003YLg-0X;
	Tue, 06 Jun 2023 23:01:06 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ffh-003YJT-1d
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 23:01:03 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so56629915e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686092460; x=1688684460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AyxSeVCWLu668XQQXcZmNRbTvqm+XfWnbYRI3bfM+o=;
        b=ap+1NYchKGrYc446kRWRnQbhMV1pl6YsP5OToBbRr7yqxWuwivol/KLqvKwbFREzDt
         leVawKb5LA6xL6S30/x70zQDywvhkHn7+JCGlKA0lozFIJqWnjRJTp5YJHpex7lWnnUv
         dJkg9spKjZLznLO62AffDpdqoqWcUVXi8VRvJ792SrSPG5RfZag3TIQLuMV3b7gUNrfh
         oTcGuFKfS4159jodmD3xpY5/Ko+Rh5RiDBfrQUvcEy89mqnn+LVVNO5Iw2N5Qiu+JIlB
         FJKkwHEgGck4KgrxHNc30tLse+VJntfkb30BZScrTrWOpflbR4XFpuj885jYKqOuXNkW
         SBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686092460; x=1688684460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AyxSeVCWLu668XQQXcZmNRbTvqm+XfWnbYRI3bfM+o=;
        b=SwCe/A6bFdchbZq7khkg9C/wFN7j4xEbNMfVn7oaRhIqxA074hSpPppugyP+EmsPkD
         7zMzyUipXa/LsOC9+5yTmhitUziQEaqNw5dPr3QCsy5/9k2psBl27JptzuyagApdWZna
         XgTedn7nesCJOXgnL2tuLrQ7QY9ojekOlb+HLcA2Rp9ciiTpvE3xY08a8F/6SRRnmLD3
         +ABXKTSJ2ygER0rQMQ6lgYJk3wcIJqJuxGJSgjcbeaRWZWh2N8fu3hrohtcYETagYzxL
         OuxXZbOuMimOKA9rJ2AD//C26zCKvPFHKd+3hBxm+EfkORwijsFaHEYDo7GXl8Bq+gPD
         KEhw==
X-Gm-Message-State: AC+VfDymglyWUbYBwuPQEraMZsEx+iczHGKnktc3/BZxzm9DrHQ97rAw
	RDdnk1hBJSL8HUaiLx+W9yXcqA==
X-Google-Smtp-Source: ACHHUZ5ZvgvojXp46B2yfDhTglh07h4ImH+yrfGSyDnf68I9NldGnBlDJsUdFl1IxgkatnTdfmUXtg==
X-Received: by 2002:a1c:4c0d:0:b0:3f5:6e6:9d83 with SMTP id z13-20020a1c4c0d000000b003f506e69d83mr2830681wmf.23.1686092459976;
        Tue, 06 Jun 2023 16:00:59 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003f73a101f88sm201447wmj.16.2023.06.06.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 16:00:59 -0700 (PDT)
Date: Wed, 7 Jun 2023 00:00:57 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <ZH+6qd1W75G49P7p@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_160101_546440_D8EE947C 
X-CRM114-Status: GOOD (  19.47  )
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

On Tue, Jun 06, 2023 at 09:39:25AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/cdrom/cdrom.c | 2 +-
>  drivers/cdrom/gdrom.c | 2 +-
>  drivers/scsi/sr.c     | 2 +-
>  include/linux/cdrom.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index adebac1bd210d9..998b03fe976e22 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1250,7 +1250,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>  	return 0;
>  }
>  
> -void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
> +void cdrom_release(struct cdrom_device_info *cdi)
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 14922403983e9e..a401dc4218a998 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
>  	bdev_check_media_change(bdev);
>  
>  	mutex_lock(&gdrom_mutex);
> -	ret = cdrom_open(gd.cd_info, mode);
> +	ret = cdrom_open(gd.cd_info);
>  	mutex_unlock(&gdrom_mutex);
>  	return ret;
>  }
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index 444c7efc14cba7..6d33120ee5ba85 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -512,7 +512,7 @@ static void sr_block_release(struct gendisk *disk, fmode_t mode)
>  	struct scsi_cd *cd = scsi_cd(disk);
>  
>  	mutex_lock(&cd->lock);
> -	cdrom_release(&cd->cdi, mode);
> +	cdrom_release(&cd->cdi);
>  	mutex_unlock(&cd->lock);
>  
>  	scsi_device_put(cd->device);
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 385e94732b2cf1..3f23d5239de254 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -102,7 +102,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
>  
>  /* the general block_device operations structure: */
>  int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
> -extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
> +void cdrom_release(struct cdrom_device_info *cdi);
>  int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
>  		unsigned int cmd, unsigned long arg);
>  extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
> -- 
> 2.39.2
> 

Looks good, thanks.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

