Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9357AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lhcONO+Ox5e3dJOs8MV4pjmMQq
	wjSdSYteecr8PPOcswMXN3/PLrCi0rLorJtQCPIwQZnsL22aZQ3AnU/Wt2jv/TUw6TTSKZv9TEtkg
	20Yd1Sk+bQcBj/8DCsHQE3Se55hS5gUwmOCFp3FGsreWka7FJ92eObg0Ma3s3xzzKgxb59vhSrhuB
	W1WabVEkwFCjydpywvfnOYMkMqtnc+7gsXC8mnLGZqlzk8meyL710ezQM3dePrC1Q/GCmALBrPubd
	Q2CJYIIai8RcG5CPKuKg6epo3gS1BedlZEh+z925S7vImXELSFHPjUrOnnT5U99ozYxvYNcBk9rLi
	1SHjYQDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbLK-00AAzS-HP; Wed, 09 Nov 2022 03:01:34 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbKb-00AAFJ-H8; Wed, 09 Nov 2022 03:00:51 +0000
Received: by mail-pj1-f54.google.com with SMTP id gw22so15513668pjb.3;
        Tue, 08 Nov 2022 19:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZGTXHZwga7GKM2Erj7qjnwOeKr+sjuznDL/9gixwKQebQRX9vjeYNGqxBGyTbH1dSt
         BebmKgJPk0WBlHB3jiUupCaNJuSYdpHiZhTe0Z+1N17osY2hiJdVrivy+GvlCzwz2+Br
         OiCCTkNB2aAH8coIwCAP7PSkHwlQt7rIMflCtq5XUyse8N4tBy5RyXkugmDNztsTZXtt
         /RG1mB1hNiDuImxRFbNrP5l6wcKDT+HcuGhPDTwGXFzaLyXlFA6oRfWQap8uvXjcSZpq
         2R8QS8lhdBsvaE315EXpBUQrDCzi9kOvO3pemQ5jkP8d5IfFgrbbc2c8fguXsQWuCrWG
         FaEg==
X-Gm-Message-State: ACrzQf2f6STKONJaAqcux+VGX4BuLugA7g8Ch2u9iuBJt4XlYx30c73P
	7CVmBIH830dZhH4zsyJ0N6k=
X-Google-Smtp-Source: AMsMyM4MjyYJm3A0lRMAig+9KBrkTTzQIX469ghRDQr5mOQe+122nwCSZxkAk0Sj/83VH4yL3hvuFg==
X-Received: by 2002:a17:902:d4cc:b0:186:f57d:ba61 with SMTP id o12-20020a170902d4cc00b00186f57dba61mr58745464plg.97.1667962847373;
        Tue, 08 Nov 2022 19:00:47 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id f143-20020a623895000000b0056b6d31ac8asm7299069pfa.178.2022.11.08.19.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:00:46 -0800 (PST)
Message-ID: <3e8c78a4-d50b-efc5-d66a-8e90dc37a86b@grimberg.me>
Date: Wed, 9 Nov 2022 05:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/12] nvme-pci: factor the iod mempool creation into a
 helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_190049_590096_2D818212 
X-CRM114-Status: UNSURE (   6.69  )
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

