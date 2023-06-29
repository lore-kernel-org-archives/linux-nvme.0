Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A5EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 21:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5sXNz3T27fieAIRTR48zTnONuZ1yBFOaZf/CPHZQ27c=; b=cuVrchJ8MZ0FGS1UunEfVMXVdu
	u0d4XSg/KxuP6UyPcoyzjs8EDN2efI04P2ohT2MD30+aEN99Zagzp19qai8WFYdRiBTX7vt3z2r3b
	KyDI5ViyU1+fkgjuxwkZYJU3cRzESGTeQTsHz66IOlvrMv+ZFBmxLsv8gZh+agRtzHxQZNTtNrvPo
	PeEBFlUVeilbX9N1rjhnA/pPTdtNPMOh5BWeFEQoWhZH6QdsVr8M9XaPg9hXDQgd9/WwyYaPfWWdV
	7Fe52Ope6kmW0dIQJeLcytA8Ki9XWgDSjxX1sJj9JlCOd9ihAeSQweC6gP5Vu5WfHSPmiA23omlCL
	GHHP5Ztg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEzGO-002EtJ-09;
	Thu, 29 Jun 2023 21:33:16 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEzGK-002Es0-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 21:33:14 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-313f0ca48c7so367165f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 14:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074391; x=1690666391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sXNz3T27fieAIRTR48zTnONuZ1yBFOaZf/CPHZQ27c=;
        b=KpI7p5CnEquIXi9QZ01uGSS+5LmKFGIaRAQXU1v06Zdv+nxHlZ9ELhNBAW2LNCuqfe
         J7HQmQC+MPgWj/jv8kdr8oefBZ7h8UQ1Y/UGdOxj7YvtoZhDYcyoDnG7dXoN4jgenu1a
         Qx6/WPhWvxj9pisV15N6HpGytQDl3IYii2QYg99Teg7B7iiojvWZpl+SgHZdENpnT5pi
         4k6E3EzoNEWyRkN5v/0I15aR7ddrSsmFJai/VruyH0sNgGdgeio7rXkcdvp871VWVkU5
         mgP37oJG0pKOZB7NGV93uOfkr/i8rg7d4utG1u8iZO/l5eV6StW2bmqsTGZJxGKugUPU
         GAxQ==
X-Gm-Message-State: ABy/qLZrPWdUSU1mA1o+CY2JZXymmbnoeIObLd4A6TJX1ehrCHjxwrZz
	VAFQzVesx3qg8GKRaBQ2lc0=
X-Google-Smtp-Source: APBJJlHhxv+5GV3Rjo7juNC1oow8yS4xjV2IiwQgUGk5HHlOOrfmZLq+H5OaYbuw+s8Py7L4F8UYoQ==
X-Received: by 2002:adf:e5c1:0:b0:314:1e8:40ca with SMTP id a1-20020adfe5c1000000b0031401e840camr598464wrn.3.1688074390598;
        Thu, 29 Jun 2023 14:33:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600010c300b00313f9367844sm9301920wrx.88.2023.06.29.14.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 14:33:09 -0700 (PDT)
Message-ID: <6021d82d-ac0f-cc03-d9b2-19dcf20e48ee@grimberg.me>
Date: Fri, 30 Jun 2023 00:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
Cc: Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <55023.1688073781@warthog.procyon.org.uk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <55023.1688073781@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_143312_814331_6B7D5B0E 
X-CRM114-Status: GOOD (  16.48  )
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


> Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>> simple way to check is to run:
>> nvme_trtype=tcp ./check nvme
> 
> It says a lot of:
> 
> nvme/002 (create many subsystems and test discovery)         [not run]
>      nvme is not available
>      nvme_trtype=tcp is not supported in this test
> nvme/003 (test if we're sending keep-alives to a discovery controller) [not run]
>      nvme is not available
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [not run]
>      nvme is not available
> nvme/005 (reset local loopback target)                       [not run]
>      nvme is not available
> ...
> 
> I have the following NVMe config:
> 
> # NVME Support
> CONFIG_NVME_COMMON=y
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=y
> # CONFIG_NVME_RDMA is not set
> # CONFIG_NVME_FC is not set
> CONFIG_NVME_TCP=y
> CONFIG_NVME_AUTH=y
> CONFIG_NVME_TARGET=y
> CONFIG_NVME_TARGET_PASSTHRU=y
> CONFIG_NVME_TARGET_LOOP=y
> # CONFIG_NVME_TARGET_RDMA is not set
> # CONFIG_NVME_TARGET_FC is not set
> CONFIG_NVME_TARGET_TCP=y
> CONFIG_NVME_TARGET_AUTH=y
> # end of NVME Support
> CONFIG_RTC_NVMEM=y
> CONFIG_NVMEM=y
> # CONFIG_NVMEM_SYSFS is not set
> # CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
> # CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
> # CONFIG_NVMEM_RMEM is not set
> 
> Can you tell me what I'm missing?

install nvme-cli.

nvme/010 is enough to reproduce I think:
nvme_trtype=tcp ./check nvme/010

