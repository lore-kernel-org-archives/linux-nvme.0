Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B86C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:53:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C355208C0
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nV84vXl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C355208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=nV84vXl42cZAhdnjRypmL+ZNJ
	yBD30PxaRYv4nT/cpAQ/3kE/3aB8oneDIGDakpEolhZKxqwpapsAfZy4dCr2L2WTyaoFufUK7+K4U
	k3slBYH4m99RhmAmGicGHdcPT/zbDQPczX2DpS9famx24gLMjxEDB/BEFXeIfLC+L8qkqeOXUDKyO
	FOCZOZCJu2ME7O6605BbAv3cj36hKyUiNGUp9Cpl8DhuyRgZC5/5Wm7YcsigzBQBuyOdOy1uWymez
	K1qukRE5lHlcvyqDVf1iCovqCrCeghoBKjlyweE4ycOK6LEueS7b1bZ4tG9OsGWH+cSCWJSa91dox
	hdTMEJkeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBN6L-0005l1-0O; Fri, 20 Sep 2019 17:53:49 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBN6I-0005kh-TX
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:53:48 +0000
Received: by mail-wr1-f48.google.com with SMTP id v8so7675991wrt.2
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 10:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=F+gdZpvxyagUpm73AiW+C6rHfwIMTE4rx/gVt4K6rASVCeYyFcUlPECJ8fBP+YqCru
 nMdqBWP/mvM8Pu0BkyhHixAUu4oUdXR6m6w8KhsKk3QU4qJ9mi3wcWR9XOZlY4v4u88m
 TYMdxz9oiyZO24Xxz42hGFu6xXonu26Jv8UcHfateJUFU+ACs4c/RW9dtNup0n8QPayt
 Nuj6dEYizAgyIm7tNgQfLY+j/Y8/uQfjE5E1wDwatCTdyJ35tU1ymj2xDIvPAaiIRZOK
 S2+fBT26bqMTA9fsPw/Mvz04h9/L/qjJ8Lz7X4Vrg1RuKnL9y2nGgOQ+6dKJSDKK23B9
 JQIw==
X-Gm-Message-State: APjAAAW1rDtgTwBnbE/ichtgWu6NAmW+uLyu0ascKUnTRRpE1o4sjxfO
 aK7caYZPf5wjSM0SIzvDU4I=
X-Google-Smtp-Source: APXvYqwd1Z3bZI6XJPpYR4SkX7fwz8xnyes5qjxd/FhudI7G7o2sE/PKhjnB92oAPQ85H5uU3sJfgw==
X-Received: by 2002:adf:f406:: with SMTP id g6mr12424357wro.325.1569002025725; 
 Fri, 20 Sep 2019 10:53:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id h17sm4957329wme.6.2019.09.20.10.53.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 10:53:45 -0700 (PDT)
Subject: Re: [PATCHv2 3/6] nvme: Restart request timers in resetting state
To: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-4-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3a7bc2e8-24fd-9312-403c-992b1f1ff48e@grimberg.me>
Date: Fri, 20 Sep 2019 10:53:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213431.7864-4-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_105346_954942_BE8C62CC 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
