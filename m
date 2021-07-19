Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02112C636C9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20E16115B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20E16115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZr+2KBEjdMl61tLfb45/CUnjJkmsBzgVCN2mCksEIo=; b=gcasNH8AGE4QVpgfKoxi4Zcaap
	1PwqPeghP5tzO8tuje137/kIqpdlTuCHwUtSG60JgXkcX3Ni9vt5uemxdxRK7lvtamWni/hZ9nnJe
	5HzFrI6hTkRG+nCUmswKHccenJaGCQMv2vWd9FKlRZ7pR4CgooOOAF5US/reHXtgCmbMoh2LwFLuO
	0aOsSQZFDm/m5+atEdpco68qdjXikFymyCtThF61GfRtHwwoZ6WAlyl+GZWUJfSrXjIJcgpG7Y0T8
	EXFUp1xt6K4isaRj0/wgvmd4TXf1ufo+QdEQgtw1A/vDp2dBx9cCXchb1ye5VnDlipB3On4tl2M9F
	FHEM6DIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5PSn-0093o3-0m; Mon, 19 Jul 2021 09:21:25 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5PSi-0093mH-BB
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:21:23 +0000
Received: by mail-pj1-f46.google.com with SMTP id p9so11085922pjl.3
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 02:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RxepRsSReL6KLL9VtHMr275IsSEDAJ9B4nuoTi7mv5E=;
 b=f1V9sbqhqFUw/Cjyz1SQAH1bY4pUJ0ga5JK8E6pbgMM+8RWSiYyLW2MO5r75oz5R1t
 jPCMdzNmQOkezAwl9IAfNJzmYNaThAHVE6if+c3623ut8CZOk9QUkB6SLpZ3unLa0xoc
 ysRNqIli26fV9pis168wiOZp5qR2p4xQ/ONoop38euCgNUnOccy08nR2P8TdKxd22aqQ
 xx8HozgS4v/f7wsLFgKkW9neo4b3B5x5vCSw/seF9wZ1xcwVgZW4LPNtbTsoJG5gXNla
 cpt8y8bzV/0SV/fM+iiMe6croXSeZq4ltJgQXwe9LCfmupNok+aqcty3Vqpj7ZvQrsfy
 SFMw==
X-Gm-Message-State: AOAM530a3I5qI98QBmbu291sufPHYeWRf1qwBAyYr0FytQIGYgQbND65
 aLRszPSuJ1Fd4QLWL+1h6po=
X-Google-Smtp-Source: ABdhPJy9OMiQ041lSvPRZ8JTSDeHdKEBpF1YJtg6/Ht4aM7qZc3KUcqT+FneomNWIPXnCVRpVuzCww==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id
 s8-20020a170902b188b029011b1549da31mr18322906plr.7.1626686479006; 
 Mon, 19 Jul 2021 02:21:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2ce3:950:ff23:e549?
 ([2601:647:4802:9070:2ce3:950:ff23:e549])
 by smtp.gmail.com with ESMTPSA id d12sm18880744pfv.212.2021.07.19.02.21.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 02:21:18 -0700 (PDT)
Subject: Re: [PATCH 07/11] nvme-auth: augmented challenge support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3681598b-436a-5f25-f61f-f09c6ec077a3@grimberg.me>
Date: Mon, 19 Jul 2021 02:21:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-8-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_022120_466991_E3FE9651 
X-CRM114-Status: GOOD (  31.38  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/16/21 4:04 AM, Hannes Reinecke wrote:
> Implement support for augmented challenge using FFDHE groups.

Please some more info for the change log...

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c | 403 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 371 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 448a3adebea6..754343aced19 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -8,6 +8,8 @@
>   #include <asm/unaligned.h>
>   #include <crypto/hash.h>
>   #include <crypto/kpp.h>
> +#include <crypto/dh.h>
> +#include <crypto/ffdhe.h>
>   #include "nvme.h"
>   #include "fabrics.h"
>   #include "auth.h"
> @@ -16,6 +18,8 @@ static u32 nvme_dhchap_seqnum;
>   
>   struct nvme_dhchap_context {
>   	struct crypto_shash *shash_tfm;
> +	struct crypto_shash *digest_tfm;
> +	struct crypto_kpp *dh_tfm;
>   	unsigned char *key;
>   	size_t key_len;
>   	int qid;
> @@ -25,6 +29,8 @@ struct nvme_dhchap_context {
>   	u8 status;
>   	u8 hash_id;
>   	u8 hash_len;
> +	u8 dhgroup_id;
> +	u16 dhgroup_size;
>   	u8 c1[64];
>   	u8 c2[64];
>   	u8 response[64];
> @@ -36,6 +42,94 @@ struct nvme_dhchap_context {
>   	int sess_key_len;
>   };
>   
> +struct nvme_auth_dhgroup_map {
> +	int id;
> +	const char name[16];
> +	const char kpp[16];
> +	int privkey_size;
> +	int pubkey_size;
> +} dhgroup_map[] = {
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_NULL,
> +	  .name = "NULL", .kpp = "NULL",
> +	  .privkey_size = 0, .pubkey_size = 0 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_2048,
> +	  .name = "ffdhe2048", .kpp = "dh",
> +	  .privkey_size = 256, .pubkey_size = 256 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_3072,
> +	  .name = "ffdhe3072", .kpp = "dh",
> +	  .privkey_size = 384, .pubkey_size = 384 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_4096,
> +	  .name = "ffdhe4096", .kpp = "dh",
> +	  .privkey_size = 512, .pubkey_size = 512 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_6144,
> +	  .name = "ffdhe6144", .kpp = "dh",
> +	  .privkey_size = 768, .pubkey_size = 768 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_8192,
> +	  .name = "ffdhe8192", .kpp = "dh",
> +	  .privkey_size = 1024, .pubkey_size = 1024 },
> +};
> +
> +const char *nvme_auth_dhgroup_name(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].name;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
> +
> +int nvme_auth_dhgroup_pubkey_size(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].pubkey_size;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_pubkey_size);
> +
> +int nvme_auth_dhgroup_privkey_size(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].privkey_size;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_privkey_size);
> +
> +const char *nvme_auth_dhgroup_kpp(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].kpp;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
> +
> +int nvme_auth_dhgroup_id(const char *dhgroup_name)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
> +			     strlen(dhgroup_map[i].name)))
> +			return dhgroup_map[i].id;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
> +
>   struct nvmet_dhchap_hash_map {
>   	int id;
>   	int hash_len;
> @@ -243,11 +337,16 @@ static int nvme_auth_dhchap_negotiate(struct nvme_ctrl *ctrl,
>   	data->napd = 1;
>   	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
>   	data->auth_protocol[0].dhchap.halen = 3;
> -	data->auth_protocol[0].dhchap.dhlen = 1;
> +	data->auth_protocol[0].dhchap.dhlen = 6;
>   	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_DHCHAP_HASH_SHA256;
>   	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_DHCHAP_HASH_SHA384;
>   	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_DHCHAP_HASH_SHA512;
>   	data->auth_protocol[0].dhchap.idlist[3] = NVME_AUTH_DHCHAP_DHGROUP_NULL;
> +	data->auth_protocol[0].dhchap.idlist[4] = NVME_AUTH_DHCHAP_DHGROUP_2048;
> +	data->auth_protocol[0].dhchap.idlist[5] = NVME_AUTH_DHCHAP_DHGROUP_3072;
> +	data->auth_protocol[0].dhchap.idlist[6] = NVME_AUTH_DHCHAP_DHGROUP_4096;
> +	data->auth_protocol[0].dhchap.idlist[7] = NVME_AUTH_DHCHAP_DHGROUP_6144;
> +	data->auth_protocol[0].dhchap.idlist[8] = NVME_AUTH_DHCHAP_DHGROUP_8192;
>   
>   	return size;
>   }
> @@ -274,14 +373,7 @@ static int nvme_auth_dhchap_challenge(struct nvme_ctrl *ctrl,
>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
>   		return -EPROTO;
>   	}
> -	switch (data->dhgid) {
> -	case NVME_AUTH_DHCHAP_DHGROUP_NULL:
> -		gid_name = "null";
> -		break;
> -	default:
> -		gid_name = NULL;
> -		break;
> -	}
> +	gid_name = nvme_auth_dhgroup_kpp(data->dhgid);
>   	if (!gid_name) {
>   		dev_warn(ctrl->device,
>   			 "qid %d: DH-HMAC-CHAP: invalid DH group id %d\n",
> @@ -290,10 +382,24 @@ static int nvme_auth_dhchap_challenge(struct nvme_ctrl *ctrl,
>   		return -EPROTO;
>   	}
>   	if (data->dhgid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
> -		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> -		return -EPROTO;
> -	}
> -	if (data->dhgid == NVME_AUTH_DHCHAP_DHGROUP_NULL && data->dhvlen != 0) {
> +		if (data->dhvlen == 0) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: DH-HMAC-CHAP: empty DH value\n",
> +				 chap->qid);
> +			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> +			return -EPROTO;
> +		}
> +		chap->dh_tfm = crypto_alloc_kpp(gid_name, 0, 0);
> +		if (IS_ERR(chap->dh_tfm)) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: DH-HMAC-CHAP: failed to initialize %s\n",
> +				 chap->qid, gid_name);
> +			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> +			chap->dh_tfm = NULL;
> +			return -EPROTO;

Why not propogate the error?

> +		}
> +		chap->dhgroup_id = data->dhgid;
> +	} else if (data->dhvlen != 0) {
>   		dev_warn(ctrl->device,
>   			 "qid %d: DH-HMAC-CHAP: invalid DH value for NULL DH\n",
>   			chap->qid);
> @@ -313,6 +419,16 @@ static int nvme_auth_dhchap_challenge(struct nvme_ctrl *ctrl,
>   	chap->hash_len = data->hl;
>   	chap->s1 = le32_to_cpu(data->seqnum);
>   	memcpy(chap->c1, data->cval, chap->hash_len);
> +	if (data->dhvlen) {
> +		chap->ctrl_key = kmalloc(data->dhvlen, GFP_KERNEL);
> +		if (!chap->ctrl_key)
> +			return -ENOMEM;
> +		chap->ctrl_key_len = data->dhvlen;
> +		memcpy(chap->ctrl_key, data->cval + chap->hash_len,
> +		       data->dhvlen);
> +		dev_dbg(ctrl->device, "ctrl public key %*ph\n",
> +			 (int)chap->ctrl_key_len, chap->ctrl_key);
> +	}
>   
>   	return 0;
>   }
> @@ -353,10 +469,13 @@ static int nvme_auth_dhchap_reply(struct nvme_ctrl *ctrl,
>   		memcpy(data->rval + chap->hash_len, chap->c2,
>   		       chap->hash_len);
>   	}
> -	if (chap->host_key_len)
> +	if (chap->host_key_len) {
> +		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
> +			__func__, chap->qid,
> +			chap->host_key_len, chap->host_key);
>   		memcpy(data->rval + 2 * chap->hash_len, chap->host_key,
>   		       chap->host_key_len);
> -
> +	}

Is this change only adding the debug print?

>   	return size;
>   }
>   
> @@ -440,23 +559,10 @@ static int nvme_auth_dhchap_failure2(struct nvme_ctrl *ctrl,
>   int nvme_auth_select_hash(struct nvme_ctrl *ctrl,
>   			  struct nvme_dhchap_context *chap)
>   {
> -	char *hash_name;
> +	const char *hash_name, *digest_name;
>   	int ret;
>   
> -	switch (chap->hash_id) {
> -	case NVME_AUTH_DHCHAP_HASH_SHA256:
> -		hash_name = "hmac(sha256)";
> -		break;
> -	case NVME_AUTH_DHCHAP_HASH_SHA384:
> -		hash_name = "hmac(sha384)";
> -		break;
> -	case NVME_AUTH_DHCHAP_HASH_SHA512:
> -		hash_name = "hmac(sha512)";
> -		break;
> -	default:
> -		hash_name = NULL;
> -		break;
> -	}
> +	hash_name = nvme_auth_hmac_name(chap->hash_id);
>   	if (!hash_name) {
>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>   		return -EPROTO;
> @@ -468,26 +574,100 @@ int nvme_auth_select_hash(struct nvme_ctrl *ctrl,
>   		chap->shash_tfm = NULL;
>   		return -EPROTO;
>   	}
> +	digest_name = nvme_auth_digest_name(chap->hash_id);
> +	if (!digest_name) {
> +		crypto_free_shash(chap->shash_tfm);
> +		chap->shash_tfm = NULL;
> +		return -EPROTO;
> +	}
> +	chap->digest_tfm = crypto_alloc_shash(digest_name, 0, 0);
> +	if (IS_ERR(chap->digest_tfm)) {
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +		crypto_free_shash(chap->shash_tfm);
> +		chap->shash_tfm = NULL;
> +		chap->digest_tfm = NULL;
> +		return -EPROTO;
> +	}
>   	if (!chap->key) {
>   		dev_warn(ctrl->device, "qid %d: cannot select hash, no key\n",
>   			 chap->qid);
>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +		crypto_free_shash(chap->digest_tfm);
>   		crypto_free_shash(chap->shash_tfm);
>   		chap->shash_tfm = NULL;
> +		chap->digest_tfm = NULL;
>   		return -EINVAL;

Please have a structured goto targets in reverse order, this repeated
cleanup is a mess...

>   	}
>   	ret = crypto_shash_setkey(chap->shash_tfm, chap->key, chap->key_len);
>   	if (ret) {
>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +		crypto_free_shash(chap->digest_tfm);
>   		crypto_free_shash(chap->shash_tfm);
>   		chap->shash_tfm = NULL;
> +		chap->digest_tfm = NULL;
>   		return ret;
>   	}
> -	dev_info(ctrl->device, "qid %d: DH-HMAC_CHAP: selected hash %s\n",
> -		 chap->qid, hash_name);
> +	dev_dbg(ctrl->device, "qid %d: DH-HMAC_CHAP: selected hash %s\n",
> +		chap->qid, hash_name);
>   	return 0;
>   }
>   
> +static int nvme_auth_augmented_challenge(struct nvme_dhchap_context *chap,
> +					 u8 *challenge, u8 *aug)
> +{
> +	struct crypto_shash *tfm;
> +	struct shash_desc *desc;
> +	u8 *hashed_key;
> +	const char *hash_name;
> +	int ret;
> +
> +	hashed_key = kmalloc(chap->hash_len, GFP_KERNEL);
> +	if (!hashed_key)
> +		return -ENOMEM;
> +
> +	ret = crypto_shash_tfm_digest(chap->digest_tfm, chap->sess_key,
> +				      chap->sess_key_len, hashed_key);
> +	if (ret < 0) {
> +		pr_debug("failed to hash session key, err %d\n", ret);
> +		kfree(hashed_key);

Same here...

> +		return ret;
> +	}

Spaces between if conditions please?

> +	hash_name = crypto_shash_alg_name(chap->shash_tfm);
> +	if (!hash_name) {
> +		pr_debug("Invalid hash algoritm\n");
> +		return -EINVAL;
> +	}
> +	tfm = crypto_alloc_shash(hash_name, 0, 0);
> +	if (IS_ERR(tfm)) {
> +		ret = PTR_ERR(tfm);
> +		goto out_free_key;
> +	}
> +	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> +		       GFP_KERNEL);
> +	if (!desc) {
> +		ret = -ENOMEM;
> +		goto out_free_hash;
> +	}
> +	desc->tfm = tfm;
> +
> +	ret = crypto_shash_setkey(tfm, hashed_key, chap->hash_len);
> +	if (ret)
> +		goto out_free_desc;
> +	ret = crypto_shash_init(desc);
> +	if (ret)
> +		goto out_free_desc;
> +	crypto_shash_update(desc, challenge, chap->hash_len);
> +	crypto_shash_final(desc, aug);
> +
> +out_free_desc:
> +	kfree_sensitive(desc);
> +out_free_hash:
> +	crypto_free_shash(tfm);
> +out_free_key:
> +	kfree(hashed_key);
> +	return ret;
> +}
> +
>   static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
>   					  struct nvme_dhchap_context *chap)
>   {
> @@ -497,6 +677,16 @@ static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
>   
>   	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
>   		__func__, chap->qid, chap->s1, chap->transaction);
> +	if (chap->dh_tfm) {
> +		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
> +		if (!challenge) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		ret = nvme_auth_augmented_challenge(chap, chap->c1, challenge);
> +		if (ret)
> +			goto out;
> +	}
>   	shash->tfm = chap->shash_tfm;
>   	ret = crypto_shash_init(shash);
>   	if (ret)
> @@ -532,6 +722,8 @@ static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
>   		goto out;
>   	ret = crypto_shash_final(shash, chap->response);
>   out:
> +	if (challenge != chap->c1)
> +		kfree(challenge);
>   	return ret;
>   }
>   
> @@ -542,6 +734,17 @@ static int nvme_auth_dhchap_ctrl_response(struct nvme_ctrl *ctrl,
>   	u8 buf[4], *challenge = chap->c2;
>   	int ret;
>   
> +	if (chap->dh_tfm) {
> +		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
> +		if (!challenge) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		ret = nvme_auth_augmented_challenge(chap, chap->c2,
> +						    challenge);
> +		if (ret)
> +			goto out;
> +	}
>   	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
>   		__func__, chap->qid, chap->s2, chap->transaction);
>   	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
> @@ -585,6 +788,8 @@ static int nvme_auth_dhchap_ctrl_response(struct nvme_ctrl *ctrl,
>   		goto out;
>   	ret = crypto_shash_final(shash, chap->response);
>   out:
> +	if (challenge != chap->c2)
> +		kfree(challenge);

Just free ?! what about failing?

>   	return ret;
>   }
>   
> @@ -644,10 +849,134 @@ int nvme_auth_generate_key(struct nvme_ctrl *ctrl,
>   	return 0;
>   }
>   
> +static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
> +					struct nvme_dhchap_context *chap)
> +{
> +	struct kpp_request *req;
> +	struct crypto_wait wait;
> +	struct scatterlist src, dst;
> +	u8 *pkey;
> +	int ret, pkey_len;
> +
> +	if (chap->dhgroup_id == NVME_AUTH_DHCHAP_DHGROUP_2048 ||
> +	    chap->dhgroup_id == NVME_AUTH_DHCHAP_DHGROUP_3072 ||
> +	    chap->dhgroup_id == NVME_AUTH_DHCHAP_DHGROUP_4096 ||
> +	    chap->dhgroup_id == NVME_AUTH_DHCHAP_DHGROUP_6144 ||
> +	    chap->dhgroup_id == NVME_AUTH_DHCHAP_DHGROUP_8192) {
> +		struct dh p = {0};
> +		int pubkey_size = nvme_auth_dhgroup_pubkey_size(chap->dhgroup_id);
> +
> +		ret = crypto_ffdhe_params(&p, pubkey_size << 3);
> +		if (ret) {
> +			dev_dbg(ctrl->device,
> +				"failed to generate ffdhe params, error %d\n",
> +				ret);
> +			return ret;
> +		}
> +		p.key = chap->key;
> +		p.key_size = chap->key_len;
> +
> +		pkey_len = crypto_dh_key_len(&p);
> +		pkey = kzalloc(pkey_len, GFP_KERNEL);
> +
> +		get_random_bytes(pkey, pkey_len);
> +		ret = crypto_dh_encode_key(pkey, pkey_len, &p);
> +		if (ret) {
> +			dev_dbg(ctrl->device,
> +				"failed to encode pkey, error %d\n", ret);
> +			kfree(pkey);
> +			return ret;
> +		}
> +		chap->host_key_len = pubkey_size;
> +		chap->sess_key_len = pubkey_size;
> +	} else {
> +		dev_warn(ctrl->device, "Invalid DH group id %d\n",
> +			 chap->dhgroup_id);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INVALID_PAYLOAD;
> +		return -EINVAL;
> +	}
> +
> +	ret = crypto_kpp_set_secret(chap->dh_tfm, pkey, pkey_len);
> +	if (ret) {
> +		dev_dbg(ctrl->dev, "failed to set secret, error %d\n", ret);
> +		kfree(pkey);
> +		return ret;
> +	}
> +	req = kpp_request_alloc(chap->dh_tfm, GFP_KERNEL);
> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto out_free_exp;
> +	}
> +
> +	chap->host_key = kzalloc(chap->host_key_len, GFP_KERNEL);
> +	if (!chap->host_key) {
> +		ret = -ENOMEM;
> +		goto out_free_req;
> +	}
> +	crypto_init_wait(&wait);
> +	kpp_request_set_input(req, NULL, 0);
> +	sg_init_one(&dst, chap->host_key, chap->host_key_len);
> +	kpp_request_set_output(req, &dst, chap->host_key_len);
> +	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				 crypto_req_done, &wait);
> +
> +	ret = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
> +	if (ret == -EOVERFLOW) {
> +		dev_dbg(ctrl->dev,
> +			"public key buffer too small, wants %d is %d\n",
> +			crypto_kpp_maxsize(chap->dh_tfm), chap->host_key_len);
> +		goto out_free_host;

Is this a specific retcode of intereset? Why did you specifically add
special casing here?

> +	} else if (ret) {
> +		dev_dbg(ctrl->dev,
> +			"failed to generate public key, error %d\n", ret);
> +		goto out_free_host;
> +	}
> +
> +	chap->sess_key = kmalloc(chap->sess_key_len, GFP_KERNEL);
> +	if (!chap->sess_key)
> +		goto out_free_host;
> +
> +	crypto_init_wait(&wait);
> +	sg_init_one(&src, chap->ctrl_key, chap->ctrl_key_len);
> +	kpp_request_set_input(req, &src, chap->ctrl_key_len);
> +	sg_init_one(&dst, chap->sess_key, chap->sess_key_len);
> +	kpp_request_set_output(req, &dst, chap->sess_key_len);
> +	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				 crypto_req_done, &wait);
> +
> +	ret = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
> +	if (ret) {
> +		dev_dbg(ctrl->dev,
> +			"failed to generate shared secret, error %d\n", ret);
> +		kfree_sensitive(chap->sess_key);
> +		chap->sess_key = NULL;
> +		chap->sess_key_len = 0;
> +	} else
> +		dev_dbg(ctrl->dev, "shared secret %*ph\n",
> +			 (int)chap->sess_key_len, chap->sess_key);
> +out_free_host:
> +	if (ret) {
> +		kfree(chap->host_key);
> +		chap->host_key = NULL;
> +		chap->host_key_len = 0;
> +	}
> +out_free_req:
> +	kpp_request_free(req);
> +out_free_exp:
> +	kfree_sensitive(pkey);
> +	if (ret)
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INVALID_PAYLOAD;
> +	return ret;
> +}
> +
>   void nvme_auth_free(struct nvme_dhchap_context *chap)
>   {
>   	if (chap->shash_tfm)
>   		crypto_free_shash(chap->shash_tfm);
> +	if (chap->digest_tfm)
> +		crypto_free_shash(chap->digest_tfm);
> +	if (chap->dh_tfm)
> +		crypto_free_kpp(chap->dh_tfm);
>   	if (chap->key)
>   		kfree(chap->key);
>   	if (chap->ctrl_key)
> @@ -732,6 +1061,15 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>   	if (ret)
>   		goto fail2;
>   
> +	if (chap->ctrl_key_len) {
> +		dev_dbg(ctrl->device,
> +			"%s: qid %d DH-HMAC-DHAP DH exponential\n",
> +			__func__, qid);
> +		ret = nvme_auth_dhchap_exponential(ctrl, chap);
> +		if (ret)
> +			goto fail2;
> +	}
> +
>   	dev_dbg(ctrl->device, "%s: qid %d DH-HMAC-CHAP host response\n",
>   		__func__, qid);
>   	ret = nvme_auth_dhchap_host_response(ctrl, chap);
> @@ -806,6 +1144,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>   		ret = -EPROTO;
>   	if (!ret) {
>   		ctrl->dhchap_hash = chap->hash_id;
> +		ctrl->dhchap_dhgroup = chap->dhgroup_id;
>   	}
>   	kfree(buf);
>   	nvme_auth_free(chap);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
