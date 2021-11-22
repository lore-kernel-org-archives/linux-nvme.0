Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CABC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2XjOzACDW7rUkmtrfr1HAifUKw3J31vQSKBnxuwuJ8g=; b=lBMH8lJo8cT9o35ZiEFWao+lI+
	BmbPigrDNLY9UleRnCgcF/PU98D5T4bvBrylA+c1TcXIwcBiqN8suo8NMl7uVLNAdgiHR5qk2MWqB
	DNW/xtRhtrb9UGFCUpLQh1Qt3xE5ShYTLWN5Y+NSuQ+n8cbHyenUlOZafpxcw65uhMPyfgVvDleGH
	i4RiV/NKOjppKb+sLthOhPZrplN7kKxC7W0ck0UsZuHWqM+4wfVLUIDqWQUDN0bXWaKjJCquS8aAj
	Z/dCIaqKEhV9e4wVBeDE7D0bBWfuQepoXMMtZqSle9GdO4n0Hjb2k8R0dWoFr/+TyJ1jmKDbJF6JV
	3jXa4gbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9nL-00GlCj-AF; Mon, 22 Nov 2021 13:55:43 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9nH-00GlBB-MK
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 13:55:41 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 i8-20020a7bc948000000b0030db7b70b6bso16865827wml.1
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 05:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2XjOzACDW7rUkmtrfr1HAifUKw3J31vQSKBnxuwuJ8g=;
 b=3kbga6xFbQRfLOKKt4zjRzfu9rR9RjEAJYiB1uA7oeTxP32SfyRo/I6TeFmbBy8RRZ
 CQFGcFn12wJ04MZEk18j+J/CtnXRTukaQxIem5AnRNN7/7c/YyfLdNP3iPed2Py2+q1K
 qcLbI+ZKETy3L6dqTvFqybNIxPSHg2QUcUbDR87Fuik9GsTMDYYZaJU/N5ezx3cKoI+j
 ZZHBhwYq2z0j75gFt6ecaAy7VJ2zg/6J9BMjybnD+K0guGB+gqlqTfyWfqBlW9leBkYM
 nDjsOHeU+Z8dklYz4c7TbKW2r4XwODO38ImTPjZPMiIxp2IOpuKH4QGkWJD6PTqV0u2T
 azqg==
X-Gm-Message-State: AOAM533OkgLQOLXOjkZfHs9w4Ui/itUns5cjjkILTsG7U1ffkbKz1cl5
 pp/B0BLpbyyltqUbKyfZ5BE=
X-Google-Smtp-Source: ABdhPJwnKiWn1edWGJeYIgb4UdPnjH6KQyYj/SgbK8Y1T/NH4oHrBbgWTMmkZ4uecxdgm7i6xBvEtA==
X-Received: by 2002:a05:600c:1d97:: with SMTP id
 p23mr29788839wms.186.1637589338490; 
 Mon, 22 Nov 2021 05:55:38 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l5sm10895275wrs.59.2021.11.22.05.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 05:55:38 -0800 (PST)
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me> <YZuagPbZJ6CjiUNi@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me>
Date: Mon, 22 Nov 2021 15:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZuagPbZJ6CjiUNi@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_055539_796947_519398C1 
X-CRM114-Status: GOOD (  13.02  )
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


>>> Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
>>> queues in parallel, then we can just wait once if global quiesce wait
>>> is allowed.
>>
>> blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
>> obviously it has a scope.
> 
> How about blk_mq_shared_quiesce_wait()? or any suggestion?

Shared between what?

Maybe if the queue has a non-blocking tagset, it can have a "quiesced"
flag that is cleared in unquiesce? then the callers can just continue
to iterate but will only wait the rcu grace period once.

