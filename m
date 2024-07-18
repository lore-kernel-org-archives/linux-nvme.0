Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B37FC3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SdeTWlHgqldcOwD/iVPHZSwa7mrgxWCOkW0o75+uSc=; b=v7X/g7fAJ5tR9u4PSjUelHP08Y
	IqDa27FFQ/Ue2qGqCtgvY8nGy5JMU1wabBknWa/wrn3+I2jWLp8SKGcheUftO+3PO5hmxt/4Y4NXb
	baw/967qqH5j65KIjTMix/Wb4r4x2Ew0Q+I7Xo6mfyvFNENmuLOLwSpAMyL9xxrG4Txi9mEqJ9eSb
	Z+Mu7tXiShDfXCAbdttzgGGE+zSsRA+lny8R89YIsKGaw+U99JVAhsyATUYyVpBM3P834xySB+Kat
	7E8lqmn9frrYBUCFPMJ/zP6wNaBPQDj1q6/WQ6sRasOEyuLaAqUIrmz3isg47YYBu2e/ybU+hIJiw
	0Qzag9/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULI5-0000000G7RE-2Zp2;
	Thu, 18 Jul 2024 07:11:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULI1-0000000G7Px-0QtO
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 07:11:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98B071FBAD;
	Thu, 18 Jul 2024 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721286655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SdeTWlHgqldcOwD/iVPHZSwa7mrgxWCOkW0o75+uSc=;
	b=yJLiU9d9wCj/9YV43l1JLWktW8qC+8+KZDdrhyTC8wKgnBkOgrqUrYoOOopZGcb1iOxM0b
	fzjhxAlE0rfFTOgNYJdJD2uzRDGQkjbU3p6OLxD6qOaXCHyvOzyO1aIZ26g9Ptcq0aJ1YY
	+Gvp6g6wTpRcDeEx4WCJKhOANZ85uIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721286655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SdeTWlHgqldcOwD/iVPHZSwa7mrgxWCOkW0o75+uSc=;
	b=z/mE1ogNVVrHxWlfqpxv9K2g8kEwqlBa2Kn7Z1K2Yg9NRmfs7YtbOM36UAtzHGdeHqIaFV
	7Z601Ydzg3O4SQAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yJLiU9d9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="z/mE1ogN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721286655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SdeTWlHgqldcOwD/iVPHZSwa7mrgxWCOkW0o75+uSc=;
	b=yJLiU9d9wCj/9YV43l1JLWktW8qC+8+KZDdrhyTC8wKgnBkOgrqUrYoOOopZGcb1iOxM0b
	fzjhxAlE0rfFTOgNYJdJD2uzRDGQkjbU3p6OLxD6qOaXCHyvOzyO1aIZ26g9Ptcq0aJ1YY
	+Gvp6g6wTpRcDeEx4WCJKhOANZ85uIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721286655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SdeTWlHgqldcOwD/iVPHZSwa7mrgxWCOkW0o75+uSc=;
	b=z/mE1ogNVVrHxWlfqpxv9K2g8kEwqlBa2Kn7Z1K2Yg9NRmfs7YtbOM36UAtzHGdeHqIaFV
	7Z601Ydzg3O4SQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60DE2136F7;
	Thu, 18 Jul 2024 07:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eYc0FP+/mGbrCwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 07:10:55 +0000
Message-ID: <5afb5554-2dd1-4261-8d11-9e1372df430e@suse.de>
Date: Thu, 18 Jul 2024 09:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] nvme-tcp: sanitize TLS key handling
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-3-hare@kernel.org>
 <715ffc48-cd34-4776-a51a-e1199b8d0435@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <715ffc48-cd34-4776-a51a-e1199b8d0435@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 98B071FBAD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_001057_321627_91404481 
X-CRM114-Status: GOOD (  19.32  )
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

On 7/17/24 23:53, Sagi Grimberg wrote:
> 
> 
> On 17/07/2024 12:10, Hannes Reinecke wrote:
>> There is a difference between TLS configured (ie the user has
>> provisioned/requested a key) and TLS enabled (ie the connection
>> is encrypted with TLS). This becomes important for secure concatenation,
>> where the initial authentication is run unencrypted (ie with
>> TLS configured, but not enabled), and then the queue is reset to
>> run over TLS (ie TLS configured _and_ enabled).
>> So to differentiate between those two states store the provisioned
>> key in opts->tls_key (as we're using the same TLS key for all queues)
>> and only the key serial of the key negotiated by the TLS handshake
>> in queue->tls_pskid.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/core.c  |  1 -
>>   drivers/nvme/host/nvme.h  |  2 +-
>>   drivers/nvme/host/sysfs.c |  4 ++--
>>   drivers/nvme/host/tcp.c   | 47 ++++++++++++++++++++++++++++-----------
>>   4 files changed, 37 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 8d8e7a3549c6..947f1e631ee5 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4641,7 +4641,6 @@ static void nvme_free_ctrl(struct device *dev)
>>       if (!subsys || ctrl->instance != subsys->instance)
>>           ida_free(&nvme_instance_ida, ctrl->instance);
>> -    key_put(ctrl->tls_key);
>>       nvme_free_cels(ctrl);
>>       nvme_mpath_uninit(ctrl);
>>       cleanup_srcu_struct(&ctrl->srcu);
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index c63f2b452369..cdb53323f4eb 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -370,7 +370,7 @@ struct nvme_ctrl {
>>       struct nvme_dhchap_key *ctrl_key;
>>       u16 transaction;
>>   #endif
>> -    struct key *tls_key;
>> +    key_serial_t tls_pskid;
>>       /* Power saving configuration */
>>       u64 ps_max_latency_us;
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 3c55f7edd181..5b1dee8a66ef 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -671,9 +671,9 @@ static ssize_t tls_key_show(struct device *dev,
>>   {
>>       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> -    if (!ctrl->tls_key)
>> +    if (!ctrl->tls_pskid)
>>           return 0;
>> -    return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>> +    return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
>>   }
>>   static DEVICE_ATTR_RO(tls_key);
>>   #endif
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index a2a47d3ab99f..92ad5b8cc1b4 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -165,6 +165,7 @@ struct nvme_tcp_queue {
>>       bool            hdr_digest;
>>       bool            data_digest;
>> +    bool            tls_enabled;
> 
> I swear I'll ask this every single time that I don't understand it. Why 
> is this per-queue and
> not per controller?

TLS is a per-queue setting (each queue has it's own TCP connection, and 
that connection might or might not have TLS enabled), _and_, more 
importantly, it's a queue _status_ (ie the queue is TLS enabled), and
set ex-post _after_ TLS handshake is run.

This is to differentiate against the TLS _configuration_ (ie the option
'--tls'), which is indeed per controller, but is the _intention_ to 
enable TLS.

The distinction becomes important for secure concatenation, as there
one can have an admin queue where TLS should be enabled (the 
configuration setting), but currently is not as authentication is 
ongoing (the status), then a reset of the admin queue, at the end
of which TLS is enabled (the status).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


