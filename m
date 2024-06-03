Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13503C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KnSGZaDAycV2tvORy07sVNfaZHBK8GcSrvy4W6YUd7E=; b=nM96dH9y6ec60rn/U9NuYP4s19
	mBPZUOVyH2RUoYTU/EJg618tUKbpg+WHlMML6oHBkpnmBdWvXRgcIpSpaWrSvs8sHB/o1rMcqleAv
	f1rGavJHEVRVGIhvQNkDrsZaZDvTUAQnf+LKZDS5g/OldtUX7uzhQ/95M3zldn10LnxhTsPcFqPiO
	uPychFn/7yto7uy3F31NlEk1TYhKNo3JcVbZqNeS19nxvE7bPJZcckyy6AngcWRq2BlHqbBYZJVVD
	9rlLCLRFRUPp6DCE1NKBrNEG2yk6xb9f9smwUuVHyQY+AboCxpGp9NpA2Ha2oafTAp8hT61Ly4h7S
	5JraQP4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1gm-0000000FpzW-35DL;
	Mon, 03 Jun 2024 07:01:04 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1gi-0000000Fpxw-1oPR
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 07:01:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5727B2001C;
	Mon,  3 Jun 2024 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717398058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnSGZaDAycV2tvORy07sVNfaZHBK8GcSrvy4W6YUd7E=;
	b=o22TxMymO3sPEHp474ptV+TbaxUz2f1u4ShjGKrTsvUU+FLEev4ijea9w2+sMY3OMKIbMc
	KqXbnCUX5onEjXy3FW/BQKwPPf/ietHbxYCGw9G8JynRWHQi2pf57oT88znC/3fatfis0q
	S1BEvo7bZzuxeuM/LACTOQNZ2Y0Wiss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717398058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnSGZaDAycV2tvORy07sVNfaZHBK8GcSrvy4W6YUd7E=;
	b=jta+fgGu58ZXTUy50WV8qUaz9Zikh6hSnUFS87lTsl1xfOUwwT3le8wrHlkCJ+KwBdQTWq
	IgH0Pa3jvkeBP7BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717398058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnSGZaDAycV2tvORy07sVNfaZHBK8GcSrvy4W6YUd7E=;
	b=o22TxMymO3sPEHp474ptV+TbaxUz2f1u4ShjGKrTsvUU+FLEev4ijea9w2+sMY3OMKIbMc
	KqXbnCUX5onEjXy3FW/BQKwPPf/ietHbxYCGw9G8JynRWHQi2pf57oT88znC/3fatfis0q
	S1BEvo7bZzuxeuM/LACTOQNZ2Y0Wiss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717398058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnSGZaDAycV2tvORy07sVNfaZHBK8GcSrvy4W6YUd7E=;
	b=jta+fgGu58ZXTUy50WV8qUaz9Zikh6hSnUFS87lTsl1xfOUwwT3le8wrHlkCJ+KwBdQTWq
	IgH0Pa3jvkeBP7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1375E13A93;
	Mon,  3 Jun 2024 07:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ffHjAipqXWaaUQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 07:00:58 +0000
Message-ID: <38e1e677-9fc2-411f-a198-dc717d304428@suse.de>
Date: Mon, 3 Jun 2024 09:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nvme: fix a possible memory leak when failing to
 initialize ctrl auth
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Maurizio Lombardi <mlombard@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240530072233.899680-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240530072233.899680-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_000100_878157_63E5FAE8 
X-CRM114-Status: GOOD (  16.71  )
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

On 5/30/24 09:22, Sagi Grimberg wrote:
> In case nvme_auth_init_ctrl fails, we leak memory [1] due to not dropping
> the device reference to zero, causing a device private allocation to leak.
> 
> Dropping the reference to zero to trigger device .release() is a bit
> problematic here because the callers of nvme_init_ctrl() cannot sanely
> understand if it failed before or after a device was added, hence don't
> know if they need to cleanup or allow the ctrl device release to cleanup.
> 
> Instead, we simply move the call to nvme_auth_init_ctrl before we add the
> device such that nvme_init_ctrl either fails without creating a device
> or it succeeds. We also add a code comment to try and prevent similar issues
> from coming back in the future.
> 
> [1]:
> --
> unreferenced object 0xffff91488fb07200 (size 256):
>    comm "nvme", pid 29344, jiffies 4295069699
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 72 b0 8f 48 91 ff ff .........r..H...
>      08 72 b0 8f 48 91 ff ff 00 d6 55 a2 ff ff ff ff .r..H.....U.....
>    backtrace (crc 36f6c278):
>      [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
>      [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
>      [<ffffffffa2562fd0>] device_add+0x510/0x8c0
>      [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
>      [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
>      [<ffffffffc13b0af6>] 0xffffffffc13b0af6
>      [<ffffffffc120e565>] 0xffffffffc120e565
>      [<ffffffffa1edeb14>] vfs_write+0x104/0x490
>      [<ffffffffa1edf263>] ksys_write+0x73/0x100
>      [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
>      [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
>      [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
>      [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff91488ed7ea00 (size 256):
>    comm "nvme", pid 37478, jiffies 4295155857
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 ea d7 8e 48 91 ff ff ............H...
>      08 ea d7 8e 48 91 ff ff 00 d6 55 a2 ff ff ff ff ....H.....U.....
>    backtrace (crc fc1acf5):
>      [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
>      [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
>      [<ffffffffa2562fd0>] device_add+0x510/0x8c0
>      [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
>      [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
>      [<ffffffffc13707b7>] 0xffffffffc13707b7
>      [<ffffffffc120e565>] 0xffffffffc120e565
>      [<ffffffffa1edeb14>] vfs_write+0x104/0x490
>      [<ffffffffa1edf263>] ksys_write+0x73/0x100
>      [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
>      [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
>      [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
>      [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> --
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


