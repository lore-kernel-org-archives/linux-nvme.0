Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D62EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 02:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qvfAwzsixySLnhs9NU7vEX17uE
	2QAefd/S8FV8KuzN/dOIZEtbPn2/t5sf53DpM5mt1xw+0GsfZi+n7ZLet5HCYuNU0TtZTwQaH7iyL
	A+TY4xWOwc4a2RPeHfNTPvB1n7D3eqEkNFxpTSHAVk4Bb8Fr4aBxtxcuJefksDj2+HOHggJt0xThl
	UnFzUIps84orxa4edeguj7d2Sg0tBuyqhwaNld3+JATXds88EYMDYIvQWm4FPwZIrlupU8q7w+HXT
	U1kOb+asxQNUmAe9eUECE8BVYxo8NUWgUR8HTD72Op4zEccLmlwk0IsV5QfqysxY7iVQG3zfiAP3v
	xjIsb+Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbHR-00A7U1-PY; Wed, 09 Nov 2022 02:57:33 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbH6-00A7OJ-W8; Wed, 09 Nov 2022 02:57:14 +0000
Received: by mail-pg1-f177.google.com with SMTP id q71so15043258pgq.8;
        Tue, 08 Nov 2022 18:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gLmFXJm4MknUVzv3w2im06I1taed9Brh5LGMoPJB2mWJLKqyGtmEWSs1VMEaRTKNH1
         6ZH6Pj+Ev4NbUFpRpBgKSaBT+PFQRANiVWKhjix5F/M68gnClqoYJepLN2cRJWQTt/5D
         8AQTg/CbQogThlu8yRPP8Yl2jSpiI47Mj7l0nT00c18L3bPb7cYnNcBS6NBrkXLI73/e
         bVB0pmOnrIGZsQF7JOloIW481PphxuIjp4it9a6qrnl7qaFFmNHeYP0cVaA95LY/iifq
         UTWTpfn4TScuXozuCozvZ1i576Z4a91P33a9zv4yi3z3SFRN5i6IQmAzl+5P/Yrh9huF
         0tZA==
X-Gm-Message-State: ACrzQf3k9qEZHvpYGo6XeSHEDyNCJsvGmTHTF0+j1tmppxu5cT1etSf+
	KHXuvBC/iSvvFZE2ztRh7pplvQlepBi5cg==
X-Google-Smtp-Source: AMsMyM4xtTYhW17B2CKQu4HnS9hmOYEMFWL0YRjJ3wvUH0U1lWuwxpx+hWKzpOZ6qVbzV0E68Iqopg==
X-Received: by 2002:a65:5886:0:b0:439:8dd3:18d4 with SMTP id d6-20020a655886000000b004398dd318d4mr49748860pgu.430.1667962632416;
        Tue, 08 Nov 2022 18:57:12 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001869d71228bsm7713655pls.170.2022.11.08.18.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 18:57:11 -0800 (PST)
Message-ID: <3855b0ef-f34e-4f9d-254c-7111299bd480@grimberg.me>
Date: Wed, 9 Nov 2022 04:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/12] nvme: simplify transport specific device attribute
 handling
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_185713_060333_E45224E4 
X-CRM114-Status: UNSURE (   6.60  )
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

