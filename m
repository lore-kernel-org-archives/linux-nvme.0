Return-Path: <SRS0=VV3U=5V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC31C2D0F4
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2020 11:11:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71A220672
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2020 11:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K8bN16Dv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EB1yNBoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71A220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RMZOVTSb8Lz8+wYn0DeAbuypVl7WgBG6PUW2E8ZVx70=; b=K8bN16DvxSNW6n
	u1J+PhArF0O4U0jJc8yhRxwoweui3m+8S/EZjVk82ZQ1Avxwoda7AVZIFz/CQEO422D8/Wf0qnj6y
	xVH9MlZSBGlvFpIHfJCzjF0GOFpDAbsqoaktAKVlwADV/mwlPpOSQt45A1vT/zFm0LkI7VflV4MiT
	yAQHJZMw5eBCMsWsJtechre658dvWc+Imc/LqyJ51di0luhgwZOwDbEjokts6IZDVLXRYmCxo/DtI
	PmXFVQD7cvLa/dNitEYs1RkTjt+neXmxm4lhpfTLZncctGRd44Y0WH/7q+8DXx7N5I2/m3SbG3ZPP
	RnHrto4WhH3ByqDtv+sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jL3BO-0003WN-AB; Sun, 05 Apr 2020 11:11:18 +0000
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jL3BL-0003VR-7k
 for linux-nvme@lists.infradead.org; Sun, 05 Apr 2020 11:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LouJbtdVkABhvIsRcem/vztB4ECmBUomzcL+iPRKvveiPdEPOD7755r2fl5elzxtg6JKUph6TRKZcXahSyNClABT+hX7TxY6F7XftOqRRDI52GCNXrt2kt8x44ak9ATP3RHh+EmeIoOOC7ppqCTYurHslb7daRg9qXs4XajmZIBu6mEcCyKL6FxGXal4coqLeOmOCSdKlMgyGmN3HyAYdHpzPdcRub8DInTpefPNbdmFjwaOeGkT9afGd5+9rHlhmlSMl9VkYQib6MRFfftYjG/zPi44M5f6MvB2WcLTV5jVB5Dzg0DY5l40yfMx3CU5ZugWNgstBwCxfMXfNvdMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXAoCK59bKHeoHlJdZWPIo0t6oBluViGsmpNYuTAQJE=;
 b=nCCWxjexhrJhOqFqW5NRhu+sLGnjF5ZrS/JSJSL78IYJNR7Y4Mb4/UjaH9oJHDszatujkLhSWI+i6nU2BegQ+QlJTGx0QDYdZgrqYobAw+Bc3gfowUtLHFnm7H1aUboSCH/Nlmfk304zcC2AkFAiEl944Hsq6IR54ykZNI4i9X84iGDUzRAKOzq8DJH0XR4n8veKTAUV+wkjPuIL1MH/qd+8g0wcycqiDmmDUDrFeWYr9lLGKK6LnlHamAuITwc0Ce/XdYXCs54mSb4gIgdpW4vmJrNeOiOfquYSbALGYkicR7BUggpuT65HI3+XZ0wW0rs8LOTi3IflHuyKB66rjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXAoCK59bKHeoHlJdZWPIo0t6oBluViGsmpNYuTAQJE=;
 b=EB1yNBoSeDQQ+S6HJyY71RvSmUxBfMj26pnLtS9u2VeSUKV0ibSx8lgM+8Hf9l/mbXTywvsNhrErRpLVeVhkef4qQkdNTRyHuCvl9iSTf0Oe+/emm5oSsXcvpqbixtr7nkLwn1MANp5RdI1y9VYRP1Dhkukg3qaG+8aCL3K3xps=
Received: from AM0PR0502MB3777.eurprd05.prod.outlook.com
 (2603:10a6:208:1e::23) by AM0PR0502MB3665.eurprd05.prod.outlook.com
 (2603:10a6:208:1d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 11:11:10 +0000
Received: from AM0PR0502MB3777.eurprd05.prod.outlook.com
 ([fe80::65e6:5bf4:b844:8465]) by AM0PR0502MB3777.eurprd05.prod.outlook.com
 ([fe80::65e6:5bf4:b844:8465%3]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 11:11:10 +0000
From: Shlomi Nimrodi <shlomin@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>, Alex
 Lyakas <alex@zadara.com>
Subject: RE: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
Thread-Topic: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
Thread-Index: AQHVMZ7Ogx7dWH66H0uk966533Hhaaa5ffCAgA3xrYCAAZPIgIAAxKgAgBvgE4CARLtPAIE4xPMAgABZB4CAA7k3AIAAY2CAgAAFCICABG+IwA==
Date: Sun, 5 Apr 2020 11:11:09 +0000
Message-ID: <AM0PR0502MB3777EDEFC698146A753DA0E3D7C50@AM0PR0502MB3777.eurprd05.prod.outlook.com>
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
 <66ACE500178B47D6B39F23FE98D22363@alyakaslap>
 <b6443a7c-4be6-3dbc-0535-a8ded3261c50@mellanox.com>
 <8ab1fa5e-2d67-5128-93b5-2f32704869e4@grimberg.me>
 <28046c97-c271-dff4-5252-4b5668c7bfb7@grimberg.me>
 <B3E9005C4E4645628157970AE2A385C4@alyakaslap>
 <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
 <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>
 <5fee46b0-0516-766a-5b1a-7114a164c9ae@grimberg.me>
 <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
 <5f439f61-338f-4f37-2b13-d3b743c32409@grimberg.me>
 <CAOcd+r2JSYfL66a6yLO6KDTFHo3XcNW=4mZnqAw_Wz-wQ1=ULQ@mail.gmail.com>
 <c43c581a-a2b6-62fd-340a-b20c7ca25b88@mellanox.com>
 <8cc74e5f-f005-415a-e67f-0486b3999f71@grimberg.me>
In-Reply-To: <8cc74e5f-f005-415a-e67f-0486b3999f71@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shlomin@mellanox.com; 
x-originating-ip: [85.250.232.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f708ff97-62f8-4648-4db7-08d7d9520b9b
x-ms-traffictypediagnostic: AM0PR0502MB3665:|AM0PR0502MB3665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0502MB3665375F0837D9F203B882E3D7C50@AM0PR0502MB3665.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03648EFF89
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR0502MB3777.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(55016002)(71200400001)(66556008)(52536014)(316002)(2906002)(81156014)(26005)(186003)(86362001)(110136005)(54906003)(8676002)(6506007)(4326008)(107886003)(9686003)(66446008)(64756008)(76116006)(8936002)(5660300002)(4744005)(81166006)(478600001)(53546011)(7696005)(66946007)(66476007)(33656002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2D/jzs6cy1Qu0Fku47HztwicgwqMMXRbj2EkNEw4ebM1qyLcmaEK7xPmYYQqnu1ctKBQUNVmSiBQdQetwmuUWfVtnCfhQjI+cjaCWvd1PSwxpQPzoBwIynxGUwTE2PFfv2WlmbwvtlmtCijiSOGKikkh2I2BVBhGIExuI+uLZk6rRi3CZFuABiTux7wM7Y7gSAdGyCSH34HlC+ztjoclIoqA5Fl2jw5pu9YrXp3IrvgK+SRxddfDq14h6uiA7+VKPsGIShygunqC4+UxL4kV3tJ5ffwHbh/8n9BNyNn3KNeSXKIIUnRHKED7w9EfFEEkVM/8VKqhigqS814oZwxfwZjdH4eR9TntJBfM5VPZHOMpyAl0LtQgjpXmNTIqjEMSFDTERiaE394Ptbt9CoYPtBILEJsjq+0XmRq6xNQ5LQsbAvBROOch1D3JKRr2czjv
x-ms-exchange-antispam-messagedata: IfqEpNpgR1qQmWzO0olTsbuX1M0RzZcy/vCdRKbJ4E92nHm9B6/yjchE9HycVZWHSc9+P9wvDlgTG30W2rxekax2uZEV1ReZPDrhIKxe6ctdrK5CRLd6f8o4eeJri/+tjz7CDTiunRDhVjmD/lrReQ==
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f708ff97-62f8-4648-4db7-08d7d9520b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2020 11:11:10.0078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw4noHfLH9PMMBHfZLJnvKNdVjegi4y1sk8QUrP4rAoQF+Dhq4AYXWkSzOcIaSUAPDnt8+PiLmc8x3Us+h1o4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3665
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200405_041115_613724_68350191 
X-CRM114-Status: UNSURE (   7.00  )
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
Cc: Tom Wu <tomwu@mellanox.com>, Nitzan Carmi <nitzanc@mellanox.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Israel Rukshin <israelr@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

++

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Thursday, April 2, 2020 18:27
To: Max Gurtovoy <maxg@mellanox.com>; Alex Lyakas <alex@zadara.com>
Cc: Tom Wu <tomwu@mellanox.com>; Israel Rukshin <israelr@mellanox.com>; linux-nvme <linux-nvme@lists.infradead.org>; Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during bond failover


>> This patch did not apply to latest 5.2 (5.2.21). All of 10 hunks 
>> failed.

It applies on branch linux-5.2.y in the stable tree. What are you using?

>> I applied it manually, and also handled cm_id->context in 
>> nvmet_rdma_find_get_device as I mentioned earlier. I am attaching the 
>> patch that I tested on kernel 5.2.21 (target side). I confirm that 
>> this patch fixes the bond failover issue.
>>
>> Tested-by: Alex Lyakas <alex@zadara.com>

Cool.

>>
>> Max, will this help to deliver this fix upstream, so that we can get 
>> it in MOFED 4.9?
>>
>> Thanks,
>> Alex.
> 
> Alex,
> 
> Thanks for testing this.
> 
> Waiting for Sagi's official rebased version for doing full review.

I'll send a patch...
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
