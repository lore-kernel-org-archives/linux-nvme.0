Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3E3CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKHJZriYKa36rbi9ZopYAoHYEAve1fWaR/i30QYt0uo=; b=T4vx797g4JUamC2ib5YYKX2tMB
	ZoGrO5R7zfZncL3Cde1RleEEQo8XS5Wmi49oZ60Mty8YmMiLgwUSfvUh7MrFl0JyvSstpj+J9al4x
	LhiXRK0CIVz9F57roKzmWIhhTnGcTrKHi73nZUcWO9e02vaUzgSqkJLhYOfh+0xqLQS1eLyrQvfVW
	/YO5qt1JN36AvvRKTLmdtMdKIkpml4p443HPuUkL+NTDxAh6Rb8hb4Nml+zeMbqc8KINgQDi1I++r
	V/D2NdTNZe247/ETGlNZzh9HZZOdS8m6BQb2w8dZR+mTPWyhTZ0f2RkkFALf9YFaRyxIK6/OhQaZF
	g11ZE5/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaH3-0000000DZSp-44aY;
	Sun, 07 Apr 2024 21:42:01 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaGz-0000000DZR7-45FV
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:42:00 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343d32aba7eso819625f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526115; x=1713130915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKHJZriYKa36rbi9ZopYAoHYEAve1fWaR/i30QYt0uo=;
        b=j7o2DA2b+NGOvcgaJaG67LEaouzEGsAStjfgs/Y/MgJaK/WHK2ssAV2rNDjAR9x9Y5
         CzL7A6Dm/BBR5dP7GdRZa2sLI7b0q8qve+pGGfNKGyZI8jKN3lSLkCWg58+wSWDVtmLu
         Da694+wPBog3tNmZaeGCIaBDK0Y6wNPTXkT5UTlaBJvhE+FZT362C/lK2un0zh19lEmL
         +6F0KY1AgILZnVaGSpb0D7j5MvSWj8iXIw8fPbWIbP/qUeFiQM1Pd9njXSDUxQOkh/N9
         Jinfl6QZHvV9+U9blCCmbKHucJ6oCipXkut2lwo3lMAZcXbFPsd5Yxqra09DGGXgh4uA
         W0cw==
X-Forwarded-Encrypted: i=1; AJvYcCVzCVySCZ4TAoMEZ/Hfs8CSkA8Pw4fLGCk0H7x4klHZ7M1IUKD+97OG94nnJ0vqbJTH44y0myDWxB/9O58il6OBZS2aTkltXYm6VttXibs=
X-Gm-Message-State: AOJu0YzWgZB1DGOd15hqoJduyhdNe2aAOCU/h4333q0CbnnnYyV/1ZzJ
	Ppo9xr3xKSe1NtvANYarYaRUHgyNWmogi+NQ42LhKH5yLAAJVMe1ri6Xj0ZA
X-Google-Smtp-Source: AGHT+IFTEYd45UhJCqCrUNv6Wgs6mCvjqTP+iA47TXkePnYbxSUvgR7MyVyDLN4wsu/69t7EPQnrLw==
X-Received: by 2002:a05:600c:5106:b0:416:2f7e:b0db with SMTP id o6-20020a05600c510600b004162f7eb0dbmr5774376wms.2.1712526114822;
        Sun, 07 Apr 2024 14:41:54 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id e23-20020a05600c4b9700b004163703fd6asm4717846wmp.1.2024.04.07.14.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:41:54 -0700 (PDT)
Message-ID: <7102826f-b92c-4546-a351-159b8a7dd233@grimberg.me>
Date: Mon, 8 Apr 2024 00:41:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] nvme-tcp: request secure channel concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-12-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-12-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_144158_226482_419A5BBE 
X-CRM114-Status: GOOD (  38.29  )
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



On 18/03/2024 17:03, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Add a fabrics option 'concat' to request secure channel concatenation.

maybe name it secconcat ? or secure_concat ?

> When secure channel concatenation is enabled a 'generated PSK' is inserted
> into the keyring such that it's available after reset.

Umm, I'm not sure what this means? Is this the revoke action? what if
the user passes a keyring? I'm not entirely sure what is the interface 
semantics here.

>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c    | 108 ++++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/fabrics.c |  25 ++++++++-
>   drivers/nvme/host/fabrics.h |   3 +
>   drivers/nvme/host/sysfs.c   |   2 +
>   drivers/nvme/host/tcp.c     |  53 ++++++++++++++++--
>   include/linux/nvme.h        |   7 +++
>   6 files changed, 186 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a264b3ae078b..a4033a8f9607 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -12,6 +12,7 @@
>   #include "nvme.h"
>   #include "fabrics.h"
>   #include <linux/nvme-auth.h>
> +#include <linux/nvme-keyring.h>
>   
>   #define CHAP_BUF_SIZE 4096
>   static struct kmem_cache *nvme_chap_buf_cache;
> @@ -131,7 +132,12 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
>   	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
>   	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>   	data->t_id = cpu_to_le16(chap->transaction);
> -	data->sc_c = 0; /* No secure channel concatenation */
> +	if (!ctrl->opts->concat || chap->qid != 0)
> +		data->sc_c = NVME_AUTH_SECP_NOSC;
> +	else if (ctrl->opts->tls_key)
> +		data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
> +	else
> +		data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
>   	data->napd = 1;
>   	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
>   	data->auth_protocol[0].dhchap.halen = 3;
> @@ -311,8 +317,9 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>   	data->hl = chap->hash_len;
>   	data->dhvlen = cpu_to_le16(chap->host_key_len);
>   	memcpy(data->rval, chap->response, chap->hash_len);
> -	if (ctrl->ctrl_key) {
> +	if (ctrl->ctrl_key)
>   		chap->bi_directional = true;
> +	if (ctrl->ctrl_key || ctrl->opts->concat) {
>   		get_random_bytes(chap->c2, chap->hash_len);
>   		data->cvalid = 1;
>   		memcpy(data->rval + chap->hash_len, chap->c2,
> @@ -322,7 +329,10 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>   	} else {
>   		memset(chap->c2, 0, chap->hash_len);
>   	}
> -	chap->s2 = nvme_auth_get_seqnum();
> +	if (ctrl->opts->concat)
> +		chap->s2 = 0;
> +	else
> +		chap->s2 = nvme_auth_get_seqnum();
>   	data->seqnum = cpu_to_le32(chap->s2);
>   	if (chap->host_key_len) {
>   		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
> @@ -677,6 +687,79 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
>   		crypto_free_kpp(chap->dh_tfm);
>   }
>   
> +static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
> +				   struct nvme_dhchap_queue_context *chap)
> +{
> +	u8 *psk, *digest, *tls_psk;
> +	struct key *tls_key;
> +	size_t psk_len;
> +	int ret = 0;
> +
> +	if (!chap->sess_key) {
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d no session key negotiated\n",
> +			 __func__, chap->qid);
> +		return -ENOKEY;
> +	}
> +
> +	psk = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
> +				     chap->sess_key_len,
> +				     chap->c1, chap->c2,
> +				     chap->hash_len, &psk_len);
> +	if (IS_ERR(psk)) {
> +		ret = PTR_ERR(psk);
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to generate PSK, error %d\n",
> +			 __func__, chap->qid, ret);
> +		return ret;
> +	}
> +	dev_dbg(ctrl->device,
> +		  "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
> +
> +	digest = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
> +					   ctrl->opts->subsysnqn,
> +					   ctrl->opts->host->nqn);
> +	if (IS_ERR(digest)) {
> +		ret = PTR_ERR(digest);
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to generate digest, error %d\n",
> +			 __func__, chap->qid, ret);
> +		goto out_free_psk;
> +	};
> +	dev_dbg(ctrl->device, "%s: generated digest %s\n",
> +		 __func__, digest);
> +	tls_psk = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest);
> +	if (IS_ERR(tls_psk)) {
> +		ret = PTR_ERR(tls_psk);
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to derive TLS psk, error %d\n",
> +			 __func__, chap->qid, ret);
> +		goto out_free_digest;
> +	};
> +
> +	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl->opts->host->nqn,
> +				       ctrl->opts->subsysnqn, chap->hash_id,
> +				       true, tls_psk, psk_len, digest);
> +	if (IS_ERR(tls_key)) {
> +		ret = PTR_ERR(tls_key);
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to insert generated key, error %d\n",
> +			 __func__, chap->qid, ret);
> +		tls_key = NULL;
> +		kfree_sensitive(tls_psk);
> +	}
> +	if (ctrl->opts->tls_key) {
> +		key_revoke(ctrl->opts->tls_key);
> +		key_put(ctrl->opts->tls_key);
> +	}

Question, is this for the case where the user passes both tls_key and
concat? Is this something that we expect users to do? What is the
benefit?

> +	ctrl->opts->tls_key = tls_key;
> +out_free_digest:
> +	kfree_sensitive(digest);
> +out_free_psk:
> +	kfree_sensitive(psk);
> +	return ret;
> +}
> +
>   static void nvme_queue_auth_work(struct work_struct *work)
>   {
>   	struct nvme_dhchap_queue_context *chap =
> @@ -831,10 +914,21 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   		if (ret)
>   			chap->error = ret;
>   	}
> -	if (!ret) {
> +	if (ret)
> +		goto fail2;
> +	if (chap->qid || !ctrl->opts->concat) {
>   		chap->error = 0;
>   		return;
>   	}
> +	ret = nvme_auth_secure_concat(ctrl, chap);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to enable secure concatenation\n",
> +			 __func__, chap->qid);
> +		chap->error = ret;
> +	} else
> +		chap->error = 0;
> +	return;
>   
>   fail2:
>   	if (chap->status == 0)
> @@ -912,6 +1006,12 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
>   			 "qid 0: authentication failed\n");
>   		return;
>   	}
> +	/*
> +	* Only run authentication on the admin queue for
> +	* secure concatenation
> +	 */
> +	if (ctrl->opts->concat)
> +		return;
>   
>   	for (q = 1; q < ctrl->queue_count; q++) {
>   		ret = nvme_auth_negotiate(ctrl, q);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 75aa69457353..ae091e0e4ecf 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -463,8 +463,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   	result = le32_to_cpu(res.u32);
>   	ctrl->cntlid = result & 0xFFFF;
>   	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
> -		/* Secure concatenation is not implemented */
> -		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
> +		/* Check for secure concatenation */
> +		if ((result & NVME_CONNECT_AUTHREQ_ASCR) &&
> +		    !ctrl->opts->concat) {
>   			dev_warn(ctrl->device,
>   				 "qid 0: secure concatenation is not supported\n");

Perhaps the log msg should be adjusted as well.

>   			ret = NVME_SC_AUTH_REQUIRED;
> @@ -682,6 +683,7 @@ static const match_table_t opt_tokens = {
>   #endif
>   #ifdef CONFIG_NVME_TCP_TLS
>   	{ NVMF_OPT_TLS,			"tls"			},
> +	{ NVMF_OPT_CONCAT,		"concat"		},
>   #endif
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
> @@ -711,6 +713,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->tls = false;
>   	opts->tls_key = NULL;
>   	opts->keyring = NULL;
> +	opts->concat = false;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -1029,6 +1032,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tls = true;
>   			break;
> +		case NVMF_OPT_CONCAT:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			opts->concat = true;
> +			break;

Isn't there a dependency with a dhchap auth rquested? meaning what 
happens if the user
did not pass a dhchap_secret?

>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> @@ -1055,6 +1066,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
>   				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>   	}
> +	if (opts->concat && opts->tls) {
> +		pr_err("Secure concatenation over TLS is not supported\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (opts->concat && opts->tls_key) {
> +		pr_err("Cannot specify a TLS key for secure concatenation\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   
>   	opts->host = nvmf_host_add(hostnqn, &hostid);
>   	if (IS_ERR(opts->host)) {
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 06cc54851b1b..accfc7228366 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -73,6 +73,7 @@ enum {
>   	NVMF_OPT_TLS		= 1 << 25,
>   	NVMF_OPT_KEYRING	= 1 << 26,
>   	NVMF_OPT_TLS_KEY	= 1 << 27,
> +	NVMF_OPT_CONCAT		= 1 << 28,
>   };
>   
>   /**
> @@ -108,6 +109,7 @@ enum {
>    * @keyring:    Keyring to use for key lookups
>    * @tls_key:    TLS key for encrypted connections (TCP)
>    * @tls:        Start TLS encrypted connections (TCP)
> + * @concat:     Enabled Secure channel concatenation (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
>    * @data_digest: generate/verify data digest (TCP)
> @@ -137,6 +139,7 @@ struct nvmf_ctrl_options {
>   	struct key		*keyring;
>   	struct key		*tls_key;
>   	bool			tls;
> +	bool			concat;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
>   	bool			data_digest;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 07ec26de2d91..edd96f501d8a 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -675,6 +675,8 @@ static ssize_t tls_key_show(struct device *dev,
>   
>   	if (!key)
>   		return 0;
> +	if (ctrl->opts->concat)
> +		return 0;
>   	if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
>   	    test_bit(KEY_FLAG_INVALIDATED, &key->flags))
>   		return -EKEYREVOKED;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 66675b2dc197..94152ded123a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -219,7 +219,7 @@ static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
>   	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>   		return 0;
>   
> -	return ctrl->opts->tls;
> +	return ctrl->opts->tls || ctrl->opts->concat;
>   }
>   
>   static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *queue)
> @@ -1941,7 +1941,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	if (nvme_tcp_tls_configured(ctrl)) {
>   		if (ctrl->opts->tls_key)
>   			pskid = key_serial(ctrl->opts->tls_key);
> -		else {
> +		else if (ctrl->opts->tls) {
>   			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
>   						      ctrl->opts->host->nqn,
>   						      ctrl->opts->subsysnqn);
> @@ -1973,12 +1973,28 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	key_serial_t pskid = ctrl->tls_key ? key_serial(ctrl->tls_key) : 0;
>   	int i, ret;
>   
> -	if (nvme_tcp_tls_configured(ctrl) && !pskid) {
> -		dev_err(ctrl->device, "no PSK negotiated\n");
> -		return -ENOKEY;
> +	if (nvme_tcp_tls_configured(ctrl)) {
> +		if (ctrl->opts->concat) {
> +			/*
> +			 * The generated PSK is stored in the
> +			 * fabric options
> +			 */
> +			if (!ctrl->opts->tls_key) {
> +				dev_err(ctrl->device, "no PSK generated\n");
> +				return -ENOKEY;
> +			}
> +			if (pskid && pskid != key_serial(ctrl->opts->tls_key)) {
> +				dev_err(ctrl->device, "Stale PSK id %08x\n", pskid);
> +				pskid = 0;
> +			}
> +		} else if (!pskid) {
> +			dev_err(ctrl->device, "no PSK negotiated\n");
> +			return -ENOKEY;
> +		}
>   	}
>   
>   	for (i = 1; i < ctrl->queue_count; i++) {
> +		WARN_ON(nvme_tcp_tls_enabled(&tcp_ctrl->queues[i]));
>   		ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
>   		if (ret)
>   			goto out_free_queues;
> @@ -2203,6 +2219,26 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   	}
>   }
>   
> +static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opts->concat)
> +		return;
> +	/* No key generated, nothing to do */
> +	if (!ctrl->opts->tls_key)
> +		return;
> +	/*
> +	 * Key generated, and TLS enabled:
> +	 * Revoke the generated key.
> +	 */
> +	if (ctrl->tls_key) {
> +		dev_dbg(ctrl->device, "Wipe generated TLS PSK %08x\n",
> +			key_serial(ctrl->opts->tls_key));
> +		key_revoke(ctrl->opts->tls_key);
> +		key_put(ctrl->opts->tls_key);
> +		ctrl->opts->tls_key = NULL;
> +	}
> +}
> +
>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->opts;
> @@ -2304,6 +2340,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   				struct nvme_tcp_ctrl, err_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
> +	nvme_tcp_revoke_generated_tls_key(ctrl);
>   	nvme_stop_keep_alive(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	nvme_tcp_teardown_io_queues(ctrl, false);
> @@ -2343,6 +2380,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   	struct nvme_ctrl *ctrl =
>   		container_of(work, struct nvme_ctrl, reset_work);
>   
> +	nvme_tcp_revoke_generated_tls_key(ctrl);
>   	nvme_stop_ctrl(ctrl);
>   	nvme_tcp_teardown_ctrl(ctrl, false);
>   
> @@ -2632,6 +2670,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   
>   	len = nvmf_get_address(ctrl, buf, size);
>   
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		return len;
> +
>   	mutex_lock(&queue->queue_lock);
>   
>   	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> @@ -2817,7 +2858,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
>   			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
> -			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
> +			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index ce0c1143c7e4..b29310424ee1 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1663,6 +1663,13 @@ enum {
>   	NVME_AUTH_DHGROUP_INVALID	= 0xff,
>   };
>   
> +enum {
> +	NVME_AUTH_SECP_NOSC		= 0x00,
> +	NVME_AUTH_SECP_SC		= 0x01,
> +	NVME_AUTH_SECP_NEWTLSPSK	= 0x02,
> +	NVME_AUTH_SECP_REPLACETLSPSK	= 0x03,
> +};
> +
>   union nvmf_auth_protocol {
>   	struct nvmf_auth_dhchap_protocol_descriptor dhchap;
>   };


