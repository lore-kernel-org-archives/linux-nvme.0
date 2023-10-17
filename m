Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4A6CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9a68sPqMx7ZDloMDTxc3vrp5wWlq8916xmtAhXYTPxw=; b=qMIv5GsZ8wZp1p/w4QLQrspAtc
	WT4bn7GIctAVeM1sdxI0lhZpHYbLeBMUGIZa9rS72YQCgfpgCvv45S2rtVR/hukHmzWGhNVn4j5no
	K9DR3z79slcC709tNpEPd++XYZGBR2S8daqzGmRDBN2ytF421NSbDLhroEVKbNO7EtbbHuTPsXUMe
	Pu+ebxTyMRFOrlyidY/1ABv6K32bZ9F5fw9/uLddcrFkEvqrQ81Ivz+L8DzB/TQ5YmQ11BoX7J486
	XQ8N4tSabWKWrZdui2M8iw80Slkrnm/sfdh6lgZqjQUnhXhFoSXhoooC91K/MSUizt6jE20yVLVUJ
	NONXOOig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdCo-00BLkk-24;
	Tue, 17 Oct 2023 06:05:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdCl-00BLju-08
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 06:05:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BE1421CEE;
	Tue, 17 Oct 2023 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697522717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9a68sPqMx7ZDloMDTxc3vrp5wWlq8916xmtAhXYTPxw=;
	b=AR/YzopelNXSOq2AqfXPMxQzNEuNXtWtqhscK5sPt3sUkqFZhL9OSHb9JyaQ3CTfaxHCZ6
	n5Qow8P6HBKlN+Qg0RRfEhrbl/TJynjpkTZ5O7oaSAEw3gxKhbjjayD6whZSYmsNEMCycc
	Yrcfh3qKB4ju5F3zLm7ITBhS5KNqPyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697522717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9a68sPqMx7ZDloMDTxc3vrp5wWlq8916xmtAhXYTPxw=;
	b=2dxcQ/KmBSHhBa1maVaUrwgPx0BDD3ZoG0mqTgulub5JHWvH8KaYTjR8hs+8Hlhmpm7C+L
	0d4KeLospKO2jAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBE4D13597;
	Tue, 17 Oct 2023 06:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id DUD9NxwkLmWIAQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 17 Oct 2023 06:05:16 +0000
Message-ID: <26154d3a-54b9-4775-b3a9-ce65c64bb7fd@suse.de>
Date: Tue, 17 Oct 2023 08:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org, Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231016225857.3085234-1-shiftee@posteo.net>
 <20231016225857.3085234-2-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231016225857.3085234-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-8.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_230523_982093_6170BB63 
X-CRM114-Status: GOOD (  16.06  )
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

On 10/17/23 00:58, Mark O'Donovan wrote:
> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>   drivers/nvme/common/auth.c | 26 +++++++++++++++-----------
>   include/linux/nvme-auth.h  |  3 ++-
>   2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index d90e4f0c08b7..225fc474e34a 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -163,14 +163,9 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>   	p = strrchr(secret, ':');
>   	if (p)
>   		allocated_len = p - secret;
> -	key = kzalloc(sizeof(*key), GFP_KERNEL);
> +	key = nvme_auth_alloc_key(allocated_len, 0);
>   	if (!key)
>   		return ERR_PTR(-ENOMEM);
> -	key->key = kzalloc(allocated_len, GFP_KERNEL);
> -	if (!key->key) {
> -		ret = -ENOMEM;
> -		goto out_free_key;
> -	}
>   
>   	key_len = base64_decode(secret, allocated_len, key->key);
>   	if (key_len < 0) {
> @@ -213,19 +208,28 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>   	key->hash = key_hash;
>   	return key;
>   out_free_secret:
> -	kfree_sensitive(key->key);
> -out_free_key:
> -	kfree(key);
> +	nvme_auth_free_key(key);
>   	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
>   
> +struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
> +{
> +	struct nvme_dhchap_key *key = kzalloc(len + sizeof(*key), GFP_KERNEL);
> +
> +	if (key) {
> +		key->len = len;
> +		key->hash = hash;
> +	}
> +	return key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
> +
>   void nvme_auth_free_key(struct nvme_dhchap_key *key)
>   {
>   	if (!key)
>   		return;
> -	kfree_sensitive(key->key);
> -	kfree(key);
> +	kfree_sensitive(key);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_free_key);
>   
> diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
> index dcb8030062dd..df96940be930 100644
> --- a/include/linux/nvme-auth.h
> +++ b/include/linux/nvme-auth.h
> @@ -9,9 +9,9 @@
>   #include <crypto/kpp.h>
>   
>   struct nvme_dhchap_key {
> -	u8 *key;
>   	size_t len;
>   	u8 hash;
> +	u8 key[];
>   };
>   
>   u32 nvme_auth_get_seqnum(void);
> @@ -27,6 +27,7 @@ u8 nvme_auth_hmac_id(const char *hmac_name);
>   struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>   					      u8 key_hash);
>   void nvme_auth_free_key(struct nvme_dhchap_key *key);
> +struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
>   u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
>   int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
>   int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
Good idea.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


