Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C511FC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=v51wS2+GWcndCf9LrA7SEsKS2Y
	PBWrd8yBY834YMHLv5R3x2uTEYsQBE3csqZo57mUiVzU1Mvh6e7UaDSZaMTXHiGc6U0GtWyABzhTw
	ECp2MjhTjnKKIljyHZbW46FdPpOqX9yixGn3H7AIcB8iGTyal7yvXq1EdbcceJdNVPXjD7TrtvKaf
	EonAF/cikgsigMoobYJYa+VeEPxItoCVEYmQiCAak31JuBC0UtkOlI7orjpua5mx2yNP0OkdbTaDU
	2/qCjomZofXzsLdjqUVSCK95ht/R9s2iS9ao3c3K9vVK2uM8aalMqLGV5Nmh1q+0xApfyxiD0eCBU
	aFpFGmUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVkT-00FZIS-Lc; Thu, 20 Oct 2022 13:38:13 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVWZ-00FPsL-8l
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:23:57 +0000
Received: by mail-wm1-f43.google.com with SMTP id v11so4907922wmd.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ts17DcKfzlAEuiZciC6rx8Gn0BrVQyjtmzju+RNcmCGoixAw0yJpAZjRoI1aMDOFWY
         B0GRcSrEi+S3FGF0koDcsM7Vx8f5EkzYngalgNHZpHHDM38TYm5jZozAbF/5b1rwZMSM
         PFTL2QrMdcvAZzbuGklABy5aJplOa2AEtuaLGQAbuXHW7bPunYzlK3BJqp+7LcJCnaEE
         BSDMSsOnF28rg+bn2o9dvkM1evDwEphHS/NBODC93qTAqbIm1vFoQoIxFB5Wcus+JN9A
         dkTHLBGvCO1QEYBb4kfNVTmVcZHgGOR60raGhRtN6q+yGjODkYKkcxqHMSdxzbWg3pTC
         QAXQ==
X-Gm-Message-State: ACrzQf2CCAih38U82tkaZJp4xgIy7D2a0m93DjEfwneHvclY+oUxsZmC
	mOn6/UMv5jaNa3M7wnXF+vU=
X-Google-Smtp-Source: AMsMyM7K5WQPPB1FDyFXOQr28xu12GlQmwYpYnkorVNl0FM4LrMpfMZJ7ZSzoMz4I7K7yB7Kc03c2A==
X-Received: by 2002:a05:600c:4e8b:b0:3b4:c8ce:be87 with SMTP id f11-20020a05600c4e8b00b003b4c8cebe87mr31938678wmq.157.1666272229300;
        Thu, 20 Oct 2022 06:23:49 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4f08000000b0023538fb27c1sm2523871wru.85.2022.10.20.06.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:23:48 -0700 (PDT)
Message-ID: <a9d28250-e231-00aa-c104-5e14b9631a02@grimberg.me>
Date: Thu, 20 Oct 2022 16:23:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_062351_353942_261DA939 
X-CRM114-Status: UNSURE (   6.84  )
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

