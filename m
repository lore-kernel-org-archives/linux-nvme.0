Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99211E7B5E2
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifMada/Ec0wG4fmWRFeePI5fo54s5fxBvPZqeUNAEsQ=; b=wygUZwRH5qmCjqZYLhE+FrsIaU
	bDNafKqIoFV4pv8BPbAbNv3q6WISHNw1lL6FAU8xu+IRxFP0ssAa/Mh9pR5YScl3H6SdfCiI2X3l5
	vZNV1mvZToK0f+JS4vth/hUK9dAP7/nSF/ydZ4dgKVnMpuR1uhYlGy/TXy6jzuaYl9wlc6l7r9/hT
	FkAG+0ZI8XiI4pqvKtAvKeRkxQpNctg/F16gdPmnozEJ7Ojt6QA2il+zaBni9JTzj987nV3kB5VIk
	jlZxXK/YocNudP39tdN0+S+7ENuI2Ue+hoT59jTkZ7FehZyPx2v8O+fL2MF0hQRc8s7TLhTjpyS7v
	oUpzqTkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnyO0-00H6PE-2u;
	Wed, 04 Oct 2023 09:41:44 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnyNx-00H6ME-2C
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 09:41:42 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so4039155e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 02:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412493; x=1697017293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifMada/Ec0wG4fmWRFeePI5fo54s5fxBvPZqeUNAEsQ=;
        b=ct+RBqvUk3lDbV3bqWedXZiwOeNaFLCQjxdLe/xUBq6VhI0UFKaysElEJPGRuzzkNY
         K/BNLInpciIn15z/bb2muc7S778KZJqHzIQbvEF9KIR77VHuyZeo09wMxkNXdt36etBq
         AgC9sRSCmhHjCdOKs4V1gds00hnANeaIJrjgZb9nhb6I8Uxr/Cb/NM/KwLShrv1qxnsQ
         WH7hcG8dO2jY+FImiL4oBhQHEHyZEk+Ag4DVfHyrx2RVJvKOIr8Qv+guoByx7/uWvYDV
         AqXSFw26fipvcii/VEp0AhqAbl/iNRQ2cpfMccsFcHdYWJ5k5PfhemKD335Y+5n5EC2G
         KQgw==
X-Gm-Message-State: AOJu0YxrfoPUQBuMcB11z/4nYG1qMVLz62frdFH+MvQVAsOWzjwg/eRM
	Xx2L3cXdX6fLzTRob/BQna0=
X-Google-Smtp-Source: AGHT+IH3qG8Om251uKRLbUeetK66chKfQ2k0y45RvwLUdJVPnRg/N2oAEEd7YFcUyATWhHpskEOdiw==
X-Received: by 2002:a05:600c:3b9a:b0:3fe:21a6:a18 with SMTP id n26-20020a05600c3b9a00b003fe21a60a18mr1737804wms.3.1696412492367;
        Wed, 04 Oct 2023 02:41:32 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b00405391f485fsm1043839wmb.41.2023.10.04.02.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:41:31 -0700 (PDT)
Message-ID: <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
Date: Wed, 4 Oct 2023 12:41:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Content-Language: en-US
To: sj@kernel.org
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, zahavi.alon@gmail.com,
 stable@vger.kernel.org
References: <20231003164638.2526-1-sj@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231003164638.2526-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_024141_718179_E6784228 
X-CRM114-Status: GOOD (  16.35  )
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


> Hello,
> 
> On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>>  From Alon:
>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>> a malicious user can cause a UAF and a double free, which may lead to
>> RCE (may also lead to an LPE in case the attacker already has local
>> privileges)."
>>
>> Hence, when a queue initialization fails after the ahash requests are
>> allocated, it is guaranteed that the queue removal async work will be
>> called, hence leave the deallocation to the queue removal.
>>
>> Also, be extra careful not to continue processing the socket, so set
>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>
>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Would it be better to add Fixes: and Cc: stable lines?

This issue existed since the introduction of the driver, I am not sure
it applies cleanly that far back...

I figured that the description and Reported-by tag will trigger stable
kernel pick up...

