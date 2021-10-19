Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1341C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 11:22:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868C761212
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 11:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 868C761212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cKC7DTCmYqPLyaE1CHH5uYAnsL7VY3wqJfG6lmM5nRE=; b=jNvdlMrkJWNSXsElHgoEVrLMMn
	zHIrQKAIijL+U6SB6r5089uYAHvSj/AMJmaXyW9oL+sdZYkoolSKD9fqrf9SxrPekEHe4w3xzbFY4
	5qKgTMomp4jCr3m76Yp/3SeB4riDyUqvRyfFABUpGQUOnmHJyn26cPS3dkAuhUVYwByrvPusFwQdS
	NPyyd8cWisp4a4LqX/vvJ13Jz+O/8BXwiAEQZXJ04jnjqXiCTTWf6HeZdQ8GpB3k7o3AFvyzpDtlj
	P3cTBcF7Z8e7OnNnUDAWkHiEOatMIgvoriMBHluqMktkmP7OTojsHjTdFqJHdrskBspr+r/7Ewgbg
	86+wdRoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcnCo-000xJX-EL; Tue, 19 Oct 2021 11:22:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcnCk-000xJ3-A2
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 11:22:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4EC5B1FCB4;
 Tue, 19 Oct 2021 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634642568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cKC7DTCmYqPLyaE1CHH5uYAnsL7VY3wqJfG6lmM5nRE=;
 b=ORYbw2GXqmA9uaIQVwrEA2ihl4WHNsA2uQCe0sIj/uzEf0ocQL6T9gIzZnIw92x7xVTWjt
 sB+FfXl7d+RgSwvRidTxN8NIDr2QwNb1/lOkh8WtuDzTriF/96w0Of95g1Dd3qiJ8Q4wmr
 Sc7ZKtoW9ScUQmng1IZGrTuAdyBU00A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634642568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cKC7DTCmYqPLyaE1CHH5uYAnsL7VY3wqJfG6lmM5nRE=;
 b=lNS8UjJUH8rhGT0/xAe+H6c10WTFRI4yLiDUBCQ77QPw4vF80DJAZkVXM0CH0qdgrqNNaF
 2h7v8hbfGtJ7dgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 283A313E6B;
 Tue, 19 Oct 2021 11:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K+L8CIiqbmFobQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 11:22:48 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Deadlock on failure to read NVMe namespace
Message-ID: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
Date: Tue, 19 Oct 2021 13:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_042250_523589_2589BF0B 
X-CRM114-Status: GOOD (  12.46  )
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

Hi all,

during testing my test target (https://github.com/hreinecke/nofuse) I've 
managed to run into a deadlock (with nvme-5.16):

c481:~ # dmesg
[102885.483587] nvme nvme0: sqsize 128 > ctrl maxcmd 32, clamping down
[102885.483711] nvme nvme0: creating 2 I/O queues.
[102885.484130] nvme nvme0: mapped 2/0/0 default/read/poll queues.
[102885.485527] nvme nvme0: new ctrl: NQN 
"nqn.2014-08.org.nvmexpress:uuid:62f37f51-0cc7-46d5-9865-4de22e81bd9d", 
addr 127.0.0.1:8009
[102885.487351] nvme nvme0: request 0x0 genctr mismatch (got 0x0 
expected 0x1)
[102885.487354] nvme nvme0: got bad c2hdata.command_id 0x0 on queue 2
[102885.487356] nvme nvme0: receive failed:  -2
[102885.487357] nvme nvme0: starting error recovery
[102885.487444] block nvme0n1: no usable path - requeuing I/O
[102885.502051] nvme nvme0: Reconnecting in 10 seconds...
[102893.291877] nvme nvme0: Removing ctrl: NQN 
"nqn.2014-08.org.nvmexpress:uuid:62f37f51-0cc7-46d5-9865-4de22e81bd9d"
[102895.535149] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
[102895.535214] nvme nvme0: creating 2 I/O queues.
[102895.535943] nvme nvme0: mapped 2/0/0 default/read/poll queues.
[102895.536187] nvme nvme0: Failed reconnect attempt 1
[103700.406060] INFO: task kworker/u4:0:14965 blocked for more than 491 
seconds.
[103700.406068]       Tainted: G            E     5.15.0-rc3-54-default+ 
#862
[103700.406071] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[103700.406073] task:kworker/u4:0    state:D stack:    0 pid:14965 ppid: 
     2 flags:0x00004000
[103700.406117] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[103700.406143] Call Trace:
[103700.406146]  __schedule+0x302/0x13a0
[103700.406157]  ? block_read_full_page+0x21e/0x3b0
[103700.406164]  ? blkdev_direct_IO+0x4a0/0x4a0
[103700.406172]  schedule+0x3a/0xa0
[103700.406177]  io_schedule+0x12/0x40
[103700.406182]  do_read_cache_page+0x49b/0x790

481:~ # cat /proc/15761/stack
[<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
[<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
[<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
[<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
[<0>] kernfs_fop_write_iter+0x12f/0x1a0
[<0>] new_sync_write+0x122/0x1b0
[<0>] vfs_write+0x1eb/0x250
[<0>] ksys_write+0xa1/0xe0
[<0>] do_syscall_64+0x3a/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
c481:~ # cat /proc/14965/stack
[<0>] do_read_cache_page+0x49b/0x790
[<0>] read_part_sector+0x39/0xe0
[<0>] read_lba+0xf9/0x1d0
[<0>] efi_partition+0xf1/0x7f0
[<0>] bdev_disk_changed+0x1ee/0x550
[<0>] blkdev_get_whole+0x81/0x90
[<0>] blkdev_get_by_dev+0x128/0x2e0
[<0>] device_add_disk+0x377/0x3c0
[<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
[<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
[<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
[<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
[<0>] nvme_scan_work+0x168/0x310 [nvme_core]
[<0>] process_one_work+0x231/0x420
[<0>] worker_thread+0x2d/0x3f0
[<0>] kthread+0x11a/0x140
[<0>] ret_from_fork+0x22/0x30

My theory here is that the partition scanning code just calls into the 
pagecache, which doesn't set a timeout for any I/O operation.
As this is done under the scan_mutex we cannot clear the active paths, 
and consequently we hang.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

