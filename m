Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDBBC4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E914206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2EMf4T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E914206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=X2EMf4T+xoUSUpZggHJJxavi5
	GFXaVKaDXx0kSI3dHywE0IejeIeLfNicjh6o0stE1tJzAUx+58+IjJZvd55g0+5HPARw+Wv8vW960
	owcbSHgeciTJ6sl/VVcUGeRNyKgn756EmYDV6ghvxQl1vc7itFgNwA10ymSR05HtRAmnIfz5rQp4E
	9DvLcVKrC3tfEioCL16Kssxx8tUk7/H3sO3tK1/NhQazSzW6JoUagB/RvHSg4+ZPv8LG87O2mn9Jd
	x3e6HpA2lG/YIelTE52h7bR44g/SkkgY+6Oa7gzUXcI3cHPjmR7DyC9gKM3oFTbhkvxMbqyPwp5vC
	21vm+xpVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBSs-0004Yb-8b; Tue, 29 Sep 2020 08:58:26 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBQ9-0003OG-MN
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:55:39 +0000
Received: by mail-pg1-f169.google.com with SMTP id 197so3308437pge.8
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=D+6t1EsQQhocm3QE58e8iKPuKWfTNKH4OWXnb4KiUdsVHYi1DCMZEDdhfCNCTFiWvk
 q5zzzWluL3Eby2Ju5rvq78Q9UJYNMvNdJWpHZxFA15u0cLtWkTHhfN3w8SFOT+UbZSm2
 G2lhbHXqmp+vhWqEf4Bd5neYt+efah4C7S0AW/hW7hkiyW+aSTqs0KT3ygdD9loGbNdM
 FQdyzPjDmwnI7qswerwWwQi3PmlQkZ5VS+qNJyN0HG8gjztggFCqP/rDhfNnAfPAuEHR
 cSJ1KCJ3lNEjeOx0BRkQB3cbcv1Gdhman6psX3bEFTxuzI3nyKKTMthwP4Ox1WgMFkCS
 tL8Q==
X-Gm-Message-State: AOAM5307WA57M5KxjvsNv13+pFmf0vvDY60MDEASfFzjJeqIPv1pyxYN
 P8lx0d0uiuY1iZFgcImjdMQ=
X-Google-Smtp-Source: ABdhPJwcjz3nYsn/wx6VjkfzTvqBpZ06u/WLigsp58fP3J+QkkPqQvcQ9BF8dWXMzG9kC1M3q/0bbw==
X-Received: by 2002:a17:902:67:b029:d2:564a:e842 with SMTP id
 94-20020a1709020067b02900d2564ae842mr3522204pla.4.1601369736237; 
 Tue, 29 Sep 2020 01:55:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id e2sm4066922pgc.29.2020.09.29.01.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:55:35 -0700 (PDT)
Subject: Re: [PATCH 14/20] nvme: update the known admin effects
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-15-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9764fc1-2bcf-d0e6-84e9-1bab7c01f464@grimberg.me>
Date: Tue, 29 Sep 2020 01:55:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-15-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_045537_795173_EBF5BCE7 
X-CRM114-Status: GOOD (  11.04  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
