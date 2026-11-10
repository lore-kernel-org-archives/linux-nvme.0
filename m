Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC19606E478
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UMt9r2Gz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q+LLrnRA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9mKtERTg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q+LLrnRA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9mKtERTg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SVc+CPW7zoLyGQ3H7jfE36yTV77ec3+3pCaUO3ZepOY=; b=UMt9r2GzvIsUTb
	bO5AHbC4FfA77eSzbJyU13YVgEvqIcXt+3D+jyYNdGJYlowHq7IHvtxyie8UzHshP2s1MurP0/MZd
	1bQvu04bOIq04u2hNcfGLJV5vz9ZPMfnkR6vTt0DhJmVElOEfanhkGx4bTsz/+FMJtOPjY7cHJbbb
	yfNn+NmchWmla17Rv2/Mpjc+k/MkntS9CxKf7t1+pRk76YwboNpjVFrFeq1RaBXkAlHKRpYfL3mQl
	kIaeWhgAuIvF06udqT0YGlMDUvivJfhCe/ppHoA8Xy9kRmOKj3NPJQ5RfSCruMJ8jMITlwnLXo9vU
	MeEJtem6N7hdJRYSBKRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlXX-00000003y45-0MeL;
	Tue, 10 Nov 2026 13:05:31 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlXU-00000003y2N-073O
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 13:05:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4661321F55;
	Tue, 10 Nov 2026 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVc+CPW7zoLyGQ3H7jfE36yTV77ec3+3pCaUO3ZepOY=;
	b=q+LLrnRAHGnMhsOAm2AR5PdVjDpVTcHVB1zUGLVl8XVF+10S7zFRJLhAhfuyqNj9jZSsPN
	7o7mhlD2DrGxcmSfMSVIlVY45YBZx6TBpvxBY1IB7x0xlGIkV8MAkMdknFdsN2DRjTzkJC
	v48EfLoUtaBxGibD894VNTXCIwe+uSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVc+CPW7zoLyGQ3H7jfE36yTV77ec3+3pCaUO3ZepOY=;
	b=9mKtERTg9o79kwEmyaZ0oloS/1w3HrCeLuFtvtWqQbmXXBp1t2/Vg+fhBFbpmX8Qoei8qz
	uWEvqABlY41p2lBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVc+CPW7zoLyGQ3H7jfE36yTV77ec3+3pCaUO3ZepOY=;
	b=q+LLrnRAHGnMhsOAm2AR5PdVjDpVTcHVB1zUGLVl8XVF+10S7zFRJLhAhfuyqNj9jZSsPN
	7o7mhlD2DrGxcmSfMSVIlVY45YBZx6TBpvxBY1IB7x0xlGIkV8MAkMdknFdsN2DRjTzkJC
	v48EfLoUtaBxGibD894VNTXCIwe+uSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVc+CPW7zoLyGQ3H7jfE36yTV77ec3+3pCaUO3ZepOY=;
	b=9mKtERTg9o79kwEmyaZ0oloS/1w3HrCeLuFtvtWqQbmXXBp1t2/Vg+fhBFbpmX8Qoei8qz
	uWEvqABlY41p2lBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13A021339F;
	Tue, 10 Nov 2026 13:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FL9NNpUW82oVTQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 13:05:26 +0000
Message-ID: <2f0e8fe5-42b6-47d9-9bcd-c549544e099a@suse.de>
Date: Tue, 10 Nov 2026 14:05:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvmet: clean up DH group state on initialization
 failure
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>, hare@kernel.org,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20261110113502.3235-1-sreekuttan2156239@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261110113502.3235-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lst.de,nvidia.com,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_050528_372001_084201B0 
X-CRM114-Status: GOOD (  20.31  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 12:35 PM, Sreeraj S Kurup wrote:
> nvmet_setup_dhgroup() leaves the DH transform and group ID
> initialized when private-key generation, public-key allocation,
> or public-key generation fails.
> 
> A subsequent invocation with the same DH group incorrectly
> returns success because the existing transform and group ID
> are treated as proof of successful initialization.
> 
> Release the transform and reset the group state on initialization
> failures so that subsequent attempts can properly retry setup.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
> v4:
>   - Consolidate DH group error handling and clear stale key state
>     when switching DH groups.
> v3:
>   - Clear stale DH key state when crypto_alloc_kpp() fails during
>     re-authentication.
>   - Fix the error path when crypto_alloc_kpp() fails by returning
>     the allocation error instead of incorrectly reporting success.
> v2:
>   - Consolidate error handling in "nvmet_setup_dhgroup()" using
>     a shared cleanup label to avoid duplicated teardown code.
>   - Add Fixes trailer.
> 
>   drivers/nvme/target/auth.c | 67 +++++++++++++++++++++-----------------
>   1 file changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e..681459b5db3b 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -76,8 +76,11 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
>   			return 0;
>   		}
>   		crypto_free_kpp(ctrl->dh_tfm);
> +		kfree_sensitive(ctrl->dh_key);
>   		ctrl->dh_tfm = NULL;
>   		ctrl->dh_gid = 0;
> +		ctrl->dh_key = NULL;
> +		ctrl->dh_keysize = 0;
>   	}
>   
>   	if (dhgroup_id == NVME_AUTH_DHGROUP_NULL)
> @@ -95,38 +98,42 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
>   			 __func__, ctrl->cntlid, dhgroup_id,
>   			 PTR_ERR(ctrl->dh_tfm));
>   		ret = PTR_ERR(ctrl->dh_tfm);
> -		ctrl->dh_tfm = NULL;
> -		ctrl->dh_gid = 0;
> -	} else {
> -		ctrl->dh_gid = dhgroup_id;
> -		pr_debug("%s: ctrl %d setup DH group %d\n",
> -			 __func__, ctrl->cntlid, ctrl->dh_gid);
> -		ret = nvme_auth_gen_privkey(ctrl->dh_tfm, ctrl->dh_gid);
> -		if (ret < 0) {
> -			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
> -				 __func__, ctrl->cntlid, ret);
> -			kfree_sensitive(ctrl->dh_key);
> -			ctrl->dh_key = NULL;
> -			return ret;
> -		}
> -		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
> -		kfree_sensitive(ctrl->dh_key);
> -		ctrl->dh_key = kzalloc(ctrl->dh_keysize, GFP_KERNEL);
> -		if (!ctrl->dh_key) {
> -			pr_warn("ctrl %d failed to allocate public key\n",
> -				ctrl->cntlid);
> -			return -ENOMEM;
> -		}
> -		ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
> -					   ctrl->dh_keysize);
> -		if (ret < 0) {
> -			pr_warn("ctrl %d failed to generate public key\n",
> -				ctrl->cntlid);
> -			kfree(ctrl->dh_key);
> -			ctrl->dh_key = NULL;
> -		}
> +		goto err;
> +	}
> +
> +	ctrl->dh_gid = dhgroup_id;
> +	pr_debug("%s: ctrl %d setup DH group %d\n",
> +		 __func__, ctrl->cntlid, ctrl->dh_gid);
> +	ret = nvme_auth_gen_privkey(ctrl->dh_tfm, ctrl->dh_gid);
> +	if (ret < 0) {
> +		pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
> +			 __func__, ctrl->cntlid, ret);
> +		goto err;
> +	}
> +	ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
> +	ctrl->dh_key = kzalloc(ctrl->dh_keysize, GFP_KERNEL);
> +	if (!ctrl->dh_key) {
> +		pr_warn("ctrl %d failed to allocate public key\n",
> +			ctrl->cntlid);
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
> +				   ctrl->dh_keysize);
> +	if (ret < 0) {
> +		pr_warn("ctrl %d failed to generate public key\n",
> +			ctrl->cntlid);
> +		goto err;
>   	}
>   
> +	return 0;
> +err:
> +	kfree_sensitive(ctrl->dh_key);
> +	ctrl->dh_key = NULL;
> +	crypto_free_kpp(ctrl->dh_tfm);
> +	ctrl->dh_tfm = NULL;
> +	ctrl->dh_gid = 0;
> +	ctrl->dh_keysize = 0;
>   	return ret;
>   }
>   

Still wonder if a helper wouldn't be better here.
But anyway.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

