Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B677C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8NQwjInQeHX4PNBQH9WRkcIExVlhXjtH5bBsP3hUUow=; b=4q7IhXqrZLsT7eanrwfb6+ArfI
	7DtciLnJAUVrAxu1dXy0Io4dzfTAPcOffILycuQ4S6qrJtASrw6EicZ7OD5LNwXDiDKAnj1Urj9Wd
	O09M8gDflNLdV5P20tsoZ2ACPpf9VDCoRUIK9jOsKjrwEu2XZFBItk4rQOBixRThGGVAmzpvaysBI
	lEEERi0/3NASs1XEm1VpuisDiE6JS8vT+dad3QJQzRdhN3kJCRnx8By4aJrzRkofodAEblzKdsW7D
	zPxL5ex4gWjg41Viqgt/UnqsaelnFmqILKnET3zb1XRMyVV1OAwwTiPgAe/8U0iPluIx1bxKretsv
	8Dioxd6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWz2Y-00DRg6-N3; Wed, 23 Mar 2022 11:20:34 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWz22-00DRRr-1E; Wed, 23 Mar 2022 11:20:03 +0000
Received: by mail-ej1-f50.google.com with SMTP id p15so2139610ejc.7;
 Wed, 23 Mar 2022 04:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8NQwjInQeHX4PNBQH9WRkcIExVlhXjtH5bBsP3hUUow=;
 b=Hn+VBq2GxU5EG/wKCDOdybgyT2zPi1nq1IGKYj28ABGNPh2FySqGFWMox23XjkDxBt
 37Q/2sQQSsn8JC/+pG4V8EbNTg26UDsLJNR9KwiQWazNDA8Oq7iEZ1omlCcqRs8lXW7S
 zw/CawH5CptmrGDU044jmwmg5Y94fZR9FMjlA3GXRHPTS1Ft3ubh4LsjXCqhxN2yDf5A
 mD7Fy48IKsrGX4ipvPSY12HtHfcC014EvE2n1QJeGC94J//d6Sks/Ua5nmqrvRZruQDA
 N+ANFTN+nTv2OkZaS90tpgc6ayxYYDK4/3rzU7brwHHHosARh7O0s9Ii5pIsut4JnzXq
 MfCw==
X-Gm-Message-State: AOAM533mqpl+k3s5RiLLyE7N535Efjme9rhA5MakLs9fvIjFABuRLZoG
 p9YFm9AVUkXSz4OAp+YNRXY=
X-Google-Smtp-Source: ABdhPJyggNgkzWof95iHK2BBBMKkQTe1ofpITUi/c6gBiK4dbd3/biJiEJrfNyHqAUzhektMkOESWg==
X-Received: by 2002:a17:907:16ac:b0:6e0:1646:9121 with SMTP id
 hc44-20020a17090716ac00b006e016469121mr14215917ejc.194.1648034400203; 
 Wed, 23 Mar 2022 04:20:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.googlemail.com with ESMTPSA id
 q15-20020a1709060e4f00b006cdf4535cf2sm9582171eji.67.2022.03.23.04.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 04:19:59 -0700 (PDT)
Message-ID: <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
Date: Wed, 23 Mar 2022 12:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321165049.35985-6-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_042002_171138_7F1B3B15 
X-CRM114-Status: GOOD (  13.39  )
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

On 21/03/2022 17:50, Sven Peter wrote:
> Apple SoCs such as the M1 come with multiple embedded co-processors
> running proprietary firmware. Communication with those is established
> over a simple mailbox using the RTKit IPC protocol.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/soc/apple/Kconfig          |  13 +
>  drivers/soc/apple/Makefile         |   3 +
>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>  drivers/soc/apple/rtkit-internal.h |  76 +++
>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>  6 files changed, 1284 insertions(+)

Isn't this some implementation of a mailbox? If so, it should be in
drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
Linux is organized. To drivers/soc usually we put drivers which do not
fit regular subsystems.

Best regards,
Krzysztof

