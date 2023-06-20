Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82820EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ichHBITtiXbhvg4wtZ1vUsPoopXyJCtdwz3MwN/NO4M=; b=wgBgvYUJMA2SxZoCjjy2SkQBa1
	VuNsKGohRAESIGm27cRA3T0FChix8Si8kWQdDFHhssq3FfKL4RveEM211OCzlwIAnaQugCJN2tcE3
	S+MRlbf9oPOL6GfEjj3FGIhUgHmFTBgXdRWXLiZqEZq27EloAudo+sUljL9aDXhS2TBv5q95IKRjT
	IOLBddmodwSP6PNj1HSovcdatSZQj6Pb9nrHt0ogDkD23o+GeEziRUXIKs/3E7iDq36mwD7QzNIfP
	7oXFv/bc72W1j6P3h6x0HryAvP5V2nD7l59HOc3NqdEF7M/WsLl2vIBgFgrZmf5R3rnSmwNaqf7+T
	GQMebLnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYE7-00AoBF-16;
	Tue, 20 Jun 2023 10:04:43 +0000
Received: from mail-lj1-f173.google.com ([209.85.208.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYE4-00AoAP-29
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 10:04:41 +0000
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b36116a7dbso9971581fa.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 03:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255476; x=1689847476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ichHBITtiXbhvg4wtZ1vUsPoopXyJCtdwz3MwN/NO4M=;
        b=hju2SBYNo/BvldNIXoi9zVLu/N5eCq46Z3+W0L5pdm4X4+LNy5+ZWoWr7rF5pecSOm
         ysEM5+cN5i+hi1UWIQQpZBuHQ34HVhSk1ngYI2lTL4B22g0zzC3+QFwkyRoFyu5WlLBb
         kuROQ55x4B8zZQf2xAEwMnX3izwBpUHP5P3fokv/AaM9K5FoGhHvOQ5s0Ae2bfe4h9uj
         jWKurxGCNFYVg7u3wgkbJU0KnxV74Q4C1iW45jl9xXh7GwuLqlyi7XWnaIOEojamHvR3
         fMn5X8S5LBqam89PPecI6QLRyT7rZ88XdmWRUlcZHQF2EZCdt6/rPBsxWtxRMp4UNRWm
         PFMQ==
X-Gm-Message-State: AC+VfDwD6nK6qVPzJjj3X8ukPbGQHQjl2J3S5/p06iAnAQshJl9zRp7k
	MVhViWkz5QVwthj+9+xXgpWzQ6/39dE=
X-Google-Smtp-Source: ACHHUZ6qIHcwF7r810eKQ1dzX3u1KNsQUMwETDgWdDq4ezsW97apVNbzQO9bDsxCveQXRoE8Sh9CxA==
X-Received: by 2002:ac2:5101:0:b0:4f7:640c:1847 with SMTP id q1-20020ac25101000000b004f7640c1847mr5089563lfb.6.1687255476104;
        Tue, 20 Jun 2023 03:04:36 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d498b000000b00307a86a4bcesm1631011wrq.35.2023.06.20.03.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:04:35 -0700 (PDT)
Message-ID: <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
Date: Tue, 20 Jun 2023 13:04:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_030440_703759_D9439D23 
X-CRM114-Status: GOOD (  11.63  )
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


> Hello,
> 
> The 1st three patch fixes io hang when controller removal interrupts error
> recovery, then queue is left as frozen.
> 
> The 4th patch fixes io hang when controller is left as unquiesce.

Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
connect patches?

I think that these are patches that should go in regradless because
they also fix I/O failover blocked on request queue enter.

