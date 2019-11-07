Return-Path: <SRS0=ACpZ=Y7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA68C5DF60
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A8A2077C
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMd26m1b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dGukHpVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A8A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M+N48VuK8lJA4rBdIh13XgLzbRfgqzIYM/QScRLowtU=; b=KMd26m1bvv1OsMq/5z0YExyRu
	0AZhomS69C6HEo1vXxl/1A1ktOeWMaK/pT8N0R8EmkxFRZkA0n4M2qn+C39fXzNKmQpFPElGXsYV3
	1PYcHOMMuWl3uj2ZRRwhf7NI4o/CkvmYR+Mln9CKDHpQffhOp4bEVXyS6cjlowXyDJ9IC4KF8gJEc
	Yb+fk6zaSD5NXEvQc5DiB2w1S25EP/SuNISmnw4EyKOY8fFyoNGUHCmkxluYlI3wfRhmlVy5i9gvF
	oYy8nDyzu0M9Ggbnh/tOYZcP/LvWFl069QPEakNEuXvy7Bj8IwJNF8F2z35irYX2fZEgsyIY94ZQS
	OV21efCXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSi5n-0002cs-I0; Thu, 07 Nov 2019 13:44:55 +0000
Received: from mail-eopbgr150088.outbound.protection.outlook.com
 ([40.107.15.88] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSi5k-0002c4-G9
 for linux-nvme@lists.infradead.org; Thu, 07 Nov 2019 13:44:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxL92rgfFByPzEkxV8gloIh2SBZn/3yp6BBqKeDgd+dEsV8MH8LOdbqH4jchs/cLLMtp7XyUs1umqUB+re6cPVXuo3VCGQKOjlq+MB8hmSoC/yTrLqLm0LJUtsSBQmik/7JXXFcKKFqVC5Cjt0kLQWY7TXD5wmwOffid/LgzAB07JpAoOH20YgkG7DfAR/t3CTLXgbupGVdfJR0RbfBM5nLOZCbykBqkvDNrOj//uSSsYHBkBOBgxhuCglHyEw2DW9R9zq9SG6E21/6CyWTw++ffbpXlw2b+it/9logImB6w7ZFev4FHJavMfEKHFrfAU+Kj33AaGmKkh9PhPD2ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78feJ0bLw3IFOFiN1ZEjWnayN2Fqxtmnt8QadeTYNn4=;
 b=Hua7guD7hDC04ipX63ZpFLiocg41VPDw5D1QpdV+AX1w1jsxaKI6vvZd1tbGpCiAbr0gP4ac2/ZeIMFIxx4cOFS924vXZlfeaXwVDKJ/RjXtaC3u6RNp0SorUNOdqvukdvfOgWLbCwiFmNpVoo8L9QISVPiMNOCZOnKaxgPMZ3mu48spWmOhbZcOaHThA1Lg09/czRgPBdfxxATGmebgW+w0LiLStjqE0rw9tvz+bwXEd3WCAonEA/u5EQDotraeP6PDIl4KSD+2ll0hxUR2axTSJD3h6aHD4MJ858WIxxlJNw6skWzAjT/ux2/tfbLQkuNh78q69Un1OQC/v/Zw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78feJ0bLw3IFOFiN1ZEjWnayN2Fqxtmnt8QadeTYNn4=;
 b=dGukHpVWxyEKD/oIn6M8P4ke/cIeKxJm9WXQ+EQ8Rypd+uGOdm5ND0BjFA37oXV8UhCnBTwm+Snbsdmf/7rGiehBsHMA5ig8MEN+WTpiRtdiZUJXLFa3YzszaZLrTFY0qUVOs/do/V/hPN9Vfo3VwCiI50pYy6pSj4pb7NV0qf0=
Received: from VI1PR0502CA0020.eurprd05.prod.outlook.com (2603:10a6:803:1::33)
 by HE1PR05MB3449.eurprd05.prod.outlook.com (2603:10a6:7:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 13:44:46 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR0502CA0020.outlook.office365.com
 (2603:10a6:803:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23 via Frontend
 Transport; Thu, 7 Nov 2019 13:44:45 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 13:44:45 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 7 Nov 2019 15:44:44
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 7 Nov 2019 15:44:44 +0200
Received: from [172.16.0.217] (172.16.0.217) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 7 Nov 2019 15:39:31
 +0200
Subject: Re: [PATCH 15/15] nvmet-rdma: Add metadata/T10-PI support
To: Christoph Hellwig <hch@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-17-maxg@mellanox.com> <20191105180254.GJ18972@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3069d77c-01ae-4d4c-1b96-a785dbfd26d9@mellanox.com>
Date: Thu, 7 Nov 2019 15:43:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105180254.GJ18972@lst.de>
Content-Language: en-US
X-Originating-IP: [172.16.0.217]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(6116002)(26005)(486006)(6916009)(16526019)(126002)(2486003)(7736002)(76176011)(53546011)(65956001)(107886003)(23676004)(336012)(186003)(11346002)(446003)(305945005)(230700001)(47776003)(2616005)(65806001)(58126008)(70206006)(16576012)(2906002)(8936002)(70586007)(86362001)(36906005)(476003)(3846002)(31696002)(316002)(5660300002)(6246003)(31686004)(106002)(8676002)(356004)(81166006)(478600001)(4744005)(6666004)(50466002)(4326008)(36756003)(81156014)(229853002)(54906003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR05MB3449; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fdcbcc7-151c-4486-55b9-08d76388a69f
X-MS-TrafficTypeDiagnostic: HE1PR05MB3449:
X-Microsoft-Antispam-PRVS: <HE1PR05MB3449775C3EFF32928A536975B6780@HE1PR05MB3449.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVgLKhy4+NeCag1XBoTU/OQ7TxSaaZMqnu67yMrK1+H294QriRUbakjwVu2oqe/XvtdIrtDL/G95mq3xMn90+bx5PjDHyEZIT13u7WZaRm93apI3fgwbdF2h6eUOp6Atn4JSS/ZbeMCEpZnHl3G4fr7PPcSoyAApQy0o8NWQEQR2Wr6+thm2kwPalwJzh96kzPzLChmRTmW8ndTAAchGotFCeyqW5Q0F/7i6yReOLo68nBNhIhWYhQM2/AfvOsDAguACWG46MBO2uUbGXVnqY8avn6A3TdyF9EVo7vR5kk36oLQR+K03DZQecQcWI1z0geLp485Swy3nehTKVG0+YsGIowlUphfDdM3HR/ZGx6YXWbVqhEsZeiIsXV8diy6NWEGsTqc/OX+yceO/rzBG+WVlvWAggI2BDOAN8veaOJOynaM7KXY8Hlw46+y0qkOj
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 13:44:45.6515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdcbcc7-151c-4486-55b9-08d76388a69f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3449
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_054452_537826_0DB9E630 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/5/2019 8:02 PM, Christoph Hellwig wrote:
>> +static bool nvmet_rdma_pi_enable;
>> +module_param_named(pi_enable, nvmet_rdma_pi_enable, bool, 0444);
>> +MODULE_PARM_DESC(pi_enable, "Enable metadata (T10-PI) support");
> This needs to be a configfs attribute, not a module parameter.

Ok, we'll move it to be per port configuration.

>
>> +	/* Data Out / RDMA WRITE */
>> +	r->write_cqe.done = nvmet_rdma_write_data_done;
>> +
> We should only do that for actual PI enabled controllers.  Also please

are you talking about the assignment ? I guess we can add an "if" check.

> use IS_ENABLED or ifdef to only compile this code if we actually support
> PI in the kernel build.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
