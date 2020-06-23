Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB1EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:35:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE86520706
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l3kKKMe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE86520706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0fWflv2P9MgmHrOBvJ7t0vaKoYlo5cyy/l7HD35woNc=; b=l3kKKMe899fovKyUuQ3plwhje
	H7pfkYJDphG0IiCIwkKuZg4wRZGtM+35kRHCPpG7y/nrOeKFQelSYsSuUsAAUjfGfcG2CjZTKGRw9
	mtKaZzfAozugLjoWnaAMztXUEAU4lsE9MPUB0rmCISuSFUrW5y7prJUiNuFsCxNZpAF+b14Y76Ypn
	1DNDLgInomSYh+idK1UBe6ORhTjuOUvIerrFUG07zfp6X1gUQvtq5YdlH3rok3Ptl836tsV1m2a2C
	e2P5JhV9kKVEhrSCxRUJ9DHAnlq6rj6yGX053Q8yvSSTdU+lElwxjk2ATLU4SFsc8GaEQGRBOloxr
	/6i+LO5gA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnmp2-0003AP-Ic; Tue, 23 Jun 2020 17:35:00 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnmoy-000398-FB
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 17:34:57 +0000
Received: by mail-pl1-f195.google.com with SMTP id g12so9398622pll.10
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+A/6UEovR0ikbKJZDf8J76Ay9NDf8N0ASuhXXppOwdg=;
 b=B/pkVERHrDvrXoVVlihsWST19yWgRMzqx2gv3E9zWYtkQw3DlEINnIpqLiVeD+N9Pw
 9fL0HOOh3/z/+IO5SrLduzFszYVtt3prpXXYyS6SWrt+NtszCCe3uUPvmvTZc6jdYbWz
 wcN6xaJ7xRX96PHnSrWMBEYWnW/n0OcUdKk8j9TX1r2WZn31u8an94TTABzx8EB9YHn9
 5UsqHYYnt5Tih8WGdoZVx2tX3h9p7OeQD5vDvnAioqWfTs7TBR9AA7y8AElMfdL/2wji
 1AOyXETBNP4zB73G68UPXqjbckmuabhuLcnszjamW4BzEcp2awnYMAbJejneqrGTYgds
 op+w==
X-Gm-Message-State: AOAM530b9JVrqXapsRx1U4luk42Gbzo6UUpulZFbpwgAikfQZ5efFldT
 TzNXB5vo2YBv+wEcLK+43Us=
X-Google-Smtp-Source: ABdhPJyqviTZ7NT7z0ApcZ8Qw0NF72vsP6rhiDSDmUeDtVnECSO/1TwMuGo1dKY+3oOx20UAM9sJrQ==
X-Received: by 2002:a17:90a:7e5:: with SMTP id
 m92mr25335069pjm.196.1592933695223; 
 Tue, 23 Jun 2020 10:34:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id jz23sm2920583pjb.2.2020.06.23.10.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:34:54 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
To: Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
 <20200623152236.GA3072004@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
Date: Tue, 23 Jun 2020 10:34:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623152236.GA3072004@mellanox.com>
Content-Language: en-US
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
Cc: yaminf@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, kbusch@kernel.org,
 ogerlitz@mellanox.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> The completion vector index that is given during CQ creation can't
>> exceed the number of support vectors by the underlying RDMA device. This
>> violation currently can accure, for example, in case one will try to
>> connect with N regular read/write queues and M poll queues and the sum
>> of N + M > num_supported_vectors. This will lead to failure in establish
>> a connection to remote target. Instead, in that case, share a completion
>> vector between queues.
> 
> That sounds like a RC patch? Where is the fixes line? Why is it in
> this series?

Agree, this should be sent as a separate patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
