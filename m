Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D284ACE7AB0
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SvGjXTAVSGkRo+KSLyDpgwu/DRPS/FYIn0hOrNq+fvc=; b=pY0ef4MzNhqCxP9195cDaV82Hx
	Bsn9eTrbBFAa9s8Dt8/tNpmtAVgMmXylKV9lasnP85oRtbGHyzbcXG9H50bHe7Kjt6ULW0ruGPiYP
	aG2zLsjftL07fi7LX1ZH1dBc6YBznJVRWJM78uSRKGVGLGqiv4Cm9rbNfNwMPuG0F8dIZefOrzbxI
	M5JAFKykChdiWIjYravfxcBLF2ccaC9HU1/nQWQ07BH0ENfiJHv9CvPjgZSFPzOvekO3wVJtYjgRQ
	DNUI6Z4xwvtSM4ET9ZNYhmnvUZ8KQhuHPdCsO9n6hsVhOwMx3m3z72Iwu/MnXCPU+YECdP2UWdWRT
	wGF0zjOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYMx-00000000iJy-3VBQ;
	Mon, 09 Sep 2024 06:59:27 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYMs-00000000iIW-3Ta3
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 06:59:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 006C021AD5;
	Mon,  9 Sep 2024 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725865161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvGjXTAVSGkRo+KSLyDpgwu/DRPS/FYIn0hOrNq+fvc=;
	b=aRBV/qlCiJEgRxBAKLJiPy9eZRqzghyRIB+gP3Bgw/41Ynwz9L0uh8xsGe3VLjZtCBT2OW
	CF4gJl4wj8xVv5ICxeREqA9nmfaez+Hk46npTwZ4i2TDAHwU+xFFn/AusSckU0i2jW2Tey
	fBbck70NoQpt7kNZ7XuTnd8e8+NbjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725865161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvGjXTAVSGkRo+KSLyDpgwu/DRPS/FYIn0hOrNq+fvc=;
	b=6fHV+l5I2Bw2f8p+PDP7ftJWdYF7rNKEtgINsKgIqGoMUC5zyQEfcuxPCpOGQ/HU4bz1DV
	+jChG647R9IkeEDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725865161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvGjXTAVSGkRo+KSLyDpgwu/DRPS/FYIn0hOrNq+fvc=;
	b=aRBV/qlCiJEgRxBAKLJiPy9eZRqzghyRIB+gP3Bgw/41Ynwz9L0uh8xsGe3VLjZtCBT2OW
	CF4gJl4wj8xVv5ICxeREqA9nmfaez+Hk46npTwZ4i2TDAHwU+xFFn/AusSckU0i2jW2Tey
	fBbck70NoQpt7kNZ7XuTnd8e8+NbjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725865161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvGjXTAVSGkRo+KSLyDpgwu/DRPS/FYIn0hOrNq+fvc=;
	b=6fHV+l5I2Bw2f8p+PDP7ftJWdYF7rNKEtgINsKgIqGoMUC5zyQEfcuxPCpOGQ/HU4bz1DV
	+jChG647R9IkeEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5EA213A3A;
	Mon,  9 Sep 2024 06:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RBbSKsic3mafUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Sep 2024 06:59:20 +0000
Message-ID: <a521d514-311c-4a91-974c-6b0ee9e1d9cf@suse.de>
Date: Mon, 9 Sep 2024 08:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping
 namespaces
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906101640.44417-1-hare@kernel.org>
 <20240906101640.44417-4-hare@kernel.org>
 <1401aec0-059b-43fb-97b9-0b0896c2a56c@grimberg.me>
 <59313c6b-215a-4c76-be62-e74597988871@suse.de>
In-Reply-To: <59313c6b-215a-4c76-be62-e74597988871@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_235923_045611_35A208B6 
X-CRM114-Status: GOOD (  16.08  )
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

On 9/9/24 08:22, Hannes Reinecke wrote:
> On 9/8/24 09:21, Sagi Grimberg wrote:
>>
>>
>>
>> On 06/09/2024 13:16, Hannes Reinecke wrote:
>>> During repetitive namespace map and unmap operations on the target
>>> (disabling the namespace, changing the UUID, enabling it again)
>>> the initial scan will hang as the target will be returning
>>> PATH_ERROR and the I/O is constantly retried:
>>>
>>> [<0>] folio_wait_bit_common+0x12a/0x310
>>> [<0>] filemap_read_folio+0x97/0xd0
>>> [<0>] do_read_cache_folio+0x108/0x390
>>> [<0>] read_part_sector+0x31/0xa0
>>> [<0>] read_lba+0xc5/0x160
>>> [<0>] efi_partition+0xd9/0x8f0
>>> [<0>] bdev_disk_changed+0x23d/0x6d0
>>> [<0>] blkdev_get_whole+0x78/0xc0
>>> [<0>] bdev_open+0x2c6/0x3b0
>>> [<0>] bdev_file_open_by_dev+0xcb/0x120
>>> [<0>] disk_scan_partitions+0x5d/0x100
>>> [<0>] device_add_disk+0x402/0x420
>>> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>>> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>>> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>>> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>>> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>>>
>>> Calling 'nvme disconnect' on controllers with these namespaces
>>> will hang as the disconnect operation tries to flush scan_work:
>>>
>>> [<0>] __flush_work+0x389/0x4b0
>>> [<0>] nvme_remove_namespaces+0x4b/0x130 [nvme_core]
>>> [<0>] nvme_do_delete_ctrl+0x72/0x90 [nvme_core]
>>> [<0>] nvme_delete_ctrl_sync+0x2e/0x40 [nvme_core]
>>> [<0>] nvme_sysfs_delete+0x35/0x40 [nvme_core]
>>> [<0>] kernfs_fop_write_iter+0x13d/0x1b0
>>> [<0>] vfs_write+0x404/0x510
>>>
>>> before the namespaces are removed.
>>>
>>> This patch sets the 'failfast_expired' bit for the controller
>>> to cause all pending I/O to be failed, and the disconnect process
>>> to complete.
>>
>> I don't know if I agree with this approach. Seems too indirect.
>> Can you please explain (with tracing) what is preventing the scan_work
>> to complete? because the controller state should be DELETING, and perhaps
>> we are missing somewhere a check for this?
>>
>> nvme_remove_namespaces() at the point you are injecting here is designed
>> to allow any writeback to complete (if possible).
> 
> Looks like we're forgetting a 'nvme_kick_requeue_lists()' when setting 
> the state to DELETING. So requeue is never triggered, causing stuck I/O.
> I'll be checking.
> 
Turns out not to be sufficient.
Problem here is that nvmet will always return PATH_ERROR when the 
namespace is disabled. So that I/O will _continue_ to be retried,
as nvme_find_path() calls nvme_path_is_disabled(), which
_deliberately_ forwards I/O even if the controller is in DELETING:

  /*
   * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
   * still be able to complete assuming that the controller is connected.
   * Otherwise it will fail immediately and return to the requeue list.
   */

with no way out, and a stuck process. We can surely try to failover to
another path, but if this is the last path we're stuck forever.
Seems like we need a 'fail_if_no_path' mechanism here...

Hmm.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


