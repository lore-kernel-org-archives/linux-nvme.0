Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C92CAC589
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Sep 2025 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9ZVJI2dTzDxGooFtTzUPXSetU9cr6ewTIx+EaQ4SSo=; b=DdDzUNhX+CqPJ9ImvV6k1Hzq4I
	Yj8UNVk7mQXAjBQ/KExQwUClGbDlq4tMbQ2Mts+kJcyBbRiSUzhIE5lwn39WNwBT10yVkyeai59Id
	IaakAPgzIKCLGtfcdKjnmH1dBOsZrJhW5iW3B6LDR9FP42lrJ2XPjDlKxK16WI527GSMoxdG4R91C
	AfLpVxIZD1EMJPImRznvu82sjGLIgygyYSqA8xMpuoibWc9970cxQ4Dp3+cB0cxyePbDeLkZTfGeV
	Ziy+nuFneBLYO+M4NeGx9UevpH5ch5GtvGopKbzJF4ADyPaH1VHJbcS5sQCqOXuGTzfhM1RII3BfQ
	WnOlJrzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsse-00000005CJS-0lmQ;
	Tue, 09 Sep 2025 07:35:08 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvs55-00000004laY-09Ur
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 06:43:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33EA627BAF;
	Tue,  9 Sep 2025 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757400230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ZVJI2dTzDxGooFtTzUPXSetU9cr6ewTIx+EaQ4SSo=;
	b=RVNlIfTBZ3Fn+6oZ+c4qkpHWSZwhYw+cix+7Vi5g+EkCAqPQ0ZqJeTjN7WeX2Cmj39rR72
	2O03/g9eW9clgea5QOYhnm9juxnJ9v6a0cP0ogmyZhOz0C1fHnL/5B9msvzKGNDyt/kf/E
	+qzTqdUhy3SzJSzGlL8YceMNnR3Gocs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757400230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ZVJI2dTzDxGooFtTzUPXSetU9cr6ewTIx+EaQ4SSo=;
	b=UUEKmkFlC9Mp4T1QzAoq8X3BOYJq6HGhjFpwOe5I65i47nNCPBrm1ik1zeCx/fqRi8K+yQ
	ppkAi56CWM13eiBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RVNlIfTB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UUEKmkFl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757400230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ZVJI2dTzDxGooFtTzUPXSetU9cr6ewTIx+EaQ4SSo=;
	b=RVNlIfTBZ3Fn+6oZ+c4qkpHWSZwhYw+cix+7Vi5g+EkCAqPQ0ZqJeTjN7WeX2Cmj39rR72
	2O03/g9eW9clgea5QOYhnm9juxnJ9v6a0cP0ogmyZhOz0C1fHnL/5B9msvzKGNDyt/kf/E
	+qzTqdUhy3SzJSzGlL8YceMNnR3Gocs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757400230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ZVJI2dTzDxGooFtTzUPXSetU9cr6ewTIx+EaQ4SSo=;
	b=UUEKmkFlC9Mp4T1QzAoq8X3BOYJq6HGhjFpwOe5I65i47nNCPBrm1ik1zeCx/fqRi8K+yQ
	ppkAi56CWM13eiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2A281388C;
	Tue,  9 Sep 2025 06:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WSS5NaXMv2jzVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Sep 2025 06:43:49 +0000
Message-ID: <32cffc9b-8be5-42db-bec2-871293c5549b@suse.de>
Date: Tue, 9 Sep 2025 08:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: update sc_c in host response
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org,
 Martin George <marting@netapp.com>, Prashanth Adurthi <prashana@netapp.com>
References: <20250908172457.5512-1-marting@netapp.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250908172457.5512-1-marting@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 33EA627BAF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_234355_233872_33C50E2C 
X-CRM114-Status: GOOD (  12.28  )
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

On 9/8/25 19:24, Martin George wrote:
> The sc_c field is currently not updated in the host response to the
> controller challenge leading to failures while attempting secure
> channel concatenation. Fix this by adding a new sc_c variable to the
> dhchap queue context structure which is appropriately set during
> negotiate and then used in the host response.
> 
> Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
> Signed-off-by: Martin George <marting@netapp.com>
> Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
> ---
> Changes in v2: set *buf to sc_c as suggested by Hannes
> ---
>   drivers/nvme/host/auth.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

