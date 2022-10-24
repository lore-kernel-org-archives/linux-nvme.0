Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0793ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6vie4dh+louXoUQMxLwJz2RE5N7M8k6YAevG4uZHlAM=; b=XKUkFAbJ6jdTjWZn75pduRMM1b
	ZpfdDZG34mWUkR2whVpnAqp/LTGC1OqWsd+fscDCml7n+1Tc3wMXg1X1CSpviRwOWPmTgrppx+OBl
	5fHYXj20U5yjX9Z++Z2r50zA+sXGqoFpjTsNY4In9ex8Ih0OEpEuid2i0hnhBuEm4KnbO+E6f7tKc
	IWok9QYE1L0E1Qu/KpMsbpN/V/mr2SPwsKS32+rloZ9vZsT33wa3n1DyXIh9aqspnOF38Dw8nTOSH
	RpGk+VFXQyyMnjIXV+AxlAlgSJ9YL+ucx8hoDCw87bYsvN0/qVk44IpIIyMKXj+JLLBY96VLDXVem
	VKYXmj8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omxc1-001jeq-Pb; Mon, 24 Oct 2022 13:35:29 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omxbz-001jW4-Gp
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 13:35:29 +0000
Received: by mail-pg1-f180.google.com with SMTP id g129so7067891pgc.7
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 06:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vie4dh+louXoUQMxLwJz2RE5N7M8k6YAevG4uZHlAM=;
        b=aPCQz1a+P8p5islg2eAEW/r1e3uF7FluROSL0rHuNoZDtNq7Yjjg4gOZVZ3k0uXVWF
         jdi0xX4Uxe41sXTEUrzWAMSBD1w5HkgsJj0CnK1K4yFao/Iv1XXVar29Qi0DCFWecaxT
         i3273blgsjRIJMwVa3UMWYZf/9Gjvq7/473deJ0pVwQ7weW9WzSNj1wz2BX+jpC4MkvP
         dH8WhKepG3/SokpFIaKfF0kp3ZhAsBx9yFn49TRUuD3bgrcEsy1M2JLmeAOI+91E1NHK
         dAwtuGOKOwlhjLSWuwREh1rifwfz7ouHD9bzdoE3gatKcdN/fiW1gqwvLACFh+c2D2Lz
         6Gtw==
X-Gm-Message-State: ACrzQf3pkriBkEp07yJrvvUSig4zE7AjzIUd1fx5m4MKJyJqogRQWVG6
	e/w+8WKM4bGBQ0Gg7INc7W+nyh6bH/A=
X-Google-Smtp-Source: AMsMyM6ckg/oHhCgaWHmli0CaXhP/8VL4mNEVYUHYL8F3rk1ClcrEraBR6UfQF3YnlCK0f+GKELy9w==
X-Received: by 2002:a05:6a00:2303:b0:56b:cd7e:6cb with SMTP id h3-20020a056a00230300b0056bcd7e06cbmr5528386pfh.77.1666618524742;
        Mon, 24 Oct 2022 06:35:24 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id cx10-20020a17090afd8a00b002132adb61ccsm432730pjb.48.2022.10.24.06.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:35:23 -0700 (PDT)
Message-ID: <77784776-4e58-47d9-abde-a782f5ca7d3a@acm.org>
Date: Mon, 24 Oct 2022 06:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
 <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
 <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_063527_871611_984485AF 
X-CRM114-Status: GOOD (  11.09  )
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

On 10/23/22 18:57, Chao Leng wrote:
> blk_mq_quiesce_tagset() support concurrency. blk_mq_quiesce_tagset() just
> check the flag(QUEUE_FLAG_SKIP_TAGSET_QUIESCE), it has no impact on 
> concurrency.

Hi Chao,

I think it depends on how the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag is 
set. I agree if that flag is set once and never modified that there is 
no race. What I'm wondering about is whether there could be a need for 
block drivers to set the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag just before 
blk_mq_quiesce_tagset() is called and cleared immediately after 
blk_mq_quiesce_tagset() returns? In that case I think there is a race 
condition.

Thanks,

Bart.

