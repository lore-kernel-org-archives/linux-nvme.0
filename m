Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE185C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dtqtWKzwvzkkAl/0bMMBYU9tOrtgUv77meRWu0a0WsY=; b=RnAvNkcIFod4vcTT0KzqnJ21vI
	ytpy3tRodWfYVlQ41W55sSKMMWnPzMkLtXz2lByNY2Q3ZvZYsxvswBwiVqToNYFrStpe66T9aTjZb
	OQjXyZEiZWUVP7zH/eTpUd2l3yF/8Vym8mcy80ghGH4elWsIjs7fqZ+4n+LQVlP17UmJUlR741cZF
	0IvBQ9r2x1wLynvHBu8fc57j919J+HSYVj42zG3e+f4OSBtIzzjzaW4hq2dTgha363PX+ziy3No8t
	Eb7WSb1uVJDbyUZSztpA2NMggVgVlpv9enT24uMRSBzgpWu4l4X/1ct/0SyBFj96AtEWLiK3SVaub
	WWaX8slw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2Oj-00DyKb-Mt; Wed, 23 Mar 2022 14:55:41 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2Og-00DyKB-PV
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 14:55:39 +0000
Received: by mail-wr1-f44.google.com with SMTP id m30so2528338wrb.1
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 07:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dtqtWKzwvzkkAl/0bMMBYU9tOrtgUv77meRWu0a0WsY=;
 b=5HHK2586ffR+mCM7PMgPCGDevpKBZlGFvpBT2W1OOND48n/1DF/2mOkZNYkOlKYhXL
 fNtovKm9pcO0TpKs4JBG9zW8lCtuNmnNY5dGbDQctYYd5DanBG7q+sUEJ4CkM078L0Du
 jORUdp9tHLd7st0zAWy6sAmjGH1jEAmyLUh3eyeUztrouJZprd2wLgzN7dCKYfvBuaid
 PpQ5uBVipQHtsiB8itmpSif9YtnUXQ244v63TXcU3GFReBlpxsrKlnRUVCHsHIRSDH4o
 8eo8W6aXAcvcC3JN8U9JhN5OuQxv/0VjaKMDMu47JsWszVyO3wpsHYpDm5OFJoi1+diE
 3TKQ==
X-Gm-Message-State: AOAM533tWpNv9VFe0wC/EhEbq75xOscFlPXpgCAVn0p2jHm3dHwD6uVk
 rjbWsmKzbxDmQ2KQPZM5Y7c=
X-Google-Smtp-Source: ABdhPJw9lW1+4IMyNAIKe3hf2140sqqm9vocyMvc+tgZxkwn1P3j/dUtSDMbj6UAmfEppCr0u+HnpQ==
X-Received: by 2002:adf:fa87:0:b0:203:f28e:76c3 with SMTP id
 h7-20020adffa87000000b00203f28e76c3mr144948wrr.579.1648047337245; 
 Wed, 23 Mar 2022 07:55:37 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 e8-20020a056000178800b00203da3bb4d2sm114506wrg.41.2022.03.23.07.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 07:55:36 -0700 (PDT)
Message-ID: <faa92ca7-5ede-f6dd-1ac6-857d88583487@grimberg.me>
Date: Wed, 23 Mar 2022 16:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/1] nvme/mpath: fix hang when disk goes live over
 reconnect
Content-Language: en-US
To: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com
Cc: ushankar@purestorage.com, Anton Eidelman <anton@lightbitslabs.com>
References: <20220323035551.1524128-2-anton@lightbitslabs.com>
 <20220323144504.1557518-1-anton@lightbitslabs.com>
 <20220323144504.1557518-2-anton@lightbitslabs.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220323144504.1557518-2-anton@lightbitslabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_075538_858292_1AA08CC8 
X-CRM114-Status: UNSURE (   6.45  )
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

This looks good to me Anton,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

