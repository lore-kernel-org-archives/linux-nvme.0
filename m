Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FBFCD37AA
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Sep 2023 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W3shQt9pHzjrMC5bslq+3JN+ZQQYAVzmjL6eUROYVpw=; b=MJnU9bLOeA+0P4OfAeZsd+qAWG
	ZnCkZYFvwpDEMYWh8tOiG4B08Z5hUNjdIU6yIG2RfGHc/npOdwUQUUsH3k1prFzqz+SB03tbowZW5
	pO534vcHmYvCZOop4ii3+AxuSXyefPxJdUjQdAAvNjfBMOcTK1woXhmjQkMSGkH5MdL5qQcqaWMqm
	POPQm3yV7vZbiYC/CeZ13ID57XVJ0C10Fh5vujHjgh2805MoyhCS5B9tyqYqw01YdUOuCijOBnl8I
	/9aWbs5a2mg8QneKtfM/YoHm7R73S3lwAOx+NjxoR3NC7iDJf3PISKPHDzVysrLvTiftVLOrRr+Ni
	GQaMnk9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qhH5e-00BTFv-1q;
	Fri, 15 Sep 2023 22:15:06 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qhH5Y-00BTFI-26
	for linux-nvme@lists.infradead.org;
	Fri, 15 Sep 2023 22:15:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694816100; x=1726352100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W3shQt9pHzjrMC5bslq+3JN+ZQQYAVzmjL6eUROYVpw=;
  b=S9UiOf7o6Fxt+B9DJcJzbYdFvUt++Lf5ZFz2OS/JGwuZA5Z+1bjFJwAu
   1/54ehcsaG8DUbjFAaFJ0zA4Oim0SaM+EbiPtI0/TyDb2+8KkRukRo1gd
   RVGKLq5EQP2egoL0/W/bGCT1ZtErdBI9+eoA/PazpJUVOVxFvdiIPx/Gs
   4SqQSBiHeZlRRYfTHIym7dbAMf9OwCSmszgqUT3oAVyUsXw2gSQGxWsL0
   lyh7lRJxOWJ4Sbfvd7UeyAPNN1Ntt58Iymcm9/ViyaodjwDdKOtuN2I2u
   r/cDZBIl4oGGyunxtFmPrwQkZlmHoyN5JU5pZ/wGJbEQthO6yc4Fx9IQ3
   A==;
X-CSE-ConnectionGUID: 3H14ShJAQiSr46EtT2NNoA==
X-CSE-MsgGUID: bnajK2V9RSiC1HuuOh1gxw==
X-IronPort-AV: E=Sophos;i="6.02,150,1688400000"; 
   d="scan'208";a="242308623"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2023 06:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cok7cnAG5DHRLsOaFsL3w7veVPuoocdoQV9uI8Y2WEM5W8U8z2LVmxy4jb/KU9TD1lUtwFOqq7+nums1arJWliOWsyhpRLU7BK4KZ596OcuMLtV6aDMosyzBHYyveDFLVRIP6fpoP7NKG5PJGfD0Azh/8WgI6DhZHNKktma059MvhqlUhAmMBu8ssHouqUtybsunCQ7iWpFAwUdIuUU9JVZqkKTXzvHMkJmILXiNR6n98igKuzXgX+6NIr8KeVXB25k0MdTLcasYaAyCnq+Qtkvc7s1siSAyu9kVLVE9Rw6Ok/JnPPATLeJdYuDjEaIvuQ+PbIGOOb76HoZ8TDd9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3shQt9pHzjrMC5bslq+3JN+ZQQYAVzmjL6eUROYVpw=;
 b=ZEWG1nVdhktWXFtRDY6tY6PbhPvQzphWDYSp6pOJMtqpybZ1pZLlwOb7ppmkVdDCGga+rlrPljw6m0+gxG+QuSSx8+yp4hnLX+RYU/Qm6zFUuduBAOfFttU5tvR/8BDBoBD8qRzlGHyvNTV1/g6qWsW11Ihp/T37CZv3p4fobFQBfCOfTGkNbeWTo0C1aeSf7i2GJr/thd0Mpc4C3RCHu5rGeHwTZyB9QrsDxSINIkYThj4gYeSyVA6+v18OJRIp7rDnQx4uPh2uqyk17cpWROUmosf8tg4nkGnCL2ANBbd3BaoEWIQaxWgKsKaM/z88ugtVJP09Qq6NffbIG5jOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3shQt9pHzjrMC5bslq+3JN+ZQQYAVzmjL6eUROYVpw=;
 b=uytsjWkv6Gm9d0Fo3Fgo/Yu08GfqfHvO7HTVMww0RlWIdSQTjUNAqL7/RkTP5YZhCRVI14+Pei/NvOCPXeQvoxe2LoerWa5ZTPyfVDxHJGfaz/6K/Xbwuuo2UblaNA/IZu12M4C5gR9cWVXv+lDVdaVq5NLj9AJx3pQG+sgtHbo=
Received: from BYAPR04MB6261.namprd04.prod.outlook.com (2603:10b6:a03:f0::31)
 by PH7PR04MB8681.namprd04.prod.outlook.com (2603:10b6:510:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16; Fri, 15 Sep
 2023 22:14:52 +0000
Received: from BYAPR04MB6261.namprd04.prod.outlook.com
 ([fe80::984f:fe7e:1273:bd5d]) by BYAPR04MB6261.namprd04.prod.outlook.com
 ([fe80::984f:fe7e:1273:bd5d%4]) with mapi id 15.20.6813.007; Fri, 15 Sep 2023
 22:14:52 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, =?iso-8859-1?Q?Cl=E1udio_Sampaio?=
	<patola@gmail.com>, Felix Yan <felixonmars@archlinux.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Thread-Topic: [PATCH] nvme: avoid bogus CRTO values
Thread-Index: AQHZ5j1hsYCwaiF7S0KQOilyaTtJJ7AY3xWAgAAPPYCAAAjJAIADdHSAgAAFNACAAAbRAA==
Date: Fri, 15 Sep 2023 22:14:52 +0000
Message-ID: <ZQTXVDmb+DYZX9Ex@x1-carbon>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
 <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
 <ZQHf8Yyw+UC9ysDR@x1-carbon>
 <ZQHnUMlm80Xzxn6n@kbusch-mbp.dhcp.thefacebook.com>
 <ZQTNP5lnFFn8ThkZ@x1-carbon> <ZQTRnJm0z3ZE3x4I@kbusch-mbp>
In-Reply-To: <ZQTRnJm0z3ZE3x4I@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB6261:EE_|PH7PR04MB8681:EE_
x-ms-office365-filtering-correlation-id: 1aafc3d1-837d-4c15-0ecb-08dbb6392f59
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: we2W5tcqFwoW+ijzzjKpEDoMxsBJ7TtfJnXBtBMiuBrd8za7l1dzFVoTEN4dRE5gALtSJ53gHDGG7EwgLVedBnWYTyCx/SaWrBHdYmHrmG5Rp6OTjw17NjIFvlGCK8GUd+afs+Qj1gE19Nnnv61Q8gZUBeBLZmbvZo8Nhvvi1l2p+Tl7Ynsw8le19o2qksFoPKGIvkwgbHETK5y2Kgb/AGKfcwzIgTey1lav4te9Q76OHgc5xhRbB14zYv33mHF/X4yjxY/vYd/RsL/eSlAeMqpT1PWZbcm8/NTKa6YwSphaOgFm4mNkdS7xanuwg/bpUoWnFDB5Onqmt05C1eiv9IQCTbA3HaU2TvAGTTsefIA9HQnGW5uyI19wZ+7oJuvQS1PqwJHasSoHnfrNgqE5kAdyrA7WMd6MKOGvINVuLx4nrT3YEfcbjuZG3dEsMuZEJ8oKHBH01IfMjHOSR/qnwlecK5+jkOzg6lGnuq0myyAarBntiCOkHlmGlMWFSsjNXUhguqXostAqPlDnO0dvcq32i2s1Z1nKO7p0foaxTfKq2PbIiSFdUOIjCoIbxA4JjkXGpTwnJVCCWf/6K+ctZnDBy69DgHZw2cKwG3tM3vdaX3uIwtKN23LJcHGivb2VKKP/mhEbsCHaEPvDsnhQ1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB6261.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(186009)(1800799009)(451199024)(9686003)(6486002)(6512007)(6506007)(71200400001)(86362001)(82960400001)(33716001)(38100700002)(38070700005)(66476007)(41300700001)(2906002)(26005)(64756008)(316002)(76116006)(6916009)(91956017)(66556008)(54906003)(66446008)(66946007)(122000001)(4326008)(8676002)(5660300002)(8936002)(478600001)(4744005)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LCy6+HZWVaPHvfdUHXjbTwbCZcZmxkLKQG9P5Zz57WlbfXK8KWKIo89CM2?=
 =?iso-8859-1?Q?RGA+TtLoSSpcQCGVvUuqBXBODOwyVvZ8ZDiTm6M6rF5MJZIfxm8ZQY4sWu?=
 =?iso-8859-1?Q?4mms3WUPOO7DxLmdf5N/0USmtRGQNQeemTGqKN7ON2+9oJICWUG0ei3Ngu?=
 =?iso-8859-1?Q?/gSie0vfuNXrhqWxC9ZGTWsYZBI4k9PWmLhPqOmssvwmEhocGaLq1emWrY?=
 =?iso-8859-1?Q?mynDu0sxFv4gyBNLUcShoOXLodDesTQNa9Hnom3L8SBlMRTFFg2eC/wjo4?=
 =?iso-8859-1?Q?cRwaK8t1PAM3p3mOW44dkxehaxnlIqaXomkWNo+aQ4FxIvYfsBWxDJOzKR?=
 =?iso-8859-1?Q?XNSXINAAKFQjqcyef2rgjchKYAhwv55+QjfzAJdTZO7urSOdGMu5USYhOg?=
 =?iso-8859-1?Q?HFDchUT7i9tmE1jexyXKS5l5kGeVr2SKjWPL7v5fzR/ohr6U26YX/JGSj+?=
 =?iso-8859-1?Q?AUPw4mfe5R8oUBB6Z3SsZjVoJxEYfQ3ymQbcXSxsgF17IuA6caWdyKJe4+?=
 =?iso-8859-1?Q?COnvMrnpBcNO2yupN6a6YEKgm2CvDSGCOf656BaM2D1BvrKNZUdoB6TSWg?=
 =?iso-8859-1?Q?4qpS4OttQ+VRjUtMaN37qTSaNBd01QWz13oL2WtqMW7I9nRCQt/eTeuJ+I?=
 =?iso-8859-1?Q?IM2bwNJxtO8GQ9yu7Nt+eLKhmcP2Cm1Q+z0MQUiN+fH58T2pLqCWvLO1Oe?=
 =?iso-8859-1?Q?w052Lk0+bZcRgV9Q5bC3WPay7cjhadrTs/13RybZzfCXbUVCaJxH5lPvfm?=
 =?iso-8859-1?Q?ThDYXsUK2qb+pdJBVU9HaA3QeN7WtlDEnQkeEUAwcuyH4ygwVEw9DFsT8p?=
 =?iso-8859-1?Q?9UsXzLv5rqnSpyoiFhI3MSD492hCGUkueHlEt5TA+xw/z1pP4honOLksmL?=
 =?iso-8859-1?Q?CfBR3C6G7lGq2htkrsbJ/ofzmzjeL1rhnv3SIc3QT1mCx+SQvR6sikNSHf?=
 =?iso-8859-1?Q?RkBnWA02M8Hs/LFWE4JwXiyK8Ty2E/GYrLfT21PAOBrKnF/P/Xd7HjzAR6?=
 =?iso-8859-1?Q?aN6XjhMhh18ba0Z6aHK4nR5NgY9UJMIi+7gZOBR5pMvRyTFRu7vNcpjUcH?=
 =?iso-8859-1?Q?MIcPngA5BUXfhS8fpJj74hGo4BCw5Cp0RlwIqTffTm/6kM2TKnuz0Lvl6B?=
 =?iso-8859-1?Q?pDKptb9Dz5f12IBAqeKJjQRmPPjuo+QLEtBUTbU0hWzeNSUApbL0IML0+v?=
 =?iso-8859-1?Q?275GmyvtwmiwLnZHEcgQihmqzwOEUGc7zJ9UTG8Cx2Q1+4qwmLHs+LzHxK?=
 =?iso-8859-1?Q?k5sXiUrHnkbf9qCZ9FOgRQQKnxy6LaZJoKWMUvrKXoKx3Nzu+hKx8FPzCi?=
 =?iso-8859-1?Q?bF7HG16s0Yi53hIJSut1Bs4zK1k3/9cLQCLiBvfrnd4Ktwn8OYhCoCM9So?=
 =?iso-8859-1?Q?tthgLSxc5xJ1Jrphb9BFIdDXkB8fs738n0RE0ftkIzc735qVAIbgiq/5Gp?=
 =?iso-8859-1?Q?oE49VpuCQrEoXEVKesWZkPUDqc6HWldJXfeDC/HmEejk6LW5pjrDHW+8DV?=
 =?iso-8859-1?Q?xi7K9T0Xy3kUOjeEyRbeoWZwnoC42I8GHCbjGli9GcEK95Z5hcAdA5BQdi?=
 =?iso-8859-1?Q?n8lTE9qahHuDg/WaXAne/+lI4PpZgfN+MgIIWFY5+0kEr7o/3rcgmpNNws?=
 =?iso-8859-1?Q?cf/r5QfylQKRgsFe/b3sZs0jn+FIonu4XOSwiTAKVk0/VYbmETgCo6PQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7748C6B73DEBCE4DA4DA0F9108555105@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?F3a2/rlRkVN+PWfHUBjuZPFDjKIiCehnRGkQmt/IC5uifNi1TS11NRpZF5?=
 =?iso-8859-1?Q?3c5JX2E3DKDln5sB7S29pvgPM+zuGEqQ/z0MswQvBeIcXMTlqv2tkr+DZr?=
 =?iso-8859-1?Q?6gud0A8kOycZrnm27SXT5O1wNEMXQpEdtGmkTMSoJ/JCtsgILAdWdiTiAW?=
 =?iso-8859-1?Q?Nb7wOg4vMCI7yJV7s5Mh4ZRdp5l2zRVpA+imK236+qVnUuLVn30jZ6+oSe?=
 =?iso-8859-1?Q?/YBjQunSEGaXwC14KJMtYdtAjm7f/aWY2cN8TWuCssFGUTbXwPrdJMaZK3?=
 =?iso-8859-1?Q?ke+dC5ZZ3s9wcOGrEEuvQQEYV1VpHOibTe6ZAr9EBZv9/ZDLH8fctR23WY?=
 =?iso-8859-1?Q?Ay90ZBJOj+McAXTmwGzYCAfOjOUYAtNYftbz25UoQ9sY0lmU6M9TLFnhGU?=
 =?iso-8859-1?Q?8MeXrRkNecz8c+kLV9P3x/1CxwcwQAjzOulBD2UKu2D2srJCuQ9BTkuoen?=
 =?iso-8859-1?Q?WSM20mvHXZXy4dOCuKyoOO+d0eQl255Ymq0h0wfh0x68zFHCDSggyY4nbo?=
 =?iso-8859-1?Q?DmN3tjJkgrkaVDWGXZgAXDPP45eqlAIg2YdqGD7lN+bTmaG1x+RQlDlM/Q?=
 =?iso-8859-1?Q?/VdME4pMaVRaUtn5u9XrHXKlVslGcj6sc/xQNR+19nlYyZlD5wWR5XP61P?=
 =?iso-8859-1?Q?NhLyUJnSqDpEqoexraBi0fNJeMmXuL0OI1LckJxI1hgRcGDhqkMkxNaZPh?=
 =?iso-8859-1?Q?y+2n4ugqb96buctRtziUCcGpIiZzGy2hdZOTjDyfkTtv+wQeZOs67ed3HS?=
 =?iso-8859-1?Q?k6Pb2ZhHNYyD0nNdsbflNn6xv35IAkboMnu4d+QpZJRz0x5IzGs8hreDPT?=
 =?iso-8859-1?Q?53deRXSL4mCRtYvJQT562hosaar/Vo3YK4ynyLufdvGXlbRnMBTNxjHFwY?=
 =?iso-8859-1?Q?7N45hiOnoTjhMJBXYKQhAWCikhMG6TGE8RW50x8rAGd0K/43W6Vn8yMili?=
 =?iso-8859-1?Q?aWzQhP/CS3JGgiB/qhOBpnigk32jR1jzgHfx6rxebQddY55SXzXc+Rlvdc?=
 =?iso-8859-1?Q?kRMAhURlFUWDoEUfbK0Z1zeHAX1ch//3XjR8j7?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB6261.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aafc3d1-837d-4c15-0ecb-08dbb6392f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 22:14:52.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwb6tmTMM7eMUXBzOdnRq3K3t47KAH1sPQXsmMHSV/wnR+Z774deGYCWhaNvHjY7Qtrm0gNG70Zg7Q01Kkv1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8681
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_151500_762160_214B82D8 
X-CRM114-Status: GOOD (  16.00  )
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

On Fri, Sep 15, 2023 at 02:50:20PM -0700, Keith Busch wrote:
> On Fri, Sep 15, 2023 at 09:31:44PM +0000, Niklas Cassel wrote:
> > I'm not saying that these controllers shouldn't work with Linux.
> > However, these controller used to work with CC.CRIME =3D=3D 0, so perha=
ps
> > we should continue to use them that way?
>=20
> Perhaps I missed something, but I didn't get any indication that these
> controllers were reporting CRIMS capability. They're just reporting
> CRWMS as far as I know, so CRIME doesn't apply. I only included that
> case in the patch for completeness.

Yes, you are right of course.

My brain started thinking about this issue when relaxing...
but I guess that my brain got some details wrong when context
switching to this problem again after too much idle...

Have a nice weekend!


Kind regards,
Niklas=

