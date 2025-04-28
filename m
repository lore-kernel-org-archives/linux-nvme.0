Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4AFC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKCfsUSiVgaMGLYlRKMuDqRi+jxJnou69nt3LDKwSkY=; b=1vEeNyV4ZxnIKlj2csnAN5Nw7F
	a/bceGg4nEbiT/ir0gHtxz70DIhn9vyP2zC/v0Dt5PTlb5qW/5P56zd7Rl/xCOKBVzoV+svFcyBLA
	XI8nv3TQAQJFAByANuDZdw+HcDqGRCDr6XyTRMb5bXRBh1QD301wRRRtwf0SMtpforBGnzf+pYT9D
	z1rasf7zEiGRq0PSQzFnJuDIl3cfxDNsUnL6uzDnjyHi0HQsHzPH5qCSMZx+7YjiZ8DZ+BLBsrd5M
	5IvsP/tUXyOnSljbywQfA5iV5OVs6sYSihmyAJzRDegyWc8Gc+VvM58er5O7CQZkNgNlA/n6qfLwh
	OGSSC07w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Op8-00000006WxW-09Tv;
	Mon, 28 Apr 2025 13:47:06 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9OQD-00000006RuR-0e8O
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 13:21:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 332161F390;
	Mon, 28 Apr 2025 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745846479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKCfsUSiVgaMGLYlRKMuDqRi+jxJnou69nt3LDKwSkY=;
	b=dFdSM1hXoQ/DErZ4LG7lSkry0rA/fgCYFkaoBc2RiJf4m1k+EEmCspgKpu6/C+YaRlExAX
	HV+7xysk2dNcMbQTsn4YhrXZAHD5sS4ZSSOUcRJKvjV/pfIIyMQBOHPBr43t8fsJGhrzti
	eoR/1FINAXmDDzdd+fsX2FNuemi2YHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745846479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKCfsUSiVgaMGLYlRKMuDqRi+jxJnou69nt3LDKwSkY=;
	b=Ds0IHOTwBrmtL9+kBlcqWdlfdH0ryq2b4FpcVnfjdrwA0NaRod110CF8WThug4H3+eBr+s
	NM4y6ImOwJvap4Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745846479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKCfsUSiVgaMGLYlRKMuDqRi+jxJnou69nt3LDKwSkY=;
	b=dFdSM1hXoQ/DErZ4LG7lSkry0rA/fgCYFkaoBc2RiJf4m1k+EEmCspgKpu6/C+YaRlExAX
	HV+7xysk2dNcMbQTsn4YhrXZAHD5sS4ZSSOUcRJKvjV/pfIIyMQBOHPBr43t8fsJGhrzti
	eoR/1FINAXmDDzdd+fsX2FNuemi2YHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745846479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKCfsUSiVgaMGLYlRKMuDqRi+jxJnou69nt3LDKwSkY=;
	b=Ds0IHOTwBrmtL9+kBlcqWdlfdH0ryq2b4FpcVnfjdrwA0NaRod110CF8WThug4H3+eBr+s
	NM4y6ImOwJvap4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12A7113A25;
	Mon, 28 Apr 2025 13:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id blcPBM+AD2ikYAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 28 Apr 2025 13:21:19 +0000
Message-ID: <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
Date: Mon, 28 Apr 2025 15:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <dwagner@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_062121_340461_3EE5923F 
X-CRM114-Status: GOOD (  26.67  )
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

On 4/28/25 14:44, Daniel Wagner wrote:
> On Sun, Apr 27, 2025 at 08:59:13AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Fri, Feb 14, 2025 at 09:02:03AM +0100, Daniel Wagner wrote:
>>> The fabric transports and also the PCI transport are not entering the
>>> LIVE state from NEW or RESETTING. This makes the state machine more
>>> restrictive and allows to catch not supported state transitions, e.g.
>>> directly switching from RESETTING to LIVE.
>>>
>>> Signed-off-by: Daniel Wagner <wagi@kernel.org>
>>
>> nvme_handle_aen_notice(), when handling NVME_AER_NOTICE_FW_ACT_STARTING,
>> sets the state to RESETTING and and triggers a worker. This worker
>> waits for firmware activation to complete and then tries to set the
>> state back to LIVE. This step now fails.
>>
>> Possibly the handling of NVME_AER_NOTICE_FW_ACT_STARTING needs to be
>> improved. However, leaving the NVME in RESETTING state after an
>> NVME_AER_NOTICE_FW_ACT_STARTING event is worse.
>>
>> I think this patch should be reverted at least for the time being until
>> the handling of NVME_AER_NOTICE_FW_ACT_STARTING no longer relies on a
>> direct state change from RESETTING to LIVE.
> 
> ee59e3820ca9 ("nvme-fc: do not ignore connectivity loss during connecting")
> f13409bb3f91 ("nvme-fc: rely on state transitions to handle connectivity loss")
> 
> are depending on the fact that is not possible to switch from
> NEW/RESETTING directly into LIVE.
> 
> I think it would be better to fix the worker instead dropping this patch
> and the above fix for the fc transport.
> 
> What about:
> 
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b502ac07483b..d3c4eacf607f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>                  msleep(100);
>          }
> 
> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>                  return;
> 
>          nvme_unquiesce_io_queues(ctrl);

I would rather have a separate state for firmware activation.
(Ab-)using the 'RESETTING' state here has direct implications
with the error handler, as for the error handler 'RESETTING'
means that the error handler has been scheduled.
Which is not true for firmware activation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

