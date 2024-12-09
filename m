Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED011E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ecFxS/bnPGsNngQFtB/79KGUXtsUek/Qt1T2kNoz5bg=; b=4TlIZ2cwiDQ+c9z7nWMClv/Zcx
	CmzJAzHPFXVf5khR0ndkBYUbARs1qtPmMy02GaeC1iPMpTw3pyClhvCYIFKJZlwiPmfQoD1bUoj/v
	WmJaZGMwoZT8H+CUH7IeYY0IDiYYaHwU/LTcTR+vCHpsX0KYokgp5kpJU1gNo7pPK6RfB0ulMolsw
	OwR5WzYzvc6evMcU7gYEoeqErFhLK4p3cUC4tWWo+agnuRUP7HCtwiY6dmshRbqpRk5cS6fMls9Vk
	oMUltprqMbaLi3hAy/p+YIJU85zz1eQO3XJ36586fEmV7phxSQIFZ7M/TM7cU35xdgTXK9bgYNODT
	qsiB+KGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZAn-00000006vPx-3bET;
	Mon, 09 Dec 2024 08:31:21 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZAl-00000006vO6-05lP
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:31:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA495211B8;
	Mon,  9 Dec 2024 08:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733733077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecFxS/bnPGsNngQFtB/79KGUXtsUek/Qt1T2kNoz5bg=;
	b=LHDKWUngQ5BPC6UrogXTvvLxEatwqnExvNgu8LplW+RPYdDP2AF2193EUF0R+jbpQBY1jv
	l01kBEyO5En0ArSBOBq5urlh23CTS95rVc/QwmZ6CGeFbuWa9sNyeuZdcCwRvkU2ClIe3h
	cvP61eXe3huEEkfirCsp9CoaTB3X7VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733733077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecFxS/bnPGsNngQFtB/79KGUXtsUek/Qt1T2kNoz5bg=;
	b=5ZxMqnzp9OVvfYWqYIfA9kIJK6t79zHBuMhoB8rA87l1xBrYx+IjpJH2YiCyO3BJoL9NLw
	TJC6JTTVqepz64Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LHDKWUng;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5ZxMqnzp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733733077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecFxS/bnPGsNngQFtB/79KGUXtsUek/Qt1T2kNoz5bg=;
	b=LHDKWUngQ5BPC6UrogXTvvLxEatwqnExvNgu8LplW+RPYdDP2AF2193EUF0R+jbpQBY1jv
	l01kBEyO5En0ArSBOBq5urlh23CTS95rVc/QwmZ6CGeFbuWa9sNyeuZdcCwRvkU2ClIe3h
	cvP61eXe3huEEkfirCsp9CoaTB3X7VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733733077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecFxS/bnPGsNngQFtB/79KGUXtsUek/Qt1T2kNoz5bg=;
	b=5ZxMqnzp9OVvfYWqYIfA9kIJK6t79zHBuMhoB8rA87l1xBrYx+IjpJH2YiCyO3BJoL9NLw
	TJC6JTTVqepz64Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 338F613B18;
	Mon,  9 Dec 2024 08:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tqCrCtWqVmeJDgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Dec 2024 08:31:17 +0000
Message-ID: <8ca78f55-1758-4059-b542-41ad7c7db7a4@suse.de>
Date: Mon, 9 Dec 2024 09:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 07/12] io_uring: enable per-io write streams
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-8-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241206221801.790690-8-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA495211B8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[grimberg.me,gmail.com,samsung.com,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_003119_205699_FBADD9F9 
X-CRM114-Status: GOOD (  11.25  )
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

On 12/6/24 23:17, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Allow userspace to pass a per-I/O write stream in the SQE:
> 
>        __u8 write_stream;
> 
> The __u8 type matches the size the filesystems and block layer support.
> 
> Application can query the supported values from the statx
> max_write_streams field. Unsupported values are ignored by file
> operations that do not support write streams or rejected with an error
> by those that support them.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/uapi/linux/io_uring.h | 4 ++++
>   io_uring/io_uring.c           | 2 ++
>   io_uring/rw.c                 | 1 +
>   3 files changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

