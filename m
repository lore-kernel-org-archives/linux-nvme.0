Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49765C369DC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 06:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iCJ7kphXDRJ8nsOq63foj70HkiOS92To0zYCk/e+AIs=; b=Rhcq64hFtIKEf+qWJ/YF9iZEwR
	Ixspbh9vMaIwWNGD7DedfV0cZt0jOmbfGNBNR7sL3DqASIiUQe0nh6bjnZ2IZNNhUfCSdYZ8xL9RM
	MkRK3WgKPALjm3HJA7utq2tkY7jNzsNwmm1Bl813e+MVYIyGraJpuXbmLMvx6AXxskK5H5r6lpIej
	i4exHbbBEq1NsyszU1KSTphoazAP0lD0Mq7rKFhpCcrskwW+taasZv0FsQybpmntI0rZYGOruuewg
	cD7PJcJYJdmzM3pqkO92XZZmKSvdiMBYTtysaeCaw+/0GmR18n5B4MEckim2mafA+aNcYqd6Qil+8
	cIrLcDeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA0fV-0000000BpkZ-0Cs9;
	Wed, 30 Apr 2025 06:11:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA0cZ-0000000BpUj-1Ua1
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 06:08:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA3B211E5;
	Wed, 30 Apr 2025 06:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCJ7kphXDRJ8nsOq63foj70HkiOS92To0zYCk/e+AIs=;
	b=fDEQ8ZpkVj0MXrc8R2xno8NlIQF1aT/PKyO452+QM8M4EQrDNbzhjyuLJWOZheWO9HHcQV
	gXrXTKdWhrsYzxLffyrAtLdZ3dK57AdO1OnbYyDgZzjLCLPKkF3iArtL+WZGqCc9pZVKI6
	bntKqvddUyXq1Y5fn7H+KqLXjKcDDHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCJ7kphXDRJ8nsOq63foj70HkiOS92To0zYCk/e+AIs=;
	b=qVq1Icc0Gx/cRf8HT+DsU5RtydquBqBAec6OpMd8tmLHx6kZ8tagFNK5CwM+P8SPH7QYMd
	4S0gZoRGNSLUtsBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fDEQ8Zpk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qVq1Icc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCJ7kphXDRJ8nsOq63foj70HkiOS92To0zYCk/e+AIs=;
	b=fDEQ8ZpkVj0MXrc8R2xno8NlIQF1aT/PKyO452+QM8M4EQrDNbzhjyuLJWOZheWO9HHcQV
	gXrXTKdWhrsYzxLffyrAtLdZ3dK57AdO1OnbYyDgZzjLCLPKkF3iArtL+WZGqCc9pZVKI6
	bntKqvddUyXq1Y5fn7H+KqLXjKcDDHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCJ7kphXDRJ8nsOq63foj70HkiOS92To0zYCk/e+AIs=;
	b=qVq1Icc0Gx/cRf8HT+DsU5RtydquBqBAec6OpMd8tmLHx6kZ8tagFNK5CwM+P8SPH7QYMd
	4S0gZoRGNSLUtsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6B9C139E7;
	Wed, 30 Apr 2025 06:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RgHkJmS+EWhfZAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:08:36 +0000
Message-ID: <80bf4e1d-b60d-4c61-a887-b6d093cfbd60@suse.de>
Date: Wed, 30 Apr 2025 08:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de> <aBEW4W40ZelIXfs2@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aBEW4W40ZelIXfs2@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EA3B211E5
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_230839_542091_3C806978 
X-CRM114-Status: GOOD (  16.70  )
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

On 4/29/25 20:13, Keith Busch wrote:
> On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index b502ac07483b..d3c4eacf607f 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>                   msleep(100);
>>>           }
>>>
>>> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>                   return;
>>>
>>>           nvme_unquiesce_io_queues(ctrl);
>>
>> I would rather have a separate state for firmware activation.
>> (Ab-)using the 'RESETTING' state here has direct implications
>> with the error handler, as for the error handler 'RESETTING'
>> means that the error handler has been scheduled.
>> Which is not true for firmware activation.
> 
> But the point of having firmware activation set the state to RESETTING
> was to fence off error handling from trying to schedule a real reset.
> The fw activation work schedules its own recovery if it times out, but
> we don't want any other recovery action or user requested resets to
> proceed while an activation is still pending.

I know; that was precisely my point. We are overloading the 'RESETTTING'
state to mean either 'reset has started' or 'fw activation is ongoing'.
Which are two _vastly_ different situations, and we should differentiate
them eg by introducing a new state. That new state can (and should) have
the same effects as the RESETTING state, true.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

