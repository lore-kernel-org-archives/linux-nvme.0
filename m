Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B5DC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JwClzlSy5kE4jQaAPpLNKVtmTatsa4b5MW4XdoXrcbk=; b=vT3OGj21Nfztc+HgT7xpDOV3oZ
	ILEOs7QxrASnwEWXFlTvTtQlpSbo+nN7uP5GcI+AL+GyNTGP3dEPmskMQy9NlQp2gYfnOEF/WDyz2
	3eJqdNulQ8UKjTzVQA6mLFW/iNDHqT91g4WL77X1nTOufycO3vwP9cdwqj4qV2H0005HRGtxcprCU
	ju/wzaO7WBnKkAM256uVXnRLkrjswd/hjt6gtLcWabubt0wKA8mAIqg8cPrui3cFehKpKXjYk+KdC
	QihgHuK8GcCUmT9AjSMbVH+NCmEsZ0ZteXPl64r/ZFxTpg67HzBaW7J+rqgseBIRXG6P6DXC7fPS3
	ZeJZtyoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsFy-00000000inS-0p6I;
	Wed, 19 Jun 2024 10:09:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsFs-00000000ilg-3sVA
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:09:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 459A821A6D;
	Wed, 19 Jun 2024 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718791767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwClzlSy5kE4jQaAPpLNKVtmTatsa4b5MW4XdoXrcbk=;
	b=mZKAE5PkFtNH7FfuKxpZNcCXtX+H65xdeMgthuvdE8SAK6znBF7mubrcPcPK/azffBKtVD
	aabIBwZ2bkkPUewUsq54lq8hK/VbWSLT+fxzqeODEiuPh6txQmVwj8QM+iMzbfppYIng/R
	BYE6HaNq0kB/ydgVJdF+A0Rgb224AmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718791767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwClzlSy5kE4jQaAPpLNKVtmTatsa4b5MW4XdoXrcbk=;
	b=LXdTL5obyjIgvvCcajdb5aFIKaGzX85AbCqN7jbbYWPUGNFmgoyK4UYb9GWOwfyynDFL5w
	05hkyPn1CzryHwAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mZKAE5Pk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LXdTL5ob
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718791767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwClzlSy5kE4jQaAPpLNKVtmTatsa4b5MW4XdoXrcbk=;
	b=mZKAE5PkFtNH7FfuKxpZNcCXtX+H65xdeMgthuvdE8SAK6znBF7mubrcPcPK/azffBKtVD
	aabIBwZ2bkkPUewUsq54lq8hK/VbWSLT+fxzqeODEiuPh6txQmVwj8QM+iMzbfppYIng/R
	BYE6HaNq0kB/ydgVJdF+A0Rgb224AmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718791767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwClzlSy5kE4jQaAPpLNKVtmTatsa4b5MW4XdoXrcbk=;
	b=LXdTL5obyjIgvvCcajdb5aFIKaGzX85AbCqN7jbbYWPUGNFmgoyK4UYb9GWOwfyynDFL5w
	05hkyPn1CzryHwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16CD413ABD;
	Wed, 19 Jun 2024 10:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZrMRBFeucmagPAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Jun 2024 10:09:27 +0000
Message-ID: <3513742b-ff12-45a9-ae83-6de6cc65a955@suse.de>
Date: Wed, 19 Jun 2024 12:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: align I/O cpu with blk-mq mapping
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240618120345.64761-1-hare@kernel.org>
 <20240619053015.GB29159@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240619053015.GB29159@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 459A821A6D
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_030929_151221_A0F4B808 
X-CRM114-Status: GOOD (  15.91  )
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

On 6/19/24 07:30, Christoph Hellwig wrote:
> On Tue, Jun 18, 2024 at 02:03:45PM +0200, Hannes Reinecke wrote:
>> Add a new module parameter 'wq_affinity' to spread the I/O
>> over all cpus within the blk-mq hctx mapping for the queue.
>> This avoids bouncing I/O between cpus when we have less
>> hardware queues than cpus.
> 
> What is the benefit when setting it?  What is the downside?  Why do you
> think it needs to be conditional?
> 
We could make it the default option, as the current way of just cycling
through the cpu_online_mask() works only for trivial cpu configurations 
(ie not on AMD).
Downsides are none; at worst we're ending up with the same behaviour
which we have now (ie scheduling I/O on a cpu which is not part of the
blk-mq hwctx map).

>> +	}
>>   	if (wq_unbound)
>>   		queue->io_cpu = WORK_CPU_UNBOUND;
>> +	else if (wq_affinity) {
> 
> Missing curly braces.  But this also means the wq_unbound options
> is incompatible with your new one.
> 
Correct. The options are mutually incompatible.
I was looking into merging them, but then 'wq_unbound' is already 
existing and I wasn't sure if one can replace existing module options.

>> +	} else
>>   		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> 
> Overly long line here.
> 
Yeah, sorry.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


