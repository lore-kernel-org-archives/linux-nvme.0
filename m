Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F6EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 05:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eUHv1b8aqLsb4R7LditAal7kNTag6lxKqXAOQ2qujCU=; b=1mosimez9p8ig/CKNPvg7j/zEt
	0iwDcTTQ1cOyGi5o02zLElLd46wcgJzgDF79nqTQ6DFrS0Ca1NWz6SpxjSil+gKOm3vJgjywS6MHf
	hFieGPD9dsWa2WJmJUhJPZ2wbFO+TFLMsd1j+JyGSnw8NYkgM1KAe9fcYEnutFx8Z3torIoXY61Oc
	0DcerAGf7kxPnfdAyiR40vBe6RWzD8USnANl06q5FcCUSWyfyvlpGjLQMn4UqmqyTjc7ey7+T/l/C
	wwmCT/jOhitrYpmkbcQwSizCbH9OUoH+WzlliT5SfZf66afZyRclzsshka/FQDbW81kjhiLXNN7m9
	v16O6aeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qE1S1-00Bvlf-2v;
	Tue, 27 Jun 2023 05:41:17 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qE1Rv-00BvkY-0O;
	Tue, 27 Jun 2023 05:41:12 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b4f9583404so34904725ad.2;
        Mon, 26 Jun 2023 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687844470; x=1690436470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUHv1b8aqLsb4R7LditAal7kNTag6lxKqXAOQ2qujCU=;
        b=fG/WGax37UoauKBSyv6kej64LdcGJrv6k66h8NGOsMv9uaUsNclSu7DiDyHvg7N0+H
         TpLbLvnFmTkLJuRzyFn0V5R9/xG3MBNfmS6gpoZxFQmbIvFJa8XU1iIC6Fyl95ACCFHi
         Ys+3TEnr35uP041kETcaQnaFL3Zzmuv0Ara4RUBuuI4A1DlyY37o026XtSt1PCG00d7o
         R82xvUrMlfJH4JujFDKNZYqLCuYZs3onB7GlXFtQZdgcqNFnR06TCpWzVOviTJnvGG64
         v3WIIO+Pf3siD1OxDgXeCgfd8ad+rtq0TuDOYOoPNLLpd/YOKy903+fL59/xrY4ynCa9
         WP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687844470; x=1690436470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUHv1b8aqLsb4R7LditAal7kNTag6lxKqXAOQ2qujCU=;
        b=mGaiuRiHZ4hve0FHk2jpnPytyscxtnABUttGsEmmCaxuzIpI3Z00/9ptmZ7c2Z/PjV
         S6Q38+U7ZrMXku5ggcl92NEQMsp6hF7cs3Ixqpq31pl2vzQilZJFMoJAwU2XOjAqvkKm
         s/RAD2Fno9/tor86gxsFMdMXf95zC1dM7iAEsqNYjSJYU49LtYzIjAQmBPXjm1bf0PcJ
         +acuN1U1Md5id96EqUuQtu7MIZWalhmub6zngm5wDM49CGCSO0aAwa5PlidtjHSKz68F
         auk+ELfkI3GCG0OMsM/L0cbQIdSGI0GJEnS/AWIgvl5vquVyfoAq1H1u0aQJWNIW5VzQ
         WD8g==
X-Gm-Message-State: AC+VfDzKhDpkPPRUgu01fXelEpYDvLtBYTgL+CjPRQAhvzPDXO6yB4ag
	E8DfApe8e7+/YHZk4PZPQnk=
X-Google-Smtp-Source: ACHHUZ4Aj+CfQoLGg0YEyBUDipJUlv6nej6ije3P7CId9SMSoIBcFwHmOjcIwHyQMLpCclEzduuKWQ==
X-Received: by 2002:a17:902:f54b:b0:1b6:b805:5ae3 with SMTP id h11-20020a170902f54b00b001b6b8055ae3mr10571515plf.3.1687844469519;
        Mon, 26 Jun 2023 22:41:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9-20020a1709026a8900b001b80d411e5bsm2144863plk.253.2023.06.26.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:41:09 -0700 (PDT)
Date: Mon, 26 Jun 2023 22:41:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
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
Message-ID: <fb21bb8b-958a-4238-aab8-c2720ac519ad@roeck-us.net>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_224111_166075_3E1972EE 
X-CRM114-Status: GOOD (  18.99  )
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

$ git grep cdrom_release
Documentation/cdrom/cdrom-standard.rst:         cdrom_release,          /* release */
Documentation/cdrom/cdrom-standard.rst:the door, should be left over to the general routine *cdrom_release()*.
Documentation/cdrom/cdrom-standard.rst: void cdrom_release(struct inode *ip, struct file *fp)
                                                                           ^^^^^^^^^^^^^^^^^
drivers/cdrom/cdrom.c:void cdrom_release(struct cdrom_device_info *cdi)
drivers/cdrom/cdrom.c:  cd_dbg(CD_CLOSE, "entering cdrom_release\n");
drivers/cdrom/cdrom.c:EXPORT_SYMBOL(cdrom_release);
drivers/cdrom/gdrom.c:  cdrom_release(gd.cd_info, mode);
                                                ^^^^^^
drivers/scsi/sr.c:      cdrom_release(&cd->cdi);
include/linux/cdrom.h:void cdrom_release(struct cdrom_device_info *cdi);

$ git grep cdrom_open
Documentation/cdrom/cdrom-standard.rst:         cdrom_open,             /* open */
Documentation/cdrom/cdrom-standard.rst: int cdrom_open(struct inode * ip, struct file * fp)
Documentation/cdrom/cdrom-standard.rst:This function implements the reverse-logic of *cdrom_open()*, and then
drivers/cdrom/cdrom.c:static int cdrom_open_write(struct cdrom_device_info *cdi)
drivers/cdrom/cdrom.c:int cdrom_open(struct cdrom_device_info *cdi, blk_mode_t mode)
drivers/cdrom/cdrom.c:  cd_dbg(CD_OPEN, "entering cdrom_open\n");
drivers/cdrom/cdrom.c:                  if (cdrom_open_write(cdi))
drivers/cdrom/cdrom.c:EXPORT_SYMBOL(cdrom_open);
drivers/cdrom/gdrom.c:  ret = cdrom_open(gd.cd_info);
                                         ^^^^^^^^^^
drivers/scsi/sr.c:      ret = cdrom_open(&cd->cdi, mode);
include/linux/cdrom.h:int cdrom_open(struct cdrom_device_info *cdi, blk_mode_t mode);

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
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

