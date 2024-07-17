Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64760C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjRfV0YfKkR8VgTR/jAj6CLX1hC4I2N/08E6IWca4/Q=; b=QWav4jw+Qh9BVeQ5pqUZz+NUjV
	wbkkGzI6JxLkKCX9pZ1SQF5XdjXbh6tUpftzfA7cWPCwPT0CTFSr+6E6BS9BOtCbnq+lzC2N4YMOV
	uQOOTixLCMe5/fCiud4rmAtknUXxJO35ehYO1WBjLXPlFCvCZlqkxZbpompZqht5k3K+Ta0XLOTzI
	Lo25IckrIU6d8hh6GHjZkD0g2ZvZprDbdWQMMN+bViKuvhLcU57cGjeBWXEEjbI1GJ7r37RLoK27P
	/KzkLWXtW6q1AWDdzuIT+CJQslRiwde+eNmpUSEQUx98sqp5kRgHKumGRJ3f4dZ6uRLfjZh90q3Vh
	NrB4S0kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCfo-0000000F2gh-41v6;
	Wed, 17 Jul 2024 21:58:56 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCfm-0000000F2fs-0XWf
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:58:55 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426744ca29bso209115e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253532; x=1721858332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjRfV0YfKkR8VgTR/jAj6CLX1hC4I2N/08E6IWca4/Q=;
        b=meMPGE/ZSLuNIBldADv7EL8D4Iaof+1pisdujRtzveqk/EFZ4vnzTs7cC+Re5T8YLY
         Yf6ynhsjuR39DFdSXfAfcuHXgbrhGcj1Qc3SjsuqLfYyeu0GNXo0X/76+hTTShwyAxqV
         wmKTFt74B+qeRUDIyaeRZPeD7CAfTLaB9DFW3YDhvK9HXNIBUGvbZpXNrcUtlBvhXAmM
         V06zn3qR93CXelYA4n2RZAijNNZG2z7swMmnldUSpWoDnLl8hXJJh4UxQpOyArfx9O/e
         /4znMQKtkjw7XE6WXTCJ4MpsuJAOjT6CxscsVi8SVuyohGvNDZkYrq0Wc1eFVkabbOuV
         eRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6dCs9MnkvTn80igIqe/PzUUqyMni3H87QC90NRPpXWNCaQ6dQC7UX9nruzrppfq1nBHx/S7F+vUtczsmDYDBXstCgj8wpN7G34qRExpw=
X-Gm-Message-State: AOJu0YzFosR9i/PVrY1otxDthoJf2pxkROJglMr5/eU8TFkDKYfsih+Y
	SQqNk2T/g0PICX2KG6PXF9WSvQd4ZabRHtms/5K31jseG8OPXh1WzCVv7Q==
X-Google-Smtp-Source: AGHT+IEQLgojnGMQWNMS7KtgsaQSZerJw26vrEnx1/9RQdIl+V+nOqrqYp+WZRrnkrf0B8JvnUeO+Q==
X-Received: by 2002:a05:600c:3111:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-427c2cb8ba9mr14358415e9.1.1721253532111;
        Wed, 17 Jul 2024 14:58:52 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7792c99sm11163955e9.3.2024.07.17.14.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:58:51 -0700 (PDT)
Message-ID: <ca8a40e5-ce2d-458d-a3b1-505d9d4836e2@grimberg.me>
Date: Thu, 18 Jul 2024 00:58:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] nvme-sysfs: add 'tls_keyring' attribute
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_145854_202612_3D368DBC 
X-CRM114-Status: GOOD (  16.42  )
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



On 17/07/2024 12:10, Hannes Reinecke wrote:
> Add a 'tls_keyring' attribute to display the contents of the
> --keyring option from the connect string. Adding this attribute
> allows us to recreate the original connect string from sysfs
> settings.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/sysfs.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index e5cd738660b1..462d71e2fbf8 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -689,6 +689,18 @@ static ssize_t tls_configured_key_show(struct device *dev,
>   	return sysfs_emit(buf, "%08x\n", key_serial(key));
>   }
>   static DEVICE_ATTR_RO(tls_configured_key);
> +
> +static ssize_t tls_keyring_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct key *keyring = ctrl->opts->keyring;
> +
> +	if (!keyring)
> +		return 0;

Same comment as the last patch.

