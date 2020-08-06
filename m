Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DDEC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:29:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5450C2177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gN1e8ph0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="anPYaSdv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ns4SqfnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5450C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=PGjjpLTMbQoNCn99qs8Ekq/WbuXLka5on0OB5FIaUH8=; b=gN1e8ph0vvQ1Wi+RyJNbLSaB+
	0glOkLvJyRgwybQmz+d7dZal67Q9rrj3+yKY2ZX4/KYUEFUdSP4eI75QbQ89XplDsH02um7vHe+lS
	9VY81XMFB3DsSfy1aYzRH59qYjU09Q5paSMRPbfmlJuNb1nUHd/OSV8hSDXJMO+nhkCrHd6tAhl5W
	VD4awK/b9G5gA59TnlM88DwarMLUNMbtFavRmBvXugB4g45SlqPnNhDRyjj/Lg4oxLWNHjVej5UWB
	fG82n4fS23dSkfp5WbWNrUdTi3KdMJxaHtUTDTvN12NBqYUXeimIuEilroh2E75OChDXdkNvyK4er
	xB1Z9LmzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lZq-0005Cn-Bb; Thu, 06 Aug 2020 19:29:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lZn-0005Bt-Ff
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:29:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596742174; x=1628278174;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=90O1mttmNtqGYZ5bAISKTTEyjFeLKSFg8SwbEgsQKP0=;
 b=anPYaSdvpv5/h5IEk+KqJ6aEt3fOrG615oZ10FouHMRwpF+DNA8zhMQ7
 QoSp9IWR84KNgIRJwGL6HNUQnK+02EWZGNMFdF96ND0GX2yZJIhP4ehWQ
 LhZR3PwgObLrD4zAaAutrQu3oKsPjviBKNdBkozSqzoIBSrgqyzDdZgUF
 hG+vL8LTxy63/L1u0RY8oOZGaZIBp7bjUq2YnLpi/AMVbyhoqFsBb+Ymr
 IFHPbikGE4mwWhrr0gGB+dMMNJe5LCRq4oKidTUEpSi7Vug++x/WNx71M
 97Z7qSQQULxiWDNOfibe8Ma3na66FQ4xMYCjnY9RQztGTSHXr0C07S66V w==;
IronPort-SDR: dBEmfya5hMa0UPNG+MKy6iPr73DGz8aSWl4+MG5L/FE4E36V74PBSSHhN6nLClPgqu66cDgoDx
 fqiB+wIHmZdNYIp9AQPmfMFEKoBWUTKi326TN2BIgyXRYhQFcZc9EoiYE/GtLXpWFNLLlx/BPS
 P0ueNBmRpdupGjDVIpZJSSGrgqv1K88yAxbMlZ/CyT/eZpQ7Ef4QgeQVq5qXmeOsp4VMoVnDjO
 nc/tf64mASKMCVUe4nAyZmsR6GZ2pMVjziSVL3UDi/KvFRmjsS/YeMmGmrWfNECAD+szhr0S/8
 MlY=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="247434320"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 03:29:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKp1dF36xsE5EeTFFM0f1ZI+/C/C1iLAiFDX2o2x/On2xqehWRpzlRS2YA3z2oELmu2lCqG6P79VS+/21mEe1pGw/bDbL0s2OtCU/eH/TzZFxSHrK3sicOfaohHxo6u2M5y36zMx3pwGXABXnBLtaSLIB0rdmxhbXHwgR7o2EgGj1XIpN1mV7zcZx7fXQhSUpenF3miqWoXrzrDlZ216ccs9bnVihO+TxOE6Kzv3RWjF6nPUg6qKJlFySRd43ZO8yacwUv1+ZSmvw5fm3dThfekqkzIyVnSCb58WdlU5adfIw5kas2Ij7aG1ubGZO/8mG+D6AqvLtk3HNdCAZCNeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUPhpBHQc35GJIK/+vmoF8dV6yv85N3S9YMlazv7tIM=;
 b=ishLY6UwX06LOYCKi/lfme8LT+xvUeY+tXcq3RbrCUlpONCwd9LPtW3f7gP2BZEC1JZ4MRbrTaCkLBrJ4BDvGYKRdtGvmQJUgX914RcaetjxYjqufKBpooU87SXjjkph9u1kIaJwlqGSwkwGQPDJRXvsEwNyPyj9xTzJ9euH452CE4g9LBsNY8OBbK7c3pn2lB4i0RQ/wZcuH/MTDhLO3pq9IkDqg92ce9Y6Y2xRUltGpKdEtchuaTYYAZFUprvHMEG1g5p4UgOUIVO3eGYvoKbjmYzAJCF+tRIYnEnz2vFZwCzLNb1Y5/P8aLX9M7UEsaCCdxiBK3Wh9zerJPEkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUPhpBHQc35GJIK/+vmoF8dV6yv85N3S9YMlazv7tIM=;
 b=Ns4SqfnZYXT4MDbNA494AV47hAjLcR8X647/2v5MGu+PUIiCFwGMgOd8r8MFeef0wuNJ7klKzsw4/w3/ih4Ps6mMLWqXpcAyQQEFPRzdDPnQbTI9LS4NAPUWTFzlCq0Nf86lWs7PVNcGD54QUnkVdHrEp66+dXnFeF1CtTevSWY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3957.namprd04.prod.outlook.com (2603:10b6:a02:af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:29:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 19:29:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 19:29:14 +0000
Message-ID: <BYAPR04MB49656ED3D29D82B52624F2AB86480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db1f66d4-65c3-49d2-8e1e-08d83a3f0104
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-microsoft-antispam-prvs: <BYAPR04MB395730E8275070739B8375A286480@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cI0gs+8bW9uLYvgANarPwLco4Yqn2wU46Aimu4+JDKfggyeY6aYoEP98Rxg9/Xw+ZWBSZB7j+U6aMyCJOqxrVnovYBQS6C1Nh/c/wb4aG+BVHbnSx5auBph6t1pSYL/gWbFU3mOxW4Peyf4P4vXzSMaU6rZBEZ1N64qei8HokeVNJERIXQ5kGFwr8DWEozmI2A56cdBSZiALihJw3BN4jbow+eeGdeRVifc6gcJ61Z16TLEuasDRg56shrdCeZ5VmAx4DghXoN2twSSu37OnBVH6PDxdto3+PKFDUDj0ArOpPfIctlu12WDWrrSC0bI7sLq1JMt2g9lnixojcNTT5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(7696005)(4744005)(8936002)(316002)(66946007)(66446008)(86362001)(33656002)(64756008)(66556008)(83380400001)(9686003)(66476007)(478600001)(6916009)(54906003)(55016002)(2906002)(186003)(76116006)(26005)(71200400001)(4326008)(52536014)(5660300002)(53546011)(6506007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eZOZWOgerqgkfupZDN1kyVRa5zVLlJ5ZYzyFLmb41s0klY/Y284RWeYh9XoEcywX6+oTZsi5i0kqzNRb1hVjCEJgvTAVrwuNSo0gldic8dklLf6Y7OIAozbB5EdJ4i13Anm30OwETxdAwWEkT7y+fah00R3KeXqhN1Fjq2qKBaKB31YaOS+V38WtLr0cuRc5YaEcRYELMt4H93aPbrjj7Qotr6m+t5Uvu3df2CewOsUXt41TKtl+8QdTmucRCF+isV6DUxSDA+YaRmYRQHzwljXpm+VcBMyD0445cYUxMU8hjAEkcAaFbWN8VXHRDJKa2526QKSKrnjHO97cAg/biW6cJaHplnYo5w46lWj+Ayxk9HjvRTNz+OeuWBAtGg7HVwWWyfjFnsLztjXb6n7tYVUlx+Yosk00Qr3C8JVYu0FNCnVDqFFwnrqY/28V7aT88PPANl9VYDmcNucV5kZZoPq5XjAkZd7WONoIXakSWTs8QnpC5a9bDfHjB4qQouVcbsBoRfcYwZYFTr2b219UsD6ehLniBwSXNMp6rmbHHKRfyXtG38S+RRZWTwZbzWCmVtNdayajxYkahqKBuFTziRWzfzhWdpCCU8U1xEg6rNdDu9nAwrTmDrL+sArTEdwgVJ1ftROkcrzr2FTMmEMHUg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1f66d4-65c3-49d2-8e1e-08d83a3f0104
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 19:29:14.6691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryFu5dMTQTwukDz5kJ3WnK6Mtjg2EShl3O8AH5zBNLkswRy4EfZ3kYs9JHKz2x8S27ZYBLYyl2hoiutgGhYUVbXz8fgGPE9TtS9sRKCyoA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_152919_779980_8B166B2B 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 8:43 AM, Keith Busch wrote:
> On Thu, Aug 06, 2020 at 12:31:50AM -0700, Chaitanya Kulkarni wrote:
>> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
>> following Oops :-
> Suggested changelog:
> 
>    A passthrough request may be NULL if an invalid namespace is used, or
>    if the allocation failed. Check for a valid request before releasing
>    it to fix a NULL pointer dereference.
> 
Okay, will send V2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
