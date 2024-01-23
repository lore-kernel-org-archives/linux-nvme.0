Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D100C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=itvk7vusTBGhoS3cJeywBxLQ0V
	8pATtPxlk/YLhngUg4zsl/YM/nLAbMUfYUm+y3PgGILS+hzEz/jNA96zNitjBaQwvFoIPnQQEwkWR
	a52j17+QtWNMdCi3C2p2FuFgobgH4MeYBb9XYwZbT3dZRa4WsroUvmjQpmkLXZJAQj1gaFACzaDh1
	eHCIhCM3oUhOLRTfu+PqXcaQ1nOdWpydPEBUHZokZk8GgkyjDu2USTdjetpHsSu0iJ8GwHz6aqYW7
	PQkBW/YjlC72IHyAnSNpi4PkN7JqsRQ/tSurLEuK+0ziD3DJU0c00j1SojWlhYOMGixZ6M9g1oMOs
	5KitIPhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEuB-00G8ZK-22;
	Tue, 23 Jan 2024 11:25:23 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEu8-00G8Xg-2z
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 11:25:22 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eb24d3ccbso1024649e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jan 2024 03:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009116; x=1706613916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PU43VSwyuY/TH3+zDY4B8F4VyNQAczKvcFBbYiocRVWFvVgNpg2yynI9Qd7/YzzQDu
         bKKnoXhMowzQhKiu7PXP3sOR314HIlRGUtdgoJvtfTq59DljjBuecKSuv2eOZ95XnAFX
         MX2ICrSj6DubxiMLX7cDQG3zcyuFP06/5U2jWLQGEwVN+lOO2diXTA9BSEvf9tAHHN7m
         HV9qs72Yzcmkv4Wyz6+K15Xu2g3wu2MlZ2iszCT/q2ecPtq36RrnjzVzFaZlUMIBYo3Z
         hUDHvzIuGlndGbUPsiXVYyDSiOWDxydrviRqOBfOhEvTCS7xMb0TVrn5rTo8NAcezXzG
         wxyg==
X-Gm-Message-State: AOJu0YykCszxwQkobBgzQzZhMXceRoH2kP++LEeAIpcaYjfNZeiEtg+r
	2r5iyhvvwZ18zIn04rBQSX8RBFJTtUTWrNKHq3zwLbodoldYT7jL
X-Google-Smtp-Source: AGHT+IGwxdQzfIQmze10iCdid0qNAfhIYPfflcBG56VXg8+lfHY7KvQDXvXPaPF2xr+55YK6Vt8U+g==
X-Received: by 2002:a19:ca45:0:b0:50e:84f9:22dc with SMTP id h5-20020a19ca45000000b0050e84f922dcmr4953153lfj.2.1706009116197;
        Tue, 23 Jan 2024 03:25:16 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v24-20020a1709067d9800b00a2a4efe7d3dsm14343849ejo.79.2024.01.23.03.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:25:15 -0800 (PST)
Message-ID: <058ed6f2-5228-445c-85b9-21e0b16c7703@grimberg.me>
Date: Tue, 23 Jan 2024 13:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvmecli] fabrics: Add disallow_pi param to connect cmd
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, dwagner@suse.de
Cc: oren@nvidia.com, israelr@nvidia.com, oevron@nvidia.com
References: <20240122153341.20757-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240122153341.20757-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_032520_961429_8DD9C995 
X-CRM114-Status: UNSURE (   5.19  )
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

