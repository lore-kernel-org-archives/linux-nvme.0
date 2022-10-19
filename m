Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEFAC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C+YQK553ZwAb75g9DYbrpJvtlRziCaaKNmA4fzdn2Go=; b=Q/HTCtkAihOke3lSBSOD9ewLKu
	g518AiSJKfhpfI6JZu9NJGVyz254JCATYIHs2dDsKqcMaGLnQIoL49rMymz0qSrKQgfDRV1hj8tym
	iVN4GDgu6V18IOWNAriHZRiljSON1Ms6VHwmC03TOb0kb9j6S2Ie2Oy6pPEZPtL3J3Udu75R+ggy1
	bUvcZlrHMKx5Cxz+Kr1eZWulEE6yJk629PnEZ2r9CtQ/0cygDKOA9v2wPfd8AJd880MzUWhG0lr7K
	C13AoMF1x1Wbjhnp52qCjribjKYAEhbNO5G63G7lk1DmA/oO8lX+xAfCEB/CJeNRGZmGvzJ8JM/2A
	QnJs9dBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4SE-00GZFY-Qn; Wed, 19 Oct 2022 08:29:34 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4SB-00GZCm-U8
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:29:33 +0000
Received: by mail-wr1-f50.google.com with SMTP id a10so27795320wrm.12
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+YQK553ZwAb75g9DYbrpJvtlRziCaaKNmA4fzdn2Go=;
        b=yHZrS3j5JLgOYKKfPvDgyCeLE3caT/mw910bpSkCQA/dz0mzkRXjvRI8dkDcQtlkdy
         Um2m8VhvLaoNpk6GzdKkfPgoLOiHMNti7i6mwMsZ29IBJvRKS5ZyKoo8IdPWYKyc0PRW
         9j3vkvz5Axw1otCTKNXbpsreHEJcVBlcLA5vSXeay5DELZyT+BViHY5noz+URe/UGA7q
         C48oqwIOGymn45i7ZmcWi6jQUZqzl26JOm2a6PzdBguEKdFw0xOenrCAmqKEk8j1T0xM
         Rg1VTYNhJv1BQ0aay8VJOCVapXaUQX2R7yyZMwEYd/2gFtas22LDKxZrzLe2gvkTh1wi
         P9Ow==
X-Gm-Message-State: ACrzQf0Jx3j96dhUFwcvl5aWgQhDhRNyO/L0yiII9Uhhv6kI56xfBvu0
	A5xCgtFYEYcTzv4TpXAPStE=
X-Google-Smtp-Source: AMsMyM5YXYOq0swriFXs8+YYZMHVekIYDljoauTk0kcObiPq1L4R2KyizmHUw1twq22YPfLd/0Zcfw==
X-Received: by 2002:a5d:4d07:0:b0:22e:3c45:9f00 with SMTP id z7-20020a5d4d07000000b0022e3c459f00mr4189315wrt.646.1666168169115;
        Wed, 19 Oct 2022 01:29:29 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q8-20020a1cf308000000b003c6b9749505sm20546201wmq.30.2022.10.19.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:29:28 -0700 (PDT)
Message-ID: <78b32314-6e03-6069-3459-d21189eb42e4@grimberg.me>
Date: Wed, 19 Oct 2022 11:29:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk
References: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
 <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
 <20221019072535.GA11402@lst.de>
 <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
 <20221019073231.GA12035@lst.de>
 <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
 <20221019081734.GA15255@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019081734.GA15255@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_012932_005478_6F777F4C 
X-CRM114-Status: GOOD (  11.36  )
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


>>>> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
>>>> BLK_MQ_F_BLOCKING.
>>>
>>> Yes, but Mike had a series to implement a similar fast path as nvme-tcp
>>> as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
>>> midlayer.
>>
>> Hmmm, didn't see that, pointer?
> 
> https://www.spinics.net/lists/linux-scsi/msg170849.html

Nice.

>>>   We'll also need it to convert the paride drivers to libata,
>>> but those are single request_queue per tag_set as far as I know.
>>
>> didn't see paride even attempting to quiesce...
> 
> The block layer might.  But it really does not matter for our
> considerations here..

Right.

