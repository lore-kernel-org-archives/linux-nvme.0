Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CFBC4345F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tV2ZC2UmEwzpoMr2Th1EtRY5AdqzP0fjZxhzJ5COxUg=; b=Cftvp07+8Wze/p8pxgRFK7A9RJ
	oBCYtnGqFPHF5FUSz8RZCqkgxMC56IK1NLuOSJMGzuzGl+wblgbio2lXw6NLnouP46jj2EKnLyGhM
	wbTcbfVWCvQK7r6/xJQPU/+AkFoGzQwtRaEDTQAXC2uLF1cVs7+bg4DSzlxNwffLfZrdNOUdaHnPb
	btw9FhxzbZ8XN+1t/1R2gjK1UJgSsgZMFHuubIVWkyAjzOVsIYU2+NgU9KrlWBPJcahF/+GoWltOE
	MJbwFXtAyZbU8APBjHo4tFvWxRGeO9YIEbhqJhAJ/mZN8I1yzvGozFOZ6ctmOPRxv0i+4y8M9l5S6
	Q9yJP6rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3stX-00000006Tb3-2jat;
	Mon, 06 May 2024 07:36:19 +0000
Received: from mail-lj1-f180.google.com ([209.85.208.180])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3stU-00000006TaN-1t9b
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 07:36:17 +0000
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e20088184cso3432411fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 May 2024 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714980973; x=1715585773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tV2ZC2UmEwzpoMr2Th1EtRY5AdqzP0fjZxhzJ5COxUg=;
        b=nDFdM5OOtFWRTQYPE+mlm+TkYZf39uhC0dgdy92oQkE66+0ZDMkpqAAIBu8ED5lT+J
         c8Mb384cmTWtOdJafvcnO3l+IdzKrgwsIrRVTANmdTotZzV73SqPmFB4ATmLsurAYCzr
         JUWPXHf+FHtBPBK6gLPSOUUtjZ26sGlrz8XYKxx2SfdB6W/Yxk8QLwL0yQackRFa8NrY
         cOfO5x6OciwIqAM6zLCh1rc9AbzjL3uzBCNlQyXCHqQPEqKU8bLJEmswljBG+WWem+KL
         eSXNCK4JFkQ+Guj9DQyZ4KPPLyAcgroIvjTKsC5MKqWIXhs2UrdmrmpSvG3+imlnqsGZ
         SkVg==
X-Gm-Message-State: AOJu0Yze2m3ePG+8BBp/hiYrn7QM71UKFGaxWuKEwP1R+/wT4WJ+fb79
	0wM47rZUY9qiidzzE6f0Se1/aAs2gAgWPzv0ispJ1+56FQTnJ3c2
X-Google-Smtp-Source: AGHT+IExWeMlGyGUom1vcTk7FI0Dxv92Qd4YwkpTbjr8h0NuUb2R1Ra6IJaTzwPkUFB0/VMG27mNEA==
X-Received: by 2002:a2e:7d0f:0:b0:2e1:f928:b62f with SMTP id y15-20020a2e7d0f000000b002e1f928b62fmr5967287ljc.5.1714980972968;
        Mon, 06 May 2024 00:36:12 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b0041bc41287cesm15075182wmo.16.2024.05.06.00.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 00:36:12 -0700 (PDT)
Message-ID: <c7fb5eeb-1dc7-4cf1-875b-b941447b7be0@grimberg.me>
Date: Mon, 6 May 2024 10:36:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20240505103944.52275-1-sagi@grimberg.me>
 <20240506055020.GA5059@lst.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240506055020.GA5059@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_003616_527417_01FA3F1A 
X-CRM114-Status: GOOD (  16.79  )
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



On 06/05/2024 8:50, Christoph Hellwig wrote:
> On Sun, May 05, 2024 at 01:39:44PM +0300, Sagi Grimberg wrote:
>> From: Sagi Grimberg <sagi.grimberg@vastdata.com>
>>
>> When deleting a nvmet-rdma ctrl, we essentially loop over all
>> queues that belong to the controller and schedule a removal of
>> each. Instead of restarting the loop every time a queue is found,
>> do a simple safe list traversal.
>>
>> This addresses an unneeded time spent scheduling queue removal in
>> cases there a lot of queues.
> I think the original reason for this was to avoid lock order dependencies
> and/or deadlocks, I wish I would have documented that better.  Looking at
> the current version __nvmet_rdma_queue_disconnect I can't find any
> obvious problem, but rdma_disconnect is a bit of a block box from
> the driver POV.

Yes rdma_disconnect is a black box (essentially move the qp to err state 
and send
a cm disconnect request/response). But it is not dependent on
nvmet_rdma_queue_mutex. It is true that in the cm handler we may take this
lock, but that handler has its own context.

The same pattern is used in nvmet_rdma_destroy_port_queues() and
nvmet_rdma_remove_one()

>   Did you test this extensively with lockdep enabled?

I can't say this is extensively tested. I can run blktests and make sure 
lockdep
is enabled.

>
>> +	list_for_each_entry_safe(queue, tmp, &nvmet_rdma_queue_list, queue_list) {
> Nit: overly long line here.  Maybe just rename tmp to n?

Sure.

