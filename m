Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED642C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dSSSazSY6MlNREwZLnRMD5Ut3x
	GzHatk+UhylzsRumY12rBl/W1XAddf2x7hEzSX+ZeaexoqI/irWOM6tr5ewuZPoLI1bwLuLyqnIY3
	CUgsMeqVbSH1Q6k4Goi4glQ2LRgKsTPgvPfifbjhyCb4PuVVYM9+ysScahvVRJDh6TEyP755CKChJ
	U557f3filWaXpFjxLeH8d73zhBXcBFwIBDGPQla27KyseIkW5G/l/KxybDmHN+Q91qRBhQoDQSkP+
	rT64vFogJFW9WdpkKnkWi+h2ldevpwrTy9NY2/sm6gvFIS9zpXoCXHUEuQQ3OadmtZMXd9oyGCyRo
	XS7+HMww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgkK-00FPjD-1N;
	Tue, 19 Dec 2023 20:31:20 +0000
Received: from mail-lf1-f48.google.com ([209.85.167.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgkH-00FPhE-2C
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 20:31:19 +0000
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e25e5a4easo1130535e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 12:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017876; x=1703622676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OUxvzi0CmDCFukm7YAtoZ3Of/L2SJFvFP2nGymKCmHlVuBOc8WdxVie/cbF/O+eRHu
         87YjTBYdetgFF9vjL35CtpjgsS5S9snkMZihGmczvQZgoZCGEWZHiybYf6xC32TESwgF
         gG8a2/k4mVbPuT7zFEc8C6SDu8Ls92DSabiQ4nIcWtMMMXmNuvyyhGPBD/KFHP4dfodJ
         9qKjKyrNtuXkJLalv1YPWcHk5rvXySQjnZR9UQzMx/jMckbxdL4wX6LPmiY0kttC7FSa
         HANLOPS+d5R+HB9hGY0TY6ONFTi4zW2HLXtEL9hv1Y0+Bh/hoI4eMEkHnmzpdJ60jf6a
         edeA==
X-Gm-Message-State: AOJu0YxjfCrCt1+zS/SZxDIbP8nhLulnyIWjXMXQXKlOuKQPsoDsN3+Z
	DTCBXcTIMqomVhJHlU1bsxCskIlMMOA=
X-Google-Smtp-Source: AGHT+IGiq9EsSTa3nuYt4nm9N1Nu4Ul4UDrmP9dFsHKABPHbFB3zWoPe2pYuZExTIbqxLgdTnlS6vg==
X-Received: by 2002:ac2:5ec4:0:b0:50e:337b:f316 with SMTP id d4-20020ac25ec4000000b0050e337bf316mr4893942lfq.1.1703017875430;
        Tue, 19 Dec 2023 12:31:15 -0800 (PST)
Received: from [10.100.102.67] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600004c400b0033621fe3a29sm23809510wri.26.2023.12.19.12.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 12:31:14 -0800 (PST)
Message-ID: <2aa68966-8374-49ee-9a16-3a8b68672788@grimberg.me>
Date: Tue, 19 Dec 2023 22:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fc: set numa_node after nvme_init_ctrl
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 james.smart@broadcom.com
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20231219174934.20400-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231219174934.20400-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_123117_717197_29DC0D88 
X-CRM114-Status: UNSURE (   4.96  )
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

