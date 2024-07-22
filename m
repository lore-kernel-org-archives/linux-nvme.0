Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B8EC3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MGPAaW5uu403lkq3IL2g2pt7ZUp9PwiaCnI6WD+LxbE=; b=X6OMW3yz6oOp4T0gucTz8ftooj
	CVUjFa9brsHta2MLcjqxAAZGuh1uEj9K+7KImgLPbq3s/XnBAWdW+ue49aiZ1y8II8wmDuzZJFDVd
	Mb6niwDCBtFK5+MBQc9NskF9zjQFUd590gO+gIxUysbdW/exTgbIB/Q5+I/PpJo9e+aQxtlX1NFj7
	4HZihTCthPmFY++Fe3J/INOYQadgSL0qybDqnMyX6Q8iHTZt57X+T+L5+TLqSDy4q3wiaURkY1p7O
	ATOgedaJLL6Qa1mUgP/fw+0jcE0D8LdEWbTcZhjbR+YOvrNAFzAFH2jAbjQ172J2kCC2t+OmFsQGE
	SiCyzkCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVodm-00000008vcc-3RST;
	Mon, 22 Jul 2024 08:43:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVodg-00000008vaO-0nyy
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 08:43:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8450E1FB57;
	Mon, 22 Jul 2024 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721637802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGPAaW5uu403lkq3IL2g2pt7ZUp9PwiaCnI6WD+LxbE=;
	b=KSIPNbzkpF8+JODt2uZu89CNbzLgeP7fQ2b8LQYW8x5j76qHZdLKBlb+NQBk11YGT0Exxx
	jRkcEbWFtXBYokUTkeBMByMRfvD3+N+i1IAwXDNW6kZnMcjrS2HCKG3JIqSzIYr3qD5WiA
	F06aN6Kul3TKrewZQ4/E+Fe9b/IE1eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721637802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGPAaW5uu403lkq3IL2g2pt7ZUp9PwiaCnI6WD+LxbE=;
	b=4UGacyRt+Xo8NpH1RJ5hjvmDUIESdOem7kuGURxoIVs6PfrXN5dWZ6k02VVbQjX2JcQpNS
	3CZ1N0hw90hWS+Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721637802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGPAaW5uu403lkq3IL2g2pt7ZUp9PwiaCnI6WD+LxbE=;
	b=KSIPNbzkpF8+JODt2uZu89CNbzLgeP7fQ2b8LQYW8x5j76qHZdLKBlb+NQBk11YGT0Exxx
	jRkcEbWFtXBYokUTkeBMByMRfvD3+N+i1IAwXDNW6kZnMcjrS2HCKG3JIqSzIYr3qD5WiA
	F06aN6Kul3TKrewZQ4/E+Fe9b/IE1eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721637802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGPAaW5uu403lkq3IL2g2pt7ZUp9PwiaCnI6WD+LxbE=;
	b=4UGacyRt+Xo8NpH1RJ5hjvmDUIESdOem7kuGURxoIVs6PfrXN5dWZ6k02VVbQjX2JcQpNS
	3CZ1N0hw90hWS+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FDD5136A9;
	Mon, 22 Jul 2024 08:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PubFqobnmZvXwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Jul 2024 08:43:22 +0000
Message-ID: <5b570d03-f2d5-4be8-8337-3922fce9cd6a@suse.de>
Date: Mon, 22 Jul 2024 10:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: request secure channel concatenation
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240718150658.99580-1-hare@kernel.org>
 <20240718150658.99580-7-hare@kernel.org>
 <271ab7cc-d766-4527-805f-a20107998beb@grimberg.me>
 <d9a1f599-eea8-4069-8f95-3778280010e5@suse.de>
Content-Language: en-US
In-Reply-To: <d9a1f599-eea8-4069-8f95-3778280010e5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_014324_402173_45FDC1B0 
X-CRM114-Status: GOOD (  13.52  )
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

On 7/22/24 08:36, Hannes Reinecke wrote:
> On 7/21/24 13:27, Sagi Grimberg wrote:
>>
>>
>>
>> On 18/07/2024 18:06, Hannes Reinecke wrote:
>>> Add a fabrics option 'concat' to request secure channel concatenation.
>>> When secure channel concatenation is enabled a 'generated PSK' is 
>>> inserted
>>> into the keyring such that it's available after reset.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/auth.c    | 100 ++++++++++++++++++++++++++++++++++--
>>>   drivers/nvme/host/fabrics.c |  34 ++++++++++--
>>>   drivers/nvme/host/fabrics.h |   3 ++
>>>   drivers/nvme/host/tcp.c     |  56 +++++++++++++++++---
>>>   include/linux/nvme.h        |   7 +++
>>>   5 files changed, 188 insertions(+), 12 deletions(-)
>>>
[ .. ]
>>> +
>>>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>>>   {
>>>       struct nvmf_ctrl_options *opts = ctrl->opts;
>>> @@ -2308,6 +2348,8 @@ static void nvme_tcp_error_recovery_work(struct 
>>> work_struct *work)
>>>                   struct nvme_tcp_ctrl, err_work);
>>>       struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>> +    if (nvme_tcp_key_revoke_needed(ctrl))
>>> +        nvme_tcp_revoke_tls_key(ctrl);
>>
>> Should this maybe move to nvme_tcp_teardown_admin_qeueue ?
>>
> 
> Good point, will do.
> 
Actually, no.

That's precisely where we _cannot_ do it.
(Cf patch to reset the admin queue for secure concatenation).
We have three stages during secure concatenation:
1. authentication:
    ctrl->opts->concat = true, ctrl->opts->tls_key = NULL
    queue->tls_enabled = false
2. reset after authentication:
    ctrl->opts->concat = true, ctrl->opts->tls_key = <set>
    queue->tls_enabled = false
3. TLS enabled on the queue:
    ctrl->opts->concat = true, ctrl->opts->tls_key = <set>
    queue->tls_enabled = true

As we are calling 'nvme_teardown_admin_queue' in step 2)
we cannot clear the tls_key in that function.

Cheers,

Hannes
>>>       nvme_stop_keep_alive(ctrl);
>>>       flush_work(&ctrl->async_event_work);
>>>       nvme_tcp_teardown_io_queues(ctrl, false);
>>> @@ -2348,6 +2390,8 @@ static void nvme_reset_ctrl_work(struct 
>>> work_struct *work)
>>>           container_of(work, struct nvme_ctrl, reset_work);
>>>       int ret;
>>> +    if (nvme_tcp_key_revoke_needed(ctrl))
>>> +        nvme_tcp_revoke_tls_key(ctrl);
>>
>> Would eliminate this call...
> 
> Cheers,
> 
> Hannes

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


