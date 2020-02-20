Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30932C11D00
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 07:43:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1182208C4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 07:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qa9HMtQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1182208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Qa9HMtQnOrwWr/67hmk+JrBUC
	qjA8kZIYGIZxBN6TpaA/khURvqfmog1neBvDKBcwkV3X+0/z+AVwCYgbA4n/7krSJ/LhlXRQ+X96s
	9gQJ6cScSw4tn8Z7dV7qh9i72pxRF91nAyL8D1AA96r5hmP/K26dqj3rC6jHCNrDPFgKKTr8v5ogd
	58j2hpVQJXRUgYVAx4sxzJ/1b4gisSIjuzTdc/b3Ngiv2BCFU7Yln0PxnygKsPrTvATFO6J7dMSai
	Qri9vBHPpWzvid+hf+61VSHDWTiXF9xlp2wWizxkJr+hVeKk/ru8MG+DozwDg7YXbEQCQMfSxdsUS
	i6fsZCZWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4gUe-0008UJ-2r; Thu, 20 Feb 2020 07:43:32 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4gUb-0008Tm-A5
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 07:43:30 +0000
Received: by mail-pf1-f196.google.com with SMTP id 185so1506152pfv.3
 for <linux-nvme@lists.infradead.org>; Wed, 19 Feb 2020 23:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=XBSxmO5TpiVMzEe52tNNrzFRv5O0ZzTpZf638fKhbJAfiesI6hSL/UWeoMMxZ3Joi8
 48ws0qT/6W6f/ZlUzq8B7q2mqS9s+E5SE9pTAqsm8UPxwR1SOL62Gwgtf3AFW6p3enFF
 jfRkeangfs8f6Ywxt0c3PPgepFlL5J04S/9Y+orEU2DQHwSXfLlZcBnmGo04BEsgsckK
 LQfuSV8/elSQ320DB/egp5hm/4Ly9kjxo2ZyS3qLZp96nZ1U2fcESxTmEP68AaKv09H8
 BpsqEgNxfR5rb94pnoaBX6Nu8APjLp3YXmdtv9gR81CYXv9TZDT1F3aoH+AFtH6tpuyr
 T1Sg==
X-Gm-Message-State: APjAAAX6J3gcV+hZ68TpWDSxJNphD/B427HLcq9BsgVUJG5okBb8Wack
 JADJnAns7q02DXOlQbNZdbvDPlim
X-Google-Smtp-Source: APXvYqxW9vqfSo4un2/wqMr9IomlzFNArev64L9mPekd4cJHuA6sCPC0xxcKKXPS5w83i/fOqH8R/A==
X-Received: by 2002:a63:381a:: with SMTP id f26mr32909470pga.40.1582184608040; 
 Wed, 19 Feb 2020 23:43:28 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3910:5e55:b19d:2395?
 ([2601:647:4802:9070:3910:5e55:b19d:2395])
 by smtp.gmail.com with ESMTPSA id v184sm2203990pfc.67.2020.02.19.23.43.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 23:43:27 -0800 (PST)
Subject: Re: [PATCH] nvme: Fix uninitialized-variable warning
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200219161950.14460-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b81eddf-61c6-c1e6-c32a-9a77dbf01558@grimberg.me>
Date: Wed, 19 Feb 2020 23:43:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219161950.14460-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_234329_349057_4BEE3564 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
