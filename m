Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90093C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XtZYA2aaU6ZQ5dDIxai629ECT3+Gm8LQlfd63Lc9iTg=; b=eRU7UfiJ3xzzUpy0gQ5G3UHnBE
	eMzWyOwwhWLXUVdQtvxw8g7vUGsPjyYgDhGbSQkae+9S3gOilHcfik2WvgebRAbH1+GkhL+dGgCQA
	b6pEVUrjc1bfPrulmO1MKm5kXcTqWjEibMxk19MSGXvlpeP8TrDI3LcitQStVEM1sYiPtpwi1vpmJ
	iZfm4GUujAcMJKNjBgHCtjucAg/kVwefcwLPr3HyD0OmjHq5WOXUkUA7HO39m7BJ6aL4eTIBojhVt
	xN/1aScHIFukMqEPeW1Iph9QEkoNKmSnFgv85wS7Fw+qAARtPwrKyiRSv2qU1x1i9+JsTr3aM1x5O
	kKNIHHqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5wF-00000000bF1-1G8n;
	Wed, 31 Jul 2024 09:48:07 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5tL-00000000aDI-3tZX
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 09:45:09 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368660d5922so442976f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jul 2024 02:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419106; x=1723023906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtZYA2aaU6ZQ5dDIxai629ECT3+Gm8LQlfd63Lc9iTg=;
        b=AVkmZOa903f10iQA8P1aHe7Gmob5AAyiIUDvLlzdjT/TEvZaguR9vVI7ZVp3QdWgXf
         YpTgLeyA3LnBhPhTsDD7KTDDizJtuX3pooN+EQesJY0WoiKQOgAEGIZ6oTi0kEletKSw
         y2+2K5NjllgJlJsX8gDNL2Hb2uPy9eOG65dZ8bGaMw4eAqA6783EIrfE7htqRW/JjUvW
         JXPGUi8LEVx1dJFP/gE8zYkHD+taq1dXgJmpnLL3T2fFogpB4CEjN5fa4kXS0QB8jkdz
         0j36S3M4vhsnna/mRkwp2/Ao3Xjo3mBBKoTASrRZKX9r8iJhYB6aMx4YdTeUpBgP9CrB
         V59Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEhBstnh+SLcpK1PlmjszUVc2m94NS0kHfjq29+eW/trHzQB5wf3RLS9d0bMhEuJduVnEsE87ZFgZD@lists.infradead.org
X-Gm-Message-State: AOJu0YxjGf8Fe5QYg7eWPDa4ziYOHRIMhuSkolPWy7oqOGaEQA8ph4OX
	sRyikWKT2uyStN2msZ9uYPXEl0H77DNnrx4hNsLs+q0T4BhYs1Z2
X-Google-Smtp-Source: AGHT+IGP9vD4f+usD1dN2Pd1qglu1Ico7peraFsTdKUmUOdVH9Eh9axtmSAoV2WC55AmLq5qdFKL7A==
X-Received: by 2002:a05:600c:1c99:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-4280570b81emr85681105e9.5.1722419106019;
        Wed, 31 Jul 2024 02:45:06 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adc7dsm15111225e9.14.2024.07.31.02.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:45:05 -0700 (PDT)
Message-ID: <9192ada0-0be6-4fad-8d2d-a26bebe934be@grimberg.me>
Date: Wed, 31 Jul 2024 12:45:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-tcp: check for invalidated or revoked key
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-4-hare@kernel.org> <ZqeqqK3XBk_eoyZb@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZqeqqK3XBk_eoyZb@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_024508_016842_5BDC7627 
X-CRM114-Status: GOOD (  11.99  )
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


>>   static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
>>   {
>>   	seq_puts(m, key->description);
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index f5f545fa0103..432efcbf9e2f 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -665,7 +665,7 @@ static struct key *nvmf_parse_key(int key_id)
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>> -	key = key_lookup(key_id);
>> +	key = nvme_tls_key_lookup(key_id);
> We've had some fallout before with nvme modules vs built-in, so I test
> for this now. Here's the relevant parts of my config:
>
> CONFIG_NVME_KEYRING=m
> ...
> CONFIG_NVME_FABRICS=y
> ...
> CONFIG_NVME_TCP=m
>
> And that gets this error:
>
> vmlinux.o: in function `nvmf_parse_key':
> /home/kbusch/src/linux/drivers/nvme/host/fabrics.c:668: undefined reference to `nvme_tls_key_lookup'

Hannes, can you take look.



