Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC8CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=; b=NKUnwVOtNr0rr+dKmndO0siiOk
	FERd3kHYgS8W9Xxc67R07V0JsCX0EpUptDofRC0rzt0XH10ogolPbArh/uUj+wNcE4+0EtGXyGNUZ
	cQUFeSsq3NtsqqYqTYEZ7jsQT4PbXN0CLQ6B2z3wQB9WLjP9y/5YV39o/Yn9cQ280ANBmzzFgQtty
	CklLMnAMwnEsDwzmrfaOSkx2CWL7t5F0xjYt01giQlhRkn0NpAZKKs47wX2CTJdnIEY2MRsOqbagL
	+cQU8unuwPPM0HXJzCVnpbBdsvoCUUerdKL1a15ls5nKU0brZAnfamBcdapObc2YzqmhVGPSiJh7o
	KwSGwX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXfp-0000000D9V9-1Gw4;
	Wed, 05 Nov 2025 07:11:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXfn-0000000D9UE-24HR
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:11:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F72A1F397;
	Wed,  5 Nov 2025 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=rFnoBMMwQCLrredczS2A+OGMgWFLLPlw5ExzGSiORskXO20tfdCrPFZIJ0ffVxegdjJeHt
	OkgdU+1dVIlrG/PyFmc1JDAksS0GnSMnLvw7PRnjOO+hTbnKlHmQaNMPRaMnlN5tHi+DKW
	FEoYRnPvcnaEpwQNsu+IYxus4OwfND0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=GOw5CN6IiaZ+5r4zEgIp0v2E9r3ZHclMbanpQGZnp9ck8XswOuAQaFIYkLdg6wI/7Abo1i
	pvCofUH3YJw2XRAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rFnoBMMw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GOw5CN6I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=rFnoBMMwQCLrredczS2A+OGMgWFLLPlw5ExzGSiORskXO20tfdCrPFZIJ0ffVxegdjJeHt
	OkgdU+1dVIlrG/PyFmc1JDAksS0GnSMnLvw7PRnjOO+hTbnKlHmQaNMPRaMnlN5tHi+DKW
	FEoYRnPvcnaEpwQNsu+IYxus4OwfND0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksQCo3Ad1VfdJUV7onmvH6G6iW7WglY8N/GR2YtrkfM=;
	b=GOw5CN6IiaZ+5r4zEgIp0v2E9r3ZHclMbanpQGZnp9ck8XswOuAQaFIYkLdg6wI/7Abo1i
	pvCofUH3YJw2XRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B449D132DD;
	Wed,  5 Nov 2025 07:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZMZKpD4CmnXFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:11:12 +0000
Message-ID: <ca71da48-0ee2-44b6-badf-5ed933d2a4ff@suse.de>
Date: Wed, 5 Nov 2025 08:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
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
 <20251104013147.913802-12-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F72A1F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_231115_821950_40511064 
X-CRM114-Status: GOOD (  15.48  )
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
> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
> applications access to the fast zone report implemented by
> blkdev_report_zones_cached(). This new ioctl is defined as number 142
> and is documented in include/uapi/linux/fs.h.
> 
> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
> field of struct blk_zone_report also as an input. If the user sets the
> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
> is used to generate the zone report using cached zone information. If
> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
> as BLKREPORTZONES and the zone report is generated by accessing the
> zoned device.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c             | 25 ++++++++++++++++++++++---
>   block/ioctl.c                 |  1 +
>   include/uapi/linux/blkzoned.h | 32 +++++++++++++++++++++++++++-----
>   include/uapi/linux/fs.h       |  2 +-
>   4 files changed, 51 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

