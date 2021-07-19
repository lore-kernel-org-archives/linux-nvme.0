Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD9DC636C9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:22:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4C26115B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4C26115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=OgT7mTljr0VIauIU5F3kr4M1fS
	w343gDCC7y296ohX6JtezX97Xor7HQatgMRWaRrgwqedSFtzNFeLY1PnFRpAPBAW3nrt05kWHTtT0
	1e8deAKOrIu6z/zavtQKoG8e07x6JTKcY2no8uQolaVe8NY6rKGig7rQXgTHmG5FfhmlgRVnCSc+k
	+jl3PXzdwhHW+Xmr6d2eNf4ePuU+n9+aRwND4wTHduonC8r8OMKHtICPAGnPdX0AI5VLWeBO1e9+X
	JFORkgvBCJe4sByJSTlSt3u7a/7A0plDuuCdCz7/TGSgjEAm2cr4BK7mrIvV01qVa0qiHfNji437e
	h6H8oJ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5PSz-0093sV-RP; Mon, 19 Jul 2021 09:21:37 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5PSr-0093pP-Mg
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:21:31 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 v18-20020a17090ac912b0290173b9578f1cso11107176pjt.0
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 02:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=N+M729QszgOWpT7/ltncUTegnw/ArSVBwe8iNm9lyPj24vBLJ2UCS8sImVtvSMMMqu
 wn1ivqdoMS3vKAkOdMvgGVvCUxmoY9TRgJ+xtm5mYd8bqKdqpshgLJ4LO+ewLDIOednE
 at8q1HIEMQmH3/poTC1t3xl9UeFafYelpxdpunjEOQizuv3CJjD9KaF1yOkfGrR36nKX
 j9+NHbwSEom0bgmEGlelnoz5Rveq/k/bA+A3l67nfUVucIMVBge/148XkvQikisG1UT+
 mqNAo91MLMapQB+MMG0bIBrmhX0KOLkPtswWHq1sV2tmV6qlVu85CJFzJg/SMqOGp+0O
 KbeA==
X-Gm-Message-State: AOAM531TkUt/4ppZD6wxZETDC8Vk4hg58c9Aq4xZbtqNpOecoxRgWX7B
 Nc0yx9YS6Yo3SZ9yKwjsQq0=
X-Google-Smtp-Source: ABdhPJzRipXFPTOD0+JVvSxPxrq+277fDIiQ0W18t5/nck3nY+AO6FxOTKOj9WuRvL/yJlhkx21wRA==
X-Received: by 2002:a17:90a:6686:: with SMTP id
 m6mr23476110pjj.109.1626686488611; 
 Mon, 19 Jul 2021 02:21:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2ce3:950:ff23:e549?
 ([2601:647:4802:9070:2ce3:950:ff23:e549])
 by smtp.gmail.com with ESMTPSA id i8sm4195038pgj.78.2021.07.19.02.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 02:21:28 -0700 (PDT)
Subject: Re: [PATCH 08/11] nvmet: Parse fabrics commands on all queues
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-9-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e70e6c61-05b9-5918-b8d9-09169253968b@grimberg.me>
Date: Mon, 19 Jul 2021 02:21:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-9-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_022129_792421_799CB87A 
X-CRM114-Status: UNSURE (   9.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
