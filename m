Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219F8C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 15:29:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C01820A8B
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 15:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PhCk+wXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C01820A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JQ9upAWS7WT0DJNsWBhCs5zstX20Il8Qk4ji4O9x/Q4=; b=PhCk+wXX94b3Y+xplbQie1OnP
	xpWZ2kGE6+N2zmmTrtveQhn1hqahgl3UV2bTe2M/fVcTVtOE/+xiRasPjLex4wO/oIC3VjvcThpM9
	ir3wZVaGYcFh8kP9WDzcMXUuLTL6ilKL/DRevzoA6HM6cB7HweB53qLGGjUj+PNwL/p15Zc89oz33
	bj8WO8rYcKiX9YKd1N9KPZK9cVCWAuo19JQDl2wq43LP35EOsOtLqkx8yzFtny8WifakB4k7JI5VL
	KITNk4vkqBjpgyyfPNnXZgRGgqjzsZQLbl3pU3GXFaAIWem2tTnqBY+0Jhy0HP6x/wvpo4TBZkQp3
	x8QSwosvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdEXI-0004DE-8U; Thu, 12 Nov 2020 15:29:20 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdEXG-0004CV-8D
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 15:29:19 +0000
Received: by mail-pl1-f196.google.com with SMTP id t18so2966523plo.0
 for <linux-nvme@lists.infradead.org>; Thu, 12 Nov 2020 07:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mfWwkX2VqCJnpSe3f6b7gGDcCnnDVIbQGc+a3cLC1XQ=;
 b=V2Fb8CKxcN44ISMsPLJ/a7jS/yVc4bf9NARMREaqFpXX0Y4S2eJYTNQ6PdlLBF5p+q
 4zJ1fldsMM938ZPcBSr63QHisHtGYTSL80CRuC5AhtGu6S7+GQZPVFIISyz3BGhWCZy2
 yVnBXsd/I4yOelUwokKKfs/+vxnbS3IhMxbC08KiKbUwYPvGNf0khGGzVNOJyDPk54jj
 VDPvC5r936Rf2RDpdrMhK75W6Cdb8FnhkGOTmmdZt7XdSIidmxHJpd5rGuOzj+bNz/oN
 VYYxD1hzV5QlUghQjv2SKI7pMsWLhrr9cjH8klMZj2uX/5o1/8G2DPGmb8DWRhw9Z5Za
 2qHw==
X-Gm-Message-State: AOAM533wEIFZlRptfym3v/xNoPqpngt1vII4UCXI3NN1Dc53VGE53IHb
 +SGUh1ZymCxoXE5GLVf/GTY0Bhl1sdk=
X-Google-Smtp-Source: ABdhPJxOj52iktluMxLhGtb7Uxm7Tvphkd8qB2HY4bWSTc9zsAj9RHsxcwe7GxmwCtCA92aOoYD40A==
X-Received: by 2002:a17:902:a608:b029:d6:a1fc:ab75 with SMTP id
 u8-20020a170902a608b02900d6a1fcab75mr247999plq.18.1605194956874; 
 Thu, 12 Nov 2020 07:29:16 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id j1sm6672257pfa.96.2020.11.12.07.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2020 07:29:15 -0800 (PST)
Subject: Re: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
From: Bart Van Assche <bvanassche@acm.org>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
 <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
Message-ID: <e0392f5e-1de2-d56b-027b-4bb4d041fdcc@acm.org>
Date: Thu, 12 Nov 2020 07:29:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_102918_353212_3933AE44 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: Qian Cai <cai@redhat.com>, Sumit Saxena <sumit.saxena@broadcom.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/12/20 7:12 AM, Bart Van Assche wrote:
> On 11/11/20 11:55 PM, Ming Lei wrote:
>> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
>>
>> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
>> locking' by nvme-loop's lock class, no need to apply dynamically
>> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
>> lockdep complaint triggered by request queue flushing").
>>
>> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
>> is reported the whole probe may take more than half an hour.
> 
> The code touched by this patch is compiled out with locked disabled so
> it is not clear to me how this patch could affect a probe delay for
> megaraid_sas? Has the megaraid_sas probe issue perhaps not been root
> caused correctly?

(replying to my own email)

I found the answer in the descriptions of the previous patches of this
series. I think this patch would benefit from a more complete patch
description.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
