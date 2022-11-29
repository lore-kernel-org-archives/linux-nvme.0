Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79932C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vfmdPrG/d/sdcfBpP/NPY9FRIiiTUjLGS4u7Y99UOIE=; b=YS0BNl/r6Lq6mnIDFml3VkWnS+
	DK9vOiKQn58WygvS0PdsUfL9LNuYsSWzcLJSq8FmH0dl6Q7BIWMx9c0PTQpIBR3Y01OdMwsJeOPhw
	MBtqxu1x1LoJmRmh1o4DrYhGEP+odPdFZu5YphDVfYSpY5xnF2FqGURT3Y63G6ws+6AnFikq4rwVH
	ErIzOwSkcPBoVAv1AZda4EqGrjYYxPr6oSIEaV18nAsTo1rLCifbC+g3foVEav1FNQOgB6cPy34bd
	ZMXfj/aB5M8EUtFYGkrFLAqj/3ZrKBt2f4pvxMVVty00xx60gr2ArXFr8n9eosBKyP93UyfOV6BQE
	Nkod40mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p019z-0091SU-8d; Tue, 29 Nov 2022 14:00:31 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p019x-0091Qb-6I
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:00:30 +0000
Received: by mail-pf1-x429.google.com with SMTP id x66so13768031pfx.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfmdPrG/d/sdcfBpP/NPY9FRIiiTUjLGS4u7Y99UOIE=;
        b=oGZ/Yt/gIKSQvsmmQAqcqfOeW8pLTBZ4YW8Ym0mEQmIDNl5xMsrQl5yKcC1yfph0lv
         VWJkIZGtWuD/YOiGYGQvZVo5EmLaBfe051c6fokhgSyIjPtz7Nho5gEoeXmDikdvp10V
         VneR3YhPNehWBtWji7zUkuLqXzBIEzgbn8OpBXNhk60XRLhNXQn/vNXNMKIVhWcapXdw
         ju9p+VGhx8ZOTMLRo/aTaNfdUCPx5CM4/opnYwAGqgZ2/tx/BpmnvR8wUg+1QB4geIFp
         PlM5sGl4kAqj8HRJcTY4h42mOtNpLriihJ50p+eTyVRlNf/K2Gp/LLzwik2tHbJ3E5rR
         ejzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfmdPrG/d/sdcfBpP/NPY9FRIiiTUjLGS4u7Y99UOIE=;
        b=rh5SFDyyKoPCv1ZAzHSyoFTMUPCG+28xaCxh2ZEsKPUa9Mi2jQEMGy61ouksddpFGj
         ODH0v7RP4rW0TYjnJx4HXpjIRWR63jY5tddJE7aNNC50zhMhKDsn4yoVEwcOYueX6x2o
         Q3XT+wVV6+Wnpfc3Wj1StwpqVvuSue6Xt0xGy/5CXOhoFhe0B2nLDUsXVfjQxJX3ults
         FsfXN1VQgrZodFupgNeAZFiS8stUkvGnUeMKit6b6h3VQvf1KMrxOqa9s2OqV+U7HjrJ
         u0xSE6UEAvuErJarBqN9BO76cjRHYIKMKKlf1BAvg4Uz3AgHL6S3+6wtkEl6SckCl+f/
         wSrQ==
X-Gm-Message-State: ANoB5pkBa1K1NDRN/QaBQqfhmQuvZ1+U/s1f2zhI1A+f7cSou6xZn5Dr
	I55wc2dvYH+ZTrpKVrIhO57j9w==
X-Google-Smtp-Source: AA0mqf5pYbhR7pkuhHMFk67yso4Z04ENb6/JaLVqnj5Qm3hFaKDh2I38Mgs3uXFHWikR7bv14adqbw==
X-Received: by 2002:a63:d21:0:b0:438:c2f0:c2cf with SMTP id c33-20020a630d21000000b00438c2f0c2cfmr17408182pgl.116.1669730425127;
        Tue, 29 Nov 2022 06:00:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id kb1-20020a17090ae7c100b0020b21019086sm1863999pjb.3.2022.11.29.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:00:24 -0800 (PST)
Message-ID: <613117ce-56ce-10cb-1548-eac1741ceae5@kernel.dk>
Date: Tue, 29 Nov 2022 07:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/4] block/scsi/nvme: Add error codes for PR ops
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Christie <michael.christie@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20221122032603.32766-1-michael.christie@oracle.com>
 <yq1o7sumo0c.fsf@ca-mkp.ca.oracle.com>
 <538bcade-c453-e6f8-4530-808a9bf2140a@nvidia.com>
 <20221129132805.GA13061@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221129132805.GA13061@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_060029_251298_7FA6CF6C 
X-CRM114-Status: GOOD (  11.88  )
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

On 11/29/22 6:28 AM, hch@lst.de wrote:
> On Tue, Nov 29, 2022 at 04:18:19AM +0000, Chaitanya Kulkarni wrote:
>>> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>>>
>>
>> perhaps a block tree since it has block/scsi/nvme ?
> 
> I think Mike has SCSI work that builds on top of this, and reservations
> ar originally a SCSI feature.  But either block or scsi is fine with
> me.

I'm fine with scsi or block, I'm assuming we won't have any
conflicts from this on the block/nvme side?

If we're doing block just let me know and I can queue it up.

-- 
Jens Axboe



