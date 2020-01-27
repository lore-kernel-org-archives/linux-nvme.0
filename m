Return-Path: <SRS0=UxdA=3Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D94C33CB7
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 11:25:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD762214AF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 11:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7VbctuG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ra863kiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD762214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fQQhifEQIqlbLAD/RfpgFe0KGRtkmY7CdnX4R54VQt8=; b=G7VbctuGNOn/GJsOOPWHVe2X3
	ZE9L0GOAEKEdBKE9BCbQZrmxGZKugvyILTpjuppuHRp3wV8FM4Mu7qXnAP8KRQjnzySfjuxze5pxo
	5HJ93uGpqVCqj8kCLmHIyj2XMatpBrqwgupKX66eVqCDf4xN62GI6G+MvuJ1hyXjE/XEVeZKNe4Za
	+L8Ep4JqOGwCIcnSxrgNr0tdOHKtVBGzfMHwxosVtp1Dfeo76bhOFTRx/QPb0H1p3g+cp48bCltwR
	71r7BbcDXD3e4oenkj8WcBALP98AzbYLnKbU1jfzkLUYrMdKk7nzsYW7nSOSWz9HWqlTZyWgvthLV
	lRo3SfWlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iw2WA-0007He-Po; Mon, 27 Jan 2020 11:25:22 +0000
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iw2W7-0007G3-Vm
 for linux-nvme@lists.infradead.org; Mon, 27 Jan 2020 11:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfyBYShirFJZBxPamu9F2zVxk1uU/rtRQ71ghiq5WCcqN+Q2+9aK3xZOGjta1Z4cY9uGKHph4Z8eM7h179/dAloHppvZblcmtrw2yghszjIibjn9sfdv99fS9zbyoAud6m/+0HEhn/rb8LFkgECjYfuIDRG1Oin5pwmq8c4CZuI2PT1Re3qVUp51cTQEqQLAzTNxq7wYt9O3Lp6BPHd58BxTjlaysFaumChKmXh0vKYyPYwbSB/d5NzP36na+A5xKV6m0imnm4+WMrbTRgFKCG5813njFtcMwI64IS6WlS16qWvuCdCgtZdm2A33P3GU2OXCEuQXGf933AZ1btSzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xXi8Q5jqY6q2IIXSDIo25iosP9oAt4gjUCQqdPgUb0=;
 b=e47RhLf7dg/aiW5hdrpR+AtTogwT2gQ+XX5Mt6mVE+Y3/ceo4FuXz8cN18Nv/sRdz7CZlTWQbTe0wki1jJWMsaRCuzrnvwkYYWDW07P7QVlVF8BWTuLX0NTPwug7LNkdqFx5XDX93AoaVhLVFZX9XX3+kX7Zec4XWhIs5Xoazo3Fz9ATbMbjbFtLIe/qfJAZFhq7efxc9PWSEBJuzQfUyr/nW3afaaasg7wbvBCbjnNyP9dMcJY9gnrg6+vBq0qgfMQ86SSZ6ghxL5lPiEPVKAh4ioD8hHnxgfOExRbDxjnn16FO6rb5BTzM/gSglLLD4ZEs5cVeqHSmB0aY5IB4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xXi8Q5jqY6q2IIXSDIo25iosP9oAt4gjUCQqdPgUb0=;
 b=Ra863kiKfu4Z8XV6z6I/IzseKPZjb2tQ4rBLW0PQwc2r/CdXT7koHX+AU88UNPWpAKgP//iPXz99VzQtu+bH4YxGGIt74LBIrHRzmP69hFcOL/zXawiIK4anCWS00hRho7gVUmoWUqV5GcISsbUYpMTWB3jzvJu3ccxARm0Rfco=
Received: from AM0PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:208:be::48)
 by AM6PR05MB5409.eurprd05.prod.outlook.com (2603:10a6:20b:37::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Mon, 27 Jan
 2020 11:25:14 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM0PR05CA0071.outlook.office365.com
 (2603:10a6:208:be::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Mon, 27 Jan 2020 11:25:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2665.18 via Frontend Transport; Mon, 27 Jan 2020 11:25:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 27 Jan 2020 13:25:13
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 27 Jan 2020 13:25:13 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 27 Jan 2020 13:25:12
 +0200
Subject: Re: [PATCH v2] nvmet: fix dsm failure when payload does not match sgl
 descriptor
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200127072328.7653-1-sagi@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <83402d55-c4c4-63c9-18be-9641fb1309fa@mellanox.com>
Date: Mon, 27 Jan 2020 13:25:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127072328.7653-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(70586007)(4326008)(5660300002)(70206006)(186003)(36756003)(16526019)(8676002)(86362001)(81156014)(81166006)(8936002)(336012)(53546011)(26005)(478600001)(2906002)(110136005)(31696002)(4744005)(356004)(6666004)(36906005)(54906003)(316002)(2616005)(16576012)(31686004)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5409; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b7c4800-cb13-4b05-d102-08d7a31b9450
X-MS-TrafficTypeDiagnostic: AM6PR05MB5409:
X-Microsoft-Antispam-PRVS: <AM6PR05MB54092F23F73FF46073506330B60B0@AM6PR05MB5409.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-Forefront-PRVS: 02951C14DC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWZwDc2OBf/qb5QqzKme+bJtOoarAUoIXR0rThB/70WxnlPaEkNJL+e4tiBCBOwvNhNk69+b0gRSkAzTkrpt9WTkPPZjLz8vbVvbSOOOc3lSuVIBFoUbK0lmxYMzoaFpP8xOWO4wHQ4sNR7Q8b8VdikM4cj9NmeVXl0jYOljM8MU3QBayKQadtmN4+IIIVADJOIXfypYELASQFE9UYSaG1ScV/3wzFJXJ1oruGIr57GbIGAYeZ770O/hNiB4j1LliW+YbEL/8NtdmV6uS4uSuGBHRLwrAKNLaDD2G+F5H33L/IYcgyX4v59Lh/Gp/jbrDf/SazPMVOCTn5FPLrCLOBaiuT9mIxDgQNGuUzgac4n6biETSNdU0DambqqcWdSUpmUYCVfUKF8I0nP5ddWUo/xslqJ93Jd+S6UD1E2Djr48o1aXlQlqF0rVIENFGU8MogMrRS/lbRCLgvXhIFy8msi9+zakLu/k9sbgIt58Jt5o4vnnoC5QL1exhxfgz4Am
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 11:25:14.0780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7c4800-cb13-4b05-d102-08d7a31b9450
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5409
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200127_032520_097008_B6F9D791 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/27/2020 9:23 AM, Sagi Grimberg wrote:
> The host is allowed to pass the controller an sgl describing a buffer
> that is larger than the dsm payload itself, allow it when executing
> dsm.
>
> Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - remove redundant symbol export
>
> drivers/nvme/target/core.c        | 11 +++++++++++
>   drivers/nvme/target/io-cmd-bdev.c |  2 +-
>   drivers/nvme/target/io-cmd-file.c |  2 +-
>   drivers/nvme/target/nvmet.h       |  1 +
>   4 files changed, 14 insertions(+), 2 deletions(-)


Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
