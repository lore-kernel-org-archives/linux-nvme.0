Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916B1C19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bq8Wh0DBxA9ofnc2B4ZWJo4uKOzB9xAeDGowWbZAsis=; b=0Z9eD5eULqkad4U81TSSI0xchk
	eOJWjXZZHQxkOZl1O5jOFBKWi5X2U75uol3QittG8rn/i6y83j/41jGd3sdYoJUkwyQZMwS09qelr
	lOBnGr5Vo0w7r0JLL4rEUHmPZQfarNMKCp4elZaJPYfwUYN+TALPbBOis6bfgT6x7JLjNnncpAMwY
	YV9JaoHWZqA1ShAluPPhZTPj3ty+9F1HIXRgWA0/y2shnNwTCF6LFb0Qxb0WrxcgpCeYm9wtCIGpr
	CX55It/plOPjccMwT6KvxN68gZ5zIL31qOecoC6FgAQrCEwgnjdtJuj9wVCozcIjfFUbGhO6KR69+
	VIIQ8xVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM9Mq-00DOy8-6y; Thu, 11 Aug 2022 14:41:00 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM9KF-00DN2T-H2
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 14:38:20 +0000
Received: by mail-pf1-x42d.google.com with SMTP id f30so16274763pfq.4
        for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bq8Wh0DBxA9ofnc2B4ZWJo4uKOzB9xAeDGowWbZAsis=;
        b=URNVc5r9o1mFF0mYIf+8A1j2TJ3rqj9AxopPpMAE2MYBm2p+SKUbJDbR0h4xAH4vag
         2KVdVrBjaavulPDrGKQqp/8DoEQqpglldqFBhbWBhk+gFUG/f7moT19A4ibj2bwfDUg9
         JNp93jrsYpAW5BCew6/CvHSooFLrV6Paj/VyQDpCQjYOU4r5VPCj2Xmi3NB2qB54QYlN
         Wy70X3pCwqttCOCpYEnj21lYGufGGwF5OrEXEsN1FLle4wnJn5dMj25ft0vmvq6op2XU
         DAtr10kWephsQg2lURjJUiAbNjyo9TghjtwdSlMIpiZ4EhCs9xxNA5CE/NI3bz64JVhV
         4oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bq8Wh0DBxA9ofnc2B4ZWJo4uKOzB9xAeDGowWbZAsis=;
        b=aZXPxb/B5JbXB3CCOO8HYxTAkx3w56OWsnN3tYXrAfvW3b0ZdzRV/PqvxUY3/0Wt0g
         5AIU8eS/CeL+QHB1s0ARMaSfy1ci5RLXIyGEO3im+RczGwwozDKEeLUc5ianMvZHgqg+
         JdLi47JAhU3OkLrWenXldP3OvC4rWh5OVA2ckluLhxKwF4jXSchUcBKKDjpXU8fcZ8eO
         uiUwFockE0KxeXtjuNsAsRQT5/KxRDFIdh9DuSfXNDQ00NzulEpN6/d9TkZ0bcHO+7zn
         27uRDl0yVFOq7t2AGhFUJLR7v7Y5ubuHtYbs5mVpjUP38vjyw9Um0sVkHr88hx3uJOII
         8e5Q==
X-Gm-Message-State: ACgBeo1SnasGLEYGZIf4tKCmUnGh982X4tosvTvijzVrCNxKeQWRn2eI
	obxcFta6zP0W7mtY4S2zBLUT8g==
X-Google-Smtp-Source: AA6agR5ghk48s+57bs2yaHWYiSDnjVUXtjDn9nYHemrBcLJdO2HNFpXKFnzZI/hk2teoa5uAupbqBA==
X-Received: by 2002:a65:6c0c:0:b0:41b:8696:d9d7 with SMTP id y12-20020a656c0c000000b0041b8696d9d7mr27187458pgu.16.1660228696634;
        Thu, 11 Aug 2022 07:38:16 -0700 (PDT)
Received: from ?IPV6:2600:380:766f:10a9:aeaa:ac41:5e56:1dd? ([2600:380:766f:10a9:aeaa:ac41:5e56:1dd])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a4e0100b001f510175984sm3677817pjh.41.2022.08.11.07.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:38:16 -0700 (PDT)
Message-ID: <956b18be-0649-abb7-968d-eb034cc468e3@kernel.dk>
Date: Thu, 11 Aug 2022 08:38:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YvUMpS5PxgJSykCB@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YvUMpS5PxgJSykCB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_073819_600762_4E832853 
X-CRM114-Status: UNSURE (   9.43  )
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

On 8/11/22 8:05 AM, Christoph Hellwig wrote:
> The following changes since commit fa9db655d0e112c108fe838809608caf759bdf5e:
> 
>   Merge tag 'for-5.20/block-2022-08-04' of git://git.kernel.dk/linux-block (2022-08-04 20:00:14 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-08-11

Pulled, thanks.

-- 
Jens Axboe


