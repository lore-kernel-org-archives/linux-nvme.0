Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D726C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNK1NJAI1fkUW47cH9u4dB4Oh27DLMH5Z33vw6bc3n4=; b=nw9380MHbiwR5/CMGrdrbHsqPH
	zRluWB45roErvB0NY3/sqR3EIEjvfA6IQFr/LcPc64OIRSF+TLDd5rb/NF/WXjrQPmsnCdX95wnwP
	DrVDaOoK2wi4XeLKKuZ9gBdX0lsu+icGvTVvibqxmCQur73ELeOZvamBvd3g6LQPjqbxVUSdTDH3+
	uJZTHUkd6UuPwPt8+/vOZVeAe6U+b47aCx5lSkqX2W7nSsSyTjHQONjO6+gmTMs1GuZODK41AeNvU
	F4cbohKuHRjBe4mVz42b5AbQPyCmm3c2y8PJvTKDT45igQ5nNqE4H6dDEl7A4loo+za2N1WULrCpH
	nwKmfAVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGL1-005vv9-25;
	Mon, 01 Jan 2024 11:20:07 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGKz-005vum-1S
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 11:20:06 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5a733823so2626955e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 03:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704108003; x=1704712803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNK1NJAI1fkUW47cH9u4dB4Oh27DLMH5Z33vw6bc3n4=;
        b=FW1neUBDAPpnjlXwv8Zbl557sc0iykwww2/t3Tnn2gncLFEfzxj8IrwnjO3omZ7FzG
         WwP0kpz5ML1t+YXs9QRKbIKliRLIN8R6vfaWR7nsYBkRAGHlTX3HVlrtl8cERJvUkZUk
         yx/493wqPXkbpo4DLvASP+Fu7Wp4MJGrn+ARgd1LlKqm5TCgxNh1EhCEtTtWkQX8aNtT
         apr99ymInsLIJZsF2yxb/SoQ0hrK3M+OCvXVC3AOPmV3ptVP7ow5JL+afSfoH09OJFss
         nykci4vjOw8jimBLcIzq42GECqhR9afjiUgYjdDUdKfB+cB/tNC1iTM4VRLsuJ4KglBv
         mNLw==
X-Gm-Message-State: AOJu0YxAcs9wTHGZD14xqQMg6l9hYdaXLAXV7mb1UoAsn4OKzMO7xPqj
	e+bEGM9iaXsd/H07AKuWcHc=
X-Google-Smtp-Source: AGHT+IH4p5D72SBAIuDNYvVbZPWndxFuZB79QVlpRywXppI06DbeAV+Zae7DOIRX9XQrpZ7ODYCUlg==
X-Received: by 2002:a05:600c:4f90:b0:40d:5ae4:726a with SMTP id n16-20020a05600c4f9000b0040d5ae4726amr10886363wmq.4.1704108003034;
        Mon, 01 Jan 2024 03:20:03 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040d5c58c41dsm20303033wmq.24.2024.01.01.03.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 03:20:02 -0800 (PST)
Message-ID: <8dca8961-ead8-44d2-bc58-2be9edbe5d81@grimberg.me>
Date: Mon, 1 Jan 2024 13:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] nvme-fabrics: move queue size definitions to common
 header
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-4-mgurtovoy@nvidia.com>
 <41e49eb9-24e5-47c8-96a9-12d47cfe3367@grimberg.me>
 <24453b86-800e-4a92-b78b-5fe7d92a9c8f@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <24453b86-800e-4a92-b78b-5fe7d92a9c8f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_032005_493347_C4AAA3CA 
X-CRM114-Status: GOOD (  12.48  )
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


>>> These definitions will be used by host and target fabrics drivers. Move
>>> them to a common place.
>>
>> Don't see why these should in any way be common.
> 
> why not ?
> why should we define these values separately for hosts and targets ?

Because the host and the target are separate systems. Don't know why
they should share the same defines for something like this.

> 
>>
>>>
>>> In the future we can introduce a common nvme-fabrics header to ease on
>>> the maintenance of the global nvme.h header.
>>
>> nvme.h is the wrong place IMO.
> 
> I've mentioned that it will be better to create 
> include/linux/nvme-fabrics.h file for common definitions for fabrics 
> drivers.
> But we can do it incrementally.

I still think that nvme.h is the wrong place for this. But if others
don't mind then fine.

