Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1293BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wH6QzGEGZ2ruzuhVM8wqXrNXUE
	cgsHNzemRZyhj6cr8HgzackDHv89GbVNZXBns9NttW8GokryOosXZC1Yh8n070VGa9wXfNXc8ggp2
	ityS0ivyUVdIvj/0lDM4/tZwF9wqhK8hUovXFoRKrQPTyjUnOeOOoUDkRnH4gtBuxMcuAHMTyXh1K
	HMxBFpw/1dI+OyA/hctqBYMgGwXvhYBgWAbcrxbci7zxJRpqYwGo8kJFy7c6YwhP6yIq6DsYkMphq
	GIwi0FrQIA9zqdzY3YDGJ/Vl/OdprOvRn/Dp2tklfCFi+xMN5x1ylGKutNj/JvSEf5xU4pRPdiZkY
	YehRwU1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUPG1-00CBf8-Hz; Wed, 16 Mar 2022 08:43:49 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUPFy-00CBdo-P8
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 08:43:47 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 q7-20020a7bce87000000b00382255f4ca9so2792567wmj.2
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 01:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=0GYAu8z1jsSXaLgJ35M4zfL14FnDkbYjbDMWDBbHpV27HeRgwyBaawNAKtCWEVKzH2
 VQfOAgCgfLc4JF1YfI1vTaYBCCiNLMq3oCRiuO+NTu+xbu9xpa3cmeSqnc7YYowRTvUI
 cF/9DE4ZLsmZPZTqsEW9fIEPLjfygxorVQjC9YXRMYBt68NQFEE+SDqhnJbm8/RW2rKD
 2nn7ZdOsVAykA8daOeOpOv8uVKd/1kC6pNuSbwH9sdDep2QJJoXcHJQb3QDxjN4Y+230
 /WNz5kx9BXwMpb7CEw2HUhTdHz+dFopB1sXMuLA1OxNFR98LRXGU3z4xM0gTn5gDDnEg
 EvIQ==
X-Gm-Message-State: AOAM533vouMv7FPx81K0OUGTsVV/ADCuNqufQE6Oc9poQoAnaHPj+Xml
 aBP+NYaw1aGanxlVTPcZd8gDwO1Pmqo=
X-Google-Smtp-Source: ABdhPJzpXYj1WPAlSvCiO1w1aCpiQ95Lp+uW/xoxEMylwKCgK1/PuInKoyzT826ykbMSvC7KdN1f5Q==
X-Received: by 2002:a05:600c:190c:b0:389:8f94:fcac with SMTP id
 j12-20020a05600c190c00b003898f94fcacmr6423710wmq.27.1647420224754; 
 Wed, 16 Mar 2022 01:43:44 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 g2-20020a5d46c2000000b001f079ba0158sm1065770wrs.60.2022.03.16.01.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 01:43:44 -0700 (PDT)
Message-ID: <1b5c60eb-40da-b6d2-2f0e-855ce9562b67@grimberg.me>
Date: Wed, 16 Mar 2022 10:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: cleanup how disk->disk_name is assigned
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20220315145125.2586068-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315145125.2586068-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_014346_838696_74F10246 
X-CRM114-Status: UNSURE (   6.35  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

