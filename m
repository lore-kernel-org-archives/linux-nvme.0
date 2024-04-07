Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55319CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ioVIwbdgW4ehobZqWOUOsjJOzwym81QNPAVGkioyuFA=; b=gYhrCYGZOyrkc2Sx2DBQLvFOhC
	iMunHrFNN/rtRXGA7Ww5f4nRNfzA+0sg8SE0X1hrOumyMDi9dpveLOt/m5Lue++muhLURzVCGg36+
	sBsWz32pR4B90NNe/1h8XULaJhM61LS35jXnVKmuO+6UaEvRW9UmLoqDQrtvTHdMAo7gLVxBnIJkp
	wSFGWiIuTnYPPxxn7LBoo0hSxBWLXs3FL+1fD5TZtM+r5340lnQsYEjChmLT3H4UnVV19CEBKyoXf
	H0jHZqUto5QGtqkGx3q3MMEpGMQTVOwtkuUqaAZDxNG4X/NxdOxJyadtcGrvF9rXZHvFOlLfoF6Hi
	GBJSws1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZUV-0000000DUbD-06zj;
	Sun, 07 Apr 2024 20:51:51 +0000
Received: from mail-lf1-f48.google.com ([209.85.167.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZUR-0000000DUaZ-0H6S
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 20:51:48 +0000
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d23d3bceso959003e87.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 13:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712523105; x=1713127905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioVIwbdgW4ehobZqWOUOsjJOzwym81QNPAVGkioyuFA=;
        b=YRvRBPV7qQzOwNeMNIxV1l54d+tcCdQhx/Pyb2Mga/H6bDzVw5Tyxg+PtEL59X6uIE
         JUwTsA5sbuzu0SSu0rsyIIPChhnAZqMMG2P3MyV4juRKcy465MRoOYFk7/ckoa6aS+XU
         n1oorNgLpKcH1mREy/NhQJ48KxY5VHxMxlTa5D3O9oI18hcJEaoiIJJNw8y7+51TboBj
         iavGyEJ9Im3izVgUeVd02+8AegjaMmmfI8w4VuZlNH4/0Tve/0p8wVwGeRGS7hyEk6yY
         IPdLLxP2+hTLUPDPAMq1H7Fuy+xSbHf7FgPLiz7ZlUfBQwXpnWaVB3oNCffRgyq88q1k
         rdcA==
X-Forwarded-Encrypted: i=1; AJvYcCUrSXD3bHVtvrwM7Vb9bCk2oYS4cQkGYzWu4zzEJRa0SryFd+ddC74tnEOdUDnDq4QQfWWm0rlPsQknzK0sdC+Tcg5lhhuniAkyJdbvTxc=
X-Gm-Message-State: AOJu0YwRTFhE4LYaDFjW1Z1x3E+LPdjJCeKZca2HEfjZQapktcuHwD16
	3H+5xpmkF78fBB+wtplZ/x++vDub9rYLQoo2Y+WjMIodlL2SSuZh
X-Google-Smtp-Source: AGHT+IFVz7RNaurLu6utNeoyZg7E3A5mACh/fHdH1LmzAjc8N5jzQ3gzK1od1KZPBqW1N82w4Pv5uA==
X-Received: by 2002:a05:6512:3611:b0:516:ced5:3af9 with SMTP id f17-20020a056512361100b00516ced53af9mr3953583lfs.5.1712523104669;
        Sun, 07 Apr 2024 13:51:44 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id x11-20020ac259cb000000b00516afebe26asm923020lfn.1.2024.04.07.13.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 13:51:44 -0700 (PDT)
Message-ID: <7de989ae-6088-438d-af71-50688f18cba6@grimberg.me>
Date: Sun, 7 Apr 2024 23:51:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] nvme-tcp: check for invalidated or revoked key
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-3-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_135147_148915_BFA1B95C 
X-CRM114-Status: GOOD (  15.65  )
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
> key_lookup() will always return a key, even if that key is revoked
> or invalidated. So check for invalid keys before continuing.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 7 ++++++-
>   drivers/nvme/host/sysfs.c   | 9 +++++++--
>   drivers/nvme/host/tcp.c     | 8 +++++++-
>   3 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 0141c0a6942f..75aa69457353 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -639,7 +639,12 @@ static struct key *nvmf_parse_key(int key_id)
>   	key = key_lookup(key_id);
>   	if (IS_ERR(key))
>   		pr_err("key id %08x not found\n", key_id);
> -	else
> +	else if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
> +		 test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
> +		pr_err("key id %08x invalid\n", key_id);
> +		key_put(key);
> +		key = ERR_PTR(-EKEYREVOKED);
> +	} else
>   		pr_debug("Using key id %08x\n", key_id);
>   	return key;

Looks like it will be useful to have a nvme_key_lookup() that
prints an error and returns a semantic error for revoked/invalidated key
and would be used in the call-sites ?

