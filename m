Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D9EC4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 03:21:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C3420796
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 03:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZ3pKLuu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ssstc.onmicrosoft.com header.i=@ssstc.onmicrosoft.com header.b="JqBMP35q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C3420796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssstc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MlVr27okeMO74dtzvr+enRkosA7KA+y3rVi8ZfhiZOA=; b=cZ3pKLuuWwlnsk40cKTlgFEi6
	BfhU8PuUxZIgzB0OsAVutVH0dxVA9G6nxavswP2wRqTonAZRQ/nktx3ljIUx2gAI3TSba2qcZ9jUc
	oQmR2zJwAbk+568tyC+i/BpdzGNrRWPRoQVufnZvaCK58lTleqvejaFXcRIMHiNFryCQQ8PMQpKa1
	BFJRxlyiQpnHkpfbq2Ds8n5DGwgrmgPBfvKV2u5ir/U+7DSCKu/AG4RrXrAvQ04oylaiaBDcrityy
	32/74P4HGWtVDeei336rWkACTjhZvo4u3WyxbVJ4sLdtHbitIQkY8PIRYv2lPfe9q7+Yqr83LEpb6
	mGugehtzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXyVO-0007Xj-Fc; Thu, 29 Oct 2020 03:21:38 +0000
Received: from mail-eopbgr1310085.outbound.protection.outlook.com
 ([40.107.131.85] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXyVL-0007XC-BW
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 03:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPsvWxaCMpNbDwufzOeSsaeOHjj9vDP/eH7QK8RwXc9bfTbQfnGW3ywYqAo/pj2Qd9B3SPze0thMoTuM0rreHFQBjM9xtLae/i0jmxHk9ds1srUh5w+GlnU1mK/uSfyWjyKcrLwwl8LGEhUpC+0Ph54PJKMYDM39Xw8+MUDU50EQTAaT5gXlD1IwqRCJgjmj5/qSZQWDwXHkR/6tBUf7BAA1qr4PHuLtrvNabMY+hRNiRtM2lh2C2gcp8Wztcx3lBwcGztQyn8rutUC+aFXOuWbxaQxD0g3Qg1Vc8/7z+rnpH5WC++ffjMRC+WuaXPy0mpjXcBdj10odaM3AG79IuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpeWBo5NgAxfOmlH8/BKOazO7ebAkeaVStbH+PQ2SZY=;
 b=gNyeWcd8cabUMS7F7M4lIbwNcfZx6UQ5++6KzUY4RTprtjwA0kd6YW1QnD8LQy8YjU3GIO8Av1R7QNld9bCPtcsI3Zca6R3PpnIeKRBgU/+d4PXkmPO30tLn0J8U0lkXmurMBk2u/ROCYT5g94cp+Ihv/qtGwECJc5MTOkGEf7ZkLJu3rWylTCn0SXFQrASkPONzNvHfmzborOkNnxWeGrzdTkGR/qXOWAjOb+EMq1tvhphCgZnK3w7hoHEUU/1Tz7TKE8/pKq+QOu711o5lsD7AWwClepGM0H3G/k44J3qF+V+JU0tWttQAhIgrSjkgu0/YOE12nU1Ozuh5al0c6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ssstc.com; dmarc=pass action=none header.from=ssstc.com;
 dkim=pass header.d=ssstc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssstc.onmicrosoft.com; 
 s=selector1-ssstc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpeWBo5NgAxfOmlH8/BKOazO7ebAkeaVStbH+PQ2SZY=;
 b=JqBMP35qiLdpBdSGI7fUKqdLeKAcCQ/VkGXxxZJ3iJJWx9L0Y8Z+Hz0EiCjyW870ZdoZ9+MJ1G+369w/AUkiZdmKgqlIgWg1OR7m/dCIprHvPCVpIPOhdQUA4f/2Gqdscu4tZOB0I7bHvd6uQ/XDMn52FbdwSGLUH9bypvX4bjM=
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com (2603:1096:202:22::15)
 by HK0PR02MB2659.apcprd02.prod.outlook.com (2603:1096:203:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 29 Oct
 2020 03:21:27 +0000
Received: from HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e10b:73fd:962e:1968]) by HK2PR02MB4004.apcprd02.prod.outlook.com
 ([fe80::e10b:73fd:962e:1968%7]) with mapi id 15.20.3477.034; Thu, 29 Oct 2020
 03:21:27 +0000
From: Gloria Tsai <Gloria.Tsai@ssstc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Topic: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Thread-Index: AQHWrQrF3kKZ6Iwnv0+X+dwLEwfIxqmtQlQAgACXJlCAAAQaAIAAC86AgAABWuA=
Date: Thu, 29 Oct 2020 03:21:27 +0000
Message-ID: <HK2PR02MB4004E96D4FEF0589232CF694EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201028171726.GA9897@lst.de>
 <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
 <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
 <20201029031521.GC20928@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201029031521.GC20928@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Enabled=True;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SiteId=5715baf5-0afd-4dc3-a35d-166593a054fb;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Owner=Gloria.Tsai@ssstc.com;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_SetDate=2020-10-29T03:20:58.2594447Z;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Name=Public;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_ActionId=057d77f0-f413-41a2-b7fe-bbe9eabb9a5d;
 MSIP_Label_70000674-648a-490a-aff3-4c9f8463df7a_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ssstc.com;
x-originating-ip: [124.219.110.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa724b1-7d70-49cd-8094-08d87bb9b906
x-ms-traffictypediagnostic: HK0PR02MB2659:
x-microsoft-antispam-prvs: <HK0PR02MB2659AF6B16267CF81D1FC258EE140@HK0PR02MB2659.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDH8fuqtby8V4brzlwtAjvvB/1L5Hs1/eFr4tkL8KDnsB9Ilc9vdULY/YtPP7S+gC1k3IYH0qLg0RptL5NItWvs8Zc+4oXOmLhHf5aY/JROo8wqsx3G+H6KPFalcUBC8nNC9NQwwqPYhh3Y625m97soh94AHO31580T/PCjUkmVB9UhOqGMk+VAIw8A0oIsccYNM9K2BO1hrxml2WpgHBW/iDQH6qanPToPuL73BxiSOFis1tIjeB7iGZjLMpYroH1sUlD2ZWKrRU8ClSZufnu/oKNmcg53qaXLsB6tntUJL90NgJc5CPDH0zB2mw1IhB0jU7zX8XyFdfEyp/KfVmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR02MB4004.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(136003)(366004)(39840400004)(396003)(86362001)(8676002)(83380400001)(478600001)(71200400001)(7416002)(55016002)(7696005)(6916009)(66476007)(33656002)(66946007)(64756008)(66556008)(186003)(316002)(2906002)(6506007)(54906003)(9686003)(4326008)(76116006)(26005)(8936002)(5660300002)(55236004)(66446008)(53546011)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: hddDyKMi4mT9NvcjSlFinQfu9vjpAVgjSlFCy6kqXkeBNmGZN93gO4mqvLqvwJsqeZimIsGCvMkHoxHmHW4IHpTsjMZMzUZOkf/RMMLJBVDfHOPDIz4dtjOAXRJFfwo0BEbb+bTsaGmWZE74dg9VdnwqqRVAA9o/n6eEAFDjsOTUCL5PWVykBXFe88ubBGo4E/TcSACj5ERYybKHWJLBDlUz9dR26I/XeWHpk3QDA2lRx/9D0SzWRoKsJK0I8trgSmKjiFZ3J5YQTZ7RmzrdTj4n5GvyYh8ad63lkfKdlCdzuC5ttueotIkVxv2khzCQ4//9B8vecUNXlmgfuRanrRbNoHt4GmoCoTCc5yX3lRqpOBAx/EITuHBWXAA4LrUFrs8T0i4J1gQXu6gnUkbj37NMBweT5cYmnU5h3TmsorM/cZrxEYuJUUKraqcVRk3oCgmC3JSJUvh93EgBTArKr3HRsk1EEyx4PrNoFVKkA3Ckp1Pz6mcC6o5QQTlqCrr+IyFltFg3jH93OxDw+3croVFAl+jK187LtEmKxJrMwY+zyCoOq/3F5k5hi0HCFYmDjlzrfBo7ImTqGHjWuN2n7MBAlmHJ8GPlpmva+FW/AEVZWtDM54M/RP9xxlVPeuYM1zX+e/0pmVKemloKxiCnjw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ssstc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4004.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa724b1-7d70-49cd-8094-08d87bb9b906
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 03:21:27.5802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5715baf5-0afd-4dc3-a35d-166593a054fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muElmKMhNWQF1JpS4obxoI8bpxIxkRMb7gRP7P8LTGe2O1HXToTFZ+g6psnzaM3PMeVSjO9zyqK8NGM6wht5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_232135_539369_AC1FD466 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: Jongpil Jung <jongpuls@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>,
 "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
 "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Correct, it's device SRAM.


Regards,
Gloria Tsai
_____________________________________

Sales PM Division
Solid State Storage Technology Corporation
TEL: +886-3-612-3888 ext. 2201
E-Mail: gloria.tsai@ssstc.com
_____________________________________

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Thursday, October 29, 2020 11:15 AM
To: Gloria Tsai <Gloria.Tsai@ssstc.com>
Cc: Jongpil Jung <jongpuls@gmail.com>; Sagi Grimberg <sagi@grimberg.me>; linux-kernel@vger.kernel.org; linux-nvme@lists.infradead.org; Jens Axboe <axboe@fb.com>; dj54.sohn@samsung.com; jongpil19.jung@samsung.com; jongheony.kim@samsung.com; Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW 220TQ,22001



This message was sent from outside of the company. Please do not click links or open attachments unless you recognize the source of this email and know the content is safe.


On Thu, Oct 29, 2020 at 11:33:06AM +0900, Keith Busch wrote:
> On Thu, Oct 29, 2020 at 02:20:27AM +0000, Gloria Tsai wrote:
> > Corrected the description of this bug that SSD will not do GC after receiving shutdown cmd.
> > Do GC before shutdown -> delete IO Q -> shutdown from host -> 
> > breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use 
> > wrong pointer on device SRAM -> over program
>
> What do you mean by "wrong pointer"? At the place in the sequence 
> you're referring to, the PCI BME is disabled: you can't access *any* 
> host RAM, so there's no "correct" pointer either.

Re-reading your message, I do see you said "device" rather than "host", so my response may not be relevant.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
