Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAD7C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qaAdthYGFTjBhAUe6rCL3b5DaVcKDiWEDe9RhUmYuCI=; b=k+9pyTFUJrpPYtShGS+xUY+dh8
	mhrtp3Fvg1xWgLSMYSMrebeUqk2xrtUOP+cdMHadIhuVdbD1MWZU6Yl1mw9dls2xD2ZFg4JuQ0exs
	34Fdq4RgbksmddbAVTR9bk7jhM6QNPbtXP76sotxP3GTgJqDRDYSlKLMxDznYogBWgeTRK3j/2IJg
	aqConjAj/F9Tjx6h5p7bX1me9SEc94qHJ1t80tnpz2ksU56RkshYLXvQyW3LoVaE3ZO3kJgSYDVQn
	b1IG9UARjshMCVNWosQoCyB/Yd+POJwU88gXdaKmyM45P3LHXfXyc0fcTDhh3mFUed5fyIPX50Gf8
	zTSjaoMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueGtO-0000000392U-1DQ3;
	Tue, 22 Jul 2025 17:35:06 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueGtL-0000000391c-3eSL
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 17:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753205703; x=1784741703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qaAdthYGFTjBhAUe6rCL3b5DaVcKDiWEDe9RhUmYuCI=;
  b=ZwOX7+d5734AZD5zo9nDIPl1rI6NSZTCIO7FHNr1dEvw5o1HDG6hp66K
   K0VABStPsF/MXn4unFSSu+Fe7Xd1I8SEx5W8Kq3l3orqf+lmKiDeOBXKM
   ctrl3tp3aMsBLbLm+oha1xsFbIouUK3D3sA2TnyHiIHIw9cugkfamhrnZ
   AtdMWGdW59w8r26L1MDcR71aeyTmwzdDED8ihwtd7L9vExc2pCiziYqRw
   +HkWckPsPZtJzARB8GVXhdvuj0dUZ22Z6XC0PJrox3c+tC84TxuqMKxml
   DcKCBbEsE9Roffn0CoxUXRVKvQnd4veYQBj6zc+yGS1XXlWVOQo2bd/Gf
   g==;
X-CSE-ConnectionGUID: fhw6tsr8RgOFmhGpsIksfQ==
X-CSE-MsgGUID: Bt+9FTb3SnCOD0VpR1TMrA==
X-IronPort-AV: E=Sophos;i="6.16,332,1744041600"; 
   d="scan'208";a="94543390"
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.53])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2025 01:34:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR+hRqJkMLicWrxeqn5OugRp2/Hlq7a1IQ2Tb7gr3ShkL+VqV2PS84F5RX/nmTMXxPUacBtbNL/bPrXf331qNOoZ4eD0puhJw898Z+wlZTv6JleT7rvsxG4gjGo6je8COI1vCH461zBkvYLw7rtwXAFxAkHnWevrPuIruCcD+pZL/ZSCrkC7SDp2P7Kgb814JdCa48ccUkl7rFo+OSfWUtXjbc8cdRcZ8jkBqUgHsiF2EtXL5xwsicDZ0XZQRRsZpvUuSBvFum1Vli5ou4E91SQSkn57LEnpt/0u1YmmYImdLfPo0gpqQ2vNTihBYXHpVSTbr/3T/kg9UpSRbAZK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaAdthYGFTjBhAUe6rCL3b5DaVcKDiWEDe9RhUmYuCI=;
 b=HFCu94MluOXaQja/vWe2yx8pqngFG0uvklCtB27S+hqXCVgQQleRTLh2GU5b+EvdCkK264KOb0OwfY0zJN76XECSmZ33/bs/n2DrLMuKV9dPGOAt8/8WxEgMJtuYt9k4g+FcuNwhGAPL8Tr3pDtaBbGsEcky/g0dVeYuJ+mp9a14IhxGj7RKxlcLT2Brag7DJjyqevxpQXen9BsGQG10vQZ6JkgVvmnFXzHdZvMcAOG+KzYSFMCGhwhqUQaPz5iyXJwy9k4kFUfGXcsf6lwriGlEkRZVKPMKOGd76i2KQh+6jOP58HP9mbGE7MxfrWWXsE+PCQfpQBmlgR2gTNMKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaAdthYGFTjBhAUe6rCL3b5DaVcKDiWEDe9RhUmYuCI=;
 b=xjplKfgnnIiWHsmaJ7BYPqresk38zPAGoUSSlsRw7YRn1Jg4Npdc5CTShq1ucbUhUY2dRX84qp8eMgvt1yM1gIKHarTPU6L64S8sNI0xwXySpYZ+Glz5NNSFG+CVFh6tpgst3l44sAwPH6xwDJQAQGRlAG3cCgigrTiwtpX/8J8=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CH7PR04MB9644.namprd04.prod.outlook.com (2603:10b6:610:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:34:56 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:34:56 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "cassel@kernel.org" <cassel@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
Thread-Topic: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
Thread-Index: AQHb93jsk1kwbVcJmEiy6h+WN4wmDrQ9vz6AgACoKMY=
Date: Tue, 22 Jul 2025 17:34:56 +0000
Message-ID: <BY5PR04MB6849799468BC4F5118343015BC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
 <845e9caa-093c-466b-9a9b-905359517568@suse.de>
In-Reply-To: <845e9caa-093c-466b-9a9b-905359517568@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CH7PR04MB9644:EE_
x-ms-office365-filtering-correlation-id: 984f6cbd-847e-46a0-c716-08ddc9461328
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LYvGClE2fj/du53lXW8kmfwouAqnkz2UT5cM0yePiXA79nE0mZzli4cHu1?=
 =?iso-8859-1?Q?ApBjd/nIlJsNCE3oj8S0zYBUpAle5CHKh27CDI/hQA+qxwYK+1QGiwQIwt?=
 =?iso-8859-1?Q?kfyiVierUaXARyT0EwCovmlNwXytWAcZXUJJxTjAIwfwKr5e8z/+cddqnN?=
 =?iso-8859-1?Q?T0kkVD6cf5jYjtCIo2kOQNdgKerfXCY6aGr0yrImByET4v4EveplpKkR21?=
 =?iso-8859-1?Q?snb9OekyKnZv/yP3Rtji8ckgrPkXhIOtQWqOvOGwKaZVYORKuPqCGl/WF2?=
 =?iso-8859-1?Q?9X4fSVyOwlqsr+LgGdYIphWIgLWJVZc4bErkxp27dkUtKCzlJBq8D2GuOA?=
 =?iso-8859-1?Q?mtYr2nMFoGuXyjvUg1AR1VTvYIt+UqN/WqzLDeVfaH9LjORyHYq1k8vcRe?=
 =?iso-8859-1?Q?Pl7uFMF39CJXumLe7EKU+ssnUYwYUR3EVJG6bK3yD4JJBJPE0C8FACg8j3?=
 =?iso-8859-1?Q?5vj34/uyEfxqMXmDHBHL4zYvyMmPTvDzdkwTVLiYvN/CfZbjXO9WtVDBG+?=
 =?iso-8859-1?Q?0GVWQ9Q1H0Ip6+bVXN86qtRUHmnQnaV6hVufE/VgPWFp0qWZF0c4I8I8bR?=
 =?iso-8859-1?Q?8HjuK9mONkGn5UXpLzpxjj0htXzgc28Q7Q+Iot4N76oTY6mOqJIHpxAmQF?=
 =?iso-8859-1?Q?5ToK51eZwhgY3THfOC2T8vNS+jn4R6oMT8a6L/CVMLDsi6jCT7fSZep8se?=
 =?iso-8859-1?Q?QHGJghuxk5+kSN4PXMvUEiG3yKrcRbKEzGdBD560IRwKw9PiJtmRZbSFwz?=
 =?iso-8859-1?Q?kT33pP5kamJiLnGAkNHOJLwBB0+vn2Zkr2OzbayaCPlIATf2RwzwWx+oHH?=
 =?iso-8859-1?Q?A+ap1B1n2JUvHO7zkA8Y4QB/DNWiOzdAXpwnEZhZ0GzvPS5fNubZ/89y/v?=
 =?iso-8859-1?Q?9fjNIF/3cPX1FJjFqp5YNUcbSeFVbwmQZ9l+5FS8gk9m+PTdZ6RQa9OnTD?=
 =?iso-8859-1?Q?rarhu3CU038d/n+Rb8MxX6s3mVAgAeE4tmMI8ZtyGc50RcXQicD2Wisc78?=
 =?iso-8859-1?Q?6W430pSW84F/4xSrRUo3JwM97TYtSmQoXP2f1hsNwNZnU9sjFP+CMFwi4u?=
 =?iso-8859-1?Q?Udq9y1JIH90PFXeR0tEdL4/Wl3jB62LtbIzNUIXLdDMEJ+IAaU7yLMJJZ5?=
 =?iso-8859-1?Q?AJhd08QU5gv5sV3r2AlYJPWZcVJxBuo7tMhQsHab70s+ETvcTv0jjvm8Qs?=
 =?iso-8859-1?Q?1VKtN8c8ZuYNX4O/zNOdiWGBceSAA2FDB1B/hpSQ2IOZH4LrsxiKPGYP24?=
 =?iso-8859-1?Q?wi5MXCAfgjmsOCSW9yKQWcMs20MD5j/4vNnscLLJmB6Y/wbZIrDZTbENDi?=
 =?iso-8859-1?Q?piCYfsbW3r5JkOKKk2HDKoUCY+gyFpZVIns0VmA/hVExy8zQDuCpploJAt?=
 =?iso-8859-1?Q?8ZnJm7RGui+W1XUmarDHBRrJPeDvz3wq1tnG3B7y6egYLf/5pa9EdCER2o?=
 =?iso-8859-1?Q?jNx2N1Gknxfr6pMZ9POsuORINNDTci8kmFX2eQpcmyL2Be9tN63RiOVNBr?=
 =?iso-8859-1?Q?Oba/h1YKoib9MDcSRjqdr6kcm0rzt+0pzB6XoS+bDSIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?599mn7VSPisexyjN3yWaKLrpQzoOLxAOhrxkkAHUOeqMKjUSqwTIijZgmt?=
 =?iso-8859-1?Q?Cr9hQOlF/NF6JOsnIbmVd1XT75OfQr1/K0pb5gTaLESQr24yvcVSjcGA3+?=
 =?iso-8859-1?Q?ZAFI/C1s5t1jtEr+bsuTZjLJW0DFmvRkJpLcv5OsJZlZ1oLqt2KT4tYLNX?=
 =?iso-8859-1?Q?Lcq6TL+Tcpn2QcKbd7f3/Obzkv1jVIl76r9y21v3SfOvxGk3juxsB3oYdA?=
 =?iso-8859-1?Q?YB6aWQh0XT76xXyDv1Ser2kpEnxzZkKhT4lspERiCzjkdLQ3Aea1feixSM?=
 =?iso-8859-1?Q?GhNKSesNueuLx2BLnjozbW6468a7mUOCUEHpkR84fNjD7K3UfE8Hwia+XU?=
 =?iso-8859-1?Q?avNB0NQhqsdCeri4LY79YD9Q4kxxP9eBdxEyMLSr1xEsPZLqGl6le5wC8v?=
 =?iso-8859-1?Q?rLCRNmL0RCAez+KW3kf69NUmS3Mol1Mc4ORSMj5CWeSPlaUUtgmAm3E5Sv?=
 =?iso-8859-1?Q?dGhuZGhB8G2tdVeJueQZXfbjkxR/+aD77HKe8S0lnoAbtjXFfPNj8JnVZo?=
 =?iso-8859-1?Q?Rx3WpKHRmf7EBMAOMtUD9bCSk4C+29OAnqOJ4AR2CbB/noxrddFaNb2kwz?=
 =?iso-8859-1?Q?pF01wbTWsJSBnyGqw/Y/O+yneU/4xcTsRpUulMkh9rNQ86OOkwNUMg4cFV?=
 =?iso-8859-1?Q?YRUAYkEo4Rfr4slzEu8hDLTsx3Wm2idcfYz/2KoRMZPf0mH7rZqKCoRWbm?=
 =?iso-8859-1?Q?x8mlQM5Qmn9tU1dahO9MIg2FNRTwLfmh2oCrhcnOVxCTNOiKr07CmkHUJ3?=
 =?iso-8859-1?Q?WvAP0959OCTvRYSHiGXbmPaYHlob7c9oZrv1G5VcSr2IGHtDNECPEhNdcw?=
 =?iso-8859-1?Q?TTjsQEu8mIueM+KRIjX7xuE73Smm0ZR2UeSPgz7LsGoS9Br3FvkAsJJ5tu?=
 =?iso-8859-1?Q?FAaK0nzxefXmydt3EfQ72+w/XfVwriNyPJney3ThrUVaGTAkNueoJIQRpp?=
 =?iso-8859-1?Q?tEvaB6drgVMtQ8ftj7Ok2ugi9XjqZD/njSP9Mx0zi+fdD+6wqFSgmBSaw5?=
 =?iso-8859-1?Q?z1xgEnXfbYWeDMdYVyjlz3xXDb9INep5C5hwiQuPMF9AiHEARSHsquCkY2?=
 =?iso-8859-1?Q?K5fng3cO2Gh1hEtDONPowhgribpvEhEFy6rMX1kxRpuvTG1yfzpMO8bLnc?=
 =?iso-8859-1?Q?AvkY8IqmzkReNaxJGq8TjKD3d7gE8vyIww9795IrUKX0yTBPzvdGZvZ/Ct?=
 =?iso-8859-1?Q?dcWu9Wn1svIf7B5FMyBl2pIfk3fk+nIMXbuOx9wrFF7G8SvxYkC/pXg3Sa?=
 =?iso-8859-1?Q?Jkp/hywScHvdP9vIEA4bx31INNCEf0cPmE8AkuGNZSqhqXNREYTz7td34E?=
 =?iso-8859-1?Q?pq0qCXBygijVnWeYdJKfKEFJFxljUN7IsZ1ETbMyxn61ork7/Gk/olUWhy?=
 =?iso-8859-1?Q?f6hqk4vh8LwA8fLws0xIHjY8IYTKKgNqHpGxWEXVtTJeN5g6BpPKolni/a?=
 =?iso-8859-1?Q?cdeo7omJOwGjClktRaw9L4VtoyrjxbNZ54lFv5AGCiBYpk98muQmKBGCWB?=
 =?iso-8859-1?Q?shxCasMHEseQwAqfzYnUBTbJTNLbpcIMDTItDpXmI2ZTgGm5NzPRu5dtz1?=
 =?iso-8859-1?Q?ydzgpHt1eVmHTUZLXQLWSAjrLLw6xaqieUTFzM6OadD69w51ej6GRLBoKl?=
 =?iso-8859-1?Q?EltDaakWHbFDbYrpDM8xMUxoYTb1jebYT8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: INSwSv0Q+bBCR4OJ5c323Pyk5zB10w1HCvJCCQLYfYEeL2lzv/LfMAwyLps2QmzmgNgmwH0VObRRy75pcaigYO8tWv6wYrDJpA0VexT7szuoz4HYfQplSf7zNmxJUVMt7sGg8oEh4id0cdDKOZrVJNvufrNTLqSire5uht56VR3E02mAZEiG3DlhZFiLb9pNT6yv8M1ULT57FDOqNe32BNdOQaj3cbqeSyuGEpM422c11+FZ0eyMQBJwaW80S/NmorzBXPXl7XvapN9JGhnHt9sA/Z7H1Qv1pmCsv9NvJEdAhkp62xGWeleSFDTPEvLrTyMHQok0NfMEarWLvt19m1G+h3XRJ45xoOM6HFkWTaf5rQR7dUiLw16QpJhGa24NpBkyq6Lq5wrbXsMP3YHtf5upuCYucDwj8de61l1v0JA/CiSTUE829bVD2fI+Y2doUvfcQxfuK6+WzHPrCzEUS6fcoMxnZ1VhOdO44gFYtwIa8DIqKDUA2z3tpFULzP5vke+dqoVh5Icb6HX3+EyfMKwtHbf/hysvaVhiibZcshREkWWtXi80ycGosaiKVJhHbcbYZQikN2airgnXakEQF6JgbP0PiRDpxgLIBu+zUedMrjWw48jekTNumHbXRPpK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984f6cbd-847e-46a0-c716-08ddc9461328
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:34:56.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o2oz9pOcY5nybrmqjJT1JybQV35TH8c/tKcLqjI+IVQbvYk8V2kuctL7mAIBg/0AbD75hBbRjFuHG8Wyy6uXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9644
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_103503_955705_5D8CF884 
X-CRM114-Status: GOOD (  16.82  )
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

Hi Hannes,=0A=
=A0=0A=
From: Hannes Reinecke <hare@suse.de>=0A=
Date: Tuesday, July 22, 2025=A0at 00:06=0A=
>> Suggested-by: Niklas Cassel <cassel@kernel.org>=0A=
>>=0A=
>> Add capability to connect to an administrative controller by=0A=
>> preventing ioq creation for admin-controllers.=0A=
>>=0A=
>> * Add helper nvme_admin_ctrl() to check for an administrative controller=
=0A=
>> * Add helper nvme_override_prohibited_io_queues() to override queue_coun=
t=0A=
>> * Call nvme_override_prohibited_io_queues() from nvme_init_ctrl_finish()=
=0A=
>>=A0=A0=A0 so it applies to nvme/tcp and nvme/rdma=0A=
>>=0A=
>> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>=0A=
>> ---=0A=
>>=A0=A0 drivers/nvme/host/core.c | 21 +++++++++++++++++++++=0A=
>>=A0=A0 1 file changed, 21 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
>> index e533d791955d..105127638c31 100644=0A=
>> --- a/drivers/nvme/host/core.c=0A=
>> +++ b/drivers/nvme/host/core.c=0A=
>> @@ -3149,6 +3149,21 @@ static inline bool nvme_discovery_ctrl(struct nvm=
e_ctrl *ctrl)=0A=
>>=A0=A0=A0=A0=A0=A0 return ctrl->opts && ctrl->opts->discovery_nqn;=0A=
>>=A0=A0 }=0A=
>>=0A=
>> +static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 return ctrl->cntrltype =3D=3D NVME_CTRL_ADMIN;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * An admin controller has one admin queue, but no I/O queues.=0A=
>> + * Override queue_count so it only creates an admin queue.=0A=
>> + */=0A=
>> +static inline void nvme_override_prohibited_io_queues(struct nvme_ctrl =
*ctrl)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 if (nvme_admin_ctrl(ctrl))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->queue_count =3D 1;=0A=
>> +}=0A=
>> +=0A=
>>=A0=A0 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct nvme_ctrl *ctrl, struct=
 nvme_id_ctrl *id)=0A=
>>=A0=A0 {=0A=
>> @@ -3670,6 +3685,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl,=
 bool was_suspended)=0A=
>>=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>>=0A=
>> +=A0=A0=A0=A0 if (nvme_admin_ctrl(ctrl))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(ctrl->device,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Subsystem=
 %s is an administrative controller",=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->subs=
ys->subnqn);=0A=
>> +=A0=A0=A0=A0 nvme_override_prohibited_io_queues(ctrl);=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0 ret =3D nvme_configure_apst(ctrl);=0A=
>>=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>=0A=
>One wonders why this is done for admin controllers only; surely=0A=
>discovery controllers also don't support I/O queues, and should=0A=
>therefore have the same setting?=0A=
I agree. That was my patch-3 in v2, which I retracted in v3 based on=0A=
your comment below. Is someone taking that action item to discuss at FMDS?=
=0A=
I haven't attended it in a while.=0A=
=0A=
If everyone agrees, I can add patch-3 back in and create v5 or since v4=0A=
patch-1 was accepted, I can issue a standalone patch just for this change.=
=0A=
Please let me know.=0A=
=0A=
=0A=
=0A=
>From: Hannes Reinecke <hare@suse.de>=0A=
>Date: Thursday, July 3, 2025 at 02:42=0A=
>> Prevent ioq creation for discovery-controllers as the spec prohibits=0A=
>> them, similarly to the administrative controllers.=0A=
>>=0A=
>> Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.=0A=
>>=0A=
>While this might be true, we already deal with discovery controllers=0A=
>just fine, and never had issues with I/O queues being created.=0A=
>Presumably because discovery controllers never exposed I/O queues=0A=
>in the first place.=0A=
>=0A=
>Which also means that admin controllers should work already if they=0A=
>would not expose I/O queues.=0A=
BTW, the reason admin controllers didn't work without my patch is that=0A=
nvme-cli "nvme connect" doesn't allow "--nr-io-queues=3D0" and the default=
=0A=
=3D1 forces the kernel to create an I/O queue, which my patch overrides.=0A=
=0A=
>=0A=
>We _might_ reduce the number of queues to '1' in nvme_set_queue_count(),=
=0A=
>but then we should issue a warning here as this would be a configuration=
=0A=
>error on the target side.=0A=
>=0A=
>'Prohibited' cuts both ways; the host shouldn't ask for it and the=0A=
>controller shouldn't advertise it...=0A=
>=0A=
>Or that's at least my reading. Might be worthwhile clarifying this=0A=
>at FMDS.=0A=
=0A=
Regards,=0A=
Kamaljit=

