Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D0D10389
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDYkrDXhGeOncItQZBSy+CQR9/YE0qzvieyADreltSs=; b=Rc1KPNglOk3/mygsgNBJp1KCaV
	1SEEudqMM0DKYbVbwFnhD6OZnAKEGqTGFudy+pBJ9lzvD8VuCNHeJ6zVj0n/H/u22aeXTANolS9mg
	yL+xuE2HPdxuW4S5P7AcO9HyEcav18I3tuBBFLEl0lIC6gkDUJ2BJdfS7XGhWBbTROQx38Aw6kzbW
	JmYIcJ+0woCSCOEMjqZVmQ/hYG+F9pAhDg3QliQIj7U3Azp6SHIkciwV2HRB58oLdUv80I51Ci3QR
	fu85dQlXqUWT/iCPt2QhsTRn6WFsLH2d2kuquzJIH8T2EDk25tlWN3zWfA0CWWPTn16WxqsCfWF8d
	6yy0nQRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOA7r-0000000EX8V-3gQt;
	Wed, 26 Nov 2025 07:39:43 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOA7o-0000000EX89-13UQ
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 07:39:41 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b427cda88so4292838f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 23:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764142778; x=1764747578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDYkrDXhGeOncItQZBSy+CQR9/YE0qzvieyADreltSs=;
        b=Csxa2eH+6H3/B6QAsZdGIKXmhzNYIO8foixPpZPwwdVw7pF9xXKj84b+bWnCbxLtjf
         hEEyFT/MB/Bg+K8sMP/lirq4tdumqQYF5npD2fk/7K/zVAQuq3aZ4GdFsaW807f18x4c
         +vWQxKg4HZfNHBi8DFBymu+HPnA5zJv4NTlRTL4N21yjNYe0yawgYVAl5HAYEvxJ6udP
         nkHGqzotg0Pmeo3Cf6Wdxu1e78FaZOFaDkiFDNOOwWPemXE8+H57NEamkipnRg+kTdT5
         jMauDt+45FhC9eEspTDv31KD8+SH9q8j1t3QAW3xP4wdH2HYZG+c96orKh/F4JsqjSQ2
         qMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIMi5P98nZOzMJp0Otk9Z56PduQkub/ETgV/CbXdQ5XufBjqbEfPfwPFQYte66jLKZgWODujFPuQba@lists.infradead.org
X-Gm-Message-State: AOJu0YzC9GxMIJmGre70lASHSzwIv/b7kNU8q3/R77Z6FW8I2xz4oGYC
	vHc9OEHYcslAveye6YzyRmtEJ2aNu/NKWFn+h5ALvq9qSHZj/sf98As3fXrr5w==
X-Gm-Gg: ASbGncuJH6IU64isoGVRv73Ezxc/HnnX8GdiE3KXfdMt7nAO+xhqUBRfhrjBjH2QD4Y
	J9PBfLwAUFeW50EWW9SRYFyRYldGkoz0H9HCG65FSPYX7uwtaHjGHkIZWwR4s0Ftzqrxb5kYvrf
	KqfcyIFtnQ9k8G6QxFuaMC9rxdufbqT5OFs4zNXV3+CA/mzdp8b+kBLfC2dQuSDL6PXRt1aSDXb
	puiQTvcHZhNh5IUYpYiR3YqrYbuc49h7Szn7q9jd/Wif44bdl3PjmYjydusQW/m1SewjWJS7uf1
	STcM6jnGtC8DWmvSJXX3xDgfobS2fmF9fener4gL721ZwpBOBPszpdC80sNpoDqypVn8xxaTuh1
	qAcD/eefSFOrPf/QS9ZRp4gA0l0fdNDF+b+CB/cuby201aD3LBQyl3sxIQFQPtaqYSv5XbOTmva
	MNt17mWGLFnqlvWVkcbmeZ2w094GfuV0qXyD0k3WGnxjEaYJjH5WRN
X-Google-Smtp-Source: AGHT+IHNIdtnwD9lhnrh7apCh2ZU4PAkxCee72/fOPCexH8yQYEfFH0rIx3lkXWxyEC0hFsVN4uYXw==
X-Received: by 2002:a05:6000:1445:b0:42b:3bc4:16c9 with SMTP id ffacd0b85a97d-42cc1d19364mr19307557f8f.51.1764142778241;
        Tue, 25 Nov 2025 23:39:38 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm38774891f8f.15.2025.11.25.23.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 23:39:37 -0800 (PST)
Message-ID: <c01b35d7-d1a6-467e-b3e8-a1aa3d613f2d@grimberg.me>
Date: Wed, 26 Nov 2025 09:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] nvme-auth: modify nvme_auth_transform_key() to return
 status
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_233940_513603_60120171 
X-CRM114-Status: GOOD (  22.32  )
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

Patch title is misleading. The addition is the transformed secret output...

On 28/05/2025 17:05, Hannes Reinecke wrote:
> Modify nvme_auth_transform_key() to return a status and provide
> the transformed data as argument on the command line as raw data.

The patch is missing the why explanation. I mean it looks fine, its unclear
why we need this change.

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/common/auth.c | 72 +++++++++++++++++++++++---------------
>   drivers/nvme/host/auth.c   | 40 +++++++++++----------
>   drivers/nvme/target/auth.c | 36 +++++++++----------
>   include/linux/nvme-auth.h  |  4 +--
>   4 files changed, 85 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 3b6d759bcdf2..918c92cbd8c5 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -237,70 +237,86 @@ void nvme_auth_free_key(struct nvme_dhchap_key *key)
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_free_key);
>   
> -struct nvme_dhchap_key *nvme_auth_transform_key(
> -		struct nvme_dhchap_key *key, char *nqn)
> +int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
> +			    u8 **transformed_secret)
>   {
>   	const char *hmac_name;
>   	struct crypto_shash *key_tfm;
>   	SHASH_DESC_ON_STACK(shash, key_tfm);
> -	struct nvme_dhchap_key *transformed_key;
> -	int ret, key_len;
> +	u8 *transformed_data;
> +	u8 *key_data;
> +	size_t transformed_len;
> +	int ret;
>   
>   	if (!key) {
>   		pr_warn("No key specified\n");
> -		return ERR_PTR(-ENOKEY);
> +		return -ENOKEY;
>   	}
> +	key_data = kzalloc(key->len, GFP_KERNEL);
> +	if (!key_data)
> +		return -ENOMEM;
> +	memcpy(key_data, key->key, key->len);
>   	if (key->hash == 0) {
> -		key_len = nvme_auth_key_struct_size(key->len);
> -		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
> -		if (!transformed_key)
> -			return ERR_PTR(-ENOMEM);
> -		return transformed_key;
> +		*transformed_secret = key_data;
> +		return key->len;
>   	}
>   	hmac_name = nvme_auth_hmac_name(key->hash);
>   	if (!hmac_name) {
>   		pr_warn("Invalid key hash id %d\n", key->hash);
> -		return ERR_PTR(-EINVAL);
> +		ret = -EINVAL;
> +		goto out_free_data;
>   	}
>   
>   	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
> -	if (IS_ERR(key_tfm))
> -		return ERR_CAST(key_tfm);
> +	if (IS_ERR(key_tfm)) {
> +		ret = PTR_ERR(key_tfm);
> +		goto out_free_data;
> +	}
>   
> -	key_len = crypto_shash_digestsize(key_tfm);
> -	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
> -	if (!transformed_key) {
> +	transformed_len = crypto_shash_digestsize(key_tfm);
> +	if (transformed_len != key->len) {
> +		pr_warn("incompatible digest size %ld for key (hash %s, len %ld)\n",
> +			transformed_len, hmac_name, key->len);
> +		ret = -EINVAL;
> +		goto out_free_tfm;
> +	}
> +
> +	transformed_data = kzalloc(transformed_len, GFP_KERNEL);
> +	if (!transformed_data) {
>   		ret = -ENOMEM;
> -		goto out_free_key;
> +		goto out_free_tfm;
>   	}
>   
>   	shash->tfm = key_tfm;
>   	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
>   	if (ret < 0)
> -		goto out_free_transformed_key;
> +		goto out_free_transformed_data;
>   	ret = crypto_shash_init(shash);
>   	if (ret < 0)
> -		goto out_free_transformed_key;
> +		goto out_free_transformed_data;
>   	ret = crypto_shash_update(shash, nqn, strlen(nqn));
>   	if (ret < 0)
> -		goto out_free_transformed_key;
> +		goto out_free_transformed_data;
>   	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
>   	if (ret < 0)
> -		goto out_free_transformed_key;
> -	ret = crypto_shash_final(shash, transformed_key->key);
> +		goto out_free_transformed_data;
> +	ret = crypto_shash_final(shash, transformed_data);
>   	if (ret < 0)
> -		goto out_free_transformed_key;
> +		goto out_free_transformed_data;
>   
>   	crypto_free_shash(key_tfm);
> +	*transformed_secret = transformed_data;
>   
> -	return transformed_key;
> +	return transformed_len;
>   
> -out_free_transformed_key:
> -	nvme_auth_free_key(transformed_key);
> -out_free_key:
> +out_free_transformed_data:
> +	kfree(transformed_data);
> +out_free_tfm:
>   	crypto_free_shash(key_tfm);
> +out_free_data:
> +	kfree(key_data);
>   
> -	return ERR_PTR(ret);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
>   
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index f6ddbe553289..9e7c2e889ee0 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -24,7 +24,8 @@ struct nvme_dhchap_queue_context {
>   	struct nvme_ctrl *ctrl;
>   	struct crypto_shash *shash_tfm;
>   	struct crypto_kpp *dh_tfm;
> -	struct nvme_dhchap_key *transformed_key;
> +	u8 *transformed_secret;
> +	size_t transformed_len;
>   	void *buf;
>   	int qid;
>   	int error;
> @@ -437,21 +438,20 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>   	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
>   		__func__, chap->qid, chap->s1, chap->transaction);
>   
> -	if (!chap->transformed_key) {
> -		chap->transformed_key = nvme_auth_transform_key(ctrl->host_key,
> -						ctrl->opts->host->nqn);
> -		if (IS_ERR(chap->transformed_key)) {
> -			ret = PTR_ERR(chap->transformed_key);
> -			chap->transformed_key = NULL;
> +	if (!chap->transformed_secret) {
> +		ret = nvme_auth_transform_key(ctrl->host_key,
> +					      ctrl->opts->host->nqn,
> +					      &chap->transformed_secret);
> +		if (ret < 0)
>   			return ret;
> -		}
> +		chap->transformed_len = ret;
>   	} else {
>   		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
>   			__func__, chap->qid);
>   	}
>   
>   	ret = crypto_shash_setkey(chap->shash_tfm,
> -			chap->transformed_key->key, chap->transformed_key->len);
> +			chap->transformed_secret, chap->transformed_len);
>   	if (ret) {
>   		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>   			 chap->qid, ret);
> @@ -517,19 +517,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
>   		struct nvme_dhchap_queue_context *chap)
>   {
>   	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
> -	struct nvme_dhchap_key *transformed_key;
> +	u8 *transformed_secret;
> +	size_t transformed_len;
>   	u8 buf[4], *challenge = chap->c2;
>   	int ret;
>   
> -	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
> -				ctrl->opts->subsysnqn);
> -	if (IS_ERR(transformed_key)) {
> -		ret = PTR_ERR(transformed_key);
> +	ret = nvme_auth_transform_key(ctrl->ctrl_key,
> +			ctrl->opts->subsysnqn,
> +			&transformed_secret);
> +	if (ret < 0)
>   		return ret;
> -	}
> +	transformed_len = ret;
>   
>   	ret = crypto_shash_setkey(chap->shash_tfm,
> -			transformed_key->key, transformed_key->len);
> +			transformed_secret, transformed_len);
>   	if (ret) {
>   		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>   			 chap->qid, ret);
> @@ -595,7 +596,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
>   out:
>   	if (challenge != chap->c2)
>   		kfree(challenge);
> -	nvme_auth_free_key(transformed_key);
> +	kfree(transformed_secret);
>   	return ret;
>   }
>   
> @@ -657,8 +658,9 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
>   
>   static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
>   {
> -	nvme_auth_free_key(chap->transformed_key);
> -	chap->transformed_key = NULL;
> +	kfree(chap->transformed_secret);
> +	chap->transformed_secret = NULL;
> +	chap->transformed_len = 0;
>   	kfree_sensitive(chap->host_key);
>   	chap->host_key = NULL;
>   	chap->host_key_len = 0;
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index b340380f3892..c70d9d259a7f 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -297,7 +297,8 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	const char *hash_name;
>   	u8 *challenge = req->sq->dhchap_c1;
> -	struct nvme_dhchap_key *transformed_key;
> +	u8 *transformed_secret;
> +	size_t transformed_len;
>   	u8 buf[4];
>   	int ret;
>   
> @@ -321,15 +322,14 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   		goto out_free_tfm;
>   	}
>   
> -	transformed_key = nvme_auth_transform_key(ctrl->host_key,
> -						  ctrl->hostnqn);
> -	if (IS_ERR(transformed_key)) {
> -		ret = PTR_ERR(transformed_key);
> +	ret = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn,
> +				      &transformed_secret);
> +	if (ret < 0)
>   		goto out_free_tfm;
> -	}
>   
> -	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
> -				  transformed_key->len);
> +	transformed_len = ret;
> +	ret = crypto_shash_setkey(shash_tfm, transformed_secret,
> +				  transformed_len);
>   	if (ret)
>   		goto out_free_response;
>   
> @@ -389,7 +389,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   	if (challenge != req->sq->dhchap_c1)
>   		kfree(challenge);
>   out_free_response:
> -	nvme_auth_free_key(transformed_key);
> +	kfree(transformed_secret);
>   out_free_tfm:
>   	crypto_free_shash(shash_tfm);
>   	return ret;
> @@ -403,7 +403,8 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	const char *hash_name;
>   	u8 *challenge = req->sq->dhchap_c2;
> -	struct nvme_dhchap_key *transformed_key;
> +	u8 *transformed_secret;
> +	size_t transformed_len;
>   	u8 buf[4];
>   	int ret;
>   
> @@ -427,15 +428,14 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
>   		goto out_free_tfm;
>   	}
>   
> -	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
> -						ctrl->subsysnqn);
> -	if (IS_ERR(transformed_key)) {
> -		ret = PTR_ERR(transformed_key);
> +	ret = nvme_auth_transform_key(ctrl->ctrl_key, ctrl->subsysnqn,
> +				      &transformed_secret);
> +	if (ret < 0)
>   		goto out_free_tfm;
> -	}
> +	transformed_len = ret;
>   
> -	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
> -				  transformed_key->len);
> +	ret = crypto_shash_setkey(shash_tfm, transformed_secret,
> +				  transformed_len);
>   	if (ret)
>   		goto out_free_response;
>   
> @@ -500,7 +500,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
>   	if (challenge != req->sq->dhchap_c2)
>   		kfree(challenge);
>   out_free_response:
> -	nvme_auth_free_key(transformed_key);
> +	kfree(transformed_secret);
>   out_free_tfm:
>   	crypto_free_shash(shash_tfm);
>   	return ret;
> diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
> index 60e069a6757f..fd43fa042c88 100644
> --- a/include/linux/nvme-auth.h
> +++ b/include/linux/nvme-auth.h
> @@ -29,8 +29,8 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>   					      u8 key_hash);
>   void nvme_auth_free_key(struct nvme_dhchap_key *key);
>   struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
> -struct nvme_dhchap_key *nvme_auth_transform_key(
> -				struct nvme_dhchap_key *key, char *nqn);
> +int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
> +			    u8 **transformed_secret) ;
>   int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
>   int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
>   				  u8 *challenge, u8 *aug, size_t hlen);


