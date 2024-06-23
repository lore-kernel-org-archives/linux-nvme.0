Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59646C27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZpMlVJ+jaIKNfbBuiKZlvKVWDvGFGqrDWEQvknRsjU=; b=Hh922nJ2Zou7Q0RcPkv4IOiglJ
	OL9H7vV157E4OhM+dhdwwoJPrLF7StG8E4s/K2cemqc6tE1XpjAK4s9pgr10Ha0cW62R/xglKAFlY
	9mQ0JnpQOOSNMskIYsPJPA8yHwTNRGafOvOmn2fDjhD5UhQxez2MDg+RFqP8NvgSuS1qwMfW+Rj/7
	V/Gl/nQA/mVyVBpN2Byhe3VJMGDb4Gqkl+TPlJ/E9JgKXyAqhRl1iSxtKBgs46IORn/3Hj1lhWXOh
	ejUBRK80Qs9rB8MoUA1wnABut4yGUgLsZfpoGutQB5RjloQapx5zLvy3/alIzKE1X+PAZvwKUn3In
	zaBUQhDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLMsj-0000000E1Xf-05re;
	Sun, 23 Jun 2024 13:03:45 +0000
Received: from out-175.mta0.migadu.com ([91.218.175.175])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLMse-0000000E1W5-3ygW
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 13:03:43 +0000
X-Envelope-To: mgurtovoy@nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719147815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZpMlVJ+jaIKNfbBuiKZlvKVWDvGFGqrDWEQvknRsjU=;
	b=vXJShoiB6Kl8C6LDFDQf21XiOgU0xnzje9Rg27Lk8JkSB4jwlgxlNxFCxVWMuNFUR7u9G0
	nvYiTPZmjYFWordThzh/QcB8YnLcQw46rpK+D0kGFfSqMVWU4IlE4fmVeN+cAm5u6bi88m
	uYUDwLoBEV65Hv4JuSFjDym6vdNCQcE=
X-Envelope-To: leonro@nvidia.com
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: linux-nvme@lists.infradead.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: chuck.lever@oracle.com
X-Envelope-To: oren@nvidia.com
X-Envelope-To: israelr@nvidia.com
X-Envelope-To: maorg@nvidia.com
X-Envelope-To: yishaih@nvidia.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: shiraz.saleem@intel.com
X-Envelope-To: edumazet@google.com
Message-ID: <9a23267e-3d63-44d2-8f06-ca8cbbf2567a@linux.dev>
Date: Sun, 23 Jun 2024 21:03:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/6] Last WQE Reached event treatment
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_060341_665206_A77875E1 
X-CRM114-Status: GOOD (  15.17  )
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

在 2024/6/18 8:10, Max Gurtovoy 写道:
> Hi Jason/Leon/Sagi,
> 
> This series adds a support for draining a QP that is associated with a
> SRQ (Shared Receive Queue).
> Leakage problem can occur if we won't treat Last WQE Reached event.
> 
> In the series, that is based on some old series I've send during 2018, I

The old series is as below. It had better to post the link.

https://www.spinics.net/lists/linux-rdma/msg59633.html

Zhu Yanjun

> used a different approach and handled the event in the RDMA core, as was
> suggested in discussion in the mailing list.
> 
> I've updated RDMA ULPs. Most of them were trivial except IPoIB that was
> handling the Last WQE reached in the ULP.
> 
> I've tested this series with NVMf/RDMA on RoCE.
> 
> Max Gurtovoy (6):
>    IB/core: add support for draining Shared receive queues
>    IB/isert: remove the handling of last WQE reached event
>    RDMA/srpt: remove the handling of last WQE reached event
>    nvmet-rdma: remove the handling of last WQE reached event
>    svcrdma: remove the handling of last WQE reached event
>    RDMA/IPoIB: remove the handling of last WQE reached event
> 
>   drivers/infiniband/core/verbs.c          | 83 +++++++++++++++++++++++-
>   drivers/infiniband/ulp/ipoib/ipoib.h     | 33 +---------
>   drivers/infiniband/ulp/ipoib/ipoib_cm.c  | 71 ++------------------
>   drivers/infiniband/ulp/isert/ib_isert.c  |  3 -
>   drivers/infiniband/ulp/srpt/ib_srpt.c    |  5 --
>   drivers/nvme/target/rdma.c               |  4 --
>   include/rdma/ib_verbs.h                  |  2 +
>   net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 -
>   8 files changed, 92 insertions(+), 110 deletions(-)
> 


