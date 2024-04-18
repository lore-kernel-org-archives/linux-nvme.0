Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C94DC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Za57lZsib4oChdbArQiN2hIlAE
	YU2vl+4F6MxIqCFWyelTpGc89cl8ElI17OMu24ZsJhJyP18LF8xvXBtkfraycRQXkSyNPuRGDVOwN
	x8oA4d4bF0opk0c67t4uWDeFVGqeCj7axGxg6ZXrdk8MCtw9xmgzHOyXFC2TmmqE7RpaM64aGdIg4
	EXaAbFU9pekz6q2g26hN7qi6kJSHAAtDQEiIxZDH+mUsaGQY5KcsOKe8+BMMLKl8YGNGplvjAkkUN
	8AuL34RUUCcZNzhvrMZK3y5SvobEhl43fwY62kLkr1j/HarWBhec5EybxBMh7/OrUQeTXLs9KUV0G
	sXjKbGow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO8J-00000001d78-2zr5;
	Thu, 18 Apr 2024 09:32:43 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO8G-00000001d6H-0GW5
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:32:41 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4188ceabeb2so15385e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432757; x=1714037557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Il+akeGmTEgD9uNCHlKlPpYbRb1lXxu/EugYWpoB2lABhaBzxtGaL/pC7EmMn/gdEo
         yZO3aCM1QcNZl5NKFVp03OWow3WNpdm2UTZjvKFOnQG11VtEakd1aBVNvWoeTW/+k1OF
         Ql4+Box7iy8jm8EJ1W0Dw2eflzLN24Vu2RWGy86nG5/fz7WR5Oee20xOMaAaQOpSy2X7
         5gEt7wu7c45lvOKke9mDndQZwDd88W1ruaUC0mnNlnRzpudTtXizbs+Dv9D+acwsVW3d
         c+e58lAubg00ZiKWeHStVhJX84lGuwsrPRVAwKBGhrSMAChFmG/iwEv3WZzyqU3Y4Qb8
         x8+w==
X-Forwarded-Encrypted: i=1; AJvYcCU1Wv9CJI0MC5sarNm8+WKfwEnNsHkYqaBHmWE/4SjoGP5tFQlnl4b11ESTV+3A4nDuEJBJOR0fh9mm246kCb8N7dAHjngL4O2KHyr15EE=
X-Gm-Message-State: AOJu0YwmEj17W+ihpoeG03xb5b1fNCi+/poIq9Nq8syjx3JShYU4GRDv
	2Bv5kqJnxWlOMP+ys7GSu75iLruB/Fw7jmGqY9tVTT+PRlt2AnHV
X-Google-Smtp-Source: AGHT+IGlQstetmOM4FUryg2FgGFjHDy8sepPXRj3cUX12cAJkaNnmzqLeyJVKxbIoRD2qmDd9n5Xag==
X-Received: by 2002:a05:600c:1d16:b0:418:192a:4243 with SMTP id l22-20020a05600c1d1600b00418192a4243mr1659440wms.1.1713432757001;
        Thu, 18 Apr 2024 02:32:37 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c1c0100b0041895d1c7bfsm5872702wms.42.2024.04.18.02.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:32:36 -0700 (PDT)
Message-ID: <53591aa0-4cc0-40fe-a8f8-7b8897bcbd6e@grimberg.me>
Date: Thu, 18 Apr 2024 12:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-auth: unexport negotiate and wait functions
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-4-kch@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240208062427.31255-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_023240_122749_3FBF563D 
X-CRM114-Status: UNSURE (   4.47  )
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

