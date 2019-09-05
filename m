Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065BEC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C222067B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fb7ZVMJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C222067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bUwnvFVYdw2Vb/JSs+fkBhMY7j5G4//wSRlbtxKQivI=; b=Fb7ZVMJmXovrGtdVxD5ASuNfn
	AbLEUcJCTl81rLUeLTzxCB6pFLY1W0s2TSxto/nRJgDwRt96dbHUVqSfILPPd5fUj+OU3EDyCGWQ3
	Q0IKAmMk3kkN0fFwTJ627KSEgSN/i5jfDNWtEvMlCczx5QQbH3yya7j35HmHBsYG3JoVez++rIvUP
	REPZiwTu9Baas5XCYKHwuBCHc1bhny/a1Y0oahihTe1nEk1FYVihAGFVkAS9IosvAfXaty/LEWkF+
	sw6MYjL6qkvRaKKxODLFBgf+Aqko2OTO7MGSBLjm2Q48+ortbQJ5d2mvrhbwd4HDlMPIM9qAThwgn
	B+gQvaJhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ybc-0000qc-3m; Thu, 05 Sep 2019 20:43:48 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5yba-0000qA-97
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:43:47 +0000
Received: by mail-wr1-f66.google.com with SMTP id h7so3264350wrw.8
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 13:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y49iptIzTryGCmBjp40qCRF6Cv5KQyxWSU/eFZY9NdY=;
 b=PFM1HQmVvcCq57iquF06iFmHm6+u7Py+C+3jtnUfOe13ui4h7CFNmhiPL83DWNx7iY
 vuP4W4cBa0ywDnPqonAsxAwLEOkGaVhJVNVq92R5YJeMZPceg4CCBw73PLfLlk/3cqie
 4k5j4u0lQ4EnA9Iv+xSaCdPaTsyFZPc4pHm/nuQaANKvWlkjLU07dBO3ovYKgBPywdv+
 07kXl+6ihxZy31YIGzN0eS0uGyX1ULWUQD6NLjPftJZlBUB9z6TYq5vwDl9t4UUUka/b
 FCqxuiU1uvQ4jkYZl9Nx5p6ZZBOldn2Ucgomen40nYfnLZjIO/HkBz3PkbPg2dHoGIiA
 5wJQ==
X-Gm-Message-State: APjAAAVWXEQIH12NBZ3wbeOzJf5ZYg+22tIhIZpO7kRW0s0g8F/LPhO4
 WM/zGaRtKNAVl49VcrlI13w=
X-Google-Smtp-Source: APXvYqyD6GGiI04+pnC6YVNw2EkVwK0R0lMxmi2mkQIkvNlNgej9uFCXz3y17S+WM2OnJZNadOYW0w==
X-Received: by 2002:adf:f543:: with SMTP id j3mr4452686wrp.243.1567716224647; 
 Thu, 05 Sep 2019 13:43:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id o9sm4612857wrh.46.2019.09.05.13.43.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 13:43:44 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme-pci: Free tagset if no IO queues
To: Keith Busch <kbusch@kernel.org>
References: <20190905142607.24897-1-kbusch@kernel.org>
 <20190905142607.24897-3-kbusch@kernel.org>
 <5183cfd8-5143-2378-13f5-02c7a70bf3e3@grimberg.me>
 <20190905204017.GC25467@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <04bc6557-d5af-af6c-c8c9-7d8cd0def4f2@grimberg.me>
Date: Thu, 5 Sep 2019 13:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905204017.GC25467@localhost.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_134346_323304_268C9938 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> If a controller becomes degraded after a reset, we will not be able to
>>> perform any IO. We currently teardown all previously created request
>>> queues and namespaces, but we had been keeping an unusable tagset. Free
>>> it after all queues using it have been released.
>>
>> Is this a resource thing? or is this causing actual troubles?
> 
> Yes, this is freeing an unusable resource so that we don't need to
> unbind the driver in order to reclaim it.
> 
> I only noticed this though because PATCH 4/5 needs to observe the cleared
> tagset to operate correctly.

I think that it would be easier to understand with a cover-letter
explaining the steps and why they are taken.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
