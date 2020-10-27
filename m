Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB8C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 13:07:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E075C221F8
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bRkPIeRD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dO8XL3In"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E075C221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kU7kCR/gkqSlNUvlRBUmw+Mle4rSp5y1Da6SSpJgEDc=; b=bRkPIeRD7YICWQB1gG9xFlp4D
	fVTK2e7hnbRKWWs768TfEk4xXVbwLdb+j4lh2+K8xBtbHdYdKNg+amASPlGNKYp7Pat5UOrIMCJa3
	o08ISkHAYGCIlSqYIq+DhTPrV6ifZTpUrNi3+lsbgLqI4urWDHt547rwrdsQQFzddh1B0H4+egcAO
	wBOheUrhcbFuW2fehMxNU7DZ+Ng+fEfoZgZtgdYI5JkhxJioPayS7Qjh/T7AaAxPIaWFqPirdXoLq
	SGTRomtTvJ7dsGLrxatg40JTfzrxSABwJggwVTYUcuL/KIzy1/zy/InaWMq+kACF6LfFvyLP/8tAd
	ccM4FspcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXOh2-0001l8-Gw; Tue, 27 Oct 2020 13:07:16 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXOgy-0001jO-Mk
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 13:07:14 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f981b850000>; Tue, 27 Oct 2020 06:07:17 -0700
Received: from [172.27.0.89] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 13:07:05 +0000
Subject: Re: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
To: Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <5b4368f9-c231-bcf4-28af-7a9bcac02eb4@nvidia.com>
Date: Tue, 27 Oct 2020 15:06:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603804037; bh=6Q/IdCWw38YxALtmasbIeodS+QkH/1f5Xs2g0ojNtug=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=dO8XL3Inf54YR8XkHIfCgLVYwUP6+sbCHyysJElERfn38mZYsxUulhQDkvBP0+hhn
 t5B3UnB65Y2ZPOCcCfdOXZt+om6cU4kaHzeQZjKtFAaFUMl0QJms6REmu3QVemlLXI
 PMfOVkz/bNsKUYO73NIPOCi/Nu8+Sylur1e/7pNum9EmwKK+Hghiy/ChMBH8ieAbFJ
 CFVdD1sm5yM6L9jpUT9asr3Bm/RHXfS8b37wdLRFMrOgu03DIXFL+gh+RagvJY2TI+
 33Skylc/CMEBpp9JI2Juza/vGW25XVlz2tcAw6LN681v3pXp6KrqfeXBCDppHDTRFd
 2j5KeEDTYOgxw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_090712_898566_57F75D0F 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>, rds-devel@oss.oracle.com,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/27/2020 2:20 PM, Jason Gunthorpe wrote:
> There are two flows for handling RDMA_CM_EVENT_ROUTE_RESOLVED, either the
> handler triggers a completion and another thread does rdma_connect() or
> the handler directly calls rdma_connect().
>
> In all cases rdma_connect() needs to hold the handler_mutex, but when
> handler's are invoked this is already held by the core code. This causes
> ULPs using the 2nd method to deadlock.
>
> Provide a rdma_connect_locked() and have all ULPs call it from their
> handlers.
>
> Link: https://lore.kernel.org/r/0-v1-75e124dbad74+b05-rdma_connect_locking_jgg@nvidia.com
> Reported-and-tested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Fixes: 2a7cec538169 ("RDMA/cma: Fix locking for the RDMA_CM_CONNECT state")
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/core/cma.c            | 40 +++++++++++++++++++++---
>   drivers/infiniband/ulp/iser/iser_verbs.c |  2 +-
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  4 +--
>   drivers/nvme/host/rdma.c                 |  4 +--
>   include/rdma/rdma_cm.h                   | 14 ++-------
>   net/rds/ib_cm.c                          |  5 +--
>   6 files changed, 46 insertions(+), 23 deletions(-)
>
> v2:
>   - Remove extra code from nvme (Chao)
>   - Fix long lines (CH)
>
> I've applied this version to rdma-rc - expecting to get these ULPs unbroken for rc2
> release
>
> Thanks,
> Jason
>
iser and nvme/rdma looks good to me,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
