Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6DDC5320E
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+6en+5a7HD24mvNu3u0g4DBxnd0FW5QqMbpUoPTCUI=; b=be3OiQmY2WiuHj9vW7jiSllJN8
	uHledo7LmoGmjssw71OL3ihHQDFU1fUfLtmk4pNqgp1ZoaCuQZhmERROuo+XjpAxSzTusQNVf2Fzv
	1UU7/2PN4vybnBtYgr7HX62CQaZThoUTBr1saHgVVvisIWtsPoLTjVEJcTsRpSn8bRBrZJeiMU1xN
	HTW15s49N28AWHWNxT2iYTH98jXqJa7+xtQ1BauK6iwfylWrCtVqmbJs0fp1mjuer6W/woWluX/wS
	ofpdBM731urXzUiqrdvOLZ73hwZQKxOzQTPOUVSjNQWO5x9NXsSHn+TNcu03u5pHrw+cmw5k66SF1
	Lo7N05ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2Hl-00000001Ybh-45vI;
	Mon, 19 Aug 2024 13:19:01 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2Hj-00000001Yak-2GAw
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 13:19:00 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3718291cd6aso568469f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Aug 2024 06:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073538; x=1724678338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+6en+5a7HD24mvNu3u0g4DBxnd0FW5QqMbpUoPTCUI=;
        b=BwMiC8FIKY9HZPYg4Ay1RU1Khgix7NJ0qB7MoHL4ZLDNtXM9OReSN9m/OgD3Lzq/Py
         k1hzcwn2MuHFqf2RXBkFZkrpOQfHFWTp7MFNl3VManVhcaS1z7KU2uVUqk4JvwC7JR2J
         cIk8NaUdoBszZfVBBm9/P0xayAkLCVx+jq1UWJlqfySF1PXXaLJeIyqBzNxCErDvYKET
         vySQ0cD3rP6C0CbFlgtVtCKEbTYuca5yDL91mVpmoeNDO18exD/AW4fn3RhNPSHM0Fk8
         noc3/NiArgvPyNws2R/bdZ9eVcpNUBTgOFYxgmGMdchjuVXIqC4crkLDvKK/BFGIwbYG
         eREg==
X-Forwarded-Encrypted: i=1; AJvYcCXMkBoiMoR7rBxo6dfGCkULvUlBodKrLJbJTeua/PHLTSPU3VbQyPwzZBYJhId6Uy19Pkq6o5QYv+xh@lists.infradead.org
X-Gm-Message-State: AOJu0YwxQaU4wOeBRIY2hm+BKd0k9jiB/iK2mIemC4B/iGBa8mTG+6v/
	QoGXn/siy7GUoz4SI/rsYR0LvmwzBv4eXm4USR3Z5w6+e7UuNVOO
X-Google-Smtp-Source: AGHT+IG7R5dzqDFICK9lAgSzdaX9A+RGs7kq6vYkcHed5R4+sQjgBqUGEaXRWa8JzIclt91TRcNfKw==
X-Received: by 2002:a05:600c:1caa:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-429ed804c49mr46673155e9.5.1724073537655;
        Mon, 19 Aug 2024 06:18:57 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898972a8sm10601790f8f.86.2024.08.19.06.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:18:57 -0700 (PDT)
Message-ID: <1512e3c7-ef59-4096-ae8d-0e158addda42@grimberg.me>
Date: Mon, 19 Aug 2024 16:18:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix typo clearing NVME_NSHEAD_DISK_LIVE
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240819122736.57863-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240819122736.57863-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_061859_609009_EFB7D316 
X-CRM114-Status: UNSURE (   8.98  )
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




On 19/08/2024 15:27, Hannes Reinecke wrote:
> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_nshead', not
> 'struct nvme_ns'.

Hannes, what is the phenomenon here? Is anything leaked or functionally
broken?

The patch looks good, but please explain if this is caught from code 
inspection
or a real issue that surfaced.

For the patch itself,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

