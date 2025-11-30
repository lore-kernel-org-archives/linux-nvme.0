Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86018D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tre+aqpQoGwCES6IhPumHwKmGx1YVH8Pn714/Q9qkzo=; b=ORVB+d2OhyP60VWM/aeDsNITIT
	oF/+Niu7uhNdJpFVxhsXTEoLZwzw1baYY2IiGQ+xN86OeYocDSl2vhFeXZdPecOolsqUz3vPjixDJ
	cmmgqqZqoTWKgNrCRRKLBLoR3yBCEFBYvi6kwpPDVR5EnRaiyUoQ5kvbgZzETKygOJ5D0rgmSnfZt
	2KnFzFdIWVYkW2I/1NO3YtEMle8Whc3NsmwAEnG9wu3bhAPkRaqqQ/lMGGxT6MvzjWCYMIkIVvAwB
	Ze9PKS97mUFZoRcna3QKQTTwYkkysRresQI8XuVNRLHH+xDMug5mmiIHa3KemXN0bEaB1DwlBsjmQ
	SemCY9Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpgg-00000002cGF-390v;
	Sun, 30 Nov 2025 22:14:34 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpge-00000002cFh-2Oan
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:14:33 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso2224564f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764540871; x=1765145671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tre+aqpQoGwCES6IhPumHwKmGx1YVH8Pn714/Q9qkzo=;
        b=IVIQjDGDBFd1NBU5Qel+nwWF62/o+vR/9RluqITQR2mtLG7t8Z6J6Vd9vOzFupdjbD
         Patpji7Tf3+2DemK0kj+DJ+45o6qDBSmSdDJwnXiGYJYx9rnBplB4nRTNa/Ie6Aic1fA
         DscHBbX5xSjgNFRLML6NttwmCLibycARupmFcJCWZY/DwroWoYoBeMyOtD8H5cpR207v
         zi4wKl79nVMc/jpFeSu3V/PYIEhtiGBGve5sNkE+3tmkkSDNBdI8JQ6uHbNkQ5dujgwj
         ekvnxBSQbVs4iwbyYz+88jWbhO2PY0Q1sRSUCgepy5ArBJ60Fx+3bHt45lnQh0reky98
         JOzg==
X-Forwarded-Encrypted: i=1; AJvYcCXuoFIwe/Sl79xe45V2xaGGVfMu7+EBYPFrScGDT3Vl2jDEBpcIJikc7Mt4n9+Fz7JDmkVMHdCB4Io1@lists.infradead.org
X-Gm-Message-State: AOJu0Ywg9KfBYKZMQO2prwbj0guwoIutEXIQvjPQkbTT3ueFhX7YcC02
	L0buQ3bOfH0JwMd7AQTR4s5e65z5cE/f7WRJkI1VSRw3bkNqXz1+lwMOtFJxoA==
X-Gm-Gg: ASbGncv2TSI5kkTycyVdUx1C2X1Vu4HT5x3VGjn/VerYSrWqZ883t5tG/lxQ9GOIliB
	brDHiljXibMVHwmNBsCwOn2HXq/3khogwO2D7Uso8wgnuv42aZlyjFhVBjLB+W38vKquAonNOpD
	lOsjYsYVxwmXQ8pR4zM2Qgv7G2nwAy5o8k4zKvqQzIshQOg8kHtl8DkJ8gIOPScMhclvPbk2QoJ
	vj/d09Wguv5Sf9bvHPZRg6rBIPETP719XdUeur7hV26Lm5/pV/37pehWpcPvUlpj/Xtb+Pv94FJ
	x2z3Ag28Of5zoQ4Ae1rZc4FOzrQmVyxELj1PcnayuAUaP/HBJ8TGbauKorsusoyMYkFqNVITEDg
	7b8stxKUYdPaRdBtNR4hQ1VPnwYiUdOBrlrW7jqEUg0i5Qrtn8Gf7gIVCq5LK3RI0nU29tJyh9Q
	qYhHhAZZneiBP/OS0mKQ99PHMSyQ15Euup38FUgTLxedF0oXdAUII=
X-Google-Smtp-Source: AGHT+IGZXgMqeqzmDR/SYlTSXM2k52rEESTR8vYbR9RmQ+jpK2AlACU+dIHNdZwZjZkp05cRonkUKg==
X-Received: by 2002:a05:6000:2681:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-42cc1d618b2mr38594482f8f.58.1764540870742;
        Sun, 30 Nov 2025 14:14:30 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca78f77sm22320944f8f.32.2025.11.30.14.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:14:30 -0800 (PST)
Message-ID: <b5b148d6-8231-49ed-857d-1d38cbad01db@grimberg.me>
Date: Mon, 1 Dec 2025 00:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] nvmet: add configfs attribute 'dhchap_keyring'
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-10-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-10-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_141432_616887_9F2DC19B 
X-CRM114-Status: GOOD (  18.16  )
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
> The authentication code now fetches the key from the kernel keystore, so
> we should be able to specify which keyring to use for looking up keys.
> So add a configfs attribute 'dhchap_keyring' for the 'host' directory
> to specify the keyring to use.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/target/auth.c     |  2 +-
>   drivers/nvme/target/configfs.c | 60 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h    |  1 +
>   3 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 036652de3489..090cc1dc0655 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -69,7 +69,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>   	}
>   
>   	len = strcspn(secret, "\n");
> -	key = nvme_auth_extract_key(NULL, secret, len, &generated);
> +	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
>   	if (IS_ERR(key)) {
>   		pr_debug("%s: invalid key specification\n", __func__);
>   		return PTR_ERR(key);
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e165905fab31..2642e3148f3f 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2217,6 +2217,60 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_host_, dhchap_ctrl_key);
>   
> +static ssize_t nvmet_host_dhchap_keyring_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_host *host = to_host(item);
> +	struct key *keyring;
> +	ssize_t ret;
> +
> +	down_read(&nvmet_config_sem);
> +	keyring = key_get(host->dhchap_keyring);
> +	if (!keyring) {
> +		page[0] = '\0';

maybe "none"?

Other than that, looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

