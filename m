Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E81CD4853
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bMj0gNvxYOOyxwwWxnhWUuUlPUM2Llw/rEms6VqqE5I=; b=EtHNVi+VKnMtLaddNmYQq7k7Hp
	BzqZvoFMRJZcY7gEoxTatDk2ce6DjK6HO3J4iSlynpzuH2wTltF/b34mRBXWCP4lDGjAmhw+rpbsX
	PCVmgZxG9aPlg7DryMT84vh1nxEAbiAC6cvlFZlh8wgyio8dTFgyrajomGqCLFz0g+iA5vztiVZxz
	s9F4Ud18TaNsQ29GqwQZA3du9S1UBjA0avVs0DyTDE2mONfbrorLLAlM7GJWfMEahQQIjXZAGmpPT
	yEQWqsE/EUmaTdy1T7l3VCASOUuFtVlyNzaQCFW7hLJYCqFcduyoopfzbbRBp5YAo2jkXm/Kt4ypg
	fAySR7NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slsSQ-000000059T1-0bZb;
	Wed, 04 Sep 2024 16:02:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slsMa-000000057nU-0fUx
	for linux-nvme@bombadil.infradead.org;
	Wed, 04 Sep 2024 15:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bMj0gNvxYOOyxwwWxnhWUuUlPUM2Llw/rEms6VqqE5I=; b=qSHNTsjo+C0Ws7r9vbY8hAb9PK
	v6jFp2yGGsaqsZg3XD9MxMvL7FW4oqJYpfRjd17ROm3GkWr5/wD9UbSYAaphMInbsXr11RfCJ0vly
	Yg4WFkr75E1sh9FJAX/Nz4Lx8HJKkzvkEJw0AlVB4CqBRFgzL/vul8PrnwqXLvjle0CasWBQ2IzJg
	pHtU/aR42OJOKnQR0JPolZLHND7nm5b1TRhFRtVzt8+r935V9TbwC4iXHDlb5JTzTSnJZM1BbgidV
	8lzY018mCuYH0EqClPy42/N5c5Q+zBO7KiKAFF76GCdwUm45NbdrRDvx1RQTVXeG1yz+akqheh8OW
	d64F682g==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1slsMV-00000000ITn-0l8M
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:56:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF76C1F7D0;
	Wed,  4 Sep 2024 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725465359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMj0gNvxYOOyxwwWxnhWUuUlPUM2Llw/rEms6VqqE5I=;
	b=lNg1iLBy+zrcYA0pP0xIH3zIpQNv++eDF+yjzte0S1Q7HdBu7YUgIDfamHTdTdHFdjGaBL
	mIp7MSvXli+MtiibKrNRcKvMUN4shZ6cYEatH6+Wiqr9V20auDWbLxOTO034IeVJsEqDAf
	S8J4wrCJGbtZ4VueXw1kk8KyKMuYsE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725465359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMj0gNvxYOOyxwwWxnhWUuUlPUM2Llw/rEms6VqqE5I=;
	b=EXynezXAKU/5kMuMtSTyFzyKMhKWU5165alDAuOq+RJTDBwVjVpxqSusyrWyHI3AorFeb5
	imxQyOkkJSFV/kCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725465359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMj0gNvxYOOyxwwWxnhWUuUlPUM2Llw/rEms6VqqE5I=;
	b=lNg1iLBy+zrcYA0pP0xIH3zIpQNv++eDF+yjzte0S1Q7HdBu7YUgIDfamHTdTdHFdjGaBL
	mIp7MSvXli+MtiibKrNRcKvMUN4shZ6cYEatH6+Wiqr9V20auDWbLxOTO034IeVJsEqDAf
	S8J4wrCJGbtZ4VueXw1kk8KyKMuYsE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725465359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMj0gNvxYOOyxwwWxnhWUuUlPUM2Llw/rEms6VqqE5I=;
	b=EXynezXAKU/5kMuMtSTyFzyKMhKWU5165alDAuOq+RJTDBwVjVpxqSusyrWyHI3AorFeb5
	imxQyOkkJSFV/kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5A79139E2;
	Wed,  4 Sep 2024 15:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KQtVMw6D2GbmEgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Sep 2024 15:55:58 +0000
Message-ID: <edefb61b-8d4d-40e1-9d07-d8ba1c8bed07@suse.de>
Date: Wed, 4 Sep 2024 17:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
 <d3762e8e-dcae-46fd-b222-92b552d3449f@linux.ibm.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d3762e8e-dcae-46fd-b222-92b552d3449f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_165603_293013_5BC42440 
X-CRM114-Status: GOOD (  20.89  )
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

On 9/4/24 16:52, Nilay Shroff wrote:
> 
> 
> On 9/3/24 23:33, Hannes Reinecke wrote:
>> During repetitive namespace remapping operations (ie removing a namespace and
>> provision a different namespace with the same NSID) on the target the
>> namespace might have changed between the time the initial scan
>> was performed, and partition scan was invoked by device_add_disk()
>> in nvme_mpath_set_live(). We then end up with a stuck scanning process:
>>
>> [<0>] folio_wait_bit_common+0x12a/0x310
>> [<0>] filemap_read_folio+0x97/0xd0
>> [<0>] do_read_cache_folio+0x108/0x390
>> [<0>] read_part_sector+0x31/0xa0
>> [<0>] read_lba+0xc5/0x160
>> [<0>] efi_partition+0xd9/0x8f0
>> [<0>] bdev_disk_changed+0x23d/0x6d0
>> [<0>] blkdev_get_whole+0x78/0xc0
>> [<0>] bdev_open+0x2c6/0x3b0
>> [<0>] bdev_file_open_by_dev+0xcb/0x120
>> [<0>] disk_scan_partitions+0x5d/0x100
>> [<0>] device_add_disk+0x402/0x420
>> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>>
>> This happens when we have several paths, some of which are inaccessible,
>> and the active paths are removed first. Then nvme_find_path() will requeue
>> I/O in the ns_head (as paths are present), but the requeue list is never
>> triggered as all remaining paths are inactive.
>> This patch checks for NVME_NSHEAD_DISK_LIVE when selecting a path,
>> and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
>> the last path has been removed to properly terminate pending I/O.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/multipath.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index c9d23b1b8efc..1b1deb0450ab 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>>   
>>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>>   {
>> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>> +		return NULL;
>> +
>>   	switch (READ_ONCE(head->subsys->iopolicy)) {
>>   	case NVME_IOPOLICY_QD:
>>   		return nvme_queue_depth_path(head);
>> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>>   {
>>   	struct nvme_ns *ns;
>>   
>> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>> +		return NULL;
>> +
>>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>   		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>>   			continue;
>> @@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>>   {
>>   	if (!head->disk)
>>   		return;
>> -	kblockd_schedule_work(&head->requeue_work);
>> -	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>>   		nvme_cdev_del(&head->cdev, &head->cdev_device);
>>   		del_gendisk(head->disk);
>>   	}
>> +	/*
>> +	 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
>> +	 * to allow multipath to fail all I/O.
>> +	 */
>> +	kblockd_schedule_work(&head->requeue_work);
>>   }
> Not sure, in your case, whether nvme_mpath_remove_disk() is called or not?
> The nvme_mpath_remove_disk() shall trigger the ns_head reqiest list.
> 
It would, but we're never get this far as the reference to ns_head it 
held by the above stack trace (and nvme_mpath_remove_disk()) is called
when the last reference to ns_head drops.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


