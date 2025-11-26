Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B7FD10390
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ql5gmDRcSmGhm/1tJwEO1QU46VuLQkS2pKco4NpJrK8=; b=Sa2+QqPhnpd7Kkw75WQNS52c9Q
	jh0N+fxHaq5HpV1BMsHP26IxtlOL0IZHUcui6Jk2fjC1MXfs2YrIFpY3BoeHPhRSDPqNeVCsiDii8
	ZX7RZJj6uGtuCIH+aOn7Ji0FY2E6BGeUUL0d61+SD+Dz6ge8lVPzmGGMKu5yCHuYRRtdXffRZUhxb
	JVA72KPN7cGPtHdBGX0LM9pkogTuxvdl+agAZL5YwMkSIuBt2KcPadlHXtgRhshoWJUGr3SvULLJf
	2bQaYfNUHhetpswcjfd5J7OCeucUQngI06icl2c5v5LVyHuEHxeX/2Z2OzwOFydEisJpIcB+hjpgX
	CYJDTRaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBS0-0000000Eg2W-0Cx6;
	Wed, 26 Nov 2025 09:04:36 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBRx-0000000Eg12-0gBL
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 09:04:34 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so52942235e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Nov 2025 01:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147871; x=1764752671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql5gmDRcSmGhm/1tJwEO1QU46VuLQkS2pKco4NpJrK8=;
        b=tvdCY+U0vQeAYE0E4H7Dsg9aMicMFs2jM+O02wMFim3TXWbgc6wGW8O/BEInLyRJor
         D/JhRDVk6C+EoSfNxNlOWHN/aFUMCEVdKPRwQpzZiNUm9bGk596xiCdWiSYyAggmlzjJ
         BiJjItLcSgvex0e5CjByn9t3UF3KuQx5rqwMe3RiZPSEY8NcPUn3UaGaANVeZ3l19t8Q
         ORckfmPGQc/LhgXYqWgfPCV+P/Ry09A0sKJ2sHWssX4ncWmAGhlM1RuxeQK66x13vo4W
         G6XMLLfBtqhogOybjcjuYMwI9ykjg00GJ56YpBaZnsmnxSBYayF6aLA0ZhY8B8o/hGH8
         x2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5pGpY4ZtRZWbhnboHJlCtlHOBZRxqDCFkENG6x/rUcb0opvnla/AN8Xa+ibSiqSa82Rsub4WsGvIL@lists.infradead.org
X-Gm-Message-State: AOJu0YxY/kYQ2kFTvDZsW7CZrDaI47kIlyeb2h1sQfeHPSk7q1S0WF4V
	CWC5lSC4K6thhFbaXZMrrYDUANze4IZjYaG20ubCTayPGLCsAtqzqwPY
X-Gm-Gg: ASbGncsgjafVa/QQrFXE7pg8O2ynl47N9hVc9rsMDhSJbVKX6BkHWN5YLwES4Mu/ymi
	3De1bHPxCUXHsXASe1dceIgetLdTQFsk22dwbEXSWycZFi2TBC3zkS60yEvhweMKkqRklTqWlGC
	yKnTnSvZX28Vp9f+MjOGElWYAsIEDQAfFpSWU0MnoaLfbKolYk4RmxOhz9vWNh77IxfiYuebJDu
	r7UK4jMLtkMiLINimpqBv2hdGzbrwVB7AJE4ypvMwsz1b+Zq02l0RvkSwnIN5wJdvZtbmkLOl4/
	CZm5FucN/nwtdVfmgT7Bxfr9k+AHjRW+p1PT/MNbvkeJMBTy2VvwiJjzrQUlzGblhNCt11w9J+Q
	8mSHlkMRvF92vF9SWRNGbmn4RVavFcQsp5OXELKz/r3HeEcogud7vYq37F0jDU7lkOQFXi3pn9G
	M0SRiIaHxMoWy951UysnkXSlfxUHJnvfyHdXAbj41tYz9x2KTdSom/
X-Google-Smtp-Source: AGHT+IGGnCsy41qz42UNsKvj5okkhTgnbf0LT8UqxKw+b/bz45xdB1WgX3I2K08fEiofGHagVfi/VA==
X-Received: by 2002:a05:600c:8b37:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47904b1ab30mr60848685e9.16.1764147871124;
        Wed, 26 Nov 2025 01:04:31 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add5b80sm33295815e9.6.2025.11.26.01.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:04:30 -0800 (PST)
Message-ID: <3503bcbe-2498-4f1a-a433-9cce622fe5c2@grimberg.me>
Date: Wed, 26 Nov 2025 11:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] nvme: parse dhchap keys during option parsing
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-5-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_010433_251801_8DADA9B1 
X-CRM114-Status: GOOD (  24.96  )
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



On 28/05/2025 17:05, Hannes Reinecke wrote:
> We really should parse the dhchap keys during option parsing to avoid
> having to pass around the plain dhchap secret. During options parsing
> we will create a 'dhchap' key with a random UUID as description, and
> store the key serial in the 'opts' structure.
> This simplifies key handling as on every access the key needs to be
> looked up and checked for validity before accessing the key data.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/auth.c    | 113 ++++++++++++++++------
>   drivers/nvme/host/fabrics.c |  82 +++++++++++-----
>   drivers/nvme/host/fabrics.h |   8 +-
>   drivers/nvme/host/sysfs.c   | 185 ++++++++++++++++++++++++++----------
>   4 files changed, 278 insertions(+), 110 deletions(-)
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index c5be0c13e85b..0e8a5b544f63 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -532,7 +532,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
>   	ret = crypto_shash_setkey(chap->shash_tfm,
>   			transformed_secret, transformed_len);
>   	if (ret) {
> -		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
> +		dev_warn(ctrl->device, "qid %d: failed to set ctrl key, error %d\n",
>   			 chap->qid, ret);
>   		goto out;
>   	}
> @@ -970,11 +970,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>   		return -ENOKEY;
>   	}
>   
> -	if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
> -		dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
> -		return -ENOKEY;
> -	}
> -
>   	chap = &ctrl->dhchap_ctxs[qid];
>   	cancel_work_sync(&chap->auth_work);
>   	queue_work(nvme_auth_wq, &chap->auth_work);
> @@ -1059,6 +1054,26 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
>   	}
>   }
>   
> +static void nvme_auth_clear_key(struct nvme_ctrl *ctrl, bool is_ctrl)
> +{
> +	struct key *key;
> +
> +	if (is_ctrl) {
> +		key = ctrl->ctrl_key;
> +		ctrl->ctrl_key = NULL;
> +	} else {
> +		key = ctrl->host_key;
> +		ctrl->host_key = NULL;
> +	}
> +	if (key) {
> +		dev_dbg(ctrl->device, "%s: revoke%s key %08x\n",
> +			__func__, is_ctrl ? " ctrl" : "",
> +			key_serial(key));
> +		key_revoke(key);
> +		key_put(key);
> +	}
> +}
> +
>   int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_dhchap_queue_context *chap;
> @@ -1068,31 +1083,70 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>   	if (!ctrl->opts)
>   		return 0;
> -	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
> -					       ctrl->opts->dhchap_secret,
> -					       strlen(ctrl->opts->dhchap_secret));
> -	if (IS_ERR(ctrl->host_key)) {
> -		ret = PTR_ERR(ctrl->host_key);
> -		ctrl->host_key = NULL;
> -		return ret;
> +	if (!ctrl->opts->dhchap_key) {
> +		nvme_auth_clear_key(ctrl, false);
> +		nvme_auth_clear_key(ctrl, true);

consider adding nvme_auth_clear_host_key and nvme_auth_clear_ctrl_key 
helpers.
> +		return 0;
>   	}
> -	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
> -					       ctrl->opts->dhchap_ctrl_secret,
> -					       strlen(ctrl->opts->dhchap_ctrl_secret));
> -	if (IS_ERR(ctrl->ctrl_key)) {
> -		ret = PTR_ERR(ctrl->ctrl_key);
> -		ctrl->ctrl_key = NULL;
> -		goto err_free_dhchap_secret;
> +
> +	if (ctrl->host_key)
> +		nvme_auth_clear_key(ctrl, false);
> +
> +	ctrl->host_key = key_get(ctrl->opts->dhchap_key);
> +	if (!ctrl->host_key) {
> +		dev_warn(ctrl->device,
> +			 "dhchap key %08x not present\n",
> +			 key_serial(ctrl->opts->dhchap_key));
> +		return -ENOKEY;
> +	}
> +	down_read(&ctrl->host_key->sem);
> +	ret = key_validate(ctrl->host_key);
> +	up_read(&ctrl->host_key->sem);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "dhchap key %08x invalidated\n",
> +			 key_serial(ctrl->host_key));
> +		key_put(ctrl->host_key);
> +		ctrl->host_key = NULL;
> +		return -ENOKEY;
>   	}
> +	dev_dbg(ctrl->device,
> +		"%s: using dhchap key %08x\n",
> +		__func__, key_serial(ctrl->host_key));
>   
> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
> -		return 0;
> +	if (ctrl->ctrl_key)
> +		nvme_auth_clear_key(ctrl, true);
> +
> +	if (ctrl->opts->dhchap_ctrl_key) {
> +		ctrl->ctrl_key = key_get(ctrl->opts->dhchap_ctrl_key);
> +		if (!ctrl->ctrl_key) {
> +			dev_warn(ctrl->device,
> +				 "dhchap ctrl key %08x not present\n",
> +				 key_serial(ctrl->opts->dhchap_ctrl_key));
> +			return -ENOKEY;
> +		}
> +		down_read(&ctrl->ctrl_key->sem);
> +		ret = key_validate(ctrl->ctrl_key);
> +		up_read(&ctrl->ctrl_key->sem);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				 "dhchap ctrl key %08x invalidated\n",
> +				 key_serial(ctrl->ctrl_key));
> +			key_put(ctrl->ctrl_key);
> +			ctrl->ctrl_key = NULL;
> +			return -EKEYREVOKED;
> +		}
> +		dev_dbg(ctrl->device,
> +			"%s: using dhchap ctrl key %08x\n",
> +			__func__, key_serial(ctrl->ctrl_key));
> +	}
>   
>   	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
>   				sizeof(*chap), GFP_KERNEL);
>   	if (!ctrl->dhchap_ctxs) {
> -		ret = -ENOMEM;
> -		goto err_free_dhchap_ctrl_secret;
> +		nvme_auth_clear_key(ctrl, true);
> +		nvme_auth_clear_key(ctrl, false);
> +		return -ENOMEM;
>   	}
>   
>   	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
> @@ -1104,13 +1158,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   	}
>   
>   	return 0;
> -err_free_dhchap_ctrl_secret:
> -	key_put(ctrl->ctrl_key);
> -	ctrl->ctrl_key = NULL;
> -err_free_dhchap_secret:
> -	key_put(ctrl->host_key);
> -	ctrl->host_key = NULL;
> -	return ret;
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
>   
> @@ -1130,10 +1177,14 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
>   		kfree(ctrl->dhchap_ctxs);
>   	}
>   	if (ctrl->host_key) {
> +		dev_dbg(ctrl->device, "%s: drop host key %08x\n",
> +			__func__, key_serial(ctrl->host_key));
>   		key_put(ctrl->host_key);
>   		ctrl->host_key = NULL;
>   	}
>   	if (ctrl->ctrl_key) {
> +		dev_dbg(ctrl->device, "%s: drop ctrl key %08x\n",
> +			__func__, key_serial(ctrl->ctrl_key));
>   		key_put(ctrl->ctrl_key);
>   		ctrl->ctrl_key = NULL;
>   	}
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 93e9041b9657..009a6cf8a86b 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -12,6 +12,7 @@
>   #include <linux/seq_file.h>
>   #include "nvme.h"
>   #include "fabrics.h"
> +#include <linux/nvme-auth.h>
>   #include <linux/nvme-keyring.h>
>   
>   static LIST_HEAD(nvmf_transports);
> @@ -717,6 +718,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   {
>   	substring_t args[MAX_OPT_ARGS];
>   	char *options, *o, *p;
> +	char *host_secret = NULL, *ctrl_secret = NULL;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
>   	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
> @@ -738,6 +740,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->tls_key = NULL;
>   	opts->keyring = NULL;
>   	opts->concat = false;
> +	opts->dhchap_key = NULL;
> +	opts->dhchap_ctrl_key = NULL;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -1026,13 +1030,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -ENOMEM;
>   				goto out;
>   			}
> -			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> -				pr_err("Invalid DH-CHAP secret %s\n", p);
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -			kfree(opts->dhchap_secret);
> -			opts->dhchap_secret = p;
> +			kfree(host_secret);
> +			host_secret = p;
>   			break;
>   		case NVMF_OPT_DHCHAP_CTRL_SECRET:
>   			p = match_strdup(args);
> @@ -1040,13 +1039,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				ret = -ENOMEM;
>   				goto out;
>   			}
> -			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> -				pr_err("Invalid DH-CHAP secret %s\n", p);
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -			kfree(opts->dhchap_ctrl_secret);
> -			opts->dhchap_ctrl_secret = p;
> +			kfree(ctrl_secret);
> +			ctrl_secret = p;
>   			break;
>   		case NVMF_OPT_TLS:
>   			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> @@ -1090,6 +1084,41 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
>   				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>   	}
> +
> +	opts->host = nvmf_host_add(hostnqn, &hostid);
> +	if (IS_ERR(opts->host)) {
> +		ret = PTR_ERR(opts->host);
> +		opts->host = NULL;
> +		goto out;
> +	}
> +
> +	if (host_secret) {
> +		pr_debug("lookup host identity '%s'\n", host_secret);
> +		key = nvme_auth_extract_key(opts->keyring, host_secret,
> +					    strlen(host_secret));
> +		if (IS_ERR(key)) {
> +			ret = PTR_ERR(key);
> +			goto out;
> +		}
> +		pr_debug("using dhchap key %08x\n", key_serial(key));
> +		opts->dhchap_key = key;
> +	}
> +	if (ctrl_secret) {
> +		if (!opts->dhchap_key) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
> +		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
> +					    strlen(ctrl_secret));
> +		if (IS_ERR(key)) {
> +			ret = PTR_ERR(key);
> +			goto out;
> +		}
> +		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
> +		opts->dhchap_ctrl_key = key;
> +	}
> +
>   	if (opts->concat) {
>   		if (opts->tls) {
>   			pr_err("Secure concatenation over TLS is not supported\n");
> @@ -1101,21 +1130,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			ret = -EINVAL;
>   			goto out;
>   		}
> -		if (!opts->dhchap_secret) {
> +		if (!opts->dhchap_key) {
>   			pr_err("Need to enable DH-CHAP for secure concatenation\n");
>   			ret = -EINVAL;
>   			goto out;
>   		}
>   	}
>   
> -	opts->host = nvmf_host_add(hostnqn, &hostid);
> -	if (IS_ERR(opts->host)) {
> -		ret = PTR_ERR(opts->host);
> -		opts->host = NULL;
> -		goto out;
> -	}
> -
>   out:
> +	kfree(ctrl_secret);
> +	kfree(host_secret);
>   	kfree(options);
>   	return ret;
>   }
> @@ -1290,8 +1314,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   	kfree(opts->subsysnqn);
>   	kfree(opts->host_traddr);
>   	kfree(opts->host_iface);
> -	kfree(opts->dhchap_secret);
> -	kfree(opts->dhchap_ctrl_secret);
> +	if (opts->dhchap_key) {
> +		pr_debug("revoke dhchap key %08x\n",
> +			 key_serial(opts->dhchap_key));
> +		key_revoke(opts->dhchap_key);
> +		key_put(opts->dhchap_key);
> +	}
> +	if (opts->dhchap_ctrl_key) {
> +		pr_debug("revoke dhchap ctrl key %08x\n",
> +			 key_serial(opts->dhchap_ctrl_key));
> +		key_revoke(opts->dhchap_key);
> +		key_put(opts->dhchap_ctrl_key);
> +	}

revoking directly from opts? opts was always used as a store for what 
the user passed in, any transformation
is kept under the ctrl.

