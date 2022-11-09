Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D70C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9AH/rLnSObU32pr53OmmnbYPJNSOAaaBmNgIHceHq+k=; b=gUOYM33fLwuFmDoU7LVvgTZx10
	Es//n0jHRNnBrk1hErMkUhqxGKs17sHGZg9a0VPoDahUvYSEc89LYKihxRpEHo2SiZNfapCGxh2Hs
	kAwRGW4AU1cvsBTKT+2Xbaly1LyCCmXDWi0/rNMotR0ZIoRY4TeIm8c6fyLvh3O+rvJR/P7KCZy1N
	mIUjCjl9pIVAoJ2rAvpOMp5UIJ+f/fBj8g6W6WZSfPYFdoFcqmmOQHpIc7BhIS4uX3ZHcdgcPlsis
	/WF7fbHesSejnBXfiiDBg1h6ThLRzFt50jIZTFtTaJEhXuW9VQZfKnla/MV8syiW2K8qPyqlY+wqB
	/JzCbhww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfXr-00BZ8Y-Ry; Wed, 09 Nov 2022 07:30:47 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfXk-00BZ7B-AE
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:30:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C01581F390;
	Wed,  9 Nov 2022 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AH/rLnSObU32pr53OmmnbYPJNSOAaaBmNgIHceHq+k=;
	b=U1Q6L4V14orscLR5mOKpsgDdffit/VwmErXUABnIszaN81HQpDtbcnDWXgLyMEWWAGdSGt
	DU9cC4NJqq6Rin2/+ogxI+3rr7crIZM3i2JwzbG0HNtzo/06hdOT9r/tXlpxEIyzmPHauQ
	kTLTkGD1MVxVALH/x84ucLBn+mlwxIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AH/rLnSObU32pr53OmmnbYPJNSOAaaBmNgIHceHq+k=;
	b=Ft5XZSmgHHNb0EoXEYcrOFuN0ndkACTQVbt3rM58KNMK1r7WxGT/IloIeyYGoey5FO9kR9
	fxzK2Lznbbowv2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69EE9139F1;
	Wed,  9 Nov 2022 07:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dtKsFhlXa2MJMwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:30:33 +0000
Message-ID: <fbdd9aa8-3b2f-bcf0-591f-34a31d552ba2@suse.de>
Date: Wed, 9 Nov 2022 08:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/16] nvme-auth: remove symbol export from
 nvme_auth_reset
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_233040_538267_4B655A1C 
X-CRM114-Status: GOOD (  15.82  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> Only the nvme module calls it.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index d45333268fcf..734928282d3e 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -932,7 +932,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
>   	}
>   	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   }
> -EXPORT_SYMBOL_GPL(nvme_auth_reset);
>   
>   static void nvme_dhchap_auth_work(struct work_struct *work)
>   {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


