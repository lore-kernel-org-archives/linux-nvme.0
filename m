Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76625D1267D
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itne/OHO0svawA3lo8eUWwNAHqIehQrxIZqJUd0UpeI=; b=1LI4pnrJUucdz0G/TysXV9UqzM
	c6ENboXDPZ3GhQ65gZJ00yqWlsECOkt/FU+e1DdVZrH8ib8TsSVJZlEwzqH/2sZyLbOvZcqzyOptE
	3nvf9cwM1yzYnGH03mrS4WPjHRH001838ynm7Y5Iz4o7nHRMSxaNPigJ8aCwwB7hlLIlqVXYGH3FQ
	DVwMSymUnqwvw/EN2MwU1q48xv0Kl8UUP8AHfq7KZSeXzlJ40D7tp7DWw/BSbRTCuN+SOcGtdiCIG
	3wgoqaV5cnE0/etgN3z5xtebuGnvVTWkKAt0+ZAv/SS9cTF4xDCMp9Px135lNdI1SJwV/PVNwl8Z/
	STf7YF4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Gm6-0000000Gffk-08Db;
	Tue, 05 Nov 2024 10:27:02 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Gm3-0000000Gfey-1IJh
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 10:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730802419; x=1762338419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HFtz5pJo2x12g2OpWer03pHwbO2Bo+Un+zugs4jiei4=;
  b=NRYIkaI2WCH7DG1FlGjB01GRc8Ah/gYnlB0BC2ZTThxmKCodkSxnogrd
   SASZQiXlnEpIA2DzpKWGms/gdA+aLvdmBzDKzXygntVHSRR/BJI4jgDTK
   oNDGXEBpGSPLuJsW4W/tbzjjYxqyXOudjGy4e4K9dbx9b2/jw4j+V4ZDR
   JUJMMcJJ1nqWNdJoy5Zqni6FByoe3urKyg1eEREc8xS1GqoHQxPLVXA66
   VGPAohmc+RLBE3z2jtzZ0KXSkIK1cYy64LDkKdQUtNsW0uCtofIWqzLzW
   9tz8/Fp5GpiqdxBkgwM27lwFRH3kS3qe/pvN0aTn3oZTdezYgqXbsdd52
   A==;
X-CSE-ConnectionGUID: uaBEeD1xQEeKuRkCvNg6Cw==
X-CSE-MsgGUID: 8VF91odxSGybZKIboYptzg==
X-IronPort-AV: E=Sophos;i="6.11,259,1725292800"; 
   d="scan'208";a="31786983"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2024 18:26:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWZEjjPXl+7YcEjAOCjXhM6pqGpvhYFMn2TDdoqd52jQa9Q23eze7NZA9JcDboHkgf/d1+BVEvAIMQcm1k7rZdaGpHeQYZ27KaKWQija4rFwelQDtJqwXhpsYGd7bvUJlEkX0cat4nsHtH3ui+H1yVQpeudJ4iOTZVDlxUwl1EPGvS84q8tT173Nlw9ZdDDgvgO7nfKPdipWuv7LPEiA+Na5VaPFV4JsBavmt5Ym0FNipMZEtzqYgSbQxOBKsbRWwqbXLVuJakX9NzoGwkNNEruTOdnJXg2p9m6ESEEKu+4heWPFJ/Xc8X8cbbyiWV5bDZ6wQS9AdUb4l/rdJiSLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itne/OHO0svawA3lo8eUWwNAHqIehQrxIZqJUd0UpeI=;
 b=RXtu+Cuvzx/X4gV5F1+ZDVfDUjk6mAl8uxaCme8V41k3zo2b2AE82iPWiiTsILiUcuWOyal/ZE2wY5Jul0VwOSE4iQPYlUVoM8KDHLFAa6J50gWnQZ/B2OL/JQUqUeShwdrHQNXRaYE1cIBx1TWt6e2x2IhZVj19duqXHCite64yedtA3HYWVTpGF+l4oXdxxGA7JHAzARNBsn8zPFvmGRdMeT5EU9z3TuwBL4GpeOT+QS4e9Wz0p1c/qkLhZ4/m3Lsx78DOgAk7MWIyu+ptOftpFOKHdfXKnFRWKTyZmTylMqLYLgYNL0LFG7ktJbRWPhXiTApSVe6jjZ0D+cYdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itne/OHO0svawA3lo8eUWwNAHqIehQrxIZqJUd0UpeI=;
 b=FycMy+q+T2JTyBf7YurDr3NWjDNRWvCX7HBT6j+9Hboq8JQYZx7ewWUKj2LDWtRuomX7E+PKipqq+qgTM+/qoMFOOIwAHGgAaWkp2mn6Diy321AZipo/bfg7lZ9nH4wr8fXWSo7o9YZdRa5hrvggfjiXdgw8pDRFokN7fFuKK4w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 10:26:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 10:26:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 00/13] nvme: prepare for ANA support
Thread-Topic: [PATCH blktests v2 00/13] nvme: prepare for ANA support
Thread-Index: AQHbKpg0dmrrs1acnUOc56lIPyFd1bKohUaA
Date: Tue, 5 Nov 2024 10:26:54 +0000
Message-ID: <es4pti2sjwvnfbqrwpmqnrrbtakhh5tffqnvlqzdkoa7codvff@tdxui4xr4yug>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6995:EE_
x-ms-office365-filtering-correlation-id: 5f8416df-4f34-4be2-3943-08dcfd845e9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ErD+3ont3vVSBmNeozqtxL1xYZ3SPLtauU05frfJV+dA9wwdbUgIMXhunNhS?=
 =?us-ascii?Q?BOcRQGGUF+Y3ajTMZbzDdFSn9XOzsWmjkEyPnudXrABNI4UVSuQbewdx1G5r?=
 =?us-ascii?Q?EWdFXgpRtsH+Oz3ZfXm24c+5tn+t8EyZswvbi+nP17+P8qG+lpFHt0xIdpzQ?=
 =?us-ascii?Q?saRMy2tY8R3R9x4F9oFKozv74NSTQnpMO3X0Tk2qXGV2FYRKzYEVSWEUhJ60?=
 =?us-ascii?Q?xpYfOwFlPcziHp9mFbs51OleqEFKq7CvI+OPuDHfj/1+KIAhXCp8DP0z9BdV?=
 =?us-ascii?Q?WJgpm0720eZWFwqcnygzdEzM4Xaxy3dgIFXvVkV3kCmcPtMghDzd247bTvOD?=
 =?us-ascii?Q?XnD8S5HDq+FCWYiiC1mG5IE3fGfjdIRCd2FYbJLsekEO7JV7CJXLejA0Af8W?=
 =?us-ascii?Q?45m65g+DpWQoHfVO/60HTI2IBEn5wYkESC0vcoUC8EnDTLnRgOHW1h90DU8w?=
 =?us-ascii?Q?LQK53kB+B0lh6ZglF3l4WXGIOnRlHiTYYDkFnDZmbBS5dplMTAFDjzqwkmJR?=
 =?us-ascii?Q?PlbowB1lxzQqEQ1ssWBZL/GkdUPvFhmkgx9r6lUp/djCzubXscDeEgjptKcQ?=
 =?us-ascii?Q?bEumQP8iOpplIoSDVODj9QkUQEcpeGy+gxQrLBrhc1w+GD9N15HxH5bo6non?=
 =?us-ascii?Q?xm2ztZJY+eVgPK9wTgbPNa1nG+BdIdqKoA6bTqGgcU5FB0vZpYMhYW/0S0XD?=
 =?us-ascii?Q?9ZdmF6RUpvZVh7PPktyCkcQRmFoA/3IOhuMa2IDkyWkT2UsJAc4RzWbPk1xh?=
 =?us-ascii?Q?oesHJkMZsl9RkuD4Eue9StudNA/O3JUbqX7sMHUhxDIy1pL6i5lCnk5hJ/iw?=
 =?us-ascii?Q?+8zYpwUu2AZpM5TstUH8LJMt6jUaqXo2+ODaR83ZYCLQI+JhGl5e89F9p2wU?=
 =?us-ascii?Q?QwzR5S60tkSSlkfRohPNdPcwX/gE0XGKNGdT3Jve9fJJOrqzAfRGRhY8Frcv?=
 =?us-ascii?Q?q9LmQwb5tQcdHyC2rrBRPd/0ejvusI3xGxCSUcJ1SPJYFboAI86diZVPKiTg?=
 =?us-ascii?Q?smD1Ztd87GToQ26rPDOyr+WtTvwczCU1Q7/Qj8+wGKPqieSKiL599gBq7yBM?=
 =?us-ascii?Q?Nx9DQrYXSG74iul6vcoRmT55YsGdmnHWGpLcIzQd/urAuWYxotNnUS4nspKJ?=
 =?us-ascii?Q?AV8iyl47iOKizS8NJktpxTe4mWI6Hbm5Ze+CWmWG+zUcRoo9xU56Uk9olajf?=
 =?us-ascii?Q?eUYPfa1AK0JLskGDjMBaqxX6bR73sqYXbh1xw1ZiePtlWqN2SF8zvQsct9/3?=
 =?us-ascii?Q?2UVLyaGX0LjxjQFnZtPT8laeDMLniyq4emtJr09qh8niMj5k/YsU6eaaDUpG?=
 =?us-ascii?Q?qn3Se80KrstFrihZsOc0hNYkJXbtG4A3ghgLu4fS8h9T8Cy8H3oYDVq/ISw8?=
 =?us-ascii?Q?CTWHVhLyr0qabQDd2vBz9cDdF0sP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jooipzx/GkTmwXbYWMQ21hFnxk/GmuV1WPmmRuIBqRQRgaaqoLNGwMwUR7Ad?=
 =?us-ascii?Q?dld18sTiZ5rc9k+cpsjlIbxBQB1SQ/wDFvRSePgXuQg2i3uLZ7k68U52QVZV?=
 =?us-ascii?Q?OlQRARpoErkZ7EsPFQiToB1P/bO9nUwLplBLNvH8im8URL3u+uev8acgW2gv?=
 =?us-ascii?Q?ofp0ibipAhe9MAor/WCrkA66rjq1VIlwQ1AWraqisOjv0owx4r0vHJ8ldo1D?=
 =?us-ascii?Q?Sthc/5v2qZnLFPgRRSe1Z60n0cEQa5tl848rmQn8e2rjchkJVBzTFz8cXr87?=
 =?us-ascii?Q?NAVG4aCc/fTh/Ls0UmfS7MU8TcxMikTRvmdK+lLaUO7SifSbmTSjh4o2htUh?=
 =?us-ascii?Q?W/vj7pxNHIwKO2VZq59ujfRb/RD72wRVIEtcBXG+etjSIxSsFxZbaUW7dtWG?=
 =?us-ascii?Q?PmV6+jx9vSZtZZ7QSPHlE234EG8PVJpX8wFlQq37TbxJxPWHxB/z3S44SxrH?=
 =?us-ascii?Q?oTKR+N8c1WOuGvCjGBeykRv2AYUXzYjYAVfvkEktm5L4RQPyyivrOv4MvT+S?=
 =?us-ascii?Q?4w+X6KPo9zTJ7cs/XOtAk9a6u9cXENVfvSXlfdkfD64+msbz8TDuFtJ8nYpt?=
 =?us-ascii?Q?DvXZJWQzJ/pVvFWb7iI8jCDSsF+Hgf64d4OUjeUjBl2+FsnHZUDObOMfDqJs?=
 =?us-ascii?Q?X0m8uZOUajwp94uEgzqSaNawkVufg+VEYXpw6c+WmH7LYFFzxTmOHLFY3j/M?=
 =?us-ascii?Q?nLQAftvzkFK7cLBOI9esqEOiZMHQG/FkW/ZNndRNFRwk4rTzWAYHLJwkOU/p?=
 =?us-ascii?Q?bZZyQ4dVWcFXAygvpAJurn4Yt1GGvl7kzYY0X2L+6AwOz1AonW2Ck1ZMQK7C?=
 =?us-ascii?Q?K7ZHODjw+PWCxi7dIJufDtveVxnvnc7AHneJ7sR+6KUIApEBMwjZC0WzKKMP?=
 =?us-ascii?Q?U210v+0vQsBPrJt12I20U9XBsMjDJJz5vUip4riHCfW+MvwJUEr1Lo6kqoAo?=
 =?us-ascii?Q?QlnZRnCM8/3WVGT+pz4Jif8MpjrMhKGAMNSyN8QhD6wLX3CM4KoWMZDXPmPc?=
 =?us-ascii?Q?4c8f6QNKNfzLNarw1720z9z6JNCKUuzrFxE5EB++RUFgz1HqnxEOhl7HB7Pn?=
 =?us-ascii?Q?OyiTOS19u/PULBTlhlYlvgkdKgDy+6tIZnYK6WVB79k5X8CnCvXIBmd/btep?=
 =?us-ascii?Q?zrLws3xC66zu5zQCguQzPm/BSokNEIXTTEUmC/1GXQWqQWOi6lvqsoEgcWZB?=
 =?us-ascii?Q?1y6P5UNg6H+Cy/kO+Oo+jNHAOjJMWDVfEQGW8RHWdw/xeDZPWt9ZtewiJwBR?=
 =?us-ascii?Q?1JCs4ECmyKmZ7dvByNoCfZO3JbM23tjfyfogrZCwfDC7dJSbU4wL5WvhOZZ5?=
 =?us-ascii?Q?y8jw58UFBWoQHITGg3yftBc0MFHp6YkfbrjLoR4hc9AmLihWeoX7q3936ogL?=
 =?us-ascii?Q?sK6Dd6ZzS7BQn+6ct8ZyZD+e8yyXV1BD3oS83Xi6Ye1Doh6hBQu4wXl262/n?=
 =?us-ascii?Q?wIZv2ri2pPz3o+LhesMgyyRdZEc7p+PwS25zyZKKUV34UhR7ww/o1LIyBZ0E?=
 =?us-ascii?Q?yqqh/OIAvH9zdQ5T+8qZq9bnvio2d4wWGs1so/S8JcRzTw4Wdtp4hDhAoMVh?=
 =?us-ascii?Q?k0Xlb3lsyxFXPAyHsXuf/Wbr1W6QVqoFb8MFkv/PHTjpvWgysRAeI3kk+u1j?=
 =?us-ascii?Q?4tMjEPFyRs8Jq80hSiO7nSI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A94303BB01736459F2EB06635573E46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 77MrPS5AZsSNJNMYxQvqyQ3AqFgeg6Ef1uNjKqWA4Bbbf+7g5C4R5YPqq50KvGG3bPHQWbHI/KNuXCYhOSqV7RKwdb1nsDAVAXXFNN04R94ItFJOYtwJCRtgROskCKIhpKSKN3BJsOYhe6nExFdfxACI6sezq2Y7VocwLcmUztdTqO9jc9DsR8ZnlAgiKuFNiaumy3VybXxhDHlsGLPjbJA3Bm4uKUmSdLwc66QrgZpgLP/6nMbjFeKIGtb27+nP3aaAUEY8fioSaDB9QcuW4IgYlM5IUA4ceOnNWUlB/dVgbyHZoKnVnDYVRV9GGI2S78mhvpxvKmGj3aH/XVvZF1YTGFcV8ROSkxzeJCfTpBF7rQJWlhaMsLBpAR30tB98HI1vLa/99C0b+QPSleXDUyPm246ZFCoKwe2ckOZVR9pRmGIfdeIxqFar1PdQ/+LOdum43mH2lfOSgiBKAGguuCWF5zE27ChY6i4G3oIt9u7fKkznQ39hBfA+nyeMM1qk+4UchAxs9OsRpdVupb80ldUTHCgcPXjdtcTl8KPnpZcewJSKst4zBTd0RhE193WXKoUOO99GXjnH3wrPvwoEDVOOW1IROO+4ZCZV4tE4/5JBdQhz3mxkSz3d/HljgU8Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8416df-4f34-4be2-3943-08dcfd845e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 10:26:54.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5ubsb+Dv3Php60N9tqinKQPAHZTSsSLCmyYeBNcyTI49LbyF4XaFfPL3Y9CuCdsdcCWhQo4rQFoyKaZcjPm4znylYwwbLVKTCEbBgCJuFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6995
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_022659_389203_3E995777 
X-CRM114-Status: GOOD (  13.86  )
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

On Oct 30, 2024 / 15:51, Shin'ichiro Kawasaki wrote:
> Hannes reworked the nvme test group scripts to support ANA, or Asymmetric
> Namespace Access. This work is tracked with GitHub PR 146 [1]. The amount=
 of
> change is large, then I split them into a few series for easier review. T=
his is
> the first series, which prepares for the ANA support. Review comments wil=
l be
> appreciated. It consists of a number of improvements, such as port handli=
ng
> improvements, helper function simplification, code readability improvemen=
ts, and
> so on.
>=20
>   [1] https://github.com/osandov/blktests/pull/146
>=20
> Most of the patches were authored by Hannes. On top of that, I added 5 pa=
tches:
>=20
>  - 4th 5th 6th: fix issues the 3rd patch caused
>  - 11th: fix an issue the 10th patch caused

I've applied the series, with a small change to reflect Daniel's comment.
Thank you for all of the review comments.=

