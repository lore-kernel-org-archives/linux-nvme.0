Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1247C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:53:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F86D6101B
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F86D6101B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcuXrE9z483G2ZHbQ1MlbKojxK8IxttUQMO6mx9HjKw=; b=bNGNodtkoRxEJj9Do8rR33t5l8
	xUxzSurTFYmy1Pn09F9wlRstfB0cmxljHR1lxfZNwYrEVyWITsgnGWzJ7qGm4uPkURyVQ456YJAvN
	bKGNmcYWoBikF8FtusPdHymOKEPHEuOnHdsuSd8BDvm+wCOH7Du3bX9jYdxu7iLdJi9ewVnJq51Rb
	snIPCI5CvOVvqWAtL07cYmgLaZlvrXyuaRW79eaSA2KCil7ewR8m+A2qMUEPq2KnT5Cg93D9lczTT
	wcTUl3CeyNTu9zbJ22HOEkjcERv0fJeNZU9A018ebPiyAlo8InXIY5qLl+eRvGhTjOGoQAJDzTUrR
	SITOmuEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPja-006540-Vm; Wed, 01 Sep 2021 12:52:55 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPjR-00652z-Rw
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 12:52:47 +0000
Received: by mail-wm1-f45.google.com with SMTP id g138so1792124wmg.4
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 05:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JtFZUlgc7VdCODB3skiCvsPKFtDTKIOPerKcg/Vpr5c=;
 b=c3+6JNHB1HTNO8HnQ9E3xPuV21WiA8stZA10gJPqUkEYfpDZkNtPYLHYMgPU0PrvAu
 LhTaT/HpNk4glX8xHdKZ5IHcQU1aFCv3gvZ0J7YoclBZtrUfXu9f7KEtSgcOVJ16M/gR
 XX3RMa7NGsPvVI/4XGGlqc4fZpfva3pjfnkTsW9elOJAGXq4Mvg9nbTrw+t4+ZEf0ngi
 0i7AZXr1C/j4kHUCOf4FjBPb3f+oQlsstaWP3z/5XtecOiqTLvg5wRnSFLr3NTSL73FN
 jJhtsu/TwNsU92J5NRZLJUrbk5i5gZ9NyBxfYSvrXBt1pk1ReweGVUVLnFUdEI2FHc1+
 +tug==
X-Gm-Message-State: AOAM533wYnjWnB9KiHZiu2JjyJz7cSdfcMjEuNIQGUcjt8YsqD0jcT20
 1oitTltxvZe6jb/hMN6Orjr5n9ftzco=
X-Google-Smtp-Source: ABdhPJz07jdK1dPHxhr5RkSgIwrVzHp8v3hXDV1xgYWeaR38HbFL44KAVkoPK4A5NZGYMssRRXDpfg==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr9231431wmb.156.1630500763713; 
 Wed, 01 Sep 2021 05:52:43 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id z137sm6016266wmc.14.2021.09.01.05.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 05:52:43 -0700 (PDT)
Subject: Re: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
To: Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07e2bbb2-2b62-f0a3-b845-27398268c468@grimberg.me>
Date: Wed, 1 Sep 2021 15:52:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_055245_955485_1B06138C 
X-CRM114-Status: GOOD (  12.37  )
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


> When I connect an SPDK initiator it will try to connect using 1024 connections.
> The linux target is unable to handle this situation and return an error.
> 
> Aug 28 14:22:56 crashme kernel: [169366.627010] infiniband mlx5_0: create_qp:2789:(pid 33755): Create QP type 2 failed
> Aug 28 14:22:56 crashme kernel: [169366.627913] nvmet_rdma: failed to create_qp ret= -12
> Aug 28 14:22:56 crashme kernel: [169366.628498] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).

Seems that the target is trying to open a queue-pair that is larger than
supported, which device are you using?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
