Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893C5CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ieV4gtk+MMlsEV2jR3L9psPPjm2FxdbRvV0d7MlGps=; b=4iqKBHVDNKiDqTS8Ya3DcSEXZS
	ykiCITzjIo3QjIqnWbudW9y2AGy5OQ+eJhn+N0gvJ75KSTnp1bwBfpmSwHs6xAgbHd+zLYOqUOqWO
	EQN0pplRBfwjD30SmGsJ9rU8FtbTXcrTR8SpcdpSqNgnKjnit690t6y9D/afXqCSh/yNYIt6BPDYz
	cvwbOGCAlT74rzWe3AcbtcyjMsAdUPHHfUVDxT3NBRVFfT6x3xQ7Zl6/ihHF6ZphwvOEGM93xXU9z
	vH6+JWsPMlA18Mkmfw2T+tjRsRZF6Ly7O/t+6AU09NVuQ1d4R/DuKp9VhiV1CBTpW0pSRx0G/mqvl
	/W3E2EZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs2Xp-0000000GjzU-3wGt;
	Wed, 03 Apr 2024 15:28:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs2Xi-0000000Gjt2-1IG5
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 15:28:56 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD0093720F;
	Wed,  3 Apr 2024 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712158128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ieV4gtk+MMlsEV2jR3L9psPPjm2FxdbRvV0d7MlGps=;
	b=KSwSzPW3rJUs63Zbnl/oCRvbpFCbpZPCjIdo2ciz6TKd15J+kMCM0gZ1wzXGJgI1Ze046P
	YHX8bCvKKFjOkTvi8xlM0C2KH0wE7QAbDCaElg26gz5QDk7wrqXRdvr6c9ioWpgydUKrFF
	NpEBVurxPTiQ2cFVnYLSUeS2RVltCF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712158128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ieV4gtk+MMlsEV2jR3L9psPPjm2FxdbRvV0d7MlGps=;
	b=qIshLm3rDBn7S4NwB4UQ2sZJzspXmUG0tCXH6TBF6CGcXdTsE2wOQ9iQjfrSIxzRt3fCE0
	nUKd/L+ZhNNJNrDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E40A11331E;
	Wed,  3 Apr 2024 15:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +KDeMq91DWaMdAAAn2gu4w
	(envelope-from <hare@suse.de>); Wed, 03 Apr 2024 15:28:47 +0000
Message-ID: <0e93e91e-e8f8-44ed-bb46-48cc8d7bbd1f@suse.de>
Date: Wed, 3 Apr 2024 17:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/28] block: Fake max open zones limit when there is
 no limit
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-9-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240403084247.856481-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD0093720F
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.19)[-0.965];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_082850_630230_0A801EC4 
X-CRM114-Status: GOOD (  12.62  )
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

On 4/3/24 10:42, Damien Le Moal wrote:
> For a zoned block device that has no limit on the number of open zones
> and no limit on the number of active zones, the zone write plug mempool
> is created with a size of 128 zone write plugs. For such case, set the
> device max_open_zones queue limit to this value to indicate to the user
> the potential performance penalty that may happen when writing
> simultaneously to more zones than the mempool size.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 41 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


