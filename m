Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFC1CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOXKxk2eJuTEUva29o5n/322R8EfrbyS0I9vuXSHbvM=; b=COr1L0KlIAQLxZCLtpl4ZjW9N3
	QaS6CDpu7nWaP0K3k9TgeDTFmk7EkgMPzS9v5gAB+jgdQu685I4y/jZrjh/OqNTrenHIDHC6z1yu7
	/RXbT2mL9rkC1+qB1tcw6YuG8TflOy/8RJf1drU9od1XrtB3x7i3umOHeCs9gnZNB6kbM1ZErJhMy
	Al3K5QwzRWK6JWR255WRdsHg4i7sY2vxnJnAs9DzW8XJA2bjcKHL0W/TW2gNACpanbJRwvBQxvfV/
	ds0SDaouuS7nNonqC7lzHS5/VGSjl4gvYTCBeNXkdYzPzUk9GtGlEjOuNCraYUvIe2MiHv5saitE/
	vboJMlVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1jr-003ETZ-0x;
	Tue, 12 Sep 2023 11:39:27 +0000
Received: from mail-lf1-f41.google.com ([209.85.167.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1jp-003ESv-0d
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:39:26 +0000
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50294a827e9so1137906e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518763; x=1695123563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOXKxk2eJuTEUva29o5n/322R8EfrbyS0I9vuXSHbvM=;
        b=TeJcVw+tN+qPAgnM+IcZEQxQAAeM2pc3xW9BMR4NbHxFoRuFc8254ih5FMv8iHqo4e
         Sl2SgkvMG5HWnB27ueCn01hDFg/mAgWx5QXPhXiGaKry3XN7CXE71CEwz+staVTPzyjS
         8j8cG2FsUhLIYPIFVWS2pNEQrqY9ekkBRqKcZ2/mNQCP7PZiMR25zRYZXLvoNAev3pTa
         2mUNM/tfAQ8BskKK4ULW5LYbY4K14aY3tUa/rS7J+AjyYYhqbZAYdMy1MV3PJA19f36q
         qB+eMAJnRoDPfvvzYLK+boxn5oVRNKQ57omVlGk7wCMxNgZXmikEiBeKhNUgaQtia7Yd
         o/8g==
X-Gm-Message-State: AOJu0Yy5RK7oeB/N7vPg5IUev5xCCrko2DmsqeBzy6jlK8hRoqy22B5M
	x3GPTHR6dRskDlFM0qydCXs=
X-Google-Smtp-Source: AGHT+IFOBzXFwfq4L8m7RXyPpWYnWpOOq0qAYiT+V+VzlZX4TTVGku3DXmqZtyz3JiwYBMU4GcxmfA==
X-Received: by 2002:a19:7402:0:b0:501:c223:fa22 with SMTP id v2-20020a197402000000b00501c223fa22mr7889927lfe.6.1694518762698;
        Tue, 12 Sep 2023 04:39:22 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906390a00b00992e94bcfabsm6688743eje.167.2023.09.12.04.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:39:22 -0700 (PDT)
Message-ID: <bb57e86e-654b-a4b1-e60a-7573e59c30ed@grimberg.me>
Date: Tue, 12 Sep 2023 14:39:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: alan.adamson@oracle.com, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
 <20230831231827.3896883-2-alan.adamson@oracle.com>
 <20230905065348.GB19754@lst.de>
 <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_043925_232520_94C9822D 
X-CRM114-Status: GOOD (  10.23  )
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


>>>       if (req->q->queuedata)
>>>           req->timeout = NVME_IO_TIMEOUT;
>>> -    else /* no queuedata implies admin queue */
>>> +    else { /* no queuedata implies admin queue */
>>>           req->timeout = NVME_ADMIN_TIMEOUT;
>>> +        if (!nr->ctrl->passthru_err_log_enabled)
>>> +            req->rq_flags |= RQF_QUIET;
>>> +    }
>>>       /* passthru commands should let the driver set the SGL flags */
>>>       cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>>> @@ -687,8 +720,7 @@ void nvme_init_request(struct request *req, 
>>> struct nvme_command *cmd)
>>>       if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>>           req->cmd_flags |= REQ_POLLED;
>>>       nvme_clear_nvme_request(req);
>>> -    req->rq_flags |= RQF_QUIET;
>> Isn't thisw now dropping the RQF_QUIET flag I/O commands that we
>> previously set?  While we're at it, why do we only allow passthrough
>> error logging for admin commands anyway?
> 
> While working through this, we decided that for IO commands (passthrough 
> or not) error logging would always be enabled. For passthrough admin 
> commands, error logging could be enabled or disabled.

Why shouldn't it apply to both?

