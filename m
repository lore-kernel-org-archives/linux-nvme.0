Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F9FC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4zCq79c6DdSRZRWz6ryhsp/B4g9Ll6mwG44eDtG8qFo=; b=OTs6Rur9v8kqZ31Ko6a67v459z
	HQDU+OsAKCUT4dI8KCItB4eC9WIkWJstUf1x1YIF1BqInoweiGXunK59RtPm+pu3xgvsQT5gYafxa
	EM5iHF344yai+g1DK5NM+C+9663ioMax1VaW/BlwlvikZKveE4CQs8Ddgg+ZgBdqCQeM7SnJf8uBx
	GNp8iMI5DsHE3HDuSB8Et1MiudhoZAr3x8MFcv5sa2uXLBvxw869sTdi3P5N2BFXngnYSFYZonDh/
	Uj1ih1qKm5qrRXXV5kZybFjahfZYwfkQsyb98Innuo4EfVNSeApClhd6KjNbJ4MsW8uGySVuV4xkx
	g5XZTMcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA63c-003VpO-2z;
	Mon, 04 Dec 2023 10:20:08 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA63T-003Vol-0r
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 10:20:06 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40b4ff0f254so7786575e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 02:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685196; x=1702289996;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zCq79c6DdSRZRWz6ryhsp/B4g9Ll6mwG44eDtG8qFo=;
        b=fN/MT9OwWupjlwP5mNAHpbI49XTdlpvOnCfdvFWmE1fkLd+JkNM/dluTxgTkQnhsNN
         vtiBqt1ROx0dIpRq6cyrEY2AyQaGzPU/VliZ6wepvraOtlEUYUxAJ09UcohTRgu3nZMD
         KPtr7PnlvwOAI6fc9MEu/nWskDdTfFBhj99n+Bmu8zWebUAcER3pRhWukdl3unEzM5xX
         WNUACNd0GVUd97l+yYR9u+izFPXxHTVk6LUkaSebyv3ZM9KZWwgoxQmC1AzcN3Eh0ojw
         4IMMQ0Zf6XI1WQkAmIoMBEcTwp7oCDjR04mSvYbhIBnS3QSux3N9bpuSlsM/62db1BTA
         9wtg==
X-Gm-Message-State: AOJu0YwkFNORO0NAreCAqjlUhOBSadnqE6z0C8ox1LcltlDCWSum3HcU
	Z7m+dEXNGeBhtdY8yivpGUM=
X-Google-Smtp-Source: AGHT+IFhqwRVTvwK/yXdFm+3VB3g0XSLsCaZIOgXKcbC094VaYXrluQJCRdeR3X9ZDs1HQ3bZssXMA==
X-Received: by 2002:a05:600c:5115:b0:40b:2971:4b73 with SMTP id o21-20020a05600c511500b0040b29714b73mr8446045wms.2.1701685196023;
        Mon, 04 Dec 2023 02:19:56 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm18061978wmq.18.2023.12.04.02.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:19:55 -0800 (PST)
Message-ID: <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
Date: Mon, 4 Dec 2023 12:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
 <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
In-Reply-To: <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_021959_387896_B00319B0 
X-CRM114-Status: GOOD (  17.69  )
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



On 11/20/23 15:48, Sagi Grimberg wrote:
> 
>>> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing
>>> controller teardown") this is just for reducing the memory footprint.
>>> Wonder if we need to bother, and whether it won't be better to remove
>>> the whole thing entirely.
>>
>> Well, Sagi added it, so I'll let him chime in on the usefulness.
> 
> While I don't like having nvmet arbitrarily replying busy and instead
> have lockdep simply just accept that its not a deadlock here, but we can
> simply just sidetrack it as proposed I guess.
> 
> But Hannes, this is on the other extreme.. Now every connect that nvmet
> gets, if there is even a single queue that is disconnecting (global
> scope), then the host is denied. Lets give it a sane backlog.
> We use rdma_listen backlog of 128, so maybe stick with this magic
> number... This way we are busy only if more than 128 queues are tearing
> down to prevent the memory footprint from exploding, and hopefully it is
> rare enough that the normal host does not see an arbitrary busy
> rejection.
> 
> Same comment for nvmet-tcp.

Hey Hannes, anything happened with this one?

Overall I think that the approach is fine, but I do think
that we need a backlog for it.

