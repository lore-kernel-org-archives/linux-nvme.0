Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A9CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=; b=EG8q0Ujgh3dtsoLq5cc5zDoB5q
	iyvuYInOFDklIUnK6Nih5js1DOMp+UKMKj/CuIwgnl1YZDlQLC/1ZGLkOUl0umQ/KRG5/MEl83LfP
	bIqJsmo0jOZyPrE5+tWlrdXLHvofuTONQQndbOKByac/2Wl0altSfzKCjGg4ToODslehYQAV65sD4
	OLpdhja0rl58RyImq+dxPF9tGw9zRStc33RzJKPZz84rt2mfS/KiFeGG0C1g4/yzqnn8wjt9vx0Ef
	smPQhKOnoV128NGEBZsFRYm7k8r0p8JkF8zrLYf7Yvnm+ltMN7hCWEhzh3qoiTjHWZG+KCDv0ooLc
	QIyJrFxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ51i-00000008GJY-40y3;
	Wed, 12 Nov 2025 07:12:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ51g-00000008GJD-0xDV
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 07:12:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F7E21841;
	Wed, 12 Nov 2025 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=GOa1syeYZ/mNrYeNR7C+fnj5dD9BHhJ3ajLOlIj0VAcUOYnpmRwC7lxf8RXqwO+r8/dXze
	uBvQ+ZOOjkQOBoLO0bedoEM0aI6HxPKlvDc/p/sau8uRIBr3QUYFpFhZMWexChReWgsvYY
	0SUOOG5HPnArJEIJN/y2dKyENoQnzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=igApBArwZss0PLdWU6EicDKB1VGfz7ZA4q0tb8W1BswjhQxcmc0lnDy+rGWueWRkY+cF0J
	2e0jZ1nmhi2K4TAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GOa1syeY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=igApBArw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=GOa1syeYZ/mNrYeNR7C+fnj5dD9BHhJ3ajLOlIj0VAcUOYnpmRwC7lxf8RXqwO+r8/dXze
	uBvQ+ZOOjkQOBoLO0bedoEM0aI6HxPKlvDc/p/sau8uRIBr3QUYFpFhZMWexChReWgsvYY
	0SUOOG5HPnArJEIJN/y2dKyENoQnzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=igApBArwZss0PLdWU6EicDKB1VGfz7ZA4q0tb8W1BswjhQxcmc0lnDy+rGWueWRkY+cF0J
	2e0jZ1nmhi2K4TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF88A14DC8;
	Wed, 12 Nov 2025 07:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqofLFEzFGkbeAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:12:17 +0000
Message-ID: <ce51e08a-d7a7-4a92-b9c1-0fe13d814721@suse.de>
Date: Wed, 12 Nov 2025 08:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251111234519.3467440-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26F7E21841
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_231220_438169_8B436FF4 
X-CRM114-Status: GOOD (  18.43  )
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

On 11/12/25 00:45, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing to the sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Trigger on any value written to `tls_configured_key`
> 
>   drivers/nvme/host/sysfs.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6d10e12136d0..db1c53e00501 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -806,7 +806,28 @@ static ssize_t tls_configured_key_show(struct device *dev,
>   
>   	return sysfs_emit(buf, "%08x\n", key_serial(key));
>   }
> -static DEVICE_ATTR_RO(tls_configured_key);
> +
> +static ssize_t tls_configured_key_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int error;
> +
> +	if (!ctrl->opts || !ctrl->opts->concat)
> +		return -EOPNOTSUPP;
> +
> +	error = nvme_auth_negotiate(ctrl, 0);
> +	if (error < 0)
> +		return error;
> +
> +	error = nvme_auth_wait(ctrl, 0);
> +	if (error < 0)
> +		return error;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(tls_configured_key);
>   
>   static ssize_t tls_keyring_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)

Errm. Why 'configured_key'?

The configured_key sysfs attribute is a representation of the --tls-key
attribute when calling 'nvme connect', which in itself should be used
for debugging purposes only. And as such it really cannot be modified.

Please use the 'tls_key' attribute (which holds the negotiated key,
and is available always).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

