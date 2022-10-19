Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009FEC43217
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=L/V3nCVu8Y+3kh/fcdYEoaO1Eb
	1tvzlKIWKaTISd6P6ANRg7LfNLmbfSP1Oc64VLrsPwdkzWhDBZm1LUh414wvT4ATVyU3LYhw7JxM9
	a1oZQxm5q/miwNZUwQm6OMUyJRFBEwmDDV1AKQgC9QH4jzHNQ8I/6pRoxW+/5ODVQMtlfiAQ4NDH1
	N9/ycWnIpcWkP4IAZKJCkGZOZ8R2arqvR3rIKhJzhWEU61rHa2iEZP//Fwtcck4G2VXAq27uS4Z2L
	Y+NRGQGERjSJLAjkikQgJ5hyHwAjSQzF19wg9MWhjfzFrrKW6dp4q269hS8TWqrGIDsOciYxJj96x
	iqRNT63g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4IQ-00GTze-Rh; Wed, 19 Oct 2022 08:19:26 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4IL-00GTwL-Q1
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:19:23 +0000
Received: by mail-wr1-f47.google.com with SMTP id bk15so27772971wrb.13
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FtnkEgbOIQuX6BLYymn53PISJrvd51goj1BOxIJk9ZuSlKWtQA7NXBA09a6A/bPFya
         x2xel8U77FENJYMrSQNSvvmhUXLKY6U2jwONWAc1dfBtqkHtXbJU739LXE0RHnr1k40f
         Bw83VQI4JqQuc4ISLnDjiI4LkBr/hn0ZG7noavBhvh95mhS7JlzAvAG2mg7BrXYASQ72
         ndih6dh44CNYiBdhiJcUkLJMpK6Hv+YwsenqQ2QPrEcrI0NNI76m8283rc4zrsydVmAm
         nLDtCpHfwVBZfOtDniQAZVMi8Op0fadAm41AisFHHWMEdB6vmZXwZS2ehwBSHYze5Kcp
         hvlA==
X-Gm-Message-State: ACrzQf1SuQ62Pa/+LFDKMSbZ4C/mbNqNeEP/3t2UMdZUT6PfCKJk5DWd
	28+htk4+pTSqTSuOmhTX17w=
X-Google-Smtp-Source: AMsMyM4phRfopiz5f0imFpQegXOUVZaDZySXbHjtKCWLqKaefCuITL0Nfnon8CM1wenadX1ryUnB6A==
X-Received: by 2002:a5d:584e:0:b0:22e:4276:c66b with SMTP id i14-20020a5d584e000000b0022e4276c66bmr4104280wrf.204.1666167560166;
        Wed, 19 Oct 2022 01:19:20 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4351000000b00231910fa71asm13212840wrr.57.2022.10.19.01.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:19:19 -0700 (PDT)
Message-ID: <56e35f32-e0d8-f4a3-f887-613c74b06664@grimberg.me>
Date: Wed, 19 Oct 2022 11:19:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] blk-mq: move the call to blk_put_queue out of
 blk_mq_destroy_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018135720.670094-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_011921_878248_6D44CAA3 
X-CRM114-Status: UNSURE (   7.84  )
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

