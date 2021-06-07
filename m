Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3FEC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:59:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5304A6102A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5304A6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=9I1oZd0Ud6Y50yS7dG8tTyTL3y8lnrr19wgck47mJzI=; b=bbFN4tbeDggVEL
	s44yBmSTVXLDrWv2/rtsw8PSXEeUPdWHktymMg2SZE5QB9kzoDX1A6SoVhoCk/TJ2hLBAfIB2AqpP
	sqAl9KDlvKw7BBHTpVc58sUrf/vRw92FAmbdk22xGsyquSBt1J1FRQ6GSiOhWgBsVz06KXCbcXi+6
	csMmdfuCmv9A+gKQoFN+t1nOGBe0fEZ3pLdma0IaovnI+0gcBKFZ4DcpFY9lY3vp2TFm1OMvKT6Lg
	RER60MTzVOfQXyQ73iRPQnL+oqguiz3/cawadKXeRjaznWKFzMbCHgMT1Y2TSgnEGzkwXsbn68MXQ
	H/Ja8Kkaz70w0UuMRSSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLPH-005EUj-2s; Mon, 07 Jun 2021 19:59:31 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLPD-005ETe-E2
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095966; x=1654631966;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=M6e7s+iSIycNavR3jW9hknMfLGtW2/jkJ2JftxI3rnA=;
 b=jC0lWs86hXVCLT7ttj3wEptH0ymbvHs0Re8wWWI7NunZR9y6ayToaESL
 R29If0ounCIHw0GTTP33Gcho9Xs9npFlZW6h4mhxzijUMyZMCRAV4eW72
 Eu7R2d5L8k6wFbfNyIL3hfJLfYJy63JI58teRgyOS+QqN1+FRrySLv+Ap
 A3qXeGMdxZgTFguaiSWPnOQ8AGeiFAqTedW5qLRHFosu2ppkO7jxa2rRG
 VGtM3snzeslHPOOJh9gz+VdTKOCy0xoD5Hxjkvx/DHlqnnTmIhkPpP0Bx
 Exvj9/Zf02pU1jnqskHIcqHGaUIy1dwOABDU5rdr47l+lvZjanTp1mlgj Q==;
IronPort-SDR: ihlf3iShG32gp64z4V+sfL/bf9P+rraZ8Ck8Eov4rz9bM7kkTFSwzM0Nk9dTNEhi3xIGx0uA68
 LEoSZidUXb9suKI7jTCqPObq6NqTuUCBDImFsOJViQMJ9V8He7O6Q63qBhuu655e1QlZRS3Ixm
 Qty6zBL2/ZMZTOrg18ffobgBeIvGXWtoQ7Q0qzyXEXYt8ebJS1hIqtm31a89/502D0BMakPlCZ
 73WAQ2rpZg+gEu3Z0gRfM1iiqq4+5TlhaidBxFfcMaQRX7DqC8g3txDQz7JEHGFK87VTbJn75J
 Mpk=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="175810936"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6fYn4+zfAyX+pW4wPSgkvmE2jvj0ckL6lXpMQufl/TSH27rHMyCRIB20/dqD4LNaBFMWVRhY3QrN1VNguYr8+aQFNmXijKwmx+pEMPTROgFAg5fGC103uOB607Z0bkuyQsu+TfI/DOpZlSxEqfiE9utp5Gc/NxH3ggTD0oIhkGihRAzU/7CAMgSvYl7gQ5MTc7GK8LEv2HQOFfYNzTmpHIVDFK7u2KNKk28WkNEoyK/trFwjfjO8MRHoOgV3bAtb0G8a14Km+u6JcAwOjQPk/udIxgWft9rGPUc2FiAxP47jDAO1rEnEaGhosXi+lhphwMee7ct4pzDUC8sVgdULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6e7s+iSIycNavR3jW9hknMfLGtW2/jkJ2JftxI3rnA=;
 b=SF1O/DEeiMN/lHfF/WVV6H8s9Uxf/wm0IsXLwbpTrhbXGy3e//8RigJGg2Tr0Z11tiScIQ3XYqjRQt0JQrWvtwk9WK574v0Vpn49gYLlLt+D2rWssdsbpcelZfTqw7X5LoTqRLzIIVUBVRNzNxBU/NsA0ta0x7Z3UNVvNYtMPJUWIlbBTDcKVrIIHW1Pf+z2cFDSm/hGe0B4ExlrMugH7ajU8oAW+gVOcmiTY+/kAOiKphX7/SVGIfiEeJiuT1oanGMr0yx/eHtgeYBnDg4MRBew6//y2betqZWWCSpjScA2s71sIoz6pK+A1M/n7JQWPfAP6+nmciJUEBoNj/h2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6e7s+iSIycNavR3jW9hknMfLGtW2/jkJ2JftxI3rnA=;
 b=GqvwddCXppr+USA/cUG2Dnb6LiYwGUXmgjvCrPnjy+NoNMKX0QuLW3NBrmyXIrS/Eorq2OQtBgQO4InyvCh/Vml7YOa7MQyGbeyYR91D8Y701D9ouWlpHyRiDnfsdZrrsCBi4eum9EJD2SiQ7I1/s+0heL8r5pFxArLAxEodYnE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5894.namprd04.prod.outlook.com (2603:10b6:a03:109::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 19:59:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:59:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "ngottlieb@nvidia.com" <ngottlieb@nvidia.com>, "oren@nvidia.com"
 <oren@nvidia.com>
Subject: Re: [PATCH v2 1/4] nvmet: change sn size and check validity
Thread-Topic: [PATCH v2 1/4] nvmet: change sn size and check validity
Thread-Index: AQHXW37KWH7lZNawpEGEdJ1+FcQyJA==
Date: Mon, 7 Jun 2021 19:59:24 +0000
Message-ID: <BYAPR04MB4965541CEAEB7DDD129D497386389@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b0ff67d-30dd-4c6f-dd79-08d929eebfa9
x-ms-traffictypediagnostic: BYAPR04MB5894:
x-microsoft-antispam-prvs: <BYAPR04MB5894B2C001D713759AC153B486389@BYAPR04MB5894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E811qibaquw0JcuhUsMIA42eYuCxQqVLhFVy+0zV36uWIiD6Pke9xzy+qjPskMhxLglyd5AnD6IamfsLVVC3SVANGeygot/lsgULZRw5odHWMwFrEh+vp3kvR0cOmTYhBADjRef/h/ZrGJ/hcpWlnQYHCXwZrMcRncJ9G9o6NHWptelPGgPoAFbrTfBNxGuoqVCgNrXcKfLOq8oArqGd8PIKal9khyL1rb4nXpHOtyg/7Ym0oByZaQg9pSSQD4wvORbKHF0NIng2SvpMTXPHvuhP0HwtNz+2ghY1GhqTHulrWtS1DMUgHK+Sr+R4Cp5AP0v94Z4Bj4K1IFCpLH3ikYYYgPs3IbaJwHnHc5PEaFhHTw09rz6yCRrqDAQi3xpD8ipt8A68b7wffjQBhU/P/6dsUoPZ9ggV+zK+U2Ak1IBfEQnOYfNfBFIIZ3zN1oZ4PrwVMA53JDnqQleubWklv60aG2DOw7l1mEJ69k+yKgKX97Mww5ESLzMi41NoX1TaHy4vvNeQ/sl3R7UZMSqhYk7H/KyfXQNjS5Zd7BD0TCfsFi0sbun6JuR0Sas7UjdaSQp70HFKArAJB7Y4msvWTv5ryN6aBieNaoG3VID2zdc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(83380400001)(316002)(9686003)(76116006)(110136005)(38100700002)(186003)(4326008)(66946007)(64756008)(122000001)(5660300002)(4744005)(71200400001)(54906003)(33656002)(8936002)(7696005)(8676002)(53546011)(52536014)(6506007)(2906002)(26005)(66476007)(478600001)(55016002)(66446008)(86362001)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xV7wHLzMklRTx8Hhjg8A7aCkZJohR6Z2yU4KTCK/+iilofzixWhAvdfmJCkd?=
 =?us-ascii?Q?KDZbdfAAGj47Akahlu5a4PxYfsqV06FwgtJ/92+nzG4YZdWn2upkR2diiJgW?=
 =?us-ascii?Q?Gfcie4w3+eJb7bL2Na/runf1R8oz5vJw5kpHB3Vf0x2NmxQRM1ol+Z1Crhnu?=
 =?us-ascii?Q?1AKf8LCzf/dnYXknaOWmy3hVgZmuzrd4t5WUUGD4KKiyXLufIxc1Cg4BjXOt?=
 =?us-ascii?Q?mxCXIfu5NTURhUoHi6TRThx+lEUZcazrqFPbLvkq4grcjRe23NyKiiARnpFP?=
 =?us-ascii?Q?Rlc6UhIqE+8Auu6bXaJC3B4rJy+WMHuyB265Q76dCabAIV8jylh0TweI587q?=
 =?us-ascii?Q?O2bfTFFE/VyuXl4MyEl4HPu1XmDHjKRQdHZbX3LZQfNGywynfE4Yv9GTY7Mx?=
 =?us-ascii?Q?CSDDqXrBImxjp39Hguulz1YEwFZQRFYxSV9HlxdEaj1kcOyKLyHlgX4xjGSg?=
 =?us-ascii?Q?ArnI33g/AEH2kFd2Udk31cvms8wW1PMhxvWxFihG8UwraT1+0Ge/5lnoYyHD?=
 =?us-ascii?Q?lV6wxG9t6HUG6nAqstblu7Vk4LMwbq8oU2UapJFFYSQBvT4OLmXsieMnUjAS?=
 =?us-ascii?Q?lmGsQ2wPQWZNuoFB1Zb+9yNWTTZiftmNCOR8YuJBKYW8gDu4h+zQvjHSj7SJ?=
 =?us-ascii?Q?rmbwrC8eo2WxMIkxrIsiObzFXafgZ9q8Jwpbl3NxcHHJWVADw/g/rKmj9wjV?=
 =?us-ascii?Q?+borRov2WhsL1p4ZQuRbVWZhPVly+j7jED3lvY4FERTM5AK8Xz/FvT+ydhsc?=
 =?us-ascii?Q?rXyZ9TvXNlZ3f2FOlAGlTCzSd810hC83D6RTVVONRGTLXprT8+Isc7lMksHe?=
 =?us-ascii?Q?Czrharsvy4J36vvsw4H11EETY3FfEvYaFStiYlTM3AbM1KyJ6UhC4kHlFxBi?=
 =?us-ascii?Q?VL7Yn06tD5H7D1F7xxwm+uDcCZQWonw49IO7yJIhALMNUwQOJRJ4Bjg39xre?=
 =?us-ascii?Q?hD5KMeWwDsK5oBgQv1mH8m13EeUZqwXARMvu2ggdcARcQtS9O94Niwtz0ugR?=
 =?us-ascii?Q?dsK8mPp1pdenFWZzSn/ZubCR6UFeIGNrEwDyh8+i7V12vHrpKOWtYysN61NA?=
 =?us-ascii?Q?BGl3oxVlwAYukKb0+zjkjwk4rrZdK919dTeSrM1ICPfoDNxO7vn7gfz9q6G9?=
 =?us-ascii?Q?esP4GNQzjqn3rr3by+MlyccGBdFDIfJThXDHLjPZHNoHjJdsTrFE/lEtr/aF?=
 =?us-ascii?Q?Bm5cUFv+KN+6634lbR3OmjwdidFnclz+aofNL3gvWCsPnSsLx/wWaCdqO3yB?=
 =?us-ascii?Q?IPdY93VqrarVEjn7fff7Yz47jPzDrNlhAVWAqSbmVmVDdnf0oUCIjJvl9uC7?=
 =?us-ascii?Q?h+Kqrg0yE7q4j0KVPV22dULk?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ff67d-30dd-4c6f-dd79-08d929eebfa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 19:59:24.2802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejC48t1DwnK/Nq5Vk/HmBddDr9QuPwlM3mx84M1ricIFruA8Gj8KoKYy6BWrpU7P2jD27kbcohkUevZgjdtEpwyZGF5PIB4Q2AdzTnntTy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5894
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125927_571706_58C56D35 
X-CRM114-Status: GOOD (  11.57  )
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

On 6/7/21 02:23, Max Gurtovoy wrote:
> From: Noam Gottlieb <ngottlieb@nvidia.com>
>
> According to the NVM specification, the serial_number should be 20 bytes
> (bytes 23:04 of the Identify Controller data structure), and should
> contain only ASCII characters.
>
> In accordance, the serial_number size is changed to 20 bytes and before
> any attempt to store a new value in serial_number we check that the
> input is valid - i.e. contains only ASCII characters, is not empty and
> does not exceed 20 bytes.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
