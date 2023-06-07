Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE909C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EfrbqBoTOOj+ioKnKZz+RFear/OCCj3jAdbAYdMpU2g=; b=tcailXCJsbmep51POh24Oh3xhn
	PQkJu3K2vEBIx3yaeDlK4YTkDEyd46AsLBX5LS8yH58luisDyngZx2uuW55cLWmTNp5x/zc/xNuD+
	QhQNvk8/KD+R9/XJtwhTGPHdoSem6ftjfgBxwHbtdjJiBpZDt1ciCnMt6gfH3Scfa0F3LxKA1JqVc
	CxbsNAAwK+STa7Z+ooZOHvSJSgS7fSUPu8ZjDtTb0H09ltbOAdVBiYcXdgAfOwHfVh+eMAWcLgDig
	4M9Jg+o4qoynl3j22ecgq7rTtR0dTs+4aoS7q7FQ7v3heJCivBhRypo6IUQ8kQf38pOghvw9y/mub
	Z6zyDK3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ulr-006MUK-1G;
	Wed, 07 Jun 2023 15:08:23 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ulo-006MSY-1c
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 15:08:21 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f7373b5499so7009345e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jun 2023 08:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150498; x=1688742498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfrbqBoTOOj+ioKnKZz+RFear/OCCj3jAdbAYdMpU2g=;
        b=fZTOaOoHr5y6g0xBI8sHaAComtkAjotBcYabLDRBGSw99pdi3jQjj1FN81xUXly0Va
         xI1XHQWLJRl0/Z7q2wfh+fo/8+v+9ICS6rx4zI7iDF+j7xUousUHVL0B3OJrREryIzvb
         ydmAKXc4nGnge/16D9K/erkYzM7bQiwn5MkX004Lh5XsE6/nU179QcS0f4vZKRvFJiKi
         oS4JMtK7exmKuV9JONWqZzo9l3lhE3knCAk5pEmFG0EhslzL572NShQof/d0bfouoDXi
         e/9JJC5hDPqxpfXmfNpekEnLnYpiwGmwssipRr/rehQ9wx9zQKlmrhTJEd72gMXIoAfh
         AbHA==
X-Gm-Message-State: AC+VfDyQgOD2HQ3NTPS2oa+oJiX/eAb0PdBf1690mkKr3FAqO/WPzlAO
	7kx+bx99U+78qgethsJfsNo=
X-Google-Smtp-Source: ACHHUZ7LWpgp7Sn8VNALb+/OkUElesaVV5c+cvDPvvYYvXAtMBxnWGXuLGD0rptMrji4R2PXCv1Xfg==
X-Received: by 2002:a7b:c383:0:b0:3f6:c88:c318 with SMTP id s3-20020a7bc383000000b003f60c88c318mr2995786wmj.4.1686150497863;
        Wed, 07 Jun 2023 08:08:17 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f7ba52eeccsm2479578wmd.7.2023.06.07.08.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:08:17 -0700 (PDT)
Message-ID: <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
Date: Wed, 7 Jun 2023 18:08:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: print disposition on err req completion
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Amit.Engel@Dell.com, kbusch@kernel.org
References: <20230605064933.46933-1-kch@nvidia.com>
 <20230607050059.GA19879@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230607050059.GA19879@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_080820_541734_947F9D30 
X-CRM114-Status: GOOD (  11.99  )
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


>> Currently we don't print disposition in the request completion path
>> in nvme_complete_rq() tracepoint, so when request fails it is not
>> straight forward to understand the diposition making it hard to debug
>> the problems in the field.
>>
>> Update nvme_complete_rq() tracepoint to print the disposition when
>> request fails, since disposition value will always be 0 when request
>> status = 0.
> 
> Hmm, not sure this is the right way to approach it.  I'd rather
> redo how the trace points work by having a class and the ondividual
> tracepoints in nvme_end_req/nvme_retry_req/nvme_failover_req.

:)

This was the original proposal (posted as a question to the list),
and I proposed this approach. You don't like it?

I kinda like the explicit disposition output.

