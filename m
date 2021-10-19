Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD59C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:41:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CB561154
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2CB561154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29VnCoJTBwQZm2cdeyvOw9rk6S6a9TlWG/GIR0BMUrs=; b=o6Gmvs6mOLNT9r/jI93+bzvuGV
	IUGhWa2rSyO9fDpIZuzX4sNVWV/xdFoH4BE3Z94/G+fyFJgLLz0m06YCXrtiaH2Q3uIp0hIqYtd/j
	9143vr5h3u9JRjzlb2jKfITBPKxtCnsrPF1/AzFy9rPyvYfuUIweZzUJNleFmB3meaU19e5GWDONG
	Dsboq+jgiTVdBrerlx34pNbki5SDpeSX1Fjd/S3zOpz/huU6Bp+b4wWUm6s09Gl2phnSG0A0YIbZ3
	1iXr9SfGZH2G5AhMAem/4PkGbqh+xSj0lfvuKBrUMdvP+jlegzhEKzlL3KAhXsmRFRIic+PxWATR1
	5HJqcVpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcrEt-001jlm-ML; Tue, 19 Oct 2021 15:41:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcrEq-001jkX-EP
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 15:41:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68F0F1FD33;
 Tue, 19 Oct 2021 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634658073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29VnCoJTBwQZm2cdeyvOw9rk6S6a9TlWG/GIR0BMUrs=;
 b=H59nynwHVehLxMub2Z0kR5M1K0buO9zhZBgP4qVV5GJl4ZglD68HOAHqYySVUAFzozfie+
 1/vBAF1AeNWv7B7Myutw0XFxQUUzURlaKAD0sJckS0K4TNhOvg9uq1ZbuF08T82/SzOPPS
 nvFD2p2WaheCCRo5Z//1eipC8mbI1m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634658073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29VnCoJTBwQZm2cdeyvOw9rk6S6a9TlWG/GIR0BMUrs=;
 b=tLQoI5M8qCs9O7Ncbr01y0IvplX4cSApg6180ZkKVXf7zQtQhMgXj/mmV2v4eN7lV6Ch+k
 n64GoSjaCFxgzGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B25D13CFC;
 Tue, 19 Oct 2021 15:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mMiuDRnnbmGtdwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 15:41:13 +0000
Subject: Re: Deadlock on failure to read NVMe namespace
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
 <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
 <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
 <8ff377bd-4d04-9fc7-66af-a48c7cdd7399@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0ea3d998-5f8c-347f-c64e-86575135a6f2@suse.de>
Date: Tue, 19 Oct 2021 17:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8ff377bd-4d04-9fc7-66af-a48c7cdd7399@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_084116_673133_C9A010D7 
X-CRM114-Status: GOOD (  20.81  )
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

On 10/19/21 5:06 PM, Sagi Grimberg wrote:
> 
> 
> On 10/19/21 5:27 PM, Sagi Grimberg wrote:
>>
>>>>> 481:~ # cat /proc/15761/stack
>>>>> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
>>>>> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
>>>>> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
>>>>> [<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
>>>>> [<0>] kernfs_fop_write_iter+0x12f/0x1a0
>>>>> [<0>] new_sync_write+0x122/0x1b0
>>>>> [<0>] vfs_write+0x1eb/0x250
>>>>> [<0>] ksys_write+0xa1/0xe0
>>>>> [<0>] do_syscall_64+0x3a/0x80
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> c481:~ # cat /proc/14965/stack
>>>>> [<0>] do_read_cache_page+0x49b/0x790
>>>>> [<0>] read_part_sector+0x39/0xe0
>>>>> [<0>] read_lba+0xf9/0x1d0
>>>>> [<0>] efi_partition+0xf1/0x7f0
>>>>> [<0>] bdev_disk_changed+0x1ee/0x550
>>>>> [<0>] blkdev_get_whole+0x81/0x90
>>>>> [<0>] blkdev_get_by_dev+0x128/0x2e0
>>>>> [<0>] device_add_disk+0x377/0x3c0
>>>>> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>>>>> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>>>>> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
>>>>> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>>>>> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
>>>>> [<0>] process_one_work+0x231/0x420
>>>>> [<0>] worker_thread+0x2d/0x3f0
>>>>> [<0>] kthread+0x11a/0x140
>>>>> [<0>] ret_from_fork+0x22/0x30
> 
> ...
> 
>> I think this sequence is familiar and was addressed by a fix from Anton
>> (CC'd) which still has some pending review comments.
>>
>> Can you lookup and try:
>> [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
> 
> Actually, I see the trace is going from nvme_alloc_ns, no the ANA
> update path, so that is unlikely to address the issue.
> 
> Looking at nvme_mpath_clear_ctrl_paths, I don't think it should
> take the scan_lock anymore. IIRC the reason why it needed the
> scan_lock in the first place was the fact that ctrl->namespaces
> was added and then sorted in scan_work (taking the namespaces_rwsem
> twice).
> 
> But now that ctrl->namespaces is always sorted, and accessed with
> namespaces_rwsem, I think that scan_lock is no longer needed
> here and namespaces_rwsem is sufficient.
> 
... which was precisely what my initial patch did.
While it worked in the sense the 'nvme disconnect' completed, we did not 
terminate the outstanding I/O as no current path is set and hence this:

	down_read(&ctrl->namespaces_rwsem);
	list_for_each_entry(ns, &ctrl->namespaces, list)
		if (nvme_mpath_clear_current_path(ns))
			kblockd_schedule_work(&ns->head->requeue_work);
	up_read(&ctrl->namespaces_rwsem);

doesn't do anything, in particular does _not_ flush the requeue work.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

