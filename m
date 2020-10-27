Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678AC388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:01:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAD522263
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 12:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RD6Nnu3Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ntYWLwfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAD522263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BbdVEBYBaA1o28DeW0SysIVXh8pxN1/L9pwJPq7Q3+c=; b=RD6Nnu3YlSi/noiYUm/3R1Kpa
	GygeAnTukMOjRdnQtH6ox7FkvfrVXwYuLdMbjUrFg5zSWSxGbfCYd9UvjI6nfiy+8fT3y8FyqgwqY
	d0ZOsT72Pn86N71YJxBdGkCc/a5SfwJMivPgAz/ttnSssagKq4tT+F2yoS8Xls9RZ/E9IMRT79xeG
	wV/ZEAYmV71jNWDvw9WYJ3RJ9kVw+sBoNsGeeVN8OMnBZOpKhRQferdrkPUtbFSXtI8+no4/fY/Ef
	m3LeJ6Lf/PITzxiMtjMlSXnW0M7Gc5aXZcH0yO1f3AP1tq5hYJEdol2W0Bo19V4l7x6hxTMfmvxwC
	UrgqCMgyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXNen-000398-IG; Tue, 27 Oct 2020 12:00:53 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXNek-00037j-Q0
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 12:00:51 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f980bf70009>; Tue, 27 Oct 2020 05:00:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 12:00:44 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Oct 2020 12:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2FwqwmxJ2w/YMUeqxlS/RgBqC7+pqc8Y5WrTpJpxT1GW/9Cefi/yeUzr9VZQPj9KMrYRlSTgL4ZEo4Hjzr92c42arJZ6r66cQ0qRubZ63GWcSQ2sxRPvjbWwsbXfPWeNvCwUinsUIeVmdN0a2cSJIsgIGRkWvRSkOOy3yUpLYpaQ1dWoYVH9nLg3G0ya4jU4QQ6FeGZYHR+2KUyQtlbKDWuztrR9ALuSCA1HqqYwWrMcxtlKKgkHagRi2P/qLTK5lvd6vS0r8H6gOkGP/evwkVzmGteSinFSLrzU3fxY0r2PQm2uSlydIFPme3S874KPVKfVAkPwr3Hjdrrpi96hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVjL38duaU6sTOh08XTelj0txgnpIU7gLTO6m7WrnCM=;
 b=aFR8GvjzcxB1OMTKHHibPgcm6MmqbLgx8R7bN9g4AbuniUa8CV4H7PGBVd7DX4m12WiaU7cFcSk3sexEDTTbjWNIp3D1JR7P+pG2gUdAS/apUtgl2+wBrBLZr3A3YDKxH2sSZVcg/C6bfeioGpW1R1/SNtw6CX/kXPh1sKkQN8nXcftfeTTZE9hoNSQ+XpiL2vXMlRA0NkyadLBl1QMiUbTqrqY1pnvWoTsVL9PXvlVU+oMphcZEkmxu33DN67EG1oR31jmF6psxZqK6p4gpygfhYss922ypLkCFtN2nwjB49zyonTxrglPRGvSg76VIga7oQx6xyg1FpS3PjlqJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 12:00:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:00:43 +0000
Date: Tue, 27 Oct 2020 09:00:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] RDMA: Add rdma_connect_locked()
Message-ID: <20201027120041.GI1523783@nvidia.com>
References: <0-v1-75e124dbad74+b05-rdma_connect_locking_jgg@nvidia.com>
 <e13ec119-3cc6-87ab-bc76-d2d3de7631e4@huawei.com>
Content-Disposition: inline
In-Reply-To: <e13ec119-3cc6-87ab-bc76-d2d3de7631e4@huawei.com>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR11CA0023.namprd11.prod.outlook.com (2603:10b6:208:23b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 12:00:42 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kXNeb-009GRY-SB; Tue, 27 Oct 2020 09:00:41 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603800055; bh=qVjL38duaU6sTOh08XTelj0txgnpIU7gLTO6m7WrnCM=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=ntYWLwfLUxG88YLiEwTYaRecEr1b29TXd+4lQG3FRXrOw0cSffingX5XQMrK45mgl
 50WI+Uy6P+UEJrAgEOsrUItYg8DxX0MyyuWH9suSK+xow4DqP074KUfXu5Vz369BKA
 7DPOmO5Nk5Fy+Te4GODCD5JnQrgoYg9BzluUMwdHQOd3ozOi1mzqh6QIpcns1FiEA5
 cPSdDGm0ooptbHRfX85cRvGwo2S6pD7BS+7Fna3CqBo3wBPvBz+saeHeazmK0dka/Y
 uYcDvgQ6dseaFhQhUw0yKRjeBAYMKiMDADjaxBFiwuUF3ejqh1iYtfSCUSG7JFh9bN
 8oGH7Ke9qsVNA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_080050_944358_8535B6F3 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, linux-nvme@lists.infradead.org,
 Doug Ledford <dledford@redhat.com>,
 Danil Kipnis <danil.kipnis@cloud.ionos.com>, Keith Busch <kbusch@kernel.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Leon Romanovsky <leonro@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 27, 2020 at 10:01:00AM +0800, Chao Leng wrote:
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index aad829a2b50d0f..f488dc5f4c2c61 100644
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -1730,11 +1730,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
> >   	req->result = cqe->result;
> >   	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
> > -		if (unlikely(!req->mr ||
> > -			     wc->ex.invalidate_rkey != req->mr->rkey)) {
> > +		if (unlikely(wc->ex.invalidate_rkey != req->mr->rkey)) {
> >   			dev_err(queue->ctrl->ctrl.device,
> >   				"Bogus remote invalidation for rkey %#x\n",
> > -				req->mr ? req->mr->rkey : 0);
> > +				req->mr->rkey);
> Maybe the code version is incorrect, cause falsely code rollback.

Oh wow, thanks for noticing that, I made a git fumble when doing this
:(

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
