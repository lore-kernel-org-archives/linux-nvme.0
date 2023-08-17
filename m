Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2749DC2FC0E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 09:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIebZwojAKXZwO37JWETlKiaDFkVEjvbBEdVxz873MI=; b=SR6yhS276jh3VebvfMh0JE54yB
	dcJKBsVxM5VuULkBe32NpgUXfHTcQIpRgHmXxf68ntpdCNYDdhNPKSzNCG/rzskaelmzUd1/IF9bg
	68LBaRM6aWtxY0yNTtx8SIFd4Bdf0oaclCjAsJPUN7XsMxcCL1GKf4MOsP/IFaRjQyAH9Lgmxf7Sz
	ARFmlICQKkRozmHYJnUOzo3ncg+6TRy+Coy/dEkic97B3VlaXVNFstQUkjolH9W76lLMcIN/arGBJ
	NrSgSGRIHFDal9YDSF0v+fx/CEGUEnHK6gtVdyskAScpGdT5MmjqfEydWFukK29mgTU2/3tQT5H04
	YodY6dCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZBc-005vRN-1I;
	Thu, 17 Aug 2023 09:21:00 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZBQ-005vQi-3D
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 09:20:50 +0000
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so1899238a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 02:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264041; x=1692868841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIebZwojAKXZwO37JWETlKiaDFkVEjvbBEdVxz873MI=;
        b=UlLYabA2z1jghFG4tMcyJjHL7cEHNbliGYrNhHTMVkxP/oPDvyKJiQkVsvxjTCWwKu
         Cx6wR1QozwDDtRTlknRR4qQ45IoxahLJnI9HDhSpf1gFt6KUf+doYWN42uS//hYljx1x
         cMt+4M7e1zQboIOrk2O2nhYa13hExSW6SQQsXt+O4bF3JVXoR9XsAWEeLhZrGZvIS5oM
         JA3C6m8l3/xpiKwh17jRTTIXAd3xrf7DULdXBpS4RfraT6PriZNjyVyFdgjs+glpnBQU
         3vQw+8rHOoa/5QI8O7kqjIKVuG1mcEsDrEtRI3ANzv2yLuzc/lwSH9szl7I5hMs6lSYh
         VOYA==
X-Gm-Message-State: AOJu0YyJUoUiJ26sUYUgIlLYAgjmJYQN8zH1QCGRLMs5TlKMZW+dYgjO
	DSfx9piEDo9BfzYlhmnBCqY=
X-Google-Smtp-Source: AGHT+IEr+1KO7wYR0yvfbMijYLcyIbVVOH2d3phvgYskk0bC3zzyzjxbQBixVT3Ft7NzxOgP749uFw==
X-Received: by 2002:a17:906:1d8:b0:99d:ddae:f75d with SMTP id 24-20020a17090601d800b0099dddaef75dmr3166894ejj.4.1692264041185;
        Thu, 17 Aug 2023 02:20:41 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b0099cc36c4681sm9797768ejc.157.2023.08.17.02.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 02:20:40 -0700 (PDT)
Message-ID: <f250deb1-90d9-f9c4-667f-9e6ad580cb6b@grimberg.me>
Date: Thu, 17 Aug 2023 12:20:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-12-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230816120608.37135-12-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_022049_039496_6D4EF65D 
X-CRM114-Status: GOOD (  27.60  )
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



On 8/16/23 15:06, Hannes Reinecke wrote:
> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 52 ++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  6 +++++
>   drivers/nvme/host/tcp.c     | 14 +++++++---
>   3 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ddad482c3537..e453c3871cb1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -622,6 +622,23 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	return NULL;
>   }
>   
> +static struct key *nvmf_parse_key(int key_id, char *key_type)
> +{
> +	struct key *key;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +		pr_err("TLS is not supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	key = key_lookup(key_id);
> +	if (IS_ERR(key))
> +		pr_err("%s %08x not found\n", key_type, key_id);
> +	else
> +		pr_debug("Using %s %08x\n", key_type, key_id);

I think that the key_type string is unneeded as an argument solely for
the log print.

I think that you can move the error print to the call-site. Keep
the debug print here, but you don't need the type...

> +	return key;
> +}
> +
>   static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
>   	{ NVMF_OPT_TRADDR,		"traddr=%s"		},
> @@ -643,6 +660,10 @@ static const match_table_t opt_tokens = {
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
> @@ -660,9 +681,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	char *options, *o, *p;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
> -	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> +	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>   	uuid_t hostid;
>   	char hostnqn[NVMF_NQN_SIZE];
> +	struct key *key;
>   
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> @@ -928,6 +950,32 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = nvmf_parse_key(key_id, "Keyring");
> +			if (IS_ERR(key)) {
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			key_put(opts->keyring);

Don't understand how keyring/tls_key are pre-populated though...

> +			opts->keyring = key;
> +			break;
> +		case NVMF_OPT_TLS_KEY:
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = nvmf_parse_key(key_id, "Key");
> +			if (IS_ERR(key)) {
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			key_put(opts->tls_key);
> +			opts->tls_key = key;
> +			break;
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> @@ -1168,6 +1216,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
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
> index ef9cf8c7a113..f48797fcc4ee 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1589,6 +1589,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   
>   	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>   		qid, pskid);
> +	if (nctrl->opts->keyring)
> +		keyring = key_serial(nctrl->opts->keyring);

Maybe populate opts->keyring with nvme_keyring_id() to begin
with and then you don't need this?

>   	memset(&args, 0, sizeof(args));
>   	args.ta_sock = queue->sock;
>   	args.ta_done = nvme_tcp_tls_done;
> @@ -1914,9 +1916,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	key_serial_t pskid = 0;
>   
>   	if (ctrl->opts->tls) {
> -		pskid = nvme_tls_psk_default(NULL,
> -					      ctrl->opts->host->nqn,
> -					      ctrl->opts->subsysnqn);
> +		if (ctrl->opts->tls_key)
> +			pskid = key_serial(ctrl->opts->tls_key);
> +		else
> +			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
> +						      ctrl->opts->host->nqn,
> +						      ctrl->opts->subsysnqn);
>   		if (!pskid) {
>   			dev_err(ctrl->device, "no valid PSK found\n");
>   			ret = -ENOKEY;
> @@ -2776,7 +2781,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
> +			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   

