Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA482CEACCB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJrDBS9asne4gQw0hgLdGdeAJ5PLMZ5/uDe5x+mYJlo=; b=qSMukZnV2YQmg9h6qB5U2A9GPa
	fMn4UI8HpSv5veD9i/m/5K/5evqNB3GlVr19jccwN0Q08EnRXakPcL1I7gWmWscpoDiEdw57b8rNt
	lDElnUAoULjdmDXfD5xzL5O0soO2WsW2iu2yZlvjRVbO8rd5RH/8R+g+cZgpa71XbNMAiPAhKhlUu
	s2Yl7UXMUxsglU0rtrSRJIEGTxGKPAc76CvFKzRhyOjWIueRW2krQA4VzQPay+PtRrz9eB7aXhPj4
	dUZzB+00Y8qXvT8YmjDWLm/qqHW0IGXIZMd5cZ/7J+Z2YWZKirkXJ5/OgXbrgfKCr2os+S/3ZSP28
	E/lU6fHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svdvF-000000039Wn-0I8h;
	Tue, 01 Oct 2024 14:32:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svcxz-00000002wiT-20sz
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 13:31:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D0B421B78;
	Tue,  1 Oct 2024 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727789460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJrDBS9asne4gQw0hgLdGdeAJ5PLMZ5/uDe5x+mYJlo=;
	b=cuam6jO6pz1IH8luoXSYzh6O7rbXmT/zXQC1XfweEe9Jl8Vw6TQpgFz6cZrEA3fEFtLe9w
	21sWjXabExlZCnaVrpQFH80og5DMqpWmp0AzBUEA4b8Lu6qtQ1Ovlvf9esIne/HClJ9pnz
	RojM6ppoPe7j5MucQlf2QmLEcyFGMig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727789460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJrDBS9asne4gQw0hgLdGdeAJ5PLMZ5/uDe5x+mYJlo=;
	b=8bfroNTJAnmdjnUIF7WHnVZtQRqa0uHBLHlzsI4XxNoRqYQKQ65eNha/BdhG/J9jDGyI4i
	gOiCM1RmUPF37eCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727789460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJrDBS9asne4gQw0hgLdGdeAJ5PLMZ5/uDe5x+mYJlo=;
	b=cuam6jO6pz1IH8luoXSYzh6O7rbXmT/zXQC1XfweEe9Jl8Vw6TQpgFz6cZrEA3fEFtLe9w
	21sWjXabExlZCnaVrpQFH80og5DMqpWmp0AzBUEA4b8Lu6qtQ1Ovlvf9esIne/HClJ9pnz
	RojM6ppoPe7j5MucQlf2QmLEcyFGMig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727789460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJrDBS9asne4gQw0hgLdGdeAJ5PLMZ5/uDe5x+mYJlo=;
	b=8bfroNTJAnmdjnUIF7WHnVZtQRqa0uHBLHlzsI4XxNoRqYQKQ65eNha/BdhG/J9jDGyI4i
	gOiCM1RmUPF37eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B463013A73;
	Tue,  1 Oct 2024 13:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+AmKJP5+2YMDwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Oct 2024 13:30:59 +0000
Message-ID: <070f7700-cce0-4fb3-8e03-a39d06a30df1@suse.de>
Date: Tue, 1 Oct 2024 15:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: tcp: avoid race between lock and destroy of
 queue_lock
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 "hch@infradead.org" <hch@infradead.org>
References: <20240912062707.1759715-1-shinichiro.kawasaki@wdc.com>
 <f32b1c7f-4c63-4333-9f43-f777115de9ce@grimberg.me>
 <0a699cf1-66a1-4793-874d-05902149f727@suse.de>
 <1eefa343-e2c3-4a50-8bce-16b451bea3cf@grimberg.me>
 <mz7efyxba4h7qui5pfykj2g3d76fwtmco2nyxsbwzhox3th35b@vziif5djzv7p>
 <iuqvbkvvtgm4z6wgtkgfsz73najwspbbbjfbwxtjhuj7cafccn@dlh6gpmfktd2>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <iuqvbkvvtgm4z6wgtkgfsz73najwspbbbjfbwxtjhuj7cafccn@dlh6gpmfktd2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[grimberg.me,lists.infradead.org,kernel.org,gmail.com,dell.com,infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_063103_703046_59DF3E69 
X-CRM114-Status: GOOD (  18.09  )
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

On 10/1/24 11:38, Shinichiro Kawasaki wrote:
> On Sep 12, 2024 / 13:28, Shinichiro Kawasaki wrote:
> [...]
>> Having said that, I still think there is a very tiny possibility that the
>> queue_lock gets destroyed between the NVME_TCP_Q_LIVE flag check and the
>> mutex_lock(). That is why I suggested the new flag NVME_TCP_Q_REFERRED.
>> Am I overthinking?
> 
> I thought about this again, now I think the patch I suggested is too much. The
> fix Hannes suggested is much simpler, and I confirmed it avoids the failure that
> I observed. Now I hope this fix to be applied.
> 
> Hannes,
> 
> May I send the fix as a formal patch on behalf of you? The fix will be as
> follows, and I will put your authorship to it.
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 89c44413c593..3e416af2659f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2644,10 +2644,11 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   
>   	len = nvmf_get_address(ctrl, buf, size);
>   
> +	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +		return len;
> +
>   	mutex_lock(&queue->queue_lock);
>   
> -	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> -		goto done;
>   	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
>   	if (ret > 0) {
>   		if (len > 0)
> @@ -2655,7 +2656,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
>   				(len) ? "," : "", &src_addr);
>   	}
> -done:
> +
>   	mutex_unlock(&queue->queue_lock);
>   
>   	return len;

Sure, you're welcome to send it :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


