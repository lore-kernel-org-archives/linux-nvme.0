Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A2C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=YIy/CbNDhk5UfoTd+ejHtqaRSL
	7O475WpMSLlej8ZtNLkzLapuosvdbfNEq4jhaNdzcfBYrlfTYSnGqxkRDqe0FFbgrTxbNXZ5rc30y
	A/u/UNOTNvM5ScwazltihyqeiQtXM7AroJ96ej4T5VfMxaVQs1Qs3v8YUZvMvQT0vGURmp/E6hdFZ
	IhUPVfNXVWkzHqPFr+rsYv/uZ8WSJvu9EO/z43xQXekBdoL1ycIOu0+my+rspY2QfW3MOJ7beCqHe
	081pxCJ6ZPEJ4o3Iqu/2f3Y2jtdm2Ds83q1i2UqeSJPab2rKjS/nwVkIZRSUrzMPTHZCwbJ4pfVGx
	cwpfjD3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4IV-00GU26-BR; Wed, 19 Oct 2022 08:19:31 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4IS-00GU0I-TN
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:19:30 +0000
Received: by mail-wm1-f42.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so14013424wmb.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JmIKcE3ckSLO7F3x3IhTEFmKwsFDjRnxLf4gWABJWNKOyBeUDnBXHNeKbobs6hc9yn
         QBIJ4OKfFuVDIkteEDWV5PQYp0SQMvcWXeG+Ykor/yk2c1UCwO8EHFXGHA7w8FHJURkF
         J+bJ1gyPgYXbWKuUOeUaOACnGwQmYfpZb5AipM5LFN92/vPBee9FEhEwn2t2bSMuoSzN
         G92tdA43tuvMuYOdTdb4vyApVhw/qOD/vFosWLWyY4weClYmcahH04cUw85sDbfCL0uJ
         fkN6/qpJWl0+6+XaowJV5eyVgQIrBIQSaKXy9z4l9aL3Z7aFBiOFoJiWOss/rHvjZw5s
         69hA==
X-Gm-Message-State: ACrzQf2JUzxit+ItBpl1W8vj6gwnmSA8UqrOtH1q7fInFAcgO5vZUglK
	QzBg2/6j3HQmXtsd8ErI3iI=
X-Google-Smtp-Source: AMsMyM6jdfABlBtJU9mx28hXGjxEvpJuKKRVafbYFMooNEY/ZiHfSwRXrftaND2z2wcWPuikvxixrg==
X-Received: by 2002:a7b:c005:0:b0:3c3:6b2a:33bf with SMTP id c5-20020a7bc005000000b003c36b2a33bfmr4527598wmb.167.1666167567218;
        Wed, 19 Oct 2022 01:19:27 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b002206203ed3dsm13127525wrs.29.2022.10.19.01.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:19:26 -0700 (PDT)
Message-ID: <dd6a3e16-e44a-fdce-d8c3-8823f200c8a6@grimberg.me>
Date: Wed, 19 Oct 2022 11:19:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/4] scsi: remove an extra queue reference
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018135720.670094-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_011928_957771_ACB914E1 
X-CRM114-Status: UNSURE (   7.41  )
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

