Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B64C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:49:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106BC606A5
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106BC606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Ry6G9dFWrRH2Vb87NZTbP/J4r5s9y8ojBRKPmUfv6E=; b=ODO9IPFfbz2Y1xg0X0lL12eH0U
	eCOQuVBq3HL+g0i9eSoE5/WdmzC6KsD9UN/kA8CxestXNz2CYnVfYNqtFHw3bc/2DUYTmLw6jCrNm
	xxAXNoyGniii41KShBtYVhSwwgaEk9pmjawluFqiOe8OKOXR8rOv5OMCui/e/4G7GokqdCNfqDnpn
	cwtXBL0Bl2qtkpbpDV3534wyLmtaVhkyBCRgzM2RvL1N6nJljbtNtRlQMZDZWORAF2abeqmsZyiPB
	fY5qKJ/6FjBDIk0FtGQq0yj8YTP/4aRK0V96ePGiYKlAr0zyCxOGJfQVNdLutA5kItrT7uvjnQiez
	E8n56YgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljnjV-002Kob-7R; Thu, 20 May 2021 18:49:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljnio-002KIX-8Z
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 18:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=uuQR4fCbWVVpkAAWrprpjFUUBECtx9GwDS4m32L2Q5M=; b=gBG6lQFSSYXcUb1gWcBOIgY3+V
 F0r9jFP04a7PFo9O9IFV6t30oVgj4yb162ej+HiNwnZ2sVIh67elzX16Ww0p1sSGGmS3/3bu1FeKY
 rI8WyTVJv9QM2UOnw3yfOL6QHQ4foVCei6XlOu65iRsuTpDzC9DaJTIm3ofQGJwIZQl1trm99cNl+
 dyuOdhHQ2/5/TWKHvrXv+FURZdV1NMohrOw/ECT2WH/lTE9LYG2aBWXoa7ogNMII0rwGDeiqjuAZY
 4tiB8g8lJrcGLPodg//Gxw10XbWD13M1GOoJveD0TUX219rtNhsJ0DCIJNstPFMGs73hWFiuSI/cD
 py4lQmTQ==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljnik-00GaHE-FT
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 18:48:36 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14KIbhnC002089; Thu, 20 May 2021 14:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uuQR4fCbWVVpkAAWrprpjFUUBECtx9GwDS4m32L2Q5M=;
 b=Coxi2QJ9M7xU3qYvPo5CQk31oWr8kBgfbzGzAPmEAnN5h5DkKqNaVQVPbvLBh1noCu6j
 Qw+8QdJ0eqGg6q6EZt9hlJXbLFhwKaR19Dlpwp2A2TmYMMKGr+jA7t8CndujYpbrM/gQ
 y8C5ioDwbOAQ0yEp/LlvW/UTGlo/euxE2ybyvae0VouaYTdABW9pzkpIP+9U76WBMvBU
 blsURED8EEF8hoRz01Gh51kLgjDbmEQKkF5m1k2nIVZUmKKMNfijrU9ZPMAhBernhnC2
 BmoR/hP9VrHyNSQDQZeiUjY+yWAeir4AppQ9ytr5p4m7Km4r6RYiK5fM+KDjCQ1+9L3o OQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 38n3a9nww2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 May 2021 14:48:21 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14KIeCUv010417; Thu, 20 May 2021 14:48:21 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-00154901.pphosted.com with ESMTP id 38nkas2g0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 May 2021 14:48:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BccG2M5KPprQYt6EtGDL5Qc8vh4dy8XK53Dh+EYwBdkRQyWZJPnxQNeK3hL5p87rPEfTqy4QeMMgqt2RiX3307CW2Ag/z1ZzOA+0X68fxvljR7bpiS45x5E3Ljllc9jBkQWBHwwt1iSoLXwlgdxoGueCfQ7YcJOPSJDZAl65gJQsNeDhov+bLR8jNmoR8ynS/qfbu3T+QX3sswNVtGnFJ5YKKlxDy4Djy6BpJalwj5GxnU94aozPHI8UpoKUB4oBcvbQd11az92J/5d3NlTKDPioQdFCZTt/hWm09LOW/kw2Dl4Ddc86GTvUKcqYHv3t7eHVzE58CGXK0fO5fqVGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuQR4fCbWVVpkAAWrprpjFUUBECtx9GwDS4m32L2Q5M=;
 b=YFOyzxp9yNsFDHmmdi3pwWwXsuRxQ/FUeOWKdYL9gf9c5Tm7lbGMi7ErF3qt6xCYgZ0WmD1sZ1XKbI1p0nDBl+Jw6Q8HPjRaJJg0CoGhj4ZO2tyXBYQYhZhXYqIMWpW6SeyT7vkXiXSFTKEB410r8JlBp3eaU/yt6HOmjYlF6ZUbE5ohgkHZuSMaJ/0iEzrbqSzfaT3C5ox+mJXrPgluajOcSRj0XxW5bl7bFmxeY0lujRo3QPl76VXkCkM0psRFw6xuqViuB0Qb0YjxMgfuHReU8mBS5LeGSrHyqsP+2xTX5aOMuaZGYAA9wobtE13RHBQPkvaiv3l7R0h0sVlffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BLAPR19MB4531.namprd19.prod.outlook.com (2603:10b6:208:29c::19)
 by MN2PR19MB3615.namprd19.prod.outlook.com (2603:10b6:208:18b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 18:48:16 +0000
Received: from BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::5d4:48d7:5472:763e]) by BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::5d4:48d7:5472:763e%9]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 18:48:16 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCHv6 1/1] nvme-tcp: Add option to set the physical interface
 to be used when connecting over TCP sockets.
Thread-Topic: [PATCHv6 1/1] nvme-tcp: Add option to set the physical interface
 to be used when connecting over TCP sockets.
Thread-Index: AQHXS0jePR862mId+USTAqdBfbHq7qrn/VaAgAS7u1A=
Date: Thu, 20 May 2021 18:48:16 +0000
Message-ID: <BLAPR19MB4531EBB359E0EA4CB80DD418F22A9@BLAPR19MB4531.namprd19.prod.outlook.com>
References: <BL0PR13MB4291A122DD3E31016AADB82A9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <eba75cd2-5021-05c3-f1ca-bfb05432af2b@grimberg.me>
In-Reply-To: <eba75cd2-5021-05c3-f1ca-bfb05432af2b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-20T18:48:14.4570068Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=94880a7e-87ad-43ca-b878-19af8dfed708;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0634c82-be0d-46fb-ab44-08d91bbfd48a
x-ms-traffictypediagnostic: MN2PR19MB3615:
x-microsoft-antispam-prvs: <MN2PR19MB361569D0615ABA4292CAD4FCF22A9@MN2PR19MB3615.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yr3wlDOjO+W5Iz2nqwyGcQjwvS015rSnYmsG98CSdIr+tH3SDLZUPA5RVx3sU2f48QXa1UHI677kTTTU2Ui3dYX/Ti31TJFqj5FJ2WUwb9GAmUCOFhLXUGDOOfh18Ak24R4Ug1TNfI0+SF0FEYljReugkrQv9JUrCcSkHv2C5QLaAtJA/ySEAfxxHQDh+36d/j2JK+H4dpItk750uCZR8sd09jTygqbLeZeemQeLfw4uDCL47e79NzCDiF3IXzsx/SCmSx3CPlzczi3nV0vwQwPmLvPfL4kO2iQ9RNcXAxp+PGK3U6fBBCpvC3BXt+Yo+rA4gxKAjguZXDt5gI+tRcN3fI7fJfRI/7mgLKWmasuugUQ35lRC2pEdbQ/kknqboPcVSOx02Bj5yex9k1UJk8pwpQhmC/rlISI+lPACXVM0cDp2jXTXECOcstes8XMq2lqZ1PWK1ZLfcrBv8usQYoHKgfcVQ3/H4nz1lgoM3k1yaOqKicfOnxPudsRUFSePwEC4c3dj5i21WBoukQmHtAbxYBstSfq9FrWbcuvQcH20BldzrruAvdcWHkQUWHii1w/i61Dp/0hq7hMwjnDjW3fR40yXQEQn/c1wNq5mriyJHqmdpm8xLLwwsGr7Prmbt417yDavOYNexYmM5dLRKd2e9lAhKEPHNGmzKuQfx343Wb5gUtG2AVqtpwJHUnBr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR19MB4531.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(2906002)(86362001)(8936002)(5660300002)(55016002)(76116006)(33656002)(122000001)(53546011)(38100700002)(6506007)(316002)(66446008)(26005)(478600001)(786003)(4326008)(66476007)(66946007)(110136005)(64756008)(966005)(9686003)(19627235002)(52536014)(186003)(8676002)(66556008)(71200400001)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVoydHQ0a3RDZGd6ME50eWJkb2Z4bmNHYm5nWm9QTWM3MWdJVm5sSjcvbzVi?=
 =?utf-8?B?OXU4RDZRSFFlWW5RcmFwbGdVV2dHcVQyL3kzTlR5Uzd1R0poMUk4bUNmMFJZ?=
 =?utf-8?B?a3h4TVp5MlMzZnNlRm9zUXo2MFlyOVNLekVtcjRIdkJDZEVjWlZpbnFibjFG?=
 =?utf-8?B?b1lZWXR4c2IrQVBQOXFvOXB6REk1dEhzWXRIUVl0QitJUmJDN0RzV1U3R1R4?=
 =?utf-8?B?dUNGM2NuNG5YN0pZb0dGYktVajdPS0lQazBreWI1Q3NvUis5THBQd09RZ1Vv?=
 =?utf-8?B?RUlrUnRDcS9OV1FVNGROc1VDNXg0eElNQVhDQUMzeHluS1p0OHZ3Tlc3YUZa?=
 =?utf-8?B?QUhyMVVVQlBvVDl4Y1dVRTZKSTY5dWQ0c253Y0d5bHhqSHJOeFlJRjQ3WXZh?=
 =?utf-8?B?WWlGZjZ1aXNGemNDbVZQNlNFMUw4dnd1cm1yMUZsSUViQUEvajhibFI1SjV4?=
 =?utf-8?B?UlBjOWwvME8wbmt4SFZ4cUw0WW9IMTJvdEpXbksrS2VTNUpYak5YZnhaZ3Vl?=
 =?utf-8?B?eENwZnErWWMxMDY2SzA4YnduTDhVSUdnVXFNTnB2amF4Q0dPcUdnZXJub0NL?=
 =?utf-8?B?YWhKM3VldFBURWVrZzVrdVNGRWtmL0d1UmVtbkdvWkcvOGNsVS9rRGFqWHVs?=
 =?utf-8?B?V0s1VDlxSEVDZEhXMlJaTWdNQ2pGSGNsWFVteTRZQ3VPSUttaFQ5eHlNeUJk?=
 =?utf-8?B?dFpXRzB0MmxXTmgvT3JEZWI3M0c4aE9ISGp0THBuQlFLU21PYnZ0aVNMS0Ex?=
 =?utf-8?B?RFZkTGNsejBCaDFnS3BDUURNZ29lSnFGVmM5STNiNjJLY3UzSnZzVFRhT203?=
 =?utf-8?B?TWgvTTVzYkY0ajhGeGxLNHVOZmNpUlRwTWErY25uVUJ5TmZpNDg4TWVXVkFH?=
 =?utf-8?B?WHYvcDJPbTM1dXdmSFJvek1sZmhMZ1E0M3FucGdUNzlrckc4K2ltWFVmYUJZ?=
 =?utf-8?B?b3JhcEdnYXRWZHdscERiZlIxVkIyK000MGF5QXNiY1BjQXptRjZuRXFuZ1BL?=
 =?utf-8?B?QzREK0RTSjMwRVpaS0RLV1dxQnZzbVdJcGtZdW8zSDBmSnVHVDJKaVVIRk5V?=
 =?utf-8?B?K3AweC9MaTJBRGRETUFOVXBYa0pDZUk2OWRaMi9hRllJRHM4dEI4MUJmZUEw?=
 =?utf-8?B?bkp5bEthTURJbnUvaXFtNDJkZXFET0xGRnZPZ2VwUnJEYkNyRFpWdnJTU1FO?=
 =?utf-8?B?aUc5R0piYWZvWWdjMG02Vm41MDdoYTQvNHNhWlZ6bHFhYnhPS3Y4TXFvQk9T?=
 =?utf-8?B?RjFyRHhWanQ0MDZ6anNVRDd0TEhWR1ZkVEwrNHJkM2V4VVJSYU1ycVRDWVNI?=
 =?utf-8?B?UUd0L3NNVEwrSGdlc3pkUlUza2I4Wnp6aFE1OUQ4c01DTTMwb1pmTVlMWFVT?=
 =?utf-8?B?bVRHenVBZGFOeENUSVR4WGh0R0VjRUc1NFpUci9XZS85U1NCNHlDdHVic1c1?=
 =?utf-8?B?MjZtNXVJeTd6OVpqNE9Ia0JUWnhScmlpaUxJc3lIWnlMczA0T2NDVmhwM2pJ?=
 =?utf-8?B?Zy9veUlMbzB0STNUb2dqTmFjaE1HZFFOZU9pL2U4eWNPaDA3MWpvMkVIMWkw?=
 =?utf-8?B?K0g2L3BReDZiK1BteS96STd0b1E0aHFhV1hJekR0bzY0dEdoR096ZTE1WlJO?=
 =?utf-8?B?YmRRcm1LeU51b1FaQWpTRUQ3SzR0UDZDeXNzZTlYRDRKYjhqckRNWWtaMVRQ?=
 =?utf-8?B?MGRET01hZFE1VjladjdhY0o1cEFzYVU1Nm4xbC8zR3hlOGZ6NXNIaFNvakhS?=
 =?utf-8?Q?T/ySt0mm5sqw2H3uJjbluAJYsNvxRLqmq/MWwzV?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4531.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0634c82-be0d-46fb-ab44-08d91bbfd48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 18:48:16.6524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtnwD+X9xQ0ZSTJtrhPH84XBP6El30Sh/l7oDiTwWCQbXDf4/ZaFbfkzv/I01yrr2EfRLncNzq1G8aaSxA/L1YlUb1PTOtJkKcQN8p9E1is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3615
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-20_05:2021-05-20,
 2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200113
X-Proofpoint-ORIG-GUID: 74SMomPnaT4LIAeWHtRxHxagA3gFat4A
X-Proofpoint-GUID: 74SMomPnaT4LIAeWHtRxHxagA3gFat4A
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_114834_608251_D8AADA8F 
X-CRM114-Status: GOOD (  35.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 5/17/21 11:16 AM, Martin Belanger wrote:
> > From: Martin Belanger <martin.belanger@dell.com>
> >
> > Addressed Sagi's review from PATCHv5.
> 
> This commentary belongs after the '---' separator.
> 
> >
> > In our application, we need a way to force TCP connections to go out a
> > specific IP interface instead of letting Linux select the interface
> > based on the routing tables. This patch adds the option 'host-iface'
> > to allow specifying the interface to use. Note that corresponding
> > changes to the nvme-cli utility will follow.
> >
> > When the option host-iface is specified, the driver uses the specified
> > interface to set the option SO_BINDTODEVICE on the TCP socket before
> > connecting.
> >
> > This new option is needed in addtion to the existing host-traddr for
> > the following reasons:
> >
> > Specifying an IP interface by its associated IP address is less
> > intuitive than specifying the actual interface name and, in some
> > cases, simply doesn't work. That's because the association between
> > interfaces and IP addresses is not predictable. IP addresses can be
> > changed or can change by themselves over time (e.g. DHCP). Interface
> > names are predictable [1] and will persist over time. Consider the
> > following configuration.
> >
> > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state ...
> >      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >      inet 100.0.0.100/24 scope global lo
> >         valid_lft forever preferred_lft forever
> > 2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
> >      link/ether 08:00:27:21:65:ec brd ff:ff:ff:ff:ff:ff
> >      inet 100.0.0.100/24 scope global enp0s3
> >         valid_lft forever preferred_lft forever
> > 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
> >      link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
> >      inet 100.0.0.100/24 scope global enp0s8
> >         valid_lft forever preferred_lft forever
> >
> > The above is a VM that I configured with the same IP address
> > (100.0.0.100) on all interfaces. Doing a reverse lookup to identify
> > the unique interface associated with 100.0.0.100 does not work here.
> > And this is why the option host_iface is required. I understand that
> > the above config does not represent a standard host system, but I'm
> > using this to prove a point: "We can never know how users will
> > configure their systems". By te way, The above configuration is
> > perfectly fine by Linux.
> >
> > The current TCP implementation for host_traddr performs a
> > bind()-before-connect(). This is a common construct to set the source
> > IP address on a TCP socket before connecting. This has no effect on
> > how Linux selects the interface for the connection. That's because
> > Linux uses the Weak End System model as described in RFC1122 [2]. On
> > the other hand, setting the Source IP Address has benefits and should
> > be supported by linux-nvme. In fact, setting the Source IP Address is
> > a mandatory FedGov requirement (e.g. connection to a RADIUS/TACACS+
> server).
> > Consider the following configuration.
> >
> > $ ip addr list dev enp0s8
> > 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
> >      link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
> >      inet 192.168.56.101/24 brd 192.168.56.255 scope global enp0s8
> >         valid_lft 426sec preferred_lft 426sec
> >      inet 192.168.56.102/24 scope global secondary enp0s8
> >         valid_lft forever preferred_lft forever
> >      inet 192.168.56.103/24 scope global secondary enp0s8
> >         valid_lft forever preferred_lft forever
> >      inet 192.168.56.104/24 scope global secondary enp0s8
> >         valid_lft forever preferred_lft forever
> >
> > Here we can see that several addresses are associated with interface
> > enp0s8. By default, Linux always selects the default IP address,
> > 192.168.56.101, as the source address when connecting over interface
> > enp0s8. Some users, however, want the ability to specify a different
> > source address (e.g., 192.168.56.102, 192.168.56.103, ...). The option
> > host_traddr can be used as-is to perform this function.
> >
> > In conclusion, I believe that we need 2 options for TCP connections.
> > One that can be used to specify an interface (host-iface). And one
> > that can be used to set the source address (host-traddr). Users should
> > be allowed to use one or the other, or both, or none. Of course, the
> > documentation for host_traddr will need some clarification. It should
> > state that when used for TCP connection, this option only sets the
> > source address. And the documentation for host_iface should say that
> > this option is only available for TCP connections.
> >
> > References:
> > [1]
> > https://urldefense.com/v3/__https://www.freedesktop.org/wiki/Software/
> > systemd/*5C__;JQ!!LpKI!3qE5jJQA-REQkOr1c042U-
> ghm28oHvTE48YZkHM5ugob8Sm
> > IPPIHxwEm7iwkC9kZyA$ [freedesktop[.]org]
> > PredictableNetworkInterfaceNames/ [2]
> > https://urldefense.com/v3/__https://tools.ietf.org/html/rfc1122__;!!Lp
> > KI!3qE5jJQA-REQkOr1c042U-
> ghm28oHvTE48YZkHM5ugob8SmIPPIHxwEm7ixiy1Q97A$
> > [tools[.]ietf[.]org]
> >
> > Tested both IPv4 and IPv6 connections.
> 
> Also this.
> 
> Can you send the nvme-cli bits as well?

Hi Sagi,

Just checking if there anything else I can do to help with this patch?

The corresponding nvme-cli changes can be inspected in Github at the following link.
https://github.com/martin-belanger/nvme-cli/commit/628aca9d66ddffaa78bdaa46668ecdc3d000a017

Note that I will only submit the nvme-cli changes after this nvme-tcp patch has been approved.

Thanks,
Martin

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
