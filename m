Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF74C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KKXK9batTk8wqcT/Bwb8BEEj7e
	/94fU0e9LhwLzaFf8nlTubpZZKyehtYv2Gc38OIhrGlVqU9KBusZ6B/rpLEfTlSsPjEaKEemVLsTP
	2EIOMk6imEmrxxzAbtRj75A1ENCbVbnj1VeCz+jtlfm4lTJ1thH0MAYM6nUmW3Yl1XBX2bIYi9aYy
	wUqD/a/hFcJn2uwR7vUqIUCOHeeMj40hJu5Lf6NoMeIJw8gt8oQtIJf1RjM6B8kdFJV5rIP8MO+CX
	MyRPXuwVoPBFKBX3T57MaHfhJw9wG6HGqvnJOJZUXQpL9DkiiMkris0QFXVaQljA/CZWmj9HlRJNw
	J2ugAD0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVhD-00FWh7-HR; Thu, 20 Oct 2022 13:34:51 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVPz-00FLk6-O8
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:17:06 +0000
Received: by mail-wm1-f52.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so2291879wmc.4
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=C4nyNPG4TKCTb6vX8clH+WGaLavLF10MztpZDoOSwkYZGXSkTXWhbz+1E42eFWp+HR
         0AYEnLcpCDY57IFcfF7z3zxPKijqM4Bv/OblfSpeeubbQD1zJoEa2kRjbM+9R9R4BaR2
         FlxsaQuDoXfmzFbMhH+di2+mqvq+9FZcNWIXaNETsDkLYBdG48h8LOPw+A7MA7o463r0
         lnO5J2kyfHQpMN9n1r2vuA3ncruac6S96ge8LI8kFWzLhtR+QEYxsrySofiJdNroL9Rp
         ZDb2k7pPqPdasjfoWPccF/HNNNcd+TvkfhNoN8+T4cYv5fpMxDp0V4NlBmsmOPmEkEA7
         sYqA==
X-Gm-Message-State: ACrzQf2BgD9DA+zsRCsv4Qx+qPF2aTRLGJvrPb4WJD9kxqLPLb2nWqnK
	Xct5fGd+mmXes0fQve7sE4s=
X-Google-Smtp-Source: AMsMyM4BA/hLXI1lD4bBUcnFM3vOLks+kWhmvPK0kW1kM2Us3kUvwpQxyIIwYoyWd+WvsMXjy9PxXg==
X-Received: by 2002:a05:600c:4410:b0:3c6:f04b:daa2 with SMTP id u16-20020a05600c441000b003c6f04bdaa2mr9600494wmn.186.1666271820916;
        Thu, 20 Oct 2022 06:17:00 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm16207614wrp.98.2022.10.20.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:17:00 -0700 (PDT)
Message-ID: <048eb761-f423-5b0e-f900-a6b0a4819f64@grimberg.me>
Date: Thu, 20 Oct 2022 16:16:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_061703_819368_7BB28D4E 
X-CRM114-Status: UNSURE (   6.82  )
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

