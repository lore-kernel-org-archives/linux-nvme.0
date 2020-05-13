Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F07C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:45:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB707205CB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B1+1hefI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB707205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=orT9WfpRFhX/ehMPxXKgjoEMmF3RJNW3xsAO2hRp0mk=; b=B1+1hefImYDIp8nKYllmBYXpt
	SgHDf0/EsM4oqcI9BF9AeJsEA2ZgG/bPH/aeDuHwdLcd9Xd0lZQ2Xf8gt5nHMMhNSjrx3N3WKJtX2
	4EWqvZGq8Ev0iFrCPs4w46mZhUgN4ty9jokXV1D7wwvQzW4szOSsE3/S1YqudpxJxPdhGn/cKURcP
	xWaXUNypbTGb+hHkfK+QjWBL/mojL6CkN+tq8kfAV4gdzP6c3YG1akxX6vj0RHT92iPDDvKnL3STI
	qj/N62dRvZzR0s3oqT1G4bVsXSYRURBl52WejMvoms7/47trXANVfQNGHoLuEWJ/rjSR3Dlioax7S
	oHivpW0nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYwO6-0000CB-Lx; Wed, 13 May 2020 18:45:50 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYwO3-00009s-34; Wed, 13 May 2020 18:45:48 +0000
Received: by mail-pf1-f195.google.com with SMTP id v63so127345pfb.10;
 Wed, 13 May 2020 11:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oGExS5qpyhaJE9sRdyvo65rhkDZrEjTLCCqtKDwIC/k=;
 b=KkfQfC8+LWQOykLgE6DOU3JPRgVCUYgFOy4nlwJlKfaCqoq9L7BfK9YiPOY8c45QQX
 kCv7stpqiR+MgcQWGKEuPRttWfBvHzqKoJiAxzij5Gxh4xatqxVNeAoGkNX4QPfilhLp
 vV57j5oa+teZxPDkejwi/PlMeVUsTL2Nn2+1wFr5IMYthLMVHjshF7r3AGI3wGh4S4+L
 LU6T6ILrA5VYSXxT1VuWHmpEdG89BhT0cyU0PDiPIT+5nLPr7zEHidszgCwxk3X8bNBk
 nLK5Bs94usZDArBc00ijg2a3waI9mYVKlc5ZIgbbb/mv5bSyXXut/Hv5q7GynYLk1B9I
 88Zw==
X-Gm-Message-State: AOAM532Nl3WqDVXtMcuiStT/6z3jf8VnmBFB0fcC1PM8OEbKjfwyTXqA
 mVSqbUC/KSncY3d90I75aQ8=
X-Google-Smtp-Source: ABdhPJxuCtZ6LqG/D7UsLLlMEE3Gj8Q00WqSwzmkuBnzsqf4vGt4xYIyJ/k3v57Ipr7A3TPHVfXEFQ==
X-Received: by 2002:a62:7d91:: with SMTP id y139mr631244pfc.172.1589395542971; 
 Wed, 13 May 2020 11:45:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59e0:deac:a73c:5d11?
 ([2601:647:4802:9070:59e0:deac:a73c:5d11])
 by smtp.gmail.com with ESMTPSA id g10sm238580pfk.103.2020.05.13.11.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 11:45:41 -0700 (PDT)
Subject: Re: remove kernel_setsockopt and kernel_getsockopt
To: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20200513062649.2100053-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c9a28f7-4268-2295-0d64-ada9178a5553@grimberg.me>
Date: Wed, 13 May 2020 11:45:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513062649.2100053-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_114547_133017_D5A15F2F 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 ocfs2-devel@oss.oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Dave,
> 
> this series removes the kernel_setsockopt and kernel_getsockopt
> functions, and instead switches their users to small functions that
> implement setting (or in one case getting) a sockopt directly using
> a normal kernel function call with type safety and all the other
> benefits of not having a function call.
> 
> In some cases these functions seem pretty heavy handed as they do
> a lock_sock even for just setting a single variable, but this mirrors
> the real setsockopt implementation - counter to that a few kernel
> drivers just set the fields directly already.
> 
> Nevertheless the diffstat looks quite promising:
> 
>   42 files changed, 721 insertions(+), 799 deletions(-)

For the nvme-tcp bits,

Acked-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
