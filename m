Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2359DC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=vzjGiAFNjVRdLdsWh/rfhI2inR
	zzC6yhBoEEYgUnb8rAtNKiquBdW7Taesk4yxWOwSGGeBV48FTV5ovDTK17Fa9oYdyF3r/BfyyTP1x
	gTGel3FvwzN8yLDU/Rna1fuhtlcs8unBt4ybtYL60yKQ4AeyyU4H9hgYz9lZVWQ/koetwzAJN0pBj
	fPRp55y5PMlFuknoTtbITIwK6IDWdZEDPgLyatfe46v8nKsyqk442XYHncC8XVg27tQOLlJuxhbXb
	kgizcRIwq9oJRvvLDNQJyCbobvdrCzp0jej8FyRVY5CPTLsEg5x340hGiXXvrEMehblo6m35ZAt1D
	ql+15FJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB9C-00000001yKb-2814;
	Mon, 01 Jul 2024 07:08:22 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB9A-00000001yK5-3DOz
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:08:21 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec4ec518fcso2569701fa.3
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 00:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817699; x=1720422499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JEqSN3NeMRYx9vlX8pSAUzLerhq5Kobm8PkjaWWf8E/vfO0XfRLyiGglXHYfzRPKeZ
         lOiYiGUFkJ8BPMOrGJayNFzRqU+EgvpEwR/GfS3t97UzZNw9a2GsKDxKpF4o0J5w6yF4
         NKThEZ12HW6iOQqWTE/Ct1mZhZ/qA8gyR1NDQNA8bp8sAIcolK/8DCzPmq4nemBZA/17
         /lJYYk7nop6HZkDSEhIri5YsKOVhcMfN1QA3PJCK1bM3CDtpggVUTtXqjp76lllXG7s6
         kWBk6qbvjkMYy3J0Nk0wR24Wccc4dHWS+vJUHUlgCFXSTCcedtQ9pu+Up9AbWMfgsg+m
         /nbA==
X-Forwarded-Encrypted: i=1; AJvYcCVoEZ1mTIYUwYuoxuqJRTT80xDKm53wlKsXnceY8GFh2VntK74qIxQ4Hnn+aAj3jTAu2adLhvC/5ODcpwdLXshe9xKSqFylsWRq2SjHswY=
X-Gm-Message-State: AOJu0YzD8y6n2qLryNlI4dgsPnqIk69HvLPuMHuLdsJr1TdghJ5FG1M2
	DL7hXqbalvjkgy4uVoU7dEAv9KDVTDpp8G7GYKE7H+ZIK5sZgCNJA8ONtQ==
X-Google-Smtp-Source: AGHT+IEgyakdEeQdj7E9cYHBzqtthbmseIELHnY1RS5Velot6nUcyAshyYc5aOvO48fGLTvo0ACEFA==
X-Received: by 2002:a05:651c:1053:b0:2ec:4399:9be1 with SMTP id 38308e7fff4ca-2ee5e2a8b15mr25854941fa.0.1719817698812;
        Mon, 01 Jul 2024 00:08:18 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55cccsm139946165e9.16.2024.07.01.00.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:08:18 -0700 (PDT)
Message-ID: <01773bb1-f470-41de-b2c7-064fec56e439@grimberg.me>
Date: Mon, 1 Jul 2024 10:08:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-4-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701051800.1245240-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_000820_809550_7D35E378 
X-CRM114-Status: UNSURE (   5.75  )
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

