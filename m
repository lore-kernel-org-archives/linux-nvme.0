Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A5BC3DA5D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m3s6Vb0tPPKI/R4wEgLfNKDPB8u6sGMp1fLsYAaPLQI=; b=dwYLrvIIWyNWPjDgfSIa/Vhibw
	5+paodnN3h324hlpzQs/QNpVRNZnaCAZGF57Ds4EaE74Lpg/xP1mxowQsGnJ8E6AswpLND9viwTxD
	9vMcmTGh3KWUhs0BP0rlGBVYg1KyyXpvFsQ/gPTQGMJpVVM5QNZ7qeOeRb4GGVFvx21iTnAYrUOFK
	Hl3Z2ffRgvf/cVNFKFODqZyuNgqMKmH9oAee6hw4W3IkL1tQfI5VSXanGw05uaf0krWChIxC3tbC9
	mvyOYIAtnUzUj+9RNAhCKNnXmyMH2+9ASO2xItYu641Kj8s6lx5HQ9IFlQSBnPSySdCSdbgZrfd8e
	K4i0dU6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUiy-00000006j6p-1WqZ;
	Sun, 21 Jul 2024 11:27:32 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUiv-00000006j4d-0x9n
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:27:30 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368633ca4ffso313942f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721561247; x=1722166047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3s6Vb0tPPKI/R4wEgLfNKDPB8u6sGMp1fLsYAaPLQI=;
        b=HvluXz72cGRB7yLA+PA3Eng8fz58siS4NYatamfWfVzxICD3JHP+XPDonSSNZxs0eG
         KqR1xVmzu12e3eLpvcVROpIQ+D1zrumnrYCmuEctzHbGdLxR1SgXOKbHyVE0E6w1u9RA
         ukXJ02LksdyBV3dmAl9IADmBE0nX6WCGAruAuML9xH1iY5tcg5APWFrSzGWJPBRnhb7d
         eT8eJzHBWWpLNsoP+fRBGda6nqyniQVivqBg7FIW4qDrwMx7U9MDAbSpI+e2jUYJuy4Y
         AJacQTIbDBx0oO2kYfGKP3J2SH/A/QEyYz9qm5K9Cwt6FMzsTPsPhp1b4Nq26IOzosvP
         6AOg==
X-Forwarded-Encrypted: i=1; AJvYcCU31WLEAijN/MlZc7fNMof9RJ+jhmKgmZArdjKzo7ImrPnbYXQJRIKNzvwXf2Mjj8h0JSn9Ae68UyGnlSjXpZ1ARJEeZ856IBEWyM/1f5c=
X-Gm-Message-State: AOJu0YwtvZhnJogaiXXcCHL2kmMXR3W2EDpNirmOi9f7pVNhgoSZQk+C
	gU2JObnMpHZniq5/aWYWd0sKu8rJJPEP04VllhuYPORy5kOXbxBJECUsAg==
X-Google-Smtp-Source: AGHT+IH/aAwPWFLTr7u4mevBdhJKFsyTGSgIU5e3qBBhaphqY5k1T9de11h6j4hkDwNQQKEVIAdZ1Q==
X-Received: by 2002:a5d:6c69:0:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-369b6768e99mr2145873f8f.2.1721561246875;
        Sun, 21 Jul 2024 04:27:26 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684253sm5886025f8f.4.2024.07.21.04.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:27:26 -0700 (PDT)
Message-ID: <271ab7cc-d766-4527-805f-a20107998beb@grimberg.me>
Date: Sun, 21 Jul 2024 14:27:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: request secure channel concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240718150658.99580-1-hare@kernel.org>
 <20240718150658.99580-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240718150658.99580-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_042729_323088_D958FC4D 
X-CRM114-Status: GOOD (  38.03  )
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




On 18/07/2024 18:06, Hannes Reinecke wrote:
> Add a fabrics option 'concat' to request secure channel concatenation.
> When secure channel concatenation is enabled a 'generated PSK' is inserted
> into the keyring such that it's available after reset.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/auth.c    | 100 ++++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/fabrics.c |  34 ++++++++++--
>   drivers/nvme/host/fabrics.h |   3 ++
>   drivers/nvme/host/tcp.c     |  56 +++++++++++++++++---
>   include/linux/nvme.h        |   7 +++
>   5 files changed, 188 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 371e14f0a203..5f71aa7b5e27 100644
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
> @@ -677,6 +687,76 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
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
> +	ret = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
> +				     chap->sess_key_len,
> +				     chap->c1, chap->c2,
> +				     chap->hash_len, &psk, &psk_len);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to generate PSK, error %d\n",
> +			 __func__, chap->qid, ret);
> +		return ret;
> +	}
> +	dev_dbg(ctrl->device,
> +		  "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
> +
> +	ret = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
> +					ctrl->opts->subsysnqn,
> +					ctrl->opts->host->nqn, &digest);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "%s: qid %d failed to generate digest, error %d\n",
> +			 __func__, chap->qid, ret);
> +		goto out_free_psk;
> +	};
> +	dev_dbg(ctrl->device, "%s: generated digest %s\n",
> +		 __func__, digest);
> +	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest, &tls_psk);
> +	if (ret) {
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

Any reason why error in nvme_tls_psk_refres() does not goto the normal 
error handling? Is it acceptable to fail here? Maybe I'm missing 
something...
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
> @@ -833,6 +913,14 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   	}
>   	if (!ret) {
>   		chap->error = 0;
> +		/* Secure concatenation can only be enabled on the admin queue */
> +		if (!chap->qid && ctrl->opts->concat &&
> +		    (ret = nvme_auth_secure_concat(ctrl, chap))) {
> +			dev_warn(ctrl->device,
> +				 "%s: qid %d failed to enable secure concatenation\n",
> +				 __func__, chap->qid);
> +			chap->error = ret;
> +		}
>   		return;
>   	}
>   
> @@ -912,6 +1000,12 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
>   			 "qid 0: authentication failed\n");
>   		return;
>   	}
> +	/*
> +	 * Only run authentication on the admin queue for
> +	 * secure concatenation
> +	 */
> +	if (ctrl->opts->concat)
> +		return;
>   
>   	for (q = 1; q < ctrl->queue_count; q++) {
>   		ret = nvme_auth_negotiate(ctrl, q);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 432efcbf9e2f..93e9041b9657 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -472,8 +472,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
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
>   			ret = -EOPNOTSUPP;
> @@ -550,7 +551,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   		/* Secure concatenation is not implemented */
>   		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>   			dev_warn(ctrl->device,
> -				 "qid 0: secure concatenation is not supported\n");
> +				 "qid %d: secure concatenation is not supported\n", qid);
>   			ret = -EOPNOTSUPP;
>   			goto out_free_data;
>   		}
> @@ -706,6 +707,7 @@ static const match_table_t opt_tokens = {
>   #endif
>   #ifdef CONFIG_NVME_TCP_TLS
>   	{ NVMF_OPT_TLS,			"tls"			},
> +	{ NVMF_OPT_CONCAT,		"concat"		},
>   #endif
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
> @@ -735,6 +737,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->tls = false;
>   	opts->tls_key = NULL;
>   	opts->keyring = NULL;
> +	opts->concat = false;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -1053,6 +1056,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> @@ -1079,6 +1090,23 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
>   				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>   	}
> +	if (opts->concat) {
> +		if (opts->tls) {
> +			pr_err("Secure concatenation over TLS is not supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		if (opts->tls_key) {
> +			pr_err("Cannot specify a TLS key for secure concatenation\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}

I think you mean it is unsupported?

> +		if (!opts->dhchap_secret) {
> +			pr_err("Need to enable DH-CHAP for secure concatenation\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
>   
>   	opts->host = nvmf_host_add(hostnqn, &hostid);
>   	if (IS_ERR(opts->host)) {
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 21d75dc4a3a0..9cf5b020adba 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -66,6 +66,7 @@ enum {
>   	NVMF_OPT_TLS		= 1 << 25,
>   	NVMF_OPT_KEYRING	= 1 << 26,
>   	NVMF_OPT_TLS_KEY	= 1 << 27,
> +	NVMF_OPT_CONCAT		= 1 << 28,
>   };
>   
>   /**
> @@ -101,6 +102,7 @@ enum {
>    * @keyring:    Keyring to use for key lookups
>    * @tls_key:    TLS key for encrypted connections (TCP)
>    * @tls:        Start TLS encrypted connections (TCP)
> + * @concat:     Enabled Secure channel concatenation (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
>    * @data_digest: generate/verify data digest (TCP)
> @@ -130,6 +132,7 @@ struct nvmf_ctrl_options {
>   	struct key		*keyring;
>   	struct key		*tls_key;
>   	bool			tls;
> +	bool			concat;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
>   	bool			data_digest;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5885aa452aa1..b748e4033df2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -227,7 +227,7 @@ static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
>   	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>   		return 0;
>   
> -	return ctrl->opts->tls;
> +	return ctrl->opts->tls || ctrl->opts->concat;
>   }
>   
>   static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *queue)
> @@ -1942,7 +1942,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	if (nvme_tcp_tls_configured(ctrl)) {
>   		if (ctrl->opts->tls_key)
>   			pskid = key_serial(ctrl->opts->tls_key);
> -		else {
> +		else if (ctrl->opts->tls) {
>   			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
>   						      ctrl->opts->host->nqn,
>   						      ctrl->opts->subsysnqn);
> @@ -1972,9 +1972,25 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	int i, ret;
>   
> -	if (nvme_tcp_tls_configured(ctrl) && !ctrl->tls_pskid) {
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
> +			if (ctrl->tls_pskid &&
> +			    ctrl->tls_pskid != key_serial(ctrl->opts->tls_key)) {
> +				dev_err(ctrl->device, "Stale PSK id %08x\n", ctrl->tls_pskid);
> +				ctrl->tls_pskid = 0;
> +			}

What is the user supposed to do with a stale psk? meaning why print an error
and continue as usual?

> +		} else if (!ctrl->tls_pskid) {
> +			dev_err(ctrl->device, "no PSK negotiated\n");
> +			return -ENOKEY;
> +		}
>   	}
>   
>   	for (i = 1; i < ctrl->queue_count; i++) {
> @@ -2205,6 +2221,30 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
>   	}
>   }
>   
> +/*
> + * The TLS key needs to be revoked when:
> + * - concatenation is enabled and
> + *   -> This is a generated key and only valid for this session
> + * - the generated key is present in ctrl->tls_key and
> + *   -> authentication has completed and the key has been generated
> + * - tls has been enabled
> + *   -> otherwise we are about to reset the admin queue after authentication
> + *      to enable TLS with the generated key
> + */
> +static bool nvme_tcp_key_revoke_needed(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->opts->concat && ctrl->opts->tls_key && ctrl->tls_pskid;
> +}
> +
> +static void nvme_tcp_revoke_tls_key(struct nvme_ctrl *ctrl)
> +{
> +	dev_dbg(ctrl->device, "Wipe generated TLS PSK %08x\n",
> +		key_serial(ctrl->opts->tls_key));
> +	key_revoke(ctrl->opts->tls_key);
> +	key_put(ctrl->opts->tls_key);
> +	ctrl->opts->tls_key = NULL;
> +}

I think this belongs in a common place no?

> +
>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->opts;
> @@ -2308,6 +2348,8 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   				struct nvme_tcp_ctrl, err_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
> +	if (nvme_tcp_key_revoke_needed(ctrl))
> +		nvme_tcp_revoke_tls_key(ctrl);

Should this maybe move to nvme_tcp_teardown_admin_qeueue ?

>   	nvme_stop_keep_alive(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	nvme_tcp_teardown_io_queues(ctrl, false);
> @@ -2348,6 +2390,8 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	if (nvme_tcp_key_revoke_needed(ctrl))
> +		nvme_tcp_revoke_tls_key(ctrl);

Would eliminate this call...

