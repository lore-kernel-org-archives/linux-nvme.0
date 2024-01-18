Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC75C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 00:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43cXtXkjNNAjs9RqNFtvUOxZFykRoN/UIFlmIiPzR2g=; b=Q7nJHOIRboSPn1KBN7BQbmZwgS
	A0vxZGUWASt9n2eqU7dLTlzMX+zMo2Ny0JBV77hlv+8zbYsouQ/ek/jI8hq7Cuh9vUAp/DHitgCqC
	NBq5Wh+v+8kaf6FkqiWKsrus/TtVHW9OKOu/GKCBc9Gh73wQh2DwYOnqtPXiDXYv2cPU8uVBcIFYi
	nbgZJf1fnKu8e2f+AYugJPWq2J7y2Dv4A69+ivXpy663ff+EISKW1zHSxc0Gnh0l7ObLvUaBGq+ql
	cduXRMGR5cuD41F086xlOLKh7Uc3leZQblVO34kG3V7APglxnt1VLf4FJfJsJ3U2b9cdXa/Icr35p
	kayGyBdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGQf-001Cax-1r;
	Thu, 18 Jan 2024 00:38:45 +0000
Received: from mail-io1-f41.google.com ([209.85.166.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGQc-001CaW-1s
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 00:38:43 +0000
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bee8f7df35so299687739f.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 16:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538320; x=1706143120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43cXtXkjNNAjs9RqNFtvUOxZFykRoN/UIFlmIiPzR2g=;
        b=B29OTrlCjkgXrJKUMT1Yf1MlNJ9H5VPnhyQec39vxVMW3FVNsEeS6BsBuQDoRAaiH4
         q8pC065nInrqlGQ2MAly2Rl4chRFiTU2viaU7tBZsP4GqywDZDcEqv2Ux5012lKaBPT5
         4q+mZybgfMsW9MFVM+IKAhClrKjEOyMnb19j8RsTA+ggq18DoiYTX22i8mOX+KMxLt90
         2QGnK2T5KMi7XKM2dUFpST8Bwe/7hGyXfsPKe0M0UV+smMCnkZxxQPH0dxCzNu3EE+4B
         q0/w96l7Z2BELdW6/xkmcERfSJul8sJVFCGSsBWe3OXMwC4eTTdtrEppNwGOv8la/u+v
         5O5A==
X-Gm-Message-State: AOJu0YyfTcN4VK37mAgWC8WBeaLFBkYjv39coKJQcgrQ9sPqaPl5CR91
	tWz69yPFbyn+TK/XjlkjH+xzoPjsQlV+QhbndcaDunIqmMR2Sgcd
X-Google-Smtp-Source: AGHT+IHUX6Yvw4cRZZSJ8OOKM9yyNwN223wFLjz8VnjEQWLnz1h/XTUrSKYudP6Rr2kmX7YlNlGM0g==
X-Received: by 2002:a92:cc01:0:b0:361:9667:39f0 with SMTP id s1-20020a92cc01000000b00361966739f0mr162412ilp.35.1705538319865;
        Wed, 17 Jan 2024 16:38:39 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id s10-20020a65644a000000b005ceb4a70483sm217397pgv.7.2024.01.17.16.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:38:39 -0800 (PST)
Message-ID: <c6dfb4f5-10f9-461e-8743-b730a8384f95@acm.org>
Date: Wed, 17 Jan 2024 16:38:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_163842_644046_E2951515 
X-CRM114-Status: UNSURE (   7.26  )
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

On 1/17/24 10:43, Jens Axboe wrote:
> Do we care? Maybe not, if we accept that an IO scheduler is just for
> "slower devices". But let's not go around spouting some 200K number as
> if it's gospel, when it depends on so many factors like IO workload,
> system used, etc.
I've never seen more than 200K IOPS in a single-threaded test. Since
your tests report higher IOPS numbers, I assume that you are submitting
I/O from multiple CPU cores at the same time.

Thanks,

Bart.

