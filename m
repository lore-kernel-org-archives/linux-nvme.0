Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E015C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UzVbvk8hx8l7BIuvfVsIXXb4jKz9eu/T6hBQaAEGOU4=; b=49hMR6asXPDqWfMVjfGLQTbW+C
	1UMu1CoC4GHxONj47aWTc6vbhsVtMCPCDMkD2rUkNMQEIBeE47qdCUwydmAcYLPw8cOMfo/XsfcmV
	B9/sdDS1MNJ9a79lQsEHw1tfVixzyOLvt/9Mq5xdjoKh86IgER/i7Z7wN7vW7AAzyc1+RG7RkSvU3
	wUAxKIT6UL9gXLnH9XSRyjH/g4xzbxzsfIxdpFK0j7OIktiJ7htjmJEp/YBXH+KibJn/qyWU8WLEv
	j0dyCTcOLI98CdL+L5yBB3tVKov+ti9Go2UgJWKnrRjlb4oAb6FBB0UJ1UNt2QURYsrQOcMij1ypT
	HOBO610A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3x1-00GJoE-64; Wed, 19 Oct 2022 07:57:19 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3wy-00GJlC-Fm
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:57:17 +0000
Received: by mail-wm1-f53.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so16514857wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 00:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzVbvk8hx8l7BIuvfVsIXXb4jKz9eu/T6hBQaAEGOU4=;
        b=As3Mwslri/5clI4tq2FevaRfY9CMktLnRk+Vm9nNXCE+Wsshe0MF0XQ7B/Jk8hsO+r
         yxVwDX5U2spnmA0BA0Ay1DDv1dHEe+Qtu+2N3TtayVP4GAGchxTF8YR3T8igxOBRFcc0
         ydrHr4Hmj39frdtsTpr+YB/GAT9vqRVOrUzAjxXuIV+q6QPpwedhu7L8ls0Po9UdZWrf
         YTahBPiMcsXVg9CdbWMH5U+olZwfPJd1ImYr1IWtCes5gXMf2fVw8W8trsSWlT5zNglh
         B/286tgG716lTFANg9uPSPGH3IkFThHs3yCS5BswQf52PYiZd4x5mu0Jr+J/wb1JNrPh
         mL0Q==
X-Gm-Message-State: ACrzQf2GvUAl4jgGu2yjTnPPvlL5jfA1WtPziPJuE5NDaxgZtUlBNzBX
	tK+58PC5RnE4bz/oc9D9nOMASI7EwMY=
X-Google-Smtp-Source: AMsMyM4tyl1SCsAIq8EtI4ZWNNZXuswm8uv6k/Bvfu0xwrxOJ7mJ5+QN0/j6R2az0CPMYvqiLfQQFw==
X-Received: by 2002:a05:600c:4f52:b0:3c6:cd82:5943 with SMTP id m18-20020a05600c4f5200b003c6cd825943mr25417718wmq.185.1666166233751;
        Wed, 19 Oct 2022 00:57:13 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c430700b003b492338f45sm14815320wme.39.2022.10.19.00.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:57:13 -0700 (PDT)
Message-ID: <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
Date: Wed, 19 Oct 2022 10:57:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk
References: <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
 <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
 <20221019072535.GA11402@lst.de>
 <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
 <20221019073231.GA12035@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019073231.GA12035@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_005716_555946_394EEA6F 
X-CRM114-Status: GOOD (  13.56  )
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



On 10/19/22 10:32, Christoph Hellwig wrote:
> On Wed, Oct 19, 2022 at 10:30:44AM +0300, Sagi Grimberg wrote:
>> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
>> BLK_MQ_F_BLOCKING.
> 
> Yes, but Mike had a series to implement a similar fast path as nvme-tcp
> as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
> midlayer.

Hmmm, didn't see that, pointer?

>  We'll also need it to convert the paride drivers to libata,
> but those are single request_queue per tag_set as far as I know.

didn't see paride even attempting to quiesce...

