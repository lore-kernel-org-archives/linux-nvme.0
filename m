Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F659C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 20:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7FB206DA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xgyjLpUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7FB206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qHEE2583gVO8YIvqAW/qhtDmowqrVALdYL2hbupHqQw=; b=xgyjLpUSJam/9aotLjwYsAP7Y
	KLOrdy/fifctIEtt6AlBjA1cPZ8Asd6EeTz/vTlxpXzSHJ5xHg3zmKW2WHD72KFXu+AgbumJ6pPor
	f5L083fB1QNwQfUljUgAaoTZ05icY7wyYRVAYpl3z7F+ea2JxEoidrG2TuBl9jnh2Li0FhfzohrfJ
	BWHMv9EjvR4g4uv6Kmcl6q4OnpvtVcU0v+xxEFQYCCMRJQ+A9o+ucqpR9Q6QdCvVnYOxk976kikDG
	ZLuTrr8ycEL0Tw9J9gV39hCsAJwUJoQ2lTJIbuWRlGkriOJoE+DcryaxGlBXxc9saFbLdBeA5/eMF
	kgpGTwkzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9DWr-0001cl-Kn; Fri, 21 Aug 2020 20:20:49 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9DWq-0001cJ-1q
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 20:20:48 +0000
Received: by mail-pj1-f66.google.com with SMTP id mw10so1290083pjb.2
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 13:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dJMzHfviirM1U8lBLyKGc//MVf+tB6J0uF/OqxxaWTw=;
 b=a1CRQU7SCDJTYDR5aHvRCGtUiV0g9CsLdj8CC7yNEGsuuHgsZSPMlHlvmRFYhJ8aLx
 AhYnd6fTqrwNs/IdHXn7qoIT123tvlSS75kh3F9P3WZkKZ9vlY8/UkQx5OYdlMifMAuF
 8lu73l6GY8T9kR//N7D+NHACl7p8h+Sjoy4H+dJKRhFwGT4SQzJcKUem7+aaKz4Xce1k
 ksHX3eEN4lNsUUI2b2K8Nu5PQUFhucr7ipy42j/Y6Vh8R5TC482Ea0djEKH7dyKIr2kS
 lRQDyvgiGRxW/kuHIU/h9iYlzupw02Pz5fEaOS5Civ/4j4tSoENNIqZ7HDbiQN0jOtwj
 dn7g==
X-Gm-Message-State: AOAM531NNwo6ULZP+9U3XRQyfE8Iomh84i435S1zSyJg1otV2CyPUm3L
 q8uhICNsA1fC55WnUD9TCOU=
X-Google-Smtp-Source: ABdhPJxFXJiwnVJXLTG0fTB1XlRaZIzywZpgTA9Id7ObhHVVrknMkK1ybYTt3ImA+BlbNcR1D415UQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr3877687pjg.197.1598041246812; 
 Fri, 21 Aug 2020 13:20:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712?
 ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
 by smtp.gmail.com with ESMTPSA id il13sm2583060pjb.0.2020.08.21.13.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 13:20:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
References: <20200820035406.1720-1-lengchao@huawei.com>
 <20200821075034.GB30216@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbf66315-9e36-2105-535e-a90352ec5306@grimberg.me>
Date: Fri, 21 Aug 2020 13:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821075034.GB30216@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_162048_137760_80CAB30F 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> A deadlock happens When we test nvme over roce with link blink. The
>> reason: link blink will cause error recovery, and then reconnect.If
>> reconnect fail due to nvme_set_queue_count timeout, the reconnect
>> process will set the queue count as 0 and continue , and then
>> nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
>> because the admin queue is quiesced.
>>
>> log:
>> Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
>> Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
>> (881)
>> stack:
>> root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
>> [kworker/u12:4+nvme-wq]
>> [<0>] blk_execute_rq+0x69/0xa0
>> [<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
>> [<0>] nvme_features+0x73/0xb0 [nvme_core]
>> [<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
>> [<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
>> [<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
>> [<0>] process_one_work+0x1a7/0x370
>> [<0>] worker_thread+0x30/0x380
>> [<0>] kthread+0x112/0x130
>> [<0>] ret_from_fork+0x35/0x40
>>
>> Many functions which call __nvme_submit_sync_cmd treat error code in two
>> modes: If error code less than 0, treat as command failed. If erroe code
>> more than 0, treat as target not support or other and continue.
>> NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
>> by host, is not the real error code return from target. So we need set
>> the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
>> the error to INTR, nvme_set_queue_count will return error, reconnect
>> process will terminate instead of continue.
> 
> But we could still race with a real completion.  I suspect the right
> answer is to translate NVME_SC_HOST_ABORTED_CMD and
> NVME_SC_HOST_PATH_ERROR to a negative error code in
> __nvme_submit_sync_cmd.

So the scheme you suggest is:
- treat any negative status or !DNR as "we never made it to
the target"
- Any positive status with DNR is a "controller generated status"

This will need a careful audit of all the call-sites we place such
assumptions...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
