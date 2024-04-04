Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860E9CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1TxBM5H1Iwp0pbO2z+3mRiMD43mnoO9X3zd3b/Ev5I=; b=M/LG9X4pfc7ppbQFfLfH/qfvqM
	jKNqpBLCFYQp/pJHs36x/s8vCCh/pnLVA1HHCBFir49OP4YuLGu9qqbLcYrBNb8XPPEF2JVwbTRbo
	8N3cHx8cVbApLauW0mRfc5205h26q7NyOqJNkU5DrkIwgppF2jvL+ksIUfn9QQ+H0LcIu/GmFowRm
	bfEya9kbjKx8HOzQL3bIC2+jIXGtfH9vrfwCWQo7wwc5bVGf9WNlRChHEQzzacSvXgRcNYfSOBzGT
	tv8kn8yuW3vXen+fv0hKVYRf7DS1bqxJxnR2gPYRKub+75NNd0U+lgUN8yOHPP7ARIOExL6vJZfs8
	4JkBW2VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOSR-000000037An-0TFK;
	Thu, 04 Apr 2024 14:52:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOSH-0000000373d-3aW3
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 14:52:49 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3994A5F813;
	Thu,  4 Apr 2024 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712242358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1TxBM5H1Iwp0pbO2z+3mRiMD43mnoO9X3zd3b/Ev5I=;
	b=iE01HefTdOETtLJW3t5z2am0ASygDYOOElVXPPpjcEnpQYwg7Ra/XdWHI7BucOCT9eEhCP
	1kwVGedVTDWAKf2ZSQSPB3jPKuuLKEI9xBEh0lpvAUEFXffkOeZNU6hYbRKs47sAzAxnMd
	JSpwa4BeBcko1Z07VC+DwLDbRPixP8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712242358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1TxBM5H1Iwp0pbO2z+3mRiMD43mnoO9X3zd3b/Ev5I=;
	b=xfDz2bD89Nz+2vjNH/ZGLWPBo6lLW4olxBE5T/341XYW3k/ZyoIF7gUetti0nqNsn50MHu
	28nadaILjllTbECA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712242358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1TxBM5H1Iwp0pbO2z+3mRiMD43mnoO9X3zd3b/Ev5I=;
	b=iE01HefTdOETtLJW3t5z2am0ASygDYOOElVXPPpjcEnpQYwg7Ra/XdWHI7BucOCT9eEhCP
	1kwVGedVTDWAKf2ZSQSPB3jPKuuLKEI9xBEh0lpvAUEFXffkOeZNU6hYbRKs47sAzAxnMd
	JSpwa4BeBcko1Z07VC+DwLDbRPixP8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712242358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1TxBM5H1Iwp0pbO2z+3mRiMD43mnoO9X3zd3b/Ev5I=;
	b=xfDz2bD89Nz+2vjNH/ZGLWPBo6lLW4olxBE5T/341XYW3k/ZyoIF7gUetti0nqNsn50MHu
	28nadaILjllTbECA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C4B93139E8;
	Thu,  4 Apr 2024 14:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ICKgLLW+DmbiEAAAn2gu4w
	(envelope-from <hare@suse.de>); Thu, 04 Apr 2024 14:52:37 +0000
Message-ID: <cb4abdda-0ad3-4147-a2f1-6b346d8ed0ee@suse.de>
Date: Thu, 4 Apr 2024 16:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-fc: rename free_ctrl callback to match name
 pattern
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240404144131.17988-1-dwagner@suse.de>
 <20240404144131.17988-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240404144131.17988-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.29 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,grimberg.me:email,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_075242_095752_8F737975 
X-CRM114-Status: GOOD (  16.44  )
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

On 4/4/24 16:41, Daniel Wagner wrote:
> Rename nvme_fc_nvme_ctrl_freed to nvme_fc_free_ctrl to match the name
> pattern for the callback.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 68a5d971657b..a5b29e9ad342 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2428,7 +2428,7 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
>    * controller. Called after last nvme_put_ctrl() call
>    */
>   static void
> -nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
> +nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
>   {
>   	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
>   
> @@ -3384,7 +3384,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.reg_read32		= nvmf_reg_read32,
>   	.reg_read64		= nvmf_reg_read64,
>   	.reg_write32		= nvmf_reg_write32,
> -	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
> +	.free_ctrl		= nvme_fc_free_ctrl,
>   	.submit_async_event	= nvme_fc_submit_async_event,
>   	.delete_ctrl		= nvme_fc_delete_ctrl,
>   	.get_address		= nvmf_get_address,
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


