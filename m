Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFF8C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 04:35:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C58C20720
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 04:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uhFrGmDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C58C20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ie8QsRVBuoBAqp5+O1b8nMhwn3QdzYRsjtlVKw32z9Y=; b=uhFrGmDOxtI7oFn73a3Tfy+/6
	bz9ZLa/3Sn3Z6bvn0Pq5bXQOTBEQr5w93EIuXnABvjyZI26WY2C41R9xlVFMrvd+CccRBBQGlw/6M
	fUvj3Hy6Va2ksCBT5VqclsR/OFubqpLNJuRnLVrZPTdkk0d82YecN07kdRFkzhlCkxji+vVAeuqyt
	LG31Ajg/HhSarslhpZ0oFouJtbsRGjGBHB0VXGmcxy3AmVbJCi9bJDFn2YaD2R4UdbmXO8NBC8kmy
	RDGqnkCAFD4Uc8jPuamuxsFubv+5dg5GYWIONfuKTxiG7YElb+QrQtugv+hxSELRXYyDLio58sIvi
	TCk6pNi9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtkkp-000535-LU; Fri, 10 Jul 2020 04:35:19 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtkkn-00052h-VP
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 04:35:18 +0000
Received: by mail-pg1-f195.google.com with SMTP id d194so1941150pga.13
 for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2020 21:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YBox9EGZ+YKWpNVqzUi7kHDn3y2d8dUIOppvqMiIKtU=;
 b=KG98dL80/r0tb7jY4OibZGcfFAe36I+8hWhvYG4T2dzQBq2dp4aisQngtJT4JNq7B8
 AGXaKqcNEqcT7qYgQf/n/+ZqzOI8EjZgjtWwK649sH5ZlaR8S7MIGRhcKbxo5V3PjWUM
 yQbU+LxIVVJA3H9FfCd1TEhlx/RxUjtrro2PwcfWPENX7fkiB0TVY+eqe8zUOkracyY4
 UBDeCXTKNrMUjK9956Lev4x12d5A03h+GWS43AMLPUuHvMOD3pQxSTQWOtG2zz0vug0S
 ognQZOfduVAeKT/clqB0/3g/WLPbg084rXO/lth0XTXe+bHE56mYOAdEQlRMCMI98Rp3
 aW8g==
X-Gm-Message-State: AOAM533kbfWudPLp9A0lmo1jZHrkSGc34FI8v4ZmmSFuprv1YTQl3CDA
 qc/30uS5jGRmd5/upgoSRWw=
X-Google-Smtp-Source: ABdhPJz2UT/DoZqGDfeqchRC5yetc45x3mqWYIKbZ2N40EMIjlpJx/ocNynNaUIn3hVIb1iGH6jxKA==
X-Received: by 2002:aa7:9609:: with SMTP id q9mr22999761pfg.269.1594355715110; 
 Thu, 09 Jul 2020 21:35:15 -0700 (PDT)
Received: from [10.92.82.19] (h208-100-138-50.bendor.dedicated.static.tds.net.
 [208.100.138.50])
 by smtp.gmail.com with ESMTPSA id f72sm4399544pfa.66.2020.07.09.21.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 21:35:14 -0700 (PDT)
Subject: Re: [PATCH v2 rfc 1/3] nvme: split nvme_remove_namespaces
To: Christoph Hellwig <hch@lst.de>
References: <20200705075935.506535-1-sagi@grimberg.me>
 <20200705075935.506535-2-sagi@grimberg.me> <20200708151752.GA26154@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c7c6c2da-8408-72e7-84ce-bf4f7a886ca6@grimberg.me>
Date: Thu, 9 Jul 2020 21:35:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708151752.GA26154@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_003518_053738_D516CAB7 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> I find the split rather confusing.  So I looked into alternatives
> and found that the state change should just be a no-op for the PCIe
> reset case.

Looks like the original version, but the only thing that bothers me
is that in the reset handler, if we failed to setup any I/O queues,
we'll put the state in DELETING_NOIO while it's not deleting, I think
that the point of allowing this is to have the device still up for the
user to analyze and debug it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
