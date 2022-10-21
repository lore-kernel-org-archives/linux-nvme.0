Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCCEC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5gjExI0OGQVf5MMUfW+J/Ig8uCVySaCPKsKvlNix8o=; b=GUYPHiIkBnGAGM9tpPtpk6ecom
	zpvtZ8o3xH+ge9R7eukL0y4DWurCTRbhlVxkIFTNGiGmK6RlnEF/B/K+GV+TnvYnhqkhefFF7HKku
	I2OSMG9vDTE0RhZEEsCmmcfO10u1uQqJPrxyn4cdcvPAvsL0C1mjH/XndgeGOfc2wAg5jwgBYOkiz
	GKXGscMn2u8ut3Q/hGu9h112e1Ds9TPXaDZ2CJ27pEpwK+EeVq+bfiZ/L6aTy7paiwlhEIO2YhX9a
	urEfegULTdSG4M4lMv7exWDi1UP2zR59j0clqgnc7gfmJljsIIhEdqEINntyaaCQH4D2kuL82xF1E
	/UB81S1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olzP8-009z8d-JM; Fri, 21 Oct 2022 21:18:10 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olzP5-009z84-B2
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 21:18:08 +0000
Received: by mail-pg1-f170.google.com with SMTP id r18so3602780pgr.12
        for <linux-nvme@lists.infradead.org>; Fri, 21 Oct 2022 14:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5gjExI0OGQVf5MMUfW+J/Ig8uCVySaCPKsKvlNix8o=;
        b=TbmDehJEatobVGEH/KCr9KNRgFpxNGRn/O34hfCnTHLrTU8ZCjmAuVpJQI7Wra9q4H
         cN4YzF7ojrFZ0Dmap6JcFl9XLnBaRptinl0wqxBirteS/grt/D7H13Frca9LWcN2vwe8
         zO5iaMtEXan2m9+6cYN4TLwbYwj7Cc2Gmo33Uw9wH+hlPRBNEGJSS5fONZz0hOS5SbPe
         4xUgIB4bPmHzkNSG2iF1anhUZcWjeCAZMeHQBceimvBHjIhR90xR/yWkP/PFg1Pyq02b
         +P3jzh0O8FnmZtuysqJzX5OLJL91kbYsRRcRMemjyM3+2Nk/agPr4JHbd5lDdpMDsvn0
         zppQ==
X-Gm-Message-State: ACrzQf1HW6AYUv3s2IQf5iAHoL3FPOYgsn09zLuhZGx96J7K4VMNHIY9
	gS7paw90VStYSGei3TTTCxfjMiVfsFI=
X-Google-Smtp-Source: AMsMyM6ju3s+P0WRsG3hEO0puPCoBQHkO0xuzJJN5nG5dawIgCzD1KYAmUU0KPhx3yO7NKJr2GKKmA==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id k8-20020a056a00168800b0053b42397c5cmr21408615pfc.81.1666387085374;
        Fri, 21 Oct 2022 14:18:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3bff:84a:36de:737? ([2620:15c:211:201:3bff:84a:36de:737])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00209a12b3879sm2055474pjb.37.2022.10.21.14.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:18:04 -0700 (PDT)
Message-ID: <0dd9b8d1-79ae-3519-518e-433bda15abd3@acm.org>
Date: Fri, 21 Oct 2022 14:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_141807_491518_6F29E267 
X-CRM114-Status: UNSURE (   8.18  )
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

On 10/20/22 03:56, Christoph Hellwig wrote:
> Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just

Noting -> Nothing

Thanks,

Bart.

