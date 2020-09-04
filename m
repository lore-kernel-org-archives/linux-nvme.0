Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6676AC433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E722075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BokVoPNT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q3VQyCdO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d3o59m8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E722075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kMQpqS8FWNm8ye1MQdj8n+JCUUem8awAOejU8p7FRq4=; b=BokVoPNTKsVu5lM3zswFbYcZH
	crtA6Outtuk/Nnx60SVzmAHQKEyWVyVZRwWWqs294hxgkxXkeLo7Pghfvr5GwbKZPGjJVT/vb1nso
	HAkVgJguS6oZEQtzfEdrrk8gCWuRQxlaFsc456JvD6xAToNRckoyFk+7vQQBfdgoDoHcmlLuHTbIQ
	pWq6fI7X3ZGUGcJfLTZT+4VQ/po0ufznDTmxfiAuZUBaEXvHF+t0v0oKB6VDbU3ZtdFu4T+kBghYC
	VIlKAO4MxGkVtJetE8Ww9M6TF20y7DHPccwDaResQJuAZbnvv9wsyNNbWFoEQD79Z8hiANF0AoF4+
	3cJKsljwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzUU-0005QV-99; Fri, 04 Sep 2020 00:22:06 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzUP-0005OD-Po
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178944; x=1630714944;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pny6/xO9rk1Y7ijbTpDe+1T4D5bPDHAAETQ4jTX91Fo=;
 b=q3VQyCdOXzh40kt9tTwC2rSDavuzLLtIvvjt0QebDgQkSCI7uwH3OtB1
 Fk43INKw2RP4Km0x/D8pMQBnBK1feiupGJoSnxb8TcpOpJG3CPnGqnUSk
 ZhMm4UxRIo62o/ZXwdGV0RZcFK+mhx3a49MhJD4Wakeq3I5LSc1n3Jnwr
 fpk6zbKd2Xe4Vzk8xi5ROuwnF0d0Dck79dwAgm3OLJK+qvjeC0aTF2ipp
 Y4jLc+zGwzPVRb89mkzXTckHrI7/nVY9EWMI+PraRIVPqlt8nRTR94Zli
 U9yCG1j8aeAe6fOtZGiaHf2MKOOs+hKIFOphbq2rP+2sj0PNagJxr50d3 w==;
IronPort-SDR: 7M5WYDfCji3RkNmZuCYOUMohB3Iar/zATwKuJhn7oCl3IqFjF+KaRSszrhRIJn/RvHZXz70Ao9
 gHSpXK2DcjUB+0nhSLKpfBTjBBcPwGiIOaxxyw8tn1RYyiojDm3tSaxh9w8UKIqJS7ySABs1NT
 GcoIjVVCW3n2J9sbQXC12BvAmxKVsEJnMKEec+zVrIMMqQ37GOyy0jQnY7v69eeaM2XIwQjHFZ
 kdZpD9PFzX3O7DLglUsEEmEIsFxS3R9zvAPNZW5bRl9JnVm1Zzpjpa+4SL8yQBg8s+KzY8kWUJ
 6Ys=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="249814568"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:22:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6BXdqtdvv067s0mZPdiEwXylql0NZZpsAbdd34XsFbCrjriFwe7LbdKbh9QjzD9uNQhpw0uRRlnJWf8Qn1AuAJZvO1KRrfSMT43vHiBVLt26dSDbJTCZLAtw+ZhU3+Yfk93oNuaB1BOriUpEt0Ko+GmTcfkWqwYMN3jlb2ueStZ63+G5aiUsL31oG7ksr5gUSYy8jpQ1HAjxflMm8PYs97YTE1YZBLJRPmry1mtyHDREQazTwFCipRENfMiHlDTRE735DkPPf7OO/yFI0vZxSTgHKc6hA5Q2mIV1klTOt6PMB5y5+9bDeYvCcuuNN4oGI3xmeMM4+y3uCJWx1op9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pny6/xO9rk1Y7ijbTpDe+1T4D5bPDHAAETQ4jTX91Fo=;
 b=f7NThHKTB3TGdPrEqaczDerd/J7qzt5J91RtOrTFIgIxiHlTSmf1SmPp3h2CBy4j2/oYDc7quh6yf6slOXLqJb4eTzRrTGP2wb3LXQ62T1VG8akS9QLND+JIHt+Cwx5nZJTNjhQ6Hpuo1FGVwSjakE90NG1OsXI2ZuQWf6JCrnouYsQLbelh8UweLDI0FECBy6PPhmi5lESdTP52DwX1imw2+pdGHdeVVLQcuSgd8Dg7Uw31u7+dXv4b5MLP863v1Nz18kR29waP9277YwSsfUQ5ocqYEqg/Zq5ABKyYqfUReEqzmsrPZUBQxF4+CHKdqHexohkZHg5oy/rsjsFxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pny6/xO9rk1Y7ijbTpDe+1T4D5bPDHAAETQ4jTX91Fo=;
 b=d3o59m8w1OzpzeIDgJIBAzJfc8f4oDxVnkZfSGuhbKxiRAcjBdOhiDz/SYwdeQFF/5RxoVbi/iXz4gPJf2VrVPL25G6te+02A5JQqBsZjhAR2Ev+X7A1D9KsQP8w3+WpnD+vQUvZUq2cfMnzh8siidY2pAkFIP2TBsqC9Yxk11A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:21:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:21:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v7 5/7] nvme: support nvme-tcp when runinng tests
Thread-Topic: [PATCH v7 5/7] nvme: support nvme-tcp when runinng tests
Thread-Index: AQHWgk2HSKyRhGrswUCkxHtEt8ecMw==
Date: Fri, 4 Sep 2020 00:21:58 +0000
Message-ID: <BYAPR04MB4965FCC811A0EEF7345BEFA1862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 073acca1-4508-4218-2081-08d850688989
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB4424AD4C5B0035DC519FF789862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oB5uJ6kljoHJ3Cmf6/hR1f6KMyy2IbHfM0jNuy29PSUZQcbdNCw93sZBVcsYgm4iJ7U2POIr+r6EFQiB13SWBjc0sy6X852tArLBxRDOYB88MfdaqppKX1JN4udt74yYDsx994jNsoQUsDG4j6QCnk/35T394cx/AxkFrXHPBx+kB66ETMUrmcMmYNEiKaPtApQVx+eCf82Szi7hpef/0qm/Aok0ogYpzKXkk5eL1KEKIPAyEd/kfBddCsvDZgQtxf108WEQOfPvfIUP2xQFvNrNOG6hXZvzNSO7CniovJae7CtJZowvyuN6Sn7gy4uKELK+eUK+at2GztoXmbjLWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: lOgC5B0RnIYJNLv6NUa/uURzfmNC8EZwm/4kFu9xKO42LOmGD4noSN/kOOlXdq51/nmZSxJOiFjV3Wsvt24Ti60UjFOr96wFbfrfZRabyJhC3kafARXczEKuE41SJJEwRPz/dOlHNvKlkHwMej/71NXL+D7cf0uhNCIG0Z3JTDWvqqMjhMIAb7pOs3cdVzBmVk5/tBpXd9QRJsY//PzOWOEqvXXneKD2x8LIQZgARVHcPwaFDlmJ/Gb9UOK4pVn8vXuSA9Lz5FiInHu0mnIFlXV/XS3cPSk7SQ33qLlcxbmi4QceRpA8mNVhrWkLqPPu+yUlH5u+6TU6a4G0m9X5IxssLtjtOXl9iw6Vi1v7HTwBmUowfHsJ78Kz4s/agWqHz/YYCaBhkQxl+/lxMZNA3DG8KkcvEHaWGk6M5VTtlvJSfXhcpI4jz5RybMTjlb0IJZ02ImPCK6R+m6wFISDq6O9dMRq6St0dBZ8aJUH4tHi4XL2AdaWBXDjMEAyogakXQKgQXeXXeUspPwspEa1atpjNPVRtiG79hVhrENxn1WUDieXj0ULSx7UncIrHDtkMyPDrlgjrpejaaMmpptZ/Jipw4tcixi2R4aJGs4BXNPaxw2zCPlSsgl8nW59IEHwx0vYqxrq48rk4o6kS+drOKQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073acca1-4508-4218-2081-08d850688989
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:21:58.5262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klDPsBbtqLcW05QQVYPOlOt++QCf0LcX8HKwA8wMmh8dcdMGdpL17Nev4fXRSeHeHGZxOH+dpyRr8TWRruGR4RlCZ5sQn/rpyMmaHtEjxPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_202201_993273_9D7FC871 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 16:54, Sagi Grimberg wrote:
> run with: nvme_trtype=tcp ./check nvme
> 
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

Looks good.
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
