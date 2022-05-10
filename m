Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA3BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 19:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJJj32LbZr/iRmJOT1pxjVpE6aBa0cTeSoz0VXB6LRU=; b=0VZ1+tDIWURHObFw1o2xYeawLC
	cglOXlJSeclRIAI9IzHn4TzV3er0N8vnO7BdbJ5/PXBrc2KSSCzNHOJUPac0kC4yDwBuJEy2fuHIe
	UXQE3SO0JXJWuezzFMV7Wt3GFH36p4y6WOfIJsA8sxVTCgHmRjnGrxgc63p7t0QAyiwLIDg0ro9sH
	xfQ5ohxSaaalB5Ea6gRIv7TrhHxDjFhHoZRcbO1+GVgCofrlyHt7bjv4zh5qcjOXD2TdsbDkC7KY0
	bg6V5xfMnz/VkdXvSrVzOdkYzvOY4Tw/lcKLVW5yEQBtTdUkIwRPNSLZKOBvCe2xUEiOqKaE7tOzB
	IgnRl8LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noVIu-003lXz-9f; Tue, 10 May 2022 19:13:52 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noVIo-003lVm-2x
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 19:13:47 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 l7-20020a17090aaa8700b001dd1a5b9965so2980799pjq.2
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 12:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SJJj32LbZr/iRmJOT1pxjVpE6aBa0cTeSoz0VXB6LRU=;
 b=KAaryfONofm1YQ2hEkgQnCIpGp//0snSVWk3Tu4THXO0DHydwijhaUALoTtqg79ayI
 dvMZrktZL93KzWNtlwXTWV6mrrTnbVD8loDw+TJzQT9hKJEYO2w/mup26r/Eml8V8Ybu
 jpu5McE75z2j94AbM2FIUK/a9qBb0mSbcIEO4N2Eb3AzuAkUftl3m8EKEvbUcP6GTXYR
 GH653OWOH2Dyo+JgqROpqXFMWbzhflST3pRyodlzld4CrXeAXkM7AFhIdhIq2/RwIA0T
 ZpdcwtVHfWM3BxGBJEbpmZmkIrlEKJ9Qu9EqAsfYx1k1ngZDlW3LRCTb0tkhbCUjPo/o
 YXDw==
X-Gm-Message-State: AOAM533YbwkxIDh7UD4HmhBdsvS0S/lEXPExiHfCQUGX61Kx+IqFs2wC
 fkjgJT12d6wWFEK7SCquk+STRGKG/GZUdg==
X-Google-Smtp-Source: ABdhPJzfrYFWUJJi3Ewq96gghXQU0UW2SNxYfN52FgersJZjL++0Vt9yZ5u8ly3U0pyusC6vOy9Sfw==
X-Received: by 2002:a17:903:11c7:b0:151:7290:ccc with SMTP id
 q7-20020a17090311c700b0015172900cccmr22274888plh.95.1652210023706; 
 Tue, 10 May 2022 12:13:43 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a17090a714400b001dc1950ead5sm2192693pjs.38.2022.05.10.12.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 12:13:43 -0700 (PDT)
Message-ID: <3c233d71-af16-d230-c207-b9c2ae38afbb@grimberg.me>
Date: Tue, 10 May 2022 12:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] nvme: enable smart AEN
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org, hch@lst.de
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_121346_170034_7B26C7E5 
X-CRM114-Status: UNSURE (   9.83  )
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


> Hi,
> 
> There are several changes in this series:
> - Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
> - Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
> - Enable smart AEN.

Is there another side to this patchset? meaning some userland agent
that listens to these events and does something with these?

