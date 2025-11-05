Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D323CCFA04
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+rHhuZ4uEdLaPfOOR/QgLQrYPPh6ePzL6uoXusgmd4=; b=MUNpsKr5HGzwQsGn7MmxpjQ4Ai
	FLxPxi5vKqNbc3BehDm9MKJ1qlDi5q5X9OUZ8IyZ7lMsA8lRlwEj/kpH8lyF4iPE9XQEyVu5SjYXd
	A/A8EHSu5NmOOOe3XwdRDTfVAuX5FM7DF5q+EdvWhTH1OclEugW6sCguyn2UT3SCJ/yc9lMFlKGin
	KTKnnwXwEj7YDTDcZCwhHVzTU9W5UQ8Tvre3zZVRZuo23qLqd6JsmmpH0k12KZpMV0hs7F2tjMW0C
	NCkt7Xq3aDlc1QibymrUvvcYUAbCXfgcMShToBPmcrbGywwTdclGNyz43hxONvElJqJgr+tJkNzRx
	BSbrF0ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXeq-0000000D9GE-3opY;
	Wed, 05 Nov 2025 07:10:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXeo-0000000D9Ep-0eDs
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:10:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64E921F394;
	Wed,  5 Nov 2025 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+rHhuZ4uEdLaPfOOR/QgLQrYPPh6ePzL6uoXusgmd4=;
	b=Y++xhtPbdLRgTrsEIdbgKGVAAccSHsgjzVlpnI/VSPLgAnN3OLibutXRHGzS9oBQbEwCVc
	xXIyDv3lS/orKNhXCnRrB/zPSmCKcTSeBF2tY9cdaK1vaknB+HS2S4O2OkqOMkUZUUMgzY
	oJu+4147Gt2ToSQUYWxtTg+TQaAZ10I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+rHhuZ4uEdLaPfOOR/QgLQrYPPh6ePzL6uoXusgmd4=;
	b=iEus27aW1EBcbrMdlt5h37BTHBAfQ+g3fnWcD7Eyv1VEtQdzd2BuMo8qWuHd4xMqtVybRT
	Uz0kxWrHELjmXnBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+rHhuZ4uEdLaPfOOR/QgLQrYPPh6ePzL6uoXusgmd4=;
	b=Y++xhtPbdLRgTrsEIdbgKGVAAccSHsgjzVlpnI/VSPLgAnN3OLibutXRHGzS9oBQbEwCVc
	xXIyDv3lS/orKNhXCnRrB/zPSmCKcTSeBF2tY9cdaK1vaknB+HS2S4O2OkqOMkUZUUMgzY
	oJu+4147Gt2ToSQUYWxtTg+TQaAZ10I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+rHhuZ4uEdLaPfOOR/QgLQrYPPh6ePzL6uoXusgmd4=;
	b=iEus27aW1EBcbrMdlt5h37BTHBAfQ+g3fnWcD7Eyv1VEtQdzd2BuMo8qWuHd4xMqtVybRT
	Uz0kxWrHELjmXnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7913E132DD;
	Wed,  5 Nov 2025 07:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PBtdGVP4CmkZFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:10:11 +0000
Message-ID: <6a3092d9-c20a-4e5f-917f-e3f491c495e7@suse.de>
Date: Wed, 5 Nov 2025 08:10:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] block: introduce blkdev_report_zones_cached()
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
 <20251104013147.913802-11-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-11-dlemoal@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_231014_337597_27E6AC9E 
X-CRM114-Status: GOOD (  15.85  )
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
> Introduce the function blkdev_report_zones_cached() to provide a fast
> report zone built using the blkdev_get_zone_info() function, which gets
> zone information from a disk zones_cond array or zone write plugs.
> For a large capacity SMR drive, such fast report zone can be completed
> in a few milliseconds compared to several seconds completion times
> when the report zone is obtained from the device.
> 
> The zone report is built in the same manner as with the regular
> blkdev_report_zones() function, that is, the first zone reported is the
> one containing the specified start sector and the report is limited to
> the specified number of zones (nr_zones argument). The information for
> each zone in the report is obtained using blkdev_get_zone_info().
> 
> For zoned devices that do not use zone write plug resources,
> using blkdev_get_zone_info() is inefficient as the zone report would
> be very slow, generated one zone at a time. To avoid this,
> blkdev_report_zones_cached() falls back to calling
> blkdev_do_report_zones() to execute a regular zone report. In this case,
> the .report_active field of struct blk_report_zones_args is set to true
> to report zone conditions using the BLK_ZONE_COND_ACTIVE condition in
> place of the implicit open, explicit open and closed conditions.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c      | 88 +++++++++++++++++++++++++++++++++++-------
>   include/linux/blkdev.h |  2 +
>   2 files changed, 77 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

