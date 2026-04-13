Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC77EBFD10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fokCImcpAiqbWw4xMqx9pi0Wk7lu1PWB1CNEyLu0nb4=; b=AdVm914yFWM9iyJwrjULwdvOhU
	ZYMba5BbiQ4I9Zrm8nrofO1HKlRVDYoZZykYEucszUyiFEGlXVnjisl7x1iYh1FYinPTh7kSnzXkl
	u59H2nSXuubUAQjOZ7fgDELGz1/dTc0hk+6G1PwBqXB9WZ/IsAD40z9r9stGUuHA7QJj6IFPSolMX
	vuesG3Pn4rXtoEzOQvOiJRCbUNiAnhdwbJ5kp10QiCWWepBl+8Qd+EycrGWjlqz9QOlIGkMKMx5TJ
	pXEhOJ9hzwz7oy0M/Y3kvcvu1GVPvvnl4wlYxhyjabOziO6QSbAzrLUDOOXNKTtqhpxh2K8b0R3tn
	2WEZyGbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCCPa-0000000FEyf-2um5;
	Mon, 13 Apr 2026 08:12:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCCPY-0000000FExw-41BM
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 08:12:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6155F6A890;
	Mon, 13 Apr 2026 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776067967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fokCImcpAiqbWw4xMqx9pi0Wk7lu1PWB1CNEyLu0nb4=;
	b=VrJPJeqlH5eLkCY12gdBlv5FqMuVZ1k6biLeV0XCff//UkeLcBT6b8LcOj9E+2IV54nwwZ
	b2FKzcujGPUmVyspnodM+E99GNxciTKI73MDE63JaepnYtxS32yl8KdRWwQkkbkpL8cyxv
	yAiX/5Btab4viY45Hnz2Eebfgu+obIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776067967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fokCImcpAiqbWw4xMqx9pi0Wk7lu1PWB1CNEyLu0nb4=;
	b=CVtNzW/X4ME+QTo95InyPHaER+FNYCUdBTbILn5VkK5ajwq92Zpb/n4uMMvAeHcSqBL+yb
	UF5mJP7iUHTMwoDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776067967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fokCImcpAiqbWw4xMqx9pi0Wk7lu1PWB1CNEyLu0nb4=;
	b=VrJPJeqlH5eLkCY12gdBlv5FqMuVZ1k6biLeV0XCff//UkeLcBT6b8LcOj9E+2IV54nwwZ
	b2FKzcujGPUmVyspnodM+E99GNxciTKI73MDE63JaepnYtxS32yl8KdRWwQkkbkpL8cyxv
	yAiX/5Btab4viY45Hnz2Eebfgu+obIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776067967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fokCImcpAiqbWw4xMqx9pi0Wk7lu1PWB1CNEyLu0nb4=;
	b=CVtNzW/X4ME+QTo95InyPHaER+FNYCUdBTbILn5VkK5ajwq92Zpb/n4uMMvAeHcSqBL+yb
	UF5mJP7iUHTMwoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0346B4ADAB;
	Mon, 13 Apr 2026 08:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TrWcOn6l3GlyfgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Apr 2026 08:12:46 +0000
Message-ID: <e7a5ab7f-722e-4767-a9a6-2a1ae73bd8b7@suse.de>
Date: Mon, 13 Apr 2026 10:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/8] nvme: Refactor and expose per-controller timeout
 configuration
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260410073924.61078-1-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_011249_144165_A4D972AC 
X-CRM114-Status: GOOD (  24.61  )
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

On 4/10/26 09:39, Maurizio Lombardi wrote:
> This patchset tries to address some limitations in how the NVMe driver handles
> command timeouts.
> Currently, the driver relies heavily on global module parameters
> (NVME_IO_TIMEOUT and NVME_ADMIN_TIMEOUT), making it difficult for users to
> tune timeouts for specific controllers that may have very different
> characteristics. Also, in some cases, manual changes to sysfs timeout values
> are ignored by the driver logic.
> 
> For example this patchset removes the unconditional timeout assignment in
> nvme_init_request. This allows the block layer to correctly apply the request
> queue's timeout settings, ensuring that user-initiated changes via sysfs
> are actually respected for all requests.
> 
> It introduces new sysfs attributes (admin_timeout and io_timeout) to the NVMe
> controller. This allows users to configure distinct timeout requirements for
> different controllers rather than relying on global module parameters.
> 
> Some examples:
> 
> Changes to the controller's io_timeout gets propagated to all
> the associated namespaces' queues:
> 
> # find /sys -name 'io_timeout'
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/io_timeout
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n2/queue/io_timeout
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n3/queue/io_timeout
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/io_timeout
> 
> # echo 27000 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/io_timeout
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/io_timeout
> 27000
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n2/queue/io_timeout
> 27000
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n3/queue/io_timeout
> 27000
> 
> When adding a namespace target-side, the io_timeout is inherited from
> the controller's preferred timeout:
> 
> * target side *
> # nvmetcli
> /> cd subsystems/test-nqn/namespaces/4
> /subsystems/t.../namespaces/4> enable
> The Namespace has been enabled.
> 
> ************
> 
> * Host-side *
> nvme nvme0: rescanning namespaces.
> # find /sys -name 'io_timeout'
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/io_timeout
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n2/queue/io_timeout
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n3/queue/io_timeout
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n4/queue/io_timeout <-- new namespace
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/io_timeout
> 
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n4/queue/io_timeout
> 27000
> ***********
> 
> io_timeout and admin_timeout module parameters are used as default
> values for new controllers:
> 
> # nvme connect -t tcp -a 10.37.153.138 -s 8000 -n test-nqn2
> connecting to device: nvme1
> 
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme1/nvme1c1n1/queue/io_timeout
> 30000
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme1/admin_timeout
> 60000
> 
> V3: - Rebase on top of nvme 7.1 branch
>      - add an admin_timeout variable to nvme_ctrl structure
>      - Wait until the controller has reached the LIVE state
>        for the first time before allowing the user to modify
>        the timeouts, this prevents the dereferencing of the admin_q,
>        fabrics_q and connect_q queues before their initialization.
>      - move blk_put_queue(fabrics_q) to nvme_free_ctrl() to align it to
>        admin_q teardown
>      - modify nvmet-loop to avoid deleting and re-creating the admin_q queue
>        when the controller enters the resetting state.
>      - add a warning if nvme_alloc_admin_tag_set() is called twice against
>        the same controller
> 
> V2: - Drop the RFC tag
>      - apply the timeout settings to fabrics_q and connect_q too
>      - Code style fixes
>      - remove unnecessary check for null admin_q in __nvme_delete_io_queues()
>      - Use DEVICE_ATTR() macro
> 
What about KATO?
With this patchset the user can set arbitrary values to the I/O timeout,
which easily can be lower than KATO.
And as per spec a KATO timeout implies a transport disruption, requiring
a controller reset.
But due to the internal design of the nvme error handling we do conflate
transport disruption and command timeout, so an _I/O_ timeout triggers
a controller reset.
Which means that a command timeout lower than KATO will result in false
positives, with the controller being reset even though the connection
is perfectly happy.

If you were to go that way of making the I/O timeout configurable I
strongly suggest to implement command abort first (hello John ;-),
as the you can simply cancel a command which ran into a timeout
without having to reset the controller.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

