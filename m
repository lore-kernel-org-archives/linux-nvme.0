Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D51C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 05:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C32208C3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 05:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UmTNaLJ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pdDtv+ir";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WNmZTh7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C32208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hkbMz8kH1jRmvcbnMmSu/hfges4EH8hw2YLPUJ+ZwDQ=; b=UmTNaLJ9gMJy4x
	jL8RgN05M9heeVonB9yYe6QpiGdxfvSh2PWV7YCmElKu75snxzUVGeAttHZb5P3QDMWR4WVeM6aHk
	0+8lGCokYWzZNnh850uNyUjO5Uy7kx0roQqq3j/Zceb67VBRKlM3unIUwDK5n41p03+LJQWOjEQyj
	7Dzbvht0X4ynh5iLON1HlhyjB8CNKIGV5KW0Cti/tCyCEQ3+N0TxautEAcfzInY2egzxqQHMFxTKE
	dbrC9qtR1faYylbVfE/jBQ8u8Tbpr6vOd0/guaNyHbA9kdO0dPdXjgfYWcPxpf+cwe3Hf7zk36Wk2
	D7OXdEozcK5R+le3edFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieufJ-0001lt-E7; Wed, 11 Dec 2019 05:36:01 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieufG-0001lV-JX
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 05:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576042559; x=1607578559;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HmYA7ux2BfDVWejsYssPyipCQteGLPcr4zFMlBZfWk4=;
 b=pdDtv+irZxtCF12tz6xhurZyD+uRnX3p1UPleRSn2mmga88Ui5zTFsNi
 Q73uOkTFXKJY2BzcUHaoLeD8Dr/SS51HdG80EsjFZBxmWlQPqeSQzvIRI
 CoFSLBQfmo1U2WqUdqEoEGHHR0twJYoCqVsD8gDzksK6F8ErOFtBZKAHf
 Ml8hkezm7lAkHgJKXHO0w5+IScHsdIiG04B/WHUnp4wz1FJU1PiH9k5lg
 mC2/SvcrajrI7WygD2v7fTJR0a+7BJzkHVGphJnXG7YiMZn5upEkw4emD
 1y3JZID/efTf1BwdJCplVgtWHQJfoaV4/jERAjgYTToHkk3mhfq/bZp3V A==;
IronPort-SDR: O5ljwuyCoIA8dJMAv9Bj4K/H0kGJcnQTbhoHUcEO0FGaG+gtKNG9AeSDE/Ik9LkHIEjjml/p8N
 O5+Y6CEbNu0oxHY4nR70ZGUBBFC/wh6+2XZ5G+Btj52wcWFNDW5kFhVcdr+CdIxcyI+SrX9/3Y
 eS4YF7KSde0Dk2S397pMlcI2HfaTT4LQzRSb9KqY14qRYVMVz7MCr2L1c5uNOqDEFCcZK0eFlo
 TS/Vn7x91Fm6Q33SkawEUXStKgGyKF+Jtd8gp5pkNEBqLD/yAO+s97LomHMJoijIGW2CgO8mH+
 R2E=
X-IronPort-AV: E=Sophos;i="5.69,301,1571673600"; d="scan'208";a="129508978"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2019 13:35:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebzr7YkTK6Ja85lOOh2L36cnXzpIlR4IMNpJUqjjtgnTX6SHaA90PsL0KZE3Htj4PBPqCLFwEmyox5464A/l//urn08g6bv1mKnBqpKPRG0GfCZRgNN8p2Yelsn7Z4y7M/lm8UOn4ocrgZck467nv7Jhnxo1OF3UrN1LDce7bO+gsHgJYj55rG3kMVjr9xWrYkVK9vk4VPJdIY/aIqCfmMFavgG7R+g4z0ehc/DmuBSUK1mRURfsoRHGaVBpG7HxJelgu3DckrdBcxBzg+KW6i4do78VUV8CVKbogqpZklKzrKBzF1eeKxkQ3/edV++ceaoPo/p2y18PJ8dgfowcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIVpBQ0besEZrRmu/dauvSx8Gs7dxTn4Lw6lOF6N0Rk=;
 b=EPj5C6hXeGKzWqlGundc/WMc67ihI6tC8ZX/ofd9CliIixoI0+AEHuEW0iOuSIsI5dM8NGMabBnZM80LO5A2Y9JWMNYWh3a4DRnvU/RzvpkrZl0V3XrJH8T0wfIw5aNGJbs44stvrvFBcbfgnM8dDT+gveZIegda0wHW/Vi3K+9fev9rWWJ0dQTeYOEKB/klqlp755mucYSXTMFMdAnJ5PfLBkbeGJW/wnX/DkASMaR9tIfXY+FOmHfmBENLt3ygOiCjFxqSFUn5bq4tHQWFS62Fcwq6y6EXtf0jqkjdL/KqeW51vxECqzPo+AhpuqFnFPM/3w4pvKugHfmrnEPuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIVpBQ0besEZrRmu/dauvSx8Gs7dxTn4Lw6lOF6N0Rk=;
 b=WNmZTh7+hr8G79BoIC/jgvX9LZwatbkHQpzLdDA6sVgCdyEKTsxHZPVF2/534SmYgft+pc0qxx1V4MRdsULgnfz7Ga5Gf4lX7TCv3kQDFNbk7xlJbdnbpgOzOZQWmnvj53PPkuQ1wh/ZAsneslTfv0q3wHjBb/JcfFpzyw2FAsI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4614.namprd04.prod.outlook.com (52.135.238.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 05:35:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 05:35:55 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/3] nvmet: make model/ctrl-id configurable, configfs fix
Thread-Topic: [PATCH 0/3] nvmet: make model/ctrl-id configurable, configfs fix
Thread-Index: AQHVpQa7N6cAr5dNFk+m1J8Te53kqA==
Date: Wed, 11 Dec 2019 05:35:55 +0000
Message-ID: <BYAPR04MB574951651302C10EC4D80B6A865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48464c2b-4706-43b2-fb8c-08d77dfbfe49
x-ms-traffictypediagnostic: BYAPR04MB4614:
x-microsoft-antispam-prvs: <BYAPR04MB4614F9787A5915D2EFF17829865A0@BYAPR04MB4614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(54534003)(199004)(189003)(8936002)(4326008)(316002)(478600001)(33656002)(55016002)(9686003)(66556008)(66946007)(81156014)(64756008)(66446008)(66476007)(81166006)(8676002)(7696005)(71200400001)(76116006)(4744005)(186003)(6506007)(53546011)(86362001)(6916009)(26005)(54906003)(2906002)(52536014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4614;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKw1XkGaWQ4UvedSKhaelYG3sVz8kvg1fmuIviUFVckpCWwmtxVuB93edNKVrebz07oAb3pedO1h2GsOgYTkcBtSDYGljftjVYqyw3a07hvdu87NYCsLRKg3LmcHWdXWP6/czNRgPRGI/8CFqz2TQDkcHKaLDsgLOl20Rulfm+0PzsMxNZrK5yNVFS7/Kpj785zTPgOcgN8me6syWgyzDrxwUUzgo/FH3XP3IuSvOM0Cbdopu+WSdAWjqYmMkQdvUcgWUMDxXu/n/80VNGuw/GncJj6ZI5EsM7XCScDqXr8Fzp9o2R58INiJ7HyI9ocKdwkkkuPCItYLxP8SX+jgFmVpajmXp+5Tt5DEHcS9WfxdGQ39KKTaxSPUlV7GvmvzleKglmB93xFxHqnOKvhqqInvzuboBwaiLizUbcdxvxLeKRNwSFX1D1Nb4D8juO48bV+B4UIui4vChk3fRC5vB43PJjop18nUHiTocZcVHyyxyMHkMMsSEYtVGM8r/KyS
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48464c2b-4706-43b2-fb8c-08d77dfbfe49
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 05:35:55.1589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XufIxf55ORZ/I0+9a0DkHQPMnsUR7dTBSYRx9Lr4gvsEcsHj9rtKNLIOkpej+ETYRUQZl1QipOxKM8kKM4goYKAEXhdMBMpxmCGmnqQcS9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4614
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_213558_673304_2129A678 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: "MRuijter@onestopsystems.com" <MRuijter@onestopsystems.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping ?
On 11/27/2019 01:40 AM, Chaitanya Kulkarni wrote:
> Hi,
>
> This is a small patch series which allows user to configure the model
> and controller ID. Also, patch #3 has a fix for missing sscanf check
> in the nvmet_subsys_attr_serial_store().
>
> The changelog is present in the respective patches.
>
> Regards,
> Chaitanya
>
> Chaitanya Kulkarni (2):
>    nvmet: make ctrl-id configurable
>    nvmet: check sscanf value for subsys serial attr
>
> Mark Ruijter (1):
>    nvmet: make ctrl model configurable
>
>   drivers/nvme/target/admin-cmd.c |  12 ++-
>   drivers/nvme/target/configfs.c  | 125 +++++++++++++++++++++++++++++++-
>   drivers/nvme/target/core.c      |   6 +-
>   drivers/nvme/target/nvmet.h     |   6 ++
>   4 files changed, 143 insertions(+), 6 deletions(-)
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
