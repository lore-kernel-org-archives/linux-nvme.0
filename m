Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029AECF9C6C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 05:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUbByObmcrUL6qVlAaUurjeuTafVISQ6sL8yGzr1Ddw=; b=URntenMBXwHASSi9hAJUPvjNpy
	TlCIWiBDrYYjAipjBidnIYYTB2xQasePQXChwFcb2KKmDD0XBcddL4g9ZCUG5/ByYSzLUtbGsYGN6
	bcIqSeoyPpEaAxAajtzy5IbmUxnAohSzGl01wWImz+VgLESsg1s7xLHYOUb4W4UVbr7hfQSgbNtrn
	n9BC8J04MVo5Ykm8x16yha7Y5blFeTlR6EBNuJGAq/5PIeYJjZNTq8xPcGi70SrRCFQqSQA/KPU8P
	Y+y6fujHiizYdyHiSzObVAJ+nyIixF4OSu8p+vR4RWNuqtVJWTV2BfNYwcMtN8v1vIz3GO52a6ulW
	+VSniO9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stKoC-000000045ww-1BAU;
	Wed, 25 Sep 2024 05:43:28 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stKo6-000000045vV-1EBX
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 05:43:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B16B1FD32;
	Wed, 25 Sep 2024 05:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727243000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUbByObmcrUL6qVlAaUurjeuTafVISQ6sL8yGzr1Ddw=;
	b=2TI+7MxCpSMcBUt115BPg6KgoNI2XvawgdqXAVP69CupyNTMaPXH9AoCOlEjN/PqtwYq+2
	TNXUpaM0g+fw36jnkYMp6D58w541kbeQ2POqYc0yrv8eIiaM694ZKVVM/O2HMXa+qv00ym
	Sih5u1YxgPGl+YEwbDACWsdq1d8yplc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727243000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUbByObmcrUL6qVlAaUurjeuTafVISQ6sL8yGzr1Ddw=;
	b=evovYc8IaV1mF+ygEOMXrziVtwsZbptVV5/dFZ7QA+TeDbAeQILEyc/KwUfq79gM8pbCJX
	SJ1I1QuxIa4xS2Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wN3LGORm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Tesn02wO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUbByObmcrUL6qVlAaUurjeuTafVISQ6sL8yGzr1Ddw=;
	b=wN3LGORmA1cW+pfD3fLTIveveaUTI0fti51/eMfMDlIm8S25tnPYMmwKeukYeaRcedlIm4
	71uQLg+Z049pH4m7j0dG3I4EzAtwNNQdC9XnMVtkI16AM7Qw1HmTX91aB08uTq1I2VSux/
	tbn161SqaSvV5aRe9d+g8ogJX7MVPKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUbByObmcrUL6qVlAaUurjeuTafVISQ6sL8yGzr1Ddw=;
	b=Tesn02wOnRlUEnzXKr+Pkuur0umhfXOdCelZn0alz9dZKq8eAiAFBhdD1wXP8xu+/odOe8
	dk7UiBGMw0Pw6YCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F2B113A66;
	Wed, 25 Sep 2024 05:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id upVlAPai82ZRUwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Sep 2024 05:43:18 +0000
Message-ID: <b147b7ed-0760-472f-8ee5-3623d3bc16d0@suse.de>
Date: Wed, 25 Sep 2024 07:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: null terminate nvme_tls_attrs
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B16B1FD32
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_224322_508933_EA9E5F39 
X-CRM114-Status: GOOD (  13.61  )
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

On 9/24/24 11:01, Shin'ichiro Kawasaki wrote:
> Commit 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
> separate group") introduced the struct attribute array nvme_tls_attrs.
> However, the array was not null terminated and caused BUG KASAN global-
> out-of-bounds. To avoid the BUG, null terminate the array.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-nvme/jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm/
> Fixes: 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a separate group")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/sysfs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index eb345551d6fe..b68a9e5f1ea3 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] = {
>   	&dev_attr_tls_key.attr,
>   	&dev_attr_tls_configured_key.attr,
>   	&dev_attr_tls_keyring.attr,
> +	NULL,
>   };
>   
>   static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


