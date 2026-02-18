Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9333DE9A03B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 08:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uG1W71yVzpq8R4o3XHp5q+zB8HyQY7YKXS4bzpupA+Y=; b=u3VgqVbUg5rPwrSRqhMDCsmAIc
	VS+Mugm1kojAG2hmEYywL4FVj8InZEs78LfKRzWCceD8/mAA7cs4PjcUN1+hBQgsXzVqIaPJz/jMQ
	x5EL6oBo6OBe6YtIzbWb74enUh5NWDxPQJ2tIHofJ12Ew8Qi5IRiAQ9J87CvAxhEaXZxFDZKxVA4l
	yU2VvwU26rg24FP1moorJxLlM/M/fGcy6+GD1HpmD0OU5uXhN7LmHBtuoCz3QgrFB8jIO7AlCg9u1
	ILz+w4UJyShEDfF8hCZO3a7QkorBZ4RMzeMggSfLV9DU39iTjqATbeGV14E7ql9rudUs9i4DD19FB
	m0caBTqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsctJ-00000009T67-12GM;
	Wed, 18 Feb 2026 08:26:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsctG-00000009T5R-2sDH
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 08:26:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAB923E6E8;
	Wed, 18 Feb 2026 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG1W71yVzpq8R4o3XHp5q+zB8HyQY7YKXS4bzpupA+Y=;
	b=Ord3GcoOV8sHvUT64cepL06gXspm4MbMLYovdbLnjMCvjiK7WpdUx31If1Ab6x+R8LzGAW
	0FTNGqz99z5r8Cr3zNTDTMkBaXBX6mo8JKHVJuy46OA1Q9zHL50I9vUNEmUabUYVrPs4zY
	COB0oNLADQEMUA0DLwe148pDMeNPNZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG1W71yVzpq8R4o3XHp5q+zB8HyQY7YKXS4bzpupA+Y=;
	b=7f5SR+E7fE3Hj90o+RejnLbj+fBliykmxs3yHOxey6tncy7Pe06dadE4iZQB8acPU3Qsns
	Sm1y/Pgx7/P/k0BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ord3GcoO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7f5SR+E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771403192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG1W71yVzpq8R4o3XHp5q+zB8HyQY7YKXS4bzpupA+Y=;
	b=Ord3GcoOV8sHvUT64cepL06gXspm4MbMLYovdbLnjMCvjiK7WpdUx31If1Ab6x+R8LzGAW
	0FTNGqz99z5r8Cr3zNTDTMkBaXBX6mo8JKHVJuy46OA1Q9zHL50I9vUNEmUabUYVrPs4zY
	COB0oNLADQEMUA0DLwe148pDMeNPNZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771403192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG1W71yVzpq8R4o3XHp5q+zB8HyQY7YKXS4bzpupA+Y=;
	b=7f5SR+E7fE3Hj90o+RejnLbj+fBliykmxs3yHOxey6tncy7Pe06dadE4iZQB8acPU3Qsns
	Sm1y/Pgx7/P/k0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 528A83EA65;
	Wed, 18 Feb 2026 08:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Dw1Erh3lWnGIgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Feb 2026 08:26:32 +0000
Message-ID: <47a898f3-bc2d-4385-b9c0-125daff7cf27@suse.de>
Date: Wed, 18 Feb 2026 09:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/21] nvme-tcp: Extend FENCING state per TP4129 on CCR
 failure
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Aaron Dailey
 <adailey@purestorage.com>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-20-mkhalfella@purestorage.com>
 <7fcdb6bb-34b4-4b73-afce-75c423f8400b@suse.de>
 <20260217175848.GD3435530-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260217175848.GD3435530-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,purestorage.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BAB923E6E8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_002634_893619_39D35EED 
X-CRM114-Status: GOOD (  23.16  )
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

On 2/17/26 18:58, Mohamed Khalfella wrote:
> On Mon 2026-02-16 13:56:10 +0100, Hannes Reinecke wrote:
>> On 2/14/26 05:25, Mohamed Khalfella wrote:
>>> If CCR operations fail and CQT is supported, we must defer the retry of
>>> inflight requests per TP4129. Update ctrl->fencing_work to schedule
>>> ctrl->fenced_work, effectively extending the FENCING state. This delay
>>> ensures that inflight requests are held until it is safe for them to be
>>> retired.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++----
>>>    1 file changed, 35 insertions(+), 4 deletions(-)
>>>
>> Can't you merge / integrate this into the nvme_fence_ctrl() routine?
> 
> ctrl->fencing_work and ctrl->fenced_work are in transport specific
> controller, struct nvme_tcp_ctrl in this case. There is no easy way to
> access these members from nvme_fence_ctrl(). One option to go around
> that is to move them into struct nvme_ctrl. But we call error recovery
> after a controller is fenced, and error recovery is implemented in
> transport specific way. That is why the delay is implemented/repeated
> for every transport.
> 
>> The previous patch already extended the timeout to cover for CQT, so
>> we can just wait for the timeout if CCR failed, no?
> 
> Following on the point above. One change can be done is to reset the
> controller after fencing finishes instead of using error recovery.
> This way everything lives in core.c. But I have not tested that.
> 
> Do you think this is better than what has been implemented now?
> 
Yeah, the eternal problem.
At one point someone will have to explain to my why 'reset' and
'error handling' are two _distinct_ code paths in nvme-tcp.
I really don't get that. I _guess_ it's trying to hold requests
when doing a reset, and aborting requests if it's an error.
But why one needs to make that distinction is a mystery to
me; FC combines both paths and seems to work quite happily.

Thing is, that will get in the way when trying to move fencing
into the generic layer; you only can call 'nvme_reset_ctrl()',
and hope that this one will abort commands.

I'll check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

