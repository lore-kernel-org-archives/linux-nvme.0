Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F35E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Yy7tg1Yd1nyzy+XXDpK5yToFQp
	riiGtOpEo6xxdQeLKNTyhDomCofMFkwf8YGGgQ5b1hKfXW+j94Mo/t1tpNFKcJjoXhbbTFN96EwpK
	7fF8AG3PUDQb9+3wDml1PMzZWg/QqImUd7lkYTb4BHk4/KkKoXWLQWnvlkx6f0q3v+DpMAnDYAkJU
	vxzlnG5UMCCdthgbEjUTB4YJOfEmgoekT0J/czfjMWObpMjopxkTOQSzawVZxYtGijYYbiKeDO8L0
	0tqKJj2fKeoZTNUFh2TcJjshTzCdd9RMdFrdrcmxEmY8C32OqgRgz9c2K+NbK2cL0QRtjuHaauhPx
	UNrCLexA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ1wK-0000000Birl-3Wi8;
	Tue, 24 Dec 2024 10:15:00 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ1sw-0000000BiKH-45LX
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:11:31 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so49192145e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735035089; x=1735639889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hb0/pycyfeJzG7jzAEqBkFbzQOBM6bNNqxEOG2mnMCUHwG3mBcuHQSGrMiEnBczjcX
         B9v8E8SMC8GA7VfImRjivlWLgEF1pNl2/kIr0FaG4iWTbYi8OfO7vM65FCMwr2CHV/QQ
         3ZAfsJLwn4QMrB1B6XPhmQhMk4hVHiVUDeZNgDTVlazVX0zz7RcKvRaZ5WSm2ztTtNvp
         aV9RYmnpL+KybGt5tzQV5UnmhM7CUKs+++83sI+wVhgkZ+JB7693mYVpYkmMmVYF0/Lk
         MNWo5kffcH14k4E32hLdltG+xD+7KVcO5LoVhfF49ULNnoQzT175gPPuOEGnG6Kpasgs
         w5XA==
X-Gm-Message-State: AOJu0YwOvfj3gc+nUP7Rm1nqWGy5Opd6kXiidKSzqXwtbj5BMFHgUT3n
	PKMxkLYqTqJh2kTs5vEKqa7fIREJrkpAmZnAnkuq2UvBR6HBiqhE
X-Gm-Gg: ASbGncsnPjqOMMmuCRqmpG1GlZ1L85/TO/9+9CmJwbc5dKKkfwfTWrKNq7sWeHqhMU2
	0MS1LybRzVlnIOAgn/OxWw1YecITujWkvH1wzyR1yDNP0T7+e/O6/DE+ZVOyAem9oYM3LrezBcc
	oOLo4FgXhUY30MmASZPA5NenMGDZInRek/oyr+7oa8FoYLIEGRYvg0fYu5GDRDkDGAgHdhDuKBK
	KV6FTv3+nM71Kr1XvHNNBYL+/KnVjPhXk/LCcKrMZOo6FiHXMu7AR05Qu6HQAEUqhoIV/XOpQY+
	phcfnj1uVjaEhWgOoNWYXGo=
X-Google-Smtp-Source: AGHT+IEdaZjidAr9OMxCa2uhvP3lFkmV47pxNJVxZ9/4jWqLshMXkioGTL3Mke6qIP3UzY15InFLBQ==
X-Received: by 2002:a05:600c:1c9f:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-43668642f9dmr135235055e9.14.1735035088758;
        Tue, 24 Dec 2024 02:11:28 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b214sm199907325e9.28.2024.12.24.02.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:11:28 -0800 (PST)
Message-ID: <d74396b2-2fa4-4bd3-8a22-cd22a9dd7dc4@grimberg.me>
Date: Tue, 24 Dec 2024 12:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add error check for xa_store in
 nvme_get_effects_log
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
References: <20241216155229.GC23786@lst.de>
 <20241220120046.13559-1-keisuke.nishimura@inria.fr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241220120046.13559-1-keisuke.nishimura@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_021131_009622_7605D3C1 
X-CRM114-Status: UNSURE (   6.75  )
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

