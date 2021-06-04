Return-Path: <SRS0=9AXB=K6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348C0C4743C
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 18:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9CC61406
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 18:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9CC61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w5MSx3tVOmsnjg9M96ztK0Tv1g2rGy+Tp3NTPcUHjn8=; b=XeGa+s8tlAjBI7
	fEKLnsz/ww+QbmmV/+Zbq/znuS5Ny8g4/bh0Gp/UdZt6lpcmB7Ox66DDhg7c336h5fgLGUWy74Ws7
	gGdkt80PwAdGpLa28G8Q43HYf7B9HSBG+ElVhR5zMV37fUGLjEpc5grHXxDMFokx6vJ/m0f6FvwXF
	u0wcQSo7HkGLhIUEQiJuIIT5G6UJZP/Q3tnrHSQ0Qn3zIInfuLXFUjBy1kW+mlbXpn78ZsZ+zIYhV
	OfH5l6xJD5yEA5Abaj97shSp95MVpyI7pmCRL9ZffdR0aWndO6b0iSnabz5CDw0fN9ktympaV/Ro2
	2+qtw0UJVjWmLywylg5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lpEsK-00EtZF-BR; Fri, 04 Jun 2021 18:48:56 +0000
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com
 ([40.107.243.73] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpEsE-00EtYe-9P
 for linux-nvme@lists.infradead.org; Fri, 04 Jun 2021 18:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9LrK2yhPhk3wZB7TCarvBWBs6mCspYncceTEdQXO4ZJpMYn/kEcrKb6kVQ8BvtWaef89/tj9wxY4rfpD0JpJJpRaRJllswDJnhVyNh5c5GaiZH1kqXR44AHfZhxDgy3JqdUSVgZoO3NxB6G+Odv4inltbNG5avh9616hZ/42DZcT+5YzGY20WSP90L5AWomDrlPhAJ9BFsKfg9EsNBCQhXYTqxdOlONH0Bd7YRrJO/tc/S09doovBrk65dObA+CjOobdRAfk0zShHbfcgAIX0Afien2U+A3QLhHke2DqoUPDmUKXaavZDTyiiuh4YTMn0x3zXd+ODQ3IQc0Akqw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9gfk0wT6bnhJ0XyCr2OsDjY/51H8YtzZpIxz8dod2k=;
 b=SE/CP30XRGcNYa/5oHLYTdnj9TNKojJFigkBSsgHXcWr/Y8VzahBDWeUF7kaciujPT0pINrdElxHPLoP/Tp4dh/LNAgmSUD9TRiF2YMy5NBnHEiyR8MMllrjUGwnHHQMIVnhI0Tfpae5LgYDdscOrecahok4qdwczexNdSW6Tl63KOFiE/U8rmJW+XnhcXDb8rWCIs9k9+0qrl9RKpw7WKRx1jts3EzDvRHJv9OuLHA1cv8uZpYqfTFFTXjUGw2RcX1LYFMgts6o+LBRfmok94t6Qfq5UQyr5wkYtuciULGP1z/4FBInoZAXfv3dg8974muAYoJiXChmbUvEJvGVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9gfk0wT6bnhJ0XyCr2OsDjY/51H8YtzZpIxz8dod2k=;
 b=PGrVk7xsduKeIs70RFZ2qg79Pbl00RAen9SeHNBfeUFKywggTPP7AF3pbF6dzsZAgVSL7EKaIUv7GjLzWIfHXulrY+Z042uF5qo0aSyPa+ZF+ycnLW1IJebGtaWrxMiD2C22vhCD9PWAZRL0RJ+S4s/QsWVQa8MO30s9OQwFFak=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 18:48:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 18:48:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Raul Rangel
 <rrangel@chromium.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki"
 <rjw@rjwysocki.net>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "david.e.box@linux.intel.com"
 <david.e.box@linux.intel.com>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, Julian
 Sikorski <belegdol@gmail.com>
Subject: RE: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
Thread-Topic: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
Thread-Index: AQHXWWJADYBNW8WMtkuzG8HMlelIgasEH2QAgAAEIYCAAAk54A==
Date: Fri, 4 Jun 2021 18:48:41 +0000
Message-ID: <MN2PR12MB4488E83A1117FBD5DDA51FF4F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
 <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
 <acd70140-aac1-bde2-225c-1a8c1c272753@amd.com>
In-Reply-To: <acd70140-aac1-bde2-225c-1a8c1c272753@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-04T18:48:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=84415ea8-8da5-476a-8b1f-46cf03ca2ec2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afa477fc-c194-43a7-3af9-08d927895f5d
x-ms-traffictypediagnostic: BL0PR12MB4849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB484904A128EF845919B96B16F73B9@BL0PR12MB4849.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qE/TLOnGq6ODsYBx97vPgMw7WPl73GgNVTCxEZXQuZugRGA3uFjI/pMpk7tqJS86KVCX0DA23z8BeGROKLB/w05OiNjpGtbJk7n+67zFljW7DudNmwZZfVNPr+NOqdroDmhvb6/yh/lDa0yBYPuxs6Fc4GP8jBXYDC2YEjdW7BSVCd/uiPLYqEVIgZA9UIQHoY3A4KIWAFZ4lCQ0XG4O8+ZI9qGkCJ9cDP5ltgow2ZkrvFNhUU3uxbjOuoRC11a9WESv/BRnLKoIBi0zDEmo7kvt5/YAsAefe4wzF8AG3zUE4Pm0WtIp4aljQigzrPtwZu6nhHwCS2bduRb8QVFeXHo5RGDjaAZmnD/nncdLBcb30SQf/p5BwfDwvxHgxeM/xp3Td7dwLyXKMPvDoSxjOeqRsk137UCpoRP05W/IF172OyMXMHnU9rXYFEgsokFVStDUGXoCa4av8JynXn/4fxQJSdNXeye7sB0dLSc/J4hoqlsfAmjSftwkzut7m/i+140lViSxuS6MMQ2v6t4KAHXdo0MHuL8qqbHC8SaMat5Hxs8K2oSphLA/nikVvYplWYa1Cza0yLyn4P36iC4Ogvr+ZY11IoqeF8PoObfyIAY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(7416002)(316002)(66556008)(2906002)(110136005)(55016002)(66476007)(5660300002)(66446008)(76116006)(66946007)(54906003)(64756008)(52536014)(122000001)(33656002)(53546011)(71200400001)(38100700002)(8936002)(7696005)(8676002)(478600001)(4326008)(186003)(83380400001)(86362001)(26005)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2NUdUpzT0hBTStKOGsyNEdCbXpON3FCbW1XRzNFV1VXNVRKcmFuTzlOU0x3?=
 =?utf-8?B?S2t1clAwWmlENEQvS0FHWWw3QXFwL1JjaW8rYThXYlN3RXcva3B2Qm9QdnUr?=
 =?utf-8?B?R1JNMG5BbmFIZmo2M081aERZWFNMN2tJaERhUWJpb0p1Y2pjZDFYWFVEaE1q?=
 =?utf-8?B?UTdFbW9sOXdKUU9MbTVJL2dVdnpXODJIazR6SVR0VTNDWGl2V1RDak9tOHlm?=
 =?utf-8?B?cGdlMmFQc2lVdk41OTA0bGFUQ2lPUkUrNXdCOEdveHFSWDFQNm9US3F4WXAx?=
 =?utf-8?B?R0c3SXdIWDh1SWh1cXFvSkFPYTBXelhUTy9Ubm9yZUtRRHpPMm9aMU5Oc2NX?=
 =?utf-8?B?aEkyMDFjdDhWUTRwYjYzTUhLMUZVQm1YSlFNNXBzTUQyc1I5Y3Y1OXBpRktJ?=
 =?utf-8?B?SllhWTJPdlJMS2wvbW82cGtZM21aWEV5Y3pYZzNJeW1jUHl6d21uTXRCdHhL?=
 =?utf-8?B?V1YrWjE3ais5ZDVYdHFXZmkyRUFHelVTREo2SFZpK3BIWUt0NkVZYk1mbjN3?=
 =?utf-8?B?citvaVRuV3liajBHQWc3aTRZOHRrRWNpODRJdG5ZWStONGlFUGhuWldrTHM5?=
 =?utf-8?B?eDZiU3dKQnlab3RISUtaQ0FHa3FidFE2SzI3YXFkdG1WZkV6NEdsWTdnczFo?=
 =?utf-8?B?Mnplb1JiZklFNThiT2ZEQUlua3dVM1ZuYjQ0MHBqVzk1YTBxc0FJVW9KclFY?=
 =?utf-8?B?dTR5K256dDN1WXZqcDhVL2JPeUZpNVp2ZTZ5dnVpaEQrd0pQM0FCMTgxeGcz?=
 =?utf-8?B?dFZyTmpQcGdsWStNZGVYQXJQMGx6b21aKzdKN3hHWUdpZTBlTGdOQWxiSkVY?=
 =?utf-8?B?a21uYnYrOVdrUjJ5TzcxYzV0aDU2ZlNiZUFxS3VuSU5VTDhZRDdITHI1Y2Vi?=
 =?utf-8?B?ckVwMTlXd25kV2pNSjgyUTQzYUMxN0NtVHVCVVNnUEFDZG11L2wxYUtDcm1M?=
 =?utf-8?B?S21sL2Rrem93Vyt1MlUxWm5TSVVwaFQ3Wmo0OGp6L1dNKzFHTURKdWx0VHp4?=
 =?utf-8?B?ai8yNk9rbzZJeW10WEZKUUlodmpvdHRONG91aUZ1RGFIbFU2MjVLTHgvWlpI?=
 =?utf-8?B?SWpSMEFQYXlPOHhzMGw1SGNUd0JlTUhIUlZzOWJON3RBcndETU9NdlFVajc4?=
 =?utf-8?B?aDk0ZGtyWTg0S25zQmd1Q09paVNFNWhCdDFxSGlYWmtpOTZ2dFRvZ0swL2kv?=
 =?utf-8?B?VXRQU0hxNHFnVFE0SG02d2NGc2QySFc3VkMrdzlsTkNQR3ZONFpXQTFXY0p5?=
 =?utf-8?B?d05lVkM4ZkthSVBDWkF5VVpFK0E0ejJwN3lJaDA4SDZtbElqM0NsVit5RGNl?=
 =?utf-8?B?eXBVMFk4emdZNFp4eGN3MTBIREZtZFFoa0htTE5KVlBRaWZtM0t6QSszRlZj?=
 =?utf-8?B?MGpMRUZVYS85RTFpVkFuWmhFMU0zT2ludmF5VXdIdGxWaDVVOG4zME81R1p2?=
 =?utf-8?B?U1RnTG1mQUNGQmRFekdkOFBUZlI0VjFsQXRmRW9oSG84eFFKYmZ1TUhJYU9n?=
 =?utf-8?B?SE41azMxOHpLd0N2L05RY0FrZFBJQlpwYjdvckxOZHA0K0ZicnlhRnNLNFcv?=
 =?utf-8?B?MXRWSHdYdUMxa2ZYZjczaEorTmcvQXBGZ1lTWFV4T05salRhKzkvbkhoZ0Fz?=
 =?utf-8?B?d0x0MDhCTW1RU0VCNG0vRjBkN01ndTBmZUZVOE11Qkxpd0ZPYXBmdkNpOW4v?=
 =?utf-8?B?Q2FKS21aZjAzemtwMjNHWE1WL0twQXJDdjhiNlpUTUpFSVMxWHBBYUlQRThE?=
 =?utf-8?Q?6iRxKAvZOIjOgbgOyq/ecmSn1oZ7vqkSGBBsuO9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa477fc-c194-43a7-3af9-08d927895f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 18:48:41.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erFVF9HT1HPJRuClEDrmZVRsxWTXoQ+/6TG7FujQujKM8kVdcIsawyZ8h1ZxvVR3vhmW5dtjFG2dbGs0cPPG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210604_114850_442644_B33B2FF4 
X-CRM114-Status: GOOD (  29.82  )
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

[AMD Public Use]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, June 4, 2021 1:58 PM
> To: Raul Rangel <rrangel@chromium.org>
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; Rafael
> J . Wysocki <rjw@rjwysocki.net>; open list:NVM EXPRESS DRIVER <linux-
> nvme@lists.infradead.org>; linux-acpi@vger.kernel.org;
> david.e.box@linux.intel.com; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liang,
> Prike <Prike.Liang@amd.com>; Julian Sikorski <belegdol@gmail.com>
> Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne
> CPUs to force the D3 hint
> 
> On 6/4/2021 12:43, Raul Rangel wrote:
> > On Fri, Jun 4, 2021 at 10:54 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >
> >> +
> >> +#ifdef CONFIG_X86
> >> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> >> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir
> */
> >> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /*
> Lucienne */
> >> +       {}
> >> +};
> >> +#endif
> >> +
> >
> > Is this the same matching logic that Windows is using?
> >
> 
> I don't have access to confirm their logic for it - but they do have an allowlist
> that was used for systems before StorageD3Enable was introduced as well as
> a registry key to override it in Windows.


My understanding from the windows team is that these AMD platforms use the allow list.

Alex

> 
> In Linux we can do it a number of ways:
> 
> * Detect the CPU in RN/LCN platforms
>    - Like I did in this patch
> 
> * Detect some other PCI device only present in RN/LCN platforms and set
> this hint
>    - Like some earlier versions of this patch series from Prike did
> 
> * Introduce a tri-state module parameter like d3=auto,off,on
>    - Set up logic behind auto to use acpi_storage_d3 primarily and look at a
> quirk list as a fallback if that was false.
> 
> * Add a compile time option to include these quirks in either acpi or nvme.ko
> only if a user selected them.
> 
> * Enumerate all the field systems SMBIOS we can find with these CPUs
>    - Expect this to be a large quirk list.
> 
> I don't have a strong opinion between those two first options, but suspect
> the 3rd through 5th aren't really acceptable or scalable.
> 
> I'm open to other suggestions but testers of the patches thus far have made
> it clear that /something/ needs to be done to avoid the problems on RN with
> Linux though.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
