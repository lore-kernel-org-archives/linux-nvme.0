Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4455C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 07:13:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3F9206D7
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0KUlDI4Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ub8Opj4x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PJJ6zOzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3F9206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=gQ/O5nEsM943n6GGPmAwMQcmYXtt6bGIHMQuu9Uk9Xc=; b=0KUlDI4QXqX1pempH+6ZrpG9IS
	QGC+pl/Gy3YNayJ+bcfcVneKJpoiVGFypwMi1jCxie3Bn9r3c9DxOleRpAAbVjo95uVnwf8yhsoQ5
	6lGPtEQ6DcdsrqCe9PJDpLnvCAf+jBmhiagQYphedW8tfhjxHBhWAx9euvqbyhADs8aX75hLrzeYy
	ckp+kD7Tn4wnp/OuV2702lsGxNPbeuv7LZ/D0VDlcmANb2XIp+F4dU8Nx7NUb8MdHT5+3B3hFdi0A
	bSKOcKUu2JqqZCks689qYM0M6kI92GMLrwX1AUKYi5QmzUJVD3xF42Cbx8k/nNEmLEinUlqpziUvy
	6A3J9YoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2Uf3-0007SK-UL; Mon, 03 Aug 2020 07:13:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2Uf1-0007Rh-7U
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 07:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596438808; x=1627974808;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ub8Opj4x3rlAInLWbgngCHU0lL/JL/j48kj8sL753Q9miXczTZYn60a/
 /neACgoBge8gi8wouZhQN0G0J17cDUftI+ZkOOmfKfMaGfM11CSWVRZUM
 Fe8kIM+Ma6aA+bDOr0SvmQL4veKdLYjjh+RyeOmANro3kIh+7KRgOz4Vo
 B6NqKmiJlTKlz9y+f9yd8CJ+AztSl5kxmm6wF4m/8XAEng7Z9t8ZrV80g
 Dk3imhAR6V4xRb56VcsQuTZ55HrspGf3Ym6LX5Uq3YHqRkyjaQaNTjMiE
 Cdvl3+lxK5DBUw9njGKpl1+Gn04h2VfVINheaRyVaL4U6F+vR0+DabYfa Q==;
IronPort-SDR: dhroqEuyp5MZ+buzoIsSq1fgannncsFKvbRDO/IN7HOJqm7sn57Somq1qSsiBUfRGt4ivf+aFG
 jNlDOwi6vbY52MeY5itIfFkrqxrxZOwWTMuK26FLczivSSLxgxaPdqbUAwF2EwOVf33SblSFyh
 v6IJcojQMpCC8QjsLdsa9Q9sY3qB5J0KofXkkLCUKeDCcFa9hWHaYINVOCjQISwuLmfHUXaLg5
 IO1fAsmp4wzwkkbnFpGMnFgvjpXNtWzNWFzhYTSrVcL3HvdHV+QS0JZCrYTzs/f99WH+3zjqrd
 Uo8=
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; d="scan'208";a="144068119"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2020 15:13:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbTPAjHmz/lar2H8kFKcnMYlQ6E2TvVqWVUh7kPoZLivkEeV2GqiMoS6ftqtSdacAulFMBefvyoJZCGB5q1djf7AlszIK5cmBqHRgE5SgMQCziVrF569e0FAXgbKl/hFEhtW7S9CfzUx+SA/oZK+fTEIiyhA7i1AtIHFncY8NWfSBoIZuCh56WgjzhnDZmhXsIfA5qDN6ClLyVtKSHgPbl3MsHuddyp/wBACC1FFg8Ir6vtnVGIRZ7hghkWLqtlX+lDWp9y/oNDZAMCmRpMrqvZmFgWIRo0Ln6rSxNDa7XmvcKWYKr3GFBeGQLyGUyiXa6MovdcLXicWzVJtCtrvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=l69MFOidKCl6bNPh2fkBeMP8yPvBQq5kj46flfbYhGbF8bV6c58aclGaIGHRIT45G609RyIsFXOrsfe05zeMj0yk4ON2qM2mWKLf5gMuoFepc4H6/WZYaJOHY1JDOpyHTpQqOlgUwCDmDl9VtS5J80IouRV4w7uE2H23dwLs8YonW60wqmdrH8hiyQJMucTZz6k6m/qfCwFQ/EGPuv4MlGiA4NSA6Qho4orwkfLbH+rcSddR2uJPdu6M6zWdOnSjgRI2s9tvofGGGkY1V91dufw7q++rQCdyuxfqUr23mmQHmtTWQe+qQYwpJGqQHxahehKh6iP/TXhgklY334R0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PJJ6zOzDRa43XwiN2ISqDSoJdnm5L8trFR8nYoRV1U2KIn1dhzcBAxVp/PEZJMv1P0zYEblgPnhGltibxnioGs88J8x3hl7mYisV9Th1K3hrI9KyjsyhV5Ok0OoLf0+ZFXC8PhrXax7oAleIrbXhCVvmCUobeiXamQENWq7leTc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 07:13:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:13:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Johannes Thumshirn
 <jthumshirn@suse.de>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH rfc 1/6] nvme: consolidate nvme requirements based on
 transport type
Thread-Topic: [PATCH rfc 1/6] nvme: consolidate nvme requirements based on
 transport type
Thread-Index: AQHWaWIq1FotgVHbLkmZ3HP5gW1Dhg==
Date: Mon, 3 Aug 2020 07:13:22 +0000
Message-ID: <SN4PR0401MB35985B07784F73DD9C27BC879B4D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b87b110b-086c-4c88-7dbc-08d8377cb558
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4464AB0B4B46114C5B7B7DFA9B4D0@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NA9fIq8pFKfrNRlFo3RX6WgMdJNH6z/r3+TySF3Nizw+PcS3PX7J0vgkdpIodKY1TB1rzo0wnaQBpDf1wHdI3obbsVA7tZi5sV0jZRujxD72jpColHZW7PNTTI7R0DTqOws/YhidufENs6ys7z9pw4TBRH7jYcxo1lMWq/z0XgdK2BvNT9T+7Q+z9Pz/l7bwWXxIqNNUa9PbJLzbPPmT82svQjxa4JEixIA5mhRpIrJKPaTLQTmeja9mJgTZ7AVP7nL4PMI3jQF2/+ZKBT085Y4xetsrJ9lBSzyvYuHdkud4fdYP83OSKc3USXo+6jFoJ579hbL0U92qB156GCsD+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66476007)(66556008)(66446008)(558084003)(64756008)(55016002)(8936002)(186003)(9686003)(76116006)(66946007)(6506007)(7696005)(71200400001)(4270600006)(33656002)(26005)(316002)(91956017)(2906002)(478600001)(8676002)(52536014)(86362001)(19618925003)(110136005)(6636002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3Jeij2Cg1z65Ct9Ju3vTPtSa9ez7PyBvuc5gEJCpkJmrerQPwRadupmzKRH3ZoPVAqnYOMTOTNoX2uY7Gq+/kJlz29C9k69v3e33Q/S0h3txFXO3JWRXovBuvRRMpl2bhIFZZkJX1XMRmelK5Ncey0SjUxoVaaBWI62gJelm6okk90PC+e20R3MQehFHFXa8slODAj0Ur8xPQCRYgF9z21eH3HsckTahGCBu7LDIgSmulv2S/peajX5i7Fkw4X8E6MkYgMqmfPmpOTIU/wvWGbaF/H2EJV6kJ8LbKwQMfTlpcvra9ddUDtqsEHxNzrbZ62BX+RRrr+LOoGQpAaFKlng2riqYhACNPKe2rtzlnLHggnNbMwMztXTwuOcltTfenkXLfDt1sI8XTdVfwBUqvBEFY4oNpNIVvyuC3q3nrnRo+s/c8eNxZDElOgOq5Z1ce9AhS6cl84JMEJoGSRIgA05dXZH6ak/KE7cqIicOJnsEbAUkmAH9yf4SzIrE3boGLc4G5C9hjZGkYyUhgqWh3UcNjc1ouSXmnKwj6NqnH9GrxTJql1vCuRzk8mi8Wi/miPbC0iZJUsA+yjog4G4yoRPQzt+DWq25wzIbDy/QOb7cgjrhdOFx0cNjjtGec/pr34htHCTH+tSvIwY+3Qv1nQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87b110b-086c-4c88-7dbc-08d8377cb558
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 07:13:23.0013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noTEhBAdKx5zNqPRiaACYKRTuvIXWa8emEOkqRkDDFStG51sKnVmVJCBqdT0s1Xv3jB5wNvfCC7HAsRdLi+gYtVXC+gLmq8AiejQrCqKPvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_031327_432878_31707B8E 
X-CRM114-Status: GOOD (  10.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
