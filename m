Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC238C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=FrZABm24vipgv4cyJLQXTodn+U
	ifZGA9o2MVip7uUuCjwbjiJBqS706XaKyCmsrFysz0VLqGTLrA5+EkYgTBgPHh9iXvXnSzT4XgzQS
	uOb7d/CAX3XsJOxsZYdHcN0+lGYTkwrIW0RSNM18AuWzbXrgZFAc5ZX+xQnGJRZaZOxmJwEvMICqG
	IjUf3yVEXD0Ye1QwMQBQbv95fbXrMvIck0TVeJAXse4qlGoM2VAUPH0ESr8K8zHqpmD1tt+I1KW5V
	9ls4imrAMVFaESWpWz15SN7gwPYAZr73X4wPL5pfvOGxVwfJr7/a9d305pa1BQBG+UHQd26I51U8c
	Fa1wvdyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVjx-00FYrk-1X; Thu, 20 Oct 2022 13:37:41 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVWN-00FPmM-To
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:23:43 +0000
Received: by mail-wr1-f43.google.com with SMTP id a3so34365047wrt.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=h2r6+u4pQeEWbnORANVObFbcQJkrwpEqu3uSb8372R1Uy4nI+RwZgboG2btQBiO6T6
         XNtnvDlEaegE2Mn5Tkr+KeglZ7NwwhRYWshA0SylpqnIzpysfRVIFZL5n3I26CntZKJn
         68Wx0Hiij/ows+PLvqVpRkC1nz8IsBtAD+Pi6pA4KI9AXbnVsz2JsafJxsZveUX5aJfn
         O6srB+9ZhtGk7qc4NBOfGkW8GlAVKHBxBuCBkNSncE6/h8nzIfo/W1lw3mSg8G5W0za+
         EVcuv85O6+CUdT8rgAx/yxJ68QeaejGJhAiJ283z/tuS4WIxBkqMJ+H79FwvV+H8pbtj
         VwKA==
X-Gm-Message-State: ACrzQf2jpHS1r9vZJ3HoEFOoIr7OQcv00HvOxIZXBJUXawRjU/nrN+DS
	NL+RT+XuutuCb5Ld0Q0igB8=
X-Google-Smtp-Source: AMsMyM5FdqFqk2BFYdqRNYgpAYJFxNQAyDuUFMezEhoRv0VIpRtNWWc4DDjTtq5WsyTltEjP5zkVRw==
X-Received: by 2002:a5d:6c62:0:b0:230:5aa7:6771 with SMTP id r2-20020a5d6c62000000b002305aa76771mr8333890wrz.158.1666272217931;
        Thu, 20 Oct 2022 06:23:37 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0022abcc1e3cesm16358140wrw.116.2022.10.20.06.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:23:37 -0700 (PDT)
Message-ID: <dcc13b0c-ecf7-d7a2-c7ab-43334ff4da6b@grimberg.me>
Date: Thu, 20 Oct 2022 16:23:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_062340_000271_9B0A1AFA 
X-CRM114-Status: UNSURE (   7.14  )
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

