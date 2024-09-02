Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF07CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cjPOrZ8WklVCJaNE9CJsPSjkwywkjZ+BvYSOPoiBrZE=; b=VOM7pp3JS8Ra0HFOYFeoNqqV4s
	LRH/brKrxI+4P2yy3TAC+aNnIhmJIq/+qg61PWLJ/UaF/A3LO5K2RKDJdCZJ9aqWnqEEx5rKRh7tE
	ump9r9pv8dLiHsBPD1UQDN/Rg1bnK1zVrWa4fPGf6ClboPeVIfSsTwD9wi5C5C6Ld6dbfnI3ZCWHY
	PnTACWc8L64T3hdL/AOtLn8Oa8kD2kSMKUHS7orPZf/L9HXnifMl/7M/XZD1+vyeTNdBxSphDPadQ
	kob5KNkbLZVF5JjYrkp1GeSxDi5IMl+97D1Gf2lmqfNMWkX/AtmVuZes71Nm9hnBS/XP13gEwrg8M
	WX05DdxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl4QV-0000000DwME-1IXt;
	Mon, 02 Sep 2024 10:36:51 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl4QQ-0000000DwKU-0WgV
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 10:36:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3743F21A1C;
	Mon,  2 Sep 2024 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725273404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjPOrZ8WklVCJaNE9CJsPSjkwywkjZ+BvYSOPoiBrZE=;
	b=z6ieuHEwCdE+BdEULWsWQDLCf8kF/Vxn09K0FgBvT6py65TKmCFXV15GnZujJdBvT6nPfo
	goBJpsy61rcQcu7wDD4zWAckt96GwhvVGEVaBhbMXl41UKxGyTkYZAdjE2mvoBjRmrQHhW
	XHLPECzwf/DH0mJeAYR8+/ocTNMt1us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725273404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjPOrZ8WklVCJaNE9CJsPSjkwywkjZ+BvYSOPoiBrZE=;
	b=CNR3rGt+Pknf6mjfFj19JeJa4Y5a2iFmm9VbNwRGlP6GOHv+MJ1jQgYugy4rzkw5YJoYIs
	mSCU4we3t4t2PMAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725273403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjPOrZ8WklVCJaNE9CJsPSjkwywkjZ+BvYSOPoiBrZE=;
	b=OGhWIolHTA5daB3IzMeaaJLUjA2/lKfaAn3+p4eAumud9WGmN5eWCL84XiMMj63niDgPRh
	s61E+WLvcPSc8xz0R+YNTbFcWWeCX/LlyeJ02AzozJEgoJTDvfhciruQD7dax3GHePT66A
	H+4TfZmjZqw14CN0iMG04FmYkx6dkwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725273403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjPOrZ8WklVCJaNE9CJsPSjkwywkjZ+BvYSOPoiBrZE=;
	b=fXlNlkj5I5Tc250K+AyYH3qr06LS0/+5+IGvqNB0LukqbW8SUcIY8hiP8M+D7PKFb9doEI
	0+s33f3gXA5gaoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F2F13AE0;
	Mon,  2 Sep 2024 10:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7oXLBTuV1WZfagAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 10:36:43 +0000
Message-ID: <084602a4-2625-4d9b-b67f-d1bcd175d59f@suse.de>
Date: Mon, 2 Sep 2024 12:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: freeze both the ns and multipath queues whe
 updating queue limits
From: Hannes Reinecke <hare@suse.de>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
References: <20240829063142.2048109-1-hch@lst.de>
 <20240829063142.2048109-4-hch@lst.de>
 <69bb27d4-1ea6-4554-9a1d-e19e4e9079c1@suse.de>
Content-Language: en-US
Cc: Martin Wilck <mwilck@suse.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
In-Reply-To: <69bb27d4-1ea6-4554-9a1d-e19e4e9079c1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_033646_339163_5DA67922 
X-CRM114-Status: GOOD (  21.39  )
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

On 8/29/24 16:34, Hannes Reinecke wrote:
> On 8/29/24 08:31, Christoph Hellwig wrote:
>> We really should not have any I/O outstanding while updating the queue
>> limits, as that could introduce inconsistencies between the multipath
>> and underlying nodes.  So always freeze the multipath node first and then
>> the underlying one, matching the order in nvme_passthru_start.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++------------
>>   1 file changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 81d2a09dd00f30..0f01a0bf976fd3 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
[  .. ]
>> @@ -2254,7 +2272,9 @@ static int nvme_update_ns_info_block(struct 
>> nvme_ns *ns,
>>   done:
>>       set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
>>       set_bit(NVME_NS_READY, &ns->flags);
>> -    blk_mq_unfreeze_queue(ns->disk->queue);
>> +    if (nvme_ns_head_multipath(ns->head))
>> +        ret = nvme_update_ns_info_mpath(ns, info, unsupported);
>> +    nvme_ns_unfreeze(ns);
>>       if (blk_queue_is_zoned(ns->queue)) {
>>           ret = blk_revalidate_disk_zones(ns->disk);
> 
> While we're shuffling things around; doesn't the mean that we unfreeze 
> the queue (and allow I/O) before we've validated all zones?
> Wouldn't it be better if we validate zoned before unfreezing queues?
> 
> Otherwise it looks good; I'll give it a spin on my map/unmap testcases.
> 
Hmm. Turns out we're not quite there yet.
We call 'set_capacity_and_notify()' unconditionally a few lines up, 
before setting the namespace to 'READY'. And then we're doing another
call to 'set_capacity_and_notify()' (from nvme_update_ns_info_mpath()).
In my map/unmap tests I've seen a stall with udev, where the initial
scanning process it stuck in device_add_disk() trying to read the 
partition table (and waiting for the uptodate bit to clear), and the 
udev process closing the bdev and waiting on 'truncate_filemap_range').

With this patch:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fdd67a55a477..8858e5bf49de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2258,8 +2258,6 @@ static int nvme_update_ns_info_block(struct 
nvme_ns *ns,
                 goto out;
         }

-       set_capacity_and_notify(ns->disk, capacity);
-
         /*
          * Only set the DEAC bit if the device guarantees that reads from
          * deallocated data return zeroes.  While the DEAC bit does not
@@ -2274,6 +2272,8 @@ static int nvme_update_ns_info_block(struct 
nvme_ns *ns,
         set_bit(NVME_NS_READY, &ns->flags);
         if (nvme_ns_head_multipath(ns->head))
                 ret = nvme_update_ns_info_mpath(ns, info, unsupported);
+       else
+               set_capacity_and_notify(ns->disk, capacity);
         nvme_ns_unfreeze(ns);

         if (blk_queue_is_zoned(ns->queue)) {

on top of your patchset I no longer see the problem.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


