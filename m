Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D128C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:14:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE7220897
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AahWFG61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE7220897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=AahWFG61/rlrlozA8nOu5EbNx
	QRPx+Z+TghCYLSRZyyjBvNLyam5Xj1K1AqWeSmIXbvnZEmsnr4/W7DBBGJrXHSNFM9YH93p+Qhs4q
	Bk6FqPrfDMBDmsaDse1zLezbv0JS9Slk6dds+rYezkxjSRkyoVpKr1GZMCBM9KbMkhcycgMRt7ppq
	zzcaDcMuTKjgABjdrlzgQeNhPp8blavHszjZQfzRW2NCEhfhpejWRAeU9BSI7GrHEJAK9s3WU8u1m
	xEwZHef2Ns7kYfP2VrxsE5PLoBJqUssjHvpceDl0FtCF16BkCuNn6CovYVlo3jfqn2xRj8WiPR67O
	WvawYvO0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNAme-0000BV-Pm; Tue, 29 Sep 2020 08:14:48 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNAmc-0000Ax-JE
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:14:47 +0000
Received: by mail-pg1-f175.google.com with SMTP id g29so3246434pgl.2
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=eFR61W0Remd1Hcym9pyzkrmCAQchQn/HULEPr12NfcGgIkfe2dfwiJxqF+VgwpLnXL
 vNZihgEL9QbwXcGBOdaYHbplBxeIGugpBTUmsN9qdiBvi8yqy9B5SCGWXO1RqTX0HnCg
 yxiaPwOIusHTNoWDMpUVl8392YcVWYjKneBlLtL47hPhC//EE8fXguWNthQlIH1tO+m5
 8XJXPWtVFIEaxhIc95kfHjd01c/i/3SbwzRT9bVfzrd/V1GuHqNWWVjvZQUzzSNVtANh
 ZT4bgjh4fO9+tAVTlexmvwF/2TirbcUB52HfpQqgkj1lsqPJMBJhQxYnig9mYdJ6wzvB
 3nrQ==
X-Gm-Message-State: AOAM533dA6t8rKqiNZD0Tf02qHJ20PEdO5puZ2eNRscjFSba2su7vml2
 uIv0W55jxTylwmjjlockJNk=
X-Google-Smtp-Source: ABdhPJyxpBZd5gDKDEFKF7nTD72p5mg0bBklYnrG+VNrKrXBgtH1KoVMJOYAFRaelIVZgzXL1NEEyQ==
X-Received: by 2002:a17:902:8ec7:b029:d2:42fe:37de with SMTP id
 x7-20020a1709028ec7b02900d242fe37demr2247420plo.23.1601367285551; 
 Tue, 29 Sep 2020 01:14:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id d12sm3644988pgd.93.2020.09.29.01.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:14:44 -0700 (PDT)
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
To: Xianting Tian <tian.xianting@h3c.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de
References: <20200922062517.30031-1-tian.xianting@h3c.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2b9e078d-7fb9-804b-cca1-b5b1197d1b4f@grimberg.me>
Date: Tue, 29 Sep 2020 01:14:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922062517.30031-1-tian.xianting@h3c.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_041446_648435_00BE5B04 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
