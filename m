Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A30BC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:11:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A72322247
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sdoA55My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A72322247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t84CMDWrR8NQIIshh0np12VOuW1R46x8CWb+xY5zZgM=; b=sdoA55Myy0Gk6uXS0KLmN6kBR
	dLPTYpvg3xcG2ixEge+MJVTfU3b7kTkfoxcb/k2aSMHvq3YNCg0TJjZg0xA7zeBkc8/RTIL1S5L/x
	EavQ7Do1mAI2iPCkho5CMcn9VRAIJKyfGB3l+bnu68Fz33Py8o49npydk6VnSHH0GJpLsUBiIVjEN
	cZUgVENPpC7EZ9yZ8IAApL/2Dr01h5kboyVtRFHqNoXgYJArqss2W3LEvt51MPkJ+xpw0SxKRdS6I
	q0Vzd0gRO2MIk8cgcvLrFwn0xJVPlmj/VpzjHNqc5yHIjgwdr5BEhLVmGW0lAAgrmCauHAqEEPClf
	WUu94XIWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUmjw-00061D-L7; Tue, 20 Oct 2020 08:11:28 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUmju-000609-Oo
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:11:27 +0000
Received: by mail-wm1-f68.google.com with SMTP id q5so840117wmq.0
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PrzDcCSg58tLG5OCWN/DAVZsKK40F6GDbr2bMNkjeOI=;
 b=Gd4Akpl640kHUg/bC84KSDY9pTiq3KBjpW42KnvkCEpmTwnkcfYxhVOGTKGJ5+/P4o
 /9+pXKjWHRGKBSbYlVCwbckcXkcsiSxfJ7IsFb29XJ5KuvWr59DFtpLK+PmJP5v2f7xO
 pxwMBFnAX+Jmt7UqyP9FFzzO7eMU1disrdx74uL19ph9q0e2L3DJI1VRTF9yYI62mzOv
 ljceSGMDUb33aRKTqDE3VDpWDNBsaDzSlgUQlwZkvbhhRAXPM+YcG+w5E2PZwBlMXZ1B
 lJfD85KS24STE4fRB8XE75PdgBSpwsQwbV+nUCD/g0iv2Zy/A5CR2WWjfnJ4NqvR/JJu
 etpQ==
X-Gm-Message-State: AOAM531lCMik6cQ5yT22lzyCwIsBFode1MerqkYG040B2vgCqIB5Asyg
 ARnWL7ZL6xCN5UPAVXGa5Cw=
X-Google-Smtp-Source: ABdhPJwwUZ2t7Zhxa7NQMi8fvWT9QiqN4uHYzcGFQJpBd7BxxXvNckrZbQKabn6C2Nu34t6OK+oMiw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr1547150wmf.67.1603181482022; 
 Tue, 20 Oct 2020 01:11:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:104e:47d9:f0fe:a697?
 ([2601:647:4802:9070:104e:47d9:f0fe:a697])
 by smtp.gmail.com with ESMTPSA id v6sm1770762wrp.69.2020.10.20.01.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:11:21 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme: tcp: fix race between timeout and normal
 completion
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-4-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9d2e28e-fb55-358c-3e8c-6f3e9dd91c25@grimberg.me>
Date: Tue, 20 Oct 2020 01:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016142811.1262214-4-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_041126_808884_2A67F321 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> NVMe TCP timeout handler allows to abort request directly when the
> controller isn't in LIVE state. nvme_tcp_error_recovery() updates
> controller state as RESETTING, and schedule reset work function. If
> new timeout comes before the work function is called, the new timedout
> request will be aborted directly, however at that time, the controller
> isn't shut down yet, then timeout abort vs. normal completion race
> will be triggered.

This assertion is incorrect, the before completing the request from
the timeout handler, we call nvme_tcp_stop_queue, which guarantees upon
return that no more completions will be seen from this queue.

> Fix the race by the following approach:
> 
> 1) aborting timed out request directly only in case that controller is in
> CONNECTING and DELETING state. In the two states, controller has been shutdown,
> so it is safe to do so; Also, it is enough to recovery controller in this way,
> because we only stop/destroy queues during RESETTING, and cancel all in-flight
> requests, no new request is required in RESETTING.

Unfortunately RESETTING also requires direct completion because this
state may include I/O that may timeout and unless we complete it
the reset flow cannot make forward progress
(nvme_disable_ctrl/nvme_shutdown_ctrl generate I/O in fabrics).

> 
> 2) delay unquiesce io queues and admin queue until controller is LIVE
> because it isn't necessary to start queues during RESETTING. Instead,
> this way may risk timeout vs. normal completion race because we need
> to abort timed-out request directly during CONNECTING state for setting
> up controller.

We can't unquisce I/O only when the controller is LIVE because I/O needs
to be able to failover for multipath, which should not be tied with
the controller becoming LIVE again what-so-ever...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
