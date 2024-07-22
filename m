Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FEDC3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 06:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xTh7pzPxMK1qvGIHC6bAoFoomXYJuqdZP/9z2544xWY=; b=T56vABhK2OKa9BtLY06lGoyES6
	mc91WpZQa2pU3k3QEvODBRaJrQUNRa2KSNIWlUHKJm8PFTgSxGO08S74E545Sk2TCXs6kssdR6fWK
	2dai6hcGEYKgxtXZblGvasjYk1qos7l0UsD2vBFbFOAp40TUMWn9NaZYhkDyn10toFwAk3ZSSM9lJ
	GVtzZ47bgaW1HjTyTmOLveXIdFS0Sm80+uRI8xk/6GLZbZSrjj4ptjbuYb8eZxJAU02W2ESaoy3Nf
	msqzQCYG3E4eZdCWio/VKTOC0pB618Q/tir/4r/EQGX7hHaCrXhjWAD5Idspg2Ml7lzxrFvBfoT4U
	f1tKFRmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVmTm-00000008VJS-0KBG;
	Mon, 22 Jul 2024 06:25:02 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVmTh-00000008VI6-0MGe
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 06:25:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CB751FB5C;
	Mon, 22 Jul 2024 06:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721629494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTh7pzPxMK1qvGIHC6bAoFoomXYJuqdZP/9z2544xWY=;
	b=UXvAPl6vRLmTnYsHqxajqEr5hzV8ooFnUGh5MMdUnSGoefGj2M0EERnPdyCxoW0nd8ghNm
	JsnQg1xsO4qCF1oa2/UX+CO5z8BFbAuugpFiF5j5MDUz2qVT5gu9a2DvQYMtgmV+m3Gw+/
	0pPn84awHa6KTMwjXahYHwbdEXhMjcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721629494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTh7pzPxMK1qvGIHC6bAoFoomXYJuqdZP/9z2544xWY=;
	b=yybXUDq6Pkdv3N1g4RwfcdGBP72fnD6G7gAxpmUOYiyLb0Ue7o82HizZofUJOD0o+IeBHc
	9GzGX3eYbxkPzDBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UXvAPl6v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yybXUDq6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721629494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTh7pzPxMK1qvGIHC6bAoFoomXYJuqdZP/9z2544xWY=;
	b=UXvAPl6vRLmTnYsHqxajqEr5hzV8ooFnUGh5MMdUnSGoefGj2M0EERnPdyCxoW0nd8ghNm
	JsnQg1xsO4qCF1oa2/UX+CO5z8BFbAuugpFiF5j5MDUz2qVT5gu9a2DvQYMtgmV+m3Gw+/
	0pPn84awHa6KTMwjXahYHwbdEXhMjcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721629494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTh7pzPxMK1qvGIHC6bAoFoomXYJuqdZP/9z2544xWY=;
	b=yybXUDq6Pkdv3N1g4RwfcdGBP72fnD6G7gAxpmUOYiyLb0Ue7o82HizZofUJOD0o+IeBHc
	9GzGX3eYbxkPzDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D511B136A9;
	Mon, 22 Jul 2024 06:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fRlwMTX7nWbHNgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Jul 2024 06:24:53 +0000
Message-ID: <5491cbc2-8b1a-40be-9ba7-ef965169106c@suse.de>
Date: Mon, 22 Jul 2024 08:24:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] nvme-tcp: sanitize TLS key handling
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240719083901.35399-1-hare@kernel.org>
 <20240719083901.35399-3-hare@kernel.org>
 <e8ddc060-f35a-4b3a-b09c-7c3168026d13@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e8ddc060-f35a-4b3a-b09c-7c3168026d13@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2CB751FB5C
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_232457_302948_809FAA5B 
X-CRM114-Status: GOOD (  16.85  )
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

On 7/21/24 13:14, Sagi Grimberg wrote:
> 
> 
> 
> On 19/07/2024 11:38, Hannes Reinecke wrote:
>> There is a difference between TLS configured (ie the user has
>> provisioned/requested a key) and TLS enabled (ie the connection
>> is encrypted with TLS). This becomes important for secure concatenation,
>> where the initial authentication is run on an unencrypted connection
>> (ie with TLS configured, but not enabled), and then the queue is reset to
>> run over TLS (ie TLS configured _and_ enabled).
>> So to differentiate between those two states store the generated
>> key in opts->tls_key (as we're using the same TLS key for all queues),
>> the key serial of the resulting TLS handshake in ctrl->tls_pskid
>> (to signal that TLS on the admin queue is enabled), and a simple
>> flag for the queues to indicated that TLS has been enabled.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/core.c  |  1 -
>>   drivers/nvme/host/nvme.h  |  2 +-
>>   drivers/nvme/host/sysfs.c |  4 ++--
>>   drivers/nvme/host/tcp.c   | 47 ++++++++++++++++++++++++++++-----------
>>   4 files changed, 37 insertions(+), 17 deletions(-)
>>
[ .. ]
>> @@ -213,7 +214,15 @@ static inline int nvme_tcp_queue_id(struct 
>> nvme_tcp_queue *queue)
>>       return queue - queue->ctrl->queues;
>>   }
>> -static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
>> +static inline bool nvme_tcp_tls_enabled(struct nvme_tcp_queue *queue)
>> +{
>> +    if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>> +        return 0;
>> +
>> +    return queue->tls_enabled;
>> +}
> 
> One suggestion.
> 
> Can we call it:
> nvme_tcp_queue_tls() ? It will first clarify that this is a queue level 
> setting,
> and will disambiguate (at least for me) the difference from 
> nvme_tcp_tls_configured().

Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


