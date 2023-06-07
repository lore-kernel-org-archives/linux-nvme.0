Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B66C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B3Xg67NbOS5YKdaySGyicbSsoGzlBjyHFHEFD4Mj8fk=; b=q1gnCy0J5yE/PYSW4GMaSkSdnK
	BYHsiSB+gMVVYsFdqimBOaBZBAzDP0jdnVexnTe+bXRY1aRMMYZxaPVfSvu52nCMyXV5tvADT1NjP
	361f30lu+e9pmhQcGYnXK1MPV5okmxtPclKULUSkKdlDTdije9bjR7N82KiVx1VeHP35ljuMwvW9x
	xjeL5E22w0dP/laAD97gaFPBoe+zapNbTJ2t+us39Pa/N0fHQuzdE1ySJ/pvwlGqSxgAHCcTANpdK
	PEsdjioi596IIA4HVH13uuzbijUGBYIHhzEH3elI4jKw78haSGDsuQcm2lmn7eHJTJmZuypAbfI5+
	Whu1JrgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s81-005pjV-28;
	Wed, 07 Jun 2023 12:19:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s7y-005pgu-07;
	Wed, 07 Jun 2023 12:19:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 992EB219BF;
	Wed,  7 Jun 2023 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3Xg67NbOS5YKdaySGyicbSsoGzlBjyHFHEFD4Mj8fk=;
	b=Zf8A5Tyivs1LBVr9z9fcut+KsQs3kcPY5GvqULx5P0MxaNd5oWQGh+1UzbHH7L+ejvrrTh
	JDmnIQJNe0G+Z00BxJB1bq4IRuImozBYRQpd4LwynxswtstxT9j1wT23SZh+ZR9kxi9nY9
	fU/9FYrR7hcLl9YyuWLg9NqNhV/Ku4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3Xg67NbOS5YKdaySGyicbSsoGzlBjyHFHEFD4Mj8fk=;
	b=eV5SDjF+54GbLqg30Fap2sfm11c6Xv616rnS3/fxtHlHOpZy29z55XNlWk4So5K2w2nPsG
	Z+0rka3GXG+V67DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6987D13776;
	Wed,  7 Jun 2023 12:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ngODGbR1gGR3QAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:19:00 +0000
Message-ID: <30183892-dce6-6946-2f7a-1bc693a657a2@suse.de>
Date: Wed, 7 Jun 2023 14:19:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/31] block: share code between disk_check_media_change
 and disk_force_media_change
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
 <20230606073950.225178-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051902_215459_0441AB73 
X-CRM114-Status: GOOD (  19.78  )
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
> Factor the common logic between disk_check_media_change and
> disk_force_media_change into a helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/disk-events.c | 37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/block/disk-events.c b/block/disk-events.c
> index 8b1b63225738f8..06f325662b3494 100644
> --- a/block/disk-events.c
> +++ b/block/disk-events.c
> @@ -262,6 +262,18 @@ static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
>   	return pending;
>   }
>   
> +static bool __disk_check_media_change(struct gendisk *disk, unsigned int events)
> +{
> +	if (!(events & DISK_EVENT_MEDIA_CHANGE))
> +		return false;
> +
> +	if (__invalidate_device(disk->part0, true))
> +		pr_warn("VFS: busy inodes on changed media %s\n",
> +			disk->disk_name);
> +	set_bit(GD_NEED_PART_SCAN, &disk->state);
> +	return true;
> +}
> +
>   /**
>    * disk_check_media_change - check if a removable media has been changed
>    * @disk: gendisk to check
> @@ -274,18 +286,9 @@ static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
>    */
>   bool disk_check_media_change(struct gendisk *disk)
>   {
> -	unsigned int events;
> -
> -	events = disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
> -				   DISK_EVENT_EJECT_REQUEST);
> -	if (!(events & DISK_EVENT_MEDIA_CHANGE))
> -		return false;
> -
> -	if (__invalidate_device(disk->part0, true))
> -		pr_warn("VFS: busy inodes on changed media %s\n",
> -			disk->disk_name);
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
> -	return true;
> +	return __disk_check_media_change(disk,
> +			disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
> +						DISK_EVENT_EJECT_REQUEST));

Can you move the call to disk_clear_events() out of the call to 
__disk_check_media_change()?
I find this pattern hard to read.

Cheers,

Hannes


