Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FA1C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uaCDM0b5Dc2HBBjC+zW0SWZcPsJhQ3Z48R0iIMtV7hA=; b=erHdjfhdLtvz169NxiCVU88CB6
	2ObAKaOHtuIDctHMK3lBtSx8Yji1tTtrkds/77/H47JLhkkkU/BFYVUIFgDEcCc/mafXer/QTA0fH
	HJAYGQrSDY1wTqEnqnIaif6vdRJErcrGXTADVGZPeuOHmCW/dJJqLcMH3OS14XXX/FxCt8cO+WtvC
	OahEZaD2nHUiRuNZUcxR8YMHS/BRlmD2RFyDd2wnJHdfbnFdNkdwfm9l9ryew60OAviRT7bk+DYw0
	9nHqU0uUy4Gal+XEDWB4LXlERui2Mqc8ZkS1okskyStLkZT+y5n3ZPiHhHuItVxpo7+OzLxdXBuAg
	XR/krWrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rruLJ-0000000EIPb-017U;
	Wed, 03 Apr 2024 06:43:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rruLA-0000000EINq-49zp
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 06:43:24 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57E6133C9B;
	Wed,  3 Apr 2024 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712126598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaCDM0b5Dc2HBBjC+zW0SWZcPsJhQ3Z48R0iIMtV7hA=;
	b=AYvYeP4RPBAmgB3pKI9F33cesqn44MGWkrnSTyjOhEnqlpT6C6NddR7xdJb+H9PSbGQArI
	pKGJ2bdjxenY6jqrnk1B2X2rVR0Fk5nxWTUgoJ57ggjva+qYxF5UbsnAUC6tDJHhK2yKAv
	oIqTU9CC7Xz/h6wZie3TEKZ+oEyLjCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712126598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaCDM0b5Dc2HBBjC+zW0SWZcPsJhQ3Z48R0iIMtV7hA=;
	b=wodbNKg6vuAzzYAw347BOECVPslUKR1WZjMsUNsNgej0SHUVaYmqIGlMW886f4Tx4LK/UY
	YmNDqBk+Htg1cjCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FE2313357;
	Wed,  3 Apr 2024 06:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qOypG4X6DGb8CAAAn2gu4w
	(envelope-from <hare@suse.de>); Wed, 03 Apr 2024 06:43:17 +0000
Message-ID: <8d0b8e39-7ca5-40eb-9f87-83c55e9357e2@suse.de>
Date: Wed, 3 Apr 2024 08:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/28] block: Replace zone_wlock debugfs entry with
 zone_wplugs entry
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-26-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240402123907.512027-26-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_LONG(-0.06)[-0.061];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 57E6133C9B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_234321_312365_4C3A4B09 
X-CRM114-Status: GOOD (  12.34  )
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

On 4/2/24 14:39, Damien Le Moal wrote:
> In preparation to completely remove zone write locking, replace the
> "zone_wlock" mq-debugfs entry that was listing zones that are
> write-locked with the zone_wplugs entry which lists the zones that
> currently have a write plug allocated.
> 
> The write plug information provided is: the zone number, the zone write
> plug flags, the zone write plug write pointer offset and the number of
> BIOs currently waiting for execution in the zone write plug BIO list.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-debugfs.c |  2 +-
>   block/blk-mq-debugfs.h |  4 ++--
>   block/blk-zoned.c      | 31 ++++++++++++++++++++++++-------
>   3 files changed, 27 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


