Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E255BC18E7C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1NYoWSMWm6jABY9nkxEQacQR+4bCbszOSR+2jijp0M=; b=IhtPkJgnLWuLpbqSkFaNakwt6w
	32BdJ4zfw/OeMD0SkawWCbNQ82mL6rkOOGZbUPKAfT6lrD9ZrodIV6XQNeZIhkBcRevMlSJT8mPff
	PujzM2CW518t0f5WHu27eijgmP0/aO8OE388yBzG+NfVKpywy75OYIrPcZ7962laxd32hmOX97Ue6
	ljtNElmmSftoBvBfK0IBZmTCTJ26pKvyOEjx+jhynQMEweR+AfKu+Mzd3OoPYoGdLpF8vfMrZsF0/
	xR5rpwFI9ghJkiQXU6vnOj6bATdAeRbfyF5aI5pLBC00VTbyF60hVFHPYNWNc4lbP45Th0CkIjcRe
	gyGB1sIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHSC-00000003u0O-2sAt;
	Wed, 26 Feb 2025 13:28:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnGXw-00000003gei-0DAT
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 12:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740572991; x=1772108991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K1NYoWSMWm6jABY9nkxEQacQR+4bCbszOSR+2jijp0M=;
  b=ZpZ1cT4L2z1C0hx6x0zppW22fVd+LqrT9RCggTpwA6Yx9IwiZLL764Xt
   5LR7Fq565A4MqjCSK/okneSCWqilzla+rLlj6+yllGkabEwmQmp5JiLCQ
   8qYjg0Gop9T7hXIULQM3hPpGT2dWe44l2zhlnoBILPddrPtHDbFnNGm9E
   yriiog9uRY5kvOCWANLexiGd++XYeEsLD6QFRU+emXagn3mzoiuah3Nn9
   175ODsLLPhc937DN/cW54kWCPppBcFMcknhzj8vf6YM9J3WVICxlDjwHW
   uuHeqSzgKb/ehA/4EvviqcxfIfYtZmIqU+IY6EDgvAqjCXJBN7G8qeYpu
   g==;
X-CSE-ConnectionGUID: 75exHY+wQCaXy5OsU1s78Q==
X-CSE-MsgGUID: nnb1n/C7TPWuxb/nwicEVg==
X-IronPort-AV: E=Sophos;i="6.13,317,1732550400"; 
   d="scan'208";a="40210038"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.8])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 20:29:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjHo9S2JN2xW6OLcw8FVRxXcQLhIyNx4sfzxDUwlIjzse2q9QBzt0o+Gw567tQwOOMTJo7DGSsOcjB+bQhmYTFyHzSoBIhmWwVBYmjbbv312Zs7weICFJWTKD9Fm8pD8o453T+OYOEwhJF69HaVJJ85NSUzptdUq3mr/OIJW2iGV3bGlcWuBN98zz2nG4qHKNhjbCYmI083HnI1W2bwlcaA2M/fNGLvYXW71XYzkBB3Ijvaag0n5xosT5B7foBU4kYnoj35mFuh3Ju7xYYBhwJTEIPipM9+m7Dr1SjEkGZB8MW8TbBnuBkrFv6uBZnu1m24FOh8lUFg32yxrDuQaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1NYoWSMWm6jABY9nkxEQacQR+4bCbszOSR+2jijp0M=;
 b=O4/B4vfmSteHxkf1yZIT2O4v+p7gL2FBstoqnK/mCNeoeX979YGKmFd9H6Mf26jOwXJzZScKVi4ElSrMjMfPgNVxqHUXh7fUDhZ+qmVts0Q3oXVJo7rTHXEA6lpz17+KdRA4z0y8O53dhtqayXsC9L0zRglxVB6IH7m5g4rLSgLUi9LKlGZN5NWVg7mjVTKqOqhQujlVhDVg5mU3X/PN8Q1bNwCDAMLY/ZXmG3OjgEqT6d41ksc9kyDvUX3Xfge2UYSG7VNzMrHqqHWlPZwybZOm6wGme3MHb4oYZZEw8zI4MdvE2VVSVIBUVzouulL/vavy0+LF11kJZH5Uer/pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1NYoWSMWm6jABY9nkxEQacQR+4bCbszOSR+2jijp0M=;
 b=zmt58wu8ama3h5Gb9ito014XOuupHV3ESUYimVhQr4DRE7RZg8plTenuezvyxDZ8czOn8Ysy6u8gWVNqxMTX11h/Wi/Ocr14IWNoFFHlD3yxRsmUPsVuuDGVSp7qkGLxBZq4DNToQMyNpBPBfU2vGfNrgqpk7nW7/azsp1ne9A0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH8PR04MB8616.namprd04.prod.outlook.com (2603:10b6:510:25c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:29:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 12:29:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 1/1] common/xfs: verify xfs_io supports statx
 atomic write attributes
Thread-Topic: [PATCH blktests 1/1] common/xfs: verify xfs_io supports statx
 atomic write attributes
Thread-Index: AQHbh7JDCZra4fyzdE+INYMH9VhbybNZhNeA
Date: Wed, 26 Feb 2025 12:29:45 +0000
Message-ID: <mbswl55ynssfysmeekg7ferqwk6jonafmd67fubce5vykjlaiy@u3xzn2o5oxj7>
References: <20250225183108.3881328-1-alan.adamson@oracle.com>
 <20250225183108.3881328-2-alan.adamson@oracle.com>
In-Reply-To: <20250225183108.3881328-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH8PR04MB8616:EE_
x-ms-office365-filtering-correlation-id: 1d7ca650-7a94-45b1-1044-08dd566140fd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6Oow8i+QlI6GyplZ7nofUOePXYA5QyFjbe6FeozIYgPUYEmseqzWvQdE495n?=
 =?us-ascii?Q?FjUvy4KE1xK64CnjFO4TJVS4khgDwUE8M5ncwx4BIpP9+yjnjbbYpw/RfDk3?=
 =?us-ascii?Q?f3tldvtpF6RgP3KSnGyZYHZtYiFSMsHh/JuH8k6XKKufhalCITTL16e1qp4x?=
 =?us-ascii?Q?GPz4ELr0luwnyOsd91rrtBXeXc1CU2AGFThk2URW1h4i6V45EODcO8/2J90q?=
 =?us-ascii?Q?1BEQSKZVMWVWp3dbH0PSJTXZpUd6+IhpoYcaRdOfWl+IBaAVYbIh3V+zowZd?=
 =?us-ascii?Q?w8O0Ejeot5Q9w66JDhg+yTap6taWcvu15ru+fD9duRlT147D4w+B2GhQH86F?=
 =?us-ascii?Q?zPsxuAeUJkqfkpPI9PrAPj4QFvc5jHQFFfBbOUbqs9ngPCQEU3+HBZCtDrNp?=
 =?us-ascii?Q?RnBSzcue3aETtgoaBTiC/z0EBctNuJd15bPZ9gRkqqrxiAouPCCdIWAdfRZj?=
 =?us-ascii?Q?C0At9t0yR38wfSx8jmpaIWFh9C8M8lbME0YBvGrLGqlE/T2+pfkvnDtrU8O3?=
 =?us-ascii?Q?suiB2kAVI6wj+B02kPG8nfLh1a023iOmUeS/NDFZ9itaoUGkez6wUSm4QcNJ?=
 =?us-ascii?Q?wPWfkT7u3J13yaPscI/QiBXZ8OQ2g2UkvwwRcaEMTk6e80hIAeW92eJ9lVk8?=
 =?us-ascii?Q?ZClc8df7pTVRMEbU8Wp0Btgt/UShF7Lp41guK3piZ+QIRTXGVQT/ctaquAa/?=
 =?us-ascii?Q?NsXK4w+R1ZL8iE9m58RNYy6FNyx/3Fm8zwZXXukzo8ukIqV6l/QmkSziuSMV?=
 =?us-ascii?Q?AKP4ZyWiYmHDB3VOh3S3SKcn9PhuLmA1v53KL6FHko642zocLw3JYTwhHiFf?=
 =?us-ascii?Q?eiNcaQNHcWhjc2+jGh0os/QEQlBa71HIaBanmDgELQMK6GdVH6FGq8TqYkXb?=
 =?us-ascii?Q?y/mvP7O399KR7oMd7QY7CtdxDQkNVlh8VzVPrPFX42miJTc4AdBNrc8YvmUv?=
 =?us-ascii?Q?DXHKiUNOGTk8TwvkpHL6zAzpD/OWCtpukHZHmKAoGblBO+76P97px0U2sJFU?=
 =?us-ascii?Q?fjkTWVJ6Oefu+Ki5857mg4/P+37+UsuKw+KgSIllI9xlUCxYAf+HCfUSj9++?=
 =?us-ascii?Q?H7Gsr5YJ6Da3waITy392qiY8SlHSkdQ24QqMiYlD6Lxw4brNfE7roUW1mL6j?=
 =?us-ascii?Q?0kNuGgRYUDlqn5dLVQp/ehMGs9u67ghHBMDRUfQwf9Jvat0lVdzoMbW6HDWD?=
 =?us-ascii?Q?lpnRkCfEtqSZy5+LRSJx87oZC0W3GHuEs1EVm3A2ID1BeVmMIMMR+5rgre6A?=
 =?us-ascii?Q?AA7kkVDZrljYWOsxMzY4A/0vkxMB5CnML9FGt6KyFrVo/0R/BGcysHDtSeK/?=
 =?us-ascii?Q?J1JsSa1gIDk+LwJko2hn5y7Wac1GD7ZzOrX90VYbPqe3V7V7Nr5eH6GvBE0r?=
 =?us-ascii?Q?+xvRPWXH8o37OFdS20+KkOLhy46pyKkKTpu6Y2mmCZyzKRmBrLT61XJkPStM?=
 =?us-ascii?Q?PBpaFdyjiT9sor7R4AKdPgW0d90rhufz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5RdNuKhw92fmyI7IaY1sPNfox5wYVTJoLAb88l/TTh08+n7EDJ0TPZj2wdQ?=
 =?us-ascii?Q?CNjQ7wmOgJZi2vgbNwrzADOA3xDGI3xTd42h8QlvKhZmCfy0QTL2q0hfSTVF?=
 =?us-ascii?Q?JJxcA6euFbbzlWJKZFNTjdcd1QS1WhgGfd+DWnXQ3tGQkNRAIcsh4E3JSKhv?=
 =?us-ascii?Q?ckO4d9G0rBoDsl66WDQN2zhXXB+uHdcqml4sU1aoDSgQCHTWmdr/h15b9nxW?=
 =?us-ascii?Q?whHtoK8iNEX8hsGIs5z18juwiGMSjP5Ccbc1d32XLl7ldIqnlwfOy1+bo5hR?=
 =?us-ascii?Q?Mvqi3UdjXeij42E9cV7quj6tE3bDu+4WyIG7f0unl8hLJGobXy97XJh9FWVn?=
 =?us-ascii?Q?pXQRTY+s0eTUkc8H6zOrh2hhmBWIcFcLTRfHsJkcTP/zbhw6n8mEQsL5gW9H?=
 =?us-ascii?Q?0u32LZBiIbuLGoHXR0iUpJdFAsUn8FX4YzkjIS2zR9LSAHzVk4Lhne4w0JAw?=
 =?us-ascii?Q?WH4+gFiBAm1k401ZANB9r7e27G/Kj6QWqjNMLfK9FVdsqFlBqxsPSI6JlgYc?=
 =?us-ascii?Q?s5V+xR0UX4ObR3nLwMXUQJrw0U+HbC5H8EFOr2gBlQXxRDR0rUWVb7RrEz7J?=
 =?us-ascii?Q?GhSEgnd/C9eyCkcEzWZBKm0vVc1RJW12ybOQDFDxTw3ITcn9bSj/1B3Ftpq6?=
 =?us-ascii?Q?sv/kWgGY2YGj+6d7JurY/oQktXQFKnv/zfjbdCveQur+cm3WiqOBoWYpNMPd?=
 =?us-ascii?Q?jYo/f/UeLRCguq6NAftIsE4FinhhIpZ3ZkG5RalIQJVuxMZHflS7F1qOVaCz?=
 =?us-ascii?Q?kSPGw5mI2VjyONvO3+OKkifAagHw2xs54oc+/hWBsOoGWU9T14lLDRPx0/SP?=
 =?us-ascii?Q?mGmYKxRPsu58qdnCAPo9v7qv6MfufVkBhWMYHmQf+4lvlUspCJFNkRy0QDyq?=
 =?us-ascii?Q?3TfkOl0ts/N42LGE/tkvTWdbmeCgScoSmxKxVf+ciyz3FoZju+oRXqhkmH3C?=
 =?us-ascii?Q?e5CgxLdDl/lzGSuWnefodSkSblth4iQOPGRf2nwbfba9CFwvu99PUupkty6z?=
 =?us-ascii?Q?zeJxPpf7zKA5IYlkSATQIK1/xs5aBffdDXNHXbyyvIRxtM8wLY3abf7RmAXr?=
 =?us-ascii?Q?A4wv1ZrKWxa92wzDf4hg0+w6Dfh4zhxua0PXq7xyetdsxywkM4lKDdHQA+EU?=
 =?us-ascii?Q?4EjYhf7Hxv51aC8im9RF+75dJT406or34Jd7hUheTICH6OF2DtCjp6udEPPF?=
 =?us-ascii?Q?Kgq5G8PRoCIiMhm3zyBJQeEBX1NQfV5ca0n2qLMtMeVSgaPCugtFC+BeZvt9?=
 =?us-ascii?Q?lJQ3MrUd6WpOiXSMFgal50ZUhZcNsCiU1wv90On4Bwiuy5akOu/rQHshwEfk?=
 =?us-ascii?Q?BI87dySIx6fVzXSMDQk0FjqIXxQ4rF3i69rWzY4Xg33TbnC36T1aiWgqCET2?=
 =?us-ascii?Q?UMdseky8tmDaoW6qxdXDW3l8UzlTLcW6AMfs9WpqTXzY22KDxh6oX5JcTbf0?=
 =?us-ascii?Q?jIu563rk0gEqzIPSC2xxGkuJkmX8Oy9GvbggP23tbqtU6Nn73CKmcjsMJcY+?=
 =?us-ascii?Q?FedbsOFgGlRn7pCpmWjN7vIaJTxhCfFFxUdJU7gUZOk7bxbN/9OLbbsHqJLf?=
 =?us-ascii?Q?tASH+qbp1slv/a4OHvc5/BIxXiSFleYB+xNlUiOp2feyEO6aSDxExKx8Vciv?=
 =?us-ascii?Q?+3DBZFdhTgXbvnAINDEN5LY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85F24CD745D24147BD9791BEC9C938F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rnCyN1HYntVvhzhlAAeRLymkygJiM6+dPRUg+mH68RpK39YH28nsp8SAb3l+FM0smf3+3yeQRCZN5dUruTthCLlvoN2GHISaPpaqFb5/Q91gAuvQFANUc2PKR7kybzc30CRLjeahxKv1I8AG55bF7ya7t/lsqgECg+Z2FkpPgt0hqTrjViVoRyvOp9tNoucTMM/pshOMqrl/OcjebLpFFWOCZHwm7xdDDJwOH4RPQAC7LSGCnrm4yV+2KKOvYi4QYALzp8LK3mwSWhka82wHBMoaitjuhZv8HxNdBSeisf1s9qQPx93EZAhLzO4w4uCCUPAfnn9mBJMDd+AyLBoXAfnUZivQV+hJXnf3z4zPPaguQSEApzpxFItZwetiwCK/PiKZZgOo8TFiDEYPorVwlM6s3kMJD8DyQ8rfamrrqv8TECge/HkVkmlBR76d0AfG/4c5T7tiOxi9o3RxKF8gmXbtgHjWa6Qj/ejR/biFx5ukx9z2E0XYxybMbN+7MY6SDQuQfoMcznORU0n92mIRhFP25mdM9fUJicYw20m3DcigrYKU5QNdDqP8vAL3uT5N3jVi+KJ9akFLeWgda4nMzJrD92e10CpchgV4eSSyxNaCMDHE72DViYfFIN4dB8+0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7ca650-7a94-45b1-1044-08dd566140fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 12:29:45.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VJ8at33Lcmx/IVXjCxhjgSShVBSQRi2g+UQDluaZ/iU0ge6bJCJ48gPBH4luNKAs49lPAT68XvZj1HwF5yZgYstflUMGu0WbOyxxArjtPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8616
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_042952_174126_AADDE085 
X-CRM114-Status: GOOD (  10.35  )
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

On Feb 25, 2025 / 10:31, Alan Adamson wrote:
> xfs_io atomic write support is a dependency of the scsi and nvme atomic w=
rite
> tests. The xfs_io atomic write support was introduced across different
> versions so if xfs_io pwrite supports the -A (Atomic Write) option, it do=
esn't
> necessarily support statx atomic write fields so that needs to be verifie=
d
> separately.
>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>

I applied it. Thanks!=

