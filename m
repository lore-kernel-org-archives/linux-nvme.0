Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E35C35DF5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 09:50:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703E520714
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 09:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gSLGDRRj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZeZ9UsI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703E520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nh8G6NXetUCFEDsy70x98qJbSx2YC/wnVsONTD5ott8=; b=gSLGDRRjJglCp/52qvZIsl90A
	LD3IxwucY3QGVTaCXASo089pIREQsoBjaj9ad8xnfSv/AC82g1QCqXO5w7aUY50FCNDfxwA1tmCsQ
	83EwmfYVoq4cmW3Pf9iIVUp5jxwGf6BpoqP+zCy94eqNnSlBgV2THKuzkqQpGvu1HxKtK0h7Py472
	sZODXNuJIDqBie5/n1NEZzDRlOyg5tALo+Oql5kB4zxCRXvcvv9ItZxdJmQBP9CpWL+Rav0No+unM
	6ah/9cS7n2BL3qj9Fv58ElGy3qlecgwbsNSQ3xqU1erGzBm+4hx+XSlsIsgAN/IljHHqHxLvIj3wV
	ztSt2q6vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6Wqj-0003Rv-9Y; Tue, 25 Feb 2020 09:49:57 +0000
Received: from mail-am6eur05on2067.outbound.protection.outlook.com
 ([40.107.22.67] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Wqd-0003RW-MW
 for linux-nvme@lists.infradead.org; Tue, 25 Feb 2020 09:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF3j5/2UczLv3yIJWmwspBEYdIOxy+wzZXiTYkln17c9BSu5uVx+JHXijXlU042J1fQTFjcPW3z0BHCkRRtaf80GB71b+UvjIIxzQ5NjE/9rZAdlu36kU+U0K07fLlYiMvQuD+n4gDAkHWEddqchtTbO9nZbilmTjA2zndyYdBMig/2q2NTYnNOOJyuT33ECcYl4iqQLZRfrafW0E7EQNu2B1LrGBn7L7OFnGjaylPS6kTr3hafxGGfnvVdSK/Pv1bAupzBPqNYiaUagCIq/rOvcOl7MRDE7ifpOZuwdnmwXlONwr6g6nI/C72pnmlHRdAzwt1mxJOpon/1F/K+NSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2e4Cns8nc1vGrlhADpXb3wbeM8eyYOK4vFYaqqCkRI=;
 b=M1TuBC7wm9K7lYhRBLIm35TZOKWlI+HRjTnoQIAPToC2tNF8Hb1+S3xngrY913XEtBFDJsJCcPZCItPSMV2qmrega8X/dcsh5enaRnTHj0ZM41E7R6t/50+xf5iCVNKJyHE6NLWN1fd12WQkXIwCcrF50bin6sbfIKSD+qpnDvahQi6i/NXeUdPSnvWX5HPiE+2EUhAbsC3MNOJGsQPAwAGfwLpusKYWpDi6aI9Y3UpN/ZzjCSLSDkzlezooRKE3w72vQaMYNv613ycon3UhQNHSKihJ8jtaqGycXu+aDeIGCP+07Z1YG5rT2FImfd9VokAXuHFX2j1bzMRAuDLjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2e4Cns8nc1vGrlhADpXb3wbeM8eyYOK4vFYaqqCkRI=;
 b=ZeZ9UsI6xLmLNH29t+vWEvubO9qpBf9A7gtGSEOSW/t7Xksw11jxKUnfKWiuXauIYZ4Ii9MwZ1s6E1wDfWuEbeGCNjWIOjWzoYkNkScBGW8NNU5z9lzveKfWIp2/3kmWufpSzZJ4ao17V6a16/oAheO2g6RIwBXE/xd+A1SOWpY=
Received: from VI1PR0502CA0004.eurprd05.prod.outlook.com (2603:10a6:803:1::17)
 by DB7PR05MB4841.eurprd05.prod.outlook.com (2603:10a6:10:1e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 09:49:47 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR0502CA0004.outlook.office365.com
 (2603:10a6:803:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 09:49:47 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2750.17 via Frontend Transport; Tue, 25 Feb 2020 09:49:47 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 25 Feb 2020 11:49:46
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 25 Feb 2020 11:49:46 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 25 Feb 2020 11:49:44
 +0200
Subject: Re: [RFC 3/6] nvme: Introduce max_meta_segments ctrl and ops attribute
To: James Smart <jsmart2021@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
 <20200224184859.20995-4-jsmart2021@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <7e85bcc2-cba8-4795-5c15-f7a586d339ac@mellanox.com>
Date: Tue, 25 Feb 2020 11:49:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224184859.20995-4-jsmart2021@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(189003)(199004)(356004)(6666004)(5660300002)(36906005)(2616005)(81156014)(4326008)(26005)(186003)(36756003)(31696002)(336012)(2906002)(86362001)(53546011)(70586007)(110136005)(8676002)(54906003)(70206006)(16526019)(81166006)(31686004)(8936002)(498600001)(16576012)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR05MB4841; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ff0ff8-7f10-4f42-f878-08d7b9d80cb5
X-MS-TrafficTypeDiagnostic: DB7PR05MB4841:
X-Microsoft-Antispam-PRVS: <DB7PR05MB4841036F2FE6CEBBB61EDE31B6ED0@DB7PR05MB4841.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPB3cRTJvATbx4ll7rAqsYakySKPG+cDjw6qWXplXewJJdRt1RzpfeUL7g1VAzQ/SXNovq90x34/NY0+UdBKOm6hAAKdntjFdKxK9QPBN2Um6hUE5/KfB51F4ZAJ2KKJLn0JTYssKGTtkcJm1jEtvnxh5YkgVTT7GVYAL4TNYmcwueCP+u4uMJNHOSZEeevaWUbhBvey/rLZoibicRuEaQTFvoomHtHPEkrhx8Ob79byMaIOtCV2Nks/6TVs9oO+8oAvnwVgD6PIAnZ78+btk7nkfLA4fMfxOXzZ5IwWp8dhHyo8tCxsf5Zk8McMtdymfUmwjJBNm3pkylT8SilGxqwiQb2mlYmmCue2M7iHUgKp1bCIHL7CHYPb/lYXGQXr9vERYoluZEPo+Ylq5kESnRnkGY1gtLpNzWTELKTPaeC4b5irGJe+cPD39MTlaY0T8N9EuJSnUrCEcYxvq8Ir2AM5JG2moggZCdUFB+3l+FlCTYH6zRbJwNlPxCeoX/ic
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:49:47.1269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ff0ff8-7f10-4f42-f878-08d7b9d80cb5
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4841
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_014951_805451_1F226290 
X-CRM114-Status: GOOD (  23.65  )
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
Cc: Israel Rukshin <israelr@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/24/2020 8:48 PM, James Smart wrote:
> This patch was originally posted by Max Gurtovoy <maxg@mellanox.com>
>
> This patch doesn't change any logic, and is needed as a preparation
> for adding PI support for fabrics drivers.
>
> This patch parameterizes the number of sgl segments supported for
> a separate metadata buffer.
>
> The parameter is added to the nvme_ctrl_ops struct and the nvme_ctrl_ops
> struct. nvme_init_ctrl() was modified to initialize the controller
> value from the ops value. It was done in this manner such that if the
> transport supports a singular/unchanged value, it can be set in the ops
> struct and no other code is necessary. However, if the transport must
> set the value on a per-controller basis, likely due to differents in the
> host transport hardware, it can directly modify the field in the ctrl
> struct.

I don't think we need to add a ops for that and override it per ctrl if 
needed later on.

And if a new op is preferred, please add a callback (see bellow).

Btw,

This was already reviewed by Sagi and Marting so it would be nice to 
leave it as-is (or maybe only rename it to max_metadata_segments).


> CC: Max Gurtovoy <maxg@mellanox.com>
> CC: Israel Rukshin <israelr@mellanox.com>
> CC: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
>
> ---
> Modifications to Max's patch:
>   Rename max_integrity_segments to max_meta_segments.
>   Add parameter to ops struct and initialize ctrl field in nvme_init_ctrl.
> ---
>   drivers/nvme/host/core.c | 12 ++++++++----
>   drivers/nvme/host/nvme.h |  3 +++
>   drivers/nvme/host/pci.c  |  3 +++
>   3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4f08c637ec2e..8421eafa81c6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1624,7 +1624,8 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   }
>   
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
> +static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> +				u32 max_meta_segments)
>   {
>   	struct blk_integrity integrity;
>   
> @@ -1647,10 +1648,11 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
>   	}
>   	integrity.tuple_size = ms;
>   	blk_integrity_register(disk, &integrity);
> -	blk_queue_max_integrity_segments(disk->queue, 1);
> +	blk_queue_max_integrity_segments(disk->queue, max_meta_segments);
>   }
>   #else
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
> +static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> +				u32 max_meta_segments)
>   {
>   }
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
> @@ -1805,7 +1807,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   
>   	if (ns->ms && !ns->ext &&
>   	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
> -		nvme_init_integrity(disk, ns->ms, ns->pi_type);
> +		nvme_init_integrity(disk, ns->ms, ns->pi_type,
> +				    ns->ctrl->max_meta_segments);
>   	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
>   	    ns->lba_shift > PAGE_SHIFT)
>   		capacity = 0;
> @@ -4058,6 +4061,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	init_rwsem(&ctrl->namespaces_rwsem);
>   	ctrl->dev = dev;
>   	ctrl->ops = ops;
> +	ctrl->max_meta_segments = ops->max_meta_segments;
>   	ctrl->quirks = quirks;
>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 0725cc7c7a7a..4c6b6fc18560 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -262,6 +262,8 @@ struct nvme_ctrl {
>   	struct work_struct fw_act_work;
>   	unsigned long events;
>   
> +	u32 max_meta_segments;
> +
>   #ifdef CONFIG_NVME_MULTIPATH
>   	/* asymmetric namespace access: */
>   	u8 anacap;
> @@ -414,6 +416,7 @@ struct nvme_ctrl_ops {
>   	void (*submit_async_event)(struct nvme_ctrl *ctrl);
>   	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>   	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> +	u32 max_meta_segments;

This shouldn't be hard-coded value.

please add a callback:

u32 (*get_max_meta_segments)(struct nvme_ctrl *ctrl);


>   };
>   
>   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index da392b50f73e..7cbd2fbda743 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2690,6 +2690,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
>   	.free_ctrl		= nvme_pci_free_ctrl,
>   	.submit_async_event	= nvme_pci_submit_async_event,
>   	.get_address		= nvme_pci_get_address,
> +	/* PCI supports metadata via single segment separate buffer only */
> +	.max_meta_segments	= 1,
> +
>   };
>   
>   static int nvme_dev_map(struct nvme_dev *dev)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
