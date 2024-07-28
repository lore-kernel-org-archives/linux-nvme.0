Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707C6C3DA49
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jul 2024 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+/qFP50QQI/w1nJkAvDGEDvq+8YnzUH9kxjP/gvtFVs=; b=ZOLJdymdRSDlG9q9FvHM7ndYH3
	fzgxLe25vX/eVLfBpdsic/nKXUkAXrLV3bjuqlliMDOsS09uprsJytNY11OpUSuy8JPvkkwTBgRhx
	EsP/vFZ/nQnRXuxmtvJQ9+l+sg+JwpX3mfnySyrVrM6pvYseg6vgVfxO/7m44a7y3TVcJI67QNb8h
	F8mQOix3tPmsYDLsKBsCgJ+K+4z+fE/ynw3RyVdreTyQpykRSTfb65mPOse8onuog4Yz8z36bPuQd
	GaW19hu5VIDuXxId1f0lWlxzd/Ja1Q9NN023XAlQTqz6ol40E31UUn330wMRmGakC2xCsdHHqvuFH
	odjXQeMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYAoG-00000009BpB-3X7s;
	Sun, 28 Jul 2024 20:48:04 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYAoA-00000009Bob-3ZBf
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jul 2024 20:48:00 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36830a54b34so202020f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jul 2024 13:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722199676; x=1722804476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/qFP50QQI/w1nJkAvDGEDvq+8YnzUH9kxjP/gvtFVs=;
        b=sTat+O3o+yowMONnyBBzo2v0FPkLfmnYVgbMKJyvuQyFl9lBvr69ojWOqP1xrtsPv1
         LMSqwmSsIqIJ7VQoX0vlaN+Ed6rM+VR6XCPHUk5V+Oa5OMw8PDJQa0I+quhE1qEQaN8F
         WuHHLyma881c244ZJb0jFyqLoim0MmWKBCHzVx8+8MgSkujCkZu80AlYaUkIXMJggJpg
         e6TI2s2fqLtpCWNb8AMSl9nlzcmtazUYwVUqxedynJ3UOTJzkOGiHgVtX6wz/GzOjx8j
         F3eN1iXfm4WYpKILbfe8OK5/IZ+ybIjWnZRxQETMUJDkrfNhrHGCukhP/NDvw3q+MDXi
         cjnA==
X-Forwarded-Encrypted: i=1; AJvYcCXhfAiqnKlON2wZdjMAaLkvCz7J1x9pVW83Am0D/4vrIUvJDnE3v6a+aKbD0tc65DpqPeJVjG6IHHLcgFQxspUoH5xztSqY6z8OPOgnP0M=
X-Gm-Message-State: AOJu0Yx8V0ttNTG4P/wtANfsgBtJBC8JQ8OkGSijSyIei54yFpxhBeMT
	8VTTUzb/G0MU6Ur7s5Bg/tkccZkPzY6JrLLZYJnwuxdfeNoZews1
X-Google-Smtp-Source: AGHT+IFiHi48RcikhSV7154KKYKg+VVWPpPoJHyfCTYCtk4nKJF8N2Unbc5AlWgtU4xgKdfKh+WNdQ==
X-Received: by 2002:a05:6000:402c:b0:366:eb60:bd0c with SMTP id ffacd0b85a97d-36b34bf28ebmr5610418f8f.3.1722199676247;
        Sun, 28 Jul 2024 13:47:56 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e3bsm10512231f8f.81.2024.07.28.13.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 13:47:55 -0700 (PDT)
Message-ID: <ed89f058-93e8-40b7-936f-b5ee83c70bf8@grimberg.me>
Date: Sun, 28 Jul 2024 23:47:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240722093124.42581-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240722093124.42581-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240728_134758_924894_1DFC124C 
X-CRM114-Status: UNSURE (   9.53  )
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


> # cat /sys/kernel/debug/block/nvme2n2/multipath
> io-policy: numa
> io-path:
> --------
> node  current-path  ctrl    ana-state
> 2     nvme2c2n2     nvme2   optimized
> 3     nvme2c0n2     nvme0   optimized
>
> The above output shows that current selected iopolicy is numa. And when we
> have workload running I/O on numa node 2, accessing namespace "nvme2n2",
> it uses path nvme2c2n2 and controller nvme2 for forwarding data. Moreover
> the current ana-state for this path is optimized. Similarly, for I/O
> workload running on numa node 3 would use path nvme2c0n2 and controller
> nvme0.
>
> Now changing the iopolicy to round-robin,
>
> # echo "round-robin" > /sys/class/nvme-subsystem/nvme-subsys2/iopolicy
>
> # cat /sys/kernel/debug/block/nvme2n2/multipath
> io-policy: round-robin
> io-path:
> --------
> node  rr-path       ctrl    ana-state
> 2     nvme2c2n2     nvme2   optimized
> 2     nvme2c0n2     nvme0   optimized
> 3     nvme2c2n2     nvme2   optimized
> 3     nvme2c0n2     nvme0   optimized

Can we avoid a formatted output in sysfs? I'd much rather prefer that 
nvme-cli/libnvme to
format this (maybe this may be wanted as json in the future for example)...

Can we simply expose the individual components and have userpace format 
the output?

