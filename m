Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292A5EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+ZBPrPmRDHQmojZ/sRTrvI64yQkj3SMNXeg8R1Yqx8=; b=C1ZwW0x8icA1a8Q3Emi8JSuATi
	wSEeGPF0KBB9P9hCzoj521VVqeIOPXZThf7KPnrCNOEhkuEmBa8u0+dqincenFJEqXNU8NoH0TsM0
	jAhVc9E8awCw6ZQ/hc2Cgxi1VWWksOIKrSTNaaen/K1gtd5tH7Oy/gvnD0t0GY3qE9C96yE3AIeDy
	YlDsR87ZpvAkuPoEHzwNbyJ9dz6+3Qpec2Te1cap+0PI8oPYXb+LCoH1NY92rkWpoqdWPousSHgVs
	N7cGzVk3LBinhKRnAJizUwxtQq+lbrl/kC2jhPU8OiSvf6o3GfVC5r6MhBpyD+mLw20P2juoPtDKN
	xi2RdBKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvWI-00GR7y-2A;
	Mon, 07 Aug 2023 08:23:18 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvWF-00GR6t-0d
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:23:16 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so5407255e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396592; x=1692001392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+ZBPrPmRDHQmojZ/sRTrvI64yQkj3SMNXeg8R1Yqx8=;
        b=aIEVdp6k4ezb+Y9kgZWI6n04M51emSPz9+H4eBaW/lqkL1rlheIkNXJb2P3Q9HJyIf
         P8RdDgI2jwmGUgymzHkH+U7XimM8KTl2RKqofzjCVjdWtPHEhabd61T2+/AN88K4WP/Q
         rVATw0bifNviTFwT2heAbco/yXJ7+EydKe37RCy8wVuIOCj/c2ocqNiURp5a9diDgkWa
         exDeQaxSQGphV/7WB4McTcG5kKK9YrsaU6MEuRK6ZOJH+R4/x1N9/q8vMIJnhuLbEjMJ
         t4SRneqvbqaBMCs8fy1D/VogZoc0mxZmnyFibKQk9DWUjggJN1RTmJaIlsMGoq1TNYTX
         AsJA==
X-Gm-Message-State: ABy/qLbW+Jb2cA1TX6JNRUiDSm+BJzusJDNZXQrw4izShqZ0vpNd4WA3
	i9CJkvu/GBCf1hAZpIMcf92/91C6kww=
X-Google-Smtp-Source: APBJJlG4+2H0UVBdnK3R7MGoLx+JOgkhDZE9J+KeBd9tqHyZ8yZU6H0GEjBGmzAW0O//HXkdX/RNXg==
X-Received: by 2002:a05:600c:3b16:b0:3f9:88d:9518 with SMTP id m22-20020a05600c3b1600b003f9088d9518mr23546583wms.0.1691396592311;
        Mon, 07 Aug 2023 01:23:12 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p17-20020a7bcc91000000b003fe2696ccfcsm9912212wma.23.2023.08.07.01.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:23:11 -0700 (PDT)
Message-ID: <9f7b64a3-2433-93eb-4cfd-4fe6408b1598@grimberg.me>
Date: Mon, 7 Aug 2023 11:23:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/14] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_012315_234979_68B05D1D 
X-CRM114-Status: GOOD (  22.83  )
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



On 8/3/23 13:50, Hannes Reinecke wrote:
> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 69 ++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  6 ++++
>   drivers/nvme/host/tcp.c     | 11 ++++--
>   3 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ddad482c3537..6bdcd505a477 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -643,6 +643,10 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +#ifdef CONFIG_NVME_TCP_TLS
> +	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
> +	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
> +#endif
>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
> @@ -660,9 +664,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	char *options, *o, *p;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
> -	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> +	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>   	uuid_t hostid;
>   	char hostnqn[NVMF_NQN_SIZE];
> +	struct key *key = NULL;
>   
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> @@ -928,6 +933,66 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
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
> +				key_put(opts->keyring);
> +				opts->keyring = NULL;
> +				break;
> +			}
> +			key = key_lookup(key_id);
> +			if (!key) {
> +				pr_err("Keyring id %08x not found\n", key_id);
> +				ret = -ENOKEY;
> +				goto out;
> +			}
> +			key_put(opts->keyring);
> +			opts->keyring = key;
> +			break;
> +		case NVMF_OPT_TLS_KEY:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
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
> +				key_put(opts->tls_key);
> +				opts->tls_key = NULL;
> +				break;
> +			}
> +			key = key_lookup(key_id);
> +			if (!key) {
> +				pr_err("Key id %08x not found\n", key_id);
> +				ret = -ENOKEY;
> +				goto out;
> +			}
> +			key_put(opts->tls_key);
> +			opts->tls_key = key;
> +			break;

Maybe move to helper(s)? looks pretty similar.

>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> @@ -1168,6 +1233,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   {
>   	nvmf_host_put(opts->host);
> +	key_put(opts->keyring);
> +	key_put(opts->tls_key);
>   	kfree(opts->transport);
>   	kfree(opts->traddr);
>   	kfree(opts->trsvcid);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dac17c3fee26..fbaee5a7be19 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -71,6 +71,8 @@ enum {
>   	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
>   	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>   	NVMF_OPT_TLS		= 1 << 25,
> +	NVMF_OPT_KEYRING	= 1 << 26,
> +	NVMF_OPT_TLS_KEY	= 1 << 27,
>   };
>   
>   /**
> @@ -103,6 +105,8 @@ enum {
>    * @dhchap_secret: DH-HMAC-CHAP secret
>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
>    *              authentication
> + * @keyring:    Keyring to use for key lookups
> + * @tls_key:    TLS key for encrypted connections (TCP)
>    * @tls:        Start TLS encrypted connections (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>   	struct nvmf_host	*host;
>   	char			*dhchap_secret;
>   	char			*dhchap_ctrl_secret;
> +	struct key		*keyring;
> +	struct key		*tls_key;
>   	bool			tls;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4d0e3de39c26..cc6a672b8d3f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1584,6 +1584,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   
>   	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>   		qid, pskid);
> +	if (nctrl->opts->keyring)
> +		keyring = key_serial(nctrl->opts->keyring);
>   	memset(&args, 0, sizeof(args));
>   	args.ta_sock = queue->sock;
>   	args.ta_done = nvme_tcp_tls_done;
> @@ -1899,9 +1901,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	key_serial_t psk_id = 0;
>   
>   	if (ctrl->opts->tls) {
> -		psk_id = nvme_tls_psk_default(NULL,
> -					      ctrl->opts->host->nqn,
> -					      ctrl->opts->subsysnqn);
> +		if (ctrl->opts->tls_key)
> +			psk_id = key_serial(ctrl->opts->tls_key);
> +		else
> +			psk_id = nvme_tls_psk_default(ctrl->opts->keyring,
> +						      ctrl->opts->host->nqn,
> +						      ctrl->opts->subsysnqn);
>   		if (!psk_id) {
>   			dev_err(ctrl->device, "no valid PSK found\n");
>   			ret = -ENOKEY;

