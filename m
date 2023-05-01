Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF60C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SJTq4WO4o8dPxJP+alr94DELl1
	GgZEB5YvgogK8dgFOrEvWH54IE6P23AphyzYGW7pob2MeAbgkxFDZobNAUH2K2H/NUZzuVxUB5E4N
	LnIl+MjoRhkBYx17E28Hinz8Uy6HcL1rLCHvOiYpH3NJzEV7GfoyeSqEDAePSqLSF+eCI6hwv+9vR
	/iV90oRnPQbFkjYhuUNjf+XTzSxNIOLM5GbxiPnXGmpyWw49S9nzJ3mlvxKkK5WM4V0qRXqz/yISz
	JJur7Cu/BnqvqeS8wi4waEDr5+Mjej1V1BhpjADB/k+QXmwqb8SK3jeLSK6FQT61JYM1HH3K5vluH
	tACXHBfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptU3B-00G6Rh-2t;
	Mon, 01 May 2023 13:58:45 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptU38-00G6R9-2N
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 13:58:43 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso3840005e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 06:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949520; x=1685541520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=S0jJfH4eLVZXg3VZ2GSFHscUYyNsUITi5rkSJNknxgVYpIxcXS5oD3lTrbHHEfX05u
         UnegGHsD+N22UIqHM/N2NF7YpYge9tn9dnguqnz5TSgPlb8dnUoU/HvVjVkeXs9rBhBa
         0HSvT4EK9h9THeA/IcujqZugHtIRa5x3h1ZqfDdeXsonQGGkVNey7TKR0HAXVyQ4fT53
         3HuVO1welzeRuuKP2ajAIR6c636ner2aTCKLoOBlXTbjVJck2SdiafjVIHUecdqONhXe
         twl0kuJcGf9du5C5kyGsxhVINU7qy6ayC5zsXjEwRp9BTwkpvMrT8KMKrmu96PYLOWx+
         Rtdg==
X-Gm-Message-State: AC+VfDwQIoKcvEnTKyg0RNBzFm9y55xGUpYGlMCei+5+cYoB8a+OowMH
	tGgcQ6HsCb3ujARKFCUJhJIFcQJvDjc=
X-Google-Smtp-Source: ACHHUZ5fmsGRmunTeUxurbFpwCadLNtuqYQAughrYQ2hG1yAOPYRFXmf0DIBqc2nXwyFjfO8/Ir9zg==
X-Received: by 2002:a05:600c:3d95:b0:3f2:571a:9bce with SMTP id bi21-20020a05600c3d9500b003f2571a9bcemr8430563wmb.4.1682949519978;
        Mon, 01 May 2023 06:58:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f1736fdfedsm32605561wmf.10.2023.05.01.06.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:58:39 -0700 (PDT)
Message-ID: <4e66d227-ca14-667f-faa5-b471886caa1b@grimberg.me>
Date: Mon, 1 May 2023 16:58:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_065842_774601_85419B2D 
X-CRM114-Status: UNSURE (   6.53  )
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

