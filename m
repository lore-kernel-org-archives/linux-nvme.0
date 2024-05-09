Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77A3C25B10
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsUPJ7Qtkf9qYaavZ0+IrhBTwWESXFWOCZ4thJF6HV4=; b=EjRiuRFcCHLFI+lE7ryeOrCW4Y
	Gn7Z+n2ThPeakiqwB2dxgtLj8u4JEFXV7SdSSV/y2yzcCWeMp/bmC4Wgjuy0oGQB6f6+aEqO8BPLi
	EIRozd9F5x5B77u3VgwOWuysFOMlE5Lv9QKra6YCRCPyARwcx63Zxd9azsQg2jAC/GyDksic7ZrnU
	uk4Kr3B4VSDz+Rs8Z5WtfvcRn7hejpxz9UL7NmlDYu6PxvZdThacHcXEa79c4aPjMqZUZtMWLyOxJ
	qZ0fTlaMRsEDrUQ+J10LukOY5SwZB0KbE6WcSpw7r3nreEZGuOf0V2V5P3ELK/7NxqAr1PC5vwmJV
	IFV9pMgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s51DA-000000019JP-0stB;
	Thu, 09 May 2024 10:41:16 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s51D6-000000019Fr-0sg1
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 10:41:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715251271; x=1746787271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5WCrwKNKXPTVBh9zI1cwkUwkuFrHVL+PtMYbUGF4H5Q=;
  b=cu/bcw52fXH6zeZPrV/40+hQWv6aq4RylEot45dOQefIiQ1wIY6KzEaG
   HeaLo8WpiCuS7fpDYqxFTgDzPYhzfhE0LZ22oVl0RAkbG25w7/hHDx8se
   K2AzGkdc7P1sZ9uEUAG0msSv2pBwOwOx40kexIaRnRVUg6mWgg/sZn5P9
   FtdJClp6y9EW6CL5Od704RhH77HIymkqVyWWXRHguv6/YbBYN+47rnqhn
   02DPOhSps+/y6WBsFILWSxyX+rdBf1RJKN6KhM3ayP3B1vkvDYUhXkJkJ
   OaU8zEpG+ZxuXff+VrqtbCJfeahrs6wyph810U9XeB4chjNwI3DTtZ7qI
   w==;
X-CSE-ConnectionGUID: YixlHZjWTbe7CA3iKz0mHA==
X-CSE-MsgGUID: ZU17yyx0TSqp0t9T89yZNA==
X-IronPort-AV: E=Sophos;i="6.08,147,1712592000"; 
   d="scan'208";a="16187762"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2024 18:41:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mid78Y+8wu2V+fMKltkZ6edr9n03RPdViODcRznV+dp9IY0IY7FmhVC9pkfM5w3EyAsQI3WOOyFtFDH2ZNmMbhiv0+j+3u2vv6C6ywZF4Mm7K8XH5KYVsM5ltUN5bku7h19/17sveMrBF/qBM+ZHGG88Rj+COK0sw7aYa3Rulip+ACbdEyswnVy4PTxsZzUC+alrqKKNEwsUCziJcM0gV5OJOjskM4iEECRd1GDfo6+QX6QKIuiq4DATrh2kLTywCnZjJDd+tDjqiMDYVlOdwQfYSYeXuAd8Lddf3JvD96UXo5bM6Y8UI69UMnnmHYfbVJzGnRllWHQgRB9toAeExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsUPJ7Qtkf9qYaavZ0+IrhBTwWESXFWOCZ4thJF6HV4=;
 b=Cu7HuCTImc5QEd9nshUo4lH3RfeeIrfLRSh3V6hxQTeNEIe+9vOCC2mvtbeBOHcXehmTSxyLEeFSNPBZRffhL0Dv6k9QLwL+yvuXWq0grn8yNyeythUJHod4G39VSvlBCnzj7M4dVuxejzMSf6w5yaZP3xbUzhY1Rkrioufstf1iB1aHowLXqT7ZOzuXf2x88z9cgFSF4newVnfzIJrr8TpNqwAFbqeRHv0UBKsDS+tyqewWFR3mOJsRzN7OKzqtUQNN/uinHGKfdFa0fIxShLMAfVX9Pcp6WCCYXWqUtyOS/bAbjyrGEGhevfAeHUpuxhgn0IHWIEDrvMVQx00Vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsUPJ7Qtkf9qYaavZ0+IrhBTwWESXFWOCZ4thJF6HV4=;
 b=ItK9RdpQD+5rdqzbSFjnXuVEkouYwDZ5YCAxBKkvDYcfGrPaJGDFCSlsdESORGighCRIGc2Yy+RQEf0gGFGnlogA1qMSYw4x0dk12De33IK6j/y0ZkW4CFiXP70C0nJrUqmcix3lp7zPn8gCADwBq0Gxr+AIhzV9lPIhWGhCxVM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7360.namprd04.prod.outlook.com (2603:10b6:a03:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:41:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 10:41:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Alan
 Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH blktests] nvme/039: adjust to util-linux v2.40 dmesg
 format change
Thread-Topic: [PATCH blktests] nvme/039: adjust to util-linux v2.40 dmesg
 format change
Thread-Index: AQHamdX/u9qF3Xr0qk2zgyceJwPScLGOxxkA
Date: Thu, 9 May 2024 10:41:03 +0000
Message-ID: <36cv63lah7wwqepilhaosvz2ycqjfrnavyxl4avnywgledncpk@5czrtiuqpydv>
References: <20240429013851.181700-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240429013851.181700-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7360:EE_
x-ms-office365-filtering-correlation-id: c9e8b972-bfc2-46e0-83d1-08dc70148661
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?KIgFX9bghC8+JcJzMISe8470Bj803PwjrI3Kv9bbuH1CN4QCO2jz8S1A017F?=
 =?us-ascii?Q?V9IMHAT5eg5b1nVzNZikVZY7BT8qkT7twzYeOLEkDZVzcPpQlgGughVXcPBw?=
 =?us-ascii?Q?/KXvg52lGKl4eM9/GabCW52oic6XVACyPhDR5QSFC1W5d+dHGbqKXCPNSySR?=
 =?us-ascii?Q?hULRFw+oJcMi+ggDbE24sm4VdS90ZxvQI5bWI+EWlilGhjZdQlWhIOI7qMAV?=
 =?us-ascii?Q?VbFcqzEyzfCb4Y16/+5xArilNujQbDHiEz+ePCyvRvibrM6MvtpKKUnLGfzx?=
 =?us-ascii?Q?QIdUf7aitL0I9M8C16cQoyifx/JVs6NtQYU/PYtjTekpwKhWkWTkF4kFCjoU?=
 =?us-ascii?Q?ewp4zCIzQgfFfhFrZB/K5KPdbTEVkN6h6Nv3AxlTxfLblU90fpqoRFduEKab?=
 =?us-ascii?Q?Qy9toB3bcOyYf0W5+ViazYYcqkcNUgDAKnw07jBQzizCTDYtV45alwIf95Ru?=
 =?us-ascii?Q?8r6Kjhtw+06/sWHOVfVEAUWelL0emZCwF0+isRG5vqBL1eB/1TK5CCC6MBXA?=
 =?us-ascii?Q?gy8k73mfdzehbcmjubULiNfx4eXqgT2RBfWGgxxrEhCewQl656CE9ZsBfNfE?=
 =?us-ascii?Q?jTY86UWYuhKqZVav++ti0Zr/0c8Rn5D8ZJiUxp4FjxluyIisaDwRWU7NF9f8?=
 =?us-ascii?Q?G9y5usSmNrYhd31NlqGNfCYc/rJw3N47CM2eidvaJRuw73ljdEVe7rR8qYYd?=
 =?us-ascii?Q?lmu4e4oa1eWosu9yHlItoF9RGfemotDSdeAF+lcSM9LsQBXzinG26YGfXB3J?=
 =?us-ascii?Q?9SWcoQqQ4jXp/zpCHmzJdNLAblcudfvQ734AAgjQL66w4XestaSR6tyw9U6w?=
 =?us-ascii?Q?Nxd2dKT0S7caCvglO4nZbiYL97UgWuwSY7maXiny0h6Ox3+dPo+l4L5u9dn4?=
 =?us-ascii?Q?ckEZYybqO8yTLPN5Kl8gkNnHYAdkzb0Y9cuKHYcaCuf4aXy3j+9akehU/3s9?=
 =?us-ascii?Q?LpQo0R3eNUkqAbNafXRKbOvrsJ1DlFKrKTy67PS5KKbmjuZORjElIAkreXFl?=
 =?us-ascii?Q?HG16dw4a9VPTABbQhi8HEt9kfK33MglRfuXT5VxKPwLItuggpSwkoKlwc8hH?=
 =?us-ascii?Q?7Qp3UX/v6SPprirDXkYXFCzeE9zwEfqqkSZ2mEmAWWRkqBntyJKIkktvDCqU?=
 =?us-ascii?Q?Kx6taY8ljzPLFZmX3fCyCGNVhoO9WlRR9XGE0jarJamKVj9LPvXEUg0ww5DE?=
 =?us-ascii?Q?Qlr6HJAZTZZQs7Vyrq0qpLnyfdCmDpzBnU9VO7VOuUWk7XbN+DvwNd/5HNB+?=
 =?us-ascii?Q?NJKkYfJgVHRdjcs8h0SO+bcNMvpAGguLfIgWD7kz3kYYlOZodH98ueXiuMDM?=
 =?us-ascii?Q?Gp6wzM7nJS79o4qg/jhF63J33ggI2LmzcKlz1M5iAtiiKw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kc+3kSJ9hDclNQVwanVrbZvIMPrGCAfZ8L3Z1R/dNTNI9rZCPNt6n47nSMyJ?=
 =?us-ascii?Q?cNhyHyZ/VTr2dbiGiIjsF/9oEu7VBU6+kg+gVPfqrOz0wRqffWKgG6lcQaf9?=
 =?us-ascii?Q?0Dliz4U1M4vz2JUMzegifSBX454AKB9vQQ9kwar+55RfCAXomMVz+rJ82Uc+?=
 =?us-ascii?Q?PuYGyVuAphJ481Mz9g9z7XuLfECH5aoeaQfzsaTwM5pgZdB1iVuXINGv3mht?=
 =?us-ascii?Q?NNSpIHW6JEi9Y9tOXjwnX1nOCGw/KBQU0XOCO5F2J887/4P46KDRrlll/8nY?=
 =?us-ascii?Q?nWRs32Rucg35DJYo1+gMKrzzP728qDfpY6FSrf2G48FhotbT9E5oHBhoV+7O?=
 =?us-ascii?Q?hgBshDZ0LxSnnuqyH4DHJXCJYAxNJBYf99BgtkQ+5VFLELA5AJJv3RXJrs8T?=
 =?us-ascii?Q?7ABxnijNg7wF1zwAzFI4VXdlKEFspcyvI0rEIG/u+T9d1y+QkIKGx3ykvr/A?=
 =?us-ascii?Q?MTmr6gDyH7rlPqP3JcIHbsTlTOgvup8USHTFzIkWngCWhcAI4TACI05z+eT9?=
 =?us-ascii?Q?CkE+bv2H47EYfYQRHGxZo6g0gANLWhNCQx4VF4CZKsKpd/qdk1Lr/wCpZ9YD?=
 =?us-ascii?Q?sKwP1Q5ulNzBHzMX4/CsceD7wd7TgrPy0RUJ2QdRp+nonypMYgkwHHwQCgym?=
 =?us-ascii?Q?+6JlM8nC5AcMZ6390psvDgC99vIhCkTaBiNKpwGKb870YYpxnSO2w43R80bU?=
 =?us-ascii?Q?vOTiWgzGk3ABMZuXxsMEZgMfQXg6RoNLkU8mivrbMpSeo0nfnvn8qS68i9JG?=
 =?us-ascii?Q?JnTR3G12pk7rasNAG0L367JbKzjeWhSg2S2j7l3L6FbL1HdTJvkXJVUKrXqf?=
 =?us-ascii?Q?usj0+OPQ3RNty0XdfiPMFMd6Tj3t4N0NvDKxUuxqOSjff0LtsANRdjrJXF1D?=
 =?us-ascii?Q?C05+3xjo0yijkuVdKoVuosnWo18MMwEKoA+91ZEg5vjHCiX8LsQNddWPOipd?=
 =?us-ascii?Q?zpT0HPXDEDtWo66rGyc/nbdwf03821bJ0rcuQQZX+V0vyuqt1opT5GLqw/tL?=
 =?us-ascii?Q?tZhdxnP9stInjHmqoJ7iUWUlraFXNOdc8VkNkTrq4QN9285hpX7U6TTAunbz?=
 =?us-ascii?Q?kNyTbEYRVU1otBVXWjyjE/zQLMB8g2BivuVl8uRddxUm82MFTpbd9CYKk/Yt?=
 =?us-ascii?Q?a7pzKL9HQnG4bKRK9rlLt4IWjMOjUBbJorNmQTtRLoFD6EzdLPAOxYmFgIqB?=
 =?us-ascii?Q?x0eAYQtXC76BC1eGsyIuOmC5urcXKWGt/hj56ugGi13Em8pUO9BcZWFd0onb?=
 =?us-ascii?Q?53hiRJJ5e8elFepcSyV8wRjH+HTQr6NU6dDqEBtpfPMTww+Xdg2jTFax0/kF?=
 =?us-ascii?Q?4gGdwifp0piTD2SFT1rf+SoZXEQhrleIl5i9W98+gptDPoxtno+ahCe5PEvQ?=
 =?us-ascii?Q?KEBOT9gNozrYbZ6X2MN3WtH9P8n1ACz7ALgf2+vXg3O0DGJ+G9GFtJHPxCDO?=
 =?us-ascii?Q?kswIFC3Rz/uIBOxbSt/z2zgy4AH6eL8t6XX32omL4jEhjLvWlN+vMINxdOZN?=
 =?us-ascii?Q?jcAg7DoltCII5dZ2kBYnQCjP3DG7YTeVAb2qcvw1584Jxx1//g/NI/UyG6LA?=
 =?us-ascii?Q?k7ilVsbRTUXm/yaQ7MaQeNSLs5zXfiy6aAKJI+xMzhv9bRei2MNx+AS2rLIA?=
 =?us-ascii?Q?0ifTzruB4sbdqeCgsNIkxoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <473EA8ABB8B26041BB9F29F5B1F782CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ohFV7eY3i198DC4ljGPEdlVdHeYBCBYleJi/+JuUD68FsKaleewEhGR3QQRpTpQLl0TIVvu5luS+V0Xgo+mlRSCSNEadwOkzG8CY7j3Z2yOpGxhj4eR5plFESzMujQIYNc0q108C6Ut/w8S5Q0/XyB6zZZsHsOcfVui2A9BuGNFVofrstfyYsU8Njdv641utnwsUfqWoDzRGcT2r+Z1e/VHxxNkK9Et5LcSapwJcm3ZiEi9vmjfbpzvjtUwiWCbFhQZc11BD4AQx449hcslwQDf/PSLVF1VvWAdQ2j1PoYchkoQqpwTeYexjaTsJiqaKbxPam9N8zqn9duckMJNqhxq5fimYVTPftUwJixcMMbuTBBMvMcwdT+33hJlOOEUBnqJkTsvOoCQR3FvxkDM/ymIVgtbWWQim9MegEZP4jnct/+6ayElHCAzEB7LHI2T6XlaJQyVO8/FrRq8Kzh0YhnyY0OBHnKYHG2SgdqRd7jiE2WoSxUXIxb9PdQ7nrbk1tVu3gAKJwyDVu6T8UWhQr2JNuBeAkTx9XzXrxCv+U1+/j1TAd3/KrCO6l5n5Ob9Zq+NinA/aD4HxeG6pkUOx8ek53w7Uu+rHDhb5Fn5z022ya4Vzclk2EfQegiSBdp6o
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8b972-bfc2-46e0-83d1-08dc70148661
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 10:41:03.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDvIEqd0D4c+XJC/RhXq4b+qtcFqzQQjxIuo9dqDjYr9MJppCkdkc5ExEIjxQJvI/qxYynRXWcugd+nUJ27+hEA2RmwAXCruzqniwjew2fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7360
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_034112_279438_71E87129 
X-CRM114-Status: GOOD (  10.05  )
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

On Apr 29, 2024 / 10:38, Shin'ichiro Kawasaki wrote:
> Since util-linux version 2.40, dmesg supports "caller ID". When Linux
> kernel supports CONFIG_PRINTK_CALLER, dmesg adds thread ID or CPU ID
> with parenthesis such as [    T123] or [     C16] to each message. This
> made the dmesg string check of the test case nvme/039 fail. Fix this by
> filtering out the added caller ID field.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, this patch has got applied.=

