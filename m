Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B7BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:16:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD52764F91
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD52764F91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H3aooIv7HhN7FyS3rhxC3wv1UwJ/RilaNQp7GEhKB3c=; b=aaz740ckXPeCHR2jx7A/q64AH
	N3u2dx4drBjd8dAA75jNXAHbeq6aStgwAXz9pCYAhTRywQ/vpPqrLh+THAEBVaOV/GBt+oOrnAzw+
	HlhjUbnhFymOJ1fwuNy+m1C5zDPGqH5QxjpAPHx1iQ6RLETFCKxIvEAMdTgpN1cPCF90HUZZd4Mf6
	W+1ttO0H3CTopamCpvmVKxoRM49CgzrEtaH7hoVsfPCes4wYCs6BalpJWN0cXFdTzZa1OPVTllfmk
	Bw+SD1n8mSJ+soNfax9aLM9H+owQGZGSTf5Iq7pRCTXzgc78aGlwCu/ZdS1GPtUxCDWnNlbOzYyPz
	bcpwovaGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMRM1-002jI1-IX; Wed, 17 Mar 2021 08:16:33 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMRLx-002jHf-79
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 08:16:31 +0000
Received: by mail-pj1-f46.google.com with SMTP id bt4so672491pjb.5
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 01:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OCWPNhUVCo4l9IaP/+6A20ViKaV1nld6lHRiKrmhEEU=;
 b=V9fTp0vP3hCsjmv9nFHq35/cwyPDig0n59BI9BRHl556cB3LZUyuabGLfcYdyIIaFC
 g385A+j5XxRNqJMGkcjpj0QkWPJ9bc6NumP9He+oZE9z/kMsi2hTlJdahld7062fO1kp
 ZrLZWs71NnmVzABCxjlWrbFP0O3d0X5kv5X0kStoVRh724X7m53fj800dTaGXCl3imRa
 8NhFfLX+xKMcU5cq0Kjc23mNWnvxNcJapwMiGudNx1EJjVzjpCRwlhXdYgTmITAZisjl
 hBCmiXrhLWIrMTl86X3x3tOLKSAF+rT+USZ/iRCdALOuOnEmdMAZiAyjcW5VztokLpLO
 hyLw==
X-Gm-Message-State: AOAM5326XbMiWOWrTu5t2GVUur4ssRNOvWXDgQzk5HLr6PEj99VaLfWP
 bSAWRlYSS6gC1s5k/3ICmXk=
X-Google-Smtp-Source: ABdhPJy1x2Ji6oqwmRp3skkW1x1aHM94wXWHQqpHEZvMQDterqZQQ7BTqU6HaAm1K3LvlZJ18DGleQ==
X-Received: by 2002:a17:90a:1a59:: with SMTP id
 25mr3403801pjl.54.1615968987741; 
 Wed, 17 Mar 2021 01:16:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dd5:ca84:dc28:de72?
 ([2601:647:4802:9070:3dd5:ca84:dc28:de72])
 by smtp.gmail.com with ESMTPSA id s22sm1851011pjs.42.2021.03.17.01.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 01:16:27 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a5a0c334-6fdc-07c9-f8dc-5d3eb13ec0b2@grimberg.me>
Date: Wed, 17 Mar 2021 01:16:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317065910.GC14498@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_081629_401466_3035F764 
X-CRM114-Status: GOOD (  21.76  )
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


>>>> Will it work if nvme mpath used request NOWAIT flag for its submit_bio()
>>>> call, and add the bio to the requeue_list if blk_queue_enter() fails? I
>>>> think that looks like another way to resolve the deadlock, but we need
>>>> the block layer to return a failed status to the original caller.
> 
> Yes, I think BLK_MQ_REQ_NOWAIT makes total sense here.

BTW, the specific hang reported is not blocking on tag allocation, but
rather than on blk_queue_enter blocking on a frozen queue.

> dm-mpath also uses it for its request allocation for similar reasons.

That is the rq based dm, and I think it is because dm_mq_queue_rq is
non-blocking. Care to explain what is similar to nvme-mpath?

I don't see how bio based dm cares about any of this...

>>> But who would kick the requeue list? and that would make near-tag-exhaust performance stink...
> 
> The multipath code would have to kick the list.

When? Not following your thoughts...

You are suggesting that we call submit_bio that will fail, put it on the
requeue_list and then what? blindly kick the requeue list? try to see if
there is an alternate path and then kick the list? for every bio that
comes in?

> We could also try to
> split into two flags, one that affects blk_queue_enter and one that
> affects the tag allocation.

If this is something that can work reliably then its better off, plus we
can probably kill the srcu as well. But I don't see how this would
work unfortunately.

>> moving nvme_start_freeze from nvme_rdma_teardown_io_queues to nvme_rdma_configure_io_queues can fix it.
>> It can also avoid I/O hang long time if reconnection failed.
> 
> Can you explain how we'd still ensure that no new commands get queued
> during teardown using that scheme?

quiescing the queue would prevent new submissions from coming down to
the driver, but I don't see how this move can help here...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
