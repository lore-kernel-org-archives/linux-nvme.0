Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47787CD4F21
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 22:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ovzrrjyj+AleRyxwaMyASNrXZB
	NdXTzUir4tmYDg397rup4mK9j/VFRc4ZrzTjJdv81A4hqjJfSqK+fBq3zqn6IvNVyB8JvJTZOVnLA
	I2DKzdGYEFK6Gvmx8nSMEuJ8IucVl6YqdISyw2D+hZxcYe+3knTF8vW1yUiGtmZQ5SofASg2XR6JQ
	R7lG98rYGw/7yhqlRT00ZXV7IGZMRV3tz750bK+u3rt8a2IBEqbVzsmzwus1UEmgsYb6QbitWxBvI
	FS5h4/XYCoZdPjMlWXhdTG9XNUbEEhXIX0E04nFjulcIkgCYuccxESC84/bnbahyCL7JMdCzrT3x/
	8DNsmpew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMvCb-00000000Xus-3CJG;
	Tue, 12 May 2026 22:03:45 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMvCY-00000000XuU-3uwm
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 22:03:44 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d734223e4so3764761f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 15:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778623421; x=1779228221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RgOMJ+4WANvwyCPkMNDtWLbxOLvQB0fMc4bh4nhKWWdYeIVlMM4v27jdcWObdM2Xmv
         bbd/+EnaE6XSj86L4aFQ+/fbJ9NQjTue3gYPe0N60W1KoCshQRvutqnwC2uAa/cxOyia
         ymv17ei4XTU7Xm8aB2W+xQ45pK8bL0RjaBS6o84+WukF5dADBs6NwHyNRwCJkmZJxBZr
         EdSB8YmJ4pBpVD7gUGWw/DjAafOhxBsPONIjRANHN6/FWOOdkTORJPho454JYw37BTq0
         whOaDxFWhTRIc6/09kc6I4SQzvX0MTS729PC4omWIUYzSicVunRIx6Ceofhm/HZRf7aI
         CB+Q==
X-Gm-Message-State: AOJu0YwlgbsOdd4YoC82mhNfjJ2X8328N5lutEvYdgM7NWEwPINQlgmL
	01sUwaLqLV6gpoJsXw7LzZOHKlmWpLJJDPQ3RSW3GaQCXMyoEtP72N1Q
X-Gm-Gg: Acq92OFeR7A1zrceM59I/rkMVerAxkydimTOy2xSk+7y0ltaDXljVNRhgL3jvmRu9wW
	EOruZCsw2NHS2mzoVue1AJmj2W6MDeEo3AnSJJrK8xAI7oQQpPt4RFaPADdwSBYhsCqr/ArulR3
	3s8OKu8HDYI7+CLBnGvTD/oO/pCUiQVJHZ4wKEYjw5KMc6Ddzg+jo3vXD16ehifepLwHhwXwZBs
	FKxmOU97TCG6YBIiwCRQsb4SX3NR+HlxHLzohOlED1Gf4vksc3/fyhJ5zizmpXlDwkVqdp/iEpz
	viBTAsT9nuJeay6kZQLz96mwzrkqA9IgfNOwem1wSchwj7Aeu4XXK4ek+SJf7PFpbQxubDbM6yE
	GZWAMjm3xTOdL+Zzbk3/LU0Xv8QvkCHL78e7qN6cC5n7uog3LB6rNfh5Y+n3xpFCtmvNoFDWcvl
	rjOQ8uXkNpgES/JlyoVyd4/bmPpYoZiA==
X-Received: by 2002:a5d:63d2:0:b0:44f:69f4:39b5 with SMTP id ffacd0b85a97d-45ac3f4246amr6113417f8f.29.1778623420888;
        Tue, 12 May 2026 15:03:40 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm34004386f8f.2.2026.05.12.15.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 15:03:40 -0700 (PDT)
Message-ID: <88b87d53-71df-412a-bc6f-c7c36ddec5c3@grimberg.me>
Date: Wed, 13 May 2026 01:03:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: release socket on sock_alloc_file() failure
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Damien Le'Moal <dlemoal@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_150342_972149_E9F371BD 
X-CRM114-Status: UNSURE (   6.26  )
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

