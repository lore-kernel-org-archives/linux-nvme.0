Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D60C7EE2F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzrxvHE7NOsDG+KS0tlYsM4OII1tBEP7fRMkD9ta1LM=; b=wkvy1QcxC9YVgnGl5S6xdzsgHY
	i/lMr4TXwOFg8fVao3uJGevH4JuoP+7kXhhJpaNEqv8Qw583fmL/un+AXzJ35h1VTskA1+xXPj6tR
	t93bC2E58af1f2X4BFWfhwM4zLgM2/upf+RWPSaY+VLmfWZa5I6RtVLOAsRwa0VPAB7F4pHDfEhRf
	NaWlMIeoXnaibz+2tUT1kFQxOAhu/aI4X5oGdJUrQJ15M98buqFp+Zy+z9FYOvw7vlLpocBW37LXb
	pYMek2VUIE54BsqBGcyh1Q4DzMabSnAFSD7pd5vGV/NrP2oqnQFD78uv2sXrowtUnGW3JJIlFYxJd
	6wfJA8Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6feJ-003XuD-2v;
	Tue, 06 Jun 2023 22:59:35 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6feH-003XrV-07
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 22:59:34 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7a8089709so30311065e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686092369; x=1688684369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzrxvHE7NOsDG+KS0tlYsM4OII1tBEP7fRMkD9ta1LM=;
        b=dPBbqXFS82u/OyXTZWp6fXeJmGza5q6dVa5qz3VIcZuY3ttrTYxwiWgluNlWkTlMHS
         nr1NagSevnp3gcPfL+kiCiB3WIarpN0pgeCvHxSkBKjcjt+hu5N1Ft+/6M9I8wrHDoyn
         9ycgq/Rw7NnFSNhYqDYV0c86KZdoApl9s6kWkF+s0hGgLYcofhqvB8kmW/BZ+LKMR//A
         gwuJ0w+LXlMxibiExmvI39ydW+5R96o5Dj5hVb4IzQeS/zsCQmqqjO7QkeXRJL2RSe4t
         6PrHCQqgVj8mU9U37sOH8TIm5TIb7ksdihwA/BJR/rIS7FZXiO40utLCY94h1/n/iUKk
         stqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686092369; x=1688684369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzrxvHE7NOsDG+KS0tlYsM4OII1tBEP7fRMkD9ta1LM=;
        b=QUGN3p9BUPsoIqTC4lNnNMIMsSER7NlnwWEGKy2sB9P23F2Kty9ikGL61lakOys5YH
         dew98gTy4iaKvIs/VNUJQzUQeeyy7qUE/oOMf8rvrABFQmrUbq4zks20Hf6PLZoNiYOF
         g3KEE7jOTqdfsKmf7qNy1yA72ySb6rcetodQc0fE5cZh4t71HQB0gLy3BFBNb+1yr3X7
         vzijcgLLwCKaKtJyl75nBgELMI4HgTecDsh1t96PZWg2PVNUI+kppqoyk0h74kMpnpuV
         qIvV+Q9rryhETMHmXh3jI1XnNIoW7r3/W7MZ5Z7UYr9W/fEkENO1ShvuvTamMKzUqW4l
         PLOw==
X-Gm-Message-State: AC+VfDw1/e7BKn/Su+9DVkMlIboZqiqhMJ9Z2ueuUPORCaCwJWKJ5CkM
	Vo151EiJoAI2kEKZ8LwplpjYTA==
X-Google-Smtp-Source: ACHHUZ5dEmrYamI1Roz1b/XXwx7e2SyRLgLDxBk8a4qqwZElHaxX8CqOd+UmcQ9YIORhk7TJQYcx6A==
X-Received: by 2002:adf:ff8e:0:b0:30e:412a:841b with SMTP id j14-20020adfff8e000000b0030e412a841bmr2765794wrr.37.1686092369334;
        Tue, 06 Jun 2023 15:59:29 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b002fed865c55esm13607049wrq.56.2023.06.06.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:59:28 -0700 (PDT)
Date: Tue, 6 Jun 2023 23:59:27 +0100
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
Subject: Re: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened for
 data
Message-ID: <ZH+6T/ibWkjSrWdt@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_155933_095863_E691B0ED 
X-CRM114-Status: GOOD (  25.20  )
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

On Tue, Jun 06, 2023 at 09:39:24AM +0200, Christoph Hellwig wrote:
> Set a flag when a cdrom_device_info is opened for writing, instead of
> trying to figure out this at release time.  This will allow to eventually
> remove the mode argument to the ->release block_device_operation as
> nothing but the CDROM drivers uses that argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/cdrom/cdrom.c | 12 +++++-------
>  include/linux/cdrom.h |  1 +
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 08abf1ffede002..adebac1bd210d9 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1172,6 +1172,7 @@ int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
>  			ret = 0;
>  			cdi->media_written = 0;
>  		}
> +		cdi->opened_for_data = true;
>  	}
>  
>  	if (ret)
> @@ -1252,7 +1253,6 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>  void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
> -	int opened_for_data;
>  
>  	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
>  
> @@ -1270,14 +1270,12 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>  		}
>  	}
>  
> -	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
> -		!(mode & FMODE_NDELAY);
> -
>  	cdo->release(cdi);
> -	if (cdi->use_count == 0) {      /* last process that closes dev*/
> -		if (opened_for_data &&
> -		    cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
> +
> +	if (cdi->use_count == 0 && cdi->opened_for_data) {
> +		if (cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
>  			cdo->tray_move(cdi, 1);
> +		cdi->opened_for_data = false;
>  	}
>  }
>  EXPORT_SYMBOL(cdrom_release);
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 0a5db0b0c958a1..385e94732b2cf1 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -64,6 +64,7 @@ struct cdrom_device_info {
>  	int (*exit)(struct cdrom_device_info *);
>  	int mrw_mode_page;
>  	__s64 last_media_change_ms;
> +	bool opened_for_data;
>  };
>  
>  struct cdrom_device_ops {
> -- 
> 2.39.2
> 

Looks good, thanks.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

