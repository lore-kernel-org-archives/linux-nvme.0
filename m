Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3BCC55178
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 13:23:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7FA20759
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 13:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xxPgG9FR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h5HwtLju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7FA20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1fnahe5FUmmn9xNTtztFCwn4WWAGkaHIxQKvUVoLH/Y=; b=xxPgG9FRzv0q4OkA3lRo+upPa
	IGd6J790bznIAf55GRd+b2sxwulWHb22+kOj63fQTEJt4Qop2HpiatjLxS2Eo1/xy1gPwkUhWJsun
	+1nP2hv/o/fa2d0RglBXT6F6f03cgAb8jln7iOGla588aILHVbe4s+OVADiEPxOm8F7iY+Q2VLU7L
	vof28sh4nq2izMC/kW387Nbu790n3Tfwft1oGuH9BdtNWd6ARHwbabaIwgjH+HLH/lUQ2Wc0POIZV
	IhTyaTAYwsQski48EBvS/+zNFA039MxK7Jb6fOGrtt4gChBK8ur5crtQ/ugjlNZSmQ/Ac3x3FXa9j
	sPddnqXDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXOwx-0004fd-Vi; Tue, 27 Oct 2020 13:23:44 +0000
Received: from nat-hk.nvidia.com ([203.18.50.4])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXOwv-0004eR-ON
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 13:23:43 +0000
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f981f560001>; Tue, 27 Oct 2020 21:23:34 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 13:23:32 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Oct 2020 13:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4lBRwh6KkG02Ch90NKhCjo9AeOyL7nnpOAkb6OPnPyeBnERAoProL2gcrwu6GexT1codYmeVmFx1cBt3eCdQqfQZMrHk5eKVHLe00hraNXKEvIpma5sY3Jkb+lMPA9yqXkxb2ba0Dj0a/XRHDakzOPg0/wlR3TZGqENxwZrOX9+XXAxmVqMMxcxMef40VbgUCzhZ6Fw6lM1pBLp9xzggzFStaXfArQpHn/cPYPAa52q4atjyttCXKbam3KT0x1ovbu85ZfCmJVb5gNsMjUjb/TiZo51ahZaRGYVpibHTJI/YJ+2p4RzFlxGEz0sB/NAgR3zdsmtp4VBnyqRPaNb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO+N/jDgb0eszrDJcGQyjQ5CdeTguL3b1ZF6FMF8r2g=;
 b=dACuIg0wq98ez83vX71Bki+pABMLVqMu+ZJwA4XGAWQJtU9FR76kjR/wTkrixal7XKCX1Pe427ljNJdZo1VHqcs8O7SzmKhFkCdVEd8RxITnlbwH6pZscy/ysNLkU8wC/nBDL0A+Zqze6snw4obiiLexsqy1StsUBw7D9LFL3eCuXI5MmAnWPsA8VHAXH15yC93LtzCSGtpuq7fYinp91Y9Z2FuArrNstkhEZzFYGeKORN0iGAgoC5q0noK0IxMq9EbWUMFAFKxPQ0MNuueFmqPI6ohuNXA9vG0RyieOi/LPVIovMKV9nHDNjmwv2swnrwylFMP+gbitMECusGSGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 13:23:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 13:23:27 +0000
Date: Tue, 27 Oct 2020 10:23:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
Message-ID: <20201027132326.GK1523783@nvidia.com>
References: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
 <20201027131936.GD1763578@unreal>
Content-Disposition: inline
In-Reply-To: <20201027131936.GD1763578@unreal>
X-ClientProxiedBy: BL0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:2d::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:2d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 13:23:27 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kXOwg-009KaE-0U; Tue, 27 Oct 2020 10:23:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603805014; bh=vO+N/jDgb0eszrDJcGQyjQ5CdeTguL3b1ZF6FMF8r2g=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=h5HwtLjuOaUZf6apBG1d5jF7BDxVb3Gq1Di+HeNipjgbl59tCyuyDdOOqWt9Ki93H
 zeDmOz0U/k8MWjD8iXfveRlPpjyf4+LW7AjU4T0r5uqhj3LE4Se00xkeY89aJufeB8
 4kjP9S2DkVCSqYaRaFqKJWJPGuAKpXYQbhWg6scClsEroR5CaQwqAqnNQzA4wwCZyC
 iYZBLScxnlbr6jUhG6KX8Q82btkxt8dw7C+7WGu0W17hJuiJiA8U7qhzUWpI2egN9u
 bxrIQcPxYwMIET+nFyklnQVaTx97Oqu2rc66P/qtzFeezol9Rrr6Pzz+TW8/pT4gKr
 WFQ68/3OvZF1w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_092342_046982_5F31C2A2 
X-CRM114-Status: GOOD (  12.28  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh
 Shilimkar <santosh.shilimkar@oracle.com>, rds-devel@oss.oracle.com,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 27, 2020 at 03:19:36PM +0200, Leon Romanovsky wrote:

> > +int rdma_connect_locked(struct rdma_cm_id *id,
> > +			struct rdma_conn_param *conn_param)
> >  {
> >  	struct rdma_id_private *id_priv =
> >  		container_of(id, struct rdma_id_private, id);
> >  	int ret;
> >
> > -	mutex_lock(&id_priv->handler_mutex);
> >  	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT)) {
> >  		ret = -EINVAL;
> >  		goto err_unlock;
> 
> Not a big deal, but his label is not correct anymore.

Oh, yep

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 193c8902b9db26..f58d19881524dc 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4053,10 +4053,8 @@ int rdma_connect_locked(struct rdma_cm_id *id,
 		container_of(id, struct rdma_id_private, id);
 	int ret;
 
-	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT)) {
-		ret = -EINVAL;
-		goto err_unlock;
-	}
+	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT))
+		return -EINVAL;
 
 	if (!id->qp) {
 		id_priv->qp_num = conn_param->qp_num;
@@ -4078,7 +4076,6 @@ int rdma_connect_locked(struct rdma_cm_id *id,
 	return 0;
 err_state:
 	cma_comp_exch(id_priv, RDMA_CM_CONNECT, RDMA_CM_ROUTE_RESOLVED);
-err_unlock:
 	return ret;
 }
 EXPORT_SYMBOL(rdma_connect_locked);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
