Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110F4C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wm8rbgtQGj5fjmx4DpdJ99Rxhb+FVTdyCOYiK/QjpTQ=; b=hAmBvGc0+NlWc7asxncnX8MWPV
	F/ggvYHOcXUQ19NnkHs0eXunani0K8qFYocfbqKmqWsWQDlmDXT4542+KI09Tgh07C3GO3YgmhEmZ
	NhycIwbWeQiJQVFAA/zBpJ7ImrMmUO8Sqe5YFX2KTif1zIt1NCIhDTQqXrKrBrIzWlt4LWDE3FyJ0
	W6da3Y+DFSLsAKEfb3AE/LAsHysMG8Ln50w8P0Bkj6+eqfopdV1HsLS8Pg3ezgPblHO/aRFjfsPbw
	dbQIBaWkCzD18VHrkUpfxcrLn3jOcpOLd83xU+r9HWDpzRFO84bjAz2ty+vDjHySFY/nWN1WkChd6
	3rrd9gPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFStA-0000000Cdye-17Lw;
	Fri, 07 Jun 2024 06:15:48 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSt1-0000000CdwU-1S3T
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 06:15:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 236FC21B47;
	Fri,  7 Jun 2024 06:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717740937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm8rbgtQGj5fjmx4DpdJ99Rxhb+FVTdyCOYiK/QjpTQ=;
	b=RPP9tipxppuNQDe1361B7Dv2Aa7xWByIGLWixigi21EQTvvjBRcy/rrUQAyScfqtKcXtvY
	+By8FRVx55ifjQLogUSGI2DtIPJW+9NGlzVtlkHD4oKq9yuwYpLzkXsla3qhaFsuEE08Tr
	1UYBUACugq0qhOshCZwNFitidbDdWiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717740937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm8rbgtQGj5fjmx4DpdJ99Rxhb+FVTdyCOYiK/QjpTQ=;
	b=kHdMmZUR+pezLBawCRSRXgq7RHoftyLz85dArPbIZ4ZujOss6yBZ0HEYf+Y9mBPWSu4oDc
	lY76/avVdEpl5zBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jxUArSxv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GLtbWZ9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717740936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm8rbgtQGj5fjmx4DpdJ99Rxhb+FVTdyCOYiK/QjpTQ=;
	b=jxUArSxvkZ3Kv8bqJ426vmTVzlZTCbG9eLigFNOaedqIishUxwmoff6i4K0a2VH5O1lXP3
	2liDgbcP+62hrYxlap8k3JVnoDGspB/22bYpIJkknrs1vTOvpOOzyIEVz5M79YCCdOZpfm
	lVCrSBNhR9JaWD7lDvuK8ve6brAZaEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717740936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm8rbgtQGj5fjmx4DpdJ99Rxhb+FVTdyCOYiK/QjpTQ=;
	b=GLtbWZ9cdhW/yrp9sWn/T//Wx9mjGjAyeJgmr5ETRFRf/yrFZ1GsaF5dDSMArDh9YmSx2d
	RUV222qdeCdLcQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BCB1133F3;
	Fri,  7 Jun 2024 06:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vJ2CDIelYmZEYAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Jun 2024 06:15:35 +0000
Message-ID: <9f649939-2fd0-4c97-947f-3de8cd631706@suse.de>
Date: Fri, 7 Jun 2024 08:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] block: remove the blk_integrity_profile structure
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240607055912.3586772-1-hch@lst.de>
 <20240607055912.3586772-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240607055912.3586772-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 236FC21B47
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_231539_561532_6BBC9E5D 
X-CRM114-Status: GOOD (  16.19  )
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

On 6/7/24 07:58, Christoph Hellwig wrote:
> Block layer integrity configuration is a bit complex right now, as it
> indirects through operation vectors for a simple two-dimensional
> configuration:
> 
>   a) the checksum type of none, ip checksum, crc, crc64
>   b) the presence or absence of a reference tag
> 
> Remove the integrity profile, and instead add a separate csum_type flag
> which replaces the existing ip-checksum field and a new flag that
> indicates the presence of the reference tag.
> 
> This removes up to two layers of indirect calls, remove the need to
> offload the no-op verification of non-PI metadata to a workqueue and
> generally simplifies the code. The downside is that block/t10-pi.c now
> has to be built into the kernel when CONFIG_BLK_DEV_INTEGRITY is
> supported.  Given that both nvme and SCSI require t10-pi.ko, it is loaded
> for all usual configurations that enabled CONFIG_BLK_DEV_INTEGRITY
> already, though.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/Kconfig                       |   8 +-
>   block/Makefile                      |   3 +-
>   block/bio-integrity.c               |  30 ++--
>   block/blk-integrity.c               |  66 ++++----
>   block/blk-mq.c                      |  13 +-
>   block/blk.h                         |   8 +
>   block/t10-pi.c                      | 241 ++++++++++------------------
>   drivers/md/dm-crypt.c               |   2 +-
>   drivers/nvme/host/Kconfig           |   1 -
>   drivers/nvme/host/core.c            |  17 +-
>   drivers/nvme/target/Kconfig         |   1 -
>   drivers/nvme/target/io-cmd-bdev.c   |  16 +-
>   drivers/scsi/Kconfig                |   1 -
>   drivers/scsi/sd.c                   |   2 +-
>   drivers/scsi/sd_dif.c               |  19 +--
>   drivers/target/target_core_iblock.c |  49 +++---
>   include/linux/blk-integrity.h       |  35 ++--
>   include/linux/blkdev.h              |   9 +-
>   include/linux/t10-pi.h              |   8 -
>   19 files changed, 215 insertions(+), 314 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


