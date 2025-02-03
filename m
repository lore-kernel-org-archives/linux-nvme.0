Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7F2C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwNfS/elvuC6TTEF9w98uKIzUZONTtcMv0uY0+FelKo=; b=RcLXqt0Gp5tZT9KvYwvNTHGqYY
	ckSWAt/qq9xWFaRobQLZdlpzKLoCaR8xW8PNvIrQcxYxcxbxt8KGpApdzVFSTRCy57Oetfu7qJQVR
	XgCzxn0DQTaFm7UgtpXK4IX3wKkmhMUPMxZwotzyZU3kg5hshH699wh1vF6K7boOA2e1WVlQaJRRD
	uHC383csyQZQBkADbVYGxQHiuL6FZDNLZQFWh0Wo/vXt/ievFkd8F0nI47Tg/w9EwEKjpZ447PA3e
	leZjTJA1gqUfQDm64diown3UPMShfINaVQgZdiDHnhGOlHELdtG0v+UDEr57Gz80rx8KPTJdJnQLb
	u2pLBgeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1texJm-0000000FeE4-18RJ;
	Mon, 03 Feb 2025 14:20:54 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1texJi-0000000FeCX-3njw
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 14:20:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 328021F391;
	Mon,  3 Feb 2025 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738592449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwNfS/elvuC6TTEF9w98uKIzUZONTtcMv0uY0+FelKo=;
	b=zfuGkVDpfNbwGGN7DydJ9zHfHyKrF4wkBNiPRe1E3TjzzoKU5kdz5DNY6Fx0pIL46QxlPh
	FHWji2FC/FkzbpACg3G1jGRH2JQDsXO8B332vV84UrwHHemHWTFjGS2f3C+gIoKJi/KVVw
	t9oUAhTlBrVtkpU8YeCpsjuEzBdKLhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738592449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwNfS/elvuC6TTEF9w98uKIzUZONTtcMv0uY0+FelKo=;
	b=bxpVxiswxeO4PkoSWQPrU0kwHQ2N7DFvBAKHtT/lhJGQ29c/eB/KweJ93Uoz7ctJiaRVZO
	ogzd9aZjyGaWOKBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zfuGkVDp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bxpVxisw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738592449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwNfS/elvuC6TTEF9w98uKIzUZONTtcMv0uY0+FelKo=;
	b=zfuGkVDpfNbwGGN7DydJ9zHfHyKrF4wkBNiPRe1E3TjzzoKU5kdz5DNY6Fx0pIL46QxlPh
	FHWji2FC/FkzbpACg3G1jGRH2JQDsXO8B332vV84UrwHHemHWTFjGS2f3C+gIoKJi/KVVw
	t9oUAhTlBrVtkpU8YeCpsjuEzBdKLhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738592449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwNfS/elvuC6TTEF9w98uKIzUZONTtcMv0uY0+FelKo=;
	b=bxpVxiswxeO4PkoSWQPrU0kwHQ2N7DFvBAKHtT/lhJGQ29c/eB/KweJ93Uoz7ctJiaRVZO
	ogzd9aZjyGaWOKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1587113795;
	Mon,  3 Feb 2025 14:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lbV3BMHQoGeaQQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Feb 2025 14:20:49 +0000
Message-ID: <49669c17-bda9-4239-9e46-f7b701facdd3@suse.de>
Date: Mon, 3 Feb 2025 15:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
 <20250122165829.11603-10-hare@kernel.org> <20250128091531.GG25760@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128091531.GG25760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 328021F391
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_062051_092397_7CED78B0 
X-CRM114-Status: GOOD (  17.85  )
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

On 1/28/25 10:15, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 05:58:28PM +0100, Hannes Reinecke wrote:
>> Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
>> the generated PSK once negotiation has finished.
> 
> Same as for the host side, please write a much more detailed commit log.
> 
Ok.

>> +	if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL &&
>> +	    ctrl->concat) {
> 
> This conditional easily fits onto a single line.
> 
Ok.

>> @@ -247,6 +263,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>>   	struct nvmet_ctrl *ctrl = NULL;
>>   	struct nvmet_alloc_ctrl_args args = {
>>   		.port = req->port,
>> +		.sq = req->sq,
> 
> So this now needs to pass a sq in alloc_ctrl_args?  That needs proper
> explanation and really should be in a prep patch.  Also please Cc
> Damien to make sure this doesn't break the nvme PCIe endpoint code.
> 

Sure, can do.

>>   	cancel_work_sync(&queue->io_work);
>> @@ -1806,6 +1808,23 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>   	spin_unlock_bh(&queue->state_lock);
>>   
>>   	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>> +
>> +	if (!status) {
>> +		struct key *tls_key = nvme_tls_key_lookup(peerid);
>> +
>> +		if (IS_ERR(tls_key)) {
>> +			pr_warn("%s: queue %d failed to lookup key %x\n",
>> +				__func__, queue->idx, peerid);
>> +			spin_lock_bh(&queue->state_lock);
>> +			queue->state = NVMET_TCP_Q_FAILED;
>> +			spin_unlock_bh(&queue->state_lock);
>> +			status = PTR_ERR(tls_key);
>> +		} else {
>> +			pr_debug("%s: queue %d using TLS PSK %x\n",
>> +				 __func__, queue->idx, peerid);
>> +			queue->nvme_sq.tls_key = tls_key;
>> +		}
> 
> This is almost begging for a separate helper..
> 
> 
Ok, will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

