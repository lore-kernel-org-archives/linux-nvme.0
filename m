Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD18C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB6C60F23
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AB6C60F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=PJAbUuukifjvGugeYFJCyLO8rD
	kZxEccqEJr4BIkXlY6LqdjrgVjKXm6PlR+O/7FO+orlVPLPZ6vD0KxzKNLAteoEe0Pd1qvVXSyh0w
	cqnDx+KolJsxnHhDrtZ3/VCYrVxGwlfWWaUu/lDZy7kuRKPTu8pUrqBcPaCvyovyAUnsflBPRLh9X
	UpvgaKr4fbWH3SPZYu+AH3v0b6jD306FWFPC6BkwgOppc1cT88daiHTqZhOHBfZ73I5eGx5nGgXiW
	AMpmV/xNtHeqfdLiOG4Q4bLK0LGEcQKmCehNDIulKtNhn8CV1erzQPl77SeOc6SSliTZTXb17QavF
	sZ0qgCbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPlqw-001kmN-9Q; Mon, 13 Sep 2021 13:18:30 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPlqr-001kjU-U5
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 13:18:28 +0000
Received: by mail-wr1-f43.google.com with SMTP id x6so14633486wrv.13
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 06:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=z0vKaGsnbJmuMiKBXbB0TNg37csz0RzWuycD659d5W+EKHJvBt3ITDwDkwuCy8TQZr
 lIaczHoCmIivnlQKetdFnKOopfByeTn8/lUtsH7bbq0RWa9/kqiEtr+9wsMcDaPChtKX
 zbr7J3BXStSLggTWUaJ6DZougJXnqCDQzvb428OqF23yzu3/KRqiOH5iwFZopBh9Oc9/
 lP9gwGwAgCVYOnbY69qwN4oYLkIrV4crGEm5RxYgjP7Jc0pTRA1OHEw/EIqzPiB0rJVS
 aWmi+lSfSR9KDatWBAyh9vp0IhlW0/C4G9nitNKZhf/3pe+Bb182WhUvgopPlXC6U9SA
 6vWQ==
X-Gm-Message-State: AOAM530tytz4Jc9uGM8LtJx0J18yDu1ecMAmoR76K3S0GwTtlq6wpWRv
 rdGso0gL62a3b3clTStytKA=
X-Google-Smtp-Source: ABdhPJyvq1YZ29jyMPrAeiPwieH1Ppp25tRgb4kqv/5IbJ8qem/xvNBF88vHAv20dclORuRv9/sC4A==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr12263202wru.436.1631539104292; 
 Mon, 13 Sep 2021 06:18:24 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r2sm7873142wrg.31.2021.09.13.06.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 06:18:23 -0700 (PDT)
Subject: Re: [PATCH 05/12] nvme: add definitions for NVMe In-Band
 authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f3747df8-e695-3363-30c9-da12074707de@grimberg.me>
Date: Mon, 13 Sep 2021 16:18:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-6-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_061826_004247_6AAE8A69 
X-CRM114-Status: UNSURE (   9.42  )
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
