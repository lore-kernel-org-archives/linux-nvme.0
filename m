Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB633C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 03:03:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E8E61019
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 03:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E8E61019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F8OGgSictZe7ePIw6Qd1MQNUK6PccPc2EnTb//DKqR0=; b=EyArijQuorzicjdry3gvZg+TM
	ath30itVzJdclwPFAQZKLV9sfZ1b7u/aa/3kGzlYeqABj5GEjwgertmY1pL0Tyzw1ifTl3mw34sjo
	mc6fVlewPhVAbZEPtVY4ZG/LQXZP4wqZ094l3UNsFC8J5WLcpOi6XvRnleZJed3Mti2iLzVx1c9iI
	dl9EBnsi7nDKDAKkoWvrADJBUhWUKEK1/YqHpFBkZVsUtvCo2jMnrloP8iOJfyZeYTdChyfdhFRD3
	+e/ACwX8QszT4XUpoLXYP1b6W0vnZHpqMrBgW1QPlU1lMi++LxvD/YeFq1XVgmuaSSqtNPtjxgEpi
	uBy+d/wEA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liq0Q-00GmoW-Bv; Tue, 18 May 2021 03:02:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liq0O-00GmoP-Et
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 03:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=FeML/C+dz+EFiECeAqqlAd3BLBfkRjaOs3WWybMiChc=; b=PVHf9rzE8N2YZOR2BFdzEDqQ4K
 5ktxbOZ1iC2KswkRcxjzSG4qPcpHGGp53REm+hr+HCVHgGxGVNTwY7bssvpFJJ1INO1ro0hxJAiUA
 Dz+sKYLyXsJifr0u7Wzvtj4+9uKTppPwZnv9kygQlsK34WQ/DbTD7HYkxHPPegptpNGH1KlUOb9AU
 7FfVGjKioFUuP8+h6bx8UHu+ClzufmGvaJEF1xexsMEVYl3ByVPSNAmdMQIB7UnmJp9Ilv9LJtHk4
 33/68fCC/c+GDeqIBgTMkmGdnRBc64HtZk0+mdELv9qje8aJ4GmlAELkwle1nu/wQ9FEYBOCl6LWI
 9yfmTaCg==;
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liq0L-00EHOx-Jg
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 03:02:46 +0000
Received: by mail-pf1-f174.google.com with SMTP id d16so6337910pfn.12
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 20:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FeML/C+dz+EFiECeAqqlAd3BLBfkRjaOs3WWybMiChc=;
 b=bYKUUfCbnjksrxoiLCiMnhpHqB+9JTkkA+CXKTNNoSPGkgEx8ga53b85pZKMtYsuJH
 YTCyh9LESNp6i3LSCbVEspu7wlQuqyzbQTXNRt2aOP2YiyEbx8J+WEdfwwE2ATLipE+y
 hlqQ+gFgEDmquqK2kKOwvpd0l/2XQ76LJyYVXFV0BlvuTlNrnQivzEtaEmZFFNN80ArL
 +0SqQcbchtJAWXzmwgq1KQTjDc9IZXZmqXM0cRVY9yCV0KugpDgSlQYV/J82Lbox3VwC
 WFRuU3il1QDaK1tHaE8guZUX73DEjd5ab9I8pm/BAVgynddNhnESgCpZTggz0S/1RO00
 LAOA==
X-Gm-Message-State: AOAM531/hQCihm0uO+dvUf32pPGab9O9jex9jDrZbvZirBX5qQ/ut2mi
 pUdXWl2cA2teiQmW9+37V8Af/uXpqrc=
X-Google-Smtp-Source: ABdhPJz1tT/ZLVSAewMQtlSgjPZK5wOk2YqQLrPY1ifPwsPZZQYgmzx8tG77LW85FFJECoVKgjes1w==
X-Received: by 2002:a63:4b5b:: with SMTP id k27mr2857825pgl.368.1621306964469; 
 Mon, 17 May 2021 20:02:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id 14sm10690385pfl.1.2021.05.17.20.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 20:02:42 -0700 (PDT)
Subject: Re: [RFC PATCH] nvme-tcp: rerun io_work if req_list is not empty
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210517223643.2934196-1-kbusch@kernel.org>
 <2479237f-ed41-6de0-6ffc-bed66046b2c2@grimberg.me>
 <20210518013804.GC2709569@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <11e1733a-24d3-72c2-1ece-4f9d1a8fade1@grimberg.me>
Date: Mon, 17 May 2021 20:02:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518013804.GC2709569@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_200245_681496_C35796A9 
X-CRM114-Status: GOOD (  27.02  )
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


>>> A possible race condition exists where the request to send data is
>>> enqueued from nvme_tcp_handle_r2t()'s will not be observed by
>>> nvme_tcp_send_all() if it happens to be running. The driver relies on
>>> io_work to send the enqueued request when it is runs again, but the
>>> concurrently running nvme_tcp_send_all() may not have released the
>>> send_mutex at that time. If no future commands are enqueued to re-kick
>>> the io_work, the request will timeout in the SEND_H2C state, resulting
>>> in a timeout error like:
>>>
>>>     nvme nvme0: queue 1: timeout request 0x3 type 6
>>>
>>> Ensure the io_work continues to run as long as the req_list is not
>>> empty.
>>
>> There is a version of this patch that I personally suggested before,
>> however I couldn't explain why that should happen...
>>
>> nvme_tcp_send_all tries to send everything it has queues, it means
>> should either be able to send everything, or it should see a full socket
>> buffer. But in case the socket buffer is full, there should be a
>> .write_space() sk callback triggering when the socket buffer evacuates
>> space... Maybe there is a chance that write_space triggered, started
>> execution, and that the send_mutex is still taken?
> 
> nvme_tcp_send_all() breaks out of the loop if nvme_tcp_fetch_request()
> returns NULL. If that happens just before io_work calls
> nvme_tcp_handle_r2t() to enqueue the H2C request, nvme_tcp_send_all()
> will not see that request, but send_mutex is still held. We're counting
> on io_work to run again to handle sending the H2C data in that case.
> Unlikely as it sounds, if the same nvme_tcp_send_all() context is still
> holding the send_mutex when io_work gets back to trying to take it, how
> will the data get sent?

Yes you are correct, overlooked this race. I guess this is all coming
from having less queues than cores (where rx really competes with tx)
which is not as common as a non default.

This is enough to convince me that this is needed:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


>> Can we maybe try to catch if that is the case?
> 
> Do you have a better idea on how we can catch this? I think there was
> only one occurance of this sighting so far, and it looks like it took a
> long time to encounter it, but we will try again if you have a proposal.

We can continue to test with the patch and hunt for another occurance,
given the argument above, this patch is needed regardless...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
