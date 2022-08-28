Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABD8ECAAD5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1rQxjDmlYO6s1/0Xpbnfy+UDBF
	QFdLy/8pIewYVUqCgyPs1VvVLnSGy9uujaH0W41uwSStdLQmoV9ocYgfBvpYSMIqmDyVn6s36ANCE
	Kk1W98AN2y6whwHuQxntA+nhLk7Swb7yIn9nygNJfK0SxzJClrERI85zXgV3WZ7V9ce++q97BaGkQ
	AUgjtPB/Bm0y+xPe1Xth488mq5wHchblA33fdIwxbrF2w/x3nUEYtoQKOsduKO9Jk8f40tpBd/GHq
	xq6qTUj0cB0e7AkDFzvGmsyDT/ZopAUt63J1aA3qOV7SZJX1sXsqdr3I5SvNyPNOIbvaSPCXJENZM
	U9Mm4RTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJPm-00HYbo-Lp; Sun, 28 Aug 2022 14:37:30 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJPj-00HYZJ-LF
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 14:37:28 +0000
Received: by mail-wr1-f51.google.com with SMTP id bv25so211487wrb.10
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 07:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fFJvW/c9tNzgXyCziKdKVqaL4WIWZxGxNaOkiFLOwmv9w7N+90bXGXuS28xdCJDEbD
         DhzEXt7mTGliDyC5LjQL1BWOJ9mLVU+zAqSHHcDWBpxyTjyPtJ5/H0mesFO7/HSsTLJ6
         0/CPVKeK+FxxgWcid886pPtZkFloRoGnC7wuf/XhFZaQ1Tz4htTWwCAatFcnZQNp45/e
         Kztuj+bI9JbMiQ+eVQuQ6zkf5txrVrIQRTHKvTv5cwzdru+qYBrRDp8ANq7TVzGz817f
         fPyo1v9D+OY0aiI2nzfdrmNZI+2uLx6LoxBw3f9BrFbZBvwr0VOg4CG1JmAmbAPXrlMo
         soSA==
X-Gm-Message-State: ACgBeo1RVQWOOldNeM8qN8Sx5hC+zPKOX41i26nqa9fZZ0XbfI2VYoJB
	kMhYUTWhQat5R7z0tzOrseQ=
X-Google-Smtp-Source: AA6agR6ftrtflPimG16k/aglIc1REvON0PkSHPMhXCeItBsL3k/CLkpCx70qxzuYmQLu10dL7YLC9A==
X-Received: by 2002:a05:6000:78d:b0:226:d5c1:5ebd with SMTP id bu13-20020a056000078d00b00226d5c15ebdmr1945012wrb.565.1661697445042;
        Sun, 28 Aug 2022 07:37:25 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c430c00b003a60bc8ae8fsm5772615wme.21.2022.08.28.07.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:37:20 -0700 (PDT)
Message-ID: <af41a6fb-cd0f-2cc7-a9a2-c8788a2831ce@grimberg.me>
Date: Sun, 28 Aug 2022 17:37:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Keith Busch <kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220821084754.340585-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_073727_705824_5C31E053 
X-CRM114-Status: UNSURE (   6.37  )
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

