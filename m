Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E9CC54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JoDBb4vvSd1zO76DjFxC3AGl0ZhwFnB4a9QXgghf79I=; b=nxGTUc2eQQ75ZhHpr8j95/lAQA
	TEcXP6GHXoWnJ+t5siKDibDdkt3v3luVtJLQxrFmUZ4vChcE3W0rLkudFC5aKikMvNI3FMOByoXW0
	Zr8dWKzYeqRv9gh1HDwvlt0oZt9MS3WwFT/934UfaXskPIfhTq4KsogVsCo5qwHaZxiLdWTEi/ahj
	RvmmPwz1jNBTH/2TN+tCzCzlSLIwI0xTUbGf6Ef8EphU7Z16hPB0twGcOQo/Kwp/pWb/E7WQjKYJE
	4b88BLWQJfk98zJ/EazBFhtBca9dg8OYBkG9TN+zSLImvsleTBnFI9o6QZlOW/O8ruHR6vmiMgEAF
	Yu/uBS2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI2lP-00000000cCG-2kAY;
	Thu, 22 May 2025 10:02:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI2kh-00000000c3l-1L9F
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 10:02:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8124C1F7EB;
	Thu, 22 May 2025 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747908132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoDBb4vvSd1zO76DjFxC3AGl0ZhwFnB4a9QXgghf79I=;
	b=lZJ1sU2ST57MUiC0jr3S9fnW/cZUTJNf3sO6L0P7jkYxqCK5I7kmTILWpws+AC4k8J1Bof
	cv9VcWPGe1EsUQ/bxAQaCjwKTnvNdcPWyBVRmZKwNBQIYuQXcrkN945r8tK52TySu26Laj
	ONuKrBE1kpenIFQwVpJ0dnwzPojnSSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747908132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoDBb4vvSd1zO76DjFxC3AGl0ZhwFnB4a9QXgghf79I=;
	b=Wm1VMAO4npnuhPjVz1ZNKE+yGKi+lMuSlbq+dUnqgRo4ZDmYyx3KnW2hzyAHl/qkDODyTQ
	5fdXPB06MRHW2qCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747908132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoDBb4vvSd1zO76DjFxC3AGl0ZhwFnB4a9QXgghf79I=;
	b=lZJ1sU2ST57MUiC0jr3S9fnW/cZUTJNf3sO6L0P7jkYxqCK5I7kmTILWpws+AC4k8J1Bof
	cv9VcWPGe1EsUQ/bxAQaCjwKTnvNdcPWyBVRmZKwNBQIYuQXcrkN945r8tK52TySu26Laj
	ONuKrBE1kpenIFQwVpJ0dnwzPojnSSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747908132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoDBb4vvSd1zO76DjFxC3AGl0ZhwFnB4a9QXgghf79I=;
	b=Wm1VMAO4npnuhPjVz1ZNKE+yGKi+lMuSlbq+dUnqgRo4ZDmYyx3KnW2hzyAHl/qkDODyTQ
	5fdXPB06MRHW2qCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63E75137B8;
	Thu, 22 May 2025 10:02:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KHBgFyT2LmhDOgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 10:02:12 +0000
Message-ID: <dc0206b7-1224-409f-960c-11549722482f@suse.de>
Date: Thu, 22 May 2025 12:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] block: new sector copy api
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_030215_502324_3C39459C 
X-CRM114-Status: GOOD (  17.60  )
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

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide a basic block level api to copy a range of a block device's
> sectors to a new destination on the same device. This just reads the
> source data into host memory, then writes it back out to the device at
> the requested destination.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-lib.c         | 62 +++++++++++++++++++++++++++++++++++++++++
>   block/ioctl.c           | 30 ++++++++++++++++++++
>   include/linux/blkdev.h  |  2 ++
>   include/uapi/linux/fs.h |  3 ++
>   4 files changed, 97 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 4c9f20a689f7b..a819ded0ed3a9 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -368,3 +368,65 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>   	return ret;
>   }
>   EXPORT_SYMBOL(blkdev_issue_secure_erase);
> +
> +/**
> + * blkdev_copy - copy source sectors to a destination on the same block device
> + * @dst_sector:	start sector of the destination to copy to
> + * @src_sector:	start sector of the source to copy from
> + * @nr_sects:	number of sectors to copy
> + * @gfp:	allocation flags to use
> + */
> +int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
> +		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
> +{

Hmm. This interface is for copies _within_ the same bdev only.
Shouldn't we rather expand it to have _two_ bdev arguments to
eventually handle copies between bdevs?
In the end the function itself wouldn't change...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

