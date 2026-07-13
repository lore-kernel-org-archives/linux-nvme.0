Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C16DC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcwDktWx0MX7A6m2tZsP59pH2CHhK2YQavo+uWy1VsQ=; b=qiMPBMutYD9MrZfqx2v2+QB6k8
	f4g+sVqtBNNK7mvCERHigMB5+WvcMCm0gQKorElpIoBIz63tyKdWUfbFqGtmZW3u+42EZQ2mQMp1S
	hJADm9zzmaHkE+IIIHd3t00X1RHOou+kT5uRj5dOuncd5VPmJuC3WSnFk+eY9aS9jjwFELMDpSZIl
	3DXh+Wv5ti8Rlhrjxrj1eEJQnB/6B306MwbAI1hgMs1PzBIuxXqxvRy3NRoWhi3D2KYsJIxKXNN0R
	7ecmsLeQDNW8Th/UoBCTUOpmtR1IDTBtWUxJTBhoF/9VdVfsGkMa9DwBjQ4udw23lC61sgLJ32lVK
	vTfn2G4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBDc-00000008SMj-048W;
	Mon, 13 Jul 2026 07:36:48 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBDZ-00000008SLk-3wuo
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:36:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF73277430;
	Mon, 13 Jul 2026 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783928204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcwDktWx0MX7A6m2tZsP59pH2CHhK2YQavo+uWy1VsQ=;
	b=yQ4juvx0QgrFDgtA4wkMKTnv4JjZBUDFA5hyG48yg3XnoSGaqYMCnBFzO7k+Sfp0ydLMkK
	TPziRAGqu/f/aN/diFTGq8yPQBjrGzj4ZEik7g6myhOgFihnAP7cUpdoH5s8ESMj57rLYz
	WKl+UvTVdRO7utZeOHP+PUxGgjf9Sck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783928204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcwDktWx0MX7A6m2tZsP59pH2CHhK2YQavo+uWy1VsQ=;
	b=aeUPCcqvtZFE5Wzz+OVj58RES/B18adSAwUq5aArCD1/zJY7vCWs0vXBM5f5X2JOz0tgvi
	48juXXUHrVtTAICQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XwrHEvOG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Tvug+SP8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783928203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcwDktWx0MX7A6m2tZsP59pH2CHhK2YQavo+uWy1VsQ=;
	b=XwrHEvOGXUjdbp9DVSEiRdnlA5blFTjKca2cE3U3naydKNkAWq6etlQtg8zGYZ0zmYEY5O
	ZcOQmeIGKfbB6XSrIxrThdC+uqg/rv+xBQaac1jAKd09A2jAuO20xX3KueEP3mpZsF3Ucn
	UHHw7O0X1I0LNdaMmcMQBxOVT3PMNxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783928203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcwDktWx0MX7A6m2tZsP59pH2CHhK2YQavo+uWy1VsQ=;
	b=Tvug+SP88mB9TPw0RdsC5R4BTjkOY/H4V+XDGjI6lsZI/8vAkOYfY4EB4tMRl4nUiO30KG
	oTUi8f00YHgYsbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97C0A779AE;
	Mon, 13 Jul 2026 07:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9wfZI4uVVGqncAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 07:36:43 +0000
Message-ID: <da0c25f7-fb17-45be-a3ff-23d6558a3a9e@suse.de>
Date: Mon, 13 Jul 2026 09:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] nvme: Add support for CQT to nvme host
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Randy Jennings
 <randyj@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-17-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260712022437.3743117-17-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EF73277430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_003646_126413_4A078A40 
X-CRM114-Status: GOOD (  12.58  )
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

On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> limit for attempting Cross-Controller Recovery. Add ctrl->cqt, read its
> value from controller identify response, expose it via sysfs, and have
> nvme_fence_timeout_ms() account for it.
> 
> Use CQT to drive time-based recovery in fc, rdma, and tcp transports.
> Add a fenced_work delayed work to each transport controller. If CCR
> fails, fencing_work switches to error recovery immediately if CQT is not
> supported. Otherwise it schedules fenced_work after the remaining fence
> timeout, which also switches to error recovery when scheduled.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c  |  1 +
>   drivers/nvme/host/fc.c    | 41 +++++++++++++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h  |  5 +++--
>   drivers/nvme/host/rdma.c  | 41 +++++++++++++++++++++++++++++++++++----
>   drivers/nvme/host/sysfs.c |  2 ++
>   drivers/nvme/host/tcp.c   | 41 +++++++++++++++++++++++++++++++++++----
>   6 files changed, 117 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

