Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6DCC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G054yDMeCVBma4S7sb6Ft+yWT8RUEJTo9XLaAmqRqeE=; b=CYWYcEQS3bbR5H1a6ySbYQcWrw
	4dhwA2bWc5ya/wJlV6cwAYB5ipXZ2hOnPXoHAKbp6dewu1OVdLbQgEIhUkozCHJgkgZUATz0Cszlv
	rKsSxoIz29QuG3Yr17B7fC27JwZe/KQS9mm5dzCU4sTE4yvvFW1oaGd2sGMxhyTmefULYgagwJXFI
	GkZK5lFKsqnlMXeanVcvtUaJGzzga4hmCAko0kfXFtmqjb3tp+nXvIHSu+vopEq+7zbGLYLSoBDlE
	9wgdJ/OAPXuV98RIj2D+iljsSQMHkVX+GMXcJg6XOkmPVT5w/USqS4ei01L9eRaOpzJqgMsfueC7Y
	xCcxSlig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phuHV-004IgV-2A;
	Thu, 30 Mar 2023 15:33:41 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phuHS-004Ifp-1d
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 15:33:40 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-2cfe3278da7so26248f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 08:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G054yDMeCVBma4S7sb6Ft+yWT8RUEJTo9XLaAmqRqeE=;
        b=n3x8GhlfABueRcA//KuBEnDnABuzBwdU7AM0yHmsEftGhGPQFIT4lUOnLHZJaa/XGT
         gnRB3u37ckP52p4qFfWF1QanIt5YklRZjyIKYpuM3baKCoDdoqpNXWSH+RgaWKHwenIg
         ILxXXGI/u2rPH8DkoqDUi5AbvS6+twuiOYlsU3y68Qkhh/GqrSHgNnBaaul601lnUbxv
         dgjoCc/Gl4k+dyh6OcuPdQt7mYT8UKBn/AfEA4BE0GrtbvXBeRDjkWRNTMnDp6I+CBOU
         64ItGNeyuxVor5A3W2TvO26wD79pEsKcnjSWH1I0JNbrfK+zpmE44ERl92bV6IP8WR7o
         gRqg==
X-Gm-Message-State: AAQBX9ci5f2thPbGT5/nm53sG2FCHzv1VOuMwHyHtXuLmoUlK1fJ0oBo
	ySF3d4Mbw5zpLrEqBCtQ380=
X-Google-Smtp-Source: AKy350Z+462wcmck/udRClMI3anzQA6rnYmMJcmhLTxtebhxO6SZS+9BBZmKZqutri65kgxAJlabOw==
X-Received: by 2002:a05:600c:1d03:b0:3eb:42f6:ac55 with SMTP id l3-20020a05600c1d0300b003eb42f6ac55mr2386918wms.1.1680190417123;
        Thu, 30 Mar 2023 08:33:37 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003eb966d39desm6246918wml.2.2023.03.30.08.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 08:33:36 -0700 (PDT)
Message-ID: <677f3f9a-872d-27fe-9a21-b41bbe1c44ff@grimberg.me>
Date: Thu, 30 Mar 2023 18:33:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-13-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-13-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_083338_539958_B9EB77FA 
X-CRM114-Status: GOOD (  20.27  )
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

> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.

Can you explain the reasoning to why a user need to pass a keyring
given that we already set up one?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 79 ++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  6 +++
>   drivers/nvme/host/tcp.c     | 20 +++++++---
>   3 files changed, 98 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 3e4f0e45b58f..5f5e487d498c 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -605,6 +605,8 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
> +	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
> @@ -620,8 +622,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	char *options, *o, *p;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
> -	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> +	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>   	uuid_t hostid;
> +	struct key *key = NULL;
>   
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> @@ -889,6 +892,74 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +#ifdef CONFIG_NVME_TLS

Same comment as before:
			if (!IS_ENABLED(CONFIG_NVME_TLS)) {
				pr_err("TLS is not supported\n");
				ret = -EINVAL;
				goto out;
			}

> +			if (match_int(args, &key_id)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (key_id < 0) {
> +				pr_err("Invalid keyring id %d\n", key_id);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (!key_id) {
> +				pr_debug("Using default keyring\n");
> +				if (opts->keyring) {
> +					key_put(opts->keyring);
> +					opts->keyring = NULL;
> +				}
> +				break;
> +			}
> +			key = key_lookup(key_id);
> +			if (!key) {
> +				pr_err("Keyring id %08x not found\n", key_id);
> +				ret = -ENOKEY;
> +				goto out;
> +			}
> +			if (opts->keyring)
> +				key_put(opts->keyring);
> +			opts->keyring = key;
> +			break;
> +#else
> +			pr_err("TLS is not supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +#endif
> +		case NVMF_OPT_TLS_KEY:
> +#ifdef CONFIG_NVME_TLS
> +			if (match_int(args, &key_id)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (key_id < 0) {
> +				pr_err("Invalid key id %d\n", key_id);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (!key_id) {
> +				pr_debug("Using 'best' PSK\n");
> +				if (opts->tls_key) {
> +					key_put(opts->tls_key);
> +					opts->tls_key = NULL;
> +				}
> +				break;
> +			}
> +			key = key_lookup(key_id);
> +			if (!key) {
> +				pr_err("Key id %08x not found\n", key_id);
> +				ret = -ENOKEY;
> +				goto out;
> +			}
> +			if (opts->tls_key)
> +				key_put(opts->tls_key);
> +			opts->tls_key = key;
> +#else
> +			pr_err("TLS is not supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +#endif
> +			break;
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> @@ -1054,6 +1125,12 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   {
>   	nvmf_host_put(opts->host);
> +#ifdef CONFIG_NVME_TLS
> +	if (opts->keyring)
> +		key_put(opts->keyring);
> +	if (opts->tls_key)
> +		key_put(opts->tls_key);

I think key_put is null safe.

