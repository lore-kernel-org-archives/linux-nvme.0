Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B394C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9DD60FF2
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA9DD60FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=CUrHebdqznM6jW7Y6MUBazuUuS
	SzntRW3u2TPXGpOJ18qz+XOdpuP1vV8LBUunpSSDOdKCrKWJ+8+mLmVoqXiFt2RKhIZvJJnCqc8lH
	paCXKs8rcgXHMPiVwDbAhguGQo5nP+Leo4et6N6lwtMmP5VOzOeqlLke5/PUp5Qww70ZOkwp3QOBi
	LSfpTem+gliomDS12cIWKYk4RQpMK724PQL6q8n/Sn1/GfzuEBmQee0PWARVR+tGuNnTiuU9ZoFds
	erBoiXwlgaVnSBTZhtYDIKJpVk2pgso1//+SbA/6OJH5zTkQPKdVroL2n473+4K6qMj1+xHr5M85j
	EYYn4iIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPmRt-001vz7-O1; Mon, 13 Sep 2021 13:56:41 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPmRr-001vyI-Nw
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 13:56:40 +0000
Received: by mail-wr1-f51.google.com with SMTP id b6so14834718wrh.10
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 06:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=A1EjTQLiCTJYQidJRbuAlZoIJbdfeV0wn1UIEp/+N9H3paWVfm13tFmMBzRTaingbg
 DldoZFcyCNEpjyq0Q2C2VDnkztzU6965eivizXC2rkqlE7yFOrr443zpKvJhkFo89Tml
 XgBQcxMPv9j3OIa7QIoH+Vvwt0TEJsyXalfQoNJIVrPmlkO66s3wXGycdwwRxW60zdFL
 8Y+v6yClN8O0OICtDkgb25O7/zwoT3fTixwLfBwERY0MwOAONb/yiPgvsV1M+LIxWmj6
 S2n6049MQxRJaOf49F1z/45jtLoL06xoHXcQPXavXjMo/V4a7AD/SrFTBKcdcIO+guEP
 VkPg==
X-Gm-Message-State: AOAM531pVfv2s35PWepa0myqL7Fj8otr3EP3uSRK6og/E5HRIf9JePT3
 XAx/O2SrigtKm+7KhY879R8=
X-Google-Smtp-Source: ABdhPJwGAeUwYWWh8DuyIIS+KhDQ6obsRHVANfkl7HEXKftFOHbkntJbkL4c5r1WdwaH7OZ4HcxAYw==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr12461437wrn.365.1631541398005; 
 Mon, 13 Sep 2021 06:56:38 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id z13sm8651351wrs.90.2021.09.13.06.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 06:56:37 -0700 (PDT)
Subject: Re: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-10-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <af9e417f-fb76-87dd-506a-39dcf9897b3b@grimberg.me>
Date: Mon, 13 Sep 2021 16:56:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-10-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_065639_821441_A1D6D25D 
X-CRM114-Status: UNSURE (   9.17  )
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
