Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80FEC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=K8NgVa2iPaJNzRB71BmTVh4kWi
	RQa4s2GQtwsTGiHkOWuf0LcPSwXCXgWZgj5JStH0shd2TcLdrrI6BX80/ew8cMz+4Na7+g5c1u4Kb
	8/5a0X5F1BqZVk/+hdDKqVkC3Kwohi0X6e6mbiwrdC4z8d4zIqt4Q/CUiYwoIQcVutfuytAbOby6W
	JLRZ+Bj8K3nNzYfGDIeS2XDqbXHw1Tpk5uwjW4zdwBH8fpSVdkNDnQILxKWTETnGx5gTGwfTaK0bj
	C+NfZDiE7L54i55U56lgXvTt6I0QPmQ8jfizomd70OlKZ7RcVYSDsT7+QUMtl8piH16tnJiirYyOa
	eK8Tq4Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VpI-00000000yeD-1Fdv;
	Tue, 21 May 2024 20:11:12 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VpG-00000000ydZ-0xgF
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 20:11:11 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354cd064810so10123f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 13:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716322268; x=1716927068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k9hWMbXsuhwbnxRJyRtzcXsm0oMWauJXtsxOQ/dCi/EDD4pwYhSZo9Z1xgqoiJPW2d
         fOeceArp3Q/VWfef7X8Gco47PZjiSO8Wu2o/ky9vzAz7/ucI338SitBNb876LvELo/8K
         PkrytxGCz4JupejMH1IjJn+LWoNyW404+G37X0pRVhyEDFyihknEjH/jMB9/fD5pfwLZ
         375ODhELvb2uo+UYojZFt/sTHKjZY8dMkt5v1H4qx17HYz3rnp57m/bzr+eUuUi/i0h3
         sQmFbDPy698g00xiC4IfsXjx479zxFY6vjM9G0+z2p2adOpZ/1Qn/urgFRSiy5FrQWbY
         iuPw==
X-Forwarded-Encrypted: i=1; AJvYcCVQtSJXiXJhL719nqJ0b8aNNo5aJwIReDYveiv0e/VE4TX+anKKAVsP46dhlL+Y+XJ24KPpfmw6RLNiwzzUKj2N3zHtbioxDjhLHVRkXTU=
X-Gm-Message-State: AOJu0YxI53Ckkx0kP5L0xAlq/HcL6S1wpsxHjm4pRP/01/wRFo3eGv9Q
	py3pnv/czFBsEg2BYyxVO628sQdkmHkzVXQAFfk63Lv8kh45iEsrnh1zgg==
X-Google-Smtp-Source: AGHT+IEp1457YOHxGd+L1xpCg7cgOHnywcCtMkFENUtbkWvX7i0Jy5MBvwZDnzyDjEI6I+iata2aNQ==
X-Received: by 2002:a05:600c:3b0a:b0:419:f0a8:9801 with SMTP id 5b1f17b1804b1-41fea539b4cmr278422355e9.0.1716322268218;
        Tue, 21 May 2024 13:11:08 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420152a2a8asm375904605e9.45.2024.05.21.13.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:11:07 -0700 (PDT)
Message-ID: <27c96a37-2754-48ec-b4dd-7875a8b95762@grimberg.me>
Date: Tue, 21 May 2024 23:11:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix multipath batched completion accounting
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
References: <20240521170537.2029233-1-kbusch@meta.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521170537.2029233-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_131110_276540_B8712EF8 
X-CRM114-Status: UNSURE (   4.38  )
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

