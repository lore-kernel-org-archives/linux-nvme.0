Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7710AC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3LG/dUdYrjO1W0C8j3PsQ44fgCxYIklWJkVY7fFSK68=; b=jP4bB5gkgGawjNOC5nX/vJkKe+
	lCQ30CGgWl/bRVeg5/mZCwqwJKC6w8h5COUH8QboTKCL9p4p7ku/OeNouuexHCHHs8/RhS428bhUV
	pvoM/EkGzrJ9AVzGGeq3IumpoUr7lNuNLiyJWpWaEakCupObIalWMH6u3gBUkNsxTFkjGqV8HBBSi
	qmkC+gqPHY/mfIWDKf8DkdqQAJHi0n6wxvMJ8eCIvlXXfKoVHxfkqQl1L4jyL7JoFobTMETJtIn1N
	i7znqiUEg2wk3Nt9QD5Yon05yL1Z1vR+WM+3bnLXhEMy32Pp59hlJA5aRiaMxRiTF8m42Ik+n0JGX
	NdMZQIdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peui3-00FOP7-2c;
	Wed, 22 Mar 2023 09:24:43 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peui0-00FONT-22
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 09:24:41 +0000
Received: by mail-wm1-f50.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6100886wmq.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 02:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LG/dUdYrjO1W0C8j3PsQ44fgCxYIklWJkVY7fFSK68=;
        b=Fmo8n3dHmnh2n82cg3ybRUMvXv8zm0vNhzqVh0w8oNSsaxPyoM8bMWKACf3aFTUCYr
         iO9IWh+o/ZnM3pJAySxLUx11c8hR59AMyeh0Z4/DQQtjrYI8IPY48Be6cvNM9qxoNfAB
         LtToB8IhSMrogKvZAhJA2mHlio8DqCoql4X2bTjNTtD3ZB8960lPZCk5qdR7ZsdYA3lt
         ymQ37iv/bYUpjNJSl65geOM30akGPZ7TUAkMcISsIS06aN3xWZJtOme6Yh0OgviHXorl
         /flUOlpgY59v3tCspbrIziC+THYrgI5Y6m90vFSHpHqalNsA0bWR+N+Nnaec+GF/Aaxf
         0PCg==
X-Gm-Message-State: AO0yUKUpa+JVSsnTS17BWF0WGx5tW0rew25kKw80BAK4R7OEBY0cD87o
	fqJT5svOkKQf5re1bMy9BP0=
X-Google-Smtp-Source: AK7set/ezQ0GT8X72o+BwtfYBCCj+u1/IfFrjMgmhrwosqkcy/RN6exYhi6pgOlwVJE+z83zsDJ/iQ==
X-Received: by 2002:a05:600c:4515:b0:3ed:2eb5:c2e6 with SMTP id t21-20020a05600c451500b003ed2eb5c2e6mr5772364wmo.2.1679477078620;
        Wed, 22 Mar 2023 02:24:38 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y18-20020a1c4b12000000b003ee70225ed2sm164054wma.15.2023.03.22.02.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:24:38 -0700 (PDT)
Message-ID: <65e17a9f-cc5a-0286-71fd-34c8560137cd@grimberg.me>
Date: Wed, 22 Mar 2023 11:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/18] nvme-tcp: add connect option 'tls'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-10-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-10-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_022440_666708_452650BD 
X-CRM114-Status: GOOD (  21.60  )
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

> Add a connect option 'tls' to request TLS1.3 in-band encryption, and
> abort the connection attempt if TLS could not be established.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 5 +++++
>   drivers/nvme/host/fabrics.h | 2 ++
>   drivers/nvme/host/tcp.c     | 7 ++++++-
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index bbaa04a0c502..fdff7cdff029 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
>   	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
> +	{ NVMF_OPT_TLS,			"tls"			},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -632,6 +633,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
>   	opts->tos = -1; /* < 0 == use transport default */
> +	opts->tls = false;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -918,6 +920,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			kfree(opts->dhchap_ctrl_secret);
>   			opts->dhchap_ctrl_secret = p;
>   			break;
> +		case NVMF_OPT_TLS:
> +			opts->tls = true;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f7..c4538a9d437c 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -70,6 +70,7 @@ enum {
>   	NVMF_OPT_DISCOVERY	= 1 << 22,
>   	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
>   	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
> +	NVMF_OPT_TLS		= 1 << 25,
>   };
>   
>   /**
> @@ -128,6 +129,7 @@ struct nvmf_ctrl_options {
>   	int			max_reconnects;
>   	char			*dhchap_secret;
>   	char			*dhchap_ctrl_secret;
> +	bool			tls;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
>   	bool			data_digest;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bcf24e9a08e1..bbff1f52a167 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1902,6 +1902,9 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   			break;
>   	}
>   	if (ret) {
> +		/* Abort if TLS is requested */
> +		if (num_keys && ctrl->opts->tls)
> +			goto out_free_queue;
>   		/* Try without TLS */
>   		ret = nvme_tcp_alloc_queue(ctrl, 0, 0);
>   		if (ret)
> @@ -1934,6 +1937,8 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   				break;
>   		}
>   		if (ret) {
> +			if (num_keys && ctrl->opts->tls)
> +				goto out_free_queues;

I don't see why we even attempt tls if we're not explicitly told to.

