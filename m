Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE57C433E1
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1DC22CAD
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LWQtRz/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1DC22CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mxFYknjd4IRTvir6td3I1suJ356jWykN+PDmqJtS00M=; b=LWQtRz/KUdU0DTxphP6QyJbsh
	03UfTCKExO10mki4hNQr6NzDtXcPBhXjuv83x94/QaQz/7peEGgaULU9Zmc6jWPXTyLQrkkPzJJZh
	7sawsIVZsblfUp/VUzZFGQJtXh/iqz7YWzfCtUjOioYbHiHc4Rq0V0DllDDMZh2H4ZoBIRhKif4Yt
	MmuhyfDeRADmbaNl1qbfC1qwi0UFc6mggZ62z/exh/RY6caBL44Mgo3BIn4urThhmM1enZuBx6XGz
	31mXxGFH+B+wEqcHBB4OG1hU+CT9IZwvv9T7dYNkynGCmSzCY5kf3X5UijkqLbNfYXXO0J+wJmLHK
	f5n+Auumw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3DiJ-0000AH-LJ; Wed, 05 Aug 2020 07:19:51 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3DiH-00009f-UX
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 07:19:50 +0000
Received: by mail-wm1-f67.google.com with SMTP id g8so4839931wmk.3
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 00:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gz0kkSVIv0Mifbaq8GuBJep9u6s5bB9Nds+vQeuzDzk=;
 b=PEUspT36xu0RAuGFpTimeb/N+T0URqFmPEyDx+DgFyf4QcyxlUMwi5rOCDtwJflWQF
 Hjr64nP6uiHVTfnAKMZhjyYhfhmg029Ntvv1Y70PcnN7UEjRaDkg7MKTq/WfbOxUhhtc
 wIO2a7NnxGzDkMorpPYSu+Pjq9m7u4l88wZm1Yd+izufSpDHUszbYq9v7NIel6x9+0xv
 uFYX7wpyY3qSZC7zemH+lHMOBQfjcMUjw8HuYnprGxihuWkG65Wjn/avUtRjhtZJJIyP
 dI0NnDYU9L0AZdF1j8aEnxp3GSPIWLIu0OxXdrEBoEtBaSjIL37WnzB/lw4Ayet8dIKw
 PWzA==
X-Gm-Message-State: AOAM531bAKRmAbE4wFLOrr4QqbYOuKdxUIch3YRQmO9vgN82GRf5rt74
 ZrlTXJsj4wz4PPsRrpLXE6c=
X-Google-Smtp-Source: ABdhPJz2VYPUbPD92gFXwgRXKZoPnfjShRhViUBBaTIwrZo1Vbj6i+lvBKF+4bR9Gux4devqsaF2Sw==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr1953629wme.0.1596611988445;
 Wed, 05 Aug 2020 00:19:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e1a8:cb16:c589:8b34?
 ([2601:647:4802:9070:e1a8:cb16:c589:8b34])
 by smtp.gmail.com with ESMTPSA id f15sm1516870wrt.80.2020.08.05.00.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 00:19:47 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
 <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
 <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
 <7250e072-c0f8-430e-3afe-d0837efe14ad@grimberg.me>
 <7a05ff5c-9ad6-786a-b1a6-9556d520f436@huawei.com>
 <ae787cff-f1a3-b464-f471-18b3d736c381@grimberg.me>
 <537c387f-61e2-77f4-a7ee-55689270bdfd@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <77794f62-2d4a-d2c9-f474-4ddbb361a308@grimberg.me>
Date: Wed, 5 Aug 2020 00:19:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <537c387f-61e2-77f4-a7ee-55689270bdfd@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_031950_086552_10D14742 
X-CRM114-Status: GOOD (  16.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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


>>>> The request being timed out cannot be completed after the queue is
>>>> stopped, that is the point of nvme_rdma_stop_queue. if it is only
>>>> ALLOCATED, we did not yet connect hence there is zero chance for
>>>> any command to complete.
>>> The request may already complete before stop queue, it is in the cq, but
>>> is not treated by software.
>>
>> Not possible, ib_drain_cq completion guarantees that all cqes were
>> reaped and handled by SW.
>>
>>> If nvme_rdma_stop_queue concurrent
>>
>> Before we complete we make sure the queue is stopped (and drained and
>> reaped).
>>
>> , for
>>> example:
>>> The error recovery run first, it will clear the flag:NVME_RDMA_Q_LIVE,
>>> and then wait drain cq. At the same time nvme_rdma_timeout
>>> call nvme_rdma_stop_queue will return immediately, and then may call
>>> blk_mq_complete_request. but error recovery may drain cq at the same
>>> time, and may also treat the same request.
>>
>> We flush the err_work before running nvme_rdma_stop_queue exactly
>> because of that. your example cannot happen.
> Flush work is not safe. See my previous email.

How is it not safe? when flush_work returns, the work is guaranteed
to have finished execution, and we only do that for states
RESETTING/CONNECTING which means that it either has already started
or already finished.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
