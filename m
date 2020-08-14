Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D997BC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 17:50:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13C520791
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 17:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0TYfzGqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13C520791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lrUsriBYzZhtwWbbYwFC5PDXor1soqQWpET3onKg7ew=; b=0TYfzGqAyYoRTUKk9JnDTqwAa
	0DoyqPd0zT45qzomNKa3rSA3PRamtW8UQaIJaHzV9fMUGRY8KkHNZnacqxqvpWdDclrdrbSIzvRln
	hZDOBdqmC39jDbFdLa9qy0GDbbGeo6xEdZCvjIseDH3eysJnN7www2eaC6kqqxvbQDjkeZbS//ioN
	w1e1H9RKiPUHe+Mv7R+kF7fSPIjF7SjW7TMw+xDBTSm3E1NqYBis6YxwllcFphHvSNLF5SrJYBUKX
	mxJbktxZpaAt1P0Aaei32d4r+m4fptpczPVh6kahZFP9bg+3l8xPScdV2qVcvTcqVhIiNcENRo6j8
	21uZeFiMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6dq4-0002tl-Pr; Fri, 14 Aug 2020 17:50:00 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6dq1-0002sd-Nc
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 17:49:58 +0000
Received: by mail-pj1-f48.google.com with SMTP id d4so4720189pjx.5
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 10:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S5Tj/c5dBM12ZdpwTiFFSc/5c2Dt2GvYVLUqn4004c4=;
 b=e4TWm1OXGkB2JV0aeTm8DhqYssz+brb4TDq2ImmYdN+ARDODMoJewaANqPouboS8VE
 q0+y5gGGtuS1E6SXJL65/kLhLEjlcTXZ3kJaYCDBxPJUxfSv/JAGeI96IVxJ3QYK+e6N
 CULJbctPtPcqnK0zSVDHm3eW2aRDVzWm7JfKrGWb0cCb1CZoa6uT2pOga3SqL++Ql5IC
 uGvYUkrMIwRezRQRBwZYxSI+PYq56afDo2Gqo/zMjd/hqeDxxNq3myvOTJhg+KWDI2I3
 npm4VQSe7L6lRb33Ns4l30fIGSdtq7ORsUbJfuBz8knBJILGZLxzBOs7xQFZFbAJ4YRM
 2N6A==
X-Gm-Message-State: AOAM531WMthQIWYhpZqhuXJJ2ISjfkvzUqR6I+8pSolFBHMaM+INC1YV
 g1IXRmgH7NaCwi50Wzs6Keg=
X-Google-Smtp-Source: ABdhPJywyWGKsC2+imA5y7OIHYu26LMOnawrkI4wS+nhv5QmY1tyZ9qmmCDMiSzfcIhOSLP6Q8P41w==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id
 mw15mr3112700pjb.174.1597427396627; 
 Fri, 14 Aug 2020 10:49:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id n18sm8586052pgd.91.2020.08.14.10.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:49:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-2-sagi@grimberg.me> <20200814064414.GA1719@lst.de>
 <27f60468-269a-34d8-9e51-920106c3a139@grimberg.me>
 <20200814072202.GA2429@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed79addc-8fdf-fa77-c91a-316101a384f4@grimberg.me>
Date: Fri, 14 Aug 2020 10:49:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814072202.GA2429@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_134957_796880_7BB39E83 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Which will still happen with the admin queue user passthrough
>>> commands with this patch, so I don't think it actually solves anything,
>>> it just reduces the exposure a bit.
>>
>> The original version of the patch removed that as well, but james
>> indicated that it's still needed because we have no way to make sure
>> the admin (re)connect will be the first request when we unquiesce.
> 
> Is that whole thing really a problem?  All the pass through requests
> are inserted at the head of the queue, so how could something else
> slip in before it?  If we have a race window we probably need
> to use BLK_MQ_REQ_PREEMPT or something like to force executing the
> connect on an otherwise frozen queue.

The problem is that we have to unquiesce the admin queue in order
to send the connect request (because it's sent on the ctrl->admin_q),
and once we do that, quiesced commands go through and the condition
being discussed is what's preventing them from passing through.

As James noted, not only before the admin connect but also before
the controller was enabled.

Anyways, this needs to be resolved, but it doesn't make this change
incorrect.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
