Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8515CD129A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HsfiniPTnQsteDUFveq8OrDLT13JLtoJig0rBNRnlVc=; b=pBQ90O0jeKMqnHs/5r4LxdKubl
	JUYY+AEO3if2TXXAM09OVxvH9UOSOM7XSrnc+6NOXdM9uXXi3gtnv5rV6279BDjeAtTw5hB3j+jyE
	wwf6wFtwKcldTHs3znyW+6Le7co1DVk5uYrw6Eu+WlIH0zQ7S/eIekhCB/6HHLiL5Q6P+5Tbk81bB
	+6toOoKXGiu0xenQ1ZC1GhAm15XKyVC3IpC2cQBWdSKuHQ9XJfU8dgx1YXjzAlMT4CGaDiDBEpiMR
	bd83vKbtmpsZd5cj/mCsTzxO9WjNHCZGYxA7Ji5/xSicYGCI9Yl/NxcBKz1oAmhNJeIeremPLZ1QU
	7orLDsLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsMLp-00000002eTs-1ukR;
	Thu, 04 Apr 2024 12:37:53 +0000
Received: from mail-bn8nam11on20701.outbound.protection.outlook.com ([2a01:111:f403:2414::701] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsMLl-00000002ePd-1j7g
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 12:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0+hf5b6DxYrEzRdfFF2dfYarEFYMqNKjnPufbrGlu9rPtkpSXkPosCFFSvDyZWX4Qykb1PMRkAwYdOSJh8MxtLMPHE39YhZY43SLfvqQZ0YNvs+U4XtiPSbfOkTfv1zsZlDtd2Au6YfOIi1K3x+r29X3+ke1/FI4b84Vro8bLQJOmFCUShpIjMcIaph2114TSChF/ctIaL8Y8BpW9O4p0TI94L/aFOH8g2ICQg6LrWa/1/zopFdxllkO7ABl0rbbbqkDGETWPCvC88eqBUu3O1pg2/X8pJ7U1oLkkPQmsWISra/2B6eXqV8SL8JEJWQgRnvulz8UTkW10YEmyP6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsfiniPTnQsteDUFveq8OrDLT13JLtoJig0rBNRnlVc=;
 b=oTzRoSiKlWerGdkouib24fyHi1DtjBAqI/9cM8KCn+3NIUvQOptUzV543dpVN5bl7BXIJQZ0nI9hp4KpF2/d8OvM8Mxu212h6vC/2loEjfMhVW6GFO3LqCOVuiUZCkZ9Kidd9e1ri01hqNmTlrvrLGnrkPm5KXLQ4rT2vDY+dUn2tpZZIKHL65UDjM9//JH0WqPQ4Uv8OyNIsp7/XCMLaAgVv3EiyI5QX1CgLaeTxplMXcLCuzOGVThDrUi9t/p1biRA2z1y0PuosRYnYSiBVUU9prfe/CFZmvlBSVE0XGgRhEfx2MNfNPJWcQT10hwUn+YRUzKv8vuCZLTLf0gc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsfiniPTnQsteDUFveq8OrDLT13JLtoJig0rBNRnlVc=;
 b=c1IDraHx6lNM4J53x6oxaLp/3JVHiaSvJeA2g5u0U2xZITlAVrjcxWQsryAt6VP/+SzTTdxF+Zm9aBbJ+IO1xC9nCsW0cc9QdAM7/Fv9BzQeulCHZAVjRM5NBB2fvwTfF7zgMum9hp5OP30BIE9X6TLXnXV/MfRUFbmkw8/yLiOllH4k8e/H/A1bcEPwSfWiBeYHMY0PZOeWxnbaMyip6RXhZbdgWN3JZsM2BFg3sswnO9kT+spohVHhDNo0Qku46v/Z240JSzgnG9j7GMIkDZyhgYBzjuloOEDr9lI3Jz+7+PNa1ayXiRvnb62SiMjxRqwPLb4Mi9G7TFjXMNY2DQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:37:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:37:41 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Thu,  4 Apr 2024 12:37:00 +0000
Message-Id: <20240404123717.11857-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0aN0zPei1Xflf2CsBPgoXx/oCFEDxuUcK7uoSFAJkFvLwT30ENs2J73gJZGG/Qe3xj8/z1ASh0wUj1LjboSN8pjCv6OgH5hyeH1hY+a//ieWEoQelaaT/kODdObeaftK8aWH1JriUTj+Knax8pc/ZhXUc0ZEKvT+aVvjde9kAB9VtMYyHVlRVf1LsCKekBmVdf/Eb9JPuKmPMrTyoOSLxWGLKi//VLPHM4+GEUuJSJxySFljYn4FKAFapKUq10XKDQS0ghJ3+vdpW84w3/NUey64F3XZ7nJo8VX86xgWBdyBW6/+K1O+/0SHFzTaP7vGd0jI0xmHVLl50HRt/9NwB+vRxeHZuI2gzBPYmye/Q0cEz/G1ZmEAe4kgGpZml3X5dOiedCSbE7RLox37Bf19xP0RaxzFGisgVVFO9s+AdiFTXw8kQzGG9goATy1SvbdifMX21JHHPp9frPdrQSYfJvR87eYG/amlf1eJQIOogUdsmy6sD6c7BSHavxMP4TyWjqArqMMDJ1efbMXrrU4WN5G5nU1xMvOYyykScuJ3tkC/ycyk7bxuI9xKNylC7HWfvRbToDUGkOXKuTG8lQIkgT5lNDslPvyF54BicKo8rs2Bnhs8X/mfrc6x4KERN87ydI9FmDhrymwI+lPrKbQMv7+YTDrk3/qnRvlsxVf+jE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ssNHO8s2F68wRZoGzPzoZOhtd3ZPk0VbG48AYXMBN0m90GykvujT3+YM5ni2?=
 =?us-ascii?Q?D7iH057cgzl6+1ZVivsZyx8XbGMe+q5npCZusQFvv1KLNC9GzTj41CyuITGF?=
 =?us-ascii?Q?Alvw2DFn2vRUYEnbNctnY1IBznaVzyCLbE6zTd556uOUBptVMvXnsHNdmRxu?=
 =?us-ascii?Q?hUXJMWbBJHzJ46rlYv8baWrW8Bm1LyvjMhBBPVPnQknWltvYjz+V6yChxOVb?=
 =?us-ascii?Q?/+9yVZl7w9qfAn6IkV7SasLIgmFAlWukbkg21RtU70uQPmNv6+CfS76OGQGx?=
 =?us-ascii?Q?0L9WQp1HHM64t/f7gaZtX/f9JMXcjrYFnswiq7adgv2/U35DcuUPdz9ZRZhE?=
 =?us-ascii?Q?FOrQ5+CGULTqKTzIhbkrKYXiqOo3QVHMe+DuKv6oZSPcA7VSFso6lABYcgsm?=
 =?us-ascii?Q?bNBOyQj+STitOdUfSAEMOle3S+kbhPVkFrq3IK9mjNVsxZ2aDP0oojVQpVJ2?=
 =?us-ascii?Q?QXTAWXVjrluYdUsCOZvc/T6Ym94OZ3OMveiYF82WoDfyieKi0KBTd15gHKLl?=
 =?us-ascii?Q?5jjM2oEjsTRRU8wEz+zWM7jzb66QF84UcokFMJizL7DEHqYa0MH02FsSvd3a?=
 =?us-ascii?Q?qRs4AMntCEw/zw/KgbqMEu3GNnJvagbfgSjhmI0gR1AQQxMRYss2QUCDJviM?=
 =?us-ascii?Q?Gb1iIN17GvexAXU0J6yxOCo/Qhhc8k7XVvRYZDlDwUhTOExyAsiHJOuNPE/9?=
 =?us-ascii?Q?CbQ4EjajpFba7LqNSPsGAr3tLNNDuoW8tVZgpxy1aHRp9oTwKv8+lbYYe2eE?=
 =?us-ascii?Q?2FW9s4Fw10voEd3DmXrXIhWQajU7OoluIpIzoMvrv0nuGlsDbyk/+KyVBXcz?=
 =?us-ascii?Q?8bpWV0VQMEyp+q2aZoGTGrBzenBn57uDzww6SNA7PKDAxkQW8lilhoC2a1Nj?=
 =?us-ascii?Q?R56GbuWOpFiL/0ok9Lo/3X6OP5veRZBPgL0H2c9h2CSK7gBgiufZatQCBCDz?=
 =?us-ascii?Q?PVVb2r97fTpqIa3UUQwe0x6aJ7ere6Td1laQYKGv1YdoolHvr++yrI4nEleL?=
 =?us-ascii?Q?AEThttrHOqIMcEKMqkSL+ehJFccAFA5FWVCysKv1azHWWkup6lLjQ2X2ChYb?=
 =?us-ascii?Q?vOYOg8D9Spal9Lz6+rbLtFwkIo6jQdHwHvXW384RrNSFfPtMSVWx7Q3zJUKD?=
 =?us-ascii?Q?Le3TeQoxRYnsXzZwb1T9xLeP+SeY6dgD99PBeQj9NCxKMNlVn5wAlMDIWQ2T?=
 =?us-ascii?Q?xKUl6+BZ1eK1fw55xaM3B7v5y3lcsRINmpZVFGok4TLpCoLl+Hya05wJ2a/1?=
 =?us-ascii?Q?Fm2IlW7z/ePY4vk1VZDzc5gJJwCEv3AqG9+9Of6Md0ylLBdUuHb20TghBEw0?=
 =?us-ascii?Q?ntZ89lUlkxcWWb7gz509LuIUSZg1Ah1QlV29OkaXdgG0IOY0ghIg04q9BDfX?=
 =?us-ascii?Q?KWezFFgV/S8E178oEMkLD2ereZukneJZ/6RptA34hSRsZcXOrKGxj/DgrYqr?=
 =?us-ascii?Q?OP/StnXkkjrfHLkf+FWiNGvyiwoG9lcYt/5OIuv5LgH2SRe0IrPXaTp6oQj/?=
 =?us-ascii?Q?ztXRhkiBxNWexYcxnQKL4kVbfpeESRuyQJW6eciI+UofDucS2ruwQEaYMPUg?=
 =?us-ascii?Q?bkdpx2CdLVixsVCaFvX5SILdYHXBI8hjbQhtuGIZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca9d11d-e67f-416e-9526-08dc54a404b5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:37:41.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAYHnj0+lTUBEmrLckVBWHzqQog0KZie8KRtIb4emfU53jUzGAL57jjGQ+yt3Lgl7h/KzwNqwpn1VzUVaidFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_053749_483358_8915CF4B 
X-CRM114-Status: GOOD (  10.55  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..a85125485174 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (iter_to != from + progress)
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


