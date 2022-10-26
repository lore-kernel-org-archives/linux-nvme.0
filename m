Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692ADC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=riHb3C+jEXFnHM0//PhEBERIeQ
	XfOjgVSpnYu4vSGviTOmGB0M92HWooURM1/dnrPN+sEOET3oKUWfVZIVJnobIuP2PEdSxGWWioeod
	6gtVWc0lC2iNgg6Xmk5Rj5ClJ8r7RTP/dLgP7umo+AacrA9S7zExf1io1+VwooPqDrRn0lRKAQ30m
	g6wDqRaXxZJGYHkOsNsxTvpelEfk2UPBRmMtSPao+vjNrzQOOO5FB+bWvyhCBSnEm+TT+G+HysFFV
	dAQs/rJxXTnnDd49EmYnj5BxHEacrBG6jjYLJ5tPNR3w0SrvWv7biTl6LhVgoNCpg+yflRhFnrAvz
	1gOiVbvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfvQ-009JCn-N5; Wed, 26 Oct 2022 12:54:28 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfvN-009JAQ-Nn
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:54:26 +0000
Received: by mail-wr1-f41.google.com with SMTP id l14so18925407wrw.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=n47DoG7OcZBfh/AqNz2QRvz6nQYV6SpSM09ikjzEOYPRo0mCX+fR3aWPzGT8m+xT+0
         +3O7MTT5g1wzCByltI6a0XjvqeAB1fV7/SVF384/TT08i/yNo+S2ywF2k4uRqsfxmv2f
         kWEWrTT9wZW0WOezlpSPHGJAmgj8zux6+ELrrn2R9Fh0gSHiLXvc47WYC6sN2gR1yKtn
         PSNKbXBM+RPxP6gkxXXHXJpF6V/fXdqo23xbCckmp/J7ot75lg+nMZMGbpGbcBs2eD4n
         gYBBkjSk3hzle20cHATSocDGd/UU89O93OeIQ9deuGukqQY13WmHMFxha0Hww3jg+egY
         xEeA==
X-Gm-Message-State: ACrzQf3lqXk+XYIchpZFGRcoKy3D0iAToHFKFn1lfOq/hmiUQZt9HjIP
	Lf9ujg/lb8GXF0DPONTDrrM=
X-Google-Smtp-Source: AMsMyM5ePG/9M6uwrcm6xSHVMuSkGSKZVC2Q9oxXwhDhTmaGBKat5SzS44mBh3XqSOKYI4w1iZEL0A==
X-Received: by 2002:adf:e610:0:b0:236:737f:8e5d with SMTP id p16-20020adfe610000000b00236737f8e5dmr10045843wrm.316.1666788862313;
        Wed, 26 Oct 2022 05:54:22 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003c6f1732f65sm1880649wmn.38.2022.10.26.05.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:54:21 -0700 (PDT)
Message-ID: <0488bde1-e36b-e3ea-a40b-9b1294273ac5@grimberg.me>
Date: Wed, 26 Oct 2022 15:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/17] nvme: don't unquiesce the I/O queues in
 nvme_kill_queues
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055425_787200_F0A08D2C 
X-CRM114-Status: UNSURE (   6.99  )
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

