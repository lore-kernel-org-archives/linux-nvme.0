Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517FCDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqBMZ/B2LC1WvliMgQCS0OWYFMH6uQMvE8clwvDX99s=; b=sm1DqCJax0f9oQnEmPK0/ItFCN
	x/0eUasRSPSXvJRG5/z/Ybtneniq50LBfP44VHoi/BCdEez5MulAxseB4mBRCYAAt9/ZpC2u8e1mu
	GBpFjeCEFrhfXS1rVb1PPrYMRIFdCaJomn3+UQ6Vhepp+Ftbcn9tFejAkwW2EcySRahqPqY8G4GoH
	/kepJ34Cyjlp8CMUWDeaG4a8nCCCLIsaHiuGA1RpqXsTQ0Wvcw6AgRd/rObPo5Spaobmb0oODDClH
	VibQC2baBMvoU6Q35XHBvhqpsT4T7TCIjANqc0kYlt2shSOb5XW52zkkA9Rr9yH3f0So5inhigsW7
	u3YEGXEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtAvQ-00FPBR-0n;
	Wed, 18 Oct 2023 18:05:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtAvL-00FP9v-36
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 18:05:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697652340; x=1729188340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mi6KAl2xSE2tXlIJECdlmWe4oY+4uE/t+tcRYj03hAk=;
  b=NU73V3PR7GL+WYWjuQughciOzOjpsQwAqxkCSzow0KUMDI0/0HSr6hS0
   K++qwj6G5IqdOHPv236t/g8Xw0v4WTIn1ra9/pRaOKIaEHCxziHLhRA9j
   KoZ1Cbd5i8/4dVHrNfhHq6WR+Wq60DUzRoGt1azhbU9nNFOJNKMfZjnoo
   Gt53T75QvJi9q4Pomf/gBUv5BZOJ4v0vTsGreD0dCrYc2gNcF0hvvKe7C
   GRKwhPiSvyNw+JaBlLVcu+24V/uW8tHq6XR6Ue4SZrnmC6qd8Ky1dnLZE
   JxjNMZyNb79Z5LQXBoS/kpRXDCsVoysbJCNoZFt8MEFM1MlNwfieFzODn
   Q==;
X-CSE-ConnectionGUID: IlQ4LIpZSs+GdDLePR/PkQ==
X-CSE-MsgGUID: ocfbHsZiQ3qZc+AH4wPgJg==
X-IronPort-AV: E=Sophos;i="6.03,235,1694707200"; 
   d="scan'208";a="54513"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2023 02:05:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv56xXrk6RUd1x7z24sxKsacgDMTsR84BmpDm1F3FK1AGYstTatkSc7F++bmXjSOhYT5L4NLX+hHaR6yJ2MkSQAIeqMesE89oqWLju+7qlz8KIR1IU9ZWmJYgKIYQy8UN+HQLv7a/OL4nFAEBRC5L4fm783BnUxmj4NAEMRc3tK/tezzpr1trk4oFHg/c5ZQ5s/sWojxBq1z+eZ0os+HIgMMGu/XObj4PPOqV1mM9PbWPkO6EaIznadvj7HGPTPAD/VwnC97cZgoCrQrBibacor9LwftoPBDekkdrjG9q1SZZAfu9W9XKNOnnB53YEPsH78bkYBGebpo4RntSTZhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqBMZ/B2LC1WvliMgQCS0OWYFMH6uQMvE8clwvDX99s=;
 b=jhByaXYXG4YwKfucLa+VAokdjdEFToXFSgk/88Gu4h5d4oXaOJhSgBwCX/b6n4ZLmX7ole+aR+fz6iVOWm1aJhUaIrm/Rbra8YHXnWUBZMuek9kJuLN8uVcqyntDtNdku2km5oIKGfEE75oglAzgiZbr18gk/EBTi9OagPA73XpLplHo9LarIXIpL5UOPqI2ytWxvvYcrAnn1V+KBN0QxHMxO+lHysJidv1hkekP4+E/jO5PRO9z46u15XnPJ9NvA/AOYNV3kaJWbCMtIb0GKWMZvbcRkUkExoz1bdRZ1D1Z1n1GstpGVexGBbvSnxcVR/TekacI4bCISlwMl+y/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqBMZ/B2LC1WvliMgQCS0OWYFMH6uQMvE8clwvDX99s=;
 b=GDH5LrNRmcPQeARDILL0ATng1/c3LL+YwhJCUJvtvpTyb1mp6AkHvq+dMd4BCMGBL42GBPpx6IU3ckhnwUuvf/JWsL453miv4Tw2jOoUPTcP2lb5jRsJNzCqOczF+REKRuOMsBYBp1VEd/v4cvdnpT+weUHmPwXPBZK46rd8qSs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by IA0PR04MB8836.namprd04.prod.outlook.com (2603:10b6:208:486::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.20; Wed, 18 Oct
 2023 18:05:30 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 18:05:30 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"joshiiitr@gmail.com" <joshiiitr@gmail.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme: fix error-handling for io_uring nvme-passthrough
Thread-Topic: [PATCH] nvme: fix error-handling for io_uring nvme-passthrough
Thread-Index: AQHaAe2ujrF/TjwVp0qh5zSMbNZdtQ==
Date: Wed, 18 Oct 2023 18:05:30 +0000
Message-ID: <ZTAeaY6V5DgaiNI0@x1-carbon>
References: <CGME20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6@epcas5p1.samsung.com>
 <20231018135718.28820-1-joshi.k@samsung.com>
In-Reply-To: <20231018135718.28820-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|IA0PR04MB8836:EE_
x-ms-office365-filtering-correlation-id: 17ec8a2f-9ce8-4016-a82b-08dbd004d0de
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkX5zYHj/me5r0c7OScO9+BEWykIbXMLE3AwWFH6qe06rKn0sPf/lt1kQeGasaVE/V2s3N/3+wzEbp0pncDuhG6jKnAc4B2Z7zGa5tN+0Kn3tSI3lxvLkzKVuTYqL4REHLdTo14wnHiFgJ5YUoMEWY6EYFLEYbNK8JcuYLJyL5WKITOaP9YyD1xyxZFIUOkiSDPV25aVK+Qh+pFAtfwSLXOoZ66k34mN7jgzwvQZeHrgS3Z9QVdnJp6idgEnnatSoZbF+MHUwW8l6Kr86VjXPEAI2lnjrKn4YgpamoXTqrDZTaIivsnPp/FKhu8kr9xnYKWW9wxCDkgnqEQOyh0OI8sq7ebDkQ7QogBqtBw86O1nPjwYkC4j0i7Qii0Yx4AvxUjRWe/7/jjse+3yXYtq1AaJ+1enzBHn1sk8Rtzpz+tVCd/o9suJbDT22sC62smlAmTIS61AJ4v8vWNQ+sAZGzyrlwlgRGgYpnfaYNsG+S/XJ5bcXLM7Y/bMDdhhoRkakU5dF8ryKT5UezjcbwnyJAtOAkJnBimKEf0uIfREgYkJb28FogaJhcf2L8ms3N+ir/kA5h0x89GReFAnf+xrrGpzFAweZfJJzOAsNo8/Xbk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(8676002)(33716001)(122000001)(83380400001)(8936002)(38100700002)(316002)(26005)(4326008)(66556008)(66946007)(71200400001)(76116006)(966005)(6506007)(91956017)(54906003)(6512007)(64756008)(6916009)(66476007)(66446008)(9686003)(478600001)(82960400001)(2906002)(86362001)(38070700005)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pi+R50RbnsQWtNRfvFpS2xWBhm5/lLM1l8dDtebtFdJS30FkIBpzhOyxAByQ?=
 =?us-ascii?Q?KZrJz4fDWqym4ZATsAI+CCLq2FUo4VwGgkvFKAukcmgdbWKE27bij8r0/17E?=
 =?us-ascii?Q?uw7xksE82qeUuh6RvFHt/YCK+5pAG/VvJg8n0zRoTndkeNcBpFlpNV0BcYWq?=
 =?us-ascii?Q?6MNyWXasfNCAMkk0RPlB8h9WZyUmPKr0a8fEAvrChcwNxYMDPJhEzKNciS2F?=
 =?us-ascii?Q?lZNXbySbtFpNItuTRo9XlzdVVqGai7gyaPodrKl+JRqIlt7Bl+Th1fjO7MvW?=
 =?us-ascii?Q?nXGnNTenhBeMpBZabnxvzOYma0SI2SBeLjKTt9eAmOhttMSDUgQ14/Dwq0/o?=
 =?us-ascii?Q?Y5Palwx3ea0fNXRX/jtp4OmL8lyJaA0Ms0qONdhGCdqPjWgen+F7/zGcl6Jv?=
 =?us-ascii?Q?BgpA4YHIUKjDUkiYBq/r/t+LMpHJX9F4uR7dMXKcttTNrHC9H4cXdMPrWOVe?=
 =?us-ascii?Q?WS9U68kI84kYsDkh7PmTGqcq5WV8S/WMQYCpyTCWWqNwNVRceTSyYWE28yYA?=
 =?us-ascii?Q?iI913DmjQuvMbNzATMVlLzyEUyaj8KZpLjTngCKqyyTFpjlFRoOhYdSvRHB2?=
 =?us-ascii?Q?3cjDtc8164XcufG0M49RcHKR7s03nXvFKbbjon6pHcVabjaVSfs1kkJWiYr8?=
 =?us-ascii?Q?wlqFQ5lC2l0Jc4Ahburr5vhQ4F4v12b/0nGAQXNunitkXCOrgYZVp35fO5+a?=
 =?us-ascii?Q?v75KtytRfdZmhEuCRFDp04gKvCnDENfrhnnQDG/FgJ2XQxq4Jg/NRDKkOR9X?=
 =?us-ascii?Q?QJloAf49qB/1apbQ/fReIdArMBG8LEAeI6g/22ZQd0guH9xQ6VmzesO9NCpB?=
 =?us-ascii?Q?G30zuR1eRYAc+agNurdGDT+IBDqWq6Oks9NiSdI15+/pMHtXuWUCB6/79ySA?=
 =?us-ascii?Q?IwPadKcJmRi45xS8zlJPAd8p2nT5wFJIFxRitgSuC4ZlBirT8rb5NGuYrqFy?=
 =?us-ascii?Q?eZEgJzBN7WUnvlEV+eL7lXDr3TvHl6YDW7ym1FKecwz2ctkMTPILJ3opUf+l?=
 =?us-ascii?Q?hbC/GTDaAh0YbcflwZunXdr06rtlMbjI4iDCFNogAynoJHzoNX9nFXwx1fb6?=
 =?us-ascii?Q?ETdc0wbZ5CBLh3cVkVixV4TJJRDGmrYVFfFVvO0GN4ZV+PjjM0C3DTtxvwco?=
 =?us-ascii?Q?EMSRfZLgX+yyqU2mEOWUbTzqwocWe0iA+evrK/N6p3xFByuJktF0lQKoskmU?=
 =?us-ascii?Q?5ex0fJX5gv0qRR2kjqx5sSHdtRQMauGgImRGcQO6fkicwDDn9z65p16vcS+n?=
 =?us-ascii?Q?wwPeh7/ZRTukW35fPZXiambYHzflam6st+dH0uT3C42FyLelX2EgXudvdDTR?=
 =?us-ascii?Q?5jlLLJic079mhHI8OpjZeA12FOFe+ue2Rs9HbeMtY3Eiq5Ob/U24iuyxFxTp?=
 =?us-ascii?Q?SoB3+kYp18ZyhPcLfhUJCIIqVGvEK/6TCTupoczW/8FUdejhjZ5PKx2Rb1Nm?=
 =?us-ascii?Q?KzZqPQYtXs9I6OETkoK0xyqf2ImEYtv2Nzh4vlLNVnQKh5Bl2K8c7o6ydMCx?=
 =?us-ascii?Q?EtxxZRst8rX6a2vOUQClwHJPkCxsxQRI5yKRruOPMjssroKxGqQwK6ezFO6c?=
 =?us-ascii?Q?27nNtMRDpa/nbW/Tp0RGTmRlp0AvkkyR24P6RvvGoDKQXPFxE+fHm9pZL3Vw?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FB03B196CF60A4B8C871F886D302238@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6bHftWB8Xma8lbuG1uxPEEjN+gyV4Pr5k3k3LgdkWrfNFb+DVR42Lrq9c6YC?=
 =?us-ascii?Q?2T3ed/dqKobo3sZZdUZWGwoWYBlktsyDuxOXdu/v5EdEcs50O1PShXez0NKK?=
 =?us-ascii?Q?7rNAYfpdpUTz4LZKJ4HumDq/kYxB4NCfwUrFEEM42XgjafAGge3CEn0CYDed?=
 =?us-ascii?Q?rjuK2Rxj+fGkLDY6yvGYUamXh3kg1o6cni18RvOHO1gAngga0BKnkr1+YgnR?=
 =?us-ascii?Q?ctToF06yRCtuqjr7VK9J1c5hRISiRH6F4qYHNRLp8kqIohtpqqIxcy9HRfR1?=
 =?us-ascii?Q?c1ZAbt6a6Psp5Ge5EvIv65sTZTPaSn+JhgfubWU4lOguSrpzsA9B5ZmfeS1A?=
 =?us-ascii?Q?a2kh7GgDN6YFmuDmB4RM9+E2m950HRq49sgXFx3vZqZNk8H1BQmrP8bXOdCR?=
 =?us-ascii?Q?Ug5BlGGS6r4ZxzgmVKMD6cb9H35Ntk59mJHf3GSo92RAsDaMuvZKOueWzd7i?=
 =?us-ascii?Q?Da+hrBKt4NTlYsSqp6aRNPKDPByhz91IOptnzZY1iF+SexClb8/tYqxU2rJW?=
 =?us-ascii?Q?CRb5Mh8Vgdzk6SWBc3PkNfWzrtfIUxoBvy6vi0Fsw2pUiMYuI9tva2oP1Wzs?=
 =?us-ascii?Q?ZUWhoU6l4O1Mlxo9CvoacXlUBxgzoI+vWb6CmiBfpN98d5wkJko65fXdIL0p?=
 =?us-ascii?Q?HSndSUBga66pNS/UT/Up7ekCzXEXsipK9g4AyE5X6dmHRSImEZpZ9iaq78kP?=
 =?us-ascii?Q?5XF7Bgm3Zz6ScbgPj664sJNCxDTdvIWoUN32JtxzZYBG085p0iYuAsoUvreS?=
 =?us-ascii?Q?AdDma7k2g9GJGs0Ue7wBTOUr9nHw0ufdgsP+ZAl9qHrHHCqBAaNXmqGtIpkz?=
 =?us-ascii?Q?tTBq3BiqL3HF8Us7vtoKkAZmHISCFIEOkWeWCi8antxR/9fOTjk9a9WSa4wt?=
 =?us-ascii?Q?4ewu59P8QC+KTzY/LJKf0FRUPx8rUn9Pyz4CObYJKChL5ffDTV7Qd/+xDQ5Z?=
 =?us-ascii?Q?veMkTtS/Wz7pyC6IjITWAA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec8a2f-9ce8-4016-a82b-08dbd004d0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 18:05:30.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nswmg1F/NK1Uda5eepsjyDnCsqBf+ql78EvmAgvMEL529LGqUUV7ow/PqV9UQf4/hViy05Z2SwOdMtZFH/vqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8836
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_110540_149194_8DDE8720 
X-CRM114-Status: GOOD (  23.02  )
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

Hello Kanchan,

On Wed, Oct 18, 2023 at 07:27:18PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
>=20
> Driver may return an error before submitting the command to the device.
> Ensure that such error is propagated up.
>=20
> Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on =
char-device.")
>

Why do you have an empty line between the Fixes and the Signed-off-by ?
(I noticed this on some of your other patches as well.)

I don't think there is supposed to be any empty lines between the tags.

> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index d8ff796fd5f2..53987df6ea7c 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -508,8 +508,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(stru=
ct request *req,
>  	req->bio =3D pdu->bio;
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>  		pdu->nvme_status =3D -EINTR;
> -	else
> +	else {
>  		pdu->nvme_status =3D nvme_req(req)->status;
> +		if (!pdu->nvme_status)
> +			pdu->nvme_status =3D blk_status_to_errno(err);
> +	}

The kernel coding standard says that you should have braces on the if,
even if it is a single line statement, when you have brances on the else:
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-br=
aces-and-spaces


Kind regards,
Niklas=

