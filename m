Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AF4F531EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 06:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7FCUnv7PHUDBm1bo7+4J5mSdfhfymBEDvhwQC6dPwnM=; b=T0TqShK9ieI/vRkpVrm2gaLaL+
	/ZjKUWHQgkMDRdWArE2lIyObXqQuoDfiQh1xHf1Gkmqx3afuuQw5lYKZGekPiV8Ljldr4AE7a7jYr
	uI7wniL60y6EgzgLqMganjo/eOiIKygjizvIEDeH1iCn3Oz0G3rXzflWBxuBDfDdYDFr1yg6X/A5c
	r7ZPdw0LyIEnRd3Sfbl7a9zU+/qCXHzmgj3y07s/Yac5/3gafprB78JOKeAH96UY9QWVuKjq0xIEZ
	2QN/BjNZUM6E/yW+ejiMGH9SZVOMfaCPmAkIjddXvoQFipu3UY/G3bc+oYRt2Ir20o7LwxvHeiEwu
	M90/8rKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCWrj-0000000GkFk-0ton;
	Tue, 14 Apr 2026 06:03:15 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCWrg-0000000GkF1-1wty
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 06:03:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E0876A95A;
	Tue, 14 Apr 2026 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776146590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FCUnv7PHUDBm1bo7+4J5mSdfhfymBEDvhwQC6dPwnM=;
	b=AJPxVGm8o8wCJ155SlplA2YizDgLMtK55JA65M/T5vUiEk8PxG3V8sP/wq8aKAojeSWErR
	WI3/isTL/3BD7eel3aDL5OG0tAAAeCgRb1NK3tAlPM3ccEt8rbR9o9qZlPv2iKh+dtcftX
	6YN6bsd8h/moEc/z8Mw2541PQiOO8U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776146590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FCUnv7PHUDBm1bo7+4J5mSdfhfymBEDvhwQC6dPwnM=;
	b=LlysaNRp6+52Px+TFcybvVBMZuUkz6D9NzLQXcGXMfCJ4bVfyY7meGBn2yrBCs/8VWnH9s
	zQDu0XZm+LscpSCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776146590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FCUnv7PHUDBm1bo7+4J5mSdfhfymBEDvhwQC6dPwnM=;
	b=AJPxVGm8o8wCJ155SlplA2YizDgLMtK55JA65M/T5vUiEk8PxG3V8sP/wq8aKAojeSWErR
	WI3/isTL/3BD7eel3aDL5OG0tAAAeCgRb1NK3tAlPM3ccEt8rbR9o9qZlPv2iKh+dtcftX
	6YN6bsd8h/moEc/z8Mw2541PQiOO8U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776146590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FCUnv7PHUDBm1bo7+4J5mSdfhfymBEDvhwQC6dPwnM=;
	b=LlysaNRp6+52Px+TFcybvVBMZuUkz6D9NzLQXcGXMfCJ4bVfyY7meGBn2yrBCs/8VWnH9s
	zQDu0XZm+LscpSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E3B94B2C1;
	Tue, 14 Apr 2026 06:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oWy6EZ7Y3WmUfQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 14 Apr 2026 06:03:10 +0000
Message-ID: <d60274f1-b9bf-4378-b59f-c0e92dbca274@suse.de>
Date: Tue, 14 Apr 2026 08:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme: fix handling of tls alerts
To: Paul Moses <p@1g4.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "okorniev@redhat.com" <okorniev@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org>
 <2026041239-engross-edition-66eb@gregkh>
 <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org>
 <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com>
 <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de>
 <cegmtu5F2Mmye7nAykxzPw4Bh8EZZCCx79IUFf4RN5vEZcAbq4-mTr5H7LycgByHGg4EzrAW4TkYkWhkCPTXtsz1dF6iOBwB672-wE15iUY=@1g4.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cegmtu5F2Mmye7nAykxzPw4Bh8EZZCCx79IUFf4RN5vEZcAbq4-mTr5H7LycgByHGg4EzrAW4TkYkWhkCPTXtsz1dF6iOBwB672-wE15iUY=@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_230312_818156_E5BF08A4 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

On 4/13/26 11:01, Paul Moses wrote:
>> This should have been address by the patchset '[PATCH v2 0/4] address
>> tls_alert_recv usage by NFS and NvME' from Olga.
>> I _thought_ it had been merged already, but seems that it didn't.
> 
> Was it ever reproduced on the nvme side? I probably would have been
> hesitant to argue with you on a hypothetical bug with no evidence
> as well.
> 
> https://lore.kernel.org/stable/c2d3a4b6-6b1c-4f9c-982b-4adbc558e1b7@suse.de/
> 
Not sure about a reproducer, but we certainly need to handle TLS
messages (including TLS Alerts) correctly. There is a patchset
to implement REPLACETLSPSK which basically requires us to handle
TLS messages.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

