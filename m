Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E1C3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 14:13:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2068D22CED
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 14:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWCHJ05o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="moBvMkqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2068D22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R6Vdr+8c7kF9pq7mOQzBk7ZVj4vM2E4E6EuV8MRL9q8=; b=kWCHJ05o40IxuPMpAKbuR/72f
	OjH7Uh964GEzFLPNcggX2L/tquqF7RC7ZUBv49NT1J3WSzpSVGw28EGZXtXV9u8Cnn10W9adpfQwM
	JrNqwrZxKhuz2TdBCQKW5YY4XoX9lVBGNMdN85o0DnkOaQRB4bTTz8xQ/uf5f4+H7GracPPUElEzi
	F6bLyaBzto/DXKKGDA9BNp+oK3Cg4Ry2KLIT9Y5iiO0puDXOaFRVCcX59VZ+wOWr+8y3snNb/Fayr
	/6ND/pnaxSwXjXjKDS2OtigQK+McvSyQu+GHkWoaBoQr01WbS8I5A++GL/Nl0fo866qa5IxiflIRZ
	FsSSlmQ9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5W2Y-0005cQ-59; Wed, 04 Sep 2019 14:13:42 +0000
Received: from mail-eopbgr90053.outbound.protection.outlook.com ([40.107.9.53]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Vxc-0006oS-OO
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 14:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm/X2EeSHTRYjU9YB39E9PaLkLDF5JV2TSm2jS4V0P9h1GWDQamm4/L1MErfsfJ+AI7FHi0BXiqwwNHc6dPab64KSTSIIKdIFRoAJBfHeTag71IZFJho0CLgEAH527Nl89mp3vX7jrVPmjAJ8V0BPc1w4pitouE7XVedpAdrAkJb+OvnWzDnbetpmDP1i13sMQfw63f86lrIFKtVluJkxxft7SJeLwN+R3F6irQK1E42+ykn5v9HAMw4t58K5QCBrq8r64puMznZvcrzk3MrfjiXp1W9BbR7zH6K3d1PLwkEjS2/HSB+n/K1OudOjDSzy/shyKbq6a6XHd4h+SnN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoBKU2CpUfEHsSgLMrjCO4y8c+tSbaJJ7itqsbCvadI=;
 b=d8+sbvtcehpQZKcPxQIO5ERbDG6MCr7mnrDHV/PdbeCT8S5D4tbdpl0CLhEg+Wj2qTTkSJtDPzmr9+JGwtCkRU+4RAGiR4qGfbiRwZDO2GG7o3wQ0Bk0L2K9qxGEvEApQ3EsqsTHdvEJhZ3zkrbFDWiyXgYSh/rwn7w+vyo5Ii71NyTkb/3WHNBsKuo/d3AYyAlrTgRxrnc2YbEKWlLm1QH9dWGHjOJBGNg1pCd5DTIfyYEWwD8HR2tRCKFMbyHuHgXvYyl4QQOcTBwpQE75WMYB4MxxYnbAktVIPDpBzUJVasJ56uzgUQhmBJIS3vHzw28gHT4wbo+jBHqyGg5VwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoBKU2CpUfEHsSgLMrjCO4y8c+tSbaJJ7itqsbCvadI=;
 b=moBvMkqdnlsgr5iKGjTMxJ/Lj/n7Zj8trSKPdoCqgDKTYBwggHR7kFHAH/IVV+Ky4b8H68It3HKS06a/mQlaHri0p8O0ZDQ0PP5zjNvMDollqkbTikAwZobk4l4StYMlOC9RdUZ8Oj78KkrinntVu0antsRK0+7/C337vtAtUAQ=
Received: from HE1PR0501CA0011.eurprd05.prod.outlook.com (2603:10a6:3:1a::21)
 by PR1PR05MB5530.eurprd05.prod.outlook.com (2603:10a6:102:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Wed, 4 Sep
 2019 14:08:33 +0000
Received: from AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by HE1PR0501CA0011.outlook.office365.com
 (2603:10a6:3:1a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.13 via Frontend
 Transport; Wed, 4 Sep 2019 14:08:33 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT042.mail.protection.outlook.com (10.152.17.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 4 Sep 2019 14:08:32 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Sep 2019 17:08:30
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Sep 2019 17:08:30 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Sep 2019 17:08:00
 +0300
Subject: Re: [PATCH v2] nvme: Treat discovery subsystems as unique subsystems
To: James Smart <jsmart2021@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20190903212037.29705-1-jsmart2021@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5b4c2f45-971c-45aa-49dd-dc1fb228cb87@mellanox.com>
Date: Wed, 4 Sep 2019 17:08:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903212037.29705-1-jsmart2021@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(189003)(199004)(6246003)(316002)(36906005)(229853002)(31686004)(16576012)(110136005)(106002)(58126008)(3846002)(478600001)(486006)(230700001)(2486003)(23676004)(8676002)(81156014)(81166006)(31696002)(446003)(8936002)(11346002)(65956001)(336012)(6116002)(86362001)(65806001)(47776003)(70206006)(70586007)(186003)(16526019)(26005)(7736002)(76176011)(2906002)(305945005)(53936002)(356004)(14444005)(5024004)(50466002)(5660300002)(53546011)(126002)(36756003)(476003)(2616005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:PR1PR05MB5530; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc0ed05-b4b3-4301-79a4-08d731415ee2
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:PR1PR05MB5530; 
X-MS-TrafficTypeDiagnostic: PR1PR05MB5530:
X-Microsoft-Antispam-PRVS: <PR1PR05MB5530165AA8FED1D54328ED17B6B80@PR1PR05MB5530.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AYhxJfM/enzpKIHgsd+JVnF3e5F71fZmxVJzFwAkGEKLghiAEUk/q4vvE2V3tyBI+nkX1NvJ0ObAdLISjFIJcUFjMtwpHk7BGmRGfeXtkmETQf3AcgwAzSvszOVgmW5Ixl3HzhXV4GQcDi6gF6S3BuzcpQ5bubeUBunOhjsSB/0kFbdi0/YXacbhtUN11EUAvTgiGWE9YmxSL+yerSH/L1T9Cm0e+GELtpFFY5jxXd+Z9ZDRvITVKHv+br7m+kDmKxelssiyEjEB7H2tWYhxVdEfWjvRSESVlwya692e8CKV3AXhjNbggyOezeWGbl9oAQoakOnBY2d9EVFvpyl+1mvSPwM6KRY3ksQybm3nljbTdJapG+ZUheVcqjb0TW2OVH4zJxMqz16r/iHX0VpePKgBbb2QrvbkLejD4LcJM8s=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 14:08:32.9019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0ed05-b4b3-4301-79a4-08d731415ee2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR05MB5530
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_070836_865219_DA465FC9 
X-CRM114-Status: GOOD (  17.73  )
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


On 9/4/2019 12:20 AM, James Smart wrote:
> Current code matches subnqn and collapses all controllers to the
> same subnqn to a single subsystem structure. This is good for
> recognizing multiple controllers for the same subsystem. But with
> the well-known discovery subnqn, the subsystems aren't truly the
> same subsystem. As such, subsystem specific rules, such as no
> overlap of controller id, do not apply. With today's behavior, the
> check for overlap of controller id can fail, preventing the new
> discovery controller from being created.
>
> When searching for like subsystem nqn, exclude the discovery nqn
> from matching. This will result in each discovery controller being
> attached to a unique subsystem structure.
>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> ---
> v2: add comment
> ---
>   drivers/nvme/host/core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4660505eded9..6960781a514e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2358,6 +2358,17 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>   
>   	lockdep_assert_held(&nvme_subsystems_lock);
>   
> +	/*
> +	 * Fail matches for discovery subsystems. This results
> +	 * in each discovery controller bound to a unique subsystem.
> +	 * This avoids issues with validating controller values
> +	 * that can only be true when there is a single unique subsystem.
> +	 * There may be multiple and completely independent entities
> +	 * that provide discovery controllers.
> +	 */
> +	if (!strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME))
> +		return NULL;
> +
>   	list_for_each_entry(subsys, &nvme_subsystems, entry) {
>   		if (strcmp(subsys->subnqn, subsysnqn))
>   			continue;


Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
