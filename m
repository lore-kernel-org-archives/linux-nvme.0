Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08141EB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxjLMaFLcmqkMgJF8iD7IC0NJ8XJCbj3i1mghtiuiEo=; b=0D2jxKcHTtA884KgvurF5Nnfo1
	YnN1E5k7cmBtB3IUkMcbcipiB4O9wqfYLvp5yCxpofjUJNZ+ko/sX8zpB9HNClmBj696U6/uHRQSO
	siaeCzaIY4lAWn+ZanfTrfVdqIWoXjUnVfA7GkslTH8Gj9pniuUBZn85tQHlGUOk78m7w7Yp6RRSQ
	Pzp532LvyD05rCMasVKqWGIQjZYzyJcbiUC7jBvCS3n62FgTZnWVzwdmGDoV278o+q094fV5o8v83
	7UpkijE+ix0IFJFQo/svhsKSkGQpqwFis0MUMR4Xu6wNyduXBC4g8mm12DvEIpRzZ9bo6oXQYi0GZ
	vRWK9PDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBXP-00FBXm-1I;
	Sun, 13 Aug 2023 13:53:47 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBXM-00FBXF-1N
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 13:53:45 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bded9d93dso80515466b.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 06:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934822; x=1692539622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxjLMaFLcmqkMgJF8iD7IC0NJ8XJCbj3i1mghtiuiEo=;
        b=lYq1FJ2BYbl5MrhZQUM4Hq7jJ57giDYMu9n7ee0Z3S5vqsmD+prcBWUiaWrAB5WoZb
         sLCYMHrvile/skiAV5kk0NicNMqz/Stk5V57WGqiO4Rl8G3CctTlxDApul28KnDQMfht
         wi8UaRSW/1Pj4nY0wPF4B85KDrIs9qCBV+5Pv6sRK8vQovxPH9nHnRDhF9cMCxdpXaIP
         gszkoGYB/2QbGTT+6HCdVTSVvBYlvtTSIs74CKhq4SzGU+qFgKhsqt2/mDclhklKrmNT
         gK4AbUur+O6CjkQzZIASu+PB2oj5q66GjhZb44J7kEptmcNJUSB+b85lvuCXfq5tJbIe
         QJnA==
X-Gm-Message-State: AOJu0Yw4wv7Z+s0z4o/Y57vdUV/076CziquHfWmD+3KEo2FuQTq6DSjl
	KmC6543kkQOkP9yVEH1l648=
X-Google-Smtp-Source: AGHT+IGd75FvfJU2yF+AhkdNfnKGyxKiNOVLrKo+LHk8jKKRREPCEXPJ47ksx29qEFkf/ramlOdo6g==
X-Received: by 2002:a17:906:74da:b0:99d:675e:5217 with SMTP id z26-20020a17090674da00b0099d675e5217mr4843605ejl.7.1691934822590;
        Sun, 13 Aug 2023 06:53:42 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id si28-20020a170906cedc00b00988dbbd1f7esm4587539ejb.213.2023.08.13.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:53:42 -0700 (PDT)
Message-ID: <5b6ff1d7-00e0-7f16-ece0-a80426821b32@grimberg.me>
Date: Sun, 13 Aug 2023 16:53:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_065344_461839_EBF11742 
X-CRM114-Status: GOOD (  10.89  )
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


> @@ -928,6 +933,46 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = key_lookup(key_id);
> +			if (IS_ERR(key)) {
> +				pr_err("Keyring %08x not found\n", key_id);
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			pr_debug("Using keyring %08x\n", key_serial(key));
> +			key_put(opts->keyring);
> +			opts->keyring = key;
> +			break;
> +		case NVMF_OPT_TLS_KEY:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = key_lookup(key_id);
> +			if (IS_ERR(key)) {
> +				pr_err("Key %08x not found\n", key_id);
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			pr_debug("Using key %08x\n", key_serial(key));
> +			key_put(opts->tls_key);
> +			opts->tls_key = key;
> +			break;

Didn't we agree that we will share the code and simply return the key?

Maybe I missed further discussion on this?

