Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCBDC27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=230HRa0bz54MsUMom7WNaqOl6oXXgPs2XLqZwWBQXJo=; b=sibov8gEJjsBndqOFpNHnoXq4T
	nSQcf0QhVUKyi41Mav5j/Y6X8GXng+uFzBmR+R9YbX40k2LknPaW54XlFOyOt6hVuczKE52hdawY4
	JEvPbKx/i/3fa/EEeJ7fOzUaWAbCEHQbYClavf6SpOkGVYmZspf1O6d99UJ4rU9LlFCTpd5pgSUQn
	CF1g/rgaLjGsn+h94IBv+nVp0+MgJvOvSNcLhx0h+TSzbKbkDGwJ7kulK8iaBpCpTwqXbWMDpW3iH
	n+Z27aeoZGWLKharX0qDrrDP8WjsB2br9FyFc0b2gdYPjeLR6zmhMStsF3TV/WLaHVNu3bZfhj5+O
	uog36/Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFU85-0000000CyQu-43ml;
	Fri, 07 Jun 2024 07:35:18 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFU7u-0000000CyO4-2KaO
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 07:35:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6558A1FB82;
	Fri,  7 Jun 2024 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717745704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=230HRa0bz54MsUMom7WNaqOl6oXXgPs2XLqZwWBQXJo=;
	b=Wo/QVKLrptrH6IeX3AZZItta8gsrkdl0YfW9PfbNTVN6BuUcTstP0PR5jifnnHrAdiagEz
	DKV1drJtyzrm5pfEYq34EeMBtRJGPeCf91B0HVob3F9RVV4sz0dep4argt1r5QVIp0wYrM
	SN+opUUWHZxto0YE2NXN3oF6I9tI6S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717745704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=230HRa0bz54MsUMom7WNaqOl6oXXgPs2XLqZwWBQXJo=;
	b=UdUWfeF1QHn0erU/113r13A3QEHvAfK/PuIl/RWLLAs8OlrB2yG5NDA+PyTDAKY1hhXwdD
	ra2zrCm7gA0w4fDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Wo/QVKLr";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UdUWfeF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717745704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=230HRa0bz54MsUMom7WNaqOl6oXXgPs2XLqZwWBQXJo=;
	b=Wo/QVKLrptrH6IeX3AZZItta8gsrkdl0YfW9PfbNTVN6BuUcTstP0PR5jifnnHrAdiagEz
	DKV1drJtyzrm5pfEYq34EeMBtRJGPeCf91B0HVob3F9RVV4sz0dep4argt1r5QVIp0wYrM
	SN+opUUWHZxto0YE2NXN3oF6I9tI6S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717745704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=230HRa0bz54MsUMom7WNaqOl6oXXgPs2XLqZwWBQXJo=;
	b=UdUWfeF1QHn0erU/113r13A3QEHvAfK/PuIl/RWLLAs8OlrB2yG5NDA+PyTDAKY1hhXwdD
	ra2zrCm7gA0w4fDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9973813A42;
	Fri,  7 Jun 2024 07:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U5ghIye4YmYbeQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Jun 2024 07:35:03 +0000
Message-ID: <1c4e6c61-fc39-4f59-a103-761984d98b18@suse.de>
Date: Fri, 7 Jun 2024 09:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] block: move integrity information into queue_limits
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
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
 <20240607055912.3586772-12-hch@lst.de>
 <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de>
In-Reply-To: <8cd46b95-bfdf-42a4-809f-36ff88062322@suse.de>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6558A1FB82
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_003506_781635_4645A6CB 
X-CRM114-Status: GOOD (  16.46  )
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

(Trimming reply for better readability)

On 6/7/24 08:29, Hannes Reinecke wrote:
> On 6/7/24 07:59, Christoph Hellwig wrote:
[ .. ]
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 996f247fc98e80..f11c8676eb4c67 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -6,7 +6,7 @@
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>>   #include <linux/bio.h>
>> -#include <linux/blkdev.h>
>> +#include <linux/blk-integrity.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/backing-dev-defs.h>
>>   #include <linux/gcd.h>
>> @@ -97,6 +97,36 @@ static int blk_validate_zoned_limits(struct 
>> queue_limits *lim)
>>       return 0;
>>   }
>> +static int blk_validate_integrity_limits(struct queue_limits *lim)
>> +{
>> +    struct blk_integrity *bi = &lim->integrity;
>> +
>> +    if (!bi->tuple_size) {
>> +        if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE ||
>> +            bi->tag_size || ((bi->flags & BLK_INTEGRITY_REF_TAG))) {
>> +            pr_warn("invalid PI settings.\n");
>> +            return -EINVAL;
>> +        }
>> +        return 0;
>> +    }
>> +
>> +    if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY)) {
>> +        pr_warn("integrity support disabled.\n");
>> +        return -EINVAL;
>> +    }
>> +
> Why is that an error?
> Surely 'validate' should not return an error if BLK_DEV_INTEGRITY is 
> disabled and no limits are set?
> 
>> +    if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE &&
>> +        (bi->flags & BLK_INTEGRITY_REF_TAG)) {
>> +        pr_warn("ref tag not support without checksum.\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!bi->interval_exp)
>> +        bi->interval_exp = ilog2(lim->logical_block_size);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Check that the limits in lim are valid, initialize defaults for 
>> unset
>>    * values, and cap values based on others where needed.
>> @@ -105,6 +135,7 @@ static int blk_validate_limits(struct queue_limits 
>> *lim)
>>   {
>>       unsigned int max_hw_sectors;
>>       unsigned int logical_block_sectors;
>> +    int err;
>>       /*
>>        * Unless otherwise specified, default to 512 byte logical 
>> blocks and a
>> @@ -230,6 +261,9 @@ static int blk_validate_limits(struct queue_limits 
>> *lim)
>>           lim->misaligned = 0;
>>       }
>> +    err = blk_validate_integrity_limits(lim);
>> +    if (err)
>> +        return err;
> Wouldn't we always fail to validate the limits if BLK_DEV_INTEGRITY is 
> disabled, given the check above?
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


