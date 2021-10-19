Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70907C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AD561057
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31AD561057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jPk6+nwoPFFjXk287jvPLwP+mQ
	cPPHJxGnUtBUOZHm5ahO46m2UgJSgqdH4zlI6kAJiI9ab2JO0O1R7Endf1Md2Nk/mjErsziPwAYOE
	4ui5S40CMRnFY0J9G9hpmLPwXWKufViOhamr0tjRjcwDOmkg0+tn05yMvuQtQIAaY9KAQQsLwar5P
	fNZ5j1bsN6uTFpVGbWspll52fV8g+HII3SSyZDX8LsT8JV3W2Uyx3BE2s61N3sWz+bpmiwqDROg3Y
	qqIhHuRLvXFk1edy9pNILpkPGjzJwqF8Pgj6hPJiccxWpfOX+TtZsC0NPOrF4bgTLtZ5tjIq/+NsP
	cnzL+05Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoJj-001E3o-2P; Tue, 19 Oct 2021 12:34:07 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoIc-001DaD-Ij
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:33:03 +0000
Received: by mail-wr1-f50.google.com with SMTP id v17so47392177wrv.9
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ImpWZ7s9maP8/GZATjcbyA1o6UWukMEnLFKJsOFFvhGYKX0jmIyWFW4YpcDdgixdy3
 u9WbJvxkRgMeZwWNwv45SVRYm7+FhTSm85gj7NuxgR58fq5G9oKKboirnBslLMrlSbBM
 INRcNF0v73H0V8GMstnwlRXxGuRoab1YtgGu/JRSNZJflS6t/Ld+8+wEVM43HT1akvkD
 KSMWaNqK7v9iGzWUlOYFoNcQeKj8onlD1jp4C1o37W8J+TEFHFveNZsjQ9x1w9R4+O6p
 MfFQeGkUemofM3Vdosk3BRi8Bcy6dZ1UTigl/1Vp9FkupfAFl0MbQ6U8mmj7L85uhjRc
 j0Tg==
X-Gm-Message-State: AOAM530X4/ugtRQAi+l6za3x/+LichzxSIvNmKBIn4lmyuFmc1GmxUgi
 YYxwCY3BAXxPudiNvQ761pE=
X-Google-Smtp-Source: ABdhPJz6F6Rfcp6equRV37ttU9Di78QjnJFANOwCuw38aKpCNSmBDOwQOC1WmzSLv8hymYDE4z5iZw==
X-Received: by 2002:adf:9bc9:: with SMTP id e9mr43963030wrc.388.1634646776620; 
 Tue, 19 Oct 2021 05:32:56 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id 25sm2287143wmo.18.2021.10.19.05.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:32:56 -0700 (PDT)
Subject: Re: [PATCH 1/7] nvme: add connect_work attribute to nvme ctrl
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-2-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ab63d3c-6c64-5343-47f5-8691f690fcb9@grimberg.me>
Date: Tue, 19 Oct 2021 15:32:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_053258_702266_5ECF35E7 
X-CRM114-Status: UNSURE (   8.95  )
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

