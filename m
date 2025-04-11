Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4265AC36010
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 08:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vHYXL1I6qNUuXmtIswQDdmW7O16+sDHDWbS1TZOUHMc=; b=lK+NyaUBBZV+Wh3sqyDSSAq5Wd
	YaFOgfcmqkzYKre5VRjo+hhjUbUCUvQhgMzgW7E3NI2U7ncYCRxurrfex+6IgHfEHlNkNH5gxdsX+
	wPpaz54KN+3YC8A3MDKbC5LGCgOGMuHA9P2p+qT4Y3I2TMRARrHAGl/YTJIsfLIpftS8pxJ0FD4vS
	7psmwehwTo9vnBHHHk2qxlsNHEOeoibvn5RdZKGPpwEPg4UsMoL08tecJy6O13PIImlSneBAhWTvR
	xNt6ZvwXXmPkuZC9bNqana6esUD8LiijqUeIhn17WC+9EKHICLz5CV1n8afeZ83p2nvxPq9EFXyrr
	ErWahm3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3ADK-0000000D6br-2FxX;
	Fri, 11 Apr 2025 08:58:18 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37Y3-0000000CfWF-15RV
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 06:07:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CAD82117F;
	Fri, 11 Apr 2025 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744351649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHYXL1I6qNUuXmtIswQDdmW7O16+sDHDWbS1TZOUHMc=;
	b=NolQo++nO01E3ZNGl8CFEYhJ8M3kpo3+MLlxvfv06UTu/p1rmC/aI/NdweFyzmPHkqSepk
	1XRhCcjEqWlwdHz6quN/UooWxtkk9J6+tHTK8GpTKCUACqyplOkLmAKPPAMBl+YqTnHR2o
	MIvQp0VZUKA+2fESK9oVz+McETfzk1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744351649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHYXL1I6qNUuXmtIswQDdmW7O16+sDHDWbS1TZOUHMc=;
	b=NCTgYf3Dou2Z74YSC6ImNsOCD0J6zbgp0bcJUHe6SXm0NxR8ET9fVTUgTpKGZVKWEZw+Ib
	jgqUAnCobISEn3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744351649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHYXL1I6qNUuXmtIswQDdmW7O16+sDHDWbS1TZOUHMc=;
	b=NolQo++nO01E3ZNGl8CFEYhJ8M3kpo3+MLlxvfv06UTu/p1rmC/aI/NdweFyzmPHkqSepk
	1XRhCcjEqWlwdHz6quN/UooWxtkk9J6+tHTK8GpTKCUACqyplOkLmAKPPAMBl+YqTnHR2o
	MIvQp0VZUKA+2fESK9oVz+McETfzk1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744351649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHYXL1I6qNUuXmtIswQDdmW7O16+sDHDWbS1TZOUHMc=;
	b=NCTgYf3Dou2Z74YSC6ImNsOCD0J6zbgp0bcJUHe6SXm0NxR8ET9fVTUgTpKGZVKWEZw+Ib
	jgqUAnCobISEn3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32A8B136A4;
	Fri, 11 Apr 2025 06:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ITHBCqGx+GdbawAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 11 Apr 2025 06:07:29 +0000
Message-ID: <4c212210-88aa-46d3-82a3-84e44f44eb86@suse.de>
Date: Fri, 11 Apr 2025 08:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: auth: Avoid sparse warning in nvmet_auth_sq_free()
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>
References: <20250411010015.1017829-1-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250411010015.1017829-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_230731_443508_D88AA308 
X-CRM114-Status: GOOD (  14.55  )
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

On 4/11/25 03:00, Damien Le Moal wrote:
> When compiling with C=1, the following sparse warning is generated:
> 
> auth.c:243:23: warning: Using plain integer as NULL pointer
> 
> Avoid this warning by using NULL to instead of 0 to set the sq tls_key
> pointer.
> 
> Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/nvme/target/auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 0b0645ac5df4..cef8d77f477b 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -240,7 +240,7 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
>   {
>   	cancel_delayed_work(&sq->auth_expired_work);
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
> -	sq->tls_key = 0;
> +	sq->tls_key = NULL;
>   #endif
>   	kfree(sq->dhchap_c1);
>   	sq->dhchap_c1 = NULL;

Tsk. Did I do that?

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

