Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92316CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CRiMn9HGQHar2JLKyD7IJYMtYyXkOjvYg0jyuEEe8FM=; b=pvbqh8OqI8eoJf8/rGfmY6r/IG
	oQTq9Hf85OAt91TQ38J9DdgR3yLHoDuHjQbTK0G3ZHoP2bc76Hv2sxhk2N09oO+g99erUKwOt5aUO
	J3FSWqiD6P0CEwFQTxStGryBJ8hHljikKAEtzqGvgTNlOvKoNrOO8q+MIimz1F/UAa7XIllxkYQBi
	wF20fa7tRorWXAXtomC2TOaJDp081Cf4nkacrUiUzfdtfWUQzaVanVW5dUFReuaFJ+H9hXWiNtCNO
	gBoXdVsX7FtIi34JIUhYlD1y/AQ8bKpcE6R/mz3vtOhVB4u58Zths7Tq+cIAOCnnT4SKP+HocPq5b
	JZ21hERw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBax-0000000528o-07aM;
	Mon, 15 Sep 2025 15:58:23 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBau-0000000528R-24R6
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 15:58:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CFE21FB40;
	Mon, 15 Sep 2025 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757951898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRiMn9HGQHar2JLKyD7IJYMtYyXkOjvYg0jyuEEe8FM=;
	b=aL3Hp5/99TplLw5YE1vSRkIjKNR12WV98a72YK7aRFU92hxuroYo7iYthCK8RksO6WcCSk
	DKcma0To5p6pQZstN/gSboR0Kq6gvS05FOtVYCtYglGeao5m0GkytazUWpz84EFiilw2Hl
	mp2kerRKjI1DQGVmG+O92wduz9f7QJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757951898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRiMn9HGQHar2JLKyD7IJYMtYyXkOjvYg0jyuEEe8FM=;
	b=c5iU+RPy5cL1wey9XdwgMlU8bR2wUK5TaO194Q5f/R9nd1eV1ap8b9DfGROk+HE+rDEzRu
	EohJ+yTQUwUqAhBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="aL3Hp5/9";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c5iU+RPy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757951898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRiMn9HGQHar2JLKyD7IJYMtYyXkOjvYg0jyuEEe8FM=;
	b=aL3Hp5/99TplLw5YE1vSRkIjKNR12WV98a72YK7aRFU92hxuroYo7iYthCK8RksO6WcCSk
	DKcma0To5p6pQZstN/gSboR0Kq6gvS05FOtVYCtYglGeao5m0GkytazUWpz84EFiilw2Hl
	mp2kerRKjI1DQGVmG+O92wduz9f7QJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757951898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRiMn9HGQHar2JLKyD7IJYMtYyXkOjvYg0jyuEEe8FM=;
	b=c5iU+RPy5cL1wey9XdwgMlU8bR2wUK5TaO194Q5f/R9nd1eV1ap8b9DfGROk+HE+rDEzRu
	EohJ+yTQUwUqAhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D5A41372E;
	Mon, 15 Sep 2025 15:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4SBsBZo3yGjZCQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Sep 2025 15:58:18 +0000
Message-ID: <2442c00d-8080-4404-92d4-0bb98e977184@suse.de>
Date: Mon, 15 Sep 2025 17:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: send only permitted commands for secure concat
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org,
 pnayak@netapp.com, prashana@netapp.com
References: <20250909103509.10343-1-marting@netapp.com>
 <1f7cd5e4-45f0-40cb-ab6a-6936a5062ae0@suse.de>
 <ee638169c6fd15b448449e7dbe3d8aacaf7fc093.camel@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ee638169c6fd15b448449e7dbe3d8aacaf7fc093.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CFE21FB40
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_085820_829920_F44CD8E6 
X-CRM114-Status: GOOD (  25.48  )
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

On 9/11/25 15:07, Martin George wrote:
> On Wed, 2025-09-10 at 14:58 +0200, Hannes Reinecke wrote:
>> On 9/9/25 12:35, Martin George wrote:
>>> In addition to sending permitted commands such as connect/auth
>>> over the initial unencrypted admin connection as part of secure
>>> channel concatenation, the host also sends commands such as
>>> Property Get and Identify on the same. This is a spec violation
>>> leading to secure concat failures. Fix this by ensuring these
>>> additional commands are avoided on this connection.
>>>
>>> Fixes: 104d0e2f6222 ("nvme-fabrics: reset admin connection for
>>> secure concatenation")
>>> Signed-off-by: Martin George <marting@netapp.com>
>>> ---
>>>    drivers/nvme/host/tcp.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index c0fe8cfb7229..1413788ca7d5 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -2250,6 +2250,9 @@ static int
>>> nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>>>    	if (error)
>>>    		goto out_cleanup_tagset;
>>>    
>>> +	if (ctrl->opts->concat && !ctrl->tls_pskid)
>>> +		return 0;
>>> +
>>>    	error = nvme_enable_ctrl(ctrl);
>>>    	if (error)
>>>    		goto out_stop_queue;
>>
>> Hmm. Not sure. While section 8.3.4.3 'NVMe In-band Authentication'
>> states:
>>
>>    If one or more of the bits in the AUTHREQ field are set to ‘1’,
>> then
>>    the controller requires that the host authenticate on that queue in
>>    order to proceed with Fabrics, Admin, and I/O commands.
>>
>>   From which one could assume that none of the commands are allowed.
>> But it then goes on to state:
>>
>>    The state of an in-progress authentication transaction is soft-
>> state.
>>    If the subsequent command in an authentication transaction is not
>>    received by the controller within a timeout equal to:
>>     * the Keep Alive Timeout value (refer to Figure 546), if the Keep
>>       Alive Timer is enabled; or
>>     * the default Keep Alive Timeout value (i.e., two minutes), if the
>>       Keep Alive Timer is disabled;
>>
>> one can imply that KATO is running during authentication
>> transactions.
>> But that might require additional commands, so really I'm not sure.
>> Let me ask FMDS for clarification.
>>
> 
> This is specific to secure concat alone, and not otherwise.
> 
> NVMe base spec 2.1 section 8.3.4.1 Fabric Secure Channel states that
> "An NVM subsystem that requires use of a fabric secure channel (i.e.,
> as indicated by the TSC field in the associated Discovery Log Page
> Entry) shall not allow capsules to be transferred until a secure
> channel has been established for the NVMe Transport connection."
> 
> And again in section 8.3.4.3 Secure Channel Concatenation, "This PSK is
> generated by an authentication transaction on an Admin Queue over an
> unsecure channel. Once the authentication transaction is completed,
> that Admin Queue transport connection shall be disconnected by the
> host. The generated PSK may then be used to set up secure channels for
> subsequent Admin Queue(s) and I/O Queues."
> 
> So once authentication is completed on the unencrypted admin connection
> as part of secure concat, the host is expected to immediately
> disconnect from that and then proceed with setting up subsequent
> encrypted admin & I/O connections i.e. no reason for the host to
> continue with nvme_enable_ctrl() & nvme_init_ctrl_finish() on the
> initial unsecure connection as that's futile and doesn't serve any
> purpose. And that's what this patch is attempting to do above.
> 
Right you are.
I stand corrected.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

