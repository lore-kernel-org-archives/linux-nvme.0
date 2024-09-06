Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3068CE7AFE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6PBQx8o9D8RAS3+llF+1frsir3b/wjXYmx237iNjvLE=; b=GBWfJlRTT9EoppifoV4me9wTkj
	1Ux19SlGI4nvAja0gXQydosNuRuoCQNqgs4yixwMd675BtXlouI/huczLPq1TY5WiSuXNVIGIZlNV
	A84yxwcPe/ITmF3VqyzyrjrKUxhEwKqk8oBnOYJmGnG81QrWv7EEH5G3psXv6vEqdxph6VLd9xEzu
	c41nAoreZDU72kp79ffHKJy5GiMJLZtS7GV52HslUJEssmVqWIyTSGwbAXhHHR+PftFibKnzf13+N
	zyXnjZ3p0nawSPPmeOibzWaWc3RqkJDly8nJ8aioWiWGLrDB2ToBc5ygDW4adRSr+kjLMd7kr4p2m
	Fh15pszw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWQh-0000000Bp2e-3laK;
	Fri, 06 Sep 2024 10:43:03 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWQa-0000000Bozn-2qog
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 10:43:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D5571F8B0;
	Fri,  6 Sep 2024 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725619371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBQx8o9D8RAS3+llF+1frsir3b/wjXYmx237iNjvLE=;
	b=cWhBtVNFagunngZiw8QuTKDY8+/9QrkLqrivffDTKIMeojnvfnyvChu5sTh1m+LUd6N6/L
	6swEooNQfPMH60T+Kukg3784e5wY59hHdUrNbJQWWJZIFPA1pryxAxcVF99NTPjLtqY/uS
	BWt6hBy6G8IC144gRPLVCmOn5XsGPcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725619371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBQx8o9D8RAS3+llF+1frsir3b/wjXYmx237iNjvLE=;
	b=ATOsn/RJIFNN3/mRf8b4i+qgVTc3UwQ5y5WtHYAqGhXlatCATmX2aE9SzCk9rx3pREyp88
	P3Tb/Z4p5XkhJ+CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725619371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBQx8o9D8RAS3+llF+1frsir3b/wjXYmx237iNjvLE=;
	b=cWhBtVNFagunngZiw8QuTKDY8+/9QrkLqrivffDTKIMeojnvfnyvChu5sTh1m+LUd6N6/L
	6swEooNQfPMH60T+Kukg3784e5wY59hHdUrNbJQWWJZIFPA1pryxAxcVF99NTPjLtqY/uS
	BWt6hBy6G8IC144gRPLVCmOn5XsGPcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725619371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBQx8o9D8RAS3+llF+1frsir3b/wjXYmx237iNjvLE=;
	b=ATOsn/RJIFNN3/mRf8b4i+qgVTc3UwQ5y5WtHYAqGhXlatCATmX2aE9SzCk9rx3pREyp88
	P3Tb/Z4p5XkhJ+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33955136A8;
	Fri,  6 Sep 2024 10:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TXn2C6vc2mYScAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Sep 2024 10:42:51 +0000
Message-ID: <3b19c91b-b9dc-4495-bd48-c5f045ad9995@suse.de>
Date: Fri, 6 Sep 2024 12:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping
 namespaces
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240906101640.44417-1-hare@kernel.org>
 <20240906101640.44417-4-hare@kernel.org>
 <b7eb6419-9c88-4e79-9c07-1db20a4bbb32@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b7eb6419-9c88-4e79-9c07-1db20a4bbb32@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_034257_944276_17279C9D 
X-CRM114-Status: GOOD (  13.60  )
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

On 9/6/24 12:35, Damien Le Moal wrote:
> On 9/6/24 19:16, Hannes Reinecke wrote:
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
>> before the namespaces are removed.
>>
>> This patch sets the 'failfast_expired' bit for the controller
>> to cause all pending I/O to be failed, and the disconnect process
>> to complete.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 651073280f6f..b968b672dcf8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4222,6 +4222,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	 */
>>   	nvme_mpath_clear_ctrl_paths(ctrl);
>>   
>> +	/*
>> +	 * Mark the controller as 'failfast' to ensure all pending I/O
>> +	 * is killed.
> 
> s/is/are ?
> 
Depending whether you consider I/O as a stream or individual commands.
'.. ensure all pending commands are killed.' ?

Cheers,

Hannes

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


