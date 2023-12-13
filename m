Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4961CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=84wm3PSFhk8WuRegTiR9tLiyORQc/j4zd70U6nvfX/c=; b=nh4UxB/5pacFUR1ewhNq9AVU+r
	onHxYYwYuV4xsm1xlGl2GON3S95onRuSsI4bbDGRzPFxGtJl3YPl4rsvGYYpsd/+qn1e1emCeQOBK
	ND4YlZwFZUqg5YB7YA7IrbvwfNbJnchVJnPkBEgEd3mvJGZ0pJyDwPgAWzaKhTg4HEGnX8RfPKKyy
	4xFMSwKu/8BuUpv4CgGA3HHu5WKzfcTt/yzkCEnUijtnegV4Oqvw9FToRxqG2LyCSH/FPYyV3TmjW
	ZJpzGier/kvXUnosglaXt4K34i704HpeeCU9Ah1sOEVEZaLxGhba/RLBKMwVcnpa4rCkEMjk/VDAk
	kkiA658g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOsW-00Eiup-0S;
	Wed, 13 Dec 2023 13:02:20 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOsT-00Eit1-1L
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:02:18 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1f8313c781so147923366b.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472534; x=1703077334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84wm3PSFhk8WuRegTiR9tLiyORQc/j4zd70U6nvfX/c=;
        b=lEAK0qwa27sxDAcz+uwAhYlKB0UxGw5vdi5o+hpZXqVh4hs9ELTHv5V3KG9H3xnuVw
         sYV5e/jvxHFvuaaQt969LZ4LXGuprIDbSRSa7oEd/BfUWEQajk+XuMEsA2P/e1A+a27c
         uqaJYjmF0z4M+5TSy0Vydj4f1B2jEjOFvpIdyy3SffFm3xbKEhEb32H4c3s1DmAGEQfR
         NQfNhdho9IIDsNejT14ZWiw317lDkcDPciusEcXArvdjusX9MLfsZuZPJlpdllSkY3is
         FNlxDCJXm8akBR4rCoi0EVtdLNKIq8TX1QDkFkrrvlRVXQ49HU/+LHpvhKI++YBAMkEp
         tViw==
X-Gm-Message-State: AOJu0YxGOtSwYw/onjQkBjGho93IKcpgFbJTpCHFeif+tkSb2+V/ENVx
	lM2w4+RGUmul2kmUj4Ha4zY=
X-Google-Smtp-Source: AGHT+IFgFeQjDqSHVZ5YKbkGypNAlrnPxOKmLotn2y4EPfnSq9rKDzypn0d2JuPAYZDFKOjKNzW7vA==
X-Received: by 2002:a17:907:d404:b0:a19:6a79:2d3f with SMTP id vi4-20020a170907d40400b00a196a792d3fmr8878947ejc.1.1702472534204;
        Wed, 13 Dec 2023 05:02:14 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id tq24-20020a170907c51800b00a1f9543a540sm5074707ejc.160.2023.12.13.05.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:02:13 -0800 (PST)
Message-ID: <e286d88f-5006-4878-a05b-a0c877ef78d0@grimberg.me>
Date: Wed, 13 Dec 2023 15:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme: avoid deadlock warning in sync_io_queues() path
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>
References: <20231213051704.783490-1-shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231213051704.783490-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_050217_448305_AEB35D6F 
X-CRM114-Status: GOOD (  15.63  )
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


> The commit c0feea594e05 ("workqueue: don't skip lockdep work dependency
> in cancel_work_sync()") restored a lockdep check and it triggered
> deadlock warning in sync_io_queues() path. This function locks
> namespaces_rwsem for read to traverse the namespace list and calls
> blk_sync_queue() for each namespace. blk_sync_queue() calls
> cancel_work_sync() to wait for nvme_timeout() completion which has paths
> to lock the namespaces_rwsem again for read. These two locks are both
> for read, but it can cause deadlock when another task has a lock for
> write. Hence, the deadlock warning was reported.
> 
> To avoid the deadlock warning, guard the namespace list by SRCU in place
> of the namespaces_rwsem. This avoids the deadlock by the two read locks
> since writes by other tasks do not stop the reads.

Based on the report this is triggered from the pci shutdown code path?
I think the problem is that there is a dev disable running together
with a reset (driven from the timeout handler). Perhaps this should
be addressed.

I don't think that making the namespaces lock an srcu helps us here.

