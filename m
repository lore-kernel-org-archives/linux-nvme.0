Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B83C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m/TtwC1jkgEbpZFWpc27pXBnfLeMwQvolPGguPuey9I=; b=ZV7/heSLh5IPIHDcJp2aUVqXYx
	RoZ0pJNpRvdnH31jqeJVkVtjbKz+ltEid7aPgWgXfMGPOcQJQgR4QbWwyvZIDkwkF0ZUk9SS9he3Y
	NUqjwQeHcimYaRGIyRj8tuTsg880TQJ9xEmd58Ag0X6Nmv9doNJzX2GCsszkwYwMK31IjcsIr0eVJ
	XAT6YB2QRKisD+Si6Z6xeD9ygKvNwJxU4zNe5OuNF/PYK3Q0R2h3F/pH/upvorX9ttDRQ4ZljyRfQ
	068ujLv5L7h1YXE1OipDubu8r3V1kY/F8kwQjMUwjvXhTDTUbdiV1x6pDk6caUsNyc7ocB5iV1PMB
	4b6YH5SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAEH-00000003tid-3GC4;
	Thu, 07 Mar 2024 09:39:57 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAEF-00000003thJ-28wn
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:39:56 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33db19538d0so160756f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804394; x=1710409194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/TtwC1jkgEbpZFWpc27pXBnfLeMwQvolPGguPuey9I=;
        b=dZgjKGAswTrzCdAg2TLukKlA0bVfMPIdeo42g8/+GcrpVskc/TejVYZMFgw249YamK
         PjTMQFVb+gkqDeCyk9v2SuPwnojD99TMdpWF5hQfcagGtBLIKt96bmXewyBBBeeOUOno
         BuX5f0x3Ykqw0pDIE2EfLA+eaNSaDtSXrdNHkdceh05rdRrhB1Kqtl0UgMq0Ng60dE5M
         XKIAHsAYLznM8CM/72Akyw3j4OP5quIy1iEQ4GKD2Gh5xy7DFBIFKub0CbNbKb0V8XCa
         hEADqepJd5GTOQVPMlz2vzyNu0zPh2PuAyHV460BCUm/eGbGkb0SF9E6q9rE3P2gFu3o
         ud1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrv8PlREmN5phCpSU0b/OINb4Y1qt+S5raA/kJOJUsYLx0VrY/Gc/hHUWsl7eOgOLKtYhlNNSIP0XtNnSpkQu9inWIW2n4RHFcHhgthGE=
X-Gm-Message-State: AOJu0Yzf9J+4rranXweTPgkNO5j7fT0c406bBTrdD008WoJkp7/choPX
	BbVs1Wv2sU4acgxipwRzu+zhQQq+hc6+uDo+y6cPVamUmfiJuDcmiOu2izpc
X-Google-Smtp-Source: AGHT+IER4+2N2vIiWxncT6aSYb30LtvoqY5ix/bEvssbdh1t62EDAg3cPPHZZ+92DWYSAhp8U3fmgQ==
X-Received: by 2002:a5d:4ed2:0:b0:33e:1eea:33b1 with SMTP id s18-20020a5d4ed2000000b0033e1eea33b1mr1063275wrv.4.1709804393594;
        Thu, 07 Mar 2024 01:39:53 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id e18-20020adfef12000000b0033cf5094fcesm19742637wro.36.2024.03.07.01.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:39:53 -0800 (PST)
Message-ID: <08a5678b-c174-4db0-8050-2a797c94909f@grimberg.me>
Date: Thu, 7 Mar 2024 11:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move nvme_dsm_range size check to
 _nvme_check_size()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org
References: <20240223032947.55086-1-kanie@linux.alibaba.com>
 <c8f19c2c-82fe-4cc3-b408-bf8040222fba@linux.alibaba.com>
 <20240227152143.GA14722@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240227152143.GA14722@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_013955_581483_E7DA2244 
X-CRM114-Status: UNSURE (   7.96  )
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



On 27/02/2024 17:21, Christoph Hellwig wrote:
> This is not a check for a spec provided struct size, so it should
> not be grouped with them.
>
Agreed.

