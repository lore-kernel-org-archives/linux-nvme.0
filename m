Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CD7C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 05:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C17kN4Qgg5Fm4/HUFq/8NX+c2uB4rYyyCpJ7yPleGK8=; b=a8fAdg213+XNyOHgcJjMBsCnOg
	JqOzu90/BAXiP9PNQ38j9YbdIyWkOoTZHdOB2FvrZqh0Z+rnJdK0b4gM95tEYZmPNBd5rukdpvYP3
	Tr0GbYws3lkiDKpyf367Ijq5Xm3CSZNEV9v49tbJlhFvwFL3sOBwzI5/YZ40XAkqk9IXq2CcarnFL
	u0hSwBVrNPQroGDIMNGda1zd5IFc9Ct0VbQkXJRmLnKOxn043qZ+Wd4+WF47wFFUi1PB4CADw23+1
	Dv1G7Cij13VwHj7/GidFZFr5WnK64tQbJtkux74Ph5JM/DJ4JmZ79dxZu/1Wm5Nmdp2l2DQzLbGEp
	2AvjHZrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy0OU-0000000F4xu-1dgB;
	Sun, 23 Aug 2026 05:05:18 +0000
Received: from rcdn-iport-5.cisco.com ([173.37.86.76])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy0OR-0000000F4xR-06oj
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 05:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1832; q=dns/txt;
  s=iport01; t=1787461515; x=1788671115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C17kN4Qgg5Fm4/HUFq/8NX+c2uB4rYyyCpJ7yPleGK8=;
  b=R5uezt5GEAWh+hAqD6rQejsqmbLdB9M7mJ9woZwugT3S43OnBKZbY0Dm
   oWaa5yawJLd4c6Rjmfudf9G+grw6oxdapr2epk/NzKeV+Vkc8c+hBZgJx
   nUrYB7HkJgJgnBUejpUuyRBj860QMys8gVgUean4tJrAXwRuDfhGq8Mbi
   sAOLEPGPHmXjNbk1wx1acpYeDl7FvDv4OtWPKpo/uWNE6uMrr41tcXXTT
   zm5whG1XBeYYrjz+HMWszKrYduHAMI9os3xWZvunvJcBHO5Q8O5gNJNiy
   XUiXdjyLgIDhZMlvv1vzB1DJ6OxUvCBJzk6b6a4//sLUg+BzBIPgB3Awr
   A==;
X-CSE-ConnectionGUID: dSEfjbEGS9m/PRC+SXgcHw==
X-CSE-MsgGUID: pE+Knn4HSnG5+DlY+eY8YQ==
X-IPAS-Result: =?us-ascii?q?A0B2BABzfopq/5P/Ja1aHgEBCxIMZYEgC4FuU4IrSYgjA?=
 =?us-ascii?q?4UrhliCJJ4bgX4PAQEBDQJRBAEBhQUCjWwCJjYHDgECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBBQEBAQIBBwWBDhOGXIZaAQEBAQMnEz8QAgEIGB0BEDElAgQBDQUIh?=
 =?us-ascii?q?W8DAQK0CQKKHHiBATOBAeA5FAGBOIheAYV4hHwnG4INgVeCaT6ECjuEE4IwB?=
 =?us-ascii?q?IIigQyBfZFaUngcA1ksAVUTFwsHBYEjQwMqLy0WDQ8TKQUtHYEjEg8dFxceW?=
 =?us-ascii?q?BsGBRIgKkFEIwM+gRlBAoF1PyMZNnqBCV6BKylgAQIQF0YuFYIHAoJagSdeA?=
 =?us-ascii?q?gFJQw4HSCILbT03FBkDBIE1BY5UH4JMAWQqllGCaQGwIgqEHqISF4QElBeSU?=
 =?us-ascii?q?ZkII6h1AgQCBAUCEAEBBoFvCC2BWXAVgyJTGQ+OX89deT0CBwIHDgMLkWiBf?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23:pxl9Jh9Nu5TWAv9uWBDoyV9kXcBvk6//MghQ7YIolPcTNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:DhZl8qIIYdgcyqdUFE+RgJQlxSXFcZb7ZxGr2PjKsXjdYENS3zNUn
 zdJDziBPvaNMzSnf49yaN6x8EkF75CGnNFqSwcd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9i2Qvajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1iN2w4P4c11d0mBCZ2z
 9dbEwACZTCc0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSAVbAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEuojx5nYj/7DLo9lf20h332cBVTqUmeouw85G27IAlZjeK0aYGMIIXbLSlTtl615
 UHA+TjZORc1aZ+zzQvG/0P8t9aayEsXX6pXTtVU7MVChFyV23xWDgMTWHO/oOKlkQi/XdxFI
 kAZ8yZoqrI9nHFHVfHnVBG+5XrBtRkGVp8JS6sx6RqGzezf5APx6nU4cwOtoecO7acebTcrz
 VSO2djuAFRSXHe9EBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:AT/5lqma+lQCFZuz3epAAhscugnpDfMjiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOCUghrYEGgE1/qs/9SAIVyzygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadv/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jDR1+GOovu7whjT2yvp6YhKmNzu891HBMadoMkYIDfhh2+TFcVcsru50wwdkaWK0hIHgd
 PMqxAvM4BY8HXKZFy4phPrxk3JzCsuw2WK8y7avVLT5ejCAB4qActIgoxUNjHD7VA7gd162K
 VXm0qEqptsCw/aliiV3amLa/gqrDvwnZMRq59Vs5Vta/pZVFaXl/1HwKphKuZFIMs90vF+LA
 AhNrCG2B8cSyLrU5mQhBgd/DXrZAVyIj62Bm4fp8eSzz9a2Fp9z0ce2Ygju01ozuNmd3GBjN
 60bpiBU9p1P5IrRLM4C+EbTcStDGvRBRrKLWKJOFziULoKInTXtvfMkf4IDcyRCdU1JaEJ6d
 z8eUIdsXR3d1PlCMWI0pEO+hfRQH+lVTCozs1F/ZB2trD1WbKuaES4OR0Tutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIM2wHlQZFdJXQXTcVQsNcmXFCFpN7NN+TRx6bmWeeWIKCoHScvW2v5DH
 dGVD/vJN9Y5kTuQXP8iAi5YQKaRqU+x+MGLEH3xZlm9GFWDPw/juE8syXN2v22
X-Talos-CUID: 9a23:GrlObG0Lc60RVtzQCLQ5MLxfFvsIfH/X4Vjrckr/MVxCC4alRlSw5/Yx
X-Talos-MUID: 9a23:JcEXtggaN1HlOStf6Cxd78MpLOorwKKoVGA2l7pb+OWABG99CmestWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Aug 2026 05:05:08 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id DB6571800026E
	for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 05:05:07 +0000 (GMT)
X-CSE-ConnectionGUID: 9UuM32ACTPup1CjJZ6+IXQ==
X-CSE-MsgGUID: uc7dJ18fTO2paSZ1ltypiA==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,238,1779148800"; 
   d="scan'208";a="66884235"
Received: from mail-westusazon11010046.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.46])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Aug 2026 05:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVTG1mXqmD3HIR2gdOs4vDn758LJe70HwJ9RfL5tlpOz8yl7ZfbxWu62SKAxe83IWNt5O3pDIdkmNmrLsxfHJxCLw/DK3xJCAf6EoL/WKluIgQLoI6DUnrZppASwgmUtUCREQ65wLnYQ9A0LH2VU4gMdq62GIGOgET4urH8l/kuJkFhZmoCmhDHmDdGflDFTSBzVN5794dAxOgSj423M/QC/XYlLds1TKppaDNshKyEZDPXiBT0MsE1TzkCB2Q7IpsMZ+e7GR2agQt5iReUEbfV0B5BGbyHcCSDnLcL43rNRoJZpyE7XwaOYdAM1cglSph2UeRs6V4vcPKNGjphkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C17kN4Qgg5Fm4/HUFq/8NX+c2uB4rYyyCpJ7yPleGK8=;
 b=vDmXVqlNJarL4vYSKx8fIBUlAQzwktVHJrk9DQ7M/guXdotWdDY4WKASBZgIjAxDbbdmEhVX89VmvQMZOIM8a2SBYj35r5oCeQ3FJeUOWTfie1vWLTge/VdhddsIWfTFt+ygjlXb393hzaZ0ccbGPCfcPFM2KWGf6JCpbN3xJQsBNhGOpQZ5xZ4leTc4MdO772jJ9aofgc8rHkcKJecL48ruugZbBphdV2F048o+C0AxwGaC6CwvjxWxJaJ/nSla2fAtNwii/ANOxhf+Edj/D+0n0Y7RX9a/c5uBVcM4DMGxapQhByF4sxBMvZujhguNiGR4GG55M7gCJ6wzPAPPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DSVPR11MB9743.namprd11.prod.outlook.com (2603:10b6:8:34d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 05:05:04 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::41fa:d12d:31c1:d5db]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::41fa:d12d:31c1:d5db%6]) with mapi id 15.21.0339.010; Sun, 23 Aug 2026
 05:05:04 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Linmao Li <lilinmao@kylinos.cn>, "Satish Kharat (satishkh)"
	<satishkh@cisco.com>, "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
CC: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Hannes
 Reinecke <hare@kernel.org>, Justin Tee <justin.tee@broadcom.com>, Naresh
 Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely
	<paul.ely@broadcom.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: fnic: initialize the NVMe local port info
 before registering
Thread-Topic: [PATCH 1/2] scsi: fnic: initialize the NVMe local port info
 before registering
Thread-Index: AQHdL8/tiO9knU7kREqpjtsF7UOa8LarGafg
Date: Sun, 23 Aug 2026 05:05:04 +0000
Message-ID: <SJ0PR11MB5896AC03937115745995EFDFC3A12@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20260819114242.3598034-1-lilinmao@kylinos.cn>
 <20260819114242.3598034-2-lilinmao@kylinos.cn>
In-Reply-To: <20260819114242.3598034-2-lilinmao@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DSVPR11MB9743:EE_
x-ms-office365-filtering-correlation-id: 496afccd-2310-4a00-5b74-08df00d417c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: /l3AhrE69/d/x2j5InP1t+Qc5YWA44Vny0/KDkvhirIva8Ueg2UIH+NwsdPtkuuyB5zzpqlcptGZ0zbbCBnpIXgw+YbUd8Bq2pGKC9fL0N3mB69R26ydgcdY84NLE693GP4el0gMw29wrmpoKeVhIUdCFxw/+I98dM0o/I3QjjnEcp8COy81YIkfntpQ/oBdzIsUbSrklxr6nqIeWY5PFdztTJwmPibx094Zw19Wopkz8y2z2FP4s+FcgMA6V9s3m/rbnEAMa7judmPe4Us/eBhANjsHKkEPFHdN9+ZEE7ezjeux6xzSN7HFkdm11yXQK1cgrReBPvi1GWDZTPNZlaoPxrwy+15FdYJoUo1DjX7pRSsqlZHywjHdqEmA2Y4RAs1okF5Qlk5KpL29Kh7SOvP1fvhdQUJDrE/An8TR2jL5GfoJ1oF9lBvnONI2O9jaxz181nhc7NVCff3VXUgNpY8kK8Lh9lmUkg/BwiXnqMNimNAvNO166M1xwnJ+pMHdriekiUEiu9Ce78+jvgCmdRk/sfmyHnQcF7+41FK+qbn92WCFhZMkBR12r/ihElyj/Y/10l5cb8o2eTTKEcK4A5EJx/aTnnMDHU7xrzqUe7DrEDcD7PEJHg+zlFaJ2Yoe1HiAP5+0kLqotTsvTzEThNNTxj9SWYGUZ2ADMlZ6kAqsz/uqZ4ZOvpDgP9tSQGCCRmRT5YoO0h8tPfDQF9jeTasLj/3Ng19FCiIIxURppz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?69XyNFSCfnBrysDVVL0Wzp5xSgXZNXHAlJnwOh/WlqaWh76xVTu+t44vMrjY?=
 =?us-ascii?Q?g6cvEkew0SHIK103T4WK4n3e/rNcMmuBljCFEKpu4jgR1SbHLhGcwKzVjJKe?=
 =?us-ascii?Q?D2Nb2qr9IlvTAX9zDp0YhfaK5Vsj4FPhdfS6wh4R6hGqyhtjrAQ2hPoYlqOc?=
 =?us-ascii?Q?/HNIDxdbpR3BoQF8B10D1iSKQtlicb4N24fJr0eHXZQm6qUbp644Kwobk02E?=
 =?us-ascii?Q?Xr69JP6ioejTsQuD1hjPS/jCmRr/sMmjjt/160OtiVOwnbjZs3vhucI9Pfnv?=
 =?us-ascii?Q?HnOsZEOTm6+cQ98zuTSS0k+omONZ8fk0w00jxzP1sxj5V+bVEIJvCvsXTvpV?=
 =?us-ascii?Q?uYi9UJMINiP+WPyCyawRgLTKPDldQ3gjspGYpI774gWZzR3LyLMxJtcwaX3F?=
 =?us-ascii?Q?fGZ8cK/Q15FVSIVdOQHUpmdZhyz83ZljEkFN7bWR9Nse+Zw+3u8QSCl3C6Zr?=
 =?us-ascii?Q?UWRDMfSn40Wzfqp2Y3Z7KjMTUX2LOJYIWoOB1K3o7bJF7UtvZrqX3XkmYCGJ?=
 =?us-ascii?Q?YtAfJTdlj8D4LRHR8RVNKr01vtyW17Dl+nJghqU3R0Ibmo54h7cbyRG9Gyo5?=
 =?us-ascii?Q?RZSqfI6u2SLLGEqc6jMKX5W+naVyBOsnxntA5jRSDlMhI2MkjKOyUXXi7LsT?=
 =?us-ascii?Q?hUly4fYrXvP5rb/55+oEUHQtoU67UiCwBD/FRzfGcb0+weJKAi6S1ZscuMUN?=
 =?us-ascii?Q?RQ95+P73g0RIwisT+6mlCote5aIc5H4JfSy16qx/99k7rX83msF11c1khuQw?=
 =?us-ascii?Q?vxwuTgEKQkDjklMxKPDX+3c3RfWe6NZkVKcIS7VeCtDMbRFuLPo95oG19HKE?=
 =?us-ascii?Q?d22ExGGa6gNEYWczggQ76JZXsAcE4e6L82Ar6yaFWLli5wM+O6y+pgo9DLwB?=
 =?us-ascii?Q?Jw+TfMboUS35bVAmK1+ELmWpSor0jnACD4nGIHtxnw0hjrlZyu/+8ecJDNIU?=
 =?us-ascii?Q?MjPaZvgRc84BVhkGayZMY8rq+rYdCvafsA9I3+WxChwg6obIQZ6VNxpj7yNR?=
 =?us-ascii?Q?fEWvHdkuz6cTvvUUW1CD6mMHja0J/YXE1k4nOjBZ9oftwB736h3GdChaISxs?=
 =?us-ascii?Q?oR+MAls4Kh+Am6zhqTMheYqaotkMnkMsPSBKYDlBl6WjT9WOj7x5OkH/ICbt?=
 =?us-ascii?Q?4DJNlY9MW/S9T0UCvS808dpHxMPVBoUiXWzb5E6wofehNjuc39Ty07M9yYQ3?=
 =?us-ascii?Q?wM5XpkhmFZIr0HrVm3EDp3aO4CDe05MYaRVAnMILqYUwrVxYME9bEL94vXBJ?=
 =?us-ascii?Q?oHfHe/9pZr9EXfU6YQQ10fWAFJTi97YBxlPwDxjhJ3V4BirTxa1+Q0ZLABjv?=
 =?us-ascii?Q?MpU/vlthlBTtw3GQAPakpJLkFwjv35l/ImtCZJmRGIJ0ZVcn8Vh63d9r80Fo?=
 =?us-ascii?Q?e7uQg9CTGexn6BhCx9w5gM8nt27RTJXjWR94SPnOnGOh0y3LIYa3YvG/cul4?=
 =?us-ascii?Q?6ntXoVXrxgie+R+FG+208T39EJKEu/k833YQGSaMYflNZs7AUPreVReBDIZp?=
 =?us-ascii?Q?+3h8FGNyl0Zr3AEyKXj4EyIdQeQx5Iuxzq07Lex/BDjceHLpXvYUSEBHVt8V?=
 =?us-ascii?Q?y5KqXrqvxBU6FG5ImR1UW8Od6AsDoUXoTa438tfGehOFeg20vi++bIHijxA1?=
 =?us-ascii?Q?HViJEZx5918PpI3fuPxmHRM4p5w4idPAxN0DiyUvD6M8YHXPEurJ2enUSh0u?=
 =?us-ascii?Q?S7qEhfHiWWyOC1YSOd1OQalGUOk0yr/b7u2wbuWuQEAE9n+A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DHm4SCAdS4G6iy5qW+0OLT6WjU5+IKSqoZzXLVFEiuPVws2Ix6Ze6BfR9zrArcspgHJSg8t1gN89BM747vMWjli0rDqwr40AljwAjicHPHDzJq4kyFIAY8WyZiDOYX11lPbV0JyfUklKnAKJZ9Nh8qPE2WJqQKL1iVlP6xgYhN++kPs5wrGwkrTwex0H5Y/amLau2/jNz+w0yf6HilLIvXfhuNlsrkLTjB9E10zCPLrGiNm8797+FNbXzWr7kP1r9WE33xfC84SSLro/VcetEODKX6fK2fHPcntZgKNs3y+YTJjzHVYwPKQFA0Saoak3roiUzIQ9ZW1Z9lBST+Bhpw==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496afccd-2310-4a00-5b74-08df00d417c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2026 05:05:04.1569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TK5v77FSiVgb09L+1UZ1UXqJ0NvLxa63INvJy8ZBKp5ppnDVjhzcf6cRnRcUk5V3JBkzqKfI7D4GHeg15JXx7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9743
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-5.cisco.com [72.163.7.169];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_220515_249324_0473A662 
X-CRM114-Status: GOOD (  19.36  )
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

On Wednesday, August 19, 2026 5:13 PM, Linmao Li <lilinmao@kylinos.cn> wrot=
e:
>
> nvfnic_add_lport() declares struct nvme_fc_port_info on the stack and
> fills in four of its five members, leaving dev_loss_tmo holding whatever
> the stack happened to contain before the call.  The structure is then
> handed to nvme_fc_register_localport().
>
> nvfnic_add_tport(), which registers the remote port a few lines further
> down, memsets its own struct nvme_fc_port_info first, so only the local
> port path passes uninitialized data across the transport interface.
>
> The NVMe/FC transport documents dev_loss_tmo as "Used only on a
> remoteport" and does not read it in nvme_fc_register_localport(), so
> there is no behavioural change today.  Initialize the structure anyway:
> the driver must not depend on which members the transport happens to
> consume, and any member added to struct nvme_fc_port_info later would
> silently start out as stack garbage.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
> drivers/scsi/fnic/fnic_nvme.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/fnic/fnic_nvme.c b/drivers/scsi/fnic/fnic_nvme.=
c
> index b237948dcafdc..00d9d5d439a38 100644
> --- a/drivers/scsi/fnic/fnic_nvme.c
> +++ b/drivers/scsi/fnic/fnic_nvme.c
> @@ -2216,7 +2216,7 @@ int nvfnic_add_tport(struct fnic *fnic, struct fnic=
_tport_s *tport,
>
> int nvfnic_add_lport(struct fnic *fnic)
> {
> -     struct nvme_fc_port_info pinfo;
> +     struct nvme_fc_port_info pinfo =3D {};
> struct fnic_iport_s *iport =3D &fnic->iport;
> int ret =3D 0;
>
> --
> 2.25.1
>
>

Thanks for the change, Linmao.
It seems simple and straightforward.=20
I'll bundle it up with the other change in our internal testing and get bac=
k to you.

Regards,
Karan

