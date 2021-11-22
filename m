Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A29C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JRZOr9ReNxwdbK656KslzswFIwdKmvYGDm2UvqThBQg=; b=BN9jdeHNyeqQDvD178+4flKT60
	zaTCsu9yEbqAa2Za6+zFpAM5a0GpofbDykDs0IS9S9k6eYjhbwYFKQR5Sy4TeQxANajXx0NJMfSfQ
	ryt2Rk3qRInZBJQSyC8HWbUqfwUon3wzvuPzpIfMnADPfmKXOUkoQVBwB/Kgwtu7KkmotVil65L6i
	ZWQTnLrYwlN3hlW//YhVvqYsgewpNMrc7YzmifOaSaro+JKhJ34mk9BL5QXCsIIq5E/r0ijq9Ebme
	oWOsPCbUevPNP0MV+GSuRsK1OWr92fa9E2SKJD0+WsLb9FJrCWMNaQMrRho8xET+4k+U06dPE1dO/
	iXptwfPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5lm-00FdJP-Pq; Mon, 22 Nov 2021 09:37:51 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4RO-00FEU8-3L
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:12:44 +0000
Received: by mail-wr1-f48.google.com with SMTP id n29so31012246wra.11
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JRZOr9ReNxwdbK656KslzswFIwdKmvYGDm2UvqThBQg=;
 b=RBhXsF/SyB1zSgDbOu0/cugTxptwLQr1cUxi+oeBn8szx2q0ZnD01iGYvQHi+HXFPC
 obHrzBzckg9po1sjUy4jWvHoPFf6e2QWvzjh/ZRTefHuHWjolkRcQcaQLs86Ve3gZbxS
 ci3Gw9rIcLQmzugL9lItiyRbt1nh+8Uug5QmDMseYBu3gb8c4wABKbG5CrEJbmpnJhNP
 OtUuTT8MZYOLWQt6ULyhC1yFM2YHoPPACYKze3WmDVeK8jFpU5vaSEgPo5VUwgNgWt2F
 n7e79juTSPR2IfZfpK1/0AC3VRPe4/T2PhPTJMDwXSOWKg3qtJ/Wat3YyOIWHB+gufpz
 Zbgg==
X-Gm-Message-State: AOAM53192HJctOmlEMA4KQjGpSwG1xKPShALWCRUAikUiwpLyc815E8t
 YmAdQVcJX6Pm/2EqsRauPzoaNcS9XJA=
X-Google-Smtp-Source: ABdhPJyfwX7jIq5oVb8kvi33y1Hx/2Dj4OOmd2n8lkGhOSruHCErMl203NTR8e0/rFxK0E49Ikg/jA==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr36537759wrn.337.1637568760405; 
 Mon, 22 Nov 2021 00:12:40 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d8sm8206214wrm.76.2021.11.22.00.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:12:40 -0800 (PST)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f6c144d-0354-2753-ab58-1f5cabcafbdd@grimberg.me>
Date: Mon, 22 Nov 2021 10:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122074727.25988-8-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_001242_218326_4533B2B5 
X-CRM114-Status: GOOD (  15.04  )
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


> +int nvme_auth_generate_key(struct nvme_ctrl *ctrl, u8 *secret, bool set_ctrl)

Maybe instead of set_ctrl introduct struct dhchap_key and pass a pointer
into that?

> +{
> +	u8 *key;
> +	size_t key_len;
> +	u8 key_hash;
> +
> +	if (!secret)
> +		return 0;
> +
> +	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> +		return -EINVAL;
> +
> +	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> +	key = nvme_auth_extract_secret(secret + 10, key_hash,
> +				       &key_len);
> +	if (IS_ERR(key)) {
> +		dev_dbg(ctrl->device, "failed to extract key, error %ld\n",
> +			PTR_ERR(key));
> +		return PTR_ERR(key);
> +	}
> +
> +	if (set_ctrl) {
> +		ctrl->dhchap_ctrl_key = key;
> +		ctrl->dhchap_ctrl_key_len = key_len;
> +		ctrl->dhchap_ctrl_key_hash = key_hash;
> +	} else {
> +		ctrl->dhchap_key = key;
> +		ctrl->dhchap_key_len = key_len;
> +		ctrl->dhchap_key_hash = key_hash;
> +	}

Then it becomes:
	dhchap_key->key = key;
	dhchap_key->len = key_len;
	dhchap_key->hash = key_hash;

