Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983A5C3F2D1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F69217F4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q1a8RifI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QFD+F5co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F69217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UEkNkvnASacJxbUo8QlnuKLaj5CXMU0I0oBALB+CZLo=; b=q1a8RifIh64ejzkvIfi3mMFzX
	0AwF07wmJCpj2FFXmtt6CSXz4fA/YkXQH/1hiAOxO8rc3tLoEdcbE5UjkzJJ5eIznCXcm9mYxCkHp
	UIFSUlWZHnxu/UnNJpGzKCOi+4yZJXYJib2veeHDuLbdZaO4XCc75LQJcnjMreJ1RjIlE/LNc985S
	svHRmgCRA95pmyrPstu9j0VrZOGPv3jp5ftFt7o4+hHEOrwGDSZK6wI0/20Ji2OeZ3Ef1EW4zKU+R
	I+4Dq+ihZHDZcTbgA0KWT+x9uL+jq5YyBYs813YkqUXOaFJa80hfJLP5z4tNau67GgACTigV+rSBJ
	qXwKCPxIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Wgv-0004d0-O4; Wed, 04 Mar 2020 16:16:13 +0000
Received: from mail-am6eur05on2068.outbound.protection.outlook.com
 ([40.107.22.68] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9Wgt-0004b9-1G
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge8PaXj2L0oKUjG844g3JlVsBVfHI7HO8EtcaRvDew5VgygeBg+6/7wpsc8B5Yxc6VfvdudlUs7WI/knQppwTQCAhpYD8qBjrPw+fxgu7blDUy5Ie+qoXZEwhw5+VWAZCSyUsDvh+Br8FDvtt0NRg5C152XcQxhvHhee4E/jJMa4LIMFdvtWSoEfYrKn/Ias6H+kBCPk1m0H93wgVjgG1tPrBHDE4zHjCbtRyA/k2vDTBJFqF+60bgD+FPptvwh9eGRt4DdPlD3wQw+11unfE5cXfAsh8p/MxPohZoXm9LwutVWbmJrKYzZ16QyVKzzs7u52YEMkDjE4inR5rObzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S4PHlXHnxMVc/4TaMzkJn0dLOUd+tatMsTAAJmVUr4=;
 b=UgVUXRcmTNUx/9ez/Lwo3XbOfjJqOLGytez8jgj6k0vmvobC17/4MSQNb98tEZpSmYn8EK5tXD+R1rRizurqohALAbdZpFYxA8duJfBMuEfh+AxdDLJC12zpRtxutWoi3gk3efII+hRHBaalj9Q36M9GQsdNo6BhlGGFmmwcaKvzDbHntM4yEqhlOX+zSCP4hsYpJj3NOwYXOzXZ/K1qLzFtDano9mqLbKEos8YkKg2PVqF7sOo4w79Onnc/dYL+sxhDYBwhU/1YDyp1C2Gp3+IhCHyUGbvsFod6r6gm+rjZU8FyTy+W1RXMro1xhzC20I39dS+1p1h1sHmbk4yLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S4PHlXHnxMVc/4TaMzkJn0dLOUd+tatMsTAAJmVUr4=;
 b=QFD+F5co1G2o+8mozxVVaCUuumlnWK98+o1iUu++Sxos+wIpjxTimAhjw3HZPpa6gospqO1vhJ8PS6WnYNFMrIB3M/9bzHi2SfrmoLodc5Fq8SlGjgBFnVbC1QNLWlHUNV9b6lGfG8nQq1wwU0CEpPxtr7quS1/8Knch4FC4F50=
Received: from HE1PR05CA0165.eurprd05.prod.outlook.com (2603:10a6:3:f8::13) by
 AM0PR05MB4658.eurprd05.prod.outlook.com (2603:10a6:208:ba::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 16:16:07 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by HE1PR05CA0165.outlook.office365.com
 (2603:10a6:3:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19 via Frontend
 Transport; Wed, 4 Mar 2020 16:16:07 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:16:07 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Mar 2020 18:16:06
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Mar 2020 18:16:06 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Mar 2020 18:16:04
 +0200
Subject: Re: [PATCH 2/3] nvmet-rdma: Implement set_mdts controller op
To: Christoph Hellwig <hch@lst.de>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-2-maxg@mellanox.com> <20200304160105.GA10897@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2e4190bc-a12a-5eaa-af53-01889f2fbb42@mellanox.com>
Date: Wed, 4 Mar 2020 18:15:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304160105.GA10897@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(6916009)(54906003)(36906005)(26005)(2616005)(478600001)(31696002)(356004)(81156014)(36756003)(6666004)(31686004)(2906002)(81166006)(186003)(70586007)(8676002)(5660300002)(8936002)(16526019)(4326008)(316002)(53546011)(70206006)(16576012)(336012)(4744005)(86362001)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4658; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 010a2ab4-ddb1-4aef-03da-08d7c0575858
X-MS-TrafficTypeDiagnostic: AM0PR05MB4658:
X-Microsoft-Antispam-PRVS: <AM0PR05MB4658A9130E2345772773EC98B6E50@AM0PR05MB4658.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er1reo5my0Q0ZsBwwfUZNDuBLzvhrQfEPo8rrSaKLim1h557ZH9o3vPtIWAFrShH72Z2Bd0Zp0XLepHtx+rCxEfOLF3wuaRP3BYX5cSi9h85CzjKOy9iT7GMYSEW7PZ+hNXuCl7U5mHMUhvarzg+sGM+05VH25qEpz2Ap1qAeHvebTsRHjTkfbwQB3/Lscvy1v25GfpD0/41glCv8eYFXhDnogSESid7CgVLtfFtbBolAlBH0bEfoxrPQshKbouzzVUSCMFCw95N/AABzJc5tAO6LtGmh6809GR0Ko4AtElWIg8vpfvaQwRfZsUuIUJPR0tSUb8tQFjRTe9j222vR76XPw642EWlpYGKgUllSVirHxJKvn8Z6wJCtH/l91W1dYbS/mda83f9cY+KKUpzyYXHzNivIM+F1unQOMVoKD0rgloGoA/tonLAx86BfUKgeuqdh4l8PJjbf3LerwtuwL2l5bxi2qO4zvHmC34Q1bf7sP/KjnY/3XjUdemQQ7Tx
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:16:07.1464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010a2ab4-ddb1-4aef-03da-08d7c0575858
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4658
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_081611_148324_8D94573D 
X-CRM114-Status: UNSURE (   8.49  )
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, krishna2@chelsio.com,
 jgg@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/4/2020 6:01 PM, Christoph Hellwig wrote:
> On Wed, Mar 04, 2020 at 05:39:34PM +0200, Max Gurtovoy wrote:
>> Set the maximal data transfer size to be 1MB (currently mdts is
>> unlimited). This will allow calculating the amount of MR's that
>> one ctrl should allocate to fulfill it's capabilities.
> Do we reall need an op for this vs just setting the field in
> nvme_rdma_create_ctrl?

This is target side :)

But we can add it to .add_port and limit/set it thorough configfs as we 
do for inline_data_size (with default of 1MB).

Let me know what's preferred.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
