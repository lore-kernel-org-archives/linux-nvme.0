Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB0C71157
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Jun 2025 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oycTO/YFFT2TIM/jSDPrQxDkJASZq1U4rkORUH/J/M0=; b=G406kiWdyyLvl9ra+MW/wL0G3M
	aJh4SaZuNXJoCM2KsV1aGI32uQdP/uTwQb6OBcRibNVIDHhgSK4HzLv9n8CJ5yGdE14uISTB08l5h
	8PJXpQIUMv01h9iHKHVeDHLMLdVh6eGnlOfktsvrggFkRicEa2FHgLVWteiNEBqbhEc13S5uQRBgb
	yCvFvit4euPn3vhXCNERLyY6gvZLIPcO45Qiaffjc+AFlR67hbFUe1RMFzEtUTCLxD9peTQAdJbE/
	sUOQSaZhUeq4WwQW3bdTnZWUllTSbLEApa7I11JWQGxtGNefB0CnygIO0p1KtjTg9OgIf0F09IsMp
	bDVO7gbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSyOv-0000000HTIZ-2rgn;
	Sat, 21 Jun 2025 13:36:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSyOm-0000000HTIC-30HF
	for linux-nvme@lists.infradead.org;
	Sat, 21 Jun 2025 13:36:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44F6F21187;
	Sat, 21 Jun 2025 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750513005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oycTO/YFFT2TIM/jSDPrQxDkJASZq1U4rkORUH/J/M0=;
	b=xpT816IBN58S8yLIy6KkCka2AmShuxRWcj5KTeYcbogzyBshjWbIo/wL4YrVk0EoKx7O5y
	OSPzwhF5hWMgA5Xf2J+eXa4iWGMzOlV02/NuGB4xg0QFSKDGcM0GaVpo7r3OnH7q75HoOt
	mfMxjQYuISX6zf9j2GyjsafJ6Z97LBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750513005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oycTO/YFFT2TIM/jSDPrQxDkJASZq1U4rkORUH/J/M0=;
	b=iQtZVTECCTGZhdAp86qJLU2twnyz3+yfAUi2+g+it7R63rHjB5k3r6Y2HzDeF6DEiMnuP0
	PcsxwjvQ/3OxSkDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750513005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oycTO/YFFT2TIM/jSDPrQxDkJASZq1U4rkORUH/J/M0=;
	b=xpT816IBN58S8yLIy6KkCka2AmShuxRWcj5KTeYcbogzyBshjWbIo/wL4YrVk0EoKx7O5y
	OSPzwhF5hWMgA5Xf2J+eXa4iWGMzOlV02/NuGB4xg0QFSKDGcM0GaVpo7r3OnH7q75HoOt
	mfMxjQYuISX6zf9j2GyjsafJ6Z97LBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750513005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oycTO/YFFT2TIM/jSDPrQxDkJASZq1U4rkORUH/J/M0=;
	b=iQtZVTECCTGZhdAp86qJLU2twnyz3+yfAUi2+g+it7R63rHjB5k3r6Y2HzDeF6DEiMnuP0
	PcsxwjvQ/3OxSkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6415136BA;
	Sat, 21 Jun 2025 13:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B3YAHGu1VmjlHAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 21 Jun 2025 13:36:43 +0000
Message-ID: <bec7b2d5-06a8-4649-a15b-e91fff21854f@suse.de>
Date: Sat, 21 Jun 2025 15:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] nvme: sysfs: emit the marginal path state in
 show_state()
To: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, jmeneghi@redhat.com
References: <20250620175820.34795-1-bgurney@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250620175820.34795-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250621_063648_913516_892C5E0E 
X-CRM114-Status: GOOD (  14.35  )
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

On 6/20/25 19:58, Bryan Gurney wrote:
> If a controller has received a link integrity or congestion event, and
> has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
> instead of "live", to identify the marginal paths.
> 
> Co-developed-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> ---
>   drivers/nvme/host/sysfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..4a6135c2f9cb 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -430,7 +430,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>   	};
>   
>   	if (state < ARRAY_SIZE(state_name) && state_name[state])
> -		return sysfs_emit(buf, "%s\n", state_name[state]);
> +		return sysfs_emit(buf, "%s\n",
> +			(nvme_ctrl_is_marginal(ctrl)) ? "marginal" :
> +			state_name[state]);
>   
>   	return sysfs_emit(buf, "unknown state\n");
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

