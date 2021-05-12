Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982FC43460
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:04:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593FF613FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593FF613FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ZuBCUAOAGidsw32029oVMGXcg
	RMATWvsFHj2isZ6+7WP/tAhL/zWiFHwkQr9J3siZn+19izaWDqvK5BnF7Q1d+qQMxi+3t+yV3rybQ
	DqWrNAO07nTuV/AIS7rG3lEPl3Dckj2eCDtj5/wsxF/qy6LJA+4YITSSa2VWRARYgwJUNtEzZX9HH
	4HffNoKF/nhUwQHi6eLs63VLdChb+GXv1AaYCSuU9Jsh+7VCd1kFnlUa6pH3oifVUkRemFy8KwhsR
	/jwAR/ptjZdEUFWSNoUiRt3qjoR5t/u36IYyTyU4sYzdsG0Y2RGfKbqBOGXvwvzsvIHTaZTsPLVhD
	1MuQ/RWow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwxw-0047ex-Hj; Wed, 12 May 2021 22:04:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwxs-0047ei-P8
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 22:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4jOF6kNo5CHCszzvlUwJxPosk1
 zE/cCrHAK0Ko0lDHBDiGPUlNTE4WF47rS7ODk3oLC6flQk1pqsllyfNOSKWnpW0yx52Aiv55w2jFs
 tJVq2vtdLXfjLUkXMC6HrqRnW7qjPgPJbTWcP5EOHXZFH617LPqSW3GoL3sJFrX7CDvBvo/SYhgdj
 2BRBpkW3U0gO7F6BJ4FK2KRIC0e8oL/9QRuDLAjmGAnMA8bjrrlz3AaY5pSQX6r1MW5Apf2n1r1CK
 eXlSr3NnpL0Xya1Hq2OCQtrTs1O83kmBBprk37idpzUnHZSuEY2xxnJ4Spp5HAHTpR76ZW1iAnk1a
 QxR9jMrg==;
Received: from mail-qt1-f172.google.com ([209.85.160.172])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwxq-00ArLR-EK
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 22:04:23 +0000
Received: by mail-qt1-f172.google.com with SMTP id m13so3189242qtk.13
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 15:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=V5h6TxlxFaVIYpB24BUkvYoTk4PUy3XWY7ggwVDZ8fGU94SUH5FnRQSUNLHft3vC5p
 +CLYwBrs/bBTbpu+QPiVDvMA6eg4+64UJA4t2R6o8sjQLsTJBVyR7Q8neBTGFhE7XmS7
 +G6ivgWttm7NQ2AR0DVhy7bIYKkO/1U9x0U2HIlMzK313v3WcdXxHTrc01Exo0a7qTLm
 Whm1ZKOeCuGn3ZedR4uOQeKSY7eqlC8J8R5vDnJP6hro2i9CFoHG7GA7ZSyu1RVbUZCZ
 Uk+fTJIzuQ23AprYmRasgtOsCdXbI7pXflK7Jb8+c8BBpS63s8/UR7LPSTPXs3EIUlPE
 Nsqg==
X-Gm-Message-State: AOAM531UFoNzT2O5gnQAWnaCQqP8bPXnR3jog4yDzJsB2uabj0Vp4MvM
 uE4bwp4oQY57h1WTirK0LQAeMhw5rAo=
X-Google-Smtp-Source: ABdhPJyXt53pTALC0p54kK3jMJP1pc+IyVs10eF1V/ahm3B87/ojgtWgktP4KHcBnxn8e8FdNHo7wg==
X-Received: by 2002:ac8:5ecc:: with SMTP id s12mr21866716qtx.349.1620857060754; 
 Wed, 12 May 2021 15:04:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id y13sm1051902qkj.84.2021.05.12.15.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 15:04:20 -0700 (PDT)
Subject: Re: [PATCH 13/15] block: don't allow writing to the poll queue
 attribute
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-14-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19027627-669c-4d72-76c8-bc26777f2b39@grimberg.me>
Date: Wed, 12 May 2021 15:04:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-14-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_150422_494810_197DB3F8 
X-CRM114-Status: UNSURE (   9.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
