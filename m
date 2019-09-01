Return-Path: <SRS0=oU3s=W4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43054C3A5A4
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 10:05:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056BA21874
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cjEc+VoX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Vd7v3ySK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056BA21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mtvtx58h+tHWxEvtvwqCoW2vgE0uE3AuvlwxM0C9XjU=; b=cjEc+VoXtlJUk3Amgu/YMnTrq
	T6aGNc/SbkY/GfXFYMmurSetSyJus4iNShRJ6U7qlgrLvDIWIGjDH+YALwmCSvke7NTRapjmcqc/V
	ou4vp4TSsBJGt43ScV0QIEkpiz5TcgukKg9JUHWFRbPPknh5uCWMFAmDsiEtByx5NFFWhW6ovovEd
	hFsXvmbJS9606XOWWB7VrroetuM+4CrMfE9gWm/8++rZvbCbUPbQWT1vvU5OUAtlnseVn2lRFrpAH
	LYCYzCdAV6GMMIr8cafPZuai0jPaduTdjQQ85y5tY6Ivi5YzYSJuqZl+GELzdGSB15VEirDgJsYxZ
	1mMaxOPBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4Mj6-0007MU-P5; Sun, 01 Sep 2019 10:04:52 +0000
Received: from mail-he1eur02on0622.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::622]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4Mj3-0007LN-6n
 for linux-nvme@lists.infradead.org; Sun, 01 Sep 2019 10:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f15lPZTVnu7BuO4gYGLzESF0IGMAo00vZGFAVRX1wLeN0q0FR80xeHKOs2TbUxlyO2Uzby4VSBvX57wsmN+NMmdr/EfYjeBf4Bi4fo+4V7H0rBP1Ua3ewetYeJwLyCf6i+P7DTyANJqW+nPans1mvvQ856SOeYhv2KM7aokyYSLmifKJsjiDdJk7S4CQ/QEmLFrg1Qb1iXFxTYRONaRxBQ0JRjKchtmubVHc8Ckt6s5qC7X/Uk8SsGWbrvm6M+a4agP3eTxAXZednLHdzsUCCBMiKg1A7xO+21n9PRlQb9VO/szdXldXYN2vIO1HaYmJSpC+uKsED+bJaDESm/Ag2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvWPD/nSjUUSUkPJAoJ0Y2OKZTog/B36sVB14GNK4+4=;
 b=IB9VcLLyW6IGSf4ZB2WBBRIVEFgix206dJ2Zb4USJSPcT8riWCBTnoxFDO8Gtpw43/yKMk70w1heX6dV1LBYPcM4nTfYdliFnSD/6+k97Wmk7DT2vm2ygD1sW94jLCDA4M5/GJsqBg7Pcz8DL5GgxlVrEwfViDVMuxsT5Soswl/r60i0E66ZZ2fZRt5H8ZOOxEIdspVnFrMyKaiubUKpiOwAFngtMGdFF1zmI1rSJFwTuXmzo/r3SfAdMqeKLjlmXsJG5Ja47WDTWYswKcevvaE/AbF2duMUc8dajrFFoJS0n5e5I12NPJ3Ic6ZbdAy0GTi9CVEC9kL5f2FTCv5J6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvWPD/nSjUUSUkPJAoJ0Y2OKZTog/B36sVB14GNK4+4=;
 b=Vd7v3ySKCBZkOPfzOa+XUjhQ+jG14/qy/A2wl+A5G917Hb+w1IZa9DSf2jBmPYEFfg1Hap5PLPcBPlVJ9k/zex8I/ZpxSlaRJHY6ILhscljYcz/XQnox9k4nL3L+zWB9+62YDYNfcZX04hSudJlayOG5xwnADHmWM6K60VlO8Ro=
Received: from AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16)
 by VI1PR05MB4798.eurprd05.prod.outlook.com (2603:10a6:802:61::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Sun, 1 Sep
 2019 10:04:45 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by AM0PR05CA0076.outlook.office365.com
 (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18 via Frontend
 Transport; Sun, 1 Sep 2019 10:04:45 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 10:04:45 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 1 Sep 2019 13:04:44
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 1 Sep 2019 13:04:44 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 1 Sep 2019 13:04:43
 +0300
Subject: Re: [PATCH] nvme: Treat discovery subsystems as unique subsystems
To: James Smart <jsmart2021@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20190830201145.6729-1-jsmart2021@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <009ea9f4-86bc-be92-d3e2-458c5dd1f059@mellanox.com>
Date: Sun, 1 Sep 2019 13:04:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830201145.6729-1-jsmart2021@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39850400004)(2980300002)(199004)(189003)(31686004)(53546011)(5024004)(14444005)(76176011)(23676004)(2486003)(478600001)(356004)(16576012)(316002)(36756003)(6246003)(58126008)(5660300002)(53936002)(26005)(16526019)(186003)(476003)(2616005)(486006)(126002)(110136005)(11346002)(446003)(47776003)(305945005)(70206006)(7736002)(86362001)(31696002)(65956001)(65806001)(230700001)(3846002)(50466002)(6116002)(336012)(229853002)(8936002)(81166006)(81156014)(8676002)(106002)(2906002)(70586007)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4798; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 503f3ffd-4113-430f-88c1-08d72ec3d0e5
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4798; 
X-MS-TrafficTypeDiagnostic: VI1PR05MB4798:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4798FAE7B6B97A351A05E04EB6BF0@VI1PR05MB4798.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0147E151B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GUkggxqyQOIj89w74mi9eXQpSYVK3w208iBPKBbCz1SEy1ofEhP1YvrBxjb77hFqSPvtufDSXNzNtC2cabVf/tUTjryS2nsnNrluVi9x61714/epbCRe7qK2QGeg+I3EEpbV4UPCLTQtkpR1zEz8Bm7zkjy3bHW6oiHaWHK3zASuzSYbxCUl6DRUkzskXuCvplAvq150+y9ON5Uy3AJmIQgrKKwLxyVLuS7fTrdStA5jRpIngsexqnvwlVSJA0N+nYGL9v3EDF2x6hU8dQODeDecClMokmph+KswLgwisvRFcanLLF8AhpGi+4f54p+KkYrIWhY7kw1f/Qtdgqs2/kMpzV4/rSyZ5lvgGGiLb4IWAnAFvJVtMr/R2e1PMYphZEGoEWy5NMjW4xGJcoOFP+0UuCG7tCubzzOzzkaZIOE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2019 10:04:45.2497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503f3ffd-4113-430f-88c1-08d72ec3d0e5
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4798
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190901_030449_591546_C3D20EB1 
X-CRM114-Status: GOOD (  14.47  )
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


On 8/30/2019 11:11 PM, James Smart wrote:
> Current code matches subnqn and collapses all controllers to the
> same subnqn to a single subsystem structure. This is good for
> recognizing multiple controllers for the same subsystem. But with
> the well-known discovery subnqn, the subsystems aren't truly the
> same subsystem. As such, subsystem specific rules, such as no
> overlap of controller id, do not apply. With today's behavior, the
> check for overlap of controller id can fail, preventing the new
> discovery controller from being created.

so this fixes a scenario of multiple discovery in parallel ?


> When searching for like subsystem nqn, exclude the discovery nqn
> from matching. This will result in each discovery controller being
> attached to a unique subsystem structure.
>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4660505eded9..3edafe57c7f7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2358,6 +2358,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>   
>   	lockdep_assert_held(&nvme_subsystems_lock);
>   
> +	if (!strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME))
> +		return NULL;
> +
>   	list_for_each_entry(subsys, &nvme_subsystems, entry) {
>   		if (strcmp(subsys->subnqn, subsysnqn))
>   			continue;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
