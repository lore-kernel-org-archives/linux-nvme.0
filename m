Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4293CC3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejC5tJyZ0xM0rvuE/Sg8ufgATqtMOj49Roier3KM3zU=; b=ChFIoO20ql0YpT+jwISEbtBlJb
	kM3bQ086C218Mk2UtJZIWRV6dC1CscSGCRL9wgR+j6MGuvcdPhuxTPi1gODvhNnkoOgSdSqVUJuZq
	6UcSCNZSHzQke03KwDMGnbDxVWsgweWrsuxyyTu8AJkUwCad4mpY5jXMDQNGs6C4EqHvxU8erhZZc
	ZQnH7BsxVvj7SUlEw3SZyTJXgawHzUjog4YAk18CpzbHzKajDcoQhln8b1+wcHt4KYQGIL3ie8OhV
	lrMg0own/nfDBs8mAdYkEY4MIc1YuS3Iz9T+eddvynrGez3Rj5RV8MAUhVBMAWjf/fBW8scqpNruX
	tCJuj5kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45lG-00000000F3K-25oH;
	Sun, 13 Apr 2025 22:25:10 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45lE-00000000F2L-2YON
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:25:09 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso42688855e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744583107; x=1745187907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejC5tJyZ0xM0rvuE/Sg8ufgATqtMOj49Roier3KM3zU=;
        b=w0q4fnt+uYRNNcxFI+XdCTwGlmOOQKPjRCr1AVN9pCLHjBB+LxYAycXq3U4IF4wqOI
         zJ72Ygdi5WRO1XrU9d/dzOIwtndqGTn3Gh+Ln+E+CPaJhPLZqalb7OKhIQzOvwimb3fw
         sYM3wUw6Lp+CPyFRDrmF0wXVvmuCLvLvFM8gDa1/68DU2/hrlMZnIPGSsz0hCQWYimnX
         GbSes33wDa3ha4bXptZZMwULcrZ8cBdeij7ZCOvosIlj/H+xAmGYzcrBNHO5RV1Kfkor
         2Z7loZXq7m7LnVVZWGCslVqLrAsuo+dKTotBVDjyYqVe/fa9+52fs4fsYp1HwuYL4frA
         cZdA==
X-Forwarded-Encrypted: i=1; AJvYcCVH7oFm6gfd2Ow5Z8dskr0v3uzHYHy5Ywo7WjZYU4V+ipoDF2OjbepTWDh8ml2eXve6LrBx6DquKqL+@lists.infradead.org
X-Gm-Message-State: AOJu0YzD/qSr1AL/ZAXsQbdSk/IIwJwAv4MQC+PJvOx8ahoJTkSq3GlS
	I+NR3sfOa0rniQwlggLNDa8CPD3iaPEm69GHa9mxZB476TUnrgRo
X-Gm-Gg: ASbGnctVZOL8e/nBGAcI1sERaCz1Jr/RroI53dl7V466jkxRsueaHyIJa5ePhCE2fsn
	GlJ/u5Rzl/gClW7OIxrUSrf15XmHHj2I8mI25vtc8WMtiwjbIdNeOjyAsR3BYcfZr8RuiVpQaoM
	EUymlK4FVW4j1gDOXpEBGCszL3Rn+SCLc6CtpuxMUIwuGlN0X2t+ztQ+3fYOhafsqWfsANWhTGO
	rdDH/+67aseWVYPept7maa4Fi/ts8c1nSasgu4DxoFuk/Od4nZIn2px5e6LeOam2rAZs1E2hgtV
	H/wQ3qowuM0hPDWEJlK36qoUY6dHnpH0lgT/vvob+H3yQ1YzbukyBMoTyHVNAAbisPYrOHwZ
X-Google-Smtp-Source: AGHT+IFDa6oa8AKbuuOybOyorIXpYHtApbZ1c2qleFIk+2Nys1atNtJtxj4H+ggw6Kswx7zqNVvGXA==
X-Received: by 2002:a05:600c:3b86:b0:43d:db5:7b21 with SMTP id 5b1f17b1804b1-43f3a9b4865mr71187775e9.28.1744583106456;
        Sun, 13 Apr 2025 15:25:06 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572d43sm153797975e9.31.2025.04.13.15.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:25:06 -0700 (PDT)
Message-ID: <2d9257c7-de3e-42ea-a947-25e394146f57@grimberg.me>
Date: Mon, 14 Apr 2025 01:25:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
To: Michael Liang <mliang@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250405054848.3773471-1-mliang@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250405054848.3773471-1-mliang@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_152508_644005_F21555FE 
X-CRM114-Status: GOOD (  14.21  )
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



On 05/04/2025 8:48, Michael Liang wrote:
> This patch addresses a data corruption issue observed in nvme-tcp during
> testing.
>
> Issue description:
> In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
> I/Os are canceled almost immediately after the kernel socket is shut down.
> These canceled I/Os are reported as host path errors, triggering a failover
> that succeeds on a different path.
>
> However, at this point, the original I/O may still be outstanding in the
> host's network transmission path (e.g., the NIC’s TX queue). From the
> user-space app's perspective, the buffer associated with the I/O is considered
> completed since they're acked on the different path and may be reused for new
> I/O requests.
>
> Because nvme-tcp enables zero-copy by default in the transmission path,
> this can lead to corrupted data being sent to the original target, ultimately
> causing data corruption.

This is unexpected.

1. before retrying the command, the host shuts down the socket.
2. the host sets sk_lingerime to 0, which means that
as soon as the socket is shutdown - the packet should not be able to 
transmit again
on the socket, zero-copy or not. Perhaps there is something not handled 
correctly
with linger=0? perhaps you should try with linger=<some-timeout> ?

