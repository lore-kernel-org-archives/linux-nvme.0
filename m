Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD1FECE582
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gM1jW9+Dp5JjpgrEhHBOr48NPx918Cjft3ERrsXHUT4=; b=ODqB6QI2OXasBopGCvUBkakMI2
	YP8hPvT79LEmmBgHUP51tQOLOijhckJDF+yQY5WMH8AN93gx9hLtDDHoiNPUWWjabZeEQGfJ2g1Pk
	bSoide4p5YbDpnVSqEw1f1G2VEoVHjf3wu/mmAiG4UVYqHGN7rUi2kKD6dodmZ49Uwxbza3LMF9Og
	IN9v2puo6gDpFLrYsx+UcNsoSpD38WbaQBp18PkDOQu6LRs22ykKSYI57G0noBVW7EY1fvcgyp3j8
	T4yjDanL5AEUGNb/jj6wYFTvaKw94ZtRR4AnCFn/J6zGjhzRvPPC7Hx/XtZL665Qhyo5wlnaWJ4/e
	ZRGD8P+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snwAU-00000004o24-42wE;
	Tue, 10 Sep 2024 08:24:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snw9T-00000004ntO-27f1
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 08:23:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19D7C1F455;
	Tue, 10 Sep 2024 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725956584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM1jW9+Dp5JjpgrEhHBOr48NPx918Cjft3ERrsXHUT4=;
	b=Zh3EqvrDLuTadq9U3NeLTj2ocuouqT69zfJrLHHEfrjWlXnItSx/aJLM9kQEQIrzjKPCxm
	gl6O63V4IWWhC2BETh/OSEaiBOxbflqHMlntlAKD6zXudbCjVqGpXMih9O3+dhyFhmK8yu
	pbo4pKtHz+vAdyejJaxh/+Xz42oIL+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725956584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM1jW9+Dp5JjpgrEhHBOr48NPx918Cjft3ERrsXHUT4=;
	b=rPIVcXGdWS93lt74YmY1KcBeJwjNvsGJZhovAH5/BosWNvoA7jfC5OBMhgEw+1rpkHY+mU
	oCNeqewKI4ZZg3CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725956584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM1jW9+Dp5JjpgrEhHBOr48NPx918Cjft3ERrsXHUT4=;
	b=Zh3EqvrDLuTadq9U3NeLTj2ocuouqT69zfJrLHHEfrjWlXnItSx/aJLM9kQEQIrzjKPCxm
	gl6O63V4IWWhC2BETh/OSEaiBOxbflqHMlntlAKD6zXudbCjVqGpXMih9O3+dhyFhmK8yu
	pbo4pKtHz+vAdyejJaxh/+Xz42oIL+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725956584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM1jW9+Dp5JjpgrEhHBOr48NPx918Cjft3ERrsXHUT4=;
	b=rPIVcXGdWS93lt74YmY1KcBeJwjNvsGJZhovAH5/BosWNvoA7jfC5OBMhgEw+1rpkHY+mU
	oCNeqewKI4ZZg3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCBF0132CB;
	Tue, 10 Sep 2024 08:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oHhmNecB4GblNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Sep 2024 08:23:03 +0000
Message-ID: <02b1dec3-3640-44ba-96ba-0550f5b50c96@suse.de>
Date: Tue, 10 Sep 2024 10:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping
 namespaces
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240909071930.146343-1-hare@kernel.org>
 <20240909071930.146343-4-hare@kernel.org>
 <58a80656-81d0-498d-a3e3-80ce9df6478c@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <58a80656-81d0-498d-a3e3-80ce9df6478c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_012307_726354_917952F6 
X-CRM114-Status: GOOD (  22.29  )
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

On 9/10/24 09:57, Sagi Grimberg wrote:
> 
> 
> 
> On 09/09/2024 10:19, Hannes Reinecke wrote:
>> During repetitive namespace map and unmap operations on the target
>> (disabling the namespace, changing the UUID, enabling it again)
>> the initial scan will hang as the target will be returning
>> PATH_ERROR and the I/O is constantly retried:
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
>> Calling 'nvme disconnect' on controllers with these namespaces
>> will hang as the disconnect operation tries to flush scan_work:
>>
>> [<0>] __flush_work+0x389/0x4b0
>> [<0>] nvme_remove_namespaces+0x4b/0x130 [nvme_core]
>> [<0>] nvme_do_delete_ctrl+0x72/0x90 [nvme_core]
>> [<0>] nvme_delete_ctrl_sync+0x2e/0x40 [nvme_core]
>> [<0>] nvme_sysfs_delete+0x35/0x40 [nvme_core]
>> [<0>] kernfs_fop_write_iter+0x13d/0x1b0
>> [<0>] vfs_write+0x404/0x510
>>
>> before the namespaces are removed, and the controller state
>> DELETING_NOIO (which would abort any pending I/O) is set only
>> afterwards.
>>
>> This patch calls 'nvme_kick_requeue_lists()' when entering
>> DELETING state for a controller to ensure all pending I/O
>> is flushed, and also disables failover for any commands which
>> are completed with an error afterwards, breaking the infinite
>> retry loop.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/core.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 651073280f6f..142babce1963 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -381,6 +381,8 @@ enum nvme_disposition {
>>   static inline enum nvme_disposition nvme_decide_disposition(struct 
>> request *req)
>>   {
>> +    struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>> +
>>       if (likely(nvme_req(req)->status == 0))
>>           return COMPLETE;
>> @@ -393,6 +395,8 @@ static inline enum nvme_disposition 
>> nvme_decide_disposition(struct request *req)
>>           return AUTHENTICATE;
>>       if (req->cmd_flags & REQ_NVME_MPATH) {
>> +        if (nvme_ctrl_state(ctrl) == NVME_CTRL_DELETING)
>> +            return COMPLETE;
> 
> This looks wrong. What if I disconnect from one path and there are other
> eligible paths?

Yes, correct. We should check if there are paths left, and failover
if we still have paths, but complete the requests if this is the last 
path and we had a path error:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 651073280f6f..73b21c01b165 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -394,8 +394,17 @@ static inline enum nvme_disposition 
nvme_decide_disposition(struct request *req)

         if (req->cmd_flags & REQ_NVME_MPATH) {
                 if (nvme_is_path_error(nvme_req(req)->status) ||
-                   blk_queue_dying(req->q))
+                   blk_queue_dying(req->q)) {
+                       struct nvme_ns *ns = req->q->queuedata;
+                       /*
+                        * Always complete if this is the last path
+                        * and the controller is deleted.
+                        */
+                       if (list_is_singular(&ns->head->list) &&
+                           nvme_ctrl_state(ns->ctrl) == NVME_CTRL_DELETING)
+                               return COMPLETE;
                         return FAILOVER;
+               }
         } else {
                 if (blk_queue_dying(req->q))
                         return COMPLETE;

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


