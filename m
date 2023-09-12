Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F9DCA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=P0Rtz8z5bhi+YYEOxhdpMFVLaE
	FCT2jNKL0Vc9NXPrPF7ZtO3W0GEkD0Ac0ApxHkae5nhjDe2n53YsT2ljnBUFHxjtAERiKM9H/ak84
	FiYawDl5jAx5HAYx6PpG5Gs6qyt47Qh02qOKOdo7WeKdBz3BcRjLD1Mx1SsKO+u/02HMlY1U/pb0y
	WAj5xWBfVE10T18wT4oI79kvub8I2Ks9aqPkVF6lekRTcpSOdgRNSR/6dzUxBu7TtmlnrMu7d0Vov
	7SE08affZgSLO86EIA+tHjS3NJ6i4XRT9hHuHbbqk0err+I5OhsY0Qf8c81F73n4PdJvpDarAb2WS
	EB8fFaMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg33R-003Nqc-0O;
	Tue, 12 Sep 2023 13:03:45 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg33O-003Npn-1C
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 13:03:43 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9ad8bedb245so10755866b.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 06:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523819; x=1695128619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Kd6eTYg/KvEgISoL+1L0FwvBLpawnSMNZ2Yl3VVLfkTsVyhPbQuQsnvwYPag0J74oo
         WAynLoC3xl2RimfwPm8YYB9fI+ar2TlYukeeR400WPIB/ZgO8Cfpc548QNnPymqmbFOt
         Texp83TWX+k2MRF6AcnZkXI93fCx04NkAujJs0GbSjX58s+DxMKHUUYZUzDk/ro3McJ5
         6tzOhp2nkogppNurksD7X5CNxCiYpeTGDiyzdgiHXaDe2jSYLoQ6CmIz9vDksKL5MfFt
         zX6IRoUF5cIc7X5xZ71BfCHD42iE53T3odnKOtq/4MjR94KlvxkjNlJRxpzPvebXYBun
         Ra1w==
X-Gm-Message-State: AOJu0YwGr90yU5hIjFKoMZhuohdlYHOm8pMOCkTFnOFiOUMdpOgzWk5X
	cH6ki9iax8zFYGobW7+E9reef2Ke2AY=
X-Google-Smtp-Source: AGHT+IGAHzTDzK/tMJq90LOuVfR5GHCxu/1spozUT8ZgMIpkf8BqK70X/N8lG9oaj+jLQAzgpSYblg==
X-Received: by 2002:a17:906:18:b0:9a6:5018:9a28 with SMTP id 24-20020a170906001800b009a650189a28mr10013931eja.1.1694523818911;
        Tue, 12 Sep 2023 06:03:38 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709063e0e00b0098733a40bb7sm6775500eji.155.2023.09.12.06.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:03:37 -0700 (PDT)
Message-ID: <f53822f6-025d-5048-ac22-cd928e53c281@grimberg.me>
Date: Tue, 12 Sep 2023 16:03:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] nvme: host: changing data type for variable from bool
 to int.
Content-Language: en-US
To: soni.ankit@samsung.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, sathya.m@samsung.com,
 d.palani@samsung.com, prakash.bv@samsung.com, anshul@samsung.com
References: <CGME20230912092353epcas5p130b50fa2030574071c41461447fddd52@epcas5p1.samsung.com>
 <1694490911-32299-1-git-send-email-soni.ankit@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1694490911-32299-1-git-send-email-soni.ankit@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_060342_405764_29E45D0C 
X-CRM114-Status: UNSURE (   6.77  )
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

