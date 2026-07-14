Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B509C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dSP6zdI9t4rsmdMSzHa/O8MQg/E2hFESX/H9uCIdsxs=; b=HztXb8zNs/SIb7U8W8n2725AE8
	szOZB3TgtRIh18X/Apqfaq1Nf0RsV/eDBKhJ2NqixQUNzGG1cuR8Mkq37xbwwMjSdQ9uFLyvazhod
	NUsoX4acub2kQKe9X/KA/eLRwUYjSUJua482lSMt08zFstJhGLNW27byiJgzahKkuA6cD9l9RmjBr
	LSCqDkIz77bAUsWRG/tyjxW/SZ1p5LgRBb6sduze2/RGXkEBUCiZs/Iy4p8aO7/wqugERjRO7pEg7
	bVtZWZWgJJ7MrAdoMj+MR7uX7On0HUEKVGCYo79eJojwTf46bVcpsW6kqWwmRaopuORq76NH0Axcj
	JbwhGtxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjd3a-0000000C9hq-3zdt;
	Tue, 14 Jul 2026 13:20:18 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjd3X-0000000C9fH-305R
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 13:20:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D8A777E7B;
	Tue, 14 Jul 2026 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784035213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSP6zdI9t4rsmdMSzHa/O8MQg/E2hFESX/H9uCIdsxs=;
	b=Tc+rdDK///OPW1LM0gh+cixhndBY8/bwGu4E5ngV8B72xltha/GBY2w/O3dOuT/0zjzYxE
	hOdZ8uCwWfxxXrKDWyousUxgDlbacVHjqjy+uT526ZcNmbGTXXv+1V7SyeF5EVeYd+0eAP
	afD99SEudp7KVYdxZ1D4kKhsZuVht4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784035213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSP6zdI9t4rsmdMSzHa/O8MQg/E2hFESX/H9uCIdsxs=;
	b=GCHafi3BuwpkUowVszFLaztKNyIbPL5jRgUfLPa8HvPGWfg3lWttL3P+AKMU33PyfPq9MG
	k0zxCG7TQ4OhMmBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Tc+rdDK/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GCHafi3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784035213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSP6zdI9t4rsmdMSzHa/O8MQg/E2hFESX/H9uCIdsxs=;
	b=Tc+rdDK///OPW1LM0gh+cixhndBY8/bwGu4E5ngV8B72xltha/GBY2w/O3dOuT/0zjzYxE
	hOdZ8uCwWfxxXrKDWyousUxgDlbacVHjqjy+uT526ZcNmbGTXXv+1V7SyeF5EVeYd+0eAP
	afD99SEudp7KVYdxZ1D4kKhsZuVht4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784035213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSP6zdI9t4rsmdMSzHa/O8MQg/E2hFESX/H9uCIdsxs=;
	b=GCHafi3BuwpkUowVszFLaztKNyIbPL5jRgUfLPa8HvPGWfg3lWttL3P+AKMU33PyfPq9MG
	k0zxCG7TQ4OhMmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E4FA779AE;
	Tue, 14 Jul 2026 13:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9BVYCo03VmqxVgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 14 Jul 2026 13:20:13 +0000
Message-ID: <20f51bf9-8288-4ce5-89b7-9dca568333c6@suse.de>
Date: Tue, 14 Jul 2026 15:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: swap synchronization ordering in nvme_remove_head()
To: John Garry <john.garry@linux.dev>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, nilay@linux.ibm.com,
 John Garry <john.g.garry@oracle.com>
References: <20260707135744.1470014-1-john.garry@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260707135744.1470014-1-john.garry@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D8A777E7B
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_062015_957804_E9AE833A 
X-CRM114-Status: GOOD (  16.19  )
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

On 7/7/26 3:57 PM, John Garry wrote:
> From: John Garry <john.g.garry@oracle.com>
> 
> sashiko bot reported a potential issue in the requeue handling in [0] -
> the code there is same as the NVMe driver.
> 
> The issue is that when we schedule the requeue work, if a bio is added to
> the requeue list afterwards in nvme_ns_head_submit_bio(), it is missed by
> the requeue worker.
> 
> This issue can be recreated by hacking a large delay in the bio submission
> requeue path:
> 
>          } else if (nvme_available_path(head)) {
>                  dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
> 
> +               msleep(30000);
>                  spin_lock_irq(&head->requeue_lock);
>                  bio_list_add(&head->requeue_list, bio);
>                  spin_unlock_irq(&head->requeue_lock);
> 
> 
> Then if we issue a write after removing all paths, a hang can be seen:
> 
> # echo 20 > /sys/devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n1/delayed_removal_secs
> #
> # ./ini_nvme_teardown.sh
> [   25.877224] nvme nvme1: Removing ctrl: NQN "nvme-test-target"
> [   25.939569] nvme nvme2: Removing ctrl: NQN "nvme-test-target"
> #
> # xfs_io -d -C "pwrite -b 64k -V 1 -D 0 64k" /dev/nvme1n1p1
> [   29.883653] block nvme1n1: no usable path - requeuing I/O
> 
> Fix by re-ordering the SRCU synchronization and scheduling the requeue
> work.
> 
> [0] https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/#m72af1f29deb0ebfb2973464207f201f1be1f660c
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> I am not sure if we still require the synchronize_srcu() after nvme_cdev_del().
> 
Which one? I only see one after 'list_del_rcu()', and there we 
definitely need it ...

Otherwise:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

