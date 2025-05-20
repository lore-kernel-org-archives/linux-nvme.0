Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F268FC3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=; b=q3r3+925PTB6eMVzRgYQh9e96W
	TdGbH13tRiQQvnKJ91vQxTYun4faB0a21H+Wg7WZjaXTS1K1JF0iKZstoA32mPJUWtl7kMfdQ2JLN
	4L9aT1HMUYudX+d5yfxG45QnRB8+gArcY2vnLJ4R8KU9kBD5H20Qxmzkc5Yr6m+hXyCWMZ/lbfR+P
	ZXS0jbom460p+XdREnmAm1iN3zTcUvuuTPFeI20zxcOO8QkvWatVaJfFERpsrpptM7Vn2saUucHTK
	SLa8Awn6SCmty4RGBPhnYpjXZCIDTdUxfI/3twwcR+9dxYGY9LOnrXfg9BG/SfzZ2HkFNOBNPlFZU
	8YTAd09A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHLWY-0000000Cj3t-45MW;
	Tue, 20 May 2025 11:52:46 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHLPY-0000000Chh6-2T3Q
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 11:45:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E89F220687;
	Tue, 20 May 2025 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747741529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=UcbvN0HYMTaNwJQLgft169UA8c5YIMggryjSKiXkhUUyCaOr+TGHUuBsrjLQJt6MgRe4Tz
	XJCI5cj1SJ/J2NCuEAqP0DcMk24wsLFA6QWKR/0zARrHLso8OpnQ5kknRWeqi8L37RuLw5
	KOn0Mq+UqNJ9Ok8p/iyQBl6XbDBKK64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747741529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=McTTgkmtJULFIoX9+1hJFHCKBbaGt8o5saXrGhiVcGHoWihkU3JNTw089Iq2a7Eiu41gvb
	yMgVo55GlXeYANCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=15z+ALjw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Wb/IY+39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747741527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=15z+ALjwicFXJewlGbgKpOpJFXua56Vh09ncLwYmfS1ARdr98xSr6CcCAo32zp/sVPsDRz
	3WcNM7d64QdiYHFQVhc3snnkhoGCRD7siH3EXsYfoppCaJxi4UCUH4BPb0fYUYc+k0VC/w
	AXmMg8qbD4s2FuM5ubFRJvxdhpy2d5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747741527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v79mAH0fQ8XwCkMiZBcFEcVG38jLqH2Y96+WO4NsMSM=;
	b=Wb/IY+39Jt6qWXK2ow7s12LEbztRskosWmARsMMrWGu5ISnpoKrU5mELqeTSdfHfxr2VYJ
	HNC+h5FItLg72OAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE55213A3E;
	Tue, 20 May 2025 11:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W3iFMVdrLGiPfAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 May 2025 11:45:27 +0000
Message-ID: <f540dd31-75f6-4e1c-9bee-304530984610@suse.de>
Date: Tue, 20 May 2025 13:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
 <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
 <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E89F220687
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_044532_775491_7EECBD28 
X-CRM114-Status: GOOD (  17.08  )
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

On 5/19/25 04:53, Shinichiro Kawasaki wrote:
> On May 18, 2025 / 13:25, Hannes Reinecke wrote:
>> On 5/18/25 12:01, Sagi Grimberg wrote:
>>>
>>>
>>> On 16/05/2025 15:31, Shinichiro Kawasaki wrote:
>>>> Hello all,
>>>>
>>>> Using the kernel v6.15-rc6 and the latest blktests (git hash
>>>> 613b8377e4d3), I
>>>> observe the test case nvme/063 fails with tcp transport. Kernel
>>>> reported WARN in
>>>> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter
>>>> [1]. The
>>>> failure is recreated in stable manner on my test nodes.
>>>>
>>>> The test case script had a bug then this failure was not found until
>>>> the bug get
>>>> fixed. I tried the kernel v6.15-rc1, and observed the same failure
>>>> symptom. This
>>>> test case cannot be run with the kernel v6.14, since it does not
>>>> have secure
>>>> concatenation feature.
>>>>
>>>> Actions for fix will be appreciated.
>>>
>>> Hannes, did you encounter this?
>>>
>> No; I would think it's an artifact due to multipath not being enabled.
>> Shin'ichiro, can you reproduce it with CONFIG_NVME_MULTIPATH on?
> 
> I tried both CONFIG_NVME_MULTIPATH on and off, and the failure was recreated
> regardless of the config value. Of note is that sometimes it is recreated at
> the first test case run, and sometimes it is required to repeat the test case a
> few times.
> 
> FYI, I attached the kernel config which I used to recreate the failure.

Hmm.
Can you check with this patch (on top of the previous one):


diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55569eb7770b..43d86e8c6df3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2197,6 +2197,7 @@ static int nvme_tcp_configure_io_queues(struct 
nvme_ctrl *ctrl, bool new)
                 blk_mq_update_nr_hw_queues(ctrl->tagset,
                         ctrl->queue_count - 1);
                 nvme_unfreeze(ctrl);
+               nvme_quiesce_io_queues(ctrl);
         }

         /*

Thanks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

