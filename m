Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2598AD65C7C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2akRc9P4gCf/FkgtSuleZCI16P/iFPZBL81LIt7QrU=; b=D8i8bwY8ThQad/E36yjgPpNxR8
	e30ARQVvVeRzONNI1j0RArm0dqneTVvu5mrZMsKC46Y6URCaPS4t/M1249h7mFCVnIBXnD5JtDm3L
	2wqqsaM8d4eU2d/gACx59ayLRuct88px867WYC+snXgfSnt2xNV+C35OVQFz2X4QtIDiyX4PKj5xz
	G1dtroi0tCQTiDRg03KYimn6/CUrJxPOswUIJRlCOteO9NNwiyIJ0UbJeg7dQcyhnYOphkkRePsou
	iGba51c4QnCJmEt5mgyoYrjEzCSU+1z29wQ+K3v5EpjiE8GH2UZQyUxvaHUeyar/OaOjrCbj928Bb
	LJ6ACOGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYGe-00000009lrK-1ivx;
	Thu, 14 Nov 2024 11:44:08 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXTg-00000009cZD-0ZOd
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 10:53:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731581612; x=1763117612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t2akRc9P4gCf/FkgtSuleZCI16P/iFPZBL81LIt7QrU=;
  b=iQ0CQUubzGm09+FsC24sc4UctrtsK7CMO+LTYulU6uQgBTkSJui+iwlS
   r5aJ7eR0BuPKnfRxo88caLcsgz4lY32xlr70K4FhTm2HeErPsxv+n7FDg
   GkJ+OYBVlQJ0T0cnWE9mAG8VRux77pWm/kh3AZfnND+JqmN4sLO8I1eBo
   M6cQ59DJg1bnKfqyH7MnldjvAsZTcfHVCi2Xc/1kU8sdck48Z9DbLr2Hq
   pbbG5hx4Hh3XqGS1WInE+/LfI9R8kmuFBWKJND7gogSMuqe1cIwNSSGdg
   R85DtKCEnLwkGWlAKrMfnqovr7wsW96nz6t879MEA+cRW62AeFJJ/4O8o
   g==;
X-CSE-ConnectionGUID: PKB86RYISNe4cLIGpiPmNw==
X-CSE-MsgGUID: lMlUaFbgS8KW7NJOgx55fQ==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="32544282"
Received: from mail-westusazlp17012032.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.32])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 18:53:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSv8dOejAcrisoqszl/+ixHPkqAELy+/aMSikYtYKxiPQml97Mh+6MpGqlyxQ1wlXV8wRGVSGOztB8T+Znm9/ZmlN2VWUKR0FTNumZ5FHQbV0WwjhmexFo7IhXnjRysyl0ERM27MH/pPPvkykg7Rv9BUN7FmztadE/1YApsVvhbZE9cPXGFFot7MPX+Bim5QS0ybDlOHRMvc94YyGgwbhQ6eIcr3eVz+711fhQJqolfsVsCa2goKSLeehV/yRPeH3J9ULpZSj+8KO+ziMRUhdgnJYHFSHFskiu2TV4SsttpW86U0WqUHO+0/feyakM6XP4eqA5dA4PyIXLWYQMXKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2akRc9P4gCf/FkgtSuleZCI16P/iFPZBL81LIt7QrU=;
 b=d4bd0kKOTDmacFNmlgm7vtF2G7ITCuq2wS8jeggcW9EZP6ewLOcyahyDQhjeMl+VSZ3om8byTw+EGINuRP6CBFB5jvYKPgtjQc40khaCLTELUQhEm3O2SHsZyb5tyxEKHmC5SBVMAslBO2mc4d4bbVd/+4fsQA9wACIE2e3RZqodB5Fw/6nl2/fwKUKZ/ZJi/rEbV2K+mbbCwb9dnnrwZxpdVC1y0XAssi/JegFNhNKEp4jto0UuziFOnhbMYKAJ48yQZe9Hpf9prEqYBC7nAYjq5ke+ehlwmThDR1uhdGUM66hm9tjD1nIfJFq5SwCXvjmfIJaXqrIDMRXd4Je3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2akRc9P4gCf/FkgtSuleZCI16P/iFPZBL81LIt7QrU=;
 b=LnAxv5USnNIc7vUsaO8lrLUkLBNyXGonoVdPYm/A9jyCL4jxIteb9MPdPqdZD503fdWf96CqLdycD+mJYcdZz+3C55eCZgd0m1V2cXyBKPYH04tIWgY/+4Mf22KfBE+NWUGC87tHtgxJqVeLxI2/7x6g65Fyax9jfWyHL/BU4io=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO1PR04MB8218.namprd04.prod.outlook.com (2603:10b6:303:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 10:53:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 10:53:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 1/8] nvme/rc: Implement --blkdev none for
 _nvmet_target_setup()
Thread-Topic: [PATCH blktests 1/8] nvme/rc: Implement --blkdev none for
 _nvmet_target_setup()
Thread-Index: AQHbMQYlaJU2gkLVokuNKXT7RBdgR7Kx5zGAgAS9noA=
Date: Thu, 14 Nov 2024 10:53:26 +0000
Message-ID: <lqd6dzrlje7sjy3whititgvdiptk34nxa5ugv6mv3wuilusqja@xlxg4pxjmzj4>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-2-shinichiro.kawasaki@wdc.com>
 <cf2b18e5-c88d-44b9-b570-e7ef0e2cf608@flourine.local>
In-Reply-To: <cf2b18e5-c88d-44b9-b570-e7ef0e2cf608@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO1PR04MB8218:EE_
x-ms-office365-filtering-correlation-id: 5c79f20c-1712-4545-cceb-08dd049a9131
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ifPfYPygg9Z8Je8OpEBH87jC1PpQE9FkfKRLppk7QBjj7wfkjXQdCZLsior0?=
 =?us-ascii?Q?0t0pZ2DXQF4b/282qxKWFhDtLn7gxFDKvtKVruV8iJZdqG3pFdmGl1K5Mvwi?=
 =?us-ascii?Q?EGKewZ+NyEY+Pnz2Wemc6UiTFT3Qn+9T7O+Kt0XYrVeZYmLui9Y1d5cDUAzx?=
 =?us-ascii?Q?chRBRA08ZaBtzm4JJAwBWV0nevceh7wisVd5T5t1kveizCsx4pSqWNcAB6Wf?=
 =?us-ascii?Q?9xIkUR41pMlSRyWqOOxEdHmHMgKwSyNPQ65TADt2YCENcGrlkev7VoNb4MfM?=
 =?us-ascii?Q?tAGPWwozyhk+zYS/Zq9maN/opqwzMNSVdt0FyWFzFmsqwoxd56pldRdlmoxu?=
 =?us-ascii?Q?qmzcihaSlYY1YgHNe/VGO9Bwuhm8CmvcIhfpGPzIk7RTukKLLjBVR85GylcF?=
 =?us-ascii?Q?H11JooY+IXU0zPxjmojCiiqiv9005CmmAuv+5qNhLtOwBRVmlcia74ZOCPfE?=
 =?us-ascii?Q?8su2VahreaO8mGrbd8m91YbgF3lZVcX1DzScqw45nO2GvPYXpsebhf8QnE6C?=
 =?us-ascii?Q?3CfLfVnzGRksgHzllO5VZdj0PdBPHYG/jGYAGs8mNWxrWWq56d1p1a4zSviS?=
 =?us-ascii?Q?YB08X4VuGs65UxnJMlFR9CN9qSq2vBv806idhnvrINvMsCD5NWKM4w9cDrIR?=
 =?us-ascii?Q?o51eXzZ6OtDXUlKMQ4xdV9yiU+L6l01hAXPFBD82T2LN4q2EQoncUE3q3KaG?=
 =?us-ascii?Q?OBchRNDxHXLyaCghj2u7h1u8JnNIcTw9YBqe/FDJl6hrusCkgth5odoTCT2G?=
 =?us-ascii?Q?AZOA8a2uhAs+X7pNMEbTdYz2KVR6vR8DaKtd+RG9VUrd2r/iAiq0+CbmwFd/?=
 =?us-ascii?Q?ViHGicivYtjElmgPH733RaaZqixU2W+7LkQikTwZaARADwD6aS9wh/zPZlBR?=
 =?us-ascii?Q?HlhoI4dD7Q4StsQ8hnMpKxillMx27MQNfHb4YkMtT4oi1RFn+Sh7bNqG6gUO?=
 =?us-ascii?Q?JPXfKJgCgbvM43U4jHJ8E0/ZsqVI2QHS8wjklJ+fRTpBRV/03lsXWJ85b6UY?=
 =?us-ascii?Q?oXot2FlWkA8O/qUY+hZiQKXtlzVPFlFjluq5tbPjX1e6KgTVz+08SYPQK18r?=
 =?us-ascii?Q?OQt1hGdSf2cjAJeJ57VRs+xJZf0h813qV3TA1N5LnhCVtEpKgmlO3KHZHJUC?=
 =?us-ascii?Q?CaB7qW5gr6ONKiEhcrg8q2hNlIoUFPDYf96d9NCM2PlpaVnfoN3MmQc7LrZa?=
 =?us-ascii?Q?kQTGARuR4CSOV2v8Agh1XCjk4Fa4L19Q/a2qle3HcKb1EzBDUUE1j21Ly6bS?=
 =?us-ascii?Q?ummtsww0bF5GEszVC1qSbjz6NhxZ/BQg95bqgCtbvDga38u3UkzWO/luhusn?=
 =?us-ascii?Q?XaNZjkIJDTNbsKuoSwoCgddIrSag3LzwP+fcrHb5P1c7SsmF6xu/rL0ibCb6?=
 =?us-ascii?Q?aIeC+dw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LjDrmcPbQIaxB1I0ssEcdWY1MP5k2/ELDxoC1zFXiqxDzxYJNbSF++e77+U5?=
 =?us-ascii?Q?reI21ctCHQ/uBpoOONE2+FtQ+GV5KS7RwuaUwlSuYp3zWBmkZWFzNegl3H+n?=
 =?us-ascii?Q?Y4fmWJtT93bqsJtIpnV1Dk/91Rekd7ilssf9D0Q/vxB5CGbpp8q8iaGqW5Gh?=
 =?us-ascii?Q?h12fcDzZ9yq6HVvMoUvtnvT+OQUYQij7I+AGUWaKstNo+n2C8pFKXzydKe3t?=
 =?us-ascii?Q?O+82JfhNdJWyU1cCIpT6EKI7PKwAtyM9YrWrSnSqPEOTvGTcSVpNVzLBMozN?=
 =?us-ascii?Q?wGmOlwOoF+kGwV9XGcNxNMLEQfgu2/0QsUX9n5YfbHPmZv5kzXkBYfVBGoXz?=
 =?us-ascii?Q?cfb5ukjtWZjdUJujE8ZE+kXGdXGl6L+jox73Ni5oXuaL6uypw5xM/jmEeU5g?=
 =?us-ascii?Q?2p9Qagt9Zp/2ddzlvO2gMvy5UkvoU68vrZuOKJWXosGNfDyB62ZLHVHd7kJG?=
 =?us-ascii?Q?dUADiaM6FhHDr+P8dsFNydJ8YnSKyimLhTIXUmTGfA6aT3Fcnt1HvByFX7B5?=
 =?us-ascii?Q?qP8fAq2SgX1FgKtPQCQmM1bXz0QaJ3gKVYFgBd+38CgaPQN9wC59+mkgggAj?=
 =?us-ascii?Q?/WC2jgtkm4ib0TlqwByY3jMFEE6QNR3/HOKkpYP0q1dWS5gaWnFJaEV2LoQg?=
 =?us-ascii?Q?yQ8j3Q98+eRewnNy4JBmYD7WWmoRic/E2U2UqssPBUuWdQqk0z/q5pNIhQ1q?=
 =?us-ascii?Q?+HsG/vjfoBxCUEPKCrorq/RlVoM7+BtQy9xllhDKXM8Fd9GanceKl303/LOL?=
 =?us-ascii?Q?SMFpoaD9ljO+PqnDk1pO8MyfyNuB3k+cy82bAwBVrQKyelwQfBDMuD6OhhuB?=
 =?us-ascii?Q?7UOuwFZ6uXjCyGp1bqRgQUtDcOztbsQ73dIr8uvEMXtNL38TCzlHN51yZemy?=
 =?us-ascii?Q?2pHpzKeDgg3wX/dDLs4NbDcHzgDG8xz6F/K0oxqBdEzI5ezyyNMSSEIf9HDC?=
 =?us-ascii?Q?z7luuaninyLm+fjF7xHYaKpZt6IW67qC8rXuZQh7liGUz7p1qBG1y+V6z8I5?=
 =?us-ascii?Q?R+Wzl0u54cvrl1VAuM7XWbH7Mi1Fagtj3/g0Zw2WfqXz1TPKnZ7fwEoj+ADt?=
 =?us-ascii?Q?EhSSxL1jInTuzmnCxk0Bm8Ae8vA3OMilEm2Z1ySCPQk739WiI5GkdESmQLLu?=
 =?us-ascii?Q?kVn14ZLw5TLWmRiOa6AXQv8C8bDsuve4OUNabi/eMW0jYe/MDDzbmMG7wGgf?=
 =?us-ascii?Q?/xRcbmzUUrI/BC9pqHITKCKPLiYUopubFr5lZTgwMG8oO7gJ3aCzQgDen5hQ?=
 =?us-ascii?Q?e7xyGYhDyPRiZzqV83ruFJB1ebeQkXy19+4AH+iv8HsG4p6YdMrOm4CwxHzV?=
 =?us-ascii?Q?qregv76/rEcThca7FQPSq3R2aVwTBXUxbRRu4/U13KFQv9eMdpATMBvVlg/o?=
 =?us-ascii?Q?OZNcHVh8w8cRkQPnuiEffJkNqG7OlEi5O5hgCe1CNuvRG9EGT+EDVyX9AHME?=
 =?us-ascii?Q?zx/L3N7OfGR55j5BtWmCVdkYeAfGRGAXBUfR9B9xtyK6yp+eEgCvb2gSv/sU?=
 =?us-ascii?Q?1NpB/WILfsjj9sNoAmFk8SB99apdWqpiibd5fprAFnZQKyl+hPS91oaqPKWJ?=
 =?us-ascii?Q?ekiuhLob7PVXc7+rjeMn5LS50a4HEhDnD5ED2Mis/gLkpxm2BqlPqqkni9Pq?=
 =?us-ascii?Q?GuvI55yzREEG/fEZDphQjSE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81EADE82B4A55F4E82147C529DC80A6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ucpwW12Mbj9hnfoc1xDR7kYyhe9AbxW7rRFaBzJeMj1R15LBNmw6iFtVM6vaIYcz5Gpfi3wPQSOzGzoviIeeD/iZlD7irB5pPygjuKes7IZ1+CPwBPqxb/icwP2FWfPWBx/rgED7ivQ9WfBp26oGx0nx2PSw0uxKAoVv9CXtxOWO70n9Vm2+99sjrmAqgIkBrRziwo0+fPHns0BXeXS72eyslstAyY4M3GC63AWjkpdBepjZUF+Q7v0pY0MkvrPoBExAK35dlpoMwyFnC1datnSOGkcxsdHjMOTuGPmXxV5NSpRuKlzhhAlpmf5QPRq9JTgVarcpJ0mfDod9BA7y2Tv/odQpD+SupeBfG/zUOudRhlunptbJP5gafmwoQi+rLaQV5UNxGK58pOLHuykGgVtiO74FnPmQIm2bAREn5QUUbuMjlQO6j5pcUnsMfqyjsMaaPkNiQhnlxuEpdK1tLTWrVgH0DENwfnhVsntO4DHwTD0tabQHDRxZBAWpysmjl7pLz4HTDgETOf7JhEMus4rpZn1Ko7SiK2qpYyRackB3ECn8LNrkcbUAOT5en/KUBRmw5vjh4V4Mi6KFR1pduIrwC/J7tT2/r1laxPp5uHOmM+AmpvH8G6B/B4Nb6+UW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c79f20c-1712-4545-cceb-08dd049a9131
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 10:53:26.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUOKEFguUFIHftOSXY0krBn5100zObptQ9ahFaCOU8sRZ2XtZ8bTNWCx1ANPZqp5AqDiioCyTNeyc+b5NKYO1AUzreM2ibPq8i8a3zYsnz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8218
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_025332_255378_0AF761AB 
X-CRM114-Status: GOOD (  15.54  )
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

On Nov 11, 2024 / 11:29, Daniel Wagner wrote:
> On Thu, Nov 07, 2024 at 08:13:47PM +0900, Shin'ichiro Kawasaki wrote:
> > From: Hannes Reinecke <hare@suse.de>
> >=20
> > Add an option '--blkdev none' for _nvmet_target_setup() to indicate
> > that no block devices (and no namespaces) should be created when
> > setting up the target.
>=20
> Okay, it descripes what it does but why?

This patch prepares for the 5th patch which simplifies the test case nvme/0=
52.
I will add this description to the commit message of this patch.

>=20
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> The change looks good.
>=20
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> =

