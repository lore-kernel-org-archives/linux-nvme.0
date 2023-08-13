Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA9C001DB
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AkCPyI/A+sycQwXChV48hDRQ+6Oy1qN3dD/aCL/aSLA=; b=Lw6Nwf1Zlh58RtCd8Smiy+fNvL
	AsjecHCnKiULi1ElAtYgJwLLV6oZD2YMniDqDmNceCxUr16V9UWW6NU1wTLaKycCbM/UJhzj9B54C
	apOtxOroh/kpL3JveX++vdYsGhU5Bg/vxlqyHuclVwnEj411hLHMy1B/jXJAAe1lP7Zk1IPX8hLPu
	ipr3/NgnQBi4NkgHXbFQKMrqCXax2SOq9UGmjwyw7Tt8EZipV9u4nwpYno/OETgHl4MwREle0MAG+
	JGXfG23EKcqUeX9I0wAyCJ/glDtd1bVzcjsPKdYg5RVSZj6DlOAqg9hcp9f6MSFyvpN6YpvZ+iwBI
	Uv9ITLcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAr4-00F8rJ-2T;
	Sun, 13 Aug 2023 13:10:02 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAr1-00F8qK-37
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 13:10:01 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe247796ccso9008875e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 06:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691932198; x=1692536998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkCPyI/A+sycQwXChV48hDRQ+6Oy1qN3dD/aCL/aSLA=;
        b=CCFVlJwlfrPg2vycia7Xb7LZEXCh9cOGgCw39YZO3N8M/7oz3BeV4mqZ2M+pLS9Ghx
         zcjTNSHLG6J9iTw0Qu4K85rz4rnoF4lokVs0/wDsqES2inMB0PDCoF2gRezLnhFjWHWQ
         D/TBfX5ebEQRJqoO3zzYDL9iLcogRg01tNIJ7Bf0jRsHey8bZJ31hBOGncZdX6+behTY
         z2kny+S3rFjbNEsaYuTh/A1n1+5Na29SKjmW1OXbm3tpsrm+wGSkUe16Bre5Rj1vCYoz
         P2gpsZU3BEovNoOc+KB2Q4peKwpqncWhAkWyspZjOpSq82lhx1otlJeMxxL0XrGITfOm
         TU1w==
X-Gm-Message-State: AOJu0YwtGq5irZ7yYKE0Pm7RwL44TOaHEIy88e/d14L+ltenDCL1b80n
	o6dUF38uxUBgFzQNiLekanc=
X-Google-Smtp-Source: AGHT+IGTagoNGP/ChjBXSbyVkHH5xDQ6dfiDDJa2sz3LpnM5ZKO+Dgl1tKEvFUavNUg3fTBCIykiVQ==
X-Received: by 2002:a05:600c:6010:b0:3fa:9767:bb0 with SMTP id az16-20020a05600c601000b003fa97670bb0mr5856682wmb.0.1691932198254;
        Sun, 13 Aug 2023 06:09:58 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b00992d70f8078sm4539985ejb.106.2023.08.13.06.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:09:57 -0700 (PDT)
Message-ID: <b28ee779-e18c-e0fa-3268-71805d23843b@grimberg.me>
Date: Sun, 13 Aug 2023 16:09:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <fa164dea-b34f-40dc-90a5-091d3a7f5b11@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fa164dea-b34f-40dc-90a5-091d3a7f5b11@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_060959_998029_8519DB13 
X-CRM114-Status: GOOD (  17.51  )
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


>> Currently nvme-cli is able to resolve an ip address from a dns name if
>> traddr argument was given as a dns name, so it does that and passes down
>> to the kernel the resolved ip address.
>>
>> However, if the dns resolution changes over time, the kernel will not
>> be able to reconnect because it has a stale ip address. While this is
>> not a real use case for nvme subsystems, it could be a valid use-case
>> for discovery controllers, where the resolution is made from a dns
>> name that may load-balance/failover over multiple endpoints.
>>
>> The last patch (7/6) is for libnvme to pass down the traddr as a dns
>> name if the kernel supports dns queries.
>>
>> The inspiration was taken from the nfs client that does this for
>> redirects or locations discovery.
>>
>> It is an rfc, so feedback is welcome.
>>
>> Sagi Grimberg (6):
>>    nvme-fabrics: add helper to resolve ipv4/ipv6 or dns name
>>    nvme-tcp: use nvmf_resolve_address helper
>>    nvme-tcp: re-resolve traddr upon reconnect in case it is a dns name
>>    nvme-rdma: use nvmf_resolve_address helper
>>    nvme-rdma: re-resolve traddr upon reconnect in case it is a dns name
>>    nvme-fabrics: expose support for traddr as dns names to userspace
>>
>>   drivers/nvme/host/fabrics.c | 29 +++++++++++++++++++++++++++++
>>   drivers/nvme/host/fabrics.h |  2 ++
>>   drivers/nvme/host/rdma.c    | 21 +++++++++++++--------
>>   drivers/nvme/host/tcp.c     | 21 +++++++++++++--------
>>   4 files changed, 57 insertions(+), 16 deletions(-)
>>
> In principle looks good, but what about target support?

I don't see what the target needs to support here?

Just place nvmet ports behind say nginx with a load-balancer, and
voila...

