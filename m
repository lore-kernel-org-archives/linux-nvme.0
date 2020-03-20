Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E53CC4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 05:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D450F2072D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 05:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ul+lSLyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D450F2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OtBpmNzcWhF1Q9ZsDOrIT3j3Qr4t+7ZyEW2v3rakXPw=; b=ul+lSLyUC7MUwOfEgtHi7quQn
	jx66b4S1uB/n6XmQd03b9hxrfx6OtxGFb80qF933yZTv+/wWSD4dTDR72n7N5v9TfFoaWMcEEIksu
	zqlhWA8vAH6hQk0O+KNkqCP5EhkrmHIRMbc35R6OsEL7mSyzmxoKxspncC30CEYl9dCOdx7A6dHqU
	mxJhVr2amLrWA1gDTQTuZuqWOZO4PylfzXFdDa2u4loTNuk8WiwkJBtjz+7bCR2XSaILVmBNzycBJ
	HNAwUtNtZ7jOaE8Y8QIvxfqChQhZapRj1MdfobL9G3YOtcSJo0+7uumawHtTKuzxqKvjvs+kfjvmL
	tHvR8xYfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFAVX-0007TY-Ej; Fri, 20 Mar 2020 05:47:47 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFAVV-0007Sw-Dh
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 05:47:46 +0000
Received: by mail-wm1-f65.google.com with SMTP id d1so5006839wmb.2
 for <linux-nvme@lists.infradead.org>; Thu, 19 Mar 2020 22:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7dPg4U8svUYFJEtkVAOtkWkAFExO6Ih2I/Gf71e770k=;
 b=jYK5weq00vLgESXAKWeHNPNkgfcWKaaae3qZ6/X6kfxyIdnC3jirKlCsmbJ5td4j6k
 +ffQ0qG1bsTfM9NLe4bTgEGnfZvmMzam47OHDvfpdNNa3a1TB8Vh0FD/D1FM/fteo9hA
 fOGh9oLuy8MB9l7Z922/lguiD05A8aNN9Cyc8UC3kfy/0cf0FyvDfk2vORtsHcLxzFFY
 gBzC03ycjEC8FthI4W9yia1TBDRHFyHmTdwnaIKRLhFPD1gR5jgph9aLZmjQig9P/ss5
 V0Nui3S3dbEcop7MnORN7xIylHPS2AfmAlzlmX4iQUzEDGQvoGLCvfyKzgXhwWUE4Ob+
 D7ow==
X-Gm-Message-State: ANhLgQ39vkrxPTYGY+6UyXx9xuEi19INRcqwFO2q4lT8rx5f5KYmBSMC
 PohiquhSpPbwmLROxtdzwCk=
X-Google-Smtp-Source: ADFU+vsrmyMUlvge3f/3ZNNku10L39XdAJssNSx+eOYzS9WDLnh76Yx/+DBPmgUcq1KpYN5CavWpkw==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr5238981wml.164.1584683263276; 
 Thu, 19 Mar 2020 22:47:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f092:4ccc:3e48:6081?
 ([2601:647:4802:9070:f092:4ccc:3e48:6081])
 by smtp.gmail.com with ESMTPSA id p15sm6574338wro.68.2020.03.19.22.47.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2020 22:47:42 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, loberman@redhat.com, bvanassche@acm.org,
 linux-rdma@vger.kernel.org
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cf52b987-e1d4-0b82-03a2-698ca79bfce0@grimberg.me>
Date: Thu, 19 Mar 2020 22:47:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-4-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_224745_462897_D09D9B2B 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: rgirase@redhat.com, vladimirk@mellanox.com, leonro@mellanox.com,
 shlomin@mellanox.com, dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, idanb@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
>   {
> -	if (!ndev->srq)
> +	int i;
> +
> +	if (!ndev->srqs)
>   		return;
>   
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
> -	ib_destroy_srq(ndev->srq);
> +	for (i = 0; i < ndev->srq_count; i++)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +
> +	rdma_srq_pool_destroy(ndev->pd);
> +	kfree(ndev->srqs);
> +	ndev->srqs = NULL;
> +	ndev->srq_count = 0;
> +	ndev->srq_size = 0;

What is the point assigning these?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
