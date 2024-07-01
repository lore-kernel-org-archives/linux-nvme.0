Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1D5C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=r9AbMWpRY+8e6TXaVvVpopU6EA
	JT08dMvYA5hxg3p6/55Xze0/R+pyVQWa6lOQKJTrFnT6LQL5pgVH6iX4oekd4crLqMTF6E//J1n/K
	ZdSNo+uYW/vnOWJ8r+XrzFSTek0J+R6kKSbLJwdQzi5EE4nYGI/eEaYan49ypW9i6eoylSqz/arND
	KAvq9O9lENj60V6j60p8Feih4kxR9zuogAZ7nHt4jpxdcwFxKNMnvllLuqQEIREvTpjeDstF97NkI
	VuHSjcaHfqzRzlzuniRYhPB3bmUd01qRjKGErdDVCiH/Ov19TpQ8ur+moxB3rlilpOye7AGz7EIb2
	RONLIo+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB8y-00000001yHH-2A1T;
	Mon, 01 Jul 2024 07:08:08 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB8w-00000001yGA-20ZK
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:08:07 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3635f991f4bso165913f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 00:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817685; x=1720422485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Mkvs4PPWAFWKM0xWV37dqAqX3ZUJXugWj6aoNs88K7n/oxdzVATVKjBPPyu/weAXGg
         JOJk24ozbi+m7B0q76K2TuojtnAoip1vu4RJz4opwaQHZhXyiHJCGWau0ogI28q/VJAX
         OYYQjWTCQqFqEvSVSofrDcwfXbl57/xClLu6Y6lLhpuMqbIGMuZcJbRfs5EdMO6XluKr
         WygYQOWXQzEs7Q6w/u6X+YBNu+Knu3Sns1GBrx05WiLkgNOStzXItIoGwGBDtMZ6BSJn
         OZg6eRJcM101jjJWpbqfkexe32IiKfFC46tXFuUjHvShHQnTb6p7lAIKFxJ/gkJkDkkF
         UF0A==
X-Forwarded-Encrypted: i=1; AJvYcCWTsu4AIRv60NYjklFwF5v9GEpzn8HRoGeemMFtYC8eeNh0UX6Ke0f7sW90auXFloW4stiieYvh7615sm5P8iHyOjQG4tS8yKF/J223rfM=
X-Gm-Message-State: AOJu0Yy8Pt4OATNhwpjqOh19GghHNvME67W28+lPWyxnFWZHSeUHa2pa
	MBGC2xCFoSDw1FKsu0CNFQhiOGKtACJgbfs2pw1fEyLjjAkdZ2f0
X-Google-Smtp-Source: AGHT+IGO+XR/E7wTlwaheKVw2Y3mz+lgUvqCWqjVh/174YlYIe7F42jOiNJ8bV1JGLNLHIDA7vOAlQ==
X-Received: by 2002:a05:6000:1f86:b0:365:da7f:6c17 with SMTP id ffacd0b85a97d-36775733d2emr3630890f8f.7.1719817684673;
        Mon, 01 Jul 2024 00:08:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fbbd4sm9223793f8f.84.2024.07.01.00.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:08:04 -0700 (PDT)
Message-ID: <f04afd3b-3b6f-4b7c-affa-146a602d64eb@grimberg.me>
Date: Mon, 1 Jul 2024 10:08:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: don't reduce max_sectors based on io_opt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701051800.1245240-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_000806_524290_8491AE7E 
X-CRM114-Status: UNSURE (   5.70  )
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

