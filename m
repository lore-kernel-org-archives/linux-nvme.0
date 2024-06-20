Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC4AC27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 06:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oGajiQoWJPyhJkfPPPX7h+SEQ4
	YIlhHxz5JUyqJfk47M8oXSbLiofKPtafPia9Sb1myJbeRqNRd6aoutsQUswQn5DwEoOBd1v3a4clK
	3lG6SPWTnT5p2HLJJj6mAFAtl7Yia5lLEGfOPamqY8S0ZvF2WXhAy/sgNOiE37gJ3UKkQBnel2hrB
	376y8OdtmS/XqAqE/zwRe9CnY73WLPP0igWhD3tCy65db2mSs/jTN0OD/ENnP6ZZ2TB1HZYamJ68L
	gapTubUFvw0EC7Q8zWTrWrlXpjvz6BBZlosIXuoSO/gGf4+KJ0KmK1+R7Ef/HLUZZHN6NcR2nxN7+
	QZQXjPAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBUI-00000003q79-0HXB;
	Thu, 20 Jun 2024 06:41:38 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBUE-00000003q5W-2LvV
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 06:41:35 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec17f19386so491521fa.2
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 23:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865693; x=1719470493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IPZJxl2OFBvdsJqrxtZ/mmwEWP+MxOMlv13CYoI3Y2NIMKa4Nfr3VVfI3AmePCxu9p
         0BMk0IQmYFcJTCTKlXoAU7y7B9Pvdo9uMRpc5aMkOrO/Z2Qjl/+GIEpVkzfpjxposoor
         U/OOAXXKRwoZCIfLONPdRVeVa49kqnKLuhbt3P/t02E//w/7K23j/JsWXPuJKS19mm3/
         1zXlxD4MbQK0tIpOFRlcgPUNYHvTlx1/G3ciXWhgqaDpc0yA8D8Eb3iihxnAH0wWvD7E
         0P2v+Tebo6sCqcbVGb1/LhB+8TmywQTnHpl5+IzWRkrrGIvQp6BvSqpnRiMv9FAF1ZCe
         LEng==
X-Forwarded-Encrypted: i=1; AJvYcCUuqNeh4CnnHx1TWetK/OZRTS2OviYA9m7/+HyLegHzXATDNae6yZCtIuGMdWCkbqGwlUHIPYIc3WAuBwtFPEjOhcciBQ3TdV5Yv3Ri2fo=
X-Gm-Message-State: AOJu0YzhakA2FMVABdqIDOASwR+J2YHcoz8IXBDdW9WjEh3KNg1ZdzgQ
	KJBlZuzzoNUD8LokZS5wsFtOY57sZwMlErEmMEHUE/jaT8B+hg7i
X-Google-Smtp-Source: AGHT+IFJqt7HNRnrba7BZb7AEYkfRfwqwKmsOv6r42Tpi6zsO1emn4kjDf30cV9GUlUv1C+OOtqn1g==
X-Received: by 2002:a19:7719:0:b0:52b:bd23:1e9 with SMTP id 2adb3069b0e04-52ccaa4eb27mr2135888e87.1.1718865692651;
        Wed, 19 Jun 2024 23:41:32 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36437896ee5sm2013893f8f.20.2024.06.19.23.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:41:32 -0700 (PDT)
Message-ID: <4f39e136-d891-478d-8a0b-3a5a2a4df4ed@grimberg.me>
Date: Thu, 20 Jun 2024 09:41:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] IB/core: add support for draining Shared receive
 queues
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
 <20240619171153.34631-2-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619171153.34631-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_234134_605522_BA554EFD 
X-CRM114-Status: UNSURE (   5.01  )
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

