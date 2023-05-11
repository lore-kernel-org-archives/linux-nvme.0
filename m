Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6419FC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H7CxoDzZAmXlEQVH2zzkKWipoEJDhgtZeubqhgC1e0Y=; b=GIlAIt/B4LmbUk6nbNTENoCG7t
	M1HCz07Cp75b/80jjH3blpY7XSNcIlrPByX89xjM2uFwA/3cp5Lj1XPuKMhx7T7OoavcwXvolgHHp
	wINuD0v6Ro84meFhss5/wCkJA0nUfN+RynqWXA2QTzIWJbaIdy8y/qxDIyOcw6WGQB06wT9S1XB+b
	0olkwaCuS1EZSM9oVucK4C6787yAP0IJ5IdSsu+f8+C+GWGtJdAP/lqMkHN1gCJ+xJgnRkw+jPtBY
	9Ds8NDVoKEuchw9ENTLPcJuxRwpkmcjI3nJTSb7qd5R7L2C/mnvxT5ebYn8IHu8HfYnO9I3JJWEjL
	E/XdwC4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxBIR-009kTy-16;
	Thu, 11 May 2023 18:45:47 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxBIN-009kSr-2J
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 18:45:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70DD420044;
	Thu, 11 May 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683830740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7CxoDzZAmXlEQVH2zzkKWipoEJDhgtZeubqhgC1e0Y=;
	b=bSXMI8I1C9iMU9HhDxAx5aULuxnX9nuIZ6QSZrhEPRgnIfWPJJMPwGYLlvhDtmvIOs9KQR
	+23bTqwjjGQT9Ud/1vn0cD1HtZWWHzpskNP/1zHwB3mjzLoCU4b+DtP+nfNzCEA4l8d1k0
	mAVINJfExk1GkewJSk3MlcyhPhuz1NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683830740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7CxoDzZAmXlEQVH2zzkKWipoEJDhgtZeubqhgC1e0Y=;
	b=I/ZNDuYYf+WI+Ntraf/gQFw8lDRTcye/xfU9+i/4/seEehuSyBWy+6XCOgn022QlNl18Zs
	9kQPMAF/vlzvm5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECBED134B2;
	Thu, 11 May 2023 18:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QmeLL9E3XWQrTQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 11 May 2023 18:45:37 +0000
Message-ID: <ea781287-bf3b-e8e7-28ea-64b49f6a04c2@suse.de>
Date: Thu, 11 May 2023 20:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/3] nvme-fabrics: check hostid using uuid_equal
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
 <20230511165441.30005-3-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230511165441.30005-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_114543_908365_5C516242 
X-CRM114-Status: GOOD (  14.79  )
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

On 5/11/23 18:54, Max Gurtovoy wrote:
> Use a dedicated function to match uuids instead of duplicating it.
> 
> Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
> - address comments from Christoph
> 
> ---
>   drivers/nvme/host/fabrics.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f7..862bc4e5e3d9 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -181,7 +181,7 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
>   	    ctrl->state == NVME_CTRL_DEAD ||
>   	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
>   	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
> -	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
> +	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id))
>   		return false;
>   
>   	return true;
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


