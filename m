Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098EC388F7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 13:31:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B363E22283
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vKKxNqxR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dfLB2rsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B363E22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mUUWDGvOm0oMRdRh62pNUbsqhyjFIEmpkmD2Q0A389c=; b=vKKxNqxRluuyAcUchr/oFkiSA
	O13UFajvBtRgzoPUH0PgtS8+v8EBEG2zLZDnUECPybi8LRREVu7+/7rwFZesmzuIHMQycGpfnefSM
	wQbBY3ZRB9QO3tnOOzCsrPQwnVyPJ/6F+Xr06Ejc3Cj3ul3hprEKPiErlk3tuFlKyWMt/8FAwM+o9
	8IUTB2Gelbra/U0YTeIG6AF57uLn98LkDGvA0VY0lstEQP4rmajgNNsnlP8dYzszX/tBoNzqFQUv8
	ae6QVO9aE1TO1T3GbB35nnKFFRK88OL4Tk8IlOBvkQV+nQ+4k4tOofPQg7EdM5yqIrXdg1WgaJICA
	xxDARcbIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXlXs-0002Jk-Dp; Wed, 28 Oct 2020 13:31:20 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXlXp-0002Iu-86
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 13:31:18 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f99728e0002>; Wed, 28 Oct 2020 06:30:54 -0700
Received: from [172.27.12.9] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:31:06 +0000
Subject: Re: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
 <4401b7b1-5d05-a715-4701-957fd09f34c9@nvidia.com>
 <20201028121437.GU1523783@nvidia.com>
From: Maor Gottlieb <maorg@nvidia.com>
Message-ID: <8306260b-ce24-3803-7d39-42f5d2209af7@nvidia.com>
Date: Wed, 28 Oct 2020 15:31:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201028121437.GU1523783@nvidia.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603891854; bh=fKN2cuSU18H4ENLzpHtOq1/kruo8GahizM1U701HZ08=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=dfLB2rsS1jUeLVi1EHeqpVPZWc/4tQtRWeoiQezb8WagHM2EcW7c/0f1dboAtSOG6
 IXyLr9NhAuGTFluamN3ynArryMwcDQwtPhZ0TYR+nRvXYYVOtTAx4X7GZg/tot7M2p
 7ruyD2L7GnnqM30XK6BApKEHUxrN9la+USpL5oMPyaNTpbvi0ccrfmEUZUPqymKFHJ
 glkEMEt11eJbAhHl3+SV+3ancTya0jEfZNi7WAyrlOwKhz0fflBOj3KL2DMnBJocIV
 mYY8+o9QX8TuAIyH+N13YrhDQwAsY2/WLdDl6I60N9sKzqgDkQpjdMR4wQEVVccX+7
 dv4Or74fAEf/A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_093117_392419_0B571A20 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Max
 Gurtovoy <mgurtovoy@nvidia.com>, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 rds-devel@oss.oracle.com, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Leon Romanovsky <leonro@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/28/2020 2:14 PM, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2020 at 11:19:14AM +0200, Maor Gottlieb wrote:
>>> +			struct rdma_conn_param *conn_param)
>>>    {
>>>    	struct rdma_id_private *id_priv =
>>>    		container_of(id, struct rdma_id_private, id);
>>>    	int ret;
>>> -	mutex_lock(&id_priv->handler_mutex);
>> You need to delete the mutex_unlock in success path too.
> Gaaaaah. Just goes to prove I shouldn't write patches with a child on
> my lap :\
>
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index f58d19881524dc..a77750b8954db0 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4072,7 +4072,6 @@ int rdma_connect_locked(struct rdma_cm_id *id,
>   		ret = -ENOSYS;
>   	if (ret)
>   		goto err_state;
> -	mutex_unlock(&id_priv->handler_mutex);
>   	return 0;
>   err_state:
>   	cma_comp_exch(id_priv, RDMA_CM_CONNECT, RDMA_CM_ROUTE_RESOLVED);
>
> Thanks,
> Jason

Reviewed-by: Maor Gottlieb <maorg@nvidia.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
