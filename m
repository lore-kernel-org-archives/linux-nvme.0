Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C657C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:01:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66CF20734
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3F9Uw4B7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iUdyISvO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d8aZfw3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66CF20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XYPAoWMpUlRDK+Uh7bvmiLlkCEWeGZ3lkL/F6FWN/EA=; b=3F9Uw4B7cEQhNx5v/vfxlsqrm
	1YtO4CzMPjyJJXbmwz4a/1vwiNcwQ0fuIyzwZD3qL7dng3hnLrA22vHZmHV6Q7BfzacuWRNWA+/s+
	1BL8KpVdqYvm0oSU0KA8/6Wnu3lVR2QrcvN7A4WMGapll5f+k2mAS4Y1ohgmTUNYGeTRwxKXEok9S
	P2ABjkwckuxslCiVQHk2JNy6fjqt221kSCrL37Fuk0umDXFyfv27AuiPT+qqVx9k6dJ/o24bgbI68
	sAfy10cacCY69A4NmG7RGseFN6ttoTA2P/WotYVX3vmpceNZYBvepfVvNXGAmzf2cSiayujfFrALK
	TeNLBdy9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gmt-0007Js-OB; Mon, 10 Aug 2020 23:01:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Gmo-0007IO-2B
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:01:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100457; x=1628636457;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IDufa/kupG8yii5653CgWxzi7KhaPfw/wbJwlwfOVN8=;
 b=iUdyISvO5WWJBNJUBbIJLtsrDzyNTtC3hidAjjel4vh9tpM3xL+xQ5Wn
 g/j0kT/PNjHKSq3TgV+5B6joUEKw+APJ9keziY7X82zYReCgOsn3KBJI9
 9Jv4eI5syYprAiU4qGZd5IrqSzJF0Z1SZtHIAFErJmnqzSWI8wkoMFwsk
 FW/XhM9ozrXxYu9YTBAiqmWXqbL58dJvw6K2IJNIR9pHa/qACrp7IGygS
 Lzd8IpVBOeue27S4Eip+tdrOXIe0yTgXllGLR455Rw67KG7x9zRw8JRIy
 GU/VhXipXCXMEHk4sF7tRPGGmZ+uenAR1Rd533DbI9kglD/+CpPGlVqhR g==;
IronPort-SDR: eRA+229xTht0g2za4me5ZeqEyzOXfqJl3mPvRMjVPHAqesJo+wJVfd5EFmoQjr4QqqaNfcYaKb
 5Lb6mKbX0V/OJxb21KZePlqQb6BlwUo9UQpc6JXfVDhvJ1P2d2NRjrp1s/N+lyyTOtFEZ9GWFp
 hiFnEVtHr7RZJC1RwFBtbrG0JXG4/UYpg4BEgeSnjBQ2SPnSYrFk8ZiuW7K/t+pNc9GI8ccvUy
 06rl+rGXOD2+AJnIM0F3aHX2lWl4VfU16bHxgd7XuVLaNMRzUhp2JjdojlxjbtwYM5MDMlkdVK
 XaQ=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144615720"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:00:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU/vUjWYVGo54zipC/9DtdLL47hKevhQRPA0iNXGIpeugjEx/de3rxA7bBfViT33rqR5wkW7dqmKv9fQnC5yTALh5DDuRyCQkvcoHYN2sUXKYjp1DiQwMbXWheVw/IeVqR2TYaeh+KyPpCkLAvg9lzgwA8uY3OhJpHEhEYwJj3G2v2E3RS4wKiYh3Ok6ww3cqJiB+tbYXVrf1Uv0Me8PmWdf9IiQCcCX7VLmjljsocJpR2VU3z1qjgI6IaVGCeKDkddtu8MSAqChHJQ/hi/5PNkzuT44n/DA1V0crT0zZ94oqGwnY5WDQDeW9kUtC4m21PqUTzvzOcu4IdqoRruLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDufa/kupG8yii5653CgWxzi7KhaPfw/wbJwlwfOVN8=;
 b=KYyRczWGgPzHt2zjOGm+5vh8LHbp29Ps1VQFiZilupmaXAaxfQkc+RPBSwHxRJBnJMmFVLIouDJI/3rxONh19t+fdqspOeYblbxrhw4RPVwO9JUZ+vgkbHwcSWMLgW2CuNrqoa3RJi8ScYwSk4AjH5SkD2cggZ6jnbyXhg6a39wIgxT+RtI3brKM/8CSoekMGXqn6eXswowTACpkK0GcvCqU4IBwlMeckQYdpjK8fJhj27f11he0MiDqCIWCFksEHfbKLZI4ahPuBTEE9ZtCfDe3DYrw/L4GD/bbS86SvB5j+AFqgJaWVo3oG8BnutHk5BXdVKTLCJiXEsu7ST8Q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDufa/kupG8yii5653CgWxzi7KhaPfw/wbJwlwfOVN8=;
 b=d8aZfw3ZL6KDECtg9qSJnO228ySDQzhsTO3Zg+kdlsn3BDDbZLNFbq5OvfMSRAGY3HwNpOB2c59r/sBRWxe08XYMhyBq6GUafxQObUVrUf38I4aw2evFB1ztqZbsY5bTlhj2EkNNdJpLQwF52ZlTWeV9sR6N6KbmPKUtf1XUowM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 23:00:55 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:00:55 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 05/14] nvmet: get rid of the extra variable
Thread-Topic: [PATCH 05/14] nvmet: get rid of the extra variable
Thread-Index: AQHWb0fa+VhsrXoTJU+QgSwrikKDHw==
Date: Mon, 10 Aug 2020 23:00:55 +0000
Message-ID: <BYAPR04MB496523DC21401582BE98753C86440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
 <f7dfd268-9b02-4711-85d4-eebd8614f8d8@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b88b9f9-909d-4b75-efc4-08d83d813d1b
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB52556994039322CEC579327886440@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZuSotV3DWMLVESefezVY/4fpIBWMuHrz4WTQKcqRjUUH8HafyWx8euRWWuyVWz0J7r/O8SOvw0WSmxFy+g8X0bs871uiLSE2y6u2PgSozSkWfdS6IDGpydwnNe/WOLYsFk8lCTC0t9CLWz63MgWlN60fWcHrUw9lCz81NWM3Ztrv6l6S6Zq1p3f29cuW3/R1Th3djqzZcgfMu5bXJZexxJ/i+0xplDA2ZoIcdMIGjZI1w2d5i9+KNkjBWCrnVl2LgeWKWWzARi7KjcyU1URPLhssntNX20uDEzAeSudkXRnNZLpTxZsgVHjClgEjokZ1BTzJu8O0476drXGh09XjKAHCyFGmnYk02jahp75WXjNLsBRqzfNc/5SrWMQUXF0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(5660300002)(4326008)(55016002)(8676002)(186003)(478600001)(53546011)(6506007)(86362001)(2906002)(26005)(33656002)(52536014)(7696005)(66556008)(66446008)(66476007)(9686003)(4744005)(71200400001)(66946007)(8936002)(64756008)(76116006)(54906003)(110136005)(316002)(26583001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eb2nyVcWnkozNlt04O4xYb6O3xKXVbusVHMg7M2aAsG1YeNnjWVjq1cgh7t5JucRuhWz6RxPkiq+XqAl0AXfEq6hQZbFCZfRpMj9NR05mte4gqiUFfhrS+c+/17YrSkkwX3+GTySRxbjW1wWE0OrvV+Ffub0fMhmmeCVQ1j5B9Dp35sN/Vp9RVDDjFl+3keg7R2ICTAfjTluKYv286qjZARkhzJw253s8ce4P/3cPvvm3Sf/H6wvV1HsOyYQWweHE5Zw+X4PsuIQYHGZ6LstGKdOqQI2oZ29tD3wPPL1wqkv5BTsEziO05i3hehI7p+k5wyXsuffwEHsNom2kWQQMrqAK/Wr1wt6M3dSGhhz83OmtsDRqCD47gEHIpkaWiyRtYTWO5cRrru+yTd5FyrWgv2vHjBrRSWj0TQwuDCiV/zzanzL9Q3WjscoW7XhqJposga4lgLYgY0CchEQO3qSSp1Z4YfwZqeagCOYh9TTe6/axoXwL2VcOpRoRosoCR4NLG9PkFWfHPRGGpfs+FGdMMTSdle+C2qFn5fJEQ+J1kGO1Zo0G3OHSV/NghCukIVkGsdyYp/14illycO2rG5H3xsxUg+objrDpFN/iyVQMv2umqkG4i5CnPtZMLa/C/kyGoK096sBo5AI9M8/y53MbA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b88b9f9-909d-4b75-efc4-08d83d813d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:00:55.7262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWqq0T3BAq68/8Pd0OWkVG1elXidtbe564fTQhFYzfJbhiOF23FtAA5+GWT7vg66kiE+MtgVCCWjVdEvk4VAllIHiCIyMacUnUOPlz1kXS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_190058_257453_6FDEF93C 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 14:58, Logan Gunthorpe wrote:
> IMO, that's really ugly and not at all an improvement.
> 
> Logan

&& operator is perfectly readable when use for short circuit two 
conditions, more than 2 or newline is what ugly not this one.

There are several places in kernel this pattern is present, if it
was ugly that code have never been accepted by the kernel standards.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
