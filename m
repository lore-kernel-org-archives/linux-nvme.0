Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16718C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmHlNmPFCdQ6vw9NO04cddK998RZT3/QaknGnYt/mxE=; b=aEUdGI8o2nZUMipBhKAJtOsyve
	UV9gu7PhEhWjUjGj3P1jWWfgf24DjauwNPWhFP08TKZ7ol8xSPBkQHUYINtafAJpXVofwLZ6XHwSh
	tLN5YB++1TuV5EfwmEqzjy0PjUmddNj21Crlb/jcYMo1V2CuHwGEcOrFRsrnHLACzgkq2fcYHEV9Z
	9vk67gazt8QPzIWoisN5Po4N4oE+IScmTL3L2U+lSxVjDzSnGSn6ARziVoVKZPd775SMewg40nhUV
	6QgKqef/KGXW+h2bL/9kByNHaK8Kmf1/DiLLKzVCcH8tuf56JSMXNnvm8TpmCt6Udy6IV1fpedjXs
	AA9L8SNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4vf-00000005jAT-2dyP;
	Thu, 23 May 2024 09:40:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4vS-00000005j2Z-1D7P
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 09:40:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 600DC20084;
	Thu, 23 May 2024 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmHlNmPFCdQ6vw9NO04cddK998RZT3/QaknGnYt/mxE=;
	b=XgIG0/NSZfbZN5Op7ktq81k1iJJSukSH2iHghElB7UWau+Rdks5n81cV5IsXag0T5iMq/4
	LJAzHSJI+9QoCPgtyRL4N9x3JjdgIx/pqYFAToaM3B4mUQ+t7Nrue8HoDmakOMEaodi/lW
	un1ZuLGCBUCU51uDaVqfobwjZN2FovE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmHlNmPFCdQ6vw9NO04cddK998RZT3/QaknGnYt/mxE=;
	b=xGHV39RIN8XZP9fostZ+WLx+EkJHSmn5l3Y0h3386flhDcfewlWhctPRbbVlJDj/Ss8unr
	vy3S/8BBc6kfnIBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmHlNmPFCdQ6vw9NO04cddK998RZT3/QaknGnYt/mxE=;
	b=XgIG0/NSZfbZN5Op7ktq81k1iJJSukSH2iHghElB7UWau+Rdks5n81cV5IsXag0T5iMq/4
	LJAzHSJI+9QoCPgtyRL4N9x3JjdgIx/pqYFAToaM3B4mUQ+t7Nrue8HoDmakOMEaodi/lW
	un1ZuLGCBUCU51uDaVqfobwjZN2FovE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmHlNmPFCdQ6vw9NO04cddK998RZT3/QaknGnYt/mxE=;
	b=xGHV39RIN8XZP9fostZ+WLx+EkJHSmn5l3Y0h3386flhDcfewlWhctPRbbVlJDj/Ss8unr
	vy3S/8BBc6kfnIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41FB013A6C;
	Thu, 23 May 2024 09:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pvGyD+cOT2bCRwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 09:39:51 +0000
Message-ID: <e5f719b1-1fec-4685-a961-aa03acbdbbed@suse.de>
Date: Thu, 23 May 2024 11:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-fabrics: use post connect auth helper
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-3-kch@nvidia.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240208062427.31255-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_023957_718845_EAFD9EEF 
X-CRM114-Status: GOOD (  14.62  )
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

On 2/8/24 07:24, Chaitanya Kulkarni wrote:
> Use previously added helper to handle post connect command auth in
> nvmf_connect_io_queue().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 25 +------------------------
>   1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 24f0d298825b..19130e3bd00a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -493,7 +493,6 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   	struct nvmf_connect_data *data;
>   	union nvme_result res;
>   	int ret;
> -	u32 result;
>   
>   	nvmf_connect_cmd_prep(ctrl, qid, &cmd);
>   
> @@ -508,29 +507,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
>   				       &cmd, data);
>   	}
> -	result = le32_to_cpu(res.u32);
> -	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
> -		/* Secure concatenation is not implemented */
> -		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
> -			dev_warn(ctrl->device,
> -				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> -			goto out_free_data;
> -		}
> -		/* Authentication required */
> -		ret = nvme_auth_negotiate(ctrl, qid);
> -		if (ret) {
> -			dev_warn(ctrl->device,
> -				 "qid %d: authentication setup failed\n", qid);
> -			ret = NVME_SC_AUTH_REQUIRED;
> -		} else {
> -			ret = nvme_auth_wait(ctrl, qid);
> -			if (ret)
> -				dev_warn(ctrl->device,
> -					 "qid %u: authentication failed\n", qid);
> -		}
> -	}
> -out_free_data:
> +	ret = nvme_auth_post_connect(ctrl, 0, le32_to_cpu(res.u32));
>   	kfree(data);
>   	return ret;
>   }
Agree with Sagi; move the first 'if' clause out of the helper:

if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR))
     ret = nvme_auth_post_connect(ctrl, 0, le32_to_cpu(res.u32));

Cheers,

Hannes


