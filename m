Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3514CC3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 06:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6Ikcbx5OVWWHOwBZUMpvbOiArTNnAI3UCayANeHQFw=; b=2r6whd20CgbHCZJLwVeLa8Lw/7
	QbJsReP6y+1KooiuqMvR4rAZ6BS+MDoEGCjiWwnUbQ5WJWx4JTiutvJdz8n6guBS4NFdxepJWgKoq
	Z8VfdIp53S0PS6x5DVF9eKoAbSN/2jcMhQK8QCu7vD4eYem6/RJwilOv4u/RfdTn9PbnYOkJj9AWb
	qIK43KSGsRc17NP4d1T7M6D8HovH9JU2cYIdtM5sJkmMpAYO/BugU4Pu3x+I6FOsg3stLb6TiEruA
	wyPqE/LqwIdfEq13fnb3B389PfKfTV64co5XYRN+amtGjWnffloPgQq9Ffm/JaOoGSCSPiqWML4O0
	LDJslVbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPGMU-007wJA-2l;
	Mon, 15 Jan 2024 06:22:18 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPGMS-007wFV-0y
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 06:22:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FDEF1F85D;
	Mon, 15 Jan 2024 06:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705299725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6Ikcbx5OVWWHOwBZUMpvbOiArTNnAI3UCayANeHQFw=;
	b=SkQNezOJltxdrnzPk03Z+95R7ZJad1Ffeaq0HruhuBkQz2EwadkPSDIV9l3ZSXvROj6C/m
	3Vk/1PMCnvSWCRnXimzF1wBXn3bIZ+IPiddAAraw1ZzBiU6A7qV+hfeYV807Icy9O83zNN
	F7niNRrGqzjFlOhDlg0CnrdBlMaa4ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705299725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6Ikcbx5OVWWHOwBZUMpvbOiArTNnAI3UCayANeHQFw=;
	b=34fiyj6zqpjlt926n9yQz9JIRLI2Y6ZF76/MMXciCX4Pgfw9i545yJBRPVZyfvUODf8tjN
	nxekZel1lvhcK+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705299723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6Ikcbx5OVWWHOwBZUMpvbOiArTNnAI3UCayANeHQFw=;
	b=NbnSvudqxJVGdfOKaRsqRK7m9ljy/Ubsc4M2LFsaaWkIFxjbuKDMlVdMFf1Jng6vppSFHU
	En45X2JigUGIv65uKnEeOmQhXFWurFsLZl8x0kfy1RSBnnMKsSuGCbNXAkfHy3KoB/vke4
	7U7/0INl4lpn422REDDYoLSBj1Y+tN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705299723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6Ikcbx5OVWWHOwBZUMpvbOiArTNnAI3UCayANeHQFw=;
	b=//Dp3uKqbj9GnfzTEPXnTbCL116sDaiqnHCq49qD+QADdmwfDc8OnTb6XNDD7SNdSngiLN
	i0uzI870uoECvHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39315132FA;
	Mon, 15 Jan 2024 06:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1I7uCwvPpGWhZAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Jan 2024 06:22:03 +0000
Message-ID: <9c13a4f8-4b3a-4719-97eb-56167f5d0456@suse.de>
Date: Mon, 15 Jan 2024 07:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Do not terminate i/o commands during
 RESETTING
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240112100907.80765-1-hare@kernel.org>
 <8292c439-4ac1-4ccb-9c18-71d55fbc57e2@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8292c439-4ac1-4ccb-9c18-71d55fbc57e2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240114_222216_521236_890EE912 
X-CRM114-Status: GOOD (  17.93  )
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

On 1/14/24 03:53, Max Gurtovoy wrote:
> Hi Hannes,
> 
> On 12/01/2024 12:09, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Terminating commands from the timeout handler might lead
>> to a data corruption as the timeout might trigger before
>> KATO expired.
> 
> Can you please explain the data corruption and how this patch is fixing 
> it ?
> 
It's like this:
n: connection breaks
n + 1: send command 1,2,3, tmo 30s
n + 2: send keep-alive, tmo 30s
n + 31: command timeout
  - command 1 timeout:
    queue error recovery workqueue,
    return BLK_EH_RESET_TIMER
  - command 2 timeout:
    abort command
    retry command
  - start error recovery workqueue, abort command 1&3
n + 32: KATO expires, commands are retried

Now command 2 was aborted directly, and will be retried
on a different path without waiting for KATO.
So command 2 will be sent to the controller while the controller
is not aware that a KATO timeout had happened.
This not only violates the spec (which states that we should only
retry commands after a KATO timeout happened), but there are
some controller implementations which need to clear up internal
state once KATO triggered. And on those implementations we see
a data corruption.

As discussed elsewhere these controllers really should be implement
CQAT, but that is no excuse for us violating the spec.

>> When several commands have been sent in a batch and
>> the command timeouts trigger just after the keep-alive
>> command has been sent then the first command will trigger
>> the error recovery. But all other commands will timeout
>> directly afterwards and will hit the timeout handler
>> before the err_work workqueue handler has started.
>> This results in these commands being aborted and
>> immediately retried without waiting for KATO.
>> So return BLK_EH_RESET_TIMER for I/O commands when
>> the controller is in 'RESETTING' or 'DELETING'
>> state to ensure that the commands will
>> be retried only after the KATO interval.
> 
> I'm not sure I understand how does KATO and reconnect_delay are related ?
> 
Not sure I'm following; reconnection delay doesn't come into it...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


