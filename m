Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86326C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 09:18:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA9161268
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 09:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FA9161268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HwtqSt66wSqT4tV/jug+lGlakgJBoV8oSGSadTllOw8=; b=OPQKsWPDbD+z2g0OlQMrVheXPk
	oTl6oe1y2mmiiDQS1iDJarGs5l93AIz6YSft7lEbXpIyM3aoHlP2VxjKph6DPGYKwQOI72Cb8sMm4
	XlWZcGVd2Sm9ETo7+VDF7MdvwTDkPs5j0RUnAhDsevM8tC9/CqdP05GKWmA1hubQRqUJKdqrEgwlf
	eq5uhmt6xiBqE2jrFMMX46ZDr6nuXtUSpGhMANz8P0sC6tWEgKoHiMfO8KiG1R9BxIywf5/AheqEA
	NG7+sF4IQ4/uofLN6W8/+tV9/3V46ZkXIeWgNWFmZOXBOxki3cTULSdLti2PJ6U1JTtpwEhi9EqGC
	ZACG4ubg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSyOV-007YXJ-BE; Wed, 22 Sep 2021 09:18:23 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSyOS-007YWg-Nb
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 09:18:22 +0000
Received: by mail-wr1-f43.google.com with SMTP id g16so4783407wrb.3
 for <linux-nvme@lists.infradead.org>; Wed, 22 Sep 2021 02:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=02qjpztlk97b3kUQStzX075lskKfkqVgq3BQX0VDegM=;
 b=uE07JvbcHNWnFrHHRKvdXMqgZiEFunQBNPJ2TojLpJeWnHn0ixeOVRNGDW3ppWKjMB
 ZqIlB8xJz07p5v/x9sxL7D/NonXRkcM8Wsc199wj+o+fXVTo2FL7h12CqRP+zTWfpyRA
 X7bWf9GT+n8rvHdYYEq/VNSNMvS/xZJlNVJeKO1JXAna8D6MDmye+rcPgYLdy2AUvWpe
 DiYB1vcyOzbNRY4YTla6AkK2A1VMfTnAAQi/qdXeohbPadr664P7QVxKv+ONKz4Un5Qf
 Q6N1Zn0dwP+uyO2HXKqx5Lx3QX2GV4N8zIYackkjejocyuaDOThsN9wD2FeDv6Hnm6qr
 DEDA==
X-Gm-Message-State: AOAM530D5hCr0vLpQYJu/hJ6A4Bj0KI4sNKcGWsoC0EK1QBs/aTvMnRf
 ICqXMMb6Ocvv8PV7YX9hd3SdJjxl7YE=
X-Google-Smtp-Source: ABdhPJwqQckht20fBkF//TprZrh+D3wvQqX0Sn1bC7PMwIZK4aCr2BlJ2hIdUUN14CIwtHgk9xUhew==
X-Received: by 2002:a5d:6307:: with SMTP id i7mr40792769wru.395.1632302298864; 
 Wed, 22 Sep 2021 02:18:18 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id e5sm1605074wrd.1.2021.09.22.02.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Sep 2021 02:18:18 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, chaitanyak@nvidia.com, 
 israelr@nvidia.com, mruijter@primelogic.nl, oren@nvidia.com,
 nitzanc@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
 <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
Date: Wed, 22 Sep 2021 12:18:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_021820_828180_55167421 
X-CRM114-Status: GOOD (  20.00  )
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


>>> So for now, as mentioned, till we have some ib_ API, lets set it to 128.
>> Please just add the proper ib_ API, it should not be a whole lot of
>> work as we already do that calculation anyway for the R/W API setup.
> 
> We don't do this exact calculation since only the low level driver knows 
> that number of WQEs we need for some sophisticated WR.
> 
> The API we need is like ib_get_qp_limits when one provides some input on 
> the operations it will issue and will receive an output for it.
> 
> Then we need to divide it by some factor that will reflect the amount of 
> max WRs per NVMe request (e.g mem_reg + mem_invalidation + rdma_op + 
> pi_yes_no).
> 
> I spoke with Jason on that and we decided that it's not a trivial patch.

Can't you do this in rdmw_rw? all of the users of it will need the
exact same value right?

> is it necessary for this submission or can we live with 128 depth for 
> now ? with and without new ib_ API the queue depth will be in these sizes.

I am not sure I see the entire complexity. Even if this calc is not
accurate, you are already proposing to hard-code it to 128, so you
can do this to account for the boundaries there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
