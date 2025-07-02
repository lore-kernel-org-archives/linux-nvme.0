Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CBAC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XvChRn5tmKyUuAm87vi/vjIR3bZYfoo/gPSJ4QV8ua4=; b=B0VYLvf5M9iDnhcJ/QE7a725RV
	Bz1l3BI7LDF37GOsTZdEmMrWnTy06RaxeDaupV1YAvafrQ3EsUueu8WlQEo17TUCPNQfIVv3ZkO/O
	AA0YVyrP7BjwgrRR3UH2CWKC6WSemfVBZOnrbEHjtKveMK5ozR6CxzK0XK4QFNxJaCAtuejOBGM9i
	NtYGYLgfeOcgr2bwKrHagmBTUNhXi+AhZWK3tdIVTN2P+avYbWR7lKIiMEbk0s9wnoWKq3iZpr5BA
	aP0K8KtnYTCrc+hL+SzOAqtA5GhDR+1p9huvcUSGlTFA7AgqwFuyvR8iXpZ16o8YhuqUMW3c0k1u/
	8RsH7Jlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX1uF-00000009EH7-1G9R;
	Wed, 02 Jul 2025 18:10:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX1to-00000009EEQ-3SaE
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 18:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751479776; x=1783015776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XvChRn5tmKyUuAm87vi/vjIR3bZYfoo/gPSJ4QV8ua4=;
  b=i0Fj4v9xXo6poW9bSlOessQOpv1FN0FqCYpVulokwvuKMjCIpoxaizMz
   JPDfi06ENKEZo1RabQgO/wURS7OdknrKi+tq6h2Loa45FGdoVo2WeShJr
   L47bCokyTFZoIvS1WVgJnxctvsJXxoVvHW7DOxydpHmgC5qqBqiU/uByv
   jdkwfjTmRLdANXxT5ZIvFkOaB+kkv8Jsgr6dtl0cEt8r2CLB9Apc0RDPs
   btfrnaACzW9C8kIvcO8qlUkFbSpaAQe+CDa2adsAJ9E42J7i30Y0HFfNT
   j+MJmMipBr2EAfp5nt8W5r0g7XFfVQfU/pdlHh1Aywo6EvKpmMmojCysd
   g==;
X-CSE-ConnectionGUID: OYV/XKyQQdS89ZBhBL0Tyw==
X-CSE-MsgGUID: abqtzk9qQKu6hewinCeAVg==
X-IronPort-AV: E=Sophos;i="6.16,282,1744041600"; 
   d="scan'208";a="91727648"
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.58])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2025 02:09:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwSmqBUVtioaGCzmeF3OKDTAIcS1DOproqt53i/O/OlNPcB8/DvzKpoe5TiEVQOzLcVL8I5AiB/BbuvfRtfMm1C1jAis35sV3ZtFOdbJaqBq6WYQE/oWbp33uaLbxCFl21MFNAH/v92CWe56x1/LMe7tMK/AegfRt8uxueaELlmeucDl9prwgOas1tuZU8pPsXXJVyue9cI6v3JOnO79BEsbZQIjNE4G/ubD/jCWrUhV8rdyRxoXKeCDBeZzpk8j4hkIN3YBF1ttAssNst+SfcdVOLgKoVWiI6bKBczSRlg4TlrmDPiqCjex/+dFFRqiU45VBAYBO0j9w4LmdExbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvChRn5tmKyUuAm87vi/vjIR3bZYfoo/gPSJ4QV8ua4=;
 b=q9rScJh1V9/IkqGYjKmevVOqScLko6V1c0zia5xXeAmxW9c5n6ujzsN1VA20KAJdeRjH7M80yPIXHCS5kuK77naNzYCzcBqj+yBxq8gGpGtjX04GcTBCjZjB+NDTTVJMyVtdQtnPVl57xH2oMnXOGc5XinAGfFd+eZtkicu8dVRdPDl+lzcFxBPqroTOijVnZHJEIIVqkFc2qGjTDAuZSzwk9wVcXxbsHLghsWOYL6ybL+9VV+YE9ENnpkZ7esCS6zii4cQOjK6EvayknZKvZmhU/gPzI6Rxf4f+AhCDiTUx9DHT7+D64Oxdilz4/ubNxR7XuuvNIxXhe6x9tt1r2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvChRn5tmKyUuAm87vi/vjIR3bZYfoo/gPSJ4QV8ua4=;
 b=ycfbrjWQqiv5c6xzLyTja9bRruMWJRgzdVQRSvuMhprgASipN6feG0sCwY+OHakVvVFC5xjo1EOKDbI8D8+J03tg1deSgoJVlX7Y6jJ+AuDfqQ6AnDD8fnfdwrXGYZohOZHguwC3MXO1koQfGTCNPR92V17Mn4Vpj97CCw6FDl8=
Received: from MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 by SJ0PR04MB7166.namprd04.prod.outlook.com (2603:10b6:a03:29f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 18:09:31 +0000
Received: from MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8]) by MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8%4]) with mapi id 15.20.8880.023; Wed, 2 Jul 2025
 18:09:30 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "cassel@kernel.org" <cassel@kernel.org>
Subject: Re: [PATCH v2 3/3] nvme: prevent ioq creation for discovery
 controllers
Thread-Topic: [PATCH v2 3/3] nvme: prevent ioq creation for discovery
 controllers
Thread-Index: AQHb6uxxbNX/FlCkz0mUnwSTz3wJ0bQeGWcAgAEDcHk=
Date: Wed, 2 Jul 2025 18:09:30 +0000
Message-ID: <MN2PR04MB68626BDAC087B4CC8CC1A1A9BC40A@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-4-kamaljit.singh1@wdc.com>
 <c168acff-66ff-4692-b21e-093c0aa592a1@kernel.org>
In-Reply-To: <c168acff-66ff-4692-b21e-093c0aa592a1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6862:EE_|SJ0PR04MB7166:EE_
x-ms-office365-filtering-correlation-id: 99767c67-7e4f-4ad7-6822-08ddb993974c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?5YdHr7yPvRRp4InSMeytGPo/MDbRPQ6Zg41k21X92YjQiVY5qGqaFp+k?=
 =?Windows-1252?Q?JlCN4/BxO9MrJHQqfqdYpESaz5tzveb674RMOCy1SMLXg4VHqiXVlQrQ?=
 =?Windows-1252?Q?o2GmFH4mkTwjaHGtMKw+ousplRP9DwEnnob7hgACJCWPICB6hFucmA/3?=
 =?Windows-1252?Q?KmCJwwN854uz+fzYrIItN3x+1lO/74OegXyUl/MZbKg6ltBJSaFSYSd4?=
 =?Windows-1252?Q?WnwdDfLXeK64F78K6JD53MdfKf34bkVh7ecu3CMbeGjI78dXgJZ9MGxF?=
 =?Windows-1252?Q?MDtjFLpoCNCStSovZQfhS9tOQv0otUAloSxQPfigiuMAhp3ZEJw6zOr6?=
 =?Windows-1252?Q?0mqR4AGi4BbrMdcly+hUIHkNqGZML8HGbcx3VVAXdv6+gVrHhAFYoJNz?=
 =?Windows-1252?Q?/B7Tklu/uUdQRKkbTBmgeNqI9aOilpUJSql6ThfcJx0qBmCd3BfjT0JF?=
 =?Windows-1252?Q?FCYCdZGiXguqt8w9Cn8i0qaJgBUoj41a9w57LmXSRvjmo3rIqpQXEwU0?=
 =?Windows-1252?Q?VXuSKDs87qPPBEGHhrTEE8Na6CqrnTXb14A52AkWWPak9cuRk0YM0pb4?=
 =?Windows-1252?Q?ZV67hPX0OuKnhGhzsCQzyOGeJLBXpEUpFFyoy7lH+hbs0uw4Fv1kLH39?=
 =?Windows-1252?Q?0dBvQB8Y4yxVSh9eNLsTdgY3K5ii4/Y1oGhss9MwFE//FNfLG+EkYaBI?=
 =?Windows-1252?Q?VyaQn6xh0tzfQ8xWVX5cB+ff5MU2TAIZh549qRbL8an9NShLo7VEjy6s?=
 =?Windows-1252?Q?dgwoPVvk80OOc3kZiYxBYBBvqzcdIqApKhTevLC5B1oujGlRHrXSe973?=
 =?Windows-1252?Q?YVxr7ZcK8oDycAbKyqxXHkn+J0Br2WpcXWlgWNIZddKOA9h0qo2Ot6j4?=
 =?Windows-1252?Q?5NL5BAOZNeTGdIxVeiXJOm2mqfDg25gECM8d/JudzAp4juTdis458o3X?=
 =?Windows-1252?Q?bzFYmD6LXTrM5D1ebzYytteRCg1eXyyJrI+iBin9cjIAXBuWtLLUsvnJ?=
 =?Windows-1252?Q?lEOL10iRU3RegbBJixFFL80YY0geNx7DBB/fswcCm4Vs+VIZHSggFBdd?=
 =?Windows-1252?Q?8Q2i2PMaxNVEvhc76bp5aR8D9o5qR2Ce+8ziKZwDJsrnrYaTmL/C7gvM?=
 =?Windows-1252?Q?waYnjsXI8og8WCAoVbGvPDtLoTyqIoRhWrFdkLlkwJ46G58fJmFQ+iFm?=
 =?Windows-1252?Q?HIoYeiY2iD2PeItio53C65btG46/3zp1G4D9l6fSexL1Do02fSjsc42a?=
 =?Windows-1252?Q?gwSuw+6UaSV2ao5hO+bpGzWtt2vQ95XieGsuPzCrjIBaM6U+v38iZeFm?=
 =?Windows-1252?Q?yKTK7C+pgmtDD0N5o8S9hnfCE4mSOfJhqj2/OW35RFxeTFk3368lLQps?=
 =?Windows-1252?Q?X58PZywZtEOLWnlqGm+z/KihYWFv9BCSqfpH0am0IV0kieqbIvDvZepC?=
 =?Windows-1252?Q?s5IcCKtiQzuvN7KPBW/0qChMPtHx/mqFr3y3iaM9QqS1Cna4Xa4Zcl1j?=
 =?Windows-1252?Q?0757l0NSOqjuFGpO4GYseYJCubZPSc2m/2sl6Wc1kj95Hq76zs/SXCvO?=
 =?Windows-1252?Q?4Yow53dmidFqz6Hvnu+fkR34FVx586Z7lOiYAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6862.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?T/HZYv4i1NSzX1K2FP+Asq7gT9T50+zDApF1Ll20k3awk3W8nRNcfO47?=
 =?Windows-1252?Q?tGm4BsACRT/QeOqt3UDco09rFDgF91YzP22lZ0cETrhgAH8pwSK1HIdn?=
 =?Windows-1252?Q?HOHqfQMPD1DYNTh3XipLSmtZrBqzO32Ji6b0C1xvTWzMvmMBV+qkfMPS?=
 =?Windows-1252?Q?ZtGz12XswJZDyIxt604TZU1D0ONtHvsNpkn4s1UzZ/9gVpOYjPvu9npr?=
 =?Windows-1252?Q?ENwUlS+gAAU8gBbWPmVsVQiDW5NdY/gAIf4Ym9DGr75U8nIo11iur/3J?=
 =?Windows-1252?Q?tJynWFDLYC1xKqnLuoIVV7HRNakAYOglvlBneYav833Tz/1juxcliz69?=
 =?Windows-1252?Q?kQceKpRAqecC4SaXJ1IZnoFD08hPfHSwSmWbdz7ubBNsevPkIWT3Icg8?=
 =?Windows-1252?Q?fqidV8swP58T6ntVi24DprTcajLWymSo6jN+EJKatd819lmJo24hY061?=
 =?Windows-1252?Q?M5o09gu5bM4dGQNGpMPysuyj7Hl0/azHas1UfqHR234l2hbM4umkE14U?=
 =?Windows-1252?Q?uQeMH5TS4CeZ55TAkKw51D2VwRZBrNHVo6RYf5RprWFEOkBI6lLgkJ6E?=
 =?Windows-1252?Q?2fU926wt7YHwSLk9GYsvtTKejYJFZ9GvaZeHoGdGYThATjVBVmr0aqNA?=
 =?Windows-1252?Q?gSJQ2syVNXRC/JY7P5tB3jRuRI1rRApHDaOk7/T2MBXN5zQG7Dc+J7Gf?=
 =?Windows-1252?Q?1NHESnptS85Rh5KuV+2M5DG5uSjELWt7fSvCI1wYT72ii0waXPcXHmrF?=
 =?Windows-1252?Q?VIrC/SOcFiAVxk2bfBLh3jNbudxXdodnbe1qWJi4mOHitHTQ64g6cYMf?=
 =?Windows-1252?Q?g0FB6IigIA3LS2pW6Y9fnIhavU5lW55OYLyey2KDlq4ng6p0LLrUbNfn?=
 =?Windows-1252?Q?dz+MOX2miO46cAD2UjIzOGqIOynkgD53JAsnlB50UirzyxizShBMpUwB?=
 =?Windows-1252?Q?VYcFDHUOliJEGJVPAS1q3SlHgU6ZnCsZk81OaWYPTX9LtqmaMKjWtkOL?=
 =?Windows-1252?Q?y6JcdwXB9AUpotcgW/ybE74vkO+5j35mltX6ZMIHCR4RjncDFD6tcoVs?=
 =?Windows-1252?Q?XV5Vfp+u58S311FLMq1IWsivjnLfex+pNPxDK7IgvLXt5T8YjcROCfJY?=
 =?Windows-1252?Q?f0esF7mczahfsX8+jFpfF5zz0G2qqptf+6ytRI6OvRQhtsjBGwFK9QRj?=
 =?Windows-1252?Q?nsAhSd2Q6Gu1nMY6kUoVE7MyCSMacWQ3ki6lppeMGO/mXJNwI9kirxfX?=
 =?Windows-1252?Q?pob0w85/PzGxjRyEdauzcywem0vpj2LXHz1wRA4h+CxXhNsVgqI1Te4f?=
 =?Windows-1252?Q?JY/71TvXXbYlMglZK2juiuvpakwYurVtmc1HmtV8zapjgIjytwMthsFf?=
 =?Windows-1252?Q?9MmpQMcx7J03L4P5f/OzbGGD4m0rtaO8R5hM5m3K84D5N//mzppp6Jf5?=
 =?Windows-1252?Q?8sYlA5Fcf0XbWIkBRcvAXT9WHmGBe2GnNtNd6TqUBOtI+HXpzSKAtfGl?=
 =?Windows-1252?Q?zVGK9wDngJ3KSAWAmTkun7jt1q7YK++rPSsOVfP2eI0vAylso9jd03A7?=
 =?Windows-1252?Q?kJTfxj8jwVwaUCu4rvoyynvbBT9i+KBspr3s44WvLDRsED5VLp6puUdS?=
 =?Windows-1252?Q?S0syY24RIhwfFb8+t9K+zw9jWh88ICVxFvHdA36cx+hj1ZSOEbZS/rin?=
 =?Windows-1252?Q?eWWr3EnMwAqNxzOKwjmnTqIw3mWXrhIV?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8JOoKVHye84IwlT0xDG33CYNxUwGSFqRW8OpBv/YI8Ar/k2habFcZmRDlnV63/nWNWNPqoFlzKwTAbn/dQwnh+x7Vsnm6vuV90rBaWNrTIqidK7XxWtvZAvN6bQ7sNj80Y8Nu9CFtgcg8Bxj6UsChgYXzIjP+Kmq/XKRVdf+XRvRobnWNCz2WzCxsfQAeIOS3Lx7EAqJB3Xgg1vO0kwPN+JkpZka5qFaRGR6tQjQPCC8ed+wkDMy306Rl6E0NaGeMrqX6tKY89LXjNahVb3XUvm+BY4Tm58J3uwNA0QlWWrPC2AYuXo3pQZweIvPzEv0Felddzl2Ke/DFPV5E5UkbgmnYJCECqCZJ/ZEZqZlDvAcUBMc7lRNuynz8QouBzaabnpP+72eBlT9NfynLpfwPdDmwSpoZxcrfqwBgUG+PJTw8QH0BeKH1Jk/AD57e+T7R2MpFA/l/vDKgV3zgPd2gM8MCsE+83/dvvG72Z7HpcdkFt9Gej2vi+PoZlfSsqDRgnrUDrcqNial6XgLMKI7oxQm83pEjejRgbiSMXU2NkA/vWdvdI0bIcRCAYfVKxr6c2widvvccDuaTG0lxuflGAYb3N/6VWEhZcpcZ1W+64xrGmAx7UUmV610L0AzC7zM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6862.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99767c67-7e4f-4ad7-6822-08ddb993974c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 18:09:30.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAnsGTVt8raFizxpuGVJT9WL3TPD7RxXkxvyLkNS9Sjc1cAL4gwNYxa7dO9HnOCtEDhjLwIQVAp/+0FakBzPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_110936_950192_615C520D 
X-CRM114-Status: GOOD (  10.97  )
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

Hi Damien,=0A=
=A0=0A=
On 7/1/25 19:18, Damien Le Moal wrote:=0A=
>>=A0 /*=0A=
>> - * An admin controller has one admin queue, but no I/O queues.=0A=
>> + * An admin or discovery controller has one admin queue, but no I/O que=
ues.=0A=
>>=A0=A0 * Override queue_count=A0so it only creates an admin queue.=0A=
>>=A0=A0 */=0A=
>>=A0 void nvme_override_prohibited_io_queues(struct nvme_ctrl=A0*ctrl)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 if (nvme_admin_ctrl(ctrl))=0A=
>> +=A0=A0=A0=A0 if (nvme_admin_ctrl(ctrl) || nvme_discovery_ctrl(ctrl))=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->queue_count=A0=3D 1;=0A=
>>=A0 }=0A=
>>=A0 EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);=0A=
>=0A=
>Repeating comment on patch 1. Can't we do this in nvme_init_subsystem() or=
 may=0A=
>be better, in nvme_set_queue_count() or nvme_init_ctrl_finish() ?=0A=
nvme_set_queue_count() won=92t even be called in this case, as its only use=
d to=0A=
configure IO queues, which are not being configured for an admin controller=
.=0A=
=A0=0A=
If we move nvme_override_prohibited_io_queues() up the stack into either of=
 your=0A=
suggested core.c=A0functions, it will affect apple & fc drivers, which I do=
n=92t have any=0A=
means of testing. Any suggestions?=0A=
=0A=
Thanks,=0A=
Kamaljit =0A=
=0A=
=0A=

