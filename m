Return-Path: <SRS0=Eo3O=3I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA34C33CB1
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 13:47:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BD9206B7
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 13:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rK5sSG5d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="MZYEBFk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BD9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tRIliOkCvOIW6e6XD4M2wBufwU1SFtYsJhXlEFIyvpE=; b=rK5sSG5dV6wsAVmo8W9HLQfwh
	yIx1UIcx/tedWsb63WjSz+3m4q077COiAVcPEy5+N3n99Qo5nDWWeFZy9pBA5j9Mwz3mlUBV16l8s
	OXg2cxh10LuGqvu3v2W+ebPHwI7L9K2dnQnd8XazQzoTOiojrCxmMENUMEdbXAGkpgdEvlMoz03FM
	+s6w6uWGWe/s8n64sGIcQhC1ONxyB8Gih/s5mCWIF0+1356hyXxyXkaTIhelYwFnrJkQqO6+R/w1V
	NY5aYIBbmMc/0YHC4dPFXxQ+4tidsLck3VR9V5nrjKBo+/kzQ/t5HNR046ZHItZp+9QIH50u5fzYF
	VyUcZNuKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itAvM-0004mp-6m; Sun, 19 Jan 2020 13:47:32 +0000
Received: from mail-am6eur05on2043.outbound.protection.outlook.com
 ([40.107.22.43] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itAvI-0004mW-Ok
 for linux-nvme@lists.infradead.org; Sun, 19 Jan 2020 13:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXUOIihYdAh/TpqLEaLQ9GAmqlT5IJewVnO2c6unSORBFK9fxjbFrbVpUOZzxsxE7zRmMmlYxQvCo21GTH4TQpclQjdifI4CAl/RmOyF51aFrHG77gp38GXWbm4B4TXiGJwUW39g4Xu8HopIW2vR4WX3bBHfDmIC8/KTH08zH3ON3oRz+M8qpB3YmvK5ILEFK0W+npFrl5IwgJOM+8ca83WV3ApWy+KCH12dpoy1HNA9xiUJApx6+db5FQ7JRCN8CHixajBuKAqTHTZRlcNIBOmk8v+qayO/VHrAQR8XoA59EToys9nBCzeuL9IZ0Uix2A2OY65PF3kejX8G36JfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66jqB6U3Xd1zRwYUE+868qPZQ2ma/eXE7zQW9890JqA=;
 b=DekGEbSxlL21RjZGTjGkMmel1G4KfSpdvnNFESkNeFy6GrOYs6/Xq/FpWefCEsxGgrFMBs68GH5kG9UyxfE7NYzIBn+Kgxz7Ycrxb7l53mj1/ygZ/zgwBbNQj/h2jzACas85ikCwkvgf1xcg3tB4A74NnvWhwk/UWcIdbMGwF2vhht819CQR9oULxFT4wYpzZf3grM4jsJsFt8DzDDDO8Gt/pvFYrDACvjLBfnpjHQ4j1/q8Op4O0YjheQkEsj1vrXMb3JeYhPHILSYXH7s6HG+97xmqs6sGG99Q/9i582Wt1e2l2rOM8GyAT1PJIrYiuRoyo3FiCKvlCGnq1JjqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66jqB6U3Xd1zRwYUE+868qPZQ2ma/eXE7zQW9890JqA=;
 b=MZYEBFk69u2MwNCWCiRRf+nF912QDn6RQMDKc9CXtihb/FXqY6JocrVabY5LvbdxonYfBNckqjSwoEJHQhR71kOVaU66j2w2KmO+OHmksFWhNVezQGJ+eTUeasBXiYwiOKVm73ZFwP29m866FbOcVGFPwsBHQWfs+9iL38cJ86o=
Received: from HE1PR05CA0219.eurprd05.prod.outlook.com (2603:10a6:3:fa::19) by
 VI1PR05MB6895.eurprd05.prod.outlook.com (2603:10a6:800:180::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Sun, 19 Jan
 2020 13:47:24 +0000
Received: from DB5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by HE1PR05CA0219.outlook.office365.com
 (2603:10a6:3:fa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Sun, 19 Jan 2020 13:47:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT047.mail.protection.outlook.com (10.152.21.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2644.23 via Frontend Transport; Sun, 19 Jan 2020 13:47:23 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 19 Jan 2020 15:47:22
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 19 Jan 2020 15:47:22 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 19 Jan 2020 15:47:17
 +0200
Subject: Re: [PATCH 13/15] nvmet: Add metadata/T10-PI support
To: James Smart <james.smart@broadcom.com>, <linux-nvme@lists.infradead.org>, 
 <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <martin.petersen@oracle.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-15-maxg@mellanox.com>
 <ae42f71d-689c-3f75-3a80-9fc4bea1427b@broadcom.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a89ea832-20f9-9e0d-3232-d251ca7858b6@mellanox.com>
Date: Sun, 19 Jan 2020 15:47:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <ae42f71d-689c-3f75-3a80-9fc4bea1427b@broadcom.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(110136005)(81166006)(5660300002)(54906003)(81156014)(16526019)(316002)(2616005)(8936002)(16576012)(53546011)(86362001)(31696002)(336012)(8676002)(36756003)(70586007)(478600001)(31686004)(356004)(2906002)(107886003)(4326008)(186003)(70206006)(26005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6895; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753833bd-fde0-41e5-128f-08d79ce61d05
X-MS-TrafficTypeDiagnostic: VI1PR05MB6895:
X-Microsoft-Antispam-PRVS: <VI1PR05MB68953B32DA8EC16A35A20469B6330@VI1PR05MB6895.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImxnGb0d+Y341ycIk1gN0HmvgZ3tfmQhfPgH/L8NZsIYuqXNSVNJ+wKE7SuKuIO/w3T1X/Sdz48WhBMHhZdlpOA5cguNu7KW7W4eA0r6kVQZT0NdpYNfvXeup5zlgGafazh+iCAz7+QD8YZXkXKsa710ybfpniVQeqR6mh2dZHZq3/oVZifJbds47e1+DWGLxTyiurBlT5vdkx8TKaNCxF+1uGNpfadMdAfYM+A5wTz1By0Y53bBnhcFMl/vrV+3cdLXsYwjP1Kcl9kP3kNLIf8ZaOnZRQbZ+E19RMum3klLHxX7CwqrK9mHtm9U5QYDIb5BtKhJsUUfWyslwZIgK8UiS+Y1/rTKVEgKqzSXcky38w1hSLtRgDUFIS1Q4Wfo+AQ0p8/SHl05eJaXWiFEOzi6o23xKup+Jvv5c4kteBPwqEPOJ9iW3i9kEBxktm0Q3LjtNetwscQzFY7AlMRgmhC0ch9/jpxDjBfbQOYsCGGMdF5bfsGQBDPpTW5PzQah
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 13:47:23.7715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753833bd-fde0-41e5-128f-08d79ce61d05
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200119_054728_863632_53B27E06 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/17/2020 6:46 PM, James Smart wrote:
> On 1/6/2020 5:37 AM, Max Gurtovoy wrote:
>> From: Israel Rukshin <israelr@mellanox.com>
>>
>> Expose the namespace metadata format when PI is enabled. The user needs
>> to enable the capability per subsystem and per port. The other metadata
>> properties are taken from the namespace/bdev.
>>
>> Usage example:
>> echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable
>> echo 1 > /config/nvmet/ports/${PORT_NUM}/param_pi_enable
>>
>>
>
> Mind adding a core routine, callable by a transport, to set the 
> pi_enable attribute on the port ?

I'm not sure what you're asking here.

port->pi_enable is set using configfs before port is active and 
port->pi_capable will be set by each transport before creating the ctrl.

ctrl->pi_support will be set according to port capabilities and 
subsystem subsys->pi_support.

E.g in case you would like to expose subsystem with MD namespaces using 
RDMA port and using FC/TCP port it will work.

The RDMA port ctrl will verify/generate the MD and the FC/TCP port ctrl 
will create a regular bio request that will be passed to the bdev driver 
to handle.

Also these ctrl will identify themselves with the correct capabilities.


>
> Also - I don't know that all block sizes, metadata sizes, and DIF 
> types are supported by the port. Should these registration be 
> "capabilities" lists ?

would it worth complicating the code in this stage for ports that might 
not support all types ?

RDMA ports support all needed bs, metadata sizes and DIF types.

We can add "capabilities" in the future for another transports that PI 
will be implemented for them (if needed).


-Max.


>
> -- james

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
