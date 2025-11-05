Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC22CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qu7pQBvotzm5Nih2E53IvQoHgeaDpISMtM7toIFJYVY=; b=sGN5WIE7Vru39JVICKjXiLAb+U
	CnDv5h+7+/r79gbKea/mwini3a9cJaztxQoH03BACOMas6EZZiZ94EQalKcbcEL+V+G6rmjcA4laW
	fUEAHYL/8zWcSIE4kMbSqZ/mWOHPilXHuWp6KG82T0GqV6jSGarWOL1mN4bIFccyCKbq+lxPG0z3P
	ECO0WhydOfqTuhkOwccImsf2bXRWwov00I1ppKEHZyF2qb5XSpB6H6mmHXRGGx9hXWFpmGr2k1Vp+
	ZwhtDxzpOq8jeCH3pYx5T4P0U+ZUwM/rykfpO2Cwwg7LdcG8oTujT+GpBp5Xjwqb8UTmOP7tkGj2G
	kdWVLnxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXbk-0000000D8KU-2aLD;
	Wed, 05 Nov 2025 07:07:04 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXbi-0000000D8JJ-1ND9
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:07:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 504ED1F394;
	Wed,  5 Nov 2025 07:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu7pQBvotzm5Nih2E53IvQoHgeaDpISMtM7toIFJYVY=;
	b=toRcqsk4WSiJ9YE8o2hIUB9sq1wq9zosEIsNiC66IEbQjVpxZh+8scASriI9RnW3UYNOVb
	29TX9EKNT2JJYVVgSLniIKuVBeG+LOCHs+MVL+M4leV3fkW2IWK/MXfEBS4/UPxdGn1qaH
	IbBB71Lj6pk2R58pDVc9IsIdampdmlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu7pQBvotzm5Nih2E53IvQoHgeaDpISMtM7toIFJYVY=;
	b=4W6nZsRVcmWtaCe4ignLB5yqBSjhcatUbvSraeBfJEqMo5GfPoe6EfZFWkGd32kVHsPrp6
	jFEmBnxmJQJK8xCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=toRcqsk4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4W6nZsRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu7pQBvotzm5Nih2E53IvQoHgeaDpISMtM7toIFJYVY=;
	b=toRcqsk4WSiJ9YE8o2hIUB9sq1wq9zosEIsNiC66IEbQjVpxZh+8scASriI9RnW3UYNOVb
	29TX9EKNT2JJYVVgSLniIKuVBeG+LOCHs+MVL+M4leV3fkW2IWK/MXfEBS4/UPxdGn1qaH
	IbBB71Lj6pk2R58pDVc9IsIdampdmlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu7pQBvotzm5Nih2E53IvQoHgeaDpISMtM7toIFJYVY=;
	b=4W6nZsRVcmWtaCe4ignLB5yqBSjhcatUbvSraeBfJEqMo5GfPoe6EfZFWkGd32kVHsPrp6
	jFEmBnxmJQJK8xCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CEA6132DD;
	Wed,  5 Nov 2025 07:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G118EJP3CmlNEQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:06:59 +0000
Message-ID: <a5e59dfc-d4a7-417b-8b25-d59049bb74c8@suse.de>
Date: Wed, 5 Nov 2025 08:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] block: track zone conditions
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
 <20251104013147.913802-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 504ED1F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email,suse.de:mid,suse.de:dkim,wdc.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_230702_534671_7E4D66CF 
X-CRM114-Status: GOOD (  26.87  )
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
> The function blk_revalidate_zone_cond() already caches the condition of
> all zones of a zoned block device in the zones_cond array of a gendisk.
> However, the zone conditions are updated only when the device is scanned
> or revalidated.
> 
> Implement tracking of the runtime changes to zone conditions using
> the new cond field in struct blk_zone_wplug. The size of this structure
> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
> end of the structure.
> 
> Beause zones that do not have a zone write plug can be in the empty,
> implicit open, explicit open or full condition, the zones_cond array of
> a disk is used to track the conditions, of zones that do not have a zone
> write plug. The condition of such zone is updated in the disk zones_cond
> array when a zone reset, reset all or finish operation is executed, and
> also when a zone write plug is removed from the disk hash table when the
> zone becomes full.
> 
> Since a device may automatically close an implicitly open zone when
> writing to an empty or closed zone, if the total number of open zones
> has reached the device limit, the BLK_ZONE_COND_IMP_OPEN and
> BLK_ZONE_COND_CLOSED zone conditions cannot be precisely tracked. To
> overcome this, the zone condition BLK_ZONE_COND_ACTIVE is introduced to
> represent a zone that has the condition BLK_ZONE_COND_IMP_OPEN,
> BLK_ZONE_COND_EXP_OPEN or BLK_ZONE_COND_CLOSED.  This follows the
> definition of an active zone as defined in the NVMe Zoned Namespace
> specifications. As such, for a zoned device that has a limit on the
> maximum number of open zones, we will never have more zones in the
> BLK_ZONE_COND_ACTIVE condition than the device limit. This is compatible
> with the SCSI ZBC and ATA ZAC specifications for SMR HDDs as these
> devices do not have a limit on the number of active zones.
> 
> The function disk_zone_wplug_set_wp_offset() is modified to use the new
> helper disk_zone_wplug_update_cond() to update a zone write plug
> condition whenever a zone write plug write offset is updated on
> submission or merging of write BIOs to a zone.
> 
> The functions blk_zone_reset_bio_endio(), blk_zone_reset_all_bio_endio()
> and blk_zone_finish_bio_endio() are modified to update the condition of
> the zones targeted by reset, reset_all and finish operations, either
> using though disk_zone_wplug_set_wp_offset() for zones that have a
> zone write plug, or using the disk_zone_set_cond() helper to update the
> zones_cond array of the disk for zones that do not have a zone write
> plug.
> 
> When a zone write plug is removed from the disk hash table (when the
> zone becomes empty or full), the condition of struct blk_zone_wplug is
> used to update the disk zones_cond array. Conversely, when a zone write
> plug is added to the disk hash table, the zones_cond array is used to
> initialize the zone write plug condition.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-zoned.c             | 112 ++++++++++++++++++++++++++++++++--
>   include/uapi/linux/blkzoned.h |   9 +++
>   2 files changed, 115 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

