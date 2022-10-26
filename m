Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C88C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=yaLx127pH7jdjag4aGh2MDXEXn
	qxWmlYdUtmvmlaTON8m7R4n+TvJXjc+tWNb/2EciuI5iOp82GSuvvSIVtq79TA24mk2jgTnYl4zv9
	mhS5pDddwbJwz3XSTrOjpZmt7t8kiI31krNks1sfL7vmaqi/HLKXfAFPL8mAmqj2pDf/Qa+4uLM0P
	DzpfO+ML8F76zf1C3+OxRx0FpmCMXOgiOqke5h+Wb1aNxy1QXYgXLulITvwJecib+Ea+wc04jnLqM
	sjFhh74GpXxyPhC3VMALcR7mE/IwaRO1wXgVqmVqfEYNd0Of7biHaTcYhRMGyvfw1bZTG5sWDrX2V
	S6kJdHhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfru-009Hna-6E; Wed, 26 Oct 2022 12:50:50 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfrq-009Hhz-VC
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:50:48 +0000
Received: by mail-wm1-f54.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1468480wmb.5
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wTO7ZvQ5XwHANBn5zaI7eT9uuyn4RGJLg0+qKOxwjL/IDozcmrykwLdxDpaFCdIhfZ
         CdbZu28GRMQkrYXHMfvFvYdDY5tjtVpZamRF6/9RQafTzhT2v15gWE8SXCAp51mMwvY+
         6176Q/ZB+AEPX8DV7mQklx3oSWeyZVJ4a2YGv9q0Uax4ZbsD+CWdjcTzOZowGeLqHQGY
         zaHfxs27YBUrUjWVsxXujf4WHpPVwigv2zIwGQjx9MB6KrmDvPv5cjmTQrpD7m0H84xo
         YqgMuSLIx+9UqrNNnx5+mfa3SIwWxBdigXps9r04+hlG+RGgi3XkOXOsul74cXb1N6i2
         5AJg==
X-Gm-Message-State: ACrzQf3rtUunk6xoyK+bSmVipeY1eVb/H7OHyoBrh32wYY85r3jSFDyq
	ZY8/rroNGC4t9ILxqcOtPiOKr+A8A9I=
X-Google-Smtp-Source: AMsMyM4r9WznkUrdw/UuWkb94bY9rSIUugCqVmtw8vp+1ots7mMJ68Kdry2WZNreT1TaVMYJVyzCXA==
X-Received: by 2002:a05:600c:3c84:b0:3b4:eff4:ab69 with SMTP id bg4-20020a05600c3c8400b003b4eff4ab69mr2362569wmb.104.1666788641377;
        Wed, 26 Oct 2022 05:50:41 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b003b4ac05a8a4sm2397387wmo.27.2022.10.26.05.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:50:40 -0700 (PDT)
Message-ID: <e367459d-e19e-6a79-20a4-20abfc6dc901@grimberg.me>
Date: Wed, 26 Oct 2022 15:50:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 05/17] nvme: don't remove namespaces in nvme_passthru_end
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055047_023970_99FBA117 
X-CRM114-Status: UNSURE (   6.91  )
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

