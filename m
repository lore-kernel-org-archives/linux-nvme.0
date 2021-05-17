Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB75C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 22:16:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32FD611B0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 22:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32FD611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HG5NDJVbpixYqC9oQW0JFfb7zXH6FEkdacXT1WfnkXc=; b=UDHueFIsReAFLnkwsu8asTV2p
	a14qc0K6y5LzXEqd7i2x4ZigMqKaoFV5oE/C12sJYuCyyrdAmjaNOr0aQOHyOclXhOnjJWFl/V4Eo
	vyeiBpL6cbW9Ln/Q940fiPh279D1buaRgu9ty5E5jvi7ryUH6QJGaz22WqdJ3m0uURvcolocz5MQ2
	8rSriUQ0c6B10A/4gHuYx5kcfHjnwnrJJ3gcsAA9CvkQuKk+ctkdX2OSqs9pPuGZHm0RMM9dFudYx
	9yNGNQVfWxSkuRuys97gLI0MLs4jobW+UdZNP7ffIYfYxx++ONbhIStOSXCIiE69i1RMiLjqcJAPu
	0dZLJXCkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lilWg-00GHyy-64; Mon, 17 May 2021 22:15:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lilWc-00GHyi-Tf
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 22:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=3AYA/b5vqO39gPlgrQQIBoYGbNXvY+nqnxHFd/b6BkI=; b=rNDxr1MdW9aDf8ZwJOomrpiNyp
 hYD0B79GbzJP4pTiiXgyrDKGVQekZYGYIzaJRxCNUUgG7yO6DwcwR9MBjJo8GAqPQQry3UBaYDAMg
 cCq7lGnfv+5qqDqm+X6Gp0r+hhIrZD+yAhT+TlPfM/dbsaONCSkYVcauQQx94FEVK4806vQkDNSf9
 P30FoeGoU8ldN9gwMbEnIAYPaE3+d3C3rtVEjmxZvU4br51H1GeXT56DyjpQiMfuYWJBt90NVapbJ
 r/5k+9Uf1Tpo/sjn/cpPFmWcvUNbZwP0drxuTbw1ywNj0Y7+QLGKDlttV+rSdCtM4XFLzugQiPlKV
 GTxx80yA==;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lilWZ-00EBLK-VI
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 22:15:45 +0000
Received: by mail-pf1-f178.google.com with SMTP id c17so5939305pfn.6
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 15:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3AYA/b5vqO39gPlgrQQIBoYGbNXvY+nqnxHFd/b6BkI=;
 b=FQPXaUmLOl5mJpCv/eCmU56rU6N8qo4Gcvbh5vp9QAci7addyEDtwS6KDfyyyp4zws
 NDfbikJfrWGCiZUehrNwuPzu7paY9Ieh3bYw5M6OrjuumEeoZG0g756Hx24l9bQblYdF
 ZwgJZo35NWOHMXIyzY+dq5AQdTH5LCVa9+dsZ6cnMeWLJ+9L7SKkFinLrrzav3K55xdR
 vNOKCq+mid+rQnlhLKSSv1XnPSDfF8RJqsWUxWthj+76eEVJCpG1j8z/vrlRbDp23Wc2
 eaAXf49urzyr/MsDtCtJ/n3W6HooxLwJ7bel3SAbADc/hVcyd3ktWXg5IEtYnh09TBa8
 QIDA==
X-Gm-Message-State: AOAM533cgDBensu7aI9pGpLcgmUaX5q1Bepxm4+cX8U6L3EZ66C4u/C+
 OWtMKogx+1ZUDHgT97f8fk0=
X-Google-Smtp-Source: ABdhPJzY/HOmDkA5eSbUAcWC4I2tVbgMRmb5Izu7yMKUQQcv837VUSS8RbAzB8TjsxNAabaNA2nfxA==
X-Received: by 2002:aa7:828f:0:b029:200:6e27:8c8f with SMTP id
 s15-20020aa7828f0000b02902006e278c8fmr1631220pfm.44.1621289742893; 
 Mon, 17 May 2021 15:15:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id q24sm11320898pgk.32.2021.05.17.15.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 15:15:42 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
 <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
 <64e3ad99-8435-22c0-bb11-cb9ad08eb52e@acm.org>
 <6474b916-9911-ba34-bd35-e5b5c7d11ac5@grimberg.me>
 <decf0b41-fa05-410c-80ab-b7f8de5618a9@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0a87055a-8156-c6fb-cce9-480edd1ec652@grimberg.me>
Date: Mon, 17 May 2021 15:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <decf0b41-fa05-410c-80ab-b7f8de5618a9@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_151544_044692_003BA4B5 
X-CRM114-Status: GOOD (  19.78  )
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


>>>>> Additionally, I do not agree with the statement "we never create such
>>>>> long queues anyways". I have already done this myself.
>>>>
>>>> Why? That won't improve bandwidth, and will increase latency. We already
>>>> have timeout problems with the current default 1k qdepth on some
>>>> devices.
>>>
>>> For testing FPGA or ASIC solutions that support offloading NVMe it is
>>> more convenient to use a single queue pair with a high queue depth than
>>> creating multiple queue pairs that each have a lower queue depth.
>>
>> And you actually see a benefit for using queues that are >=40956 in
>> depth? That is surprising to me...
> 
> Hi Sagi,
> 
> It seems like there is a misunderstanding. I'm not aware of any use case
> where very high queue depths provide a performance benefit. Such high
> queue depths are necessary to verify an implementation of an NVMe
> controller that maintains state per NVMe command and to verify whether
> the NVMe controller pauses fetching new NVMe commands if the internal
> NVMe command buffer is full.

I see, thanks for the clarification. However I think that a host may
choose not to support a full blown 65535 depth just like devices can
choose not to support it. As for testing your device, this will move
to the same category of all the other things Linux doesn't support,
as needing a different host SW to test this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
