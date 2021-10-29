Return-Path: <SRS0=7cDU=PR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36900C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 08:15:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011FA61151
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 08:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 011FA61151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ddftgpK0LDx+G+FjrkBslhvyIqXHl28zfgWlGOCfAA=; b=xJ+LK0eORBu1qyPcA8y2r1QKLg
	Inlp4yFtxN0Z05JgT6B/J6cAuCx04xvzqHrOAt6WQwFaXqIyqUiucuKvUjkWAycyEODJe50ZtGGVT
	gS8F2XjyAeEvmLV0noGFbWGY4GOTIVtgYLvUp7WpENG64H6SbDRDeRaV0KocDWfBOb64VAADLUC+W
	PwcBr1/aG5Rak2zZsLFqwVbcX+5tFLUBjRssnEJyD7S+/ea5S09ZpJlaWWUnnx6qiMi3m2fqWdIUg
	mgInIC/yISSUapE0CT+D7itv5xBa4FTiwidmSmGjT8WWorF8sjgLew+5MYvc9dgHroB3a0E6Uu/IS
	rZt+ObgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgN2M-00AEv1-HZ; Fri, 29 Oct 2021 08:14:54 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgN2J-00AEt6-99
 for linux-nvme@lists.infradead.org; Fri, 29 Oct 2021 08:14:53 +0000
Received: by mail-wr1-x42c.google.com with SMTP id z14so14917072wrg.6
 for <linux-nvme@lists.infradead.org>; Fri, 29 Oct 2021 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=8ddftgpK0LDx+G+FjrkBslhvyIqXHl28zfgWlGOCfAA=;
 b=ZvbA6OirgjAS7+trJNLUfzUzxnDghd5zTvC77XLYSKiUJni+0fhVC882L/ZVeGk6nP
 /kqxXGYeIC8ozy0ThUYCWPYJj/TnAzJyT1FoDRlAW81PXLjx1H4dovtDjSUYxLWm89Fm
 QeYR518/SaS27GmrZdJnfY4dbWaImq1x9hLn6jWFVn9mzRPWjglKS8+xiGDRwDWz/iYO
 zYrVWby82S3kK8LXamSjv0A8Cb66H4Oml/LfuIsvJZgM75kD+NlXEN9xPLTHLb4g/Maz
 3JCfMkKUJr7mv7erdqTMwWKCCXCZ8zHBaXoAeoSql0VKFMra1tHxcXHRWOHY5d7i4HUp
 zSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8ddftgpK0LDx+G+FjrkBslhvyIqXHl28zfgWlGOCfAA=;
 b=aQCHrnkgH8tybdBDDWkTqTgqBClnkFW/gM8+0ESLqSiOgC0GvnWmrgns2zaINgTL4Z
 kC0uGAAPE2GDQUuzdmz0S83VDngE2JxWRQ6yv6y2yHtWzwUDM4/CFp5Bpn+XnOWidDN6
 uQrQ6VcAYTQzavnNuOTkKKGywZ91y8BpnFa4A5uIcQUJLmiEdqGtotfHNQ6DFAEqkqPa
 zM1WDw48S6hvN+r6OYJnutGqB92j/lgQiXubagXs25eQmYc8OrPD6Mxey1TPXCL/nI6D
 hxXU7nR2b5GgPHpEfvm7W5DVfXyTLrc7UFHu6EQvT+7ySq1G4JFzH0ZO8llFesgqzEzN
 gqeQ==
X-Gm-Message-State: AOAM530MYmj2igVXvNzOn18ngi1P/oy9SaSTfCEZCMPWkRab6lFW1bCX
 irIC2LBbSuhWeB0cl+XjONTtdw==
X-Google-Smtp-Source: ABdhPJz4KKl/vCIv4EZQxDSYhXgl6hLs1xW5oRUFqmNOfzBiIlxs2qrs7OEPigr3oNUptn2YXM3COQ==
X-Received: by 2002:adf:e387:: with SMTP id e7mr1473005wrm.412.1635495289096; 
 Fri, 29 Oct 2021 01:14:49 -0700 (PDT)
Received: from localhost (5.186.124.144.cgn.fibianet.dk. [5.186.124.144])
 by smtp.gmail.com with ESMTPSA id s3sm8001684wmh.30.2021.10.29.01.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Oct 2021 01:14:48 -0700 (PDT)
Date: Fri, 29 Oct 2021 10:14:47 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211029081447.ativv64dofpqq22m@ArmHalley.local>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211029_011451_426080_3E930F4A 
X-CRM114-Status: GOOD (  18.98  )
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

On 29.10.2021 00:21, Chaitanya Kulkarni wrote:
>On 10/7/21 11:49 PM, Javier González wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 06.10.2021 10:33, Bart Van Assche wrote:
>>> On 10/6/21 3:05 AM, Javier González wrote:
>>>> I agree that the topic is complex. However, we have not been able to
>>>> find a clear path forward in the mailing list.
>>>
>>> Hmm ... really? At least Martin Petersen and I consider device mapper
>>> support essential. How about starting from Mikulas' patch series that
>>> supports the device mapper? See also
>>> https://lore.kernel.org/all/alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com/
>>>
>
>When we add a new REQ_OP_XXX we need to make sure it will work with
>device mapper, so I agree with Bart and Martin.
>
>Starting with Mikulas patches is a right direction as of now..
>
>>
>> Thanks for the pointers. We are looking into Mikulas' patch - I agree
>> that it is a good start.
>>
>>>> What do you think about joining the call to talk very specific next
>>>> steps to get a patchset that we can start reviewing in detail.
>>>
>>> I can do that.
>>
>> Thanks. I will wait until Chaitanya's reply on his questions. We will
>> start suggesting some dates then.
>>
>
>I think at this point we need to at least decide on having a first call
>focused on how to proceed forward with Mikulas approach  ...
>
>Javier, can you please organize a call with people you listed in this
>thread earlier ?

Here you have a Doogle for end of next week and the week after OCP.
Please fill it out until Wednesday. I will set up a call with the
selected slot:

     https://doodle.com/poll/r2c8duy3r8g88v8q?utm_source=poll&utm_medium=link

Thanks,
Javier


