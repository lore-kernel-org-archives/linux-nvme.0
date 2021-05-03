Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44EC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 20:00:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A9361159
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 20:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A9361159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Brn2WnLMuGS7YMWCMpU35znmc5oZlXJJKgjN0NSK2Bg=; b=OeyzE3cN+1M+tBYwYW7qXFIBt
	c2K4IsjMK5SriyS9wFyI8Tso6+BMClReenbk7BxXUvP/5RithvzT+nXNeldGWqhBKirgHlc5rRXKG
	6XCM1iGZ2Y+wXz404zC0t7uUft0S2YkIv/l95cm2hu358JTcY6GS4hvIK0PrvvNldueZP0sEmvPcB
	jUEDHQozKBwpNP/abi7htrxTHDmbTX+e4VktMjK8OlmYAJZ17bYuDuZcXSeB/NOMXPg0OkZBwBALB
	fCpAt4ACxHBi2G+eVi7+nPU7zgRjgP0YQ1v5dG3FsWYF+YUX1DG7Xj2gfj5uNx0ZmgulMk3BMICcI
	OSF0xN1RQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldejn-00EmSJ-1X; Mon, 03 May 2021 20:00:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeji-00EmS3-54
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 20:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=b3GjURVVLBsnNgF32vlm4GDf/y3UwlG6Wsg1owdDoD4=; b=qZ7b+bPFouSROu0Tq7gSspGrcD
 zUm2BFhr9MC9YpsaACKOuZU4cV89uJOTQMFxwlxwQiJKfqgJHvkQlS5iFsW4wPmoavm8CJsXb6dkT
 LOkaiG3UYH45Xfd9gpPxH/g/lenR70J15fBjU7+8s4j4bL4ACOPfS7WohFI8C8cmjVGUAMUIO/2tw
 4mXI6DX3+/nyUEhwdOX1wjR75gv+y5RuGZkso3CPEabbqHaDWdbpziupPUYmCHBqjxptBUfHmGLIO
 kKxTWX0i8j23DrE5NTAbb4f57baV0m0xYg27TDQHk1lhGCGuDEHrNxTACwUTMLWbubwOaWjpWVW7P
 waetskyg==;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldejf-003Rv4-Oj
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 20:00:08 +0000
Received: by mail-pg1-f180.google.com with SMTP id s22so4511481pgk.6
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 13:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b3GjURVVLBsnNgF32vlm4GDf/y3UwlG6Wsg1owdDoD4=;
 b=bmT0pqVmqkpeNVZZKd7dAnHaXVObx8tm6W/2BMDdVl6oCoi950Mf3rrb1gn/51rbDM
 3AfVsJbozuUtzKxlePI+chMVSrB2ezWTG1yTlVrtOc3s/WpFj2WIUgSwdQzjtuE10X/9
 ouNA/Eqf8QZJqeVubL1OrkIHhtlB4J2NnS67byFboJkG7n/GhsTGJCBNBYau5eQ0Wdm6
 0nGojosZ3tah+LAgTXDd9kt95Ph1WQRlTFGMVq8/SW7vt+LQar8LnEASR5910oX1KiRm
 iVBxiAL+J6Ut0VfZWaJ8+LvU52SJiW52nMiJ6AteXGMhl4YDk0EYgXfHbvHLxH0vXjAd
 gL2g==
X-Gm-Message-State: AOAM531I4izxv2WaIexQeQBbz+gjwGz8n+u7TU/OB1FtcYMF4h2L6RXn
 QIycukpXHxuEf20656zB69UQRS+e8BM=
X-Google-Smtp-Source: ABdhPJzIoF4SvpMN4w1EAPYN+7bfTN5TWWgxTjG/pzdU7d9vRLodP5KicQu6Wrw7b3+FxDqPyRja1Q==
X-Received: by 2002:a17:90a:5295:: with SMTP id
 w21mr365893pjh.27.1620072006642; 
 Mon, 03 May 2021 13:00:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4840:6f98:816c:4241?
 ([2601:647:4802:9070:4840:6f98:816c:4241])
 by smtp.gmail.com with ESMTPSA id 33sm422351pgq.21.2021.05.03.13.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 13:00:06 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
Date: Mon, 3 May 2021 13:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_130007_837344_4436D3FD 
X-CRM114-Status: GOOD (  16.39  )
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

>>>>> Hey Keith,
>>>>>
>>>>> Did this resolve the issues?
>>>>
>>>> We're unfortunately still observing data digest issues even with this.
>>>> Most of the testing has shifted to the r2t error, so I don't have any
>>>> additional details on the data digest problem.
>>>
>>> I've looked again at the code, and I'm not convinced that the patch
>>> is needed at all anymore, I'm now surprised that it actually changed
>>> anything (disregarding data digest).
>>>
>>> The driver does not track the received bytes by definition, it relies
>>> on the controller to send it a completion, or set the success flag in
>>> the _last_ c2hdata pdu. Does your target set
>>> NVME_TCP_F_DATA_SUCCESS on any of the c2hdata pdus?
>>
>> Perhaps you can also run this patch instead?
> 
> Thanks, will give this a shot.

Still would be beneficial to look at the traces and check if
the success flag happens to be set. If this flag is set, the
driver _will_ complete the request without checking the bytes
received thus far (similar to how pci and rdma don't and can't
check dma byte count).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
