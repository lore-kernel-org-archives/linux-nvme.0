Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43DC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:45:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5F22064B
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z5SKd7C7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5F22064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KTMBsoHxwAMB24IYGZm++e2rnYSW/jikb2x316avE00=; b=z5SKd7C7pLJdpTnDk677PJM+U
	HO3yp2tUb3cMuvoGYlatAWMJQrTlKy7rST7V+hnpb/jQ/Yu7yJFo3Rkpz7qdW6uHwsvYV1gmEwzOi
	0TmPs/XGVeGjH/s7h4YwGt9iCO5/TZnLSG20QgX+e5IFzEGHo3TeydAVHrVFzrenG/HTq1me9Jf9N
	uL6uEsaIUdJrjJjLPIQT2+Nm/Bv262880zV5KxQjE0woQlykr9YL1PJ7ORgBXlfF3Bp5pVrmCXqR9
	J2+pTLrmePcXgRyL58P5YL6ei7/vtXvdxP/MTBb4iiuwrjuUHQRO2zZDHxG2fIeMfK1Oo6rK7J8Rn
	GGu9h1nsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnmzM-0007fS-LO; Tue, 23 Jun 2020 17:45:40 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnmzJ-0007eO-BU
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 17:45:38 +0000
Received: by mail-pj1-f67.google.com with SMTP id a45so1324710pje.1
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 10:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FX6hyw2K/GlZbkxcQH0ReKiBgHEmp2VO727PD7fs5YM=;
 b=gSvbj6HX3nKGihpd9ztlKTc8K0DTqp50FIeZlyfPkFaW/HA+IjNufkW6q+/flKtIXL
 VL1x9nXliHiDR2hobKyaoS0J9ilXNscuK0o6Ax4SlDSGKGZsQf3NEB5OEfgqaSOkNnva
 G72sqYzyK/poXh+Ft18EfzR3Te3pCzT1nf1BCaQRdIiqhCgG3z76SbOfPYs7uFb1KfRi
 oDGrXPQzet5s1+utrUn6luYe0E3AgCbYqApjhyNd1ys9VpYm3UcKo/Jx+pz9RpQevP21
 BWhEFoFVrHBA7hAc3bUl732GXBQcscpk/FxLr3vbM5gEJvK+SxUQZ0b1g4BeMlXOQnh/
 OTLA==
X-Gm-Message-State: AOAM531KoAz/DN+wNcPgh3OUGBIAgPZRrK+gzmoya8Wv+VWJymVGkusR
 doCuaJQDb0tOLewqRBmVMBebTRZa
X-Google-Smtp-Source: ABdhPJygza4BgCBQdxxEfmouGRUizR3QaLs72AclE4EKxrZg/f4aRNSkOc1SrRsqfnh8DGB4TEVaKw==
X-Received: by 2002:a17:90a:cc18:: with SMTP id
 b24mr24576568pju.89.1592934336354; 
 Tue, 23 Jun 2020 10:45:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id a33sm6958898pgl.75.2020.06.23.10.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:45:35 -0700 (PDT)
Subject: Re: [PATCHv3 5/5] nvme: support for zoned namespaces
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-6-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <327444ca-8524-a0fa-c302-33e0278b2217@grimberg.me>
Date: Tue, 23 Jun 2020 10:45:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-6-kbusch@kernel.org>
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ajay Joshi <ajay.joshi@wdc.com>,
 Keith Busch <keith.busch@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Aravind Ramesh <aravind.ramesh@wdc.com>, Hans Holmberg <hans.holmberg@wdc.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good Keith,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
