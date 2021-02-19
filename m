Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27044C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 13:41:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E5164ED2
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 13:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E5164ED2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UIaJDxWJgdp1jSFFl4yDpmfs6i6bViwcY9Rz+yO685s=; b=voHAYb4yyFdEuqGYIpBrK05bO
	qL+EiKtyVsl+yEtPBVqp2t/m2AmPI49/2ylaA9vWkwdbLQ4Hkf87R5TZ0pAWOCDxO/xnyHEAp2+VF
	LiVFDyzhL94nxuHIGDHPYMowzIidYkFbgrSE4Ui0oGawB3VmQw7evypvorg6x2N5drhJQnj9BmVnL
	Dvwdd+aM8s5wUJOoYLN/LeHgy6qW9Rtj4EAEdxoG2Qb4mSHZDLfMZzcnKgffXv0ip6DQToMZzshya
	SBi8J2SDpYGQEDddC52UFFG/xsCqCi4XldKd5AMiBB/vvWT3RFbzoEOOSAEgywZZeBVshmhiULnFJ
	DzVwEngEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lD60y-00073I-IF; Fri, 19 Feb 2021 13:40:12 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lD60w-00072s-6Q
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 13:40:11 +0000
Received: by mail-pl1-x62d.google.com with SMTP id a9so3376396plh.8
 for <linux-nvme@lists.infradead.org>; Fri, 19 Feb 2021 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PozDEM9kP5pBFkg36mJjr8T8BjM1aUeLPSpcF1ah40w=;
 b=cCASVJvG1W5EJei9ZeBVqKU2qzdhQFJaiSR7/+k8ep4dMxVB3Mv2iVo0VLNqcTDI2X
 pCirkza7kOY+q1RnpezjGLN8v76pA/g+K+6u0sgamBK7shWmZCdwwFwyp50CnB43QOHb
 a8urXbge1KWaIen3X2n7+PVrPjl/OzUbnX+83jdE/b1LijzaC0YvTcPy6uEp2r7PSH4U
 d+qVrOfA7XY0F6zxVvp8040pH1Nk/+ZEzZaAYrSyRLyLQm++kV6ErfthBDU5BwPrWirz
 VuxTopv8TqsUK2DDozn2PFjCTUqxUTqWZp1C81ILntrRtBWEK9WG3havRRe19GlxLrX2
 NBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PozDEM9kP5pBFkg36mJjr8T8BjM1aUeLPSpcF1ah40w=;
 b=GImJxNmqhQneCHUj4eW/DPm0/W3XMw2m6aAoEJspCT8g9CvZeZesr4h7OhfrTDf7F3
 /+zwZhmHTZ49Rg3eeo9e8P0xTv126ACB+V6rZO9G/khZG8q7w41hIHPRu5fAFVZm9oiK
 3L/74wM4iXmc7yxchbmV5Hqq2+J7CoWprrPF1qYyzaK3LLKNFRZHhb+X0BkcuKNWyNpn
 StmhjYQvYOp8Xg7BkUFa5rZ5MW3LRb3CaB1U5C5/m9mNdi3oN7V+Dtt11Q5+dT4Hod3E
 d9jT0iN1LVvvxspDM0oDHnbbOeZbFQzlCklQf4ZNEpFYTeJ/JPuAS2kQMp/o27/BKFSD
 xhVg==
X-Gm-Message-State: AOAM533yPMsuVdBZ/WSLZkttnB3ETgCBKuEwM3kyvhhB8rwiHlN6HWS6
 eUKjtNT7ZLnL/VC2n6LlI8+tww==
X-Google-Smtp-Source: ABdhPJxsQLYWTA+NgMdLmi4kmhN/kc5Muei6d7Sqk7m6fMS90LhU36Fs3SrcGH23G5w7c8//pCLfYw==
X-Received: by 2002:a17:902:e5c8:b029:e3:9201:5121 with SMTP id
 u8-20020a170902e5c8b02900e392015121mr9103446plf.84.1613742006027; 
 Fri, 19 Feb 2021 05:40:06 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id t7sm9465378pgr.53.2021.02.19.05.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Feb 2021 05:40:04 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210219063726.63728-1-chaitanya.kulkarni@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <80fc53d2-4f35-7c72-5cc5-3ec13c5ee51a@kernel.dk>
Date: Fri, 19 Feb 2021 06:40:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210219063726.63728-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_084010_266077_FD057097 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/18/21 11:37 PM, Chaitanya Kulkarni wrote:
> The barriers were added to the nvme_irq() in the
> commit 3a7afd8ee42a ("nvme-pci: remove the CQ lock for interrupt driven queues")
> to prevent compiler from doing memory optimization for the variabes that
> were protected previously by spinlock in nvme_irq() at completion queue
> processing and with queue head check condition..
> 
> The variable nvmeq->last_cq_head from those checks was removed in the
> commit f6c4d97b0d82 ("nvme/pci: Remove last_cq_head")") that was
> preventing  poll queues from mistakenly triggering the spurious
> interrupt detection.
> 
> Remove the barriers which were protecting the updates to the variables.

Would seem prudent to just ask the original submitter to send a v2
of his patch, as that's where it came from.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
