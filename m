Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B2C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:46:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25482072D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bawYQSZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25482072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nNI0Spl4+lIklNI9ZcJ3y+EF9HY8E0fkdlRXnhqqV/I=; b=bawYQSZ/mGNKxK1VmpuLRMv4N
	vG6pVO+STzu7jbZ4P19Ch16590Y0w6YfScDUaGzVhekJcLJ/OHuJN2LK78BEvdduiELU2KZbVExFL
	R7XOSP+QcLhzgSdWOEq1lpxiwTjI8DP0C6FMlObOu7jKf+6XSvzgmXH46BjJBF4scpJTNxbD+4rgX
	AWdfNcQvyDM6fw7vZXIArcZuThCdgr90zO0CmK96MiJ06DJLNZ8+Czm4tmtptaEorlimYkoX9FgIx
	6jmU26l/HXiWwGvcYe8bA/HcunOKrrdaRV6oxoh9VjQAUcRazB3Ezbjzb1VEGNwhDxHLz/ayiGVbr
	nh8gJFHyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7Zqm-0005CM-FM; Mon, 17 Aug 2020 07:46:36 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Zqk-0005Bx-DC
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 07:46:35 +0000
Received: by mail-pg1-f195.google.com with SMTP id i10so2185603pgk.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 00:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ee5itQFSWOEDMiIhLzh5r8DhEPWzJkQEh8XzjQ9XO4A=;
 b=EhHiCFFcjHNcPwdMuUcVPkjHpkCkaThR7y3cZo6U0usDiRu2OlKQfdsx2UxnoLTCXT
 2ybYJuJdJlHSYoH4B9RB8PlYT9kSoUZEDGuc8ieJeKPTcOaWfN6OAPuw1d/4aswbFtnX
 6+Yxbd0cRhBko1UiEQBVcLHIsy5LzQRN260RrQ/y2ZhOybBqgjqK14N7g4+X7+G0qxLk
 AGlsEOLCgyJXJsEOyjTrIEgSQ0rDVflLSfXovzMxX6+sOpg6FZzHG+VD2ixUHNbi+JNA
 +Il9RPMd/gbcTZaYbyEbyQyG/zSV9hmy1UNkZqfHD3QMKOQ0ubt5EBDLnvfvbdXaaxR2
 NlHg==
X-Gm-Message-State: AOAM533d5cY0r5NCAyJ4xz1NKYodDdQA8lBXVXfZLi+fP3osd2b3PJ3i
 1n9hnsvtT+0AO4MYM89VR5PfUG7Zk58AoA==
X-Google-Smtp-Source: ABdhPJwT4jtt1Rnh8cg8SDE9ijyI3xjrznMVgy4siVE/SVOKjxRMJ1k75KvPtcq4ozP6Ev6re8gYMQ==
X-Received: by 2002:a63:ff5f:: with SMTP id s31mr2342461pgk.333.1597650392906; 
 Mon, 17 Aug 2020 00:46:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c8a:c3fd:4152:60d0?
 ([2601:647:4802:9070:c8a:c3fd:4152:60d0])
 by smtp.gmail.com with ESMTPSA id r28sm18457074pfg.158.2020.08.17.00.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 00:46:32 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
 <02f6276a-bbb5-5185-6a4a-1ac7aa938399@grimberg.me>
 <20200815065526.GB15518@lst.de>
 <62ae1057-b8a2-2b0b-8702-607d72c7492b@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9d6d90a4-4c2e-6244-5cab-27c829f3b213@grimberg.me>
Date: Mon, 17 Aug 2020 00:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62ae1057-b8a2-2b0b-8702-607d72c7492b@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_034634_470752_7DF4BDB4 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> If a command send through nvme-multupath failed on a dying queue, 
>>>> resend it
>>>> on another path.
>>>
>>> So this is a race where we got a retry-able status from the controller
>>> (not from the host teardwon sequence) and we just happen to see
>>> a dying queue?
>>
>> I think so, maybe Chao can explain the scenario in a little more detail.
>> .
> The scenario: IO already return with non path error(such as
> NVME_SC_CMD_INTERRUPTED or NVME_SC_DATA_XFER_ERROR etc.), but is waiting
> to be processed, at the same time, delete ctrl happens, delete ctrl may
> set queue flag: QUEUE_FLAG_DYING when call nvme_remove_namespaces. Then
> for example, if fabric is rdma, delete ctrl will call
> nvme_rdma_delete_ctrl, nvme_rdma_delete_ctrl will drain qp first, thus
> the IO, which return with non path error, can not be failover retry,
> and also can not retry local, IO will interrupt.

OK

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
