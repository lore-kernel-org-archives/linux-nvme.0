Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50858EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 14:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjWf42UQYA0pstvW1dY+TJV0OEUfplMXQFAUiulmBpE=; b=cd6Fqmq8uJnLSZULxaWaoV2sVR
	3xgHfoZ9IdMXIVA8jfHNdXQX4KPFRu2sTNBPnQFfMebASDycMOQdY/tUQeRyDqFiitn8NE69i8noI
	qjmD6wSJ3h/8/Vk1IncWUcL5DPLcrnRgfjsbSBuc5tDVuUg/AlFWkzyKjmTmNkAHX7DxbTdYj0D1e
	+V/RFbuHsCl4vK9sB4CuGs2BWndWspX7ifKIbKneRrgisW63aKsFFrgV9y6/3DCoLX+IHe3TDNxnm
	jn9yLKHLB/YaEpDuANT6NTZoS22XvooMTCOrpJDhyd8B9DR7W2cXOY/o4xnwlYS+sTVUxwX7Ggem7
	R0z2BZAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBySz-00ElRP-2a;
	Wed, 21 Jun 2023 14:05:49 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBySw-00ElQj-2B
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 14:05:48 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso14546365e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jun 2023 07:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356345; x=1689948345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjWf42UQYA0pstvW1dY+TJV0OEUfplMXQFAUiulmBpE=;
        b=OYqIJcULcSL69TYQRXsYBTUkdy+82jtleDGlB+hfPiQF9PLShYZDUv73pi4LS5rsJs
         A0igdM0sG5FQAcoUie42qkQ1MXm6CcQB1GQ/2bCWaHJB9W11IrpXgN859K41f0QcFSHm
         n1hVAudqMuGJq3qz3pdOHTdI1e2GNzNcleG7hk5ALFNKklbsud1Fab3atnGM5BBg5YQh
         X8hfq/VFwAr+EMla7RtRx/X/QQq3mo3WXMYZk7izl0Aa0VoaEunD2IRItHbi89Pqo1sB
         +QaovefE6a8zhtGSjfiecDuEZxBNlsBofpxzsZkHaHe9bJZpYirBVLMxbIjRAOQT6VHd
         Yv+A==
X-Gm-Message-State: AC+VfDw4qE+BiKLs07rG0DySy9T+lMZsKxNp9m7zEIMznQ24VsCIAAZk
	CZfaRmNsb6An9qLjqhOm2v4=
X-Google-Smtp-Source: ACHHUZ5J/At+CMQhWo/1+EsLpTfsPUzSaVSoS/7W21QNNoZrlL3BW+yga2Pv1xjVTP20UsMLpE8hHQ==
X-Received: by 2002:a05:600c:3ba8:b0:3f9:b445:9037 with SMTP id n40-20020a05600c3ba800b003f9b4459037mr5958214wms.2.1687356344797;
        Wed, 21 Jun 2023 07:05:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003f72468833esm5114935wmc.26.2023.06.21.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 07:05:44 -0700 (PDT)
Message-ID: <361c3135-51c4-ae81-e4e2-30c54db4eb39@grimberg.me>
Date: Wed, 21 Jun 2023 17:05:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <87f547b0-7826-b232-cd01-c879b6829951@grimberg.me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <1733833.1687350915@warthog.procyon.org.uk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1733833.1687350915@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_070546_712184_A96DD2AF 
X-CRM114-Status: UNSURE (   9.14  )
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


>> What tree will this be going from btw?
> 
> It's aimed at net-next, as mentioned in the subject line.

ok, thanks.

