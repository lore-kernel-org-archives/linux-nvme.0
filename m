Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AECCC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ntTxqe3cu4c0Uf8vB38QsM5/1MJtQWWwjbiUS6GuQg=; b=MyaEYhqX2T4I1uJ0seD8emXfj1
	bqzCrAp0exqxZdxu0EiwpnQTZKA6psGtwMTocJeECd9N1MX1nQClAsgHgc1nrVLW//mLEVa07ydtM
	fiYULv0ksLI+O3bi1tAFviWHe41RD3L3iDgjZmFytafUNZoLw8VVqumGBNUWfn+KicKfEkg73BwpM
	7ddICHxozPqSnN3asR8ZFS4nBoeiRxpTFRVUkiioJVyFePDJisQvvRITnN0Snry0q6PdI4DOXf2f/
	QDKHECQL71x4eaSh6qJ8AgLFN0rh70kh3FDt0LyqKkp3FmxKneG6K/ml3SPtmO8kKbuyJCxUlV5Oj
	znu1sTWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncKe3-009WpV-Qf; Thu, 07 Apr 2022 05:25:23 +0000
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc9Un-007NYP-1Z
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 17:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649266265; x=1680802265;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=6ntTxqe3cu4c0Uf8vB38QsM5/1MJtQWWwjbiUS6GuQg=;
 b=LX0ymPEpza7f0C4O9YLYFqJQX6hhPNMz+ObiCce8uUjBCnibfeIRe4E+
 MEy9xh998TWUGA5yrZ7UAQbFeSIyRaW4UPO7PncThO9PbtAnR+655arEc
 nZIvbuLjjr2I03szmyykj6+lR1Nim4sqUeae55dUnpKM3o3u0Djf2GPwb A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 10:30:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 10:30:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 10:30:51 -0700
Received: from [10.110.72.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 10:30:48 -0700
Message-ID: <1bd025f0-8805-6ec9-7927-a9a18d0e0431@quicinc.com>
Date: Wed, 6 Apr 2022 10:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] RDMA: Split kernel-only global device caps from uvers
 device caps
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Ariel Elior <aelior@marvell.com>, "Anna
 Schumaker" <anna@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christian Benvenuti
 <benve@cisco.com>, Potnuri Bharat Teja <bharat@chelsio.com>, Bernard Metzler
 <bmt@zurich.ibm.com>, Bart Van Assche <bvanassche@acm.org>, Chuck Lever
 <chuck.lever@oracle.com>, "David S. Miller" <davem@davemloft.net>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Christoph Hellwig
 <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni
 <kch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>, 
 <linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>, Mike Marciniszyn
 <mike.marciniszyn@cornelisnetworks.com>, Michal Kalderon
 <mkalderon@marvell.com>, Mustafa Ismail <mustafa.ismail@intel.com>, "Nelson
 Escobar" <neescoba@cisco.com>, <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <rds-devel@oss.oracle.com>, Sagi Grimberg
 <sagi@grimberg.me>, <samba-technical@lists.samba.org>, Santosh Shilimkar
 <santosh.shilimkar@oracle.com>, Selvin Xavier <selvin.xavier@broadcom.com>,
 Steve French <sfrench@samba.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 <target-devel@vger.kernel.org>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Yishai Hadas <yishaih@nvidia.com>, "Zhu
 Yanjun" <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
References: <0-v1-47e161ac2db9+80f-kern_caps_jgg@nvidia.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <0-v1-47e161ac2db9+80f-kern_caps_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_103105_155436_95701177 
X-CRM114-Status: UNSURE (   8.08  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 06 Apr 2022 22:25:17 -0700
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

On 4/4/2022 9:18 AM, Jason Gunthorpe wrote:
> Split ib_device::device_cap_flags into kernel_cap_flags that holds the
> flags only used by the kernel.
> 
> This cleanly splits out the uverbs flags from the kernel flags to avoid
> confusion in the flags bitmap.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

subject nit: s/uvers/uverbs/ ?

