Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CFCC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oL1rxmsbULnQ7bVykV93AVdpvYDqMSKfMYqBHBTEVB8=; b=tbQGv3JyaNCKFM2ZDDSxZh3qN5
	wL2teRfe9KQMuv+rcvD2fHxcvmjXog/ReV8aegTceDp8v2vdxR8squbFPmTcTYoVkMkaFEWLgVh/w
	D5jEUBDItELQtpQqR7pXXkbJQSK+o1U2SQFnqLYdJ8zj8sF0oXQdFQLeTqTIZnVVIcWtsojO/MrBj
	WIpUzuKE542PYv2MfEDO0VIteiHplVh4a2qpPQCkxEtshR6eoxnSLXyG6VsVH7koyxrwqvyKt76l2
	WZ5Yjsj7Hjx8wWgf4ZCEqRk16SZh6CMdANdD4hFsq9jjqUkWdHiNZF/Yod0YsnC5RCAVK5KyrMgAv
	zHvvO1bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olzTm-009zyV-1b; Fri, 21 Oct 2022 21:22:58 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olzTi-009zxL-JX
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 21:22:56 +0000
Received: by mail-pf1-f175.google.com with SMTP id m6so3820161pfb.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Oct 2022 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oL1rxmsbULnQ7bVykV93AVdpvYDqMSKfMYqBHBTEVB8=;
        b=IGzBZHIFv9y6AYH2EBhiQ8cx1lcWX5F6Zn1SfOOhgttEe2JwWMu4/G8y2l+KrWosXl
         CMvO8vHLOIkxMctBMAZM+LfUVEDfPurmd+C6mV7rZhxVVp3C0YScCH0m0k0mFBqzy3HK
         4TkvzIX8jD5bPIsYK8NQKslcdfuzqirrhdjPxZKgVQ+zBgGBWrydrA6rz1XK+65r1S1A
         UF1NIVJBpV1fIwgeDf5zOoLZedP2XrKIri3F5L4oGItt8g9jMqktiEmt+A0FS+HSizlS
         /w4PyJJqxXH8cz1ZX9qdwQsbMGZyT6DHd5RjW+NCSCI5VjCH+fIGU3pnuCE+9rGHofQZ
         k1kA==
X-Gm-Message-State: ACrzQf24s5N/DnGo/wMxy0N6dQoXqY2v+pcf8x2Sun1LEDgjfH/ccqbL
	YNfQ6mwH+BaWMOs4O6q0V6s=
X-Google-Smtp-Source: AMsMyM6srn2f9RgF906preCFswu5M5dN4aBh3C9WcyEJiG+QF7I4ae8DFMhHWv1JHUtUkGMPrWo3tQ==
X-Received: by 2002:a63:1162:0:b0:450:a0e9:c996 with SMTP id 34-20020a631162000000b00450a0e9c996mr17666933pgr.140.1666387373324;
        Fri, 21 Oct 2022 14:22:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3bff:84a:36de:737? ([2620:15c:211:201:3bff:84a:36de:737])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b0020a0571b354sm1930147pjb.57.2022.10.21.14.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:22:52 -0700 (PDT)
Message-ID: <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
Date: Fri, 21 Oct 2022 14:22:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_142254_673325_65C12265 
X-CRM114-Status: GOOD (  15.16  )
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
> From: Chao Leng <lengchao@huawei.com>
> 
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an
> interface to quiesce all the queues on a given tagset. This interface is
> useful because it can speedup the quiesce by doing it in parallel.
> 
> Because some queues should not need to be quiesced(e.g. nvme connect_q)

should not need -> do not have

> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to

quiesce -> quiescing

. So -> ,

> tagset quiesce interface to skip the queue.

Hi Christoph,

Are there any drivers that may call blk_mq_quiesce_tagset() concurrently 
from two different threads? blk_mq_quiesce_queue() supports this but 
blk_mq_quiesce_tagset() cannot support this because of the mechanism 
used to mark request queues that should be skipped (queue flag).

Thanks,

Bart.

