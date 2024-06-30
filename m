Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B70CC27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jun 2024 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rDLgwDcmqXk1/7aVQzzxQQ5tgE
	HDHASMqzBeoXtewaC1AQOolCX75JjFtSkZVQY5aFCmdhTPQV66t+lWl43+cDVHZb5XvGc2Tu+HKXE
	PQtwRcJWgBgDG/phQMtaBzSDLeIE0IBV9PkNW//J8OLIF2EMcoIJ8e2k7VOnnFBSd4M2lHIctaPv7
	swA7ExTEf4TxQb5DS76e0cU9UxBSlU9c4Ob9t/rn1NNB0m/Gpmmh/7Q0m0urvqlU3GBB1lBmdqnWq
	59p/PrwQ6ivoszCtvbgjPeu40JQUSq9x9/j+BMStQSutsWHe064b6W13Ump3AsrEvaKOW535qFMaw
	OvhtYz+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNprq-000000002hD-1N0E;
	Sun, 30 Jun 2024 08:25:02 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNprj-000000002gb-3xMX
	for linux-nvme@lists.infradead.org;
	Sun, 30 Jun 2024 08:24:57 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3635f991f4bso111877f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Jun 2024 01:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719735894; x=1720340694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tFoFm9NMG3tCayFekjYqkBok+c6mTRvS/h7MIZNLndoVFQtj0oJ0wJzwBtA2kpzYav
         r5H8Pr8nbiByX/q7akM5rcIaeCHNXHvYiTAgwwLEELPZ+QLUDwgLUTIVN2rrF3EY3K/g
         ljsju32PTwfeEqDuEBccyIXtkgaMjNoyUnFf8fyZZxnW9ICxdYQlc4w81yir+Lfhg4+f
         Nx+Vb1MYZ+4M3g0BYVRYP1JkhI0FsMFSfPR3GWP3K+GVXPTNwvpCdowM/TtTHDK/jaVW
         rPMarL6qCrjW+Y0LqWm2dzX9jm9SN4Jlm453cBl4uh2hXSHhK+rllR0WX1wA+ViEcKqg
         zrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAJTfn70tU7Gaue32VRo+flTPW5N79LtPX++UM+3FfD1jmfZk+Bd1pF1tszBDmNUJ8b1wwBp9/1PvGyvFmBgwoPTDz2rz8i+JQdGqis2E=
X-Gm-Message-State: AOJu0YyA/K/aaWALEZvP0/BZhOMwvWWiMvOACbNpW/e/OfogKgXKuSoM
	Pk83AT0z6XG18a4bbySD+RbZdrQu/eEu/ZMEM3vVST51vcZt1mlD
X-Google-Smtp-Source: AGHT+IF5j4Vvn/c1MwtD4Sq5KqVqB2yPZ6w2Wu759kgeCpnor3yzD4Ab/b8p68qtUYiSQzSM/GC5fQ==
X-Received: by 2002:a05:600c:4848:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4257ac69876mr15928965e9.0.1719735893588;
        Sun, 30 Jun 2024 01:24:53 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097b77sm102371405e9.33.2024.06.30.01.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:24:53 -0700 (PDT)
Message-ID: <f9790913-fbf6-4a05-bf2c-56051ab07eab@grimberg.me>
Date: Sun, 30 Jun 2024 11:24:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-mq: add blk_mq_num_possible_queues helper
To: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_012456_010567_C6060290 
X-CRM114-Status: UNSURE (   5.92  )
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

