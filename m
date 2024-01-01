Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD6AC47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8j3HRQVHzAfRTXdDuCw+GKYY+cvWW6h7LEWiljf8aQ=; b=la+waYJ90BjqHL2VFfJlqpcrJI
	ZZHvqcW0CDgjCOOOCUpRXAohWAwu5SXxgPKc/Ho08EaGDiqID80AGmiGkr93N8gGWQCfyJuAtEufo
	Wu0ZQRT5iyDjfQ1mF6zTq0XH6EQckeSvHsl+6ulhTcJ0fnep/WWrQosYKWS9QoUiXatEI81s393Wk
	NSnp5djh0GF8eiD8tKKepJe4PA9sfvPX2IAIHvHZAC2C8d3QAi1JqhTZSwnqzlKsWfUMER7YGyZyl
	EhIEEGaU192FC4xDrrfQsC5LwA6gUqmCWcNycQApRJU7BcgkpGcCDFLVQj4c+AVFx7Y63HDGFrAbm
	3CaD1grQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEXv-005otx-0n;
	Mon, 01 Jan 2024 09:25:19 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEXs-005osp-2P
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:25:17 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d8902da3cso725755e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101115; x=1704705915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8j3HRQVHzAfRTXdDuCw+GKYY+cvWW6h7LEWiljf8aQ=;
        b=txMJf0zRDA8TOkd+0Gf+R+XbiRoOEEc8QxQ9qOpLHW1oRSiUeaAdZcnroun1flMRSb
         mR+e3VrW15PXHS9QEY4NAkW7BDHSX22MI+UuqMW3d16Jil/qUiX5mpEj0qJYNvW+Y+av
         FTAvE859BLjNmj58giR2xZfavO1vIdbBAqRnLazBrWuWm3iy23Y0B9xoVbkY9JD2THTt
         HHSu/jRT9ArP14RSMtksANYrdsMNMPO5r/rRN6HqpN7ID+0n+L/bqD3CTtzSHiCyAgL9
         zGHEtI+oNzrUI3CvM4w8mkNxnzdLNQNlqmAm4ua8M0g28LUvPjvJ76cHnYJjeDQuCim4
         7vaA==
X-Gm-Message-State: AOJu0Yzr4rC6P1TWydV+NpfBx4stoBR9imjTcXfNH5J42vk2meavclnh
	pcyTtJFuKw7UM+/63KPPj1Y=
X-Google-Smtp-Source: AGHT+IF+MaNwnM1+YUVD9sEEEvLwlidRUT9V2LZ7jGDJbTMCKGGXJnDvz+3pLYbVigi6GgyD05A7Ug==
X-Received: by 2002:adf:ea83:0:b0:337:41c7:730b with SMTP id s3-20020adfea83000000b0033741c7730bmr561544wrm.6.1704101114521;
        Mon, 01 Jan 2024 01:25:14 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm25316648wrs.62.2024.01.01.01.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:25:14 -0800 (PST)
Message-ID: <e638a73c-9808-4e3c-a280-cb6fdc1d9f4e@grimberg.me>
Date: Mon, 1 Jan 2024 11:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] nvme: remove unused definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-2-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012516_789849_7C885486 
X-CRM114-Status: UNSURE (   5.15  )
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

Can you separate this unrelated patch out of the patchset?

