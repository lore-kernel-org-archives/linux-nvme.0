Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC769C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=y37EsuW6KVHbSgnCDBAF5Mg4sj
	UNol2cwgNkTN0i11f2gtuYbi1o2mVmlkRCpYqmnwsoZp8srBNJVRSRoeYuIY/wVJ3mIGwHnAcxCZm
	M7ttv4nP79PkrI5Nu3dcIXx+hQGgnOznujJyWKAS39+30o9p5At9h1QjXr/NabilsIP1gv9YeTz6f
	2BsQTqSUDJYZEk+QdXdbBznksfyTRLfiR7dOvrAHAGOVyj5AoLnGlSIiI2Y16wmDFJkMh2o1Ave3+
	X+7rbEI6PPUzGCsDPjs25jFoLYBylsvmGgH1J8jYwskAvcHqYZ1Ov6aQ0SdaPIsykPmz4sj0LPy0W
	MHeHvE3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5a-0000000AAf9-1WIs;
	Fri, 31 Jan 2025 08:09:22 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm5Y-0000000AAdb-0ejH
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:09:21 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so17072485e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310959; x=1738915759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QkyjMHMv/xgnQJX+JED3DVtvvYAtx6qZOWgnd9ZNurRGdk72/oPPH0ULv9UMcxW2kr
         4xRTAxeN1DQl99H7lgRjf3QeuwKE7EJWI8bfZ45iR7/syF2XRcvt6gLEqgbLJ+O+TJia
         U9c8eZDVfeI+3B9jzGVtCfIfooV0mo+JrLby2UuJU064te1T2uRIKt3pNFr6cyMpITmn
         1Ks5u5qNRwA31ZM4OwToIftiFFAjVbFPMVazgOzxmc2BkV6jPs9Wt0qViTT7Iub5Pfrp
         9v4FweTLKQ4PdoSg75OlJfAuHa2SDQlJIeTGfzCMJiW0VSOv1xmla7AhubhYW5FtszQo
         FgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmjDgcZXKSpWAcImYd6Q+Me00X6P9WZ+Q3KQl85NkPcDAEQD3dFMfyJQuqkb0Q6e+NcIcCjbQkTdHs@lists.infradead.org
X-Gm-Message-State: AOJu0YzjFJ8UD4xBe49q0mLZsbUxksYJDXy5WJrOOOvugi5MdLbBm6oj
	kBHOcmU5TdUdKAKuNcoxh+Ps/FKDnPeuPomD3p1+RkXpcv9g4Wr3
X-Gm-Gg: ASbGncutXqv+MmDTDynZ/qbKcfJd9m75cJT1cSOeMZktNVrMd3K6ACfLIOAcZlDXLJB
	oQe/J/qzMUsTE+e9ufJaguVJLWYrZRWaxYpG03cyOn2hRSUyaFEPl97lPdqpY+b+ysy4+zNBo4m
	T3yyEqydgewZPvb6/xqwcjQRxmmX2wKAtwgdPGgwmePbV+TcOTUg6x2QI9PbzKPezHcAfnKLSSu
	4ToPcnTHTM9A7pRfx6s4QQQ0P/o1FSuxJTOtQbB9aTIUuhJSg/NY9JKp+kdF75Ps0t/DT0Lbsl3
	wr4iFiA+WzFfHg5S+tPWsfF0oFmNIhW50nqKTCBX/Q0c0PoWq+g=
X-Google-Smtp-Source: AGHT+IFRd1COH4ffU5+pBFd8kF8BxvX8bD09TPD6Kz91rUI+X5t5CDX983eL/O/SGdvAqyh5EOSmQg==
X-Received: by 2002:a05:600c:3b9f:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-438dc3caa6cmr99103495e9.16.1738310958584;
        Fri, 31 Jan 2025 00:09:18 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2f73asm83240585e9.24.2025.01.31.00.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:09:18 -0800 (PST)
Message-ID: <f8f17b22-9d1d-4929-8eda-d0c2a679dae0@grimberg.me>
Date: Fri, 31 Jan 2025 10:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_000920_187795_E1B47B47 
X-CRM114-Status: UNSURE (   6.64  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

