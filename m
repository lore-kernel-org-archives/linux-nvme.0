Return-Path: <SRS0=oU3s=W4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12890C3A5A4
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 14:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14CE20818
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="emFATsZz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IJXMQ9Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14CE20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0NINoUcEA+HcSxcYSOGhejNAZnOUmjYyRWCRvF54yfU=; b=emFATsZz7lU7o9RzuV2d0Jqm9
	fKop9yLIVvkZxc5Tj1qyebPRo3mw7LGQHcVINkHYVeVf5TVKo72MPjEmDjGKA7ZZkx60UDEO47NmS
	F2Vwi8jOHuVH11jLggNWGfqN+QGyyrsLEHtdF6JvfEKuUr6wPOvSP7MXzFGmVeAYtmUKPAg0nfvQ5
	4VFkvJnJXH3K+q41ZfyRcts6+6R27XG0J+YRYY2humVkBjNkNeo/ybNTEXAqck/VEkB1EszdiT9YX
	larjWW0cSHxuHPe8ymwKPA3fjIJpSS6bI1Rtmf93zl/QnsXvMRWdJF7dv3cQwgvnkOI4e8t/tlm1y
	6g7a/OgtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4QRi-0008SA-GE; Sun, 01 Sep 2019 14:03:10 +0000
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4QRf-0008Ri-HP
 for linux-nvme@lists.infradead.org; Sun, 01 Sep 2019 14:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRMnunHnq/u332YoJOa6HvGSVWafzkGqeB++g6lkh5ahBwL2NkWY9I1jhOGg52AfsnaIVZcecwplID+FPPCPTI0eyLKp7cK69ajyKTH2VrbyPI/DKtveDfOAyFiQ/mpmkA7swy7pSchKjBebzSc1ENeOi65yiA1/HDgB5NMxgtXZ07wuzt2/JDyrLu0b9Qdw2JWOWW8ZtwNeBk16CHR3bbMPnL34MG/61j8KPm2hfVt+qoweGBZmsYRZ5YrMvbvANrYQcHFEJKAg536clWW6KJ2XgKuZt2SA7D5sTZM/9CeiWPbAF0a4s1pPFWsOQe4vqrWyBu/PXAFlwjNv76d8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnscSHxe+s/t8H9EhPPqyqGzPC5MldqG03UicudyW+w=;
 b=Y+WWF95khulRH+Ccgw/wMRHfPkV1B2/MvE+LMrr+y/ddY4FbVfEa4iEjRv0gcfT12GfG/5OOkkTd1u5Q4Lhqvktr1t2cp3hw4FifXWveJsYTsZjqalIhY2lUjEOAwtJOdWoNoaySVKcxT5zzu9ZEin+Goxb2A8vN1DR6QTPcyxBciHSckzUzX1yFW+b45djtGEOKX12x2yv13hSXDj9zqcB/bCGa57pi9mE0FPky3VeULrf+yn0oi+8U+EjP8QdqD6LofZpyye4A7RQd/EsHec87fHq67p7QE3r9amkWZhtoWWZRhG3nkpJbpjMtz++wpJaxLycojuzPQASeAwuMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnscSHxe+s/t8H9EhPPqyqGzPC5MldqG03UicudyW+w=;
 b=IJXMQ9Qe7hBNHMqNK++ejIN+fDfuqTRQNP7z0Ua6n42sMKDJfAXS9CuhMCF+9v2qx7Lsm5Z4c6iUCtZ3B29RKuMLHsJzjrVi2ekLwPmJzGwZ9HmmMXzIFJT53DXY6vLpC+1WNGhM6yGkAImmKGgc6fxgU0YA4XuqjzaDVwA/QD4=
Received: from DB6PR0501CA0043.eurprd05.prod.outlook.com (2603:10a6:4:67::29)
 by AM5PR0502MB2916.eurprd05.prod.outlook.com (2603:10a6:203:a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.20; Sun, 1 Sep
 2019 14:03:04 +0000
Received: from DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by DB6PR0501CA0043.outlook.office365.com
 (2603:10a6:4:67::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.18 via Frontend
 Transport; Sun, 1 Sep 2019 14:03:03 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT058.mail.protection.outlook.com (10.152.20.255) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 14:03:03 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 1 Sep 2019 17:03:01
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 1 Sep 2019 17:03:01 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 1 Sep 2019 17:03:00
 +0300
From: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH] nvme-core: cleanup work queue flags
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 <linux-nvme@lists.infradead.org>
References: <20190831000235.7400-1-chaitanya.kulkarni@wdc.com>
Message-ID: <f0ba1a23-ac8c-504a-eedf-718c452e578e@mellanox.com>
Date: Sun, 1 Sep 2019 17:03:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190831000235.7400-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(199004)(189003)(110136005)(6246003)(229853002)(53936002)(3846002)(2906002)(36756003)(6116002)(478600001)(230700001)(53546011)(26005)(76176011)(305945005)(336012)(16526019)(186003)(70586007)(86362001)(7736002)(70206006)(23676004)(5660300002)(2486003)(31696002)(16576012)(356004)(50466002)(11346002)(2616005)(446003)(476003)(126002)(486006)(47776003)(65806001)(65956001)(8676002)(14444005)(81166006)(8936002)(106002)(81156014)(31686004)(316002)(58126008)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0502MB2916; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a83521a-2eea-4fc6-0c3e-08d72ee51b51
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM5PR0502MB2916; 
X-MS-TrafficTypeDiagnostic: AM5PR0502MB2916:
X-Microsoft-Antispam-PRVS: <AM5PR0502MB291607DE371ED37205CF291CB6BF0@AM5PR0502MB2916.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-Forefront-PRVS: 0147E151B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: phKp8SE8d3gujWTF2fIJTSqmNy7eGpy4gGjx2Gl0LmJHWBYXClH5f7RHCsO99PCROls3rMUjXak2LBfBpeHK/S33rIEUH/jhPPr7dLuDJ7SFOUIkc8ST4sGWHrQDjIC6oNgw7URN7HLVV1b8qm4fBSvDuJ+oXXuQjfPO54+92DbR1EZBzxJWoN1jeR4R1H91u7mWfo3dOtwtn9ltcZDvkx0veZNIwvwKE8cVq/JAi1Q2S1wDjRC11WixgLPEwddtnXbU86FLl9bd4iu3Lk6aw+KaM5fJieL4/K/X72Mtt793+1CqRPYahqdKWwiIx1PU0xyWnEwPPN0revw9xxt086PuonC9mJgOiW7Erd/7t1HN0yQw9T5A4wY6/VKEhvyZ6xOeoPMlL0qNny8P5yEN5tXyZRAsd6CNbTw3eVhvgd4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2019 14:03:03.4007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a83521a-2eea-4fc6-0c3e-08d72ee51b51
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB2916
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190901_070307_582616_93A0356D 
X-CRM114-Status: GOOD (  15.49  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 8/31/2019 3:02 AM, Chaitanya Kulkarni wrote:
> Over the period of time there are three workqueues been added to the
> nvme-core which all share same flags :-
>
> nvme-wq :-
> commit 9a6327d2f25b ("nvme: Move transports to use nvme-core workqueue")
>
> nvme-reset-wq :-
> nvme-delete-wq :-
> commit b227c59b9b5b
> ("nvme: host delete_work and reset_work on separate workqueues")

I don't think we need the first half of commit message.


> This is a pure cleanup patch which defines a new macro for common
> workqueue flags used to initialize for nvme-wq, nvme-reset-wq,
> nvme-delete-wq and avoids the repetition of the flags in
> nvme_core_init().
>
> Signed-off-by: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/host/core.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0b1ff8d54e48..555d9efa76cd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -61,6 +61,7 @@ static bool streams;
>   module_param(streams, bool, 0644);
>   MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
>   
> +#define NVME_WQ_FLAGS (WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS)
>   /*
>    * nvme_wq - hosts nvme related works that are not reset or delete
>    * nvme_reset_wq - hosts nvme reset works
> @@ -4055,18 +4056,15 @@ static int __init nvme_core_init(void)
>   
>   	_nvme_check_size();
>   
> -	nvme_wq = alloc_workqueue("nvme-wq",
> -			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
> +	nvme_wq = alloc_workqueue("nvme-wq", NVME_WQ_FLAGS, 0);
>   	if (!nvme_wq)
>   		goto out;
>   
> -	nvme_reset_wq = alloc_workqueue("nvme-reset-wq",
> -			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
> +	nvme_reset_wq = alloc_workqueue("nvme-reset-wq", NVME_WQ_FLAGS, 0);
>   	if (!nvme_reset_wq)
>   		goto destroy_wq;
>   
> -	nvme_delete_wq = alloc_workqueue("nvme-delete-wq",
> -			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
> +	nvme_delete_wq = alloc_workqueue("nvme-delete-wq", NVME_WQ_FLAGS, 0);
>   	if (!nvme_delete_wq)
>   		goto destroy_reset_wq;
>   


Otherwise Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
