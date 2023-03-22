Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D32C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Itxw5IE33AlZCE+Tl3yJIPHE+/Q9xLb+3VZa9HsvojU=; b=5CNaU4X4tc7GW4uubqHf0gmi21
	DDdyObqh1RO0cQPbZt6ZgW0r2bz35kk+TitbhHSUUpgRumYda0yNA4xzNh4itmO6jZJrjcsYCigbL
	m7gP5cWyFp8NhcjZABsOMTYwycqGCguaNu0RNCGt4j47JKdb8/gWK1ksct5vh5FV/JykkAR4DMymu
	d+szvuzP1ZK6927h5jc8c1Ubr+P0bsuay7QsGCjlxXxymv0Fvn0hciRQid23SdvfRtzfy7nsMq4js
	AfrsBVT7RiNrLpkho41wxAi+6wHbsex5FjOAaRHkzfFHebnR4e7WkbLqR2yLWWauv1gblV8cO7jW/
	xGPDLO4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petlc-00FA8n-3A;
	Wed, 22 Mar 2023 08:24:21 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petla-00FA7y-2h
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:24:19 +0000
Received: by mail-wm1-f53.google.com with SMTP id n19so701479wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Itxw5IE33AlZCE+Tl3yJIPHE+/Q9xLb+3VZa9HsvojU=;
        b=KEum2SSNEXmtnE3c4GN50kYddMbkzXln08vm7HIQ091BsJ9B8JxnXgMO5FEJtVvsjM
         INxod5XzpZeWeiQL0gBLen//PwNY8IThZrn5Ln4Oqr0cAivlJNC05JcRdGPBLxk22OF5
         8YHx6Yy1h/NXrs8EErWwN2izTAssDQzkR+Q9Wlj45co1l2rYMskwdOgxQuILSJh6SZAD
         D2YIafGJFcA17mRRCb1LkHHnsEHBlBpaV4eLFp85yAkSc5iZQXQBa/LiDj0hHl81cGV1
         tXJhrNFW4Q8m0EPXcziqvPmkBL410Z3kA9m28xm5yNa4yJSf86MQoZ8QLautbppjqXP5
         RGgQ==
X-Gm-Message-State: AO0yUKUEIhO1yCTkhzTaCtZlbrraNQsMx3QBf/4qO06uRCsrt5rFKgVA
	xoIf6jhinacluzKA5SvthNZsNSvoHvA=
X-Google-Smtp-Source: AK7set+uAs0GxmmZulsAdKcTQIyQHvORDhRmLV3BHpkCw4PnlBlBCRi1rSHzWD9mNrj1/RmP6CTdqw==
X-Received: by 2002:a05:600c:45c3:b0:3eb:42f6:ac55 with SMTP id s3-20020a05600c45c300b003eb42f6ac55mr5620015wmo.1.1679473457175;
        Wed, 22 Mar 2023 01:24:17 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003ee6a91b596sm511424wms.29.2023.03.22.01.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:24:16 -0700 (PDT)
Message-ID: <5f3b28e6-3bfc-d46b-7265-725d2c661c70@grimberg.me>
Date: Wed, 22 Mar 2023 10:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yanjun Zhang <zhangyanjun@cestc.cn>
References: <20230320133334.57325-1-sagi@grimberg.me>
 <20230322082034.GB22321@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322082034.GB22321@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012418_880408_4D998EA3 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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


> Thanks,
> 
> applied to nvme-6.3.

Actually, I would like to waut for Yanjun to explicitly
give out his Tested-by.

