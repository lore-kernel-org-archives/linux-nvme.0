Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B20C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:31:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4626F20774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ai8NRHka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4626F20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ai8NRHkap8nomVCTpuljmKXcc
	nCc9qYAC8cWWMbO2VJ0GeRLOGM7oxm1ZpZB3b9IW3EmGon4fvvfdIDtAG5TO9yHgLbq4MKbGydaQl
	+xmpkuPx6+Qk9FIXM7BUwl0mHuBy7ON5JJWmi35QJ8Ka72oHAljJlH3/gxLTIwrlfR8Cl9j3pssHO
	ZmOSzZ7+8nyUw3HZ+h7zOy2gaeqNLDY9cJjCEyjq3zK7XY5NVl0VAHLN2Ycioe/oNPeVTrHnuMy3/
	nP0BtF54kVQiPN784kA7Fm3wfOCWmOh9qG6RhVUTUPb2fjtXncaKYbDMMXupC+rjGr+9AwOKJPFRi
	/7I9WF6Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6eUc-0006fb-AQ; Fri, 14 Aug 2020 18:31:54 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6eUZ-0006eu-Ub
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 18:31:52 +0000
Received: by mail-pl1-f195.google.com with SMTP id k13so4537337plk.13
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 11:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=gwr/UBn8z4LG32rPJYVNtiHxIDgJ3MF8vAvf51A5JAptdEUAEG7sPqP7lOb8x1l3Db
 pqqPBtPo0dihH3OBCBvaUVSWT9ZME9bfV+VSwp/euBNReenI8vmoVj4xfE1V+rPKUj52
 Z89UC9xHL1gWP0njC2Y/JA9iu5WxoQcW44AlfiXuZGBD3UYfu5ix2tHmSSUQm2G1FlKL
 YKazSI4wq31i9OrJl9620o1HyyvYGGRH9uwcbYQxsKY4qkUIrrVspQpU+kmS4c1r7VkX
 I9hTouQnuF4rY+if7FxLE9vZYQNDcer2MtihQ+IJ9aUiL8NuNFbcGUZ5416yzKEaXrLa
 uFMw==
X-Gm-Message-State: AOAM530/gKFrSGBpMOoxLp8wyAC9cx7ffNLmW2ZCQmqvnZlyFPEP8u/Q
 q5+7MsMabH2hBqQ76qNmedQ=
X-Google-Smtp-Source: ABdhPJwZeZ6zZ4oDKfva2fujlCXWWHCr1BG59AbZB8usGI/KbWDFfBkuXqB0p/PVAUpndotyiRXYBA==
X-Received: by 2002:a17:902:9a06:: with SMTP id
 v6mr2993364plp.57.1597429910708; 
 Fri, 14 Aug 2020 11:31:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id e13sm8759029pgs.13.2020.08.14.11.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:31:50 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: rename and document nvme_end_request
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ff42519f-b0b8-c43e-10ee-3d2487365f83@grimberg.me>
Date: Fri, 14 Aug 2020 11:31:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814151528.277465-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_143152_003954_2FE8150E 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
