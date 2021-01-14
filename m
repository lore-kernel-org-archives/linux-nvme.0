Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D940C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 16:34:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E157023A04
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 16:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E157023A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X3eH3PV0N7FXFZN6GdpKi+S4yRB7EfZsVGMCnmNNORM=; b=b+FAj+MLlsl/DwI6A8Pz67xnN
	+7QI4S+xG4J9v6rvTaJ16jzeQjlcJLpjHbfagWx6SzHJeNwjTbffD6+Wers5t+6lCNXc1/dXyr8jk
	w1xBiM3bU69ppZHg/1TW7xvJ4/ftm6laabUB29Z2D1KX6tz3ujjOX/rHRPptFW2/C9zi0qAqzmZ8I
	4DKdaF0mvDE3A8lXU2P2Db/ySOkY0He1G8/5k6Lk7uBUjcsxvM09VLlApKNLiGZC2qTGHjwdHw49P
	glSkK2+swO6gsfhCOwiteRZJYcOAFkq3Dyrb5ikLlliXrY7wb7SZikIywUs6mjWaDwudXSMaDTNGX
	sKIduYFBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l05a5-0002ZP-Ii; Thu, 14 Jan 2021 16:34:41 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l05a1-0002YT-Nr
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 16:34:38 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600072980000>; Thu, 14 Jan 2021 08:34:32 -0800
Received: from [10.21.63.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 16:34:28 +0000
Subject: Re: [PATCH v2 1/2] nvme-rdma: avoid request double completion for
 concurrent nvme_rdma_timeout
To: Chao Leng <lengchao@huawei.com>, <linux-nvme@lists.infradead.org>
References: <20210114090926.12109-1-lengchao@huawei.com>
 <20210114090926.12109-2-lengchao@huawei.com>
From: Israel Rukshin <israelr@nvidia.com>
Message-ID: <ab0a9be7-778a-4fdb-4bd3-cad6c76534e4@nvidia.com>
Date: Thu, 14 Jan 2021 18:34:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114090926.12109-2-lengchao@huawei.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610642072; bh=QXl5PHxbN0UP/RmAeO2NTJAO0DBskUR6W6wD02xcYgQ=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=JeZjSQCIPW+Gv1i8SVOmyzwx8Q+BJLOSIURuR+kiTx74ulmJr0lyVGiioAhi/mL3W
 FBhDQPNGT6vSx3W7Fhd+IUxUaLMG84xhtAHmDJvWXnJB8zgVpiwv68M6/Rg8WcQIQs
 zK3uri1slN3ggbECFhrgsDrvT2OepKWOze7YKCHo1mXoL1c1N7swctUEulJcgkQJ1l
 7RBWWDTCnB7CqUpXO1FljLcPe1DLi48AfSIltFcsbWLhrCXpdH540oLkHJmNgBcfx+
 YeecQjR8vTd/Sq8CfbrzQk1nI5OBaqZhbzFaSwVnEI09NFq+fBrZLETs7ae2xmDl08
 5v9xLkDFPEOKA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_113437_882616_2896CDFE 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/14/2021 11:09 AM, Chao Leng wrote:
> A crash happens when inject completing request long time(nearly 30s).
> Each name space has a request queue, when inject completing request long
> time, multi request queues may have time out requests at the same time,
> nvme_rdma_timeout will execute concurrently. Multi requests in different
> request queues may be queued in the same rdma queue, multi
> nvme_rdma_timeout may call nvme_rdma_stop_queue at the same time.
> The first nvme_rdma_timeout will clear NVME_RDMA_Q_LIVE and continue
> stopping the rdma queue(drain qp), but the others check NVME_RDMA_Q_LIVE
> is already cleared, and then directly complete the requests, complete
> request before the qp is fully drained may lead to a use-after-free
> condition.
>
> Add a multex lock to serialize nvme_rdma_stop_queue.

Looks good to me.

I tested this patch at our regression.

Tested-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
