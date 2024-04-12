Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DFAC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIxUxzr9WIUEYxw0ciZW7d1/GUe+3r7cWUQcYayWL2c=; b=YuYZhubCxsEf/XzlbpGC3ejmQD
	n+bPepf83+OQf37TQX1bKP3i2lfYiRjBVZQKZAbsU9BZbHSWOlyPiGiyFF+9qjgG1LOkmzaD8mWE+
	NVcc+BkORDcKojzNzBF5VNhbQssfYYEm6OmI5zMcTDZ6ipV5HP93hsnrKvdnm2T5eMAxVToulERQU
	lQG1Dash07lvbqb2Kw94FNhaBcnzBYgMUm/kWVgwWZFtkmJlepFnOkWvVcvYCkZjQh/cBlJGEx1QN
	/n7wA4SQ/ukQpmkl8QDhGxFMq3/qFenUZ51I5sPTe62L7/okLRxl3RY2W0k6Tg2/raI142GS7tWlx
	Zobi0sFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvEcg-0000000Gotp-1CsM;
	Fri, 12 Apr 2024 10:59:10 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvEcd-0000000Got1-46ne
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 10:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712919548; x=1744455548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b6qvL8yP/zSctu2uNVJqj12S6EmX5d/G/sdpZXi0Cp4=;
  b=giUiLtBVLFhJUBs858c0UuLNrCBEAfTh0pgA8kEGPRx+d1PP9TSarm8M
   DT2GILmGQEkjRmIV/bjTUAqay9l2tyWIg73Y5QZspIY+Ua/nDnye9NsV7
   ixh8NvPw5mw95fGzrl9hgGoXPR3FuUwbW8LH15IpGH8W0j5xKmlnU3LOt
   6mS0q6t5eNSj0rpXGvSV0ztVns+AXR9HHKL9QUVQsoAcz1tbblzyx3Dke
   Qx6L8PPWVZ49B5qorI07IVa4Ia/10hwmQtABTK8G+1Iea0FkvYl4TgHoQ
   AvaF/t2c6ydscYuu+Pcm00IqaN3u9zzN2wEwgYM1pGJb+c2hrGW1+oKM+
   g==;
X-CSE-ConnectionGUID: 2Vb0dqsTQhOpAlCgLfS31Q==
X-CSE-MsgGUID: aO8UabjzSI68rjEc5bVCWw==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="13310166"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 18:59:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlupBMKZmVbHba9DepeUGbqym72s8sEx9BPtLqtjNdb+myfYBdiJt6Z8/LLi+xQGnDbl1vAX8yP9/uVdYW20A/HqbY4sZtfOfNQrw1PkV6y2ZKSvWqytSuX+99yeQy4WSFtAHFW+jx/xuyXsHJBSjgnV9kHIPOKyQiL+Bo898jwAUVk0LD1pQAwnzJCF4Tf7zecdYPdUW8wD8gjQezPfuqttIFm/7+CA5+uFDEb4IvdGyKnmanUqNQlBVj2wZfB8djgYiJtdLcgWfKcp+qnAh1JedS4ZFw54ZYf+Qun6X4fplavytFJfI+tCHpgVNLD6Npy2DXwpTSqxrJ9vCJp0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIxUxzr9WIUEYxw0ciZW7d1/GUe+3r7cWUQcYayWL2c=;
 b=bqVKvBxahgioJ4HKt7OnMrXJvgFVpYRJERjHQRzB9rggYtQdQY3SbmbGmhzp7zSzvSobz70VIA/wenjwZnIC+mIO4en3lkIYbM6luQ/C5WLWOqBEcidVdf3hKUJC1+FUY2nkbUfaO6E7ztRUt/efAd9FcK/zaVI3Xrdzcjy2E1cOvipYl28DNbHlKv2pLwum7nPB9EQf8Xs58EclOUPOTAkrxdq3u9vYFzOo/WnCUKj+IJhKD8PtfEOx7nEeKc6ON7eKmTc1M7YPYNu0/g2z/3aRyoOwSPv27ELOEWzAX7N8V69vFvnP2pP0aIr6uvJ155d1hGbnR0tVxK2uMmgjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIxUxzr9WIUEYxw0ciZW7d1/GUe+3r7cWUQcYayWL2c=;
 b=bp/Lnfz6Jw/INVoZj4qvg3mGFPpfcPDHSPyZ8nGGfYaDzF+TJresvmcEvAGaVbfzp4wPwraFTQlup4iQxYmvNZwtgtJMtIAXCffWCNKXlehD32TgwMa8wsRkzr45ork+zgs0vbHvxivOLwnHk/IhxWD19qSbPcroE8Z0DMIOPg4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8706.namprd04.prod.outlook.com (2603:10b6:510:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 10:59:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:59:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 01/11] check: factor out _run_test()
Thread-Topic: [PATCH blktests 01/11] check: factor out _run_test()
Thread-Index: AQHajJPvjpO13kBwl0+FQsRbhK+1KLFkd7UA
Date: Fri, 12 Apr 2024 10:59:05 +0000
Message-ID: <texagyh2hqi63dgpr3jxmctcgrjphdger6vpshmpf7uvuingwb@y5cyfecjozs2>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-2-shinichiro.kawasaki@wdc.com>
 <CGME20240411134129epcas5p3f28e625fc48b93a1f492547a6f4ff894@epcas5p3.samsung.com>
 <20240411133433.gxtwr4l6wz3mk6gj@green245>
In-Reply-To: <20240411133433.gxtwr4l6wz3mk6gj@green245>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8706:EE_
x-ms-office365-filtering-correlation-id: 7e05ae05-447b-40d7-7395-08dc5adf9225
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DB9W1a7NPod3e//bAU9844Kl+KQ4+kZ1oyqCM75VBd+do5jJSPNGehlttiUmtRrkIFb/N3PEQW3j/+w4hrGJpfETrFdNUKBH/wwNxiFQ20pLLJl7Tt/AojMyrQvOuQ2Xq9e96GQQbCKTlZVSE2Zk8HpERSspF2aGR93ed+RIVkPpu4hu772/HW73p+/Tx97D7HzgrjIE+DHNFJXl4E/zEsl6tcSFjVTqU+P/hdzwBBM+doLVwwmMsR8qANf21WWkye7vXtsvwyG3BNhVhPXP1MX8FzTdwL30m2jVzQd9wIIXOUb3r9wmMma2fqzEO6enmkt+7mFXxi6aohVTn6+o2Me5vT0Fc7mXbpevXDjnRcHnUMTNKWvtvEwGvQKcGZRklGVcmMNWPz2zvlDSvw2bKhN4wMj5CDue4RedzttqwvPsm9iwrYK9X80zRow5g19WfwPIK/R4AtJftesac6R/tVm1+WtpfjjPv/8ydEcmxPJbi0yfmTnhECZXQl2JL+ZMuS/NH2gTOom6i2bjqsGMMy5lERss0LRPX9y4Yqx/j5xFXScNk8v06ZucJJoidOJKI6EC7XLYEmpPy+m54oUw8sn4MN60dbaJd2ZFUwCNOWPIpxwRnO4exo44fmfji/xHADCHbl/CrsHmlG5OfRJWHYisq9WFal6O1T9HyrRXSR5nJPd7jVkE3rPBKILBpTYN0vkx7DV+XopwMPf5ILmYNRumXKU5yicf3s8MHsZynoc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/i/jVjzxJgAXhw3Z/uvnf5gYXPD5fiJsi/2atyLNx3OJzMZk463koaKXgGhp?=
 =?us-ascii?Q?7LQDAP15/jFeBo7eB9CjYt5rqv9X5nfHfHibxut4NMJrNiJbPqKQ6ZNBOGCU?=
 =?us-ascii?Q?p2rLIUeE5ovoASz3/DGYV4nn4tKEsw1yQDov5Jy+aUCIDIMaQ+S6lrGIXXLk?=
 =?us-ascii?Q?13k9duFjn4eha7uLR+VkXUPL/FvDViOVF/VVZ+pjxBO2r68OkHXnPuhwK/97?=
 =?us-ascii?Q?GBukxh/czc5VAyGGfmU/YQpOndhOZPQ+NWDaffq8YDm9q+a4wvb24nFItrfi?=
 =?us-ascii?Q?m1Z6uw8+jczrhsASzMKvxJq2R1kSiOIEPLxI3uSzUkXZsJlTuGanVahlhGFp?=
 =?us-ascii?Q?CMulA4u4ivtAlhzFlbeM4Qm58DU3+2gBsRbi6nX++roJtgX/oxxVvRCPuJeH?=
 =?us-ascii?Q?XBItYoH8rcUPbGt0dF2p8NYrx+TulU/BB8Gq/skgdfwfj6OTtowVa+nLxRF6?=
 =?us-ascii?Q?6acpPyiCwLTVLuXEaCLBypuaPcH9ohUx8U2yhh7ybEgkUmUsIo3qk+86Tp7e?=
 =?us-ascii?Q?3cI+3Fp/W5aiYyFS9WWm14+fCYLv84rYK5qfTwEZraHspLI2rqy3PhxMaU60?=
 =?us-ascii?Q?E5YhpQ6zQWTnCKtIH7vPSG3bzAPtx4jRx/Jn1P821HarmYz8bI5XdaOwcSJc?=
 =?us-ascii?Q?eOcEmhvaVKMl6LMUiRu+Cg2E1NtVn6tUO+bWD8e/PlayUPKXdJi4du3WJ3N6?=
 =?us-ascii?Q?KNB5YRu5J+RMTirzyDX5mxHepMOdW+jlRr/Au4MVe3kXgEbeVpOXwfzBJn8Q?=
 =?us-ascii?Q?zZjO90/Yqb352aFU4VSzJES34xQy0IqfNYpEghfBML0fPmaQqoZyMuS4xygP?=
 =?us-ascii?Q?HBulA2oSLyH1L6op0YOZkYNF2Vgw21zg0jGHRPoUjRk7daIwGtOyi0HjYpTB?=
 =?us-ascii?Q?jiIeJyr1Jl81ZbOdKaEg9UDeLxmprAGjWm7JcNxlHLWqrNmvZ2k80kBhBiFZ?=
 =?us-ascii?Q?Atzlx0KuHdkRnbQOLuFkI5jpbNpAGnG9agj3NGmf8KhT1K075we6J7BvOwHQ?=
 =?us-ascii?Q?42Zq+vlxFtZdWF/dZLaix7Y3PnrjsNvgUngPbUZQnvPs0RPO7i8Ju90MzOKz?=
 =?us-ascii?Q?VxM4xiAMpykgQaQX2QK+4E3oEXwBSpLFWB6eiY+LgbR/IorME2vHSjcnw+1f?=
 =?us-ascii?Q?xv2GcA/rzZqYUmBeKhejjZPkOTrrpjNGTiGaCntT3HTpwAbCwC5ZL3+0uoS+?=
 =?us-ascii?Q?L9BeLjNerOAtPIeEA1EQzu7lB0/VIR7bbL1ZCSqygvtvzTWAEdzIAjtW5O9K?=
 =?us-ascii?Q?Vl2NoTbopBvs2UuruAlFU6AyOCMZNQ0HJ5px5zunOUsMFA8uVNCaCMfig9j5?=
 =?us-ascii?Q?Z690BQyc4oghqF6km8q9CMmB1v5Sz88cDq44dLr3QVtWghEtqiJ5UPskirbe?=
 =?us-ascii?Q?vIPRSraGDpCnPXUdBBDAaut2z2RO07K8CMMFtcQxlu9j8aTaZAl4bpJDlyuG?=
 =?us-ascii?Q?JKxe0D7SKEGkIW6Utv8QUQRFOS/SHNCSw9PXfZM5VYMyEhM1sM6e/yUuSZQp?=
 =?us-ascii?Q?S/dEYxlzDsDFkdZAEkT1LeanY0Ew3x+QHc8QweMSta7hnn+LR4vUJr5ByUHX?=
 =?us-ascii?Q?a/vzTJ2tjWFIoZv/Ib2YJwhy6/TCyq+RMkUqpLkwJYGpIK66FCIdYaZJotSg?=
 =?us-ascii?Q?frxfBgMpPnzAWUR5z+AWW9w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC460073F177D0478BF95428745E2D17@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0tSpieVKLQX2lqK4X7BWzjCwy8hVGcclzaHK0sVAmHq8dpKa9DfEiKzJNDLlAj/eTS8Nr+CaZrr7oLMp5sXlhfOjGDHdiWkgaMdHU/P15Plqz9rfznqUUJqwd6vPSSX8eIaZJyKObBBrr9Xp+N00DLo2WBAkMObKmeXJHLHhZonHaDGcNJMZGZRqVNky9O/xo0ryTi1CqDL6L0k+d60/XSp82ucM5b/CZHi9QojNw2ZqJdtXj+1YZGK0T0iy7TEwggLIbaoh/+wze+1gwgAXOI5kwDJ/BNfO9oEaF4ltuO7ZKJSbuPt3h5xa29YaER2LHF68inDuRCeYElEUscGPIO5bUWJySPRmQoRQUDwLJj2dLncNKDlhg8DRmDKEMg2sOgb7av/2RyHAwy9WWPJyqTRiw/tS3Yu2XEbM2nUG/zTFlLHeRWkGzRAQlJaYeSfg7IjiVpsZFq4TfFp5iYz47jhNF7RWbOgpYZa80s8SX8HbMAgpBNTNJCZZtCWa6IcvBzAzHco6rIRvHBlntqHhtu76aV8J8kwZsdla1Fo21qwwsgCce/MDlwmjfnrjKAEO74MgoZMdtWXjHcPF76POli/iMdOJR7SCKjsXd4oEg+iXFm9kQz2a9PgmZxAnX0PS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e05ae05-447b-40d7-7395-08dc5adf9225
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:59:05.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ap9w2NQx5HZZr1k1JPl+vKZHMpcEnhlVl7QdLbbPhR8NEZDArozpZi62A8ajNmOXa8vHxEcfdnYwi+EksTDvQs8f9i/5m2wHf0VCT6bcc+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_035908_132433_A07C773C 
X-CRM114-Status: GOOD (  18.98  )
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

On Apr 11, 2024 / 19:04, Nitesh Shetty wrote:
> On 11/04/24 08:12PM, Shin'ichiro Kawasaki wrote:
> > The function _run_test() is rather complex and has deep nests. Before
> > modifying it for repeated test case runs, simplify it. Factor out some
> > part of the function to the new functions _check_and_call_test() and
> > _check_and_call_test_device().
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> > check | 90 +++++++++++++++++++++++++++++++++++------------------------
> > 1 file changed, 53 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/check b/check
> > index 55871b0..b1f5212 100755
> > --- a/check
> > +++ b/check
> > @@ -463,6 +463,56 @@ _unload_modules() {
> > 	unset MODULES_TO_UNLOAD
> > }
> >=20
> > +_check_and_call_test() {
>=20
> ret should be declared ret as local ?

Yes, will do so in v2.

>=20
> > +	if declare -fF requires >/dev/null; then
> > +		requires
> > +	fi
> > +
> > +	RESULTS_DIR=3D"$OUTPUT/nodev"
> > +	_call_test test
> > +	ret=3D$?
> > +	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
> > +		RESULTS_DIR=3D"$OUTPUT/nodev_zoned"
> > +		RUN_FOR_ZONED=3D1
> > +		_call_test test
> > +		ret=3D$(( ret || $? ))
> > +	fi
> > +
> > +	return $ret
> > +}
> > +
> > +_check_and_call_test_device() {
> > +	local unset_skip_reason
>=20
> Same here, ret should declared be local ?

Yes, and thanks for the review :)

>=20
> Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>


