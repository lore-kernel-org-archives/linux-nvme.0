Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC2C4828D
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kJGOb8aGIl06HBM0FuAuPkbUVU
	kljK9gbeeI8rygOjRgP3W6kMItKQy3hrgXJxK2zJQhWmGu0RoM5gUpIsVyQ/F7W3IgKkRY/1sIsBo
	l9agsx8QVwftYKhOUYos5lgGCpYagCDh3fOZCySpClmQHKifV9C29LuodqDvD2KsDvZf+MxxcHwLB
	T/qKgVsmBKmo0n54vZYU0a7wN0E9ybUeUAIe6wagzJn10dnYXXjGFXmYIF19l1zvtR3JRytOJ8mMn
	ut2thvv9nCww1cQZql9q9/JfGdU+PzxSWsL/ixc4I+yUWVYTlARMZFzUEX2+4n/NBX6sYJiEA6Vyr
	aBrlZF4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAC4-00000003TPp-2mhD;
	Wed, 31 Jan 2024 12:59:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAC0-00000003TN9-3lQ5
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 12:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SpELB+hajsEcMxyHmhBqtakunW
	+ZrO74bP78TCgCm+A+fSpLbuRH4UfdTkRmuXHrCo0Lb2CSBLmyNQV6X3oDumCT85LVyXy4gVj93w4
	CoeI4muHMaqk9VYIzeuySWTKClbCUsBO1WwHfP3W581PXo8Y6O4gJG2GcgwUONApchkqDSAgCmBLQ
	Im48S7bRN2g4AgDKd4mqijA08cn4YqwB6BfjOo97Y8zoyf8046XypS8BWl5yT/ZVH+1bnfY0nYADk
	8IwFn1b64d0jKfXJoE8CF91YGohPaYDrYacPGcM8ghEu/N0Wr8Lq+l/ETTBIXOEQQF7+t6JvpcDAy
	gk25l3JA==;
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVABx-000000092Cq-3e1g
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 12:59:51 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5101ebc74ecso1276496e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 04:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705987; x=1707310787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PYs2zI2fN0N+7yKY9yvQ6owadS0XoPj4Y2BC0JcKFd/n4ydi+YRA6Nl2MTp45Pbq3T
         75SNN4zyRF/EgafRfw6uDuI1tLTDwXlC0Jgi4Pv504Mspgyo9j9y3EXlaCoim7WT+9VN
         hULVD5Mq0Ucc8ZzSFcTDGZ0ehC5w00hM9H8QLEog4ilLNWIdsMabRnum2t580X5JJm1Z
         akbwoduRo6bMZO4+7buK5e4wsoeuboCn5pbMwdZHi2FjwMNyOrNrp2ryG4uw9mZB+kvy
         MhXeSSCcvhb6jWV3bKdSw5tmliO8B14443ByWIsTlCmbJSDKYNNsfMz6AV7eRkHWvf2n
         WW7A==
X-Gm-Message-State: AOJu0Yx86seN5r3On0lXZw4r8hqoO0PDUVUVMa8lDUgFeLA7FPjo1dzh
	DL5aV+hD9ZrxEIqmuV4xAmh7wjcsl+4hjr4Xnkqx3uDUunr+7Ros
X-Google-Smtp-Source: AGHT+IHvtkQgpkvguW0u/qcGdNAkM440AvldgrjB2mNl/3SEGPPpYmjHMO2Ndjjj6O5UydAezGvuBQ==
X-Received: by 2002:a19:435a:0:b0:510:1bd3:1abf with SMTP id m26-20020a19435a000000b005101bd31abfmr1156641lfj.4.1706705986833;
        Wed, 31 Jan 2024 04:59:46 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2d0300b0040fb0c84c64sm1510879wmf.14.2024.01.31.04.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:59:46 -0800 (PST)
Message-ID: <daced189-480a-4c06-a3f0-63f63867bd6a@grimberg.me>
Date: Wed, 31 Jan 2024 14:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme: add tracing of reservation commands
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
 <20240131091222.116190-2-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131091222.116190-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125950_015917_32B1386E 
X-CRM114-Status: UNSURE (   4.63  )
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

