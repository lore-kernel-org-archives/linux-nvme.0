Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD2C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=nk2TANx1IhHHXfKlW0x95IHimx
	5vsM5X2t6A5mcMcakH8b16FvkZZGkQX7o3NwbEE7sEUhQQZahxCWkH20NJ62yWmYyRObUQsVZ15s6
	PBBEJy8dh93514S6itw2TrAvAjpRGfTg4VkSUpZdo9BxA/SzukLyL+dx2e2thHaDKqqyY3xN1CnXh
	Gvi5iNXWWZRdGpe2yp595osWTZDHB91czgxETP6780CHbA1QVsDupSX06vhLmPKFssIJrvbfaBmT2
	7LRUGN34wa48HpZDtTpTy/E6mJNiLcrXyKmPC2Lgu17oNMMu2HX91gCv2sGxlYZjPEX4xsQ5Kkw94
	eAaRaQSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbu9-00000004ZAT-1JrF;
	Mon, 10 Jun 2024 10:05:33 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbu5-00000004Z8b-2PkQ
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 10:05:31 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4218e647d62so335705e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 03:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013928; x=1718618728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OcGFUyz6Qdlt2uXO9UHimMQARhmwJJpzXWcExRL47mR20cnrmVnWcbYcWeq/h2UzO3
         7RBXCAoiKHF07jKT1HU9L8eBTneYPzXTB6mMBS8J6HmDIVdv1YYTj7M/t9/2ydSQfFke
         NqURzKe1NNAuZRdSTLjuwAuIMWpBtNjiPrEsBrNLT4+JBDod6/hHuTVi1DP9dMtD63bu
         z00l9iVylKzSYwnNehjKQs2W8SdxoWPdpRr02jC5vgZH+m+HMaUzDXOBxF6ygEtxMnsd
         D93Pit3Uam0ap1aM2N3PsriycktaccUZfPdpnra9kcLZkaY7i+tEY2b3PTrkTD5ZhSB/
         naYA==
X-Forwarded-Encrypted: i=1; AJvYcCV7XzwPqsk3SyLAq6bwvcAZkyb3jz/hl24p2tyYkZ0L4GHJwSyYzpiE+/34HV82iLjT47swuQP/Y99UNsn0/iPyNwZI2H6euk2SqIBHNUo=
X-Gm-Message-State: AOJu0YzYH5RWPj3v5bxF4a33KeoRdgGy4C7fbHagUUBqjcfydKw+Xe7m
	yydG3gcG1f7SJ7CP14Z0t1I5IHZzCleHmI2oMtCAaQLTMmR3PV9u
X-Google-Smtp-Source: AGHT+IHd2ytfSWQRZyhEMoJ4OHwdV5oY+VtFMa+gkpFCCXHA6mdBcbjzpIbfF3YSe0sE3AJLKSZkJQ==
X-Received: by 2002:a05:600c:5104:b0:421:7f30:7ccb with SMTP id 5b1f17b1804b1-4217f307f48mr32593165e9.1.1718013927623;
        Mon, 10 Jun 2024 03:05:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4217ff85ca6sm59795885e9.14.2024.06.10.03.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:05:27 -0700 (PDT)
Message-ID: <35b55da5-deb5-4899-852f-7f0f30198adb@grimberg.me>
Date: Mon, 10 Jun 2024 13:05:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] nvme-tcp: use sendpages_ok() instead of
 sendpage_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 Hannes Reinecke <hare@suse.de>
References: <20240606161219.2745817-1-ofir.gal@volumez.com>
 <20240606161219.2745817-3-ofir.gal@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240606161219.2745817-3-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_030529_686875_2192B4B3 
X-CRM114-Status: UNSURE (   4.68  )
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


