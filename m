Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1725CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eErnRtkqSjdfJvRjbcJ+OmIoi33KHHgxwyuDSUKhEhg=; b=V3AINk21fX+AIePaot+0kNcpbm
	KDU+48SvIvA0aEMVAWbUw1EpGbLUrHT1uheTzeeNrQvxzEVQMAhD/8kKTNRQvfSXPyN3pqB3hkYVq
	zEaA/r8v2Ro5BwEM86RANOGOKY5ErxWwhVusuvk5MnRHK8mUNaX0cykRszC5H6PVvEQnBgBkjlsK+
	aNDU8H+H2YGwEMajDBWLhe2fhxbnrVveFtYAXPEWWt/FAvKExPvRVqNI+puNXtyPJcTJ7kDStaQs0
	pGZZQI5Y1Ur7EZKx8WFfRGbgUv8XVILrFbwKJVihm9RXRzmgAc8nnfc0s644WYRb3o+aOXFdb1LL2
	5ADVukCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPHW-00Eo1E-28;
	Wed, 13 Dec 2023 13:28:10 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPHU-00Enzv-0y
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:28:09 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c9ebc04891so16450731fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474085; x=1703078885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eErnRtkqSjdfJvRjbcJ+OmIoi33KHHgxwyuDSUKhEhg=;
        b=E5hCVy4wzsqgu3q5QZLtSW4A6ZRhZEDpeztaNITIVSuMghxdfMoZx4vynyvf+HNHlb
         IE5tGBpq+/HCYhsI3QATokCs7Nq4Qy/Q1dfy6a3C1Fupu7HtADaBDDzqWUodBD9Yk8d6
         EiRh9yMmgi2WNzPTQ0zyUcrOHb5RqNRKnBsqq27k3oYH5p59oMiZVVkV95oOw5lGolRy
         Eoq97te1RDe+vwTkktqgU4W+RSrsf/O9pkdVcuT6Cvi++cKk+/NDKsi7QPGVmwQlnLio
         rYQcQELP+b1957cC3hELXmXYe70d5Nnj5p/U89ko5c2ruqPDNRqFJr34vof/b2x6dWCP
         QLuA==
X-Gm-Message-State: AOJu0YwDT5fMzmDqSeN1bKYmj4nZ9H8+/PZz/mLE/WEH/6QpF7r6qsz0
	x7AeZuu9CaWzKEF18MlT+SEOkSNjD2o=
X-Google-Smtp-Source: AGHT+IHIdfqgPrBDe9HzL/ucELKCUDsg0E+3xJX36t59OjStb+i5K8u+Zg+GaNLar/wj3HORNMO92g==
X-Received: by 2002:a2e:bc23:0:b0:2c9:edfa:f7a0 with SMTP id b35-20020a2ebc23000000b002c9edfaf7a0mr8853783ljf.1.1702474085305;
        Wed, 13 Dec 2023 05:28:05 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm20289168wmb.38.2023.12.13.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:28:05 -0800 (PST)
Message-ID: <8467c511-c251-4e8a-a7f7-3c8c5dd062ab@grimberg.me>
Date: Wed, 13 Dec 2023 15:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] nvme: refactor ns info helpers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_052808_342302_1ED84C2F 
X-CRM114-Status: UNSURE (   4.87  )
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

Same comment on PI.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

