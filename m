Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A80CCFA04
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdZvQ0i6OaTxmcVuq8+ooiSc+ysgf4J+yTkRFYF9X7U=; b=IIsMksUHjFHIYuCo+qrpAg5e4h
	jPQD7x+bF70LsqHHgjG94ppMQdjBUJU08lTbz3jsXl8NSCTtOPbv830ku0GyjPSdVm0ug5bbhcC4E
	zCThmRrgbIulKYs6ZStXWOrML5OeJj5RdS+K/tVKXRXLdTUJJ7yWb9NLQM0uDxBdewJjtuExolqLo
	yWX5gjBr/4EaXFPe/WcRzBDBYTWIi5VuuUyg9pf1mlTcS7eTFZU9UqVuGtX1ITXoXvOp7mhmePLyB
	rqfirtZsjYGJ7N/pvlC16RNgmR4fVI5NUW99CMNYi7qa/UL6NZCZENUOilKhY/TBy9COU7yYd1cy0
	EhWmiNDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXid-0000000DASY-1ujC;
	Wed, 05 Nov 2025 07:14:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXia-0000000DARW-48cb
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:14:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A86C21192;
	Wed,  5 Nov 2025 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdZvQ0i6OaTxmcVuq8+ooiSc+ysgf4J+yTkRFYF9X7U=;
	b=BQrWy1puabSTI0tkYnmFKPMRqbUccGSXtI2DOoGTcH1WI2AzbP/PtS8JOvN+Xh6YbT5s3Z
	GVGKccwe9i83v2c2sV2RUafuCyz8/Z/wTT7yLOlwEE5bucZqumPvB3VHv0C65n//bAEUbh
	+JT/pxAYsoxRI5xHWIK4ZM16YOEwo6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdZvQ0i6OaTxmcVuq8+ooiSc+ysgf4J+yTkRFYF9X7U=;
	b=eEX2e7QKXAmZgNWiu0Vjwqk/8jMmha27UEXY/hBuyyCuBJtvRhgqemDEhTDGJXTiFOIdYa
	IEZOr4zmKo83ytCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdZvQ0i6OaTxmcVuq8+ooiSc+ysgf4J+yTkRFYF9X7U=;
	b=BQrWy1puabSTI0tkYnmFKPMRqbUccGSXtI2DOoGTcH1WI2AzbP/PtS8JOvN+Xh6YbT5s3Z
	GVGKccwe9i83v2c2sV2RUafuCyz8/Z/wTT7yLOlwEE5bucZqumPvB3VHv0C65n//bAEUbh
	+JT/pxAYsoxRI5xHWIK4ZM16YOEwo6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdZvQ0i6OaTxmcVuq8+ooiSc+ysgf4J+yTkRFYF9X7U=;
	b=eEX2e7QKXAmZgNWiu0Vjwqk/8jMmha27UEXY/hBuyyCuBJtvRhgqemDEhTDGJXTiFOIdYa
	IEZOr4zmKo83ytCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1280132DD;
	Wed,  5 Nov 2025 07:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jxNqKT75CmmmFwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:14:06 +0000
Message-ID: <83168e99-3c65-4b6e-ae09-c3ee1de2cb5b@suse.de>
Date: Wed, 5 Nov 2025 08:14:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] xfs: use blkdev_report_zones_cached()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-16-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-16-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,lst.de:email,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_231409_168926_E81669A8 
X-CRM114-Status: GOOD (  15.75  )
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

On 11/4/25 02:31, Damien Le Moal wrote:
> Modify xfs_mount_zones() to replace the call to blkdev_report_zones()
> with blkdev_report_zones_cached() to speed-up mount operations.
> 
> With this change, mounting a freshly formatted large capacity (30 TB)
> SMR HDD completes under 2s compared to over 4.7s before.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/xfs/xfs_zone_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
> index 23cdab4515bb..8d819bc134cd 100644
> --- a/fs/xfs/xfs_zone_alloc.c
> +++ b/fs/xfs/xfs_zone_alloc.c
> @@ -1231,7 +1231,7 @@ xfs_mount_zones(
>   	trace_xfs_zones_mount(mp);
>   
>   	if (bdev_is_zoned(bt->bt_bdev)) {
> -		error = blkdev_report_zones(bt->bt_bdev,
> +		error = blkdev_report_zones_cached(bt->bt_bdev,
>   				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
>   				mp->m_sb.sb_rgcount, xfs_get_zone_info_cb, &iz);
>   		if (error < 0)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

