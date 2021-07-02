Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D5EC07E95
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 23:29:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0756C61410
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 23:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0756C61410
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KL8yj3hFBbuQR9wMJ1WZtvTd7cWoEj2FC6VyoWopss=; b=N6X6bbB7Y6Qag6k45QqAd5f2IM
	WUX70+dO9RBH1yOnFLCTIezWjbNCyDlLBLjELgmRztGEz93QIPI/pk0DJHvkX5bleOdm82AFc8csc
	s64CdApyQvsgJRx1O4owB0FmNSaKurfR+kljPAb31+QFseaBZD7pVHSCG3azVhpKtseUo7gk3lSYs
	8Ll45HxVnjkoWhHsv9JPSQjp9Z+PVMjTyaNN0Pd3wW73+6hrmRIgTCmGZfzdQCH0HaGvpNjXlnq3i
	Sr+OWsE3w8D9RRoQs9RNBfAb/JRZwd9PxW2z4JRmRdBctqZ6unfJtR//sFXv3nHhh0B04QoImBqw9
	dIIvKU1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzSab-004GhH-AS; Fri, 02 Jul 2021 23:28:53 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzSaY-004Ggs-DY
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 23:28:51 +0000
Received: by mail-pl1-f171.google.com with SMTP id f11so6651145plg.0
 for <linux-nvme@lists.infradead.org>; Fri, 02 Jul 2021 16:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u7JHIwVFD8LrMaetmX2O4vNbB66eLC6plRkGbPqn6aA=;
 b=WU4b8b6UzFVH6/laUETyffxbVEQhZPRvepFLBbuizpkuDlNAVFx8guShgmJYUwtWih
 m0lfbpWGbEvicBxzNgJu/5wjIr2DJQLf+CQbD2eiNeiYkYI0ywabN1V1xA2Nr4SaLKE/
 xNtdFOn/Dx9937VmgDM9NpBaH8Z/dUC5qKMq8jhZLSWYpbMepjFJDo6bpHk//mJA3MxX
 FKbYbZzySQbW5jmBuEzhcgyneojSBCCWwdtl4vFJ+2OBB8Ne48AFByUTt3OQAcz+DN+i
 K9xum1ZXTY7Q8HpFf48ojnrDumwXk5V+s7pfU719FrPCCwZcoPj4cL8OBvb+bGbzwuSH
 2Gvg==
X-Gm-Message-State: AOAM5323L0l5xC6irlmV8Up1v6Bnj1YjWrsqwEJIi55f5XpEh/F01hk0
 D04jiZne2fWc8nuN/n9p37g=
X-Google-Smtp-Source: ABdhPJyJC68ADXxo1b5wFNHkqVvetLFbxgnemvsk4dC3S3gFGctBxZ9MtwU3v98KoFSn5QPxS7N+7A==
X-Received: by 2002:a17:902:7598:b029:ff:655e:f0c8 with SMTP id
 j24-20020a1709027598b02900ff655ef0c8mr1805494pll.50.1625268528854; 
 Fri, 02 Jul 2021 16:28:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c2f5:d7c5:c28f:225c?
 ([2601:647:4802:9070:c2f5:d7c5:c28f:225c])
 by smtp.gmail.com with ESMTPSA id 136sm5056009pfa.158.2021.07.02.16.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jul 2021 16:28:48 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
To: Or Gerlitz <gerlitz.or@gmail.com>, Shai Malin <malin1024@gmail.com>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, axboe@fb.com, Keith Busch
 <kbusch@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Ariel Elior <aelior@marvell.com>,
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, prabhakar.pkin@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210624172410.14225-1-smalin@marvell.com>
 <20210624172410.14225-9-smalin@marvell.com>
 <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
 <CAKKgK4wJDrNcSbaPERPg2EyrSNvi8KY9UHyM3=T9bL_d3WBSDQ@mail.gmail.com>
 <CAJ3xEMiH9uaVojuvcetaWmFf8+OveX-xyvf3_CBbGsCfNP6X4g@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <80c4ef0f-cbef-46c9-97c4-959d7a80c106@grimberg.me>
Date: Fri, 2 Jul 2021 16:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMiH9uaVojuvcetaWmFf8+OveX-xyvf3_CBbGsCfNP6X4g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_162850_509883_1B30B15C 
X-CRM114-Status: GOOD (  15.62  )
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


>>>> From: Dean Balandin <dbalandin@marvell.com>
>>>> In this patch, we present the IO level functionality.
>>> [..]
>>>
>>>> +static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
>>>> +{
>>>> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>>>> +       sg->addr = 0;
>>>
>>> ok
>>>
>>>> +       sg->length = 0;
>>>> +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>>>> +                       NVME_SGL_FMT_TRANSPORT_A;
>>>
>>>> +inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
>>>> +                                       struct nvme_command *c, u32 data_len)
>>>> +{
>>>> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>>>> +       sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);
>>>
>>> ok, what about dma mapping of the address?
>>
>> The dma mapping is done by the offload device driver.
>> patch 18 - "qedn: Add IO level fastpath functionality", in qedn_init_sgl().
> 
> The dma mapping can and should be done by the nvme/tcp driver. E.g in a similar
> manner fow how it's done for nvme/rdma, you can take a look on the code there.

I agree here, the fact that the lld calls blk_rq_map_sg is very much
backwards... If the lld is peeking into a block layer request or bio,
its a sign that the layering is wrong...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
