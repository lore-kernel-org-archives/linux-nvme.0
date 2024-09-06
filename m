Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE8CE7AE0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMLIxvKWlpraeTn5+hEPKR8SaPGdjlDXCcBBBze2GY0=; b=w11svyu/cqM928NXV5v0F0Dsb4
	wSkxL6ydgUbKY5MscZQIf0/s2wSexc7zmuKvIgv6zBn1L+A9cL20PDBxiJmNDk7ST4OfPdBVd9E29
	6ejS6cc3yvj0Vur5kTkxT5C7ZCVvFHOgemE1n85duXsc/zsiTE7nkXRon8rRLmx12kmRqfc48gC0f
	jKv4gEK/x4uJxEM/FOwNXUVqE0gynikB/yK0v5/oyTYECjbtdilUgRznKo5kuWLsagAZgkZinbf5M
	5hRwR1d/TCUDNeVAcic9jk/zl92KRFzQrSOZiclrafbP2rdJLjNwrf8hV9gnI8FnKPM7caQ9iCFJN
	716YrO0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTYp-0000000B859-0TjH;
	Fri, 06 Sep 2024 07:39:15 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTOr-0000000B57P-3B7F
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:28:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c94eb9822so12490365e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 00:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607735; x=1726212535;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMLIxvKWlpraeTn5+hEPKR8SaPGdjlDXCcBBBze2GY0=;
        b=hs/2cXi3NdXgBAGj6zYFACOCyEPhS48xugjHQQs2knC+gZ3xtyLQhybrdUMt9HSmWZ
         ML186tRfA5XJ7I5DbmNNyn+bj8mIFt9vyIFkBljWzjIZG74+e7NXkfmelhpIc15XsOJd
         tC2uYVWfN9VUjIOTIYPeoXPYrfedefv9yc4o4T5OW7nBz4wCq5PyNme3yC3DIVpfkUG+
         wym0vbvehT7Mfd2Ihs8u7m8X/wbp/QTCyvjy48NZpjdIZsfDKbmR2isWs7wESePQAAdT
         zIqlxrSb8SISfU7CbHCg5ccismwkXZPbfEJRHdvE5PUNUeMeefICqWrgtAwA+TztPc8J
         nIYA==
X-Gm-Message-State: AOJu0YxUmhh80URK5c1dL+lY9ifH2HtjXgA7ruSNVO606dzNLdjZ1Lty
	pfs75AYB1ewji7yFxBYfJ8Mgd9S6J4ckKR9L0K66fIi6TVig0dd4596cWA==
X-Google-Smtp-Source: AGHT+IEPUYUnDqZoB6P+skOAwB+2RVMaXpgVH+qSdlwuNTkO/A6TQum3dSepWivU9yEp04DXf2PfVg==
X-Received: by 2002:a05:600c:19c8:b0:428:ea8e:b4a0 with SMTP id 5b1f17b1804b1-42c9f97e290mr10381805e9.14.1725607734540;
        Fri, 06 Sep 2024 00:28:54 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca06005bbsm10957895e9.30.2024.09.06.00.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:28:53 -0700 (PDT)
Message-ID: <a58ae8bf-fffd-467d-8c37-d94217eebcb4@grimberg.me>
Date: Fri, 6 Sep 2024 10:28:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: get rid of a high-order allocation
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20240826120333.529128-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20240826120333.529128-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_002857_830225_D3303D05 
X-CRM114-Status: GOOD (  11.98  )
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




On 26/08/2024 15:03, Sagi Grimberg wrote:
> Allocating the queue commands array leads to a high order
> allocation.
>
> The current size of nvmet_tcp_cmd is 704 bytes. Allocating
> 128 of those (default queue depth) means that we are allocating
> an array of 90K bytes. There is no reason why this will be
> a single contiguous allocation. Change the allocation to be
> kvcalloc instead.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Hannes, I did not test tls (I wish there were blktests for it)
> Can you please double check that nothing breaks? Given that now
> cmd->recv_cbuf is coming from a virtually contiguous allocation
> (which shouldn't be a problem as far as I can tell...)

Hannes, can you assist here please?

