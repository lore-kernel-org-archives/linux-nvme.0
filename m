Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE688C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=soAJYOMSpZnqq1n87sXjlS4cYkK2FpQ7G0vY8k4Aub4=; b=Ik03v/V6oiN4cfgISRvCWvI2wY
	m98zlbf3whsjyraYjHHAhF7UJ2BLC54nz6YclUXgjXQoOFpdRHHnYpIscqzhngzLq16wV7pxHxrgv
	y1wTlUSnL6BHvN62LJMvQ7YnqOU4+xwhM+qnKVvlwjnsr0SYghcwd2qb4dpcfLk9fwRGGk5fWp5dV
	IMoTfRsk1fGsgMaYd7AoX+7wIFqIofO5hDfZJyWL18EP8DsVyTn419+EgR+cbJhNI/bcUGmNtU/ae
	8JojdgLSfs0a2xeXYWY6+6lK1MHsBQxRrmsl4uGn6KXzylGv481XE2vEPUM4RccNrovxFRElEpb1K
	wdTU6yrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6r6-00000001VFl-261I;
	Tue, 22 Jul 2025 06:52:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6r4-00000001VEX-1ZiB
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 06:52:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F6FC21902;
	Tue, 22 Jul 2025 06:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753167120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soAJYOMSpZnqq1n87sXjlS4cYkK2FpQ7G0vY8k4Aub4=;
	b=Lu+7j5wOWqCoXszPYWFUXiDPbohQ5zRvUnQCCVjSepB/81J90L7tshi/3C5akn2ae5BsF6
	yJPTn73lwZyChRKl0bMDxlpmTnWkYGgjdN5y1JyP+sWMfdvSjz+fYLTRcayDw0ZzVlP6c1
	Es/SfM/zkyCGl+sMS1iSKnlEWXXfthw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753167120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soAJYOMSpZnqq1n87sXjlS4cYkK2FpQ7G0vY8k4Aub4=;
	b=DSU4lTAaErkK30oE8NsbpT9Zofqs8N8Zj2GD8iETE9WBaFaSD/W7sztTzBX/7KHEuuVBpZ
	43VKQf3qdLpKOnBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753167120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soAJYOMSpZnqq1n87sXjlS4cYkK2FpQ7G0vY8k4Aub4=;
	b=Lu+7j5wOWqCoXszPYWFUXiDPbohQ5zRvUnQCCVjSepB/81J90L7tshi/3C5akn2ae5BsF6
	yJPTn73lwZyChRKl0bMDxlpmTnWkYGgjdN5y1JyP+sWMfdvSjz+fYLTRcayDw0ZzVlP6c1
	Es/SfM/zkyCGl+sMS1iSKnlEWXXfthw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753167120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soAJYOMSpZnqq1n87sXjlS4cYkK2FpQ7G0vY8k4Aub4=;
	b=DSU4lTAaErkK30oE8NsbpT9Zofqs8N8Zj2GD8iETE9WBaFaSD/W7sztTzBX/7KHEuuVBpZ
	43VKQf3qdLpKOnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 370BD132EA;
	Tue, 22 Jul 2025 06:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqznCxA1f2g5bwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 06:52:00 +0000
Message-ID: <2c794c0e-b540-4b37-8691-cf2b4c6cfdf3@suse.de>
Date: Tue, 22 Jul 2025 08:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: revert the cross-controller atomic write size
 validation
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Cc: Alan Adamson <alan.adamson@oracle.com>,
 John Garry <john.g.garry@oracle.com>, yi.zhang@redhat.com,
 linux-nvme@lists.infradead.org
References: <20250714144406.1692041-1-hch@lst.de>
 <20250714144406.1692041-2-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250714144406.1692041-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_235202_566180_A41F0C3F 
X-CRM114-Status: GOOD (  16.35  )
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

On 7/14/25 16:44, Christoph Hellwig wrote:
> This was originally added by commit 8695f060a029 ("nvme: all namespaces
> in a subsystem must adhere to a common atomic write size") to check
> the all controllers in a subsystem report the same atomic write size,
> but the check wasn't quite correct and caused problems for devices
> with multiple namespaces that report different LBA sizes.  Commit
> f46d273449ba ("nvme: fix atomic write size validation") tried to fix
> this, but then caused problems for namespace rediscovery after a
> format with an LBA size change that changes the AWUPF value.
> 
> This drop the validation and essentially revers those two commits while
> keeping the cleanup that went in between the two.  We'll need to figure
> out how to properly check for the mouse trap that nvme left us, but for
> now revert the check to keep devices working for users who couldn't care
> less about the atomic write feature.
> 
> Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
> Fixes: f46d273449ba ("nvme: fix atomic write size validation")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
Yes, please. It had been a annoying me for quite some time,
glad to see it go.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

