Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC0C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=StU8bsjNjflHj0YFd3pOgj01pYtuKwFRrsba2nNmHxc=; b=plm+bYRHthTKAdmsb4t3JDlbBU
	2TnL15GdCIWRTiQ/Uvoopeg3TIvQO9WGga2B/CDOxXfOrH4EbZUMroXbTzHLNjbe24vOknF2o2ZAh
	Ii7VNthg2GHyMrZ6CLxArYI2xU7CC1N5XdHTEOPLR2Dxw+9+NTDaxBGPTFgD/EidkYwrCA0/qly5x
	O645Y1ajZfwZlqMukcNpyyGsR2DdzpedvxrJJh4xBuqc19lMjMfbr/QCuUJGv5varFNcF/fynQzMv
	e8V9t6GqexPY1aTWjxiWNdppZcYUAJ5zWq9QM6si3nCEGUJqczADIdacS3QwYmezI+T00HIjapZgO
	/ttZSXGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s2p-005oA0-0n;
	Wed, 07 Jun 2023 12:13:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s2j-005o5F-13;
	Wed, 07 Jun 2023 12:13:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1308218B8;
	Wed,  7 Jun 2023 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StU8bsjNjflHj0YFd3pOgj01pYtuKwFRrsba2nNmHxc=;
	b=dMMg+c9NJGeIwDBEGbx2Qu0RmdyzjEbDquVhtxZPyu0hsWDj62tdshi8Pk+C/wPadb/RFE
	FnFkUmm9S3NcyQ4hIfWvWWKM5Qe4kSe5QdN4EGvw7IISWJ49A0dyy9AvJh3Hu0hoLwhkxh
	nEwP4x5dY8zjOJEiuhgizoLxmTJK3bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StU8bsjNjflHj0YFd3pOgj01pYtuKwFRrsba2nNmHxc=;
	b=UHMYFZOyP/acMA8ezhNsMXSgaL/blHnAMYHL7lhda0+2cRiUsjJd9ypcsD0e8JWz2sThGU
	CZGpXJmSh+0RoTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF4DF13776;
	Wed,  7 Jun 2023 12:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QoqCKm10gGSJPQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:13:33 +0000
Message-ID: <a7524776-f4c3-147a-cfa5-da92d2f877bb@suse.de>
Date: Wed, 7 Jun 2023 14:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened for
 data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051337_523170_DC996BDE 
X-CRM114-Status: GOOD (  22.93  )
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

On 6/6/23 09:39, Christoph Hellwig wrote:
> Set a flag when a cdrom_device_info is opened for writing, instead of
> trying to figure out this at release time.  This will allow to eventually
> remove the mode argument to the ->release block_device_operation as
> nothing but the CDROM drivers uses that argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/cdrom/cdrom.c | 12 +++++-------
>   include/linux/cdrom.h |  1 +
>   2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 08abf1ffede002..adebac1bd210d9 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1172,6 +1172,7 @@ int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
>   			ret = 0;
>   			cdi->media_written = 0;
>   		}
> +		cdi->opened_for_data = true;
>   	}
>   
>   	if (ret)
> @@ -1252,7 +1253,6 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>   void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>   {
>   	const struct cdrom_device_ops *cdo = cdi->ops;
> -	int opened_for_data;
>   
>   	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
>   
> @@ -1270,14 +1270,12 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>   		}
>   	}
>   
> -	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
> -		!(mode & FMODE_NDELAY);
> -
>   	cdo->release(cdi);
> -	if (cdi->use_count == 0) {      /* last process that closes dev*/
> -		if (opened_for_data &&
> -		    cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
> +
> +	if (cdi->use_count == 0 && cdi->opened_for_data) {
> +		if (cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
>   			cdo->tray_move(cdi, 1);
> +		cdi->opened_for_data = false;
>   	}
>   }
>   EXPORT_SYMBOL(cdrom_release);
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 0a5db0b0c958a1..385e94732b2cf1 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -64,6 +64,7 @@ struct cdrom_device_info {
>   	int (*exit)(struct cdrom_device_info *);
>   	int mrw_mode_page;
>   	__s64 last_media_change_ms;
> +	bool opened_for_data;
>   };
>   
>   struct cdrom_device_ops {

Do we care about alignment here?
integer followed by a 64 bit value followed by a bool seems
like an automatic padding to me ...

Cheers,

Hannes


