Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36C4CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pIT9Dk8sDQ5OtsWM3UpTP6Oi1x
	/P5kikyXdFts5Nj6Fi0W7WjIpIwm2R4Jss7wZf7Hip5PzIUgYD5OKGQaG8tRWQfjKKmzKWCMKN44m
	j/as/opX9hgSdlfEGtWoRPzTtmXdWAbFBiWHa1M531nGn5fKdJTt7ypQVq5wv5ZiSE2CBhhvN0pRN
	j2FlkHIXitbg1JY4w8SJxLOr3FSha0l63C+eyVhK164KqTZSnMp9T/lnOx6nulR0cMesv4mgtxRq7
	ynRfw2FeRevRfT7Nyfy5VGVoG+Gs7PEENPEaFVgE+kCIZIoKQ0tIqctfN/LsUNbLcLdkkkLBCuGpQ
	s50doFSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaPU-0000000DaJO-41Ac;
	Sun, 07 Apr 2024 21:50:44 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaPS-0000000DaIy-2mak
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:50:43 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-345606e8ac0so283277f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526640; x=1713131440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QSbXYbnghane7p1hoE3dsQmyhoo4AUhtssRJevyMRbeoKD5mJ60K5UG4GdK5NujfFV
         VpHAQS1d70godvIUrQcxS338EtLiTXAkT00bXMXc2bzXvb/YtvXl0dfuS6oxHW/foFEM
         hwZcSlaIGtJEkuaK8WuA0U79HFWl0yc87jTr+7DYWYU0031LAnIjes6ua3/QQd6v3508
         jEc25lVwTdl3r4PEGPArmooD3Jx5t45RDtJtIclofJug7khL2UhChf6Pp/mmZuPEj1Ux
         bhcnZ4rCJ2Jf5AbVViGTmUDB5iHjX/uBlA4Sznq0exh0pDpys1BvHIjWc3vIG/4gVWMb
         ZJqw==
X-Forwarded-Encrypted: i=1; AJvYcCWj3yIyO3Lnf2WN9CRRMWMl3sOQ/GMQhk5iyhQbHT9UbeZSNpEwLh54l+l2IbpMv1U1Ww3mouxE+Qi4SgPnczf9anQ2Ri7ppNGahyWo54c=
X-Gm-Message-State: AOJu0YwUPTpjhh9tOt2kmjeNQcRYHACfF/lXvQA3CPtljhBM0kh5qHAJ
	e5rnTwmBnTjDZYh8QsjCf9adkYIeegGvmJR8YuV0jhuMR5Ea8hC/
X-Google-Smtp-Source: AGHT+IFJbfToLVAjIb5v3A8MgPT5ROxO14YQ5loub1J9H4E6ZTbKWB6pxJpOs77Cetkg3xG0+lMBxg==
X-Received: by 2002:a05:600c:3b96:b0:416:7b2c:df05 with SMTP id n22-20020a05600c3b9600b004167b2cdf05mr156240wms.1.1712526640213;
        Sun, 07 Apr 2024 14:50:40 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b0041469869d11sm14512220wmq.47.2024.04.07.14.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:50:39 -0700 (PDT)
Message-ID: <6ebea07b-c40b-4fb4-b0d0-27145623a151@grimberg.me>
Date: Mon, 8 Apr 2024 00:50:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] nvmet-auth: allow to clear DH-HMAC-CHAP keys
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-15-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-15-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_145042_714533_AC56D4B5 
X-CRM114-Status: UNSURE (   4.55  )
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

