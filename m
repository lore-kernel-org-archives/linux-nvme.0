Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C6DC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=YAenLq/21IRr6ZQajUm75kpg+y
	1ncnDDOP9Kn2Zx0vDp/Q98rIAau4y66zWVhfvjlKKTsRAG7k03bhGv+ML9lOnJjjQvtOH6hG3rGeZ
	SB47KJI2i1E6DsiWr8/Qw42ML5QYm5dY8xtsKQcCqm99VJ841N4hzRIqoIpLSn0NDjGwtSfm+7ovG
	SFcQ9vj+u+eYi9JM26WzT0NNsQcV9cMK1mF8IPAdI4+dQ1ArylEmnc2oLxgjcJoJXZmDX2T453gfD
	GE53i32YR5Wl/TgqoM8GsunLznh2IG8jKgB5okGXEk0yTpIVzvcQMqwUkq/yg3UYN2Ip2Z48P4nEs
	4bzHlBMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1k2K-00000005sw4-3UnY;
	Tue, 30 Apr 2024 09:44:32 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1k2H-00000005sus-2WRS
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 09:44:31 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34cb2bf85easo83556f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 30 Apr 2024 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714470266; x=1715075066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RJgMCdaJqtV2OkjwVdBL5MwsAVwDr5TuyLsp0fVL0Ir9OkWsX8jLqM3qpFCpGAQJRz
         cBrRnQnsdkHdMAwcnWNaI12zHRa83quVDJHlNFe3IT39U83iENMk54fqnI03/7bUmT4z
         dTepWg2g5xo/wne+zAZDSjRRdkA/vtT1PElGoQHNS3binF8bgdxRqGM8MdS6BkZBTLLs
         6ALYw42/wDbwfe45EcD6El00VPZ8YN9CBAM5m7FcRLuWNRlQdeKpv1ZpBu4zTJHWZYKv
         GLEWnMA3+DZnU+q/KG1gUc/aIVrJqnSWmHsnzOkSE1mvXSO2oZuOGoOSLW7QaRNtO2dk
         hXuA==
X-Gm-Message-State: AOJu0YzUd196HyqX+BbwFNcgXJhCu9Jx5mqFbpb1YNdVGMc6Ppa3pXeR
	dQEyRAU2SU983wqsjPkORPFwIb8K4PApOhICLOfRcTRG2R4OZmqs
X-Google-Smtp-Source: AGHT+IFS04wTgqa0IYe3y3a3f/GOKbZm4K9dD19fJ+08CDnEmgnJyLJz4JGTwurQc7btDIEUZLLW2Q==
X-Received: by 2002:a05:600c:1d26:b0:41a:c04a:8021 with SMTP id l38-20020a05600c1d2600b0041ac04a8021mr9216511wms.0.1714470265951;
        Tue, 30 Apr 2024 02:44:25 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id bh18-20020a05600c3d1200b0041bd920d41csm12130042wmb.1.2024.04.30.02.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:44:25 -0700 (PDT)
Message-ID: <4f95ac4c-4243-4de6-b397-adf4637d5aa4@grimberg.me>
Date: Tue, 30 Apr 2024 12:44:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240430021753.385089-1-brookxu.cn@gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240430021753.385089-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_024429_701614_DCC2C5AC 
X-CRM114-Status: UNSURE (   5.85  )
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

