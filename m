Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826DCC54FDF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 08:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pucUGyh9jOKWcu+HZoLp3+D8vSOy62TnHkwIG7nIUa4=; b=KkULD5ncuKy5tZ/cyqgV6viPWm
	qIJbRdAzVWFWEgnNIu+9Xr6XdiaGl1YrLVxm6pxmijNMgOyob9Kvw7hGw44Do+WqIedvFM/rpi/pf
	7s1B2JVgf+1DZtqK56B1NaHGqfIuA/M7D8nhBJfQXALy+0poYnt9cksAJM9SXGWM5SQYtaD7qTp7u
	VhWWtOd6LAkZ17RlgWu82SQ4wjIASqp+UvNlYdBroxwnEvMWJbizuEEDa4tXgBMGAMscx5OW3T5p1
	i2qUz7lqoKtyTBHFpmc4n5RbXavqEO8TqC9yjSFKYItZ8E9ZqAf8EvdUXhn9MO01H4uIzo6wMQm3F
	PdTZ0L/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM2w-00000009qTv-0lCi;
	Thu, 30 Jul 2026 08:23:18 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM2t-00000009qSY-1qNp
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 08:23:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 968BA3EE7;
	Thu, 30 Jul 2026 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pucUGyh9jOKWcu+HZoLp3+D8vSOy62TnHkwIG7nIUa4=;
	b=0XZcobkQ9xjfY8kcRTo2k2o7ag3PCpPCIJdE+makxWhFhe3MPhQ+U/J0SuqBNzBImbTNMP
	p7EFN3N1kx+I5aSvbKXVG7n0jNUq3udDXz5CGtjbnDqQgUJclMuC6rm56pex0QvzVIcdA/
	W4XKvfMnMzFp103ITWJh15cYR+W8IK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pucUGyh9jOKWcu+HZoLp3+D8vSOy62TnHkwIG7nIUa4=;
	b=ytdFN5PmLc1zFzTVda7HpOR6b6GF8oJfkp6SKj3FSeMtxJHHy2j7SvcQ7nXAtYKklU9huq
	7piL4nAGaSN3c5Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EfmE+qmI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wp7yJuTb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pucUGyh9jOKWcu+HZoLp3+D8vSOy62TnHkwIG7nIUa4=;
	b=EfmE+qmIm0cDVIekW8vq+fV7Knam2Es1FBqt4xL0jupWWB0o5ulNsd253QtQV44FI2vkoL
	8Qe+Wq7wCnLIfdAxRDuBPZBNovofrwzuccqjJjPFuuxwaxZFI+DaIwF3Wp3leV4WgbHoaw
	LqY3/gwM5WJtaud60AXiwIui6RyOSIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pucUGyh9jOKWcu+HZoLp3+D8vSOy62TnHkwIG7nIUa4=;
	b=Wp7yJuTbsbyxG4E2JjQZHGFvZlTckPnM1fLnrp/uWGgu/2dLJNaBvE/gYjuCOpXv0GYft1
	cawsk9Zs/j6jumDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D75D779CC;
	Thu, 30 Jul 2026 08:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /yY5HukJa2r0MwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 30 Jul 2026 08:23:05 +0000
Message-ID: <8c1d31b1-1f3e-4946-89e7-9db3009ecf22@suse.de>
Date: Thu, 30 Jul 2026 10:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvmet: propagate percpu_ref_init() failure in
 nvmet_ns_enable()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260730043105.3071328-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,alibaba.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 968BA3EE7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_012315_630560_613C6A65 
X-CRM114-Status: GOOD (  18.39  )
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

On 7/30/26 6:31 AM, Guixin Liu wrote:
> The return value of percpu_ref_init() is discarded. At this point ret is
> 0 from the preceding successful steps, so when the allocation inside
> percpu_ref_init() fails the code jumps to the out_pr_exit cleanup chain
> which ends with "return ret", i.e. reports success. The configfs enable
> store then tells userspace the namespace was enabled even though it was
> not and its backing device has already been torn down.
> 
> Capture the return value so the failure is propagated.
> 
> Fixes: 408232680707 ("nvmet: Fix crash when a namespace is disabled")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 4477c4d6b1ee..c8e01dda4121 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -610,7 +610,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   			goto out_dev_put;
>   	}
>   
> -	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
> +	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL);
> +	if (ret)
>   		goto out_pr_exit;
>   
>   	nvmet_ns_changed(subsys, ns->nsid);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

