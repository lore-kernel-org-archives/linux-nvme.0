Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB75D7497D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSPVr46F73sVlcDDHp3cXWnY698ePM9wzSKSEuAp/q0=; b=X4J2/FePpx4OPOy6hBs1nYX/b0
	yU5qMFY6WnrRm5XKufkFPMVCLiBT2yFxgcQJtGn3swVI9eNYM8dZTw12AJdK7F9kjnnNHPP0bg9+1
	tIHrZWii2dSvjLBRxMQBX+0jlDbD9G00Wp4r4p/LxT4i7uS+WKN6WCOeti7EM+DZQYebcqXtO9tIz
	L1GX45QKGChCJFxXlhFjBhI01NqhyGv/Gps7LNNKj1Guezr/nBrp1YZO4EfTj8BkXtzAjQxnIuQtk
	zBit4yZgwGsmV7yLNQSW2SOoHayN02mPhOwoZoFSP9voMkAd5FVZ3EY5GNbcztha9b/liqeXg6cFb
	hH+ek1AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63E8-0000000H9pS-0QRF;
	Wed, 30 Oct 2024 07:34:48 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63Ar-0000000H9EL-0xSW
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730273484; x=1761809484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fd/hsWda8v2v2txC8a9YbCUpL15iozQWqPlchP7+wOg=;
  b=WSiSgx/UCTBJIfSYaSPI0yEdZh1Vq5I1OXc4DB+Bv0ydQf8M5LsaqtWs
   w0YJBH4EltI31cehVpntJ3Zkm9CDH1QFNSibnOV4ju+E3vVWynLtzgm0T
   ke9o+AH/TLKmF8T6Re4npUnPJuK1wteZ1Az1ottsas3+Hvh9fAVSlMCm8
   cRz1leh3fvGxAE1o7kjQ5q++yaxfPTdZXzkiCjAlbMdzomE8t6ZysG8Uv
   0mtr48m83P6Ph1gO1dTSjtyspzmdbg8058TO+92nYPODLAGwltsKystVG
   fzWt5yBxnFVb745zU7jK11+p5zuBx3hQk6+PS3azRdwsjA07rPFIplO+i
   g==;
X-CSE-ConnectionGUID: GXELcvnYQWyRmuvFYIUlNQ==
X-CSE-MsgGUID: hYvHnlqJQkuuLcbqIjkLlQ==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31317162"
Received: from mail-dm6nam10lp2043.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.43])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 15:31:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI2B+M9YLaNRpzVK2HdtoqkHtTyMMIz3glSYoKJkjlEONvTJ4c/NG5suzVtA7LTwmQiNP0saRWvIYZLbnBzqIneEpERMRmr3w5dAjqw9lNhsktPfrkXgN99gbdguR/hbokRSm3qLIgyxfS6uI345nOId40HABzBOW96GiIsbE4HCfDAzaupDvv1vymgSXndGu/hEXoiQ12vc5uleP7lId6BbBp9MbGWbzkcwbFl/JJitYHj6KhQJ5PxVOYQRPdpAVt3gq8OP2pgSyp4MSPfc1cDUr7Zrzqm5kpCPMIeYGzAcv+rvmPI5ASz+XgT3j4oYcv1RVfemaHZAnwitZXI4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSPVr46F73sVlcDDHp3cXWnY698ePM9wzSKSEuAp/q0=;
 b=YeqcLlL2e94w7ISGBlgN1bB9alaR60XdGaUXF4iTZS1qXcaXVvThNFHEljeXEZQAbHLCze1ts+BRJeXMoGaJrtpxZg1F+J74JFt8YAV2V37hAWNJ5ej0u4wAxAIKAX46PxhVcWy4COq+L4KXScDlIcwwCIn2vJab4Bqhry+w13nEgTzrdhhN8zHJL/1fnbQ39rzrj8whiBob6jtbac/9myUHfxH+cAjpz7OFs/PGcMhXZhDXoTfU4eOBcghWeHMbFhP9gLNDBRKgVa+Pb5SwNa7EkZXJ0pUtp97aqrnfIROrKHyzi4fYO5A/7UlpQY4HEjPSuUdirG71uVekC3G1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSPVr46F73sVlcDDHp3cXWnY698ePM9wzSKSEuAp/q0=;
 b=LdRRV3rg8j8vtJCLn+8eaTMbhIHzy3f6hVCJgoARPMYY75bcGk/ahZQ6Q2SD1YFUP6b6V19hkbwqYWtU5kmy2NTKqCR4sQYhbDs7wHlNpypHuyn5WS6mXpZNVcJRLfvFVuwc8wlkmbpFr7rgs27hwslu1AGcn/q/83NrREXj/Lo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8603.namprd04.prod.outlook.com (2603:10b6:806:2e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:31:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 07:31:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Topic: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Index: AQHbKbFofh4etkxEjEuSAVUpfIuqMLKe6AgA
Date: Wed, 30 Oct 2024 07:31:18 +0000
Message-ID: <33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt>
References: <20241029031931.118305-1-kanie@linux.alibaba.com>
In-Reply-To: <20241029031931.118305-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8603:EE_
x-ms-office365-filtering-correlation-id: b28bb663-d119-4d9a-971d-08dcf8b4d851
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AyZd/fTDNlJ2v3iFnERCH992KkcKU84W4JU58GKU/BWAP73q64wiuFNnuw8f?=
 =?us-ascii?Q?6xmB06fxAoy3XncUNecIKH1daCPu3fdKZ4OKLhdWJQBsOPgYno/wjostxPvy?=
 =?us-ascii?Q?r7/XOF6Pam7ZCw2JB5DnXfQzyYQvZWOglmgZu4Uk6Z+1bftX/8tcPLID5ErM?=
 =?us-ascii?Q?RWcouOaMvtujyehcWPASzBiRLZEje66LHVceiMZMKCpYcGzMeOhbXOvOoFVd?=
 =?us-ascii?Q?+w7JFnEiBRPdcRhspFM1oGjic4wy0lKalSEfHyTxhI+yd3OiwCKUXzNlg2Ta?=
 =?us-ascii?Q?/qmclfbvPU2jzGj/Jjbin7cRNpYsGyeprEV5Q67paoM8EIKYxhUeVAJ6ngrs?=
 =?us-ascii?Q?xkpHkGZ0tIm78BRYO4uOKOagr8h3hiD2ahT0ECDK+x2hPei5cwY7qLgeda5D?=
 =?us-ascii?Q?rChvyFnJyfUzrudV4Kn88OFteCT+sJ7+98+3xywzM2I3fzHq7OPwOBBnJdT8?=
 =?us-ascii?Q?Vz7ZxUfmm3SRPGC742Zp/MXE5rUM467UqZ29soxZfm5MqDuYKnYJfNZmMsG9?=
 =?us-ascii?Q?5LwzpTl/xKvuwkKT3seJq6auyHHi3FqUA3yiLLtF01L1WEnzDlYkGm6ec+Ua?=
 =?us-ascii?Q?yN8bDl+c2+mVIshYX7Nxu65ntpicRtzejEycJ7OR8BksKkyejzjphUt/l7Be?=
 =?us-ascii?Q?vvFUkulkJjweqtvlzI//nJGW4EuHNmFTTnJ8blPF+JrUbUkRjpiQq9S+cVDc?=
 =?us-ascii?Q?sXlHOAnyHNDzLnxpUrBPFftgQ79eUfHKr3rLlGrKaiLrESjx2Ct7CuSubfZW?=
 =?us-ascii?Q?9SxbSovBEC3+dyuHLMbL6AjqDfTXyHg33kpoCzCd+aQxkmXWXe1zOB7Zm4Kb?=
 =?us-ascii?Q?uKx2VpDJowkj1TAq2d1Si40gustA2TOzJSDVMt7IHMX0OQwY7AxxOfcw8ep+?=
 =?us-ascii?Q?hOoF8+XyBci70j/vmErr+nNlvvy0cGeioGX3NNoeO41DFmgJO/g1mLiT4K9n?=
 =?us-ascii?Q?h+zKoniLrt3BkVv8m4nLzPFPtmCnVJzrvke0LxtrKlyqkNVI7EyRkb6KLh5Y?=
 =?us-ascii?Q?qIrilmbzT1KGCiA6Xg90NE1duYUOVu2N7T3VeripN78leTol4C9RYSas62Hh?=
 =?us-ascii?Q?z7nAGtXEZfHp7Zh7+mhy+mUWoxyBvAAo69BT5vD/Bg7Tmx5EbyOYKNup1+6i?=
 =?us-ascii?Q?Yq911tg4KOWyX28sGSH1O6mqIEJz7ZxTUpQnUZpVwCTCoiyOWaUUEJh4KpLa?=
 =?us-ascii?Q?+lsi/9bjrAzv4eCAYwUEyGkicODzXkXOCjaiXoS+31PA99YjTw52VV+dPA4Y?=
 =?us-ascii?Q?WtJoPq7m+dzJy4u/hqp/rr9bVrDp0BpXXhNy1F5n9Lk3YFbEHEwtI1BR7lH3?=
 =?us-ascii?Q?wzZhvZdxXFNpZcc6s2otiE+xoOjnTZN0tfbxDct4c3iJ4iT8uX0kA0qZ6AIm?=
 =?us-ascii?Q?6gtnzJI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qjNGFw/QwGi0j9/bBO33d27cbPAlxgPag+syc51WXNCrcQ14GNCaUpVo6BdU?=
 =?us-ascii?Q?MVX8/yXXpa9Yt4cBPgqI1E7Pkw3MkuppevRei4VUGpHUQuBpYavdWDqnQBu/?=
 =?us-ascii?Q?b3VkZ1VpVvQkDTLAPbD+p/raHtSpxPVNsnggUt9FjfQDR59pMcvx957exTT1?=
 =?us-ascii?Q?ioHiyyelWETglAHeQ7jzgj5GMm/C6mZ9eH13vco8Uwb66ah6HuabOvD64fO9?=
 =?us-ascii?Q?z6fO3Az+9n5Imi+kE3+igJdvzxLiC96kY4AqrFYWPcI2Fo+EKgBsXX7ASrVR?=
 =?us-ascii?Q?LSenVkxbmHNzZYr6cLmCmiZejL8tELe7qSxc5wnlbouOp/cqwD63qCbPTifX?=
 =?us-ascii?Q?U4f2FX4ZlzmtvL3gAZmiBqlAnYWUgl9JkMWofHjx0g8ZGB5mbirRn1F7HsFY?=
 =?us-ascii?Q?1+1QQm/IKD+tE7O4OCnxgyDMdez7h4QVv9PM4VfdKSqZGw01C0I3fpT5K4B0?=
 =?us-ascii?Q?+v3TBwtazsKzF9fQzdX7qaDwmN9lnlAKx+6tfByl3mr86Do3Awsfxx2WMMnr?=
 =?us-ascii?Q?7zaN1ZsreXVvarlq9eCtfh72Akb6inLJRFslwQEncsU2P6CTcpBN+XxcquNY?=
 =?us-ascii?Q?I+T+ct2nW0UAGmDhd4jJNYcjBrAodTMRCIMs9GDwgMPzRUQ2/6Db/iwqpBTC?=
 =?us-ascii?Q?VtDZL9s0Z+eHuyQ/62vo7Turw5xo9xWKQSXuf7IbLBevDrh42jifuxtwlHV2?=
 =?us-ascii?Q?SMDdMWk7Z5ZWilUPfEg3Xlwlv/7nlNXtJXmPNC07ex+7LuC8KRyGgOHzwl3t?=
 =?us-ascii?Q?TJJKxOb/xYpWQAF8fcubb/NGTtfiw9Z0s6nq+msWbCnUW3WQghaMA6+qVFzW?=
 =?us-ascii?Q?6S/X9AYArm3HXB4jAhl17CUj5OLdR0demZCyuEe4r/t4Mt5V8Ox174SM3IhY?=
 =?us-ascii?Q?/ivAR1CctBZjISAoextcbEK8DuR0ykBbvBYUIGghQgAwcNv9gSrZY2Klkqe+?=
 =?us-ascii?Q?HYYvfIJmdWLbBlUEWz2UTl3RJU76ZLbyyKftF006kwTtUdxPrn7CivzPfOhY?=
 =?us-ascii?Q?r6mDpyGv4a5E1n7tgL9JvQWwqVmOVbXWPuP992gkKcUbUs/FcT5B94nOT4ep?=
 =?us-ascii?Q?DJ/1KGRlXCZYTfZQM6wUG4cHOdc9TVFK6bTE0nSU3cJICwrVSGZtQRqMaJ6l?=
 =?us-ascii?Q?Af2nbv4YxzEKJ7RQHY08S3Iz6uEL7fncEnOSjRFsMYEOydQxaCTUjQiE5VEK?=
 =?us-ascii?Q?MQ372Of1NCCEYKw7yeAQbbeUWqQGkoAmFi7ScAAfdTv9PjAc7ZhS5/a9pxvU?=
 =?us-ascii?Q?zWp9zxpv3PVyIZJCLm71hrw0M0JLN2E/qx7Zn/tH+K+U/3N6JrQi7hIndzWp?=
 =?us-ascii?Q?CW+ZWAphLBy9QN0ncZzACqxlS4T2SiLFBDALdkqaXksoE6y1SauRcAF/1deb?=
 =?us-ascii?Q?EHIGo+p6iLmslmXyIDBLYNBUiBUbKVtACHLu+LoxH42aKEnpRfynFzRutDbu?=
 =?us-ascii?Q?x98rNzJPvnTDfUt2H2z+qe6+STQd9X48G4l7xl8ENcp9jjz9uo+ONXZqr+2B?=
 =?us-ascii?Q?f9II1FQEBJeF6lOBHwO9Mh/Ez96lMlImJAuKoF+naRPIYGCH6Ibpweq9kFlN?=
 =?us-ascii?Q?t+b6lwXm+03gAC98/KnX9sdlKyd9iwcW4Ge3VHjypXOlVd5LgWDXPU8gFm2j?=
 =?us-ascii?Q?e/Gh136bKNTa85xc657ssIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC845379CE2A724B92C2498309091066@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SYZYilV8ky36yqhZupLLDDZ2VvJCgezurPCA3MujiGic1DpFRAPafIjyCFTu5X0WaWCuE9k3zMt3XB8GhB1VBQSKlRit5/QxoMiaLeWSdQb5r67+5kbrh54ix6mbL3in88q5T912B2IUa3qpfGCCB8+kJrJa3ElsJd9pUSZ6iStQn9eWwd+oiX0jdmavNkaCeF9PheLMe3J79e/zUfsKWUXvW7VT85dMM+Axwniyj0YjbC4zyv0Lf3WMochBRWjDaM44wK6oCg7DgjW3/mN0JzByN7gP8VPfpRSuQ+sYjVo4r4w/REGhXSlhuJCi0q8iijSGzkbwtWb7SSGBLlz9SB8ChDiC1jZ+5Ue2iQBex717v+5VOjcEKP824WK/39xV09s4ThleZD0g9e+Es1hT0b3W6LHp3dRDfLnU2oWzkjfSYB5ct99ShJYLH2w+8cp9oNtpbBTMyh7wnBvgSBRL5EkwkM4kA5IEfjv6lH4vSHVBvr8QPKSVmJLtT93CyFTvCrPIPzPf1KMUEXBe6DOTJMaQf+ftX2pCIIrgtS6Eoe0JYSCf3sV0mI3jGCM4r7ikkv1Fr+WO/4F7MYpJrD5qxd3FitkqBf2sNF9h4RnZyvwrxmQlY5SGF/elbWgLls62
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28bb663-d119-4d9a-971d-08dcf8b4d851
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:31:18.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/y3TlvhGTwj0Y+1S5WSfrXImr2Vmb5EvR01/Z5jbwwLEZcnPddilbxOFmxHIgBbV40yh70/qZZcaRi6Dc5RcuBQYcRPpu/L2ri19c+Jw6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8603
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_003125_358268_4188BDBE 
X-CRM114-Status: GOOD (  23.14  )
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

On Oct 29, 2024 / 11:19, Guixin Liu wrote:
> Use def_nsid instead of hard code, the default of def_nsid is 1.

Hi Guixin, thnaks for the patch.

May I know the motivation to introduce def_nsid? Does it aim to improve cod=
e
readability? Or does it aim to allow testing various def_nsid values?

I guessed that the latter one is the motivation, and tried it. After applyi=
ng
the patch, I edited common/nvme to have differnet value: export def_nsid=3D=
"2".
With this change, nvme/004 failed. I guess your patch missed a change in
_remove_nvmet_subsystem(). With this change, nvme/004 passed.

@@ -589,7 +589,7 @@ _remove_nvmet_subsystem() {
        local nvmet_subsystem=3D"$1"
        local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"

-       _remove_nvmet_ns "${nvmet_subsystem}" "1"
+       _remove_nvmet_ns "${nvmet_subsystem}" "$def_nsid"
        rm -f "${subsys_path}"/allowed_hosts/*
        rmdir "${subsys_path}"
 }


>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  common/nvme    | 3 ++-
>  tests/nvme/051 | 2 +-
>  tests/nvme/052 | 6 +++---
>  3 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/nvme b/common/nvme
> index c1aa8d6..6371efe 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -16,6 +16,7 @@ def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>  def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>  export def_subsysnqn=3D"blktests-subsystem-1"
>  export def_subsys_uuid=3D"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> +export def_nsid=3D"1"
>  _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
>  _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
>  _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
> @@ -537,7 +538,7 @@ _create_nvmet_subsystem() {
>  	mkdir -p "${cfs_path}"
>  	echo 0 > "${cfs_path}/attr_allow_any_host"
>  	_create_nvmet_ns --subsysnqn "${nvmet_subsystem}" \
> -			 --nsid "1" \
> +			 --nsid "${def_nsid}" \
>  			 --blkdev "${blkdev}" \
>  			 --uuid "${uuid}" \
>  			 ${resv_enable}
> diff --git a/tests/nvme/051 b/tests/nvme/051
> index 624b42f..4757b80 100755
> --- a/tests/nvme/051
> +++ b/tests/nvme/051
> @@ -33,7 +33,7 @@ test() {
>  	_setup_nvmet
> =20
>  	_nvmet_target_setup
> -	ns=3D"${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
> +	ns=3D"${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/${def_nsid}"
> =20
>  	# fire off two enable/disable loops concurrently and wait
>  	# for them to complete...
> diff --git a/tests/nvme/052 b/tests/nvme/052
> index 1dcda23..781a9f0 100755
> --- a/tests/nvme/052
> +++ b/tests/nvme/052
> @@ -57,10 +57,10 @@ test() {
> =20
>  	_nvme_connect_subsys
> =20
> -	# start iteration from ns-id 2 because ns-id 1 is created
> -	# by default when nvme target is setup. Also ns-id 1 is
> +	# start iteration from def_nsid+1 because def_nsid is created
> +	# by default when nvme target is setup. Also def_nsid is
>  	# deleted when nvme target is cleaned up.
> -	for ((i =3D 2; i <=3D iterations; i++)); do {
> +	for ((i =3D $((${def_nsid})) + 1; i <=3D iterations; i++)); do {
>  		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>  		uuid=3D"$(uuidgen -r)"
>

After this change, when def_nsid is larger than iteration=3D20, nvme/052 wi=
ll do
nothing. I think the change should be like this:

    for ((i =3D 2; i <=3D iterations; i++)); do {
        nsid=3D$((def_nsid + i - 1))
	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).${nsid}"
        uuid=3D$(_create_nvmet_ns --blkdev "$(_nvme_def_file_path).${nsid}"=
 \
                                   --nsid "${nsid}")
        ....

Also, same change will be required in nvme/016 and nvme/017. They also use =
the
--nsid option.

$ git grep -e "--nsid"
common/nvme:                    --nsid)
tests/nvme/016:         _create_nvmet_ns --nsid "${i}" \
tests/nvme/017:         _create_nvmet_ns --nsid "${i}" \
tests/nvme/052:                                 --nsid "${i}")=

