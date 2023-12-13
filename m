Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2669C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=z6sDMwpR+kgbMPUOnZsVG8TInc
	39eL4AokBxc1Zc3ltnz3k+bH8CU1mTaL3XLM+/MX8Icjs07ZVawqiSHBDbxcV3jRE8K5KuhujGys8
	4L2Y7yERPLyOIE0c9Aai38HqHaEvKHXpZfzZEQHruhTF82hFnDZjcC3VfL8I+9z75aWlTMsPRr0V/
	xc1nH0JLSekq+AJ30prSEKKiInuUsWGq9ss7SA/3Yodh2bCG1wmXPc1SXygLiaCq0wiggA9vTm145
	Nyst0tysly/bKQqkOS3js8afJ5DqdfGx1ecnm1sWqS/0uUIBOQxhw2kS63pTjsYilmzZ+sDRgJIhv
	GxLaOYOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPZh-00ErpA-0B;
	Wed, 13 Dec 2023 13:46:57 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPZe-00EroH-2W
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:46:55 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1e25a49603so182649066b.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475212; x=1703080012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DFdFbhQwLMLLSooTlRzeUt5X3sKHCfPbmnXtciVAJ44dCKk1hJ8MqqJfekIbMyBzc7
         a+o5q4k7y1zU7U5KEV2/j6GsV0RskcYR6Ncy9yTPVnPcnjk6QCWsrbu/fBImThE/GSyk
         hoDDp/bPCMM6ULkuBiADvNm1PJCgmHT0C1Rhx1dCtj/V32umhUFlrbK7UFhArHdON5dW
         SAx6oi6OD1lPca5j6/YjoT3ZYx1kGf0mGmMPhDU/bJdhB7d7pyfTiErtyd3MNaeyLDtW
         VNNKHi3hjaK2SdPOJZRthh/DEVF5ULkRj4RWaxMtSqYw6koKy8LdC71hQFShesr4Ppyv
         rk5Q==
X-Gm-Message-State: AOJu0YxIBjWyb8ZrGPPSpqs2io+858EJ82aGrDGRdO1DysfYtvRYysJh
	HOr1xgjRoXw0iLwsz089wDyfv5Ag/1M=
X-Google-Smtp-Source: AGHT+IE/aQ0mdYoZRRZ28GfvqN5X6UO8yh7YCbk0LfNTS/DMZc9LTJ9AGgrgcHesalSGDQLMyd98MA==
X-Received: by 2002:a17:907:a70f:b0:a00:211c:9a9a with SMTP id vw15-20020a170907a70f00b00a00211c9a9amr8780863ejc.5.1702475211966;
        Wed, 13 Dec 2023 05:46:51 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a1b7769f834sm7702467ejc.81.2023.12.13.05.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:46:51 -0800 (PST)
Message-ID: <ae23b344-fc37-4b16-8965-ccea3a856ce9@grimberg.me>
Date: Wed, 13 Dec 2023 15:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvmet: allow identical cntlid_min and cntlid_max
 settings
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-3-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1702449172-8920-3-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_054654_818063_468085A6 
X-CRM114-Status: UNSURE (   3.90  )
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

