Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E14C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=; b=vUVieEnwDcdkncu6paAP6Uv6Q9
	v5mLXMBDaeb+G2PY7LXzCSRstGpsu4jep7tl7oaeOOQwDXSJwS2WrSGVT+bgc1RD0MZnmQgc9K1kO
	gI89kkFjZ2HuI1qWTZWvzAdzrlPEeV4JN6bUVg5MZFLn/t9lY76H0golma7TmJQAeAJigX5gIOVYx
	8Xsm3lZBMWQGoJUrFm88kpzxux0gdAw3F+K0UX5YrScP0bfKwbakAhpyOAfU7QBUiTqG5lRtJlPc3
	Q3VG5+p5bWXeuRnZDQOwKjPDAmiHVHFfJMGbW4X7Pz3UZarCJRGeNvxdAkPP+ldEAdT1mclFPu93s
	RUGtURhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuR6-00000009w7Y-2E0z;
	Fri, 28 Feb 2025 07:05:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuR4-00000009w6u-3tYQ
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:05:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36E172116F;
	Fri, 28 Feb 2025 07:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=xXbDeQJ+kcIoOQlEJoOBg7afLuv87MVjuX04iBvICEB0HzfP1eV4ihARYqsCg6dQuOzICI
	ha+xvDCU4a+KpMpzEUZYrtFjU+xlRAVwABQoQasK/rSwPWejk588hlOE2V3c8wS7NYeDVi
	gSu3vMSgjIQjxROpnskQ4OgJ2ujVh24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=SONULh4V92zBZRJeO1ULDAkRrVzRQ+GyZVvdri7xe3ZyjFUh82BLYZCFh0ro83lOydUSfA
	yNums/NO/iFWHgDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xXbDeQJ+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SONULh4V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=xXbDeQJ+kcIoOQlEJoOBg7afLuv87MVjuX04iBvICEB0HzfP1eV4ihARYqsCg6dQuOzICI
	ha+xvDCU4a+KpMpzEUZYrtFjU+xlRAVwABQoQasK/rSwPWejk588hlOE2V3c8wS7NYeDVi
	gSu3vMSgjIQjxROpnskQ4OgJ2ujVh24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=SONULh4V92zBZRJeO1ULDAkRrVzRQ+GyZVvdri7xe3ZyjFUh82BLYZCFh0ro83lOydUSfA
	yNums/NO/iFWHgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E71E1137AC;
	Fri, 28 Feb 2025 07:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AcHqNjRgwWe5HQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:05:24 +0000
Message-ID: <a75ad2a9-d8f7-4b84-aea0-12be785e249e@suse.de>
Date: Fri, 28 Feb 2025 08:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36E172116F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_230527_110006_0D9EE8F0 
X-CRM114-Status: GOOD (  11.18  )
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

On 2/26/25 19:45, Daniel Wagner wrote:
> The fcloop_lport objects live time is controlled by the user interface
> add_local_port and del_local_port. nport, rport and tport objects are
> pointing to the lport objects but here is no clear tracking. Let's
> introduce an explicit ref counter for the lport objects and prepare the
> stage for restructuring how lports are used.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 47 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 35 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

