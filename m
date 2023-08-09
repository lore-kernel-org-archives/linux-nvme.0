Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D85EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YAqLRc0BNpd8D9Rs2l3bDVGOjKartfzdlTQg+/kgZs8=; b=QQBYnNATbnishUO6oWMPzu6yqy
	xS1rffSrb96t1NWztYZKSOdrrDg4r3rZjOubBMWF1okcpNMdMSp1fFQ0MTduHqbdfE2ReW6N7zC8W
	BGM800tHXhSGW/0bScSQOSmvXxiWEVA6yz9LmcrRA74B9dcvi3a2DHv4VbEi1IfmJJwwyZ/3eCeg3
	RoI6RrHOvKCfCvl+MXh7LczYVKWTU8ScnhRP9ihApORz+xoYoLeDsRTteP/vcxBnc3IuNkHjMHKvG
	6hH6+cez6L2H02pDq3iYRiMK9o0N9e43tM6qEM05V9WgaHK8LBqFin6yfREmQ2FxvS6A4Pl4ATp4+
	lRhfCHaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTfvo-004Ttd-0x;
	Wed, 09 Aug 2023 09:56:44 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTfvl-004TsB-2P
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 09:56:42 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe3194d21dso14570435e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 02:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691574999; x=1692179799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAqLRc0BNpd8D9Rs2l3bDVGOjKartfzdlTQg+/kgZs8=;
        b=Kg9rH4xKZOyyky9NzM+yNlHaGQDJBGp9xWtm2760WnZXerwi7E72KhFIybdYJPtCmu
         Q87eiYf46hBHkrVu5MOf2k7+PCi5PfbuGZ6dwD2R0p9wdrbkI5mqGs5fJOXaEsgzVtD6
         O6QSW5X7g362TAA5nIu+p4Lxv7aeIlt0WQ0bHKrFaf+DQsmhhbHwD6sJghR5NqPE56Iv
         tCJ7NvBVi78ZQmVlueENI3tRwVNvD37vVI2q4V1gABGqyAyAcB9lPsIemWrVQigq+LFg
         19J+qJVYYQW4TyOvf4HtXtbOJW3sfGm2gaEIIDsiEzJghfr+gBnxqrvKrhBFxcC1L44Z
         VD3A==
X-Gm-Message-State: AOJu0Yxb1fRKFcVCH3CDwOzs8KEWLNrGwjqjbfvSBdCHXGwwc9qiCCEG
	s5ct9pRVSC4l9rntaTSURfk=
X-Google-Smtp-Source: AGHT+IHjXmNzHwaWBxoa5mRQU20hO+TC1NL+Agib2UBGmY+jFT1N/9r0S+U/1dB6M6Xeg9OM2ZHwug==
X-Received: by 2002:a05:600c:3b8f:b0:3f9:88d:9518 with SMTP id n15-20020a05600c3b8f00b003f9088d9518mr1926490wms.0.1691574999262;
        Wed, 09 Aug 2023 02:56:39 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc846000000b003fbc0a49b57sm1467646wml.6.2023.08.09.02.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 02:56:38 -0700 (PDT)
Message-ID: <658826df-9404-3245-6bbe-9862156c70da@grimberg.me>
Date: Wed, 9 Aug 2023 12:56:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/16] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808165354.123499-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_025641_785120_AD345E4C 
X-CRM114-Status: GOOD (  20.77  )
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



On 8/8/23 19:53, Hannes Reinecke wrote:
> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 71 ++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  6 ++++
>   drivers/nvme/host/tcp.c     | 11 ++++--
>   3 files changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ddad482c3537..df986a7641a3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -622,6 +622,41 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	return NULL;
>   }
>   
> +static int parse_key(struct nvmf_ctrl_options *opts, int key_id,
> +		     bool is_key)
> +{
> +	struct key *key = NULL;
> +
> +	if (key_id < 0) {
> +		pr_err("Invalid %s id %d\n",
> +		       is_key ? "key" : "keyring", key_id);
> +		return -EINVAL;
> +	}
> +	if (key_id) {
> +		key = key_lookup(key_id);
> +		if (!key) {
> +			pr_err("%s id %08x not found\n",
> +			       is_key ? "Key" : "Keyring", key_id);
> +			return -ENOKEY;
> +		}
> +	} else {
> +		if (is_key)
> +			pr_debug("Using 'best' PSK\n");
> +		else
> +			pr_debug("Using default keyring\n");
> +		key = NULL;

Not sure I understand the else case here.
Why do we allow key_id = 0 if it does not represent
a valid existing key_id?

> +	}
> +	if (is_key) {
> +		key_put(opts->tls_key);
> +		opts->tls_key = key;
> +	} else {
> +		key_put(opts->keyring);
> +		opts->keyring = key;
> +	}
> +

Perhaps instead of is_key, just return the key and assign outside.

