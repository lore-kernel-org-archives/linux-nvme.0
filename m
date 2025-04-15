Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D0C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFKy947J16h34LI+AY5dO1obJ1rr53gzH82F390rzGA=; b=Q+q5H5xf4pXf3ci12uG+6KwO/1
	sXZNXmvANjU9PIhcQL5CAOHPTTA/ZI9HYDFsw+GV9lYJ/UOi/bvd1lYXt9zR0VhLXzdowxf8jKj1s
	sr62P8dLF24sOONvKmx02VXFxKG4k5+FeOcsJSrH8+rdAx5bUMSCmqxTXDjBtOESwx4YVlOIiSEQY
	sclU/nl0tol1KbAlRyGOKb9ULUYEY9To30U8aY6p1GyxmpDKjOAz3trRYJNr/hdG21iH+hR5NVr+p
	qaNJzqMJ5PB8TXelpnCOn98ee30vVAZnYn342TdDFFCYH3Py7IIbqH5RBbORJi+TKBurlNksfVfba
	8DT9IZ/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nwv-00000007D30-2pZ3;
	Tue, 15 Apr 2025 21:36:09 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nwt-00000007D2A-3sdw
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:36:08 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso675445e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744752966; x=1745357766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFKy947J16h34LI+AY5dO1obJ1rr53gzH82F390rzGA=;
        b=wTYFF6Dpkb2zjU5TINbXeBmlC/iCmwSfDfcp3OIzqSsO6rBb03woY4hggNdcehxexv
         WxJ/0R0OphcPBfr0k841okr45qqxsnJeB8Fk2T2XjQC/Dxp3MpmIL25JuK5uzI3PA0wW
         h3l8pEQse5Ggjre+VlH+y2KPxOod7+iUntGHJvlrqRgp4SzbjWi6SwX6DEcG8ND8+oYU
         6hJGNMa8MR+dM8MY/NOv2ZdiF8uqY/ypPoUKW/4TE+1ORkditR4wn55tdJEXXhyPxWx7
         8JJVYaJUjhOzuaR6sru4V3OyE3YA/iakglfjnUclUn15eZVRNb7D36UPvvltuXalmDIR
         uL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWv+sU3gZ8ufbHYeCYApfFjlnPDNjHmuN+iWr39H3YBPoUgKgf1bVj098ypCQP+yxnprzX6DeEMXzNP@lists.infradead.org
X-Gm-Message-State: AOJu0YzQZWYmSuRMYGjXteOx1JmOJ5Bmr1R9asclI/r6RUkr4iiKOKVm
	ddwUv/TJd5l66Oi/mceekd0mVXVK/PC2WsRz1Y/yr1wl/mXgDSbp
X-Gm-Gg: ASbGnctWHfJ1Fz9u9m0DF+rvd6FLDAPc7TMLfHCdg9ujRCHFheUtSQhg88xlkKjqFPn
	lbRW/p5Vm+t5dfMSuX1iDa7mNo7TNl66qUl46Ww4tEnJDYOoa6U5WxvGcr1Hdr0yxqbbcLZ4vs0
	RVd1lxXPlOj1Z4YVj48eUQUh/2gbWQEEVPJMgNSx0RxJaiv+wTy6dTLXVscQic6miJKC+V6//KA
	GsfFSBmHEbkNNd2felKXtgNczi3zDy3kPH169TvZnS/hynpfkdDup3TEZV4M+KY2/sQDRK/KkCu
	FyJA9HBcOO7hj6xZZL/dBwhhg3Dw0edx6sI9CBOsEyQgv/BtRL0ONBCgOM5kZR3F2YmPbwpZ
X-Google-Smtp-Source: AGHT+IFa0tT4EAXm8Kp7q4RP+U80cG5wTgivLOFgs/+Ypgby0BpdP4qlCXy8Oivlv9oh6nAZNp4U7Q==
X-Received: by 2002:a7b:cd91:0:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43f99874f73mr40650915e9.3.1744752966103;
        Tue, 15 Apr 2025 14:36:06 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b5a98c3sm1335055e9.38.2025.04.15.14.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 14:36:05 -0700 (PDT)
Message-ID: <071e234b-ca95-498d-8dae-ca4ae1cd7156@grimberg.me>
Date: Wed, 16 Apr 2025 00:36:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: remove redundant check to ctrl->opts
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20250415060021.16472-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250415060021.16472-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_143607_963339_A5655DBD 
X-CRM114-Status: UNSURE (   5.37  )
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

Thanks Hannes,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

