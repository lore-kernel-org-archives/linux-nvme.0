Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D5DC3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SUk3wNJ8ef4t+PTUUgo9e/Lea2VXz5xnQJVjH8OqLDM=; b=kxzOTo/b5nF3b++UCbsOuQgw97
	HWlKXX5iv7otNmrPmSvKhnSWF/RMUuLndEqf49Zgai8e2uc59iwPcILLK8EOklO8lPnegplV/DNVh
	OSGv0urUIrs7YVnN+brwYTmpPHpAIrG9TIRNrmr+E0TfNihi+pUwWsl3FEGQCB1LN3Qejk0nMQ2Ih
	/ndW9CEp6zIY4NQo2wlmt1Zqdxnu2gLFyB5fb6tFMjP06CLZjjJzoaZH8ziEyDlXG2NgLUL5o5QZk
	QJFWY95MX7Zjdbf6pnsQF+nWLaiv90weqPXGff6JscsnYK5aWbcjlbXpFH3H8UfZAcierDJg4l0wi
	PmhsqETw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u46Fi-00000000JVd-3DL1;
	Sun, 13 Apr 2025 22:56:38 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u46Fd-00000000JTg-3BlO
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:56:35 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso18906745e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584992; x=1745189792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUk3wNJ8ef4t+PTUUgo9e/Lea2VXz5xnQJVjH8OqLDM=;
        b=CTGHhvKgSwysNK7myIhnd4pzAtexEEoMIqfHu03qDtbcH8uwnM3FkO6zbakvnnzuni
         cADRTgMdSmK/Ez4brntLL7LY9BSBZ/IBwxowdQLzoWkPqflFRMY/BFmSFZsPzQDJwIiF
         90fxkdNmxEMo5vO0XOe30uSU9j5K0nnVkq2q+V41CLMR24QyB2dVCU5hLOfLukqwBzEn
         srT05qoHWyI932/20ngKNoCUwyOCBEr2hXs+U/uRCHrV9PyV6mOyHBQ4JT+ODGXsY63z
         +Wsjru/KhQBMBnohKGYC8CMAWDnLqIw+pRerS4ksIrLN/Kz6Y295TGIdI8ps4lX6uqg0
         ky1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCVflzHAiBb/8+ILAvcuRehGwocRhYx0HgwiCNY3+CTDh+ULEEtTL1l4DTiOQTSAM5E9Ta7+NjB8Xr@lists.infradead.org
X-Gm-Message-State: AOJu0Yxy6UcumJpVYyOLTwAj77yIzgfEE4RuIGy4zWTolkMlTEdwoIb1
	2QcfFkzFjiSvI3N7CzMoYh7qTqW9g5tZ+i1Owg+iv/qYVUcTDjTKTwjtRA==
X-Gm-Gg: ASbGncv3BsHGq7ergrneGDzv6Z/ulLg2X4/QQKNOxUh+R0IEj0rAM4SmuOFl3LNoGX6
	HdygxgLiy3xPfnyRZcs7ikYYB4CnjJlEW3BuacW+WWPi0LbLxrvAi7ASiQb8LISahdNgSwHqxsS
	VXQyD2VyIKCX+qhIkA6IJrE1jQGL/0yldxJre+W16fc4vU7RWuITdsKislLpu1a4z3Bn4zBhbtj
	Uz/0B1Rhcquzjk6YGoXrGfUla7qG1KbM1UHxfShl1Zhx1AAZ1GB+l91ZKakSfXAEsRwLA/DV2+H
	AKEMOhuRnXMyZuSnIGeiPSDus+AS2aUDMYDsxqmKgp4vrgg1HUZOTF7afa0mrvd4dTbh8Wsk
X-Google-Smtp-Source: AGHT+IEcmYtY/IDLi5uFn31jcfqX2P4ZOVOE5EnlpSvOKI9Y26PDazAYdQ3IxdxxuK/yCVD/YSmKtg==
X-Received: by 2002:a05:600c:3510:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43f3a93ce45mr103040225e9.9.1744584991909;
        Sun, 13 Apr 2025 15:56:31 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f208e96dasm116322055e9.0.2025.04.13.15.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:56:31 -0700 (PDT)
Message-ID: <b4bef1ea-1b2d-4a3b-9f9c-91a9736cfdf6@grimberg.me>
Date: Mon, 14 Apr 2025 01:56:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: open-code nvme_tcp_queue_request() for R2T
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250403065522.90807-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_155633_815832_1AA29011 
X-CRM114-Status: UNSURE (   4.53  )
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

This is better indeed,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

