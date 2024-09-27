Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29116CEBF6B
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2024 02:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+peJQIfSC5yrcrLKFms3Lk9aD1mTLzTSBjJIZ0Vh74=; b=PBYjl6mPe+v4S2JkEaxysJ0f67
	BI8dpkHpDfyRms6Mam860wxijmTtF15q6rjyf+PN1ZzcPmyCBa2AjDVdkWsLV/ngCbkNt0d9fBING
	ETDMsPWGjhrJ7FRm8AC4KHGK1DLvM1xwtLBHpW6f5a/7KaW9av66hUff7XzgVQodPyrdNOMfQihP/
	ZK163V8Su5ycZhgrFZoznnK3oIHzCM1sI90ntb6dXh8b/MlJt6gpTdxzo/1dMkPrPuqHPJSXDTlsj
	xeOQXBate3D1/wVR2sRSgxlHgJXS1Xu8tLLs0Hy44dfxUvImT23JKl2i3jUeOUzrbuwPxAjmV0uMN
	n8yJ0MOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1su0TO-00000009nyR-0mgw;
	Fri, 27 Sep 2024 02:12:46 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1su0SV-00000009npe-1ab2
	for linux-nvme@lists.infradead.org;
	Fri, 27 Sep 2024 02:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727403111; x=1758939111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e+Cz1uYlh2uBdc6tws/GWM7sugSHjs/wrBxX5pVCMHY=;
  b=dt2Qhl1AC/m0sykZUnx3wMsMlsozuBNgXRRAS40loxijZTXzwVi5wvfD
   7lw7vk0N+pryybXhSLF+UJFSOpTgKQAFTuy63yf/F7gUN8xIjaXSHBqS5
   R3IgQjiiUrMaHF2nELCSFBS2PLg/FkCvkCwWhU481QYxIfQMlsxldbN3r
   sGMs2J5FuXuosPRy1MCBZGcq2caKKlaLcTONGBliy3D4sjxu/cBdez5I5
   KGZ/pWiKcS4d7GJpgE94Cu94eRlorwLABgt/T8oWoEIEYYWaCop+9TdSr
   ZUw2D0u7ZAeKtwWSxb4fkPFupwr5am7L7KZjPfGSiilTaJaeEeBSeuQ1o
   g==;
X-CSE-ConnectionGUID: lPYE4FZ4Ruyzabym+u0PCQ==
X-CSE-MsgGUID: P7/v14MMTAG4dqpiKecXlg==
X-IronPort-AV: E=Sophos;i="6.11,157,1725292800"; 
   d="scan'208";a="28732096"
Received: from mail-centralusazlp17011027.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.27])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2024 10:11:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ej4gyUzn/YcVaVLSoOd68C9nfTPLmvgyL2jPaqOWhQyKuMBjxdq5mRY/wznhdZFa8EZcD/McwhtKNd7aymRbjsmFxKzsPBekOerA75u4W0ChDLHPaWpFBf96g5FD4fARj1NpyBS2B233XSFsyd+mXQqCDyYJxsiTn9P67zZ6J5T1hrFxtRCBbAcw2d+eLjggfNt3ouTWGEr9a66aYBMeSRV+j1NRmANIeUXG6qW1nL1igTcTCdjfxUWYYj1ghJgV8TvNprAP/uCTfRkSG2b9drradNvprfYysX0PJvhsO/anEnj2yYfBTRz3H5UNJo8cV4CyNoI6qbDJ+3xR+NTmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+peJQIfSC5yrcrLKFms3Lk9aD1mTLzTSBjJIZ0Vh74=;
 b=FFFkQqczg/vVcOjjrhZ+Iww6dQuRpkpM5UrG75Kv0SMkettxLwVfF3/Mo9No2mtzCYpvDFPEmt3lru6RFheO9cThBqyyOaTEGNENRiCvagnLGWaNzXXd3SzClS1/RBpP6YLFkea9yIbOytCRMKxdfcD25dv7mWk+8bD406tRCVyoXFIM7dfJRzUpN9zfWbFx/XH9SQndy+zeaWwBARpZeuHJgs/r0v0hido+gqrCp3fE941L7BIdiAPUGWF0UsLT15Pyi2rV76gPAt6YH9xsiD+VkZnG5NfsrN1hPusypaqXjd7zm1UNzhI6LfxkXxsuyma6Hd0z2HQxHKeGI9AVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+peJQIfSC5yrcrLKFms3Lk9aD1mTLzTSBjJIZ0Vh74=;
 b=aAsF1tQDsGkI/2UefNW2mIllVTrZdbT/ZCHskpnNDnxV6hUlRHosqYyKwyEkoL+f+TX2BDBVDrnOfGCNsq78EdiRhHwzc/3ugg+oMT4zhvqEqj5hPUj1LvuJKihaed/9Ec17aREvNODAoUHUw34X3S3SjurOYVIgisHmvAqIusU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9308.namprd04.prod.outlook.com (2603:10b6:208:505::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 02:11:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 02:11:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.wilck@suse.com" <martin.wilck@suse.com>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2 blktests] nvme/{033-037}: timeout while waiting for nvme
 passthru namespace device
Thread-Topic: [PATCHv2 blktests] nvme/{033-037}: timeout while waiting for
 nvme passthru namespace device
Thread-Index: AQHbDx019PBt7jbYMkuJ5nQ6pP/QzbJq5vmA
Date: Fri, 27 Sep 2024 02:11:45 +0000
Message-ID: <uptdu2g3x6jwlsdew6eu3uwkmketx4z3xehzeq56gsw7eofimg@h2lnekqsbdmf>
References: <20240925073245.241234-1-nilay@linux.ibm.com>
In-Reply-To: <20240925073245.241234-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9308:EE_
x-ms-office365-filtering-correlation-id: f93f10b5-e358-4db5-6275-08dcde99bcbc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?F2lAeGr8U4xHuCBzSvwGrdWIxG6TwXkyfYOjFReFiSRj8AiZJmp9xWSrGf+4?=
 =?us-ascii?Q?OvOXlapytSjXkf+5yH0CZc0A5twgjeWIg0FoVo1zPUXx/bbdXN1sDSklN/VX?=
 =?us-ascii?Q?YmI2b5/lq50vL5NV3fHIKevbnyYd0ZyCURkSEPgbs9uwJ+6yRm2lT98TDJoj?=
 =?us-ascii?Q?rfTdYTUO6w0YjBDORQGDH9eErKVQnIcDIp/IqWP6KiNhCzHTJdwnvdocO0rX?=
 =?us-ascii?Q?gUreYlE5X/zsFrHxysqOobQQmZoogoF86PVlz0uQuDygknAzZnxTy+7IySDZ?=
 =?us-ascii?Q?31JDuRaQVtojnNS1fUmM0vIdEtAjYVOsGxAvViIshdja94KTMaotOpVJPxZt?=
 =?us-ascii?Q?vfFy5B4kt+GvDXZq7mVDXS6Sx4TR3jmg7sSNOQTC007WosimT49/i32/41z5?=
 =?us-ascii?Q?c/AehJqwMsSn48q/SaADqoByX2IM5+x7I08vP8vusoYbRaLLfXjU/TlZOctX?=
 =?us-ascii?Q?tJ3TGs3v6XpOA8OR8j10gJVcmyclhlmbxisMtxkaCRe9SYP80JV8Bfh+XJ/N?=
 =?us-ascii?Q?vIzg68TYuBnH3qewobhvdVk0RNCYuAvibTBPuwUPyMw9WD0bVXVDUqV7D3OW?=
 =?us-ascii?Q?vX3rWCnFcORGz65YRKZqlY1TsF27/9zt4otMUUALN1MpexTDDeqnniwy41GU?=
 =?us-ascii?Q?Kgz5i6H5JlqaD2mueAzPs6c5u/z+kM2lULQxjkgI/r+l2W0Nbwyc2oX6w6lZ?=
 =?us-ascii?Q?3+0W7ZLkKuFKpkJOixsk541+q7gIubgWHG2fxaqlHW44XMkrTgmv3s8R5Zfk?=
 =?us-ascii?Q?er888BqkpC+lJggRxDXhynmEHGrAgpSpk2l2NEBaNKVOHNzDe/zPjYwCKJvl?=
 =?us-ascii?Q?C/6y2Hyr9rptH6GYLho1AEEZZGRg5+3dfjlBA5eJ+kjdcuT7ITjd84MkuJyd?=
 =?us-ascii?Q?/IQiFl7F9x3O6m1FjhOfJvGdji3r9wGChd426duAABHoa20YvvNnInSgnyyf?=
 =?us-ascii?Q?WaHwP9b1c+52Eu4SM7n4J6yKB99bcJWP1CT6HbCQnPImWkeRTsKvB523tPxo?=
 =?us-ascii?Q?eWVKB/X9o3RQ0h9sCn1ORUIUxJsvOddA6y4jvdtd7zuJGfayqEz/WEKWDYVK?=
 =?us-ascii?Q?SWapZbz0DwCqOtDi3HcdZjnWeBROrAdEIukyf6EXN4O7vdYiqaa/deDL0I8x?=
 =?us-ascii?Q?4aUjbhvNB4LCa6PBgd2O6jOVkHHuE6J7/MyrsrA9oSQJSDgD9IqV/nW7yrOw?=
 =?us-ascii?Q?t9R2BM/UUnNBlSpyQCnc/Rw+iiLW5i+Qyh4Rqdo2wCbTLLDr7+54tcum361/?=
 =?us-ascii?Q?KEBLAEoJlyoSE3TwlRH+3YXdgPTTfp4TEX4fsdpwHC/cNPiV+rb0aLkvQnsb?=
 =?us-ascii?Q?oUHk0PHSCVByVW91DqUvT+CAbsVI/yw3aVoO0QzfJNk+42RE4iAzaWH5CFGm?=
 =?us-ascii?Q?kPXMb2SKyf/NNoy3u+gRVYYBxm5NGLbxm0g2+p8nKZFWCKKewA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MPxcilBOnWjQ2L9YChtuVF1SFWUe+VnKKWnrcuR0sy+RLRICoOTUVevsa+At?=
 =?us-ascii?Q?2XSU0eAvPdD/WhNw32GMnt4OXXEb99oJPNg85X8i1SZCwY7qGZrXBs7jthxr?=
 =?us-ascii?Q?CWz+Mz1FiRdrQZHLhpnAPyHktJ5tqD//B9YocSnfBNfaXSfpyQM2+KvOT8pN?=
 =?us-ascii?Q?O3GudD5eyQbwFa8351WtJ2Eda/BBxQTSJyLJiz1Xq2cxHhz1XjFHqiRta5lm?=
 =?us-ascii?Q?xxaSq6+ZxUw66Hq6MxuVfYUJjrVXBwIOGwHPWteUNdwaUdiydN97LdCyJZSu?=
 =?us-ascii?Q?UYBWic9HkYBke6o+QsMxxN4rMCh2LlOKv4vj+CdOe9e8mUxtPw+CqAmGmXkm?=
 =?us-ascii?Q?4Ghf+JY6xniaubO5ZFxgx4SVijLQQIlE3dz3tj72Jo4Gti5BbpdKnAyYt27N?=
 =?us-ascii?Q?+fl3Y5mSDeD4LKOQhHfZULeOgnwUtf6YQHb4ExNIxRpVnjC6m1HdwqJD4YJM?=
 =?us-ascii?Q?Ywk1aO3bab3Jw/ZwfuQmOtXjuriFOhRG6A7gl40OT2h4zpKvRG8Z1m+/C4Xm?=
 =?us-ascii?Q?oU35m4axX2i0fyAtHcHujroYVnkl1P2m7HbGbcaVzTNHZ0EtcJS7ljLLmK8m?=
 =?us-ascii?Q?9f0SKPIzyGtLd3WQME4xhIhJcl+NBHZAeeVZ3zBDptNGPCr74D9A2lQRXdre?=
 =?us-ascii?Q?6LrzJKsf9JAAUF18ysyqDIUo3HBs/o8+R5dGdCnG8ccEqS9g7FC4zJw4PqnO?=
 =?us-ascii?Q?zaL2O5x5IKjwoFf6qqWz6ByybzbDQ4p/P4FKbidMMmldauGsAKlUsQcm5Hnv?=
 =?us-ascii?Q?XlB1Eh2i4nGjN55jOFb+Ko0yyVP3BDLuf+0ZH89XXV05BaJ3Vk7cyM6fis8M?=
 =?us-ascii?Q?O3+JG5W/uetBKGEeLjCK/phkW/GS/exusgiv76jN1Oo3y6nRjayZa2piD+8k?=
 =?us-ascii?Q?dgzWVYKIJzatHXwvWsIx6iqwmQxsuR17TWJW3WrWtDr3sV3ytrOM1vPohYrh?=
 =?us-ascii?Q?rh0n4/QkYA2sPkG6lU+TNBrJ6wyv1eH3FHSb/AY1eNoIxMucigEZVyqbLa07?=
 =?us-ascii?Q?t0X5yr/oekaArvywGeBaZO1Vaet3UIJWmmodcEt1kBolL5GUFhGcH2uMi99d?=
 =?us-ascii?Q?DfiRX+N3ElUJMTRm123s6GiKS6IO0oxUi7JzRnB7G9EM9if62y88+kbuOmS1?=
 =?us-ascii?Q?muR5jOdMJnvbwfWO0bH6LORMvgn6JNhurDpuiGwdUoDFdONappWryC5wXZN1?=
 =?us-ascii?Q?fjxK9Xyg8sUohKNbFRA4vynPnUu3vXJQ207kFRO25SGcOFhtudekpqei3HGQ?=
 =?us-ascii?Q?EH/tjcfK1oL1Btkjx1WIxSwE2pp5yxw3ijO+27STh5igCgJhR1bgtw8YynD6?=
 =?us-ascii?Q?y75BSfAHCDiYmNljbvM7xpvIh3r2eExbM0oMY2xdpeHV5ASGKXTxobY+UnfK?=
 =?us-ascii?Q?sz77qIob3MK/ZPc0ovh7R6fdRftRXUrGGdTKshuvIujpbqGa5EFKnHEsOOlB?=
 =?us-ascii?Q?IQbyreIrcdtXLG7CrQbNq+AA/4MVJNkR38ILCAt+eFb36WTz0V4wymsUA0Tk?=
 =?us-ascii?Q?kRADQEzrRSudmdfsGQY1/DiDLZ2YSkKhGrA/rDmg/OB/8uebchegSLfAuIK/?=
 =?us-ascii?Q?k5rTb+SSGuU/UPNYN8xvDL3/AmUAhGJJdVaTtkBYBh614zvcHbr+jkzvB9px?=
 =?us-ascii?Q?taylYCE+t+88oyO0Wc8ekdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7B913FDE21B9D408A1A9B5C7618AEF1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yIJqgbn9rvp+anpYK8bgu59kRg8GZEWDMnNylOPaJu6+AlJuDbvW0AuSHT/vi3+s7jF+LHwweGTAmyJqcOy0hORPFYtsXGIRj61AmiiytmwP6/Wv0VDk4zBVGYDOG0TBkP16FDUswGDkilw57d58FUa+YRA6/gJKnONJ6oPUN/mxX+Atlq7o/SXsNyeWpNIxDxcjj6jscg94QCuBRoFpytIASE7eyiITltKdVKi4qmlgxFQ0Is0/c56Tcgl/EOalOGH3r1orIvaYB0N5sBsBAWaIp8ciUDGBjgWtpzhARAi0zLzsGx2GDAEUWIlllvC8UbkJ34XB7lhWkIy0iuf90uXnTHLbPc66hlX/3nzeIVCLAerl33ElHrbsRj6xH794KmaDa2YVipBgVeNlue/YctE5TnFkF6BG7FF3VpPFj1/wr8zUPM09DzdnWSIyiSeF+Pyd+EhGVamcOcmEvIOGNfMYsW05SdzkgdIZGModfRQ9UkqoxjeuYHx6ABnT/4Yfr3H8Rpr9RRqOeTBnvNuJoj+W/6ggG5H+qYOBq7IXamJOYUo1BGufYJjhCGRHQP4HcOC6W9HXpj1cV0gSRAF3r+Nm5eaIqFKPEu0Ne0mil7bVlIlqJl++oAWa/3u0Ru02
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93f10b5-e358-4db5-6275-08dcde99bcbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 02:11:45.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GF7lA9ArIP2ZTzwigV4geAxF5xKPoZODJyrRrppoPMRBHX1s4m6rHdVUIML64QK3wi769AR6FgwZfjU5LCDGp9thcasIfSVBytTZ48wM+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_191151_843031_4EAF6A87 
X-CRM114-Status: GOOD (  18.78  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sep 25, 2024 / 13:01, Nilay Shroff wrote:
> Avoid waiting indefinitely for nvme passthru namespace block device
> to appear. Wait for up to 5 seconds and during this time if namespace
> device doesn't appear then bail out and FAIL the test.
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>     Changes from v1:
>         - Add a meaningful error message if test fails (Shnichiro
>           Kawasaki)
>         - Use sleep "1" instead of ".1" while waiting for nsdev to be
>           created as we don't see much gain in test runtime with short=20
>           duration of sleep. This would also help further optimize
>           the sleep logic (Shnichiro Kawasaki)
>         - Few other trivial cleanups (Shnichiro Kawasaki)

Thanks for this v2 patch.

[...]

> diff --git a/tests/nvme/036 b/tests/nvme/036
> index 442ffe7..a114a7c 100755
> --- a/tests/nvme/036
> +++ b/tests/nvme/036
> @@ -27,6 +27,7 @@ test_device() {
>  	_setup_nvmet
> =20
>  	local ctrldev
> +	local nsdev
> =20
>  	_nvmet_passthru_target_setup
>  	nsdev=3D$(_nvmet_passthru_target_connect)

I commented for v1 that "unnecsseary change" was made for nmve/036. With th=
at
comment, I meant that one empty line removal was unnecessary. However, you
removed the nsdev check in nvme/036 for v2. I guess you might have misunder=
stood
my comment then removed the check. I suggest to put back the nsdev check in
nvme/036. If you agree, could you send out v3? Or I can do it when I apply =
this
patch.

Other than that, this patch looks good to me. Let's wait and see if anyone =
has
other comments.=

