Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BDC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfB0IIWFmWA4byjR9DVd4G5yzVB/O8UFaT2kngw6pT8=; b=FLa/sfTW7nzvhmmIw4myQ3ZBua
	yw/9xa7GYK6HIYqLlCvYbBxrB5jHsL9ciroRGtLcaeitvhhdLTDjVjMohFvF7V+S9uyETx85iLdI2
	wHKv1nQm7/EXj9Dq8qeV6xlr9KO3JbJ8gefeDVXkvByvIfnNu/tLDw8Zu/iC+iJ7L7IC8t80n7AYd
	LSHCtqb2KTEVQJOqNHN1ZFBdVN4y0x4fr1HGTNu1cCVTiOjudZAHiIM1J0Rbdq8eH3IXoC6xOg6Tp
	wDPCiEhb7MSWPE3eJxjqE4R/xfc8oF5ZD7SGIc0yHNGF6DEuQPsWm45hPD5yAvr7b/o2GSKziC/Th
	HWVIT/qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JK7-00H6Uh-0y;
	Mon, 05 Jun 2023 23:09:15 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JK4-00H6Tq-2G
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 23:09:14 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f616598bf3so359900e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 16:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006551; x=1688598551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfB0IIWFmWA4byjR9DVd4G5yzVB/O8UFaT2kngw6pT8=;
        b=QZn2Hr7e7kFEZdBVr0b4ouoH5nrcULGYzEloi9uvRNxAJAzfJx1KJExO341R0WNnpn
         wK19UKga4Hz1jkSFzHuhHgiCzAN9Cbhz507lOGwOidi6ShiSPRKM03XZw6jx16YIBMyx
         E+C2hnPbeXpm92Ag8zgLlTNoTYMxgwIn//YhjNjEO0LEJpyYVwHjJfWknRMv0SwzuVhO
         H5fUa5FdVbJoHKrdBpYjzkCLYAK4dosFuMhzSqTjCd9Biu/L6WHkPrVqM8FcbaiuyxH2
         lN2XcSzBak4v9hLbo7OmIcMQaF+y2HRfBOfWwtkEq0dpNN1MJzfy+8X8ZSqspGf8u8Ds
         gyPw==
X-Gm-Message-State: AC+VfDy6rh3B6D3a6pmPCfILnMMD/H1D24TWMCPHVFuMQV/1QVNGubQM
	NyEkBczth44+yKx++jsM3g8=
X-Google-Smtp-Source: ACHHUZ6ckcSXrcgzv3Nd4m7RtjFZaG5I73JpjFq5tAshEFLiJbb9ULiae6jnWiV3Ad0VmSk7xnBpug==
X-Received: by 2002:ac2:52b4:0:b0:4ee:d640:91eb with SMTP id r20-20020ac252b4000000b004eed64091ebmr162880lfm.3.1686006550601;
        Mon, 05 Jun 2023 16:09:10 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id t4-20020ac24c04000000b004f14591a942sm1263613lfq.271.2023.06.05.16.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:09:10 -0700 (PDT)
Message-ID: <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
Date: Tue, 6 Jun 2023 02:09:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Content-Language: en-US
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1685350577.git.chunguang.xu@shopee.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_160913_110279_DA658652 
X-CRM114-Status: GOOD (  12.68  )
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


> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
> while removing ctrl. The root cause may due to the state of ctrl changed to
> NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
> nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
> freezed and queue is quiescing . Since scan_work may continue to issue IOs to
> load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
> hang in flush_work(&ctrl->scan_work).
> 
> After analyzation, we found that there are mainly two case:
> 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
>     new IO to load partition table.
> 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dispatch
>     queue, leading scan_work waiting for IO completion.

Hey, can you please look at the discussion with Mings' proposal in
"nvme: add nvme_delete_dead_ctrl for avoiding io deadlock" ?

Looks the same to me.

