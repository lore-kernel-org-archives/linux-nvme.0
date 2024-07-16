Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72250C3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 06:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iuh0KtKTMq8PktC39ZKLLjqJl8C/yzhVCfCFoXvAFzI=; b=0Apx5JrnTl8d7368FZjq/J41SK
	k3+/ZkyMvr8RGqIpD72uAZ9dvG62CoKIA1xB8w7pBq6BhAgwf5BZYNkA6eqhaGlf322U3iLJ9zXOC
	3p2Csd7jZdX9xLXqicyRJL6gDpsB3IyH5cSXMxVkI6XVKhFA4Z9wBAIS3nCmVlFoYsRs2bQOh+9ov
	Gx5WExWIpb1aBY6hu3sZufsWbveX2j/A7ZS/vQi0kLa6W+1PAXC6uEKb+Qvp118yHmQ58XZx4b8cI
	q+/0qxhNjQJWxgkEZrsU2YqQ8KYbQztJL875/IMKVIiHLfEcziLXf3zJIwWa838hzawDqAxGttECD
	oCjGJ5Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTbjE-00000009TRz-3P7S;
	Tue, 16 Jul 2024 06:32:00 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTbjB-00000009TQs-2Cdj
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 06:31:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-426744ca29bso2634165e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jul 2024 23:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721111516; x=1721716316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuh0KtKTMq8PktC39ZKLLjqJl8C/yzhVCfCFoXvAFzI=;
        b=tUGcLiMxSLNyBN67TdnR5ZCo9tyd3RVoqqvXWQBSpAd/NF9ubqMT1ZW8xyGZ6iE/LU
         6qlkylkxBewFx8i6ErcOIzAS6J/NlvzLsip3wrzIW3sIIYgNWcdRxeJOnSqOJGHEvjEF
         kwIXwLyxolCsVxL/O7mCJo0lKDPAz+uZKHw5gOISERtsqXCIlg1JH9T0T6Vraqywt+VO
         0dK5DSCNkrRQKE7Fzxb9Jb4xiRLBgou2k2VOO4hLLgJOGIn/NXU+TT8i7kqgoLysUq9w
         xLevEX/DWT32Jts86d3HV73gd4qNl+BlT2c1NeymvvcISmQjaV0uc90YDlK4LJ1mJZjP
         xEcA==
X-Forwarded-Encrypted: i=1; AJvYcCXe0QL5+1Wm1/Y+pK5zF4nncpu7QNK14JS+Z82p6gIj7soQz8UMMLkH1PZNc4LGxx/Jb7TF4swI862J/TSH4EUug0MwJlc03GFO11HZsPg=
X-Gm-Message-State: AOJu0YzGa839Uf1PAk5yRLaUZlBN+bE8jKvy8AfUQrkr1yUBvpVGPTmY
	2CU+Bx5ooSX/8KWlsrf7n2F99DfosLL9R+oNIapQDNlfwik86F8n
X-Google-Smtp-Source: AGHT+IEwjsOfHiojUGtYV9VpRUd6DwjwbyYpgaHjMSpZXV581NYN8RTDKv3jsLYEhHR6A3L60weYqg==
X-Received: by 2002:a05:600c:1c12:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-427b881df8dmr8067945e9.0.1721111515397;
        Mon, 15 Jul 2024 23:31:55 -0700 (PDT)
Received: from ?IPV6:2a01:73c0:66f:53e1:9a5e:260b:a701:b780? ([2a01:73c0:66f:53e1:9a5e:260b:a701:b780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23999csm147031055e9.8.2024.07.15.23.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 23:31:55 -0700 (PDT)
Message-ID: <311fc12c-fc52-4881-9f49-d51780ca4ecb@grimberg.me>
Date: Tue, 16 Jul 2024 09:31:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] nvme-tcp: improve scalability
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240708071013.69984-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_233157_597617_D536F136 
X-CRM114-Status: GOOD (  13.73  )
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



On 08/07/2024 10:10, Hannes Reinecke wrote:
> Hi all,
>
> for workloads with a lot of controllers we run into workqueue contention,
> where the single workqueue is not able to service requests fast enough,
> leading to spurious I/O errors and connect resets during high load.
> This patchset improves the situation by improve the fairness between
> rx and tx scheduling, introducing per-controller workqueues,
> and distribute the load accoring to the blk-mq cpu mapping.
> With this we reduce the spurious I/O errors and improve the overall
> performance for highly contended workloads.
>
> All performance number are derived from the 'tiobench-example.fio'
> sample from the fio sources, running on a 96 core machine with one
> subsystem and two paths, each path exposing 32 queues.
> Backend is nvmet using an Intel DC P3700 NVMe SSD.
>
> Changes to the initial submission:
> - Make the changes independent from the 'wq_unbound' parameter
> - Drop changes to the workqueue
> - Add patch to improve rx/tx fairness

Hey Hannes, were you able to make progress here?
Thought I'd ask...

