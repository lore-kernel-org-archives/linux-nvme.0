Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69972C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:37:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69F6619B2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69F6619B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9cNJ9u86uycEKfA8Kpjp3tY3k3eH87E+2604ABsc4Sk=; b=O9oSoqh8wQRBo/mAcyLZeAfxE
	Ja6oJ1lnKJSOuPVgaLMUQAcHwoPlO1AEeHELfa8vzuYJdPTCpCFxdWm2hqalsRbo4qdTdyutczBkA
	TAN27WTxEpMkazrXmAaK+z6JNwULJMQIdrdwqwudW4dvWm1iE+JwV5thHZj71jAhRkw0kHk58xIMw
	3KQiYjIJM7Ldg1HuKhDNhZG4xU/EDsnzyeLZVGTrUAmKy1DcvniyB5UPOD4J+GrbdPxTC/w5kYc2u
	ReXV4n57tkjVHZfkVSX6OuXrhLXu32mIBK1XyvNBwyr/YT3RxPPdOaxTFBvX3lAuR0CP+2I0p54Uf
	i3Z2MkqSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lObas-00EAfb-Nv; Tue, 23 Mar 2021 07:36:50 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lObal-00EAdW-Nu
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 07:36:45 +0000
Received: by mail-pg1-f182.google.com with SMTP id f10so3747824pgl.9
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 00:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E5IJ2NTiStWRS0yTKBe3muHCvR7EJ4ZBfZfPHNWN9Qo=;
 b=GUgrp9cUxQOwsz4sbZaHvoolFhWPxf6sSufgt1WRVRmc5svPizeIhXnuyc2UCZMm4L
 uy75Ry5CKeOIVS/Mu4YKuUD1U32lYarZYMxB1W3WmxFKyG81/KdZTRKB0hE4/5aigZBd
 cUPKGhVkqN6Qc+fLPWjBc3uK0bKTGW3Usoq2xfjUVyxpmBhn6OK4RI6YJDkyfcFnnCqO
 iyH6CDWd6WUe+x2zYtir0gRtjZfJkbCqhdJXQkslTqiHA7G2rW7kCO1Q63+Rs5dAPiqZ
 Rf4ewG5tq/6IumLOwAMK9nQ53yaOYeT7yUtIY9rOOaqLeb+m+udICtil4XF8TWMcVO0B
 DDlA==
X-Gm-Message-State: AOAM533HWN3Z75X8hMait4Ry9+zNrEpReiGhdDH4w2lgbLjGz5hsJYY8
 21sCC82KhxUZ2iS8cihWG/sojov7To4=
X-Google-Smtp-Source: ABdhPJxVLzwYncrnsVjWUzV3i2OM0Wtug3Tma8WY3A+kKqFBL0Wxapp1CsBYjdfxtNRzARUw1CJzsA==
X-Received: by 2002:a62:7f45:0:b029:205:9617:a819 with SMTP id
 a66-20020a627f450000b02902059617a819mr3286098pfd.17.1616485002091; 
 Tue, 23 Mar 2021 00:36:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0?
 ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
 by smtp.gmail.com with ESMTPSA id kk6sm1594441pjb.51.2021.03.23.00.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 00:36:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
Date: Tue, 23 Mar 2021 00:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_073643_933587_AA772CE6 
X-CRM114-Status: GOOD (  16.60  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I check it again. I still think the below patch can avoid the bug.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41 

I don't understand what you are saying...

> 
> The process:
> 1.nvme_ns_head_submit_bio call srcu_read_lock(&head->srcu).
> 2.nvme_ns_head_submit_bio will add the bio to current->bio_list instead 
> of waiting for the frozen queue.

Nothing guarantees that you have a bio_list active at any point in time,
in fact for a workload that submits one by one you will always drain
that list directly in the submission...

> 3.nvme_ns_head_submit_bio call srcu_read_unlock(&head->srcu, srcu_idx).
> So nvme_ns_head_submit_bio do not hold head->srcu long when the queue is 
> frozen, can avoid deadlock.
> 
> Sagi, suggest trying this patch.

The above reproduces with the patch applied on upstream nvme code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
