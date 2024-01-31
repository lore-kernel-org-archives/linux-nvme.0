Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1613C47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=a9yI91aZBwYGd2/Cix3KeqiVgC
	gpnj3QTtveZoEE1fxUlp6ecsu0vH8tYQ0KyDIzGkavBCZpJ/0dZOEb+lzIfHs7keK8IHMv/BDiHxa
	ytwTVuGBYqAs2RfoQoDAsmYxPQ2+mYTkgVhaGWZoGpBEb23yDfsp7Ro4mL8s770+7ta23dImWs15C
	k5EnJCLHWdmaGDR2pqxvAbm3sOVD7Fz9ZKxeikuZOvBjuOj1l5mmaaDcuK4Uyucbj5kghv1ltXdLe
	BMdEnJ8kD1XYL5hfmmPCf03cmEipzIo+W4pa638SVFcke4Ef9bYHb5n9s7UHArTlbk0IT3A6d3yIH
	SFzoJLog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9vv-00000003PQJ-136B;
	Wed, 31 Jan 2024 12:43:15 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9vs-00000003PPJ-3aic
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 12:43:13 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33aeac77bc4so838496f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 04:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704990; x=1707309790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vaedwjZIiM7eUJo6ncb+esNkn+a8HmETM33B92r6uuNwkW4Pd9sMd9cywFilxQ11zA
         8RvcPX14sUJRAd+fd6FThnbOUGg6Wlm1im8Lvjb3qqz5u6+j1qic59EE7tYpE2a9kMIS
         G0MAfR1iZ4M/9JphELn0I0Rcffd6++dxI/l1hI8E1roXgSJUdwWN/oHX5PYbYcaaiD5P
         5C/rvPcEPwUUXawJPChsiLkuxnKVv0TIf9OrIZynQVtrtTFqmzPvY8NHpOAcxye7Sywk
         /Dazzn3oUVoC4QfsjPbY6Ald81kk8TEdtU0rUQ0qXSofpxcTnGYbyjsBxg5wxzuysSZj
         F7oQ==
X-Gm-Message-State: AOJu0YyxPlVg1sKDK26OZFcacJr2MtAJDwyxARD2tXR4EJ4ktxgsDjup
	RbXCWFRafyb4YLFVT9obST+dumn/7Zcd2gWk5i+5EL8Oftqb2RFuTGNIaob1
X-Google-Smtp-Source: AGHT+IHiqDri5U6yicVjAdTzw+nQJ/V3WvROrLRkTghi3afwSxj6SPokNbwq5yTXwX6Ik5pk7ipWbg==
X-Received: by 2002:adf:a2dc:0:b0:33a:e9d3:5112 with SMTP id t28-20020adfa2dc000000b0033ae9d35112mr1085807wra.6.1706704990370;
        Wed, 31 Jan 2024 04:43:10 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm7893801wrs.30.2024.01.31.04.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:43:10 -0800 (PST)
Message-ID: <d2f9a71a-8e79-4d03-98d3-7c556efbaf45@grimberg.me>
Date: Wed, 31 Jan 2024 14:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: refactor guard helpers
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20240130171206.4845-1-joshi.k@samsung.com>
 <CGME20240130171923epcas5p4610296779861b362ef98f3b6f819a060@epcas5p4.samsung.com>
 <20240130171206.4845-2-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240130171206.4845-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_044312_903741_77EFA837 
X-CRM114-Status: UNSURE (   4.79  )
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

