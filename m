Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66FDC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwXJjEFN/7cqDWysA0tH6QYvShNGebLBU+1svct73Mg=; b=NaBRzWauQgr36P894smbhC/Vx0
	hehvSpRzpZQuvb29sSHu99K3wZaBNiFHyeoPaFs0+XENyn0n3F4EHEZOahmPAa7JAf+g0BE+txyeU
	H/ny/yBK5EdunqqUDm/QxenXfEHZ9i0fP/K+Nlwg4faWVUMBME/mPUtaxdH8oc+wPYgGRbLomCYo8
	FpIWSty7ZMxaVK/48OVseiY1oMiRuZciYtUcHUyuQGv7Dyjeh9Tfqeqy3OTAfJe5XQIr5BrZJSFZv
	wjmI3t8T6SuDhNcyvPzeqqymI470Vn3XNe4FDhMA7y0D1rGzTg3YmBFksGZyzoK9155FZJuOr9R1Z
	ZS/S17qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSqt-00000007090-1XVC;
	Wed, 26 Jun 2024 13:38:23 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSqp-0000000707M-2nBV
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 13:38:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4212b102935so6143165e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409098; x=1720013898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwXJjEFN/7cqDWysA0tH6QYvShNGebLBU+1svct73Mg=;
        b=jYqDtIN0eTNMre8UEL21KMlCBKq1a+po1fF0oSRHZlpUyM3RIu3CFY8tKNIHzTplpn
         Senroe3xbhWC2fByRdWgZBqUdIxhWDgGLLYGcmNG88Bby2QZDr9Uucwls1k6bwlqBe/6
         c/Gn+O4J37ltE97FzxOP+rzPPUkhrPCyrQvJqzbb+yYYoDCN7zvJx6r++NhragifMdNj
         8h2r2P6qkKsm5cPAi0TnyIOTWujmi61rnkzE8kPi6AysBuUJB2DUM/CO6d46kacqSgta
         z1YX15vif2ebiPFBIf3QHZbrlDdmXD10xIaZLb/tuNeKTxqwdaaOwsuc4mu2/90eVcXh
         0Grg==
X-Forwarded-Encrypted: i=1; AJvYcCXWalJDvFC348WMBzsC0jpV+PXnz1KsQLwLKuQYpQ2qcCT53XF1Liglg1YSV5+oN2fI8M1H+QG43tLrPnXhbihmONbtgc11S0a1+8DcAoo=
X-Gm-Message-State: AOJu0Yyr4nCYL41kX2VGtHYxMfwR1OMXRnZ9yoGF82AyMuXqAZZKcBMn
	jQubcqyTOEtFZmI5W2Aqlq8vLpxn//p4dUJF2PTc98GFxt06QPeG
X-Google-Smtp-Source: AGHT+IHeuaFsdGyTQTSYI9ycXjo8r2b96OJck/SZmMp4ywu/YFd2+Ylp7krPNPEvqyUETC1+M1FJmw==
X-Received: by 2002:a05:600c:1c99:b0:424:8acb:7d55 with SMTP id 5b1f17b1804b1-4248acb81e8mr84656775e9.2.1719409098061;
        Wed, 26 Jun 2024 06:38:18 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8246297sm27115315e9.8.2024.06.26.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:38:17 -0700 (PDT)
Message-ID: <70216250-f3ab-438a-b85b-fd11c4b8ff6f@grimberg.me>
Date: Wed, 26 Jun 2024 16:38:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] nvme-tcp: distribute queue affinity
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240626121347.1116-1-hare@kernel.org>
 <20240626121347.1116-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626121347.1116-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_063819_770036_F3296CC6 
X-CRM114-Status: UNSURE (   8.06  )
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



On 26/06/2024 15:13, Hannes Reinecke wrote:
> Introduce a per-cpu counter to distribute the number of queues
> over all cpus in a blk-mq hwctx cpu set. The current algorithm
> leads to identical cpu affinity maps for all controllers, piling
> work on the same cpu for all queues with the same qid.

I think you want to squash this into the former patch. No need to have
this separation.

