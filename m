Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0AEC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 05:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AbwTJftiuRi31J/k2Z+DNHpUsNSGYoKMm3ahL56RZ0s=; b=czeY0yrqlvF3BO8UenbJ6rLzPE
	8acPTbGqLPkxjnge+meJgSR3IaL2qx+SteMXCTqQcDT7rD8ycT0/BAG7DupBgldgOJk2+UkCLbpds
	iZk9MOjqi6ZiV5METvVEZGqqD/iVsUoV32V81D1dCboETflVAjjEs6rWoTEinKNdPmlIjmkDfvMRh
	E3v/iASuejk4NxDhPCYj5bH0Pr6DtmejJoIjwQBCsyUoHC4l8koSg00nZ3dMAqbuFUFRV61lvLLZg
	RKl24LggS0D8RnjjHX6scZXJGBxZ8V7hNHqU2zXcOfs5Q/9Js6bUxCHlKoXWxSXhHNREEgyzGvAIm
	45ZI8V8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy0U0-0000000F5Aq-0dxS;
	Sun, 23 Aug 2026 05:11:00 +0000
Received: from alln-iport-1.cisco.com ([173.37.142.88])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy0Ty-0000000F5AV-0l4M
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 05:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2181; q=dns/txt;
  s=iport01; t=1787461858; x=1788671458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbwTJftiuRi31J/k2Z+DNHpUsNSGYoKMm3ahL56RZ0s=;
  b=k5qrSkqFCnHDg6k3wEyFpqzYQup5zYtWi1AtDGNUV/n7KMnT94cLWzLu
   Btk+mQiwMdo0pS4cjrwhSCkdGwSuzdyilpadgBaVRpASsKlggUcVvwFvN
   vsKLt8EB5WR+nTq07oyUHdk1y1HYMRFj37nGcaHgYyxDZkgSm099tqCmh
   tvQsgnE4Uqmsjgby9hM0BnqdN15y9yr0nJR/SS4JOtGaitLe7WHtTJ3Yj
   WoSKAL2jki362cVw1LpW8PAZB09ZS22wyNpDl+nS7PHlzm/QgAQVcMP9H
   Dr0GDf9Yq3MpExoef3VRaVWtEu+f2B6FUtZqv0dxapCyUGyjfq9g4pZit
   w==;
X-CSE-ConnectionGUID: Y94XkJmnQEqy0NIUQKcu0Q==
X-CSE-MsgGUID: R+vIXhTwQruuuyqXaBUMww==
X-IPAS-Result: =?us-ascii?q?A0B4BABPf4pq/44QJK1aHgEBCxIMZYEgC4FuU4IrSYgjA?=
 =?us-ascii?q?4UrhliCIQOeG4F+DwEBAQ0CUQQBAYUFAo1sAiY2Bw4BAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQUBAQECAQcFgQ4ThlyGWgEBAQEDJxM/EAIBCBgdARAxJQIEAQ0FC?=
 =?us-ascii?q?IVvAwECtAICihx4gQEzgQHgORQBgTiIXgGFeIR8JxuCDYFXgmk+hAo7hBOCM?=
 =?us-ascii?q?ASCIoEMgX2RWlJ4HANZLAFVExcLBwWBI0MDKi8tFg0PEykFLR2BIxIPHRcXH?=
 =?us-ascii?q?lgbBgUSICpBRCMDPoEZQQKBdT8jGTZ6gQlegSspYAECEBdGLhWCBwKCWoEnX?=
 =?us-ascii?q?gIBSUMOB0giC209NxQZAwSBNQWOVB+CTAEBYyqWUYJpAbAiCoQeohIXhASUF?=
 =?us-ascii?q?5JRmQgjo2iFDQIEAgQFAhABAQaBbwgtgVlwFYMiUxkPjl/PXXk9AgcCBw4DC?=
 =?us-ascii?q?5FogX4BAQ?=
IronPort-PHdr: A9a23:X3Dqlxc196bF7hV7ZGYm0O8mlGM/gIqcDmcuAtIPgrZKdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:fF0chqBIzJzfExVW/3/iw5YqxClBgxIJ4kV8jS/XYbTApDMrgmRUn
 GYYCzyFPPeJNGH9LdwjOdi+9xxV6sLTz9ZlOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYA//gGYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE8qQyPEIUOIsh1/9mWUdvy
 MU7Iy1VV0XW7w626OrTpuhEj8AnKozveYgYoHwllWyfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWAHgBfoO3WjPn8UAYgineOhhVH0ciZTrxSeoq9fD237nFYogem0bYaIEjCMbf8WgGeop
 l7Zxn7kHwwLLeyW4weg7W3504cjmgu+Aur+DoaQ8v9snU3WwHIWBTUSVECnur+4jECkUt5SI
 kBS/TAhxZXe72SiSt37Ghn9q3mes1tEBpxbEvYx70eGza+8DxulO1XohwVpMbQOnMQ3Xjctk
 FSOmrvU6fZH6tV5lVr1Gm+okA6P
IronPort-HdrOrdr: A9a23:IZwYvao3mm02ctLC2uUtZqQaV5skLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H/BEDhex/hHZ4c2/h2AV7QZniWhILOFvAs0WKC+UytJ8SQzJ8m6U
 4NSdkbNDS0NykEsS+Y2nj3Lz9D+qj7zEnAv463pBkdL3AOV0gj1XYENu/xKDwOeOAyP+tDKH
 Pq3Ls+m9PPQwVxUu2LQlM+c6zoodrNmJj6YRgAKSIGxWC15w+A2frRKTTd+g0RfQ9u7N4ZnF
 TtokjU96+ju/a0xlvm0XPP75NZod3lytFSLs2BgMoYJ1zX+0eVjYJaNIGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg+CxG0Q6g9XaoxV/Y5eDpTjMzDMRMwahDdAHC1kYmtNZglI
 pWwmOisYZNBx+oplW+2zGIbWAuqqOHmwtkrQchtQ0YbWLYUs4JkWUrxjIQLH7HJlOj1GloKp
 g0MCiW3ocnTbrTVQGrgoAo+q3tYl0DWjGbX0MFpsuZlxJSnHx/0g8k4fZ3pAZbyHr4IKM0u9
 gt9c9T5exzZ95TYqRnCOgbR8yrTmTLXBLXKWqXZU/qDacdJhv22tXKCZgOlaiXkaYzvdMPsY
 WEVEkduX85ekroB8HL1JpX8grVSGH4WTj20MlR65Vwp7W5HdPQQGC+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rHYpSxQXxV5RbNHFbWswIvdQwXU6Iv6vwW8fXn/2edOyWKKvmED4iVG+6Cn
 wfXCLrLMEF9UyvUm+QummmZ5osQD2JwXtdKtmvwwFI8vl+CmRliHlhtWiE
X-Talos-CUID: =?us-ascii?q?9a23=3A5KITsmuopSwPSpt8Fu6S3TAE6IsUIyHtz1XVJXa?=
 =?us-ascii?q?VEHcxbpyocHyb5ftdxp8=3D?=
X-Talos-MUID: 9a23:QnCQRQkD7E7Ox7N3xiUbdnpYd9lJ06SSF3kXjIgbqtC0PAZNHiiC2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Aug 2026 05:10:55 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-05.cisco.com (Postfix) with ESMTPS id BFF8618000172
	for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 05:10:55 +0000 (GMT)
X-CSE-ConnectionGUID: rr/OQn1iSEaj7EL1sHDsIA==
X-CSE-MsgGUID: iTmpL3EUSuCbwxrv+oZhMQ==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,238,1779148800"; 
   d="scan'208";a="84360525"
Received: from mail-westusazon11010056.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.56])
  by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Aug 2026 05:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5bnfM8Z548DIOvMENP6OqX09sboyBjko4EKD0tCdj+CVUy6JarYZQOH7uwpeyOzZO9BqzcrUkK5G1O5kHFLixx1D//n6qgmxVWnQsKGXSegFYmXLlQsidHgD0leO8BlcjPX4WK+UphsYUzBSxba6L07jpG45B3aRjZKOmH84iC0HE0SmJHr6LwxiJLNRCaT555bW0mVqoL6SkDqJtL/kJvRVuWc35vjf5TZHMBjdp+hE7+kUmQQNc5CWPbCAGhv4/wtnA+MEGJzmm3i4XAOtwStKmRTyNsSXqK6h7waskHpWYfVQD3jdH2u37kBrDJ/D3HRvH456nbL5Nk7jA1aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbwTJftiuRi31J/k2Z+DNHpUsNSGYoKMm3ahL56RZ0s=;
 b=LK5LP+eWMTt6FSXvVQBeMpqjdON8h+S4APgwtFiEgjGuZeSXu7lQdbUSDjLIQdYiOCQMyVz68CmvTzFX0UFqa4JfNCMzAfi/XLAbtReZkJygYd73lQ4Q9a1hsKDRzPhaC0FFezVhFh3ZT0QmoBC1LqsYPTIVWBI5VlkmYljnoVMoqVlD8hhYoCJgDkIMHZ1CptoR2/JR0oaD073gYpxBdQzBboZO5IaxqOl0K6Ejy7RFSw89hgFCDbXmIiBrqzlMQEdXme5cCyBr2SEfeISZGhbxj3M2MzYgnttIS7Rmx8yd2XTQEmVz157x+s/Mn3rg3or84y7cSgzE54CgPew4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DSVPR11MB9743.namprd11.prod.outlook.com (2603:10b6:8:34d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 05:10:52 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::41fa:d12d:31c1:d5db]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::41fa:d12d:31c1:d5db%6]) with mapi id 15.21.0339.010; Sun, 23 Aug 2026
 05:10:52 +0000
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
Thread-Index: AQHdL8/tiO9knU7kREqpjtsF7UOa8LarGafggAABhbA=
Date: Sun, 23 Aug 2026 05:10:52 +0000
Message-ID: <SJ0PR11MB58963CA2B53ABA6D1E89A0B1C3A12@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20260819114242.3598034-1-lilinmao@kylinos.cn>
 <20260819114242.3598034-2-lilinmao@kylinos.cn>
 <SJ0PR11MB5896AC03937115745995EFDFC3A12@SJ0PR11MB5896.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5896AC03937115745995EFDFC3A12@SJ0PR11MB5896.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DSVPR11MB9743:EE_
x-ms-office365-filtering-correlation-id: 8c607b40-7a1f-4f20-a9bb-08df00d4e76e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|22082099003|18002099003|5023799004|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 2i++PAJsmMtBYEKP3ZXzAhoFsqSycnOsgh5oAMKVLPzoBHuZ+snay+yT/WZfuTTrKfva++qEY35zpfjC+LFPos3lAkchs21TPWJ4CRZqCjffwWKZfrRXBJAk0U+6oSMgboiQ745LIMMRipzCIzpjQypI6H0qAyII2tEUm3Ovwe/jDzW+OLur8iSb7srJQjPWijepUy/+DZx8bxC7Hh91GDWaWO0IsaWSucDBAV34QXpc26Iaybc/6TSuwJF1+7QMox27tWX97jM47dEcH0eQwkR6rrcnZr5bc0qmxQWZ/e4cyaO6yPLbYOkR/jHg7PFJ2bjdOtmKkVSc/8H9ClINObLc7y7Dytpp2oCLILkdNndSBsxVjIEgpyH5jLJoeSHuufuNp73WI2KSpJAL99nZ6Hdji/R5kSRYNaxfCWyGhnrDNTtryFd2Z3fNMfZpE6X5GhrngZFiE1ozoU6wfpIgDK5pHA33gg270Iu24YnR58T0ya6bqju0jDzlNDX2v0XhwUWSdCQbs35rPOCTQZgEoyT1Yh169XgsXpC1tEN924G/3njMqNLWDgb6KjgopGSx382Jf1gRqFSfJu1Tsk4mUID4rAB+WOxKAdG0OSz3g/w8Hb4rL5AfwYrWCR5SBq9A+CGzwMpIePb+5c1mXEWnLV/AI8g9qfTWC4pdweEc/zilS1Xh7jaGAcJRlS5zS6ZjKJqZeOlOLWIVVpHYBcJH0o9LZ75Qobm5aY7Ob7MejHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YNdgxi5E/Dego7FxkTFeMD99xBJLbHsQGRImKTZwwIkimkE7Byq+tgIwY86b?=
 =?us-ascii?Q?OPRO5Qu2vg/LU9Nms/yTIGbn2IFllDPbsHHWIP7ZjxwXzmIJHs5Rhl9CrgiV?=
 =?us-ascii?Q?MB7ApUozokP8CSKnlthv8aoGpcvwT89ncFiN4j210DzV4DG2IggN4f8vCbkN?=
 =?us-ascii?Q?SYaJYrgoE6VpT3UXBotXJ14pvD3aWOnT9GLj1fZ+JaVr0TbxHLZSwe9H8GeY?=
 =?us-ascii?Q?YyDVattoz1fM/58xVr914/j9y5sepdm/SwUOh8CZTfSmIpM656dmVF+beFRY?=
 =?us-ascii?Q?TY2tiLM6HNC1ox1aTEfXcnurtWLl7qFk8hs2RvFwTPMwV6/Wot4lO6Gb/d/M?=
 =?us-ascii?Q?YPto986zeBd/eLyDC8spoFxeh9RcIJbymmiUEPADpDxIcYaLv3BJipSsUgX7?=
 =?us-ascii?Q?qGIatc7Fxx4zwfltbAgSCkxXR+IkCmPsv6c0BayE8TCDD3SvyAusWltI0olC?=
 =?us-ascii?Q?Ik6J0BrDIQIWsl8rwzeM22i8pk19ElyTC1EcTB+MH1mpOVswKb9f45CmZRWU?=
 =?us-ascii?Q?PP5ldnonpmDazz3JS8qD0mVBV9uJOOlB4PxlMetPWk2YRAUvknI5MAryFWcw?=
 =?us-ascii?Q?jg7UiVwIF4WPId8LehaVdCobDMrwQlxqvTYhGNMjMH6J6RRHNLlSrcr06OuA?=
 =?us-ascii?Q?lhcA5UqkQaHtTkgrNODAhi0VQxOBsY2A+mWUhyE8znRAjSLLVBhTAwzui8RG?=
 =?us-ascii?Q?oUL42ksdsoOJdfYAdVouvcqMb2NNoenCseuTZHG1pt0MyRXWwheIJZ+TqEsa?=
 =?us-ascii?Q?u2rLpin6WjsAqFJ+fjoTPOcpeZJDjSZssGoV2TAaj2DoZNQ82a+kovtwYaXc?=
 =?us-ascii?Q?wCH8YjSbBd1Urp1kSES+7fOj3N0Szv7OJQBA5qopaujq85tAr2pKOCSArRym?=
 =?us-ascii?Q?3pC1JlT8SaECCjVqeBqulKvmok8/MamJM4EBal6hjjx1zK5BOsM7GUx57Uje?=
 =?us-ascii?Q?oT7Za6VdMyaiOqSJlIUh1mgzYKrK6eQeFen84lFQVJ8lLkTU0iHC7t5nZibo?=
 =?us-ascii?Q?AfLrOrYHQBs07OsOl+k75eOz059FqNSSNImOxiMwhOGk4M714fq8Ymxekzov?=
 =?us-ascii?Q?UwJA/tTkchPz2pIdvsunFIL7XiKgE1d1CoFXajqcNC+mNE7yhWbadmtRZ6CC?=
 =?us-ascii?Q?uu9IpeZy76K3x48PoeQWRZHYrF/Jy0uCyy+gjmb0j16MJyLWKBjGrJpjhIcb?=
 =?us-ascii?Q?fHNZqHqx3a7UVZJEmy2Cw6ehHB3M4T/7ieQtwipW1XnC3C6+zmjCA8Zd3gSc?=
 =?us-ascii?Q?yCmPS5x2zpWv+hN8ju/n3EsPaWyL04XfZaEN7K1hdcB1HjiWA3WMfBbkOuYU?=
 =?us-ascii?Q?JxPiUtPADWxqJeMinY15BqVJYkv7608WuXsfIhjJ0fgqfbrj5BIT4aYyEox3?=
 =?us-ascii?Q?0Gzv+DytmiGss0Hram+DxxLE4oKkRgs6jisWpETT3vw64I+ha+AdFwK/yhCy?=
 =?us-ascii?Q?z9bPDvGnlsULNTwP9ftyNdiyhGaAptDLYIkNLe/oug5xaxwafQZNk0is1OWn?=
 =?us-ascii?Q?OAI2aK/j9DeL4jzxk1X0gIGajYUN4XKHY5llh3Gofpf4vfiNGUzfulmb5ZTO?=
 =?us-ascii?Q?h78Eb1KTYKS5YKqltUkkZQjQJcIIDqx/vbnIQjWSVrMS7BEsqN0eapMbY756?=
 =?us-ascii?Q?HhbqAlbQ2xDyASD69ZbOnZZ+5LZPJ2MVfTezws4vZucmhrzNBAgAue4bUkmg?=
 =?us-ascii?Q?SIe6ylzZSFWyPIoupNqSErHD8H52dsg4W8N0xxJxdB0nwXnV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lUXWKb+RvyDkKu/DtFC+pA3iEgS8vbZYAnru2/lqLZBoMm6v7ciNuXCuiUpKmnnZ1RF/luSD8vi5dX+j6ujeDRvco2LbFNeaAJSej6sI+/Z85H6MrySJAmjG/g5rV9PGKc5/xrzsKAkP4w+5z+krs2yYnYIBxPRWVcEt5cBc4u/dWAhD2kvtVHgPD480mIRlHpPTrvr9y1hZ+XNRno86t8vIGqwOvgSw+QO/ISKRKmGN/v4ETCPrBfNzhLyrvsnhAUOuPGpdoSzgxrsLeCLjYu/K8B+03Z5h0/AFbsIvMomvpesVpoHGqYv6SnvZKAeY0yWq1w4cykgQWn0ZcTSjoA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c607b40-7a1f-4f20-a9bb-08df00d4e76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2026 05:10:52.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glfarMI2t4+TYtFpybQl7kLXspr1P8THTMElUL3Tbzmy0GgzDax67aAa8CLw5rApReGgrjFSjP5tTxB/3Ah38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9743
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-4.cisco.com [173.37.147.252];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_221058_368798_828B7653 
X-CRM114-Status: GOOD (  22.88  )
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

On Sunday, August 23, 2026 10:35 AM, Karan Tilak Kumar (kartilak) wrote:
>
> On Wednesday, August 19, 2026 5:13 PM, Linmao Li <lilinmao@kylinos.cn> wr=
ote:
> >
> > nvfnic_add_lport() declares struct nvme_fc_port_info on the stack and
> > fills in four of its five members, leaving dev_loss_tmo holding whateve=
r
> > the stack happened to contain before the call.  The structure is then
> > handed to nvme_fc_register_localport().
> >
> > nvfnic_add_tport(), which registers the remote port a few lines further
> > down, memsets its own struct nvme_fc_port_info first, so only the local
> > port path passes uninitialized data across the transport interface.
> >
> > The NVMe/FC transport documents dev_loss_tmo as "Used only on a
> > remoteport" and does not read it in nvme_fc_register_localport(), so
> > there is no behavioural change today.  Initialize the structure anyway:
> > the driver must not depend on which members the transport happens to
> > consume, and any member added to struct nvme_fc_port_info later would
> > silently start out as stack garbage.
> >
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > ---
> > drivers/scsi/fnic/fnic_nvme.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/fnic/fnic_nvme.c b/drivers/scsi/fnic/fnic_nvm=
e.c
> > index b237948dcafdc..00d9d5d439a38 100644
> > --- a/drivers/scsi/fnic/fnic_nvme.c
> > +++ b/drivers/scsi/fnic/fnic_nvme.c
> > @@ -2216,7 +2216,7 @@ int nvfnic_add_tport(struct fnic *fnic, struct fn=
ic_tport_s *tport,
> >
> > int nvfnic_add_lport(struct fnic *fnic)
> > {
> > -     struct nvme_fc_port_info pinfo;
> > +     struct nvme_fc_port_info pinfo =3D {};
> > struct fnic_iport_s *iport =3D &fnic->iport;
> > int ret =3D 0;
> >
> > --
> > 2.25.1
> >
> >
>
> Thanks for the change, Linmao.
> It seems simple and straightforward.
> I'll bundle it up with the other change in our internal testing and get b=
ack to you.
>
> Regards,
> Karan
>

Just realized that you've requested to drop patch 2/2.=20
I'll do a build and load of this change and check that nothing's broken.
I'll get back to you.

Regards,
Karan

