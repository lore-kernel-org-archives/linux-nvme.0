Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C71C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B02gZxRZ0FFKcDcIbMfBx85QHZrsjiSIe7pV7uhbB18=; b=mWYen72Pxp32Se7MKOiWgA0BZs
	4UXyoqnHy+KveZtrXQITDxL+65wH8OlLjKM3R1G+nZHruoV0hL9W9MnA0KneamvcoxlC0i0HpzJCy
	OkZZu7ZhoIBpsrI2B9dQwra9nrXi6u2qQKlmcBm8oxkJ6MQXFejvpz6WrBeLG4N13bQ4RwmhTr0Fl
	l4Fa3mOjJeWeCupgyShXt7Iy6UK6UUB2vPSoNZqE3F4+n+hGXoMTLGO1xL31yRFxWbjhbABqLZylN
	MqERUCWgzCC2QKH4TrmP44vpIESFH1PocCkjhhH/kR1RD1T+Lj41SW1cr8khmQKCq9d10vrzlZKPw
	TH9zlXhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZwh-00C9rp-0o;
	Tue, 21 Mar 2023 11:14:27 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZwe-00C9qP-20
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 11:14:25 +0000
Received: by mail-ed1-f44.google.com with SMTP id i5so11223591eda.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 04:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397253;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B02gZxRZ0FFKcDcIbMfBx85QHZrsjiSIe7pV7uhbB18=;
        b=TSJjJ+LM6cO7PiSIRP9m/9jrVZ6cRAqc0DaRJ+g5gEg4Qw0ObNd7A3tBcklZsylQHl
         Ilmg3Y7iG7sl/BR/GeIwkLzEL6JhPEcwo03TOz/D1HUvM2KfFgyYDKpFTqyPJ7dn1692
         NhpBXTh9i/Xj7vgji7EBqot1bXMRU3KFeEBy0FA+D+Z1aUUzsPSkL+zlTKmE9IGpARW+
         w8wpXb6yvtawk4HwImvVfEUwKKyvWNvMOmMdODsccUjcbwZzxQI3AyFIrGkKLXzu3+rI
         TKz2DPtbBFj9oOBIeNLb03qE8ifbZ4sTkQ44kCYPAKDPcJNLb8GTtCIyAtlnFirvdy5q
         /bJQ==
X-Gm-Message-State: AO0yUKU+ss8jZd9tYkeTfbHZ+IZiA1bQOA4L2l2Qbjm8RiyqB9f9hJYI
	oYGOzQOYYWo5otshFHOy5to=
X-Google-Smtp-Source: AK7set8VZaILH2bk3i6nwIWvwNyZJTV88vCPQdL9oTTKpcarkwCOZnrhnvvxNjSdV20Wr4hbcyHqqA==
X-Received: by 2002:a17:906:51d1:b0:92f:39d9:1e50 with SMTP id v17-20020a17090651d100b0092f39d91e50mr2133032ejk.3.1679397252751;
        Tue, 21 Mar 2023 04:14:12 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id mj4-20020a170906af8400b008ca8b62cda6sm5776420ejb.177.2023.03.21.04.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:14:12 -0700 (PDT)
Message-ID: <0be807ea-8d44-f124-bffd-8abfcf046492@grimberg.me>
Date: Tue, 21 Mar 2023 13:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
 <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
 <20230321110645.ruxzlw5egzikagnw@carbon>
 <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
In-Reply-To: <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_041424_722309_DD4DD015 
X-CRM114-Status: UNSURE (   7.79  )
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


>>> That is not a crash, but a WARN stack dump.
>>
>> Not sure how you get to this conclusion.

bool blk_rq_is_poll(struct request *rq)
{
         if (!rq->mq_hctx)
                 return false;
         if (rq->mq_hctx->type != HCTX_TYPE_POLL)
                 return false;
         if (WARN_ON_ONCE(!rq->bio)) // this is the stack dump
                 return false;
         return true;
}

