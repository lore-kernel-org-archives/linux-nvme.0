Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9DEC3DA49
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Aug 2024 09:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hrpm4VvzBt7edfwlCanBXqSwvwiLA1e1Meeub74ld94=; b=EJjiwhye90HTk8Pu6hThPFyNOx
	GKCFZBnZdjLvgb90MJVUwtyX1gC/cu1GGN94K3U2ze3BaVJ2narN5w8OfviUYgYFh8/+SRnqp/4JJ
	F3ck4GkItzXhQXQNmZNq2imsExbaYgbcpFc8P/aextZE64FDN/vIQd6SIEex+sGWmZf4v4JSay3yF
	BFRpefTpFrpgrhBrUWxvDJ4lDC7p8TfEeFm1hke3BqAxxItL5kAVSaAARmJDK6MEawGgGZ49Oabrl
	r2P59EdIu4ee7mJYRJztRTq9Dem1259JbV3AWyq0wpc5U00YxsL7DBlcJzWel641gfFaHORBeRnpc
	c/Zv8ATg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZoJi-00000008DSJ-38fl;
	Fri, 02 Aug 2024 09:11:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZoI8-00000008D01-2gsb
	for linux-nvme@lists.infradead.org;
	Fri, 02 Aug 2024 09:09:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722589780; x=1754125780;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Y5o4vkVdLAIy3GPjPGS+BtNMelgFnpf2W//IyPk3b9I=;
  b=X+M1CBXrVG5N7GG2T4c8U26uGl1tlam/kmZEUAv+sAShtDmBQx1ZGUwk
   IirfWs7kOc0cAIhSby5GXJ+ifFOVLaJZFlol8oY9sWryfPswOcjzCjoPm
   ut+F5Clxn5xc7QfxIf1Qtg18xulgHgVKIjoauULTihTHtpwvwruFRWiUD
   h7dYHWVpD8NNsjgxTxCXvKv5KCWMa8GC4ghtz9BQ/Mmh1Vj6XcZ2VENQv
   nPAeaUidp23iKriESkABotLadrEeEXwI4AomhfUGaFrPSK/T5M3FCMH7S
   bZZefIR5Nr/BVZWKZZsbgFg7uSgRunTQ7cip3ftjwxKJGnefd/zaSXARu
   w==;
X-CSE-ConnectionGUID: mB0adR0lSVWchD2UPEyRug==
X-CSE-MsgGUID: D5OtwO+zRGqIJLBGanM7Jw==
X-IronPort-AV: E=Sophos;i="6.09,257,1716220800"; 
   d="scan'208";a="23364449"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2024 17:09:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+9FNxQIMdUZNU9ZHY/ERBPQUCtoAAsR7FXoB/0vSxq2E+CppERIZTydRBfxfjp3QUTuKezoBmdNWxSyVE+ZJAX9uwiEzN57cuqEdT0YRDdbMUwZUhYXtRUPrVWpW9Mn/xY/qDn1tMehRg4FFQmzbGS9BoI5fmLGkn0eA24rZsVsV6s+j/wlmAcpPQbu6RFHuHYIqa9uqKiegpICJQkUMbx7dO9A98CELtJ5jF6ra2eNwCIgU3Rs/UUOBcgUH+w9//E1LuZbRWRiE683q1pTqNdQxTHm/EvvOha3Pz2UoqTi80xhRjsZsSiMa9KsUQbsXv7aoQ8oBaAUP9PiFMz2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrpm4VvzBt7edfwlCanBXqSwvwiLA1e1Meeub74ld94=;
 b=i62TjQW38TnokSGNKnyI+6bJhw4waA7fQG5oyk7WDsaCPq/IIyRjyFERgRaDqbmPlZv84HzvF+mg/Bfz+eyHAEjssXN2Yw/IadV+AHsopuho2+D6dw2QtxH3TQ5gAiciuK5okARi4h8D3e9EmLmiP2FpSzCiZKc/tOqRZTGYvlKwcpt6r3Vt3QFQe/p2FLqpRTwH8JNUQk2siMR+3BeJumZYpBVFx7aBU0ZQt+Rie4hxOEzL3vhsaruy7dSK873xa+sXKAlVKsuzbZ1xmETlMLvaLO8GG8QtSPakPyID/AIFe6ZmY3J4LZeXKX9TrcFERe0XtHnZNRYoWPWgWJ/87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrpm4VvzBt7edfwlCanBXqSwvwiLA1e1Meeub74ld94=;
 b=keSoDHFLTEMXDelvfAMhu7xH5uM365X2e+H8XO7x9dNrtfmzmjY7FB4jr4Sr2/LLC0eiMwM8oqC4rD++S8uvSXeQzxygNeA+d1sD34hmS/dpiXjooYp2RLrogzYHscpok9sVoWt8Guxs/v8WwpnOBYDP6DDs039CGZHr2sVua2s=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Fri, 2 Aug 2024 09:09:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 09:09:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.11-rc1 kernel
Thread-Topic: blktests failures with v6.11-rc1 kernel
Thread-Index: AQHa5LuxC+CuFbi0TEaEvvPM0kqq9g==
Date: Fri, 2 Aug 2024 09:09:34 +0000
Message-ID: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7821:EE_
x-ms-office365-filtering-correlation-id: fd05aeca-d372-4fb4-6d0f-08dcb2d2d3f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ukxA2Af1n8nPnhfm3E06PtScUiCrO/jVmq/STbEdDeOiHK0bMrQwZP258YCF?=
 =?us-ascii?Q?BTrsdc82uc+XXCw/7LGB3LKiJXHctCXc4HSbE7bISq9QQpeUSETKUVymdZRe?=
 =?us-ascii?Q?mwWpAU2X5fdZjOGqqd/XmrR7JMaBNGfiDUNwX5J8mIYW/7m/4JTrRrLSnv/D?=
 =?us-ascii?Q?LS3k6kcB2jIGN2LO2cvGaLL8OhW6tfeAb28WgBmTn7HMTI7RqceIhYU7RS+a?=
 =?us-ascii?Q?xhCNv0hH50Md7WyIk74q1Wf2gN9YWjElHH9zRLW3GoLcLJQBA9JGQu0pi/Pu?=
 =?us-ascii?Q?iTJ9qeapkfF/sv9qYlzEcRfa5ldm0glXwFI6J380ke30OvnLxLhHlXBBkipw?=
 =?us-ascii?Q?HMRg94wfOXqmDORrbDIPjopuKlvNo7Uny2ELsgv/CGzy/HqDFQAf5WhBA7LN?=
 =?us-ascii?Q?ePE05I2ODtydX3yU1yYGBUG6FKQKz99lXOiWTKXaw55HkKe3+cV8Gs355Pcj?=
 =?us-ascii?Q?cU6xgf8/kr1os0bJF+sZRExjNLVMwoWJQxYJi7VCG4hEQ49GRtroPW+wf0+6?=
 =?us-ascii?Q?BUIlPj6aAi8mCdjcmWL+V5oi0hkRbW08cUSuUNo18eRnbXxfF5Nv2GIxvIiG?=
 =?us-ascii?Q?fAD7WUho3vBHy9M5Cuc0FVaPek2+J0coEjen02JyhYXgtX7JWzTawObp1MNh?=
 =?us-ascii?Q?I2/fFQWHRujGCcO6lKqWUr1edaTAKSoSA/16OCB4qvYrR9cOqHYgJzNyydUG?=
 =?us-ascii?Q?0RWDVb6hU1welCcfIXaOAS2HtU10pvc1aUyWd7ICzAl1CPvdHWn8RRl9lRUX?=
 =?us-ascii?Q?LLP8KZrt8hQsHmJyOFJ2sxz9mdHsmdef+7jrxMziQAR4VgIEm9HiGKOXTg4E?=
 =?us-ascii?Q?PaschTKouElNxlkBdWD2KQXMXL6NqlzHlJb6fB2HQLhm8Thurk1+bhtBs7QX?=
 =?us-ascii?Q?0z5ikuBJhkrioqPj05xXRrNbrAA+/s4souxfa5Gt67RbnXkoqTfKyncKTHiA?=
 =?us-ascii?Q?sGrr129YTVMqFWZFUOsG5X3eIYRu2ARd22uQZXvb6BTd6KHsSVZvCcvTUu6Y?=
 =?us-ascii?Q?gsZUzl0KEtPlwNhJiAJyr9OrBSjmKx+WsgT1UleMv6HaY9qvoucVwEHEprpl?=
 =?us-ascii?Q?JiN6pIJf2OMtygK1UXYmjf01ZuoxWp6QhdHfCKWm+KJJTZ9qCB1pxbvM9k6v?=
 =?us-ascii?Q?4di7YnXGNgAF/KKg5Z30HhHH2y6RWWtHDbzSAUIq7XN1KOkRRUjU7RdVSMF4?=
 =?us-ascii?Q?dc77Be9Bl+m18BOafG4DfN7e22S5jjfvGtqZLu19uKMAX6Vb3LsvurU34ou1?=
 =?us-ascii?Q?B5i99iU18fjoPtUUT7cyjhHTnSQ+3G1zC8Q6fAchFMvThYw0CvjeKF8ZtCjM?=
 =?us-ascii?Q?+rPATfdFHM5ZfO1gkxp9Yyh+c4uRHxePE4XIjTKc1mpdADWoIqAPtYqAKX29?=
 =?us-ascii?Q?qhrKSUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2k/OEX77lvek1GEi7UdgpFDpVPnJQ8XrbgaqO60Od6Bzom38NEDqordst+r?=
 =?us-ascii?Q?OS7BP1rstERWhWXTGir+ZVHNNGKEY2xDtvLU+WYXW7B3Wnes+k9wnuAnt/pn?=
 =?us-ascii?Q?bPOdzxlw5we5tJ+A4nqOXxID5d57ivgqJLIH4z7yKNBimeUgVfdSAmaYx5Ya?=
 =?us-ascii?Q?cpgb6v43Q4uSlpnuDJXeQDcWhKXrdUU+B0xLajPY/zFqqpm65f8vRpe8TSWG?=
 =?us-ascii?Q?rF+aaFYqye6+H20cd2gK2LzV5rLsRqk5kp2vYCeTQ5737DMW08VKK9pYLnCB?=
 =?us-ascii?Q?11eoBE3rM83nqetJ+MRA4nzvLV1IBq5Zf+5+Mky4eF1pNo6kUgG9/nkg+Huc?=
 =?us-ascii?Q?X2x29+8fuqrdnMdx1D5uuoJchAxoLLPjpT10g7NxvAlF5Y+nZsCO4UPBkzFF?=
 =?us-ascii?Q?3tIFwQuE297DF4zaDu76M3qqK5EZhHRFHns/hJeXdZwORT8T7r6ztmhHajaO?=
 =?us-ascii?Q?PgfCb5V9EI6GrksnSh14GFZjTuVR6/c9XvWSOX8AI+6aKV76dueE09m5lf66?=
 =?us-ascii?Q?oJIeBrhBX9f1sdRmTJ8P1CU5QFc1KJGod6ZUW6lTFYmgqh82fTYeYyAw13Sf?=
 =?us-ascii?Q?rPXrt5QD/10HJMbisjMR8aCBO+Iavf9LULjYp7SP68rScjRg5IjElVIGjRo+?=
 =?us-ascii?Q?rSrk5hxLXVi/a4wL4icir8mZeIVW/uo+y+B0oqGbHA3mm3SDboatrX3W+bmW?=
 =?us-ascii?Q?EP//FCoZJ7IZUy6+1F6pOxTiOaFjFAsGZh2qXQMU5QIDPtJAv/JZnF+fmnTF?=
 =?us-ascii?Q?X9jncM3Nq/UdjInpaS+/uDmcWAUQEqfn0GkYogMjZvCAaP+qgxtgecv0g0rc?=
 =?us-ascii?Q?R8/qUbBP9O+okiBI/XdgPE80veeg6eOm+RdSot5N7IAhPdydZzyCIgVt5GL5?=
 =?us-ascii?Q?eWctaqfG1TIcOU+qL0e1nh3cvXLqWw/w9pcRjunOZRYAGpUaRjyXKbfkJD4e?=
 =?us-ascii?Q?szwj6/AKzqleYyE6wEK0lT4CicCQD5ZfSPx5flDW8Iy19Kcm2w8nvGHPMRZ+?=
 =?us-ascii?Q?Qs2xXE6tNpoIrp6KAG9ZWSaW9yEAk0YXCBbvC+GWjrWVTtesdrI0i9daNee4?=
 =?us-ascii?Q?13veyUZX9qwKcWxoidlRxnD2fnjcTyXtgdKfEpsR11FAGxp1RizudJ/ALfBK?=
 =?us-ascii?Q?SHDtq2kHn1X8aCgtR+aIF0UIiZc/jOHHd2DGQyp17qs28nJOoNj9WgyPtMBz?=
 =?us-ascii?Q?G6v1F8TRVxx8lWKnxzZtuadQvVIrKejtr87uhfLHnCH64xtw1AbXiFg/Sy9q?=
 =?us-ascii?Q?x3XzNeEflQKOAO8F07r4ObAg5HBjA7oaTzv45pQ0hT/5Z2g+n3GlL2uWdmYe?=
 =?us-ascii?Q?01QlqRZXZozNex6kE+ss1sIxRXhmtVP3znVbKMGqr3lx+k6NilsVswGqXWfM?=
 =?us-ascii?Q?6apOQU7PnDEALCVrTd9N9bgYJH8flwrevDlJEuC/5yVWkkkjmpP9Gi4mOv1Y?=
 =?us-ascii?Q?DBOCSnRThPJ6Pzc0OygvgPwkCrHMc1oDgEW4ev3zCTsoy5+FpiAfyHvtopuU?=
 =?us-ascii?Q?8tLb1t8/uMdsUpleLZtvaBsbmQ9W0YqDeoLwb4j/Ovq4qGl2XtpqE5/VFIEp?=
 =?us-ascii?Q?nboImMDnmgmlNWn52pRMv0tXkCAWYfXwvDpfWtHRqiWC4ru6H183EuOGFpVl?=
 =?us-ascii?Q?VT0hXAXyQv2Wisvg30c9V3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A17E0A46506184FB2D3AC1CD602A266@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UDjr1imysr4bcflTuWX7YeBioo9/VzCYGGF1Cb8rFnd9w6MPRG+JrFlAtUOheGAsfrd2tas6bU0U4q6ch6E06aA5AW8dZx3UByw26asUJL0ibZv7/r7WJG+4sAq5WsqOq/RS94Yq79PSrCwI/rytbAVZhHoKoB8FRMK8LrmICIFMY4Zpex61mOin2p7bHIhxjSsR0RwLAJNqqxkaxwtelfwExBfSuJc+UCfXxkoXTQpEflQB4HIeAYPdTI5OU4w6kd2JH5/mlvoYEVjpPJ6AZeqwzPFPfXa1//lf1FrltFcAODoV6n2lHV7EqboNqEqSLxMs7HoAibyOp6/ClAIh5/Sj9avBlKWF22nPGlpSr+DoXS545sNOdFkeC/z6J25l/kvdHCo2xDnNj5v9Ane5pBriqeWkzT4D94Ho+lRsdnviOxxBk0XeXbxchVIA+Tf5GeuQYTVa3Tq+bCqECJ7f7VLlW8/iErjO/sjAEaQHwcG2iZ2cm0zOyxoYCnuhuFO7DFhG/dI6ZfSG6r9UTkkXWlj+Y4erM0fVWStaODvBMId00ewm23q30udgl+C63sVmQHM9HE9h1JKaduL3R265vWgX2wk2A6DWWmJeaG4izr8lMp+uIUcXAWJbB6qCJ3a+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd05aeca-d372-4fb4-6d0f-08dcb2d2d3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 09:09:34.7980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVrzrfXx9Q5dBaDyzRDeVTRlzVoUBAoY9LrqS2+mqhkJE+WSwsZT8Ol3bhviR7eSgg7V8YWJuHozzDiDYCioUouqVGLZUTxSbl+XSfE5f88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7821
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_020940_779624_77F42930 
X-CRM114-Status: GOOD (  12.07  )
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

Hi all,

I ran the latest blktests (git hash: 25efe2a1948d) with the v6.11-rc1 kerne=
l.
Also I checked the CKI project run results with the kernel. In total, I obs=
erved
three failures as listed below.

Comparing with the previous report using the v6.10 kernel [1], two failures=
 of
dm/002 and nbd/001,002 were addressed by blktests side fixes. The srp/002
failure with v6.10 kernel was addressed by the kernel side fix (Thanks!).
However, srp/002 had another new failure symptom with v6.11-rc1 kernel.

[1] https://lore.kernel.org/linux-block/ym5pkn7dam4vb7zmeegba4hq2avkvirjyoj=
o4aaveseag2xyvw@j5auxpxbdkpf/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/041 (fc transport)
#2: srp/002
#3: nvme/052 (CKI failure)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/041 (fc transport)

   With the trtype=3Dfc configuration, nvme/041 fails:

  nvme/041 (Create authenticated connections)                  [failed]
      runtime  2.677s  ...  4.823s
      --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
      +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2=
024-03-19 14:50:56.399101323 +0900
      @@ -2,5 +2,5 @@
       Test unauthenticated connection (should fail)
       disconnected 0 controller(s)
       Test authenticated connection
      -disconnected 1 controller(s)
      +disconnected 0 controller(s)
       Test complete

   nvme/044 had same failure symptom until the kernel v6.9. A solution was
   suggested and discussed in Feb/2024 [2].

   [2] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@sus=
e.de/

#2: srp/002

   New "atomic queue limits API" was introduce to the scsi sd driver, and i=
t
   created a circular lock dependency. A fix patch candidate is available [=
3].

   [3] https://lore.kernel.org/linux-block/20240801054234.540532-1-shinichi=
ro.kawasaki@wdc.com/

#3: nvme/052 (CKI failure)

   The CKI project reported that nvme/052 fails occasionally [4].
   This needs further debug effort.

  nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem)=
 [failed]
      runtime    ...  22.209s
      --- tests/nvme/052.out	2024-07-30 18:38:29.041716566 -0400
      +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-te=
sts/-/archive/production/kernel-tests-production.zip/storage/blktests/nvme/=
nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-07-30 18:45:=
35.438067452 -0400
      @@ -1,2 +1,4 @@
       Running nvme/052
      +cat: /sys/block/nvme1n2/uuid: No such file or directory
      +cat: /sys/block/nvme1n2/uuid: No such file or directory
       Test complete

   [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275=

