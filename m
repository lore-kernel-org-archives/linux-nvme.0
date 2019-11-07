Return-Path: <SRS0=ACpZ=Y7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6632FC5DF61
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 13:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386F4218AE
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2019 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PSJGw6k3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Nve268u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386F4218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OUQOMr7u5TF4/wmNB2EREgHH8xvWy04fJ0jCEt6Jj7Q=; b=PSJGw6k3MevlZp0mVZDyinQ3Y
	PK/qxO509FdB6uFB1br6QG9Ek0NWlKJWfdzqzRWvLTdujw4wM2Hu/pb5l/9XNHpsswswZBB+fDRay
	EnPVETx9rHgEDXMXNLVPcjqNn4h/p/BdtvIkuwIc0BkHPw7HDf88PNTr8C5Y9Tk68kQMdQnCjQ2D/
	qNV+ALdmu0AS28gZpLUR4dFQQ9zT7UGmba4qHUa4wT1soK+pvqZGd+5Z1kaUGuOSV2oOm/wTTamAS
	U7jc62gU3VGnTGhJBIXuJ1HIitiYd6FzS8864POM2j1k0Qflyt9UY+uC1KJtupFnvWx+n46YZzLK0
	TjtbJsuTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iShru-0005r6-3W; Thu, 07 Nov 2019 13:30:34 +0000
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iShrr-0005pu-1T
 for linux-nvme@lists.infradead.org; Thu, 07 Nov 2019 13:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+RTjXWur2jhC+yGP6j9XiwzkzixuZrgrVY9TF9dkidOBy767wCM04Rzk4vhPTTKPwiVvPYZYrNgKDOnTMHze5mgzS1YPOPihgQZ0UgE+pWjOteODBbaWcUFY2pipeD8IIb4FpA5WgciE33yf+o5xqFK2emOKx46J7YnW2eA5CG6HvgAZkuCwef1pl3DyyvKL+piTqeCr68zQg0CmVaYR7UjTbc5+YVPc6HRYza5j25oBZ7ONt6Zm7elG31G/8WBCprw9Esaw+S0OydmOsAgT00pXHqNkQ+AFoTjWkNurjUqHO2IbKHqLsPquUX3UkMrk81Kna5kpV8I1d0XpXy+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTGLdT849Bc3yA83hMyJSz4TCkWBmY6Q1FtWMTlDxho=;
 b=DpsS/uZgxY91iQogVrCf2VNQODhA/9994bQATm6NnkR5Ol33uW/RdlztcYV0CEIgRzOsc3cXTeDBViqKTcvsiuq1iE+GdhLA2BrVpCkA+H0f1nps2MGKd5wdWuPQqd/+7rcqeDH87DW8vk7I/Wh0fVBAWxf+J64LtHU1ayIaPIupd2vZvxbbm8Bm+jouX1RSRWKc7MhKNHlvMEg/Lj3quK/zHr3eDFfQDcUkgjLfl6Y3YArZVBbz2pPEL1RbOJ4YLSNpazhFayF2w+1yQ2pPY5uMHd5qyL1DiD2MnYoPQgW7hslUOVuwa62Jywj9MxhcIsg58CCePyhsqS/GHrMy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTGLdT849Bc3yA83hMyJSz4TCkWBmY6Q1FtWMTlDxho=;
 b=Nve268u8nYJ+IaxevLMRdetbUum+9/52YmoR4BARijfu60vuD7QFTUQRNxplpkCwTtqRFu60/FCFFWSGfE8ORUcHcsqICWYiOzbFw0zstKkGlcF3kFH1gNe9CW7wxnBXflorI8XuKdeFI1FaoyY/oSjEdnw+r5E4ys+O00HrZ3U=
Received: from DB7PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:10:36::33)
 by AM6PR05MB5288.eurprd05.prod.outlook.com (2603:10a6:20b:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 13:30:27 +0000
Received: from VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by DB7PR05CA0020.outlook.office365.com
 (2603:10a6:10:36::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 13:30:27 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT029.mail.protection.outlook.com (10.152.18.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 13:30:27 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 7 Nov 2019 15:30:26
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 7 Nov 2019 15:30:26 +0200
Received: from [172.16.0.217] (172.16.0.217) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 7 Nov 2019 15:24:59
 +0200
Subject: Re: [PATCH 06/15] block: Introduce BIP_NOMAP_INTEGRITY bip_flag
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-8-maxg@mellanox.com> <yq1y2wsxv7o.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <578955b0-719e-0ab4-919f-b4ec84d1f77d@mellanox.com>
Date: Thu, 7 Nov 2019 15:29:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1y2wsxv7o.fsf@oracle.com>
Content-Language: en-US
X-Originating-IP: [172.16.0.217]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(2906002)(76176011)(2486003)(230700001)(478600001)(4326008)(36756003)(36906005)(305945005)(81166006)(4744005)(81156014)(23676004)(7736002)(53546011)(6916009)(5660300002)(47776003)(65806001)(65956001)(486006)(8676002)(6246003)(2616005)(229853002)(476003)(126002)(6116002)(31696002)(186003)(14444005)(16526019)(106002)(8936002)(26005)(3846002)(54906003)(58126008)(11346002)(16576012)(70586007)(316002)(70206006)(86362001)(446003)(31686004)(50466002)(6666004)(356004)(336012)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5288; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb4c10ce-f964-4038-ed09-08d76386a6f9
X-MS-TrafficTypeDiagnostic: AM6PR05MB5288:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5288D6F71BCD62614D832795B6780@AM6PR05MB5288.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpKNYGRUiw2dmmdcceUBCk1ZlSQzHXT5JqRkRp8y/VesJgAi4Z/E7kkq0G9BIRsJ755+ch3QEAt0E0EjTQhgi68iMT736vjMo0usuYJy5Dv5AbMuGRwIzqrnxDLcJa23pa8KJouhhzUWXW1vpW1iTbM7L9D6olWMl05XYlmNT9/11T9kQzrIsBN33tOleIYUH0voUw8QGEvRP9znPzPQ3WtQOKQ0gR1VemvG45brhov6ZQsw0P/4rJdKkHKK4mj8MIN93dG/rfRXvU1ReWty3gHxvBt/DafWRhao6iJ94CW7yw+KVyHxm7bLqte/8hfvknKrRhUL+EMkHBZQgqy3lltdX9sdNfn3GzNoaxXBreyGMTYjwRfwv6CduaFSH2tslRYZtL453Sf5rp+LI5FQFA9g72zv6n11HoqznPR9etEs9LWlTVJUpExKc7MadNqM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 13:30:27.2524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4c10ce-f964-4038-ed09-08d76386a6f9
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5288
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_053031_151018_15395C58 
X-CRM114-Status: UNSURE (   8.50  )
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
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/7/2019 4:43 AM, Martin K. Petersen wrote:
> Max,
>
>> It means that reftag shouldn't be remapped. This flag will be used in
>> case some other layer did the reftag remapping (e.g. in NVMe/RDMA the
>> initiator controller performs the remapping so target side shouldn't
>> map it again).
> This is what BIP_MAPPED_INTEGRITY was meant for. Why do you need a
> second flag?

In the fabric solution the Initiator side is the SW controller of the 
namespace and the target is kinda HW controller.

The SW controller is doing the reftag remapping during prepare/complete 
functions and it should be done only once.

The HW controller should write/read the data from the media as is (and 
maybe verify/add it).

When you're using an NVMe disk as the bdev for the target namespace, 
then prepare/complete will be called also in the "target" side and we 
don't want double remapping to happen.

In the complete_fn there is no option to skip the remapping...

So we added a flag for it.

>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
