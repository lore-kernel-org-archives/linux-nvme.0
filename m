Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FCEC0218F
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Feb 2025 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsPzncwIigCJWeSgsuG0FXasnz96a9gzn6HqogWWQug=; b=kdS1pUviVjZ8oUK1B1kZL4PPDx
	77DwK0V1dMBhFTSO392T+oyN44rReUekhDW67odj5bugYzJM1K5C5biwLYm9Jx4odn+bxgPyRygAr
	FN81C8muXhf5xrxW12iu4nWaoRcuFar/FdP6Xmllni1NPKVTQ6SCr++eB9F8cDXVgPnI9SmVP8tqZ
	1zV5tvM0MljpJzl8VUFgwWI3kMmPXZ1LO26Y08mwMgqXBo71aST/z7wvBybgbv5oFEIT3miqK8Cni
	4sgOUaF31sxZRL5Z4e3JQ5xanKdILl8WgPGoyMLjaO7YfKobWVekNC57byMKY4waUW23urIwVZo12
	UvYKHHow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tebXa-0000000DtxJ-0lJ3;
	Sun, 02 Feb 2025 15:05:42 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tebXY-0000000Dtwi-0NRV
	for linux-nvme@lists.infradead.org;
	Sun, 02 Feb 2025 15:05:41 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so245650839f.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Feb 2025 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738508738; x=1739113538; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsPzncwIigCJWeSgsuG0FXasnz96a9gzn6HqogWWQug=;
        b=TUT+bqNPbjEeMJMF4EC6MWhk1WbJ1cwC47VRA/hiuUjI3J0VI+1la9z2lPyqmg9rR6
         8TRdAitCwwU0QrAyTngAQuZQSlgWoDzHbTw80tW8RL/eAFncW4DXpFeZ6r68QdHXK7Vp
         No7PDB/ck36H5ZY6BioygKeQERrjHIwMPop4SuZOuoLrETuxPzAhCcbOtoN6557+2PK5
         T72VullAFOjpExznxqtNzJ9AfArM075f3DcYJYpJxxztkGtPh1ZEkbvCS5RI6YN7FYAY
         cI9xGUykrvw9xlLJD9UqLsdt3VK1heIB/2lBWEw2Yqjab02+kKxbOhVnVvxgFI5T3cmm
         TXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738508738; x=1739113538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsPzncwIigCJWeSgsuG0FXasnz96a9gzn6HqogWWQug=;
        b=VpaKOYxc5VZBGJY6FRAtMQHZwYgv6t4sLj69ZEhMXj0n0PxtKBoFFuEWSvL1FJjvuw
         62jsMMYerOt+o2Y5AZc1hvSNg4uGUSg/S92erMoFCD8OO0FUHCr7PZObL65O5jpq8h0V
         n/rOi3W6yEV9yHxeB5zEWmoP7+eKtgm3segujQPi2TCwA1jc7TxjHjnwUHq+1RXChtJY
         NHS0O+GB8PR3Q9wqxLN31tvL3GDBOBMhBkceVQzxMB+ee5Ttl0okOQzXW+ZdMj3F9yk3
         ygTk1q90n9JYtw2jcoVD6B2+vklxUu2aAw0h7iQVgsRWqL6veHwTbX92F8QJJgmQgdzB
         gjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5nL0kNJHLQE66pJmTzahmwBm1ZvcWKbgJbfe1e7/tJV9AelgPf3kLrksgsG3xd3QvO9h/djAvH0ad@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/JAl9Y4LZCh1fneqgIVCWEOAksahgWPvdvRQcGtpcN2Y7HpIK
	caa8UVmi7/srTxlhV7KZ8dMQSoqap3z5+HNDmmRpcmXq7P6pA7qiypwPN6EtHiU=
X-Gm-Gg: ASbGncuMvDHoesOs4Xrbduw3gPAwAJqtTTTwaGVDCLQrzZRPBGIlk47bVXqT+hOGCZ/
	JMQzAa5BQPo49QUGoSGFD7Gzb4Mr2dHLnbdSu4LT+zhZ/GfCV6DhbKYjtevLs7wpZgAkKs+lvT5
	GFu2GIcfxH5BE2D93UeXOjq3OUmlMKkBnfi+xnW49dYbH+zxgYIhpXWdWA2lwALZtXS2rOEKL6M
	NSwCX/wcQ/5KFGW1UfXgmFOd6KjAmq1TRSiHjflWW3mJJjg0bEtNCdKiczsNufF7W16YFx7wG47
	6LSAXsO6WUn4
X-Google-Smtp-Source: AGHT+IGtE/JLqI8S9p7eRdsRPG6dC9TP58pGT88bNKePz2C1yiBYPfCn5bRWwQVviJy5GovjAgOURg==
X-Received: by 2002:a05:6602:380b:b0:847:22a7:240e with SMTP id ca18e2360f4ac-85439fa6279mr1766967239f.13.1738508738494;
        Sun, 02 Feb 2025 07:05:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a15f8394sm204030039f.11.2025.02.02.07.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 07:05:37 -0800 (PST)
Message-ID: <8f039c53-a35a-460c-a0ff-43f592caddf5@kernel.dk>
Date: Sun, 2 Feb 2025 08:05:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: apple: rtkit: Pass the crashlog to the crashed()
 callback
To: Asahi Lina <lina@asahilina.net>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_070540_150852_091C64B1 
X-CRM114-Status: UNSURE (   7.98  )
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

On 2/2/25 6:48 AM, Asahi Lina wrote:
> Client drivers might want a copy of the crashlog to stash into a
> devcoredump blob. Since device memory management can be very variable,
> the actual devcoredump implementation is left to client drivers. Pass
> the raw crashlog buffer to the client callback so it can use it if
> desired.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


