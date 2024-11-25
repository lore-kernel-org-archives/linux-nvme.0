Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A46D58D79
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5kuRxtoH4TbhNGLgS1kx6q3NW6CczR79cFTR4AwMg48=; b=P/8tZmGeymZaDaSoUwwxCQXkl7
	muJJ2SQRtgK38KZlXWXR69ePT0W6+H+pzAlx7aXt/XUPG53h67pYbxmsEvNwKX9e9IqGykQiWLAk8
	4xoZHb0wPULRnM/H/YB0eJcFnz/v0DFT3oh1bcQGACxjtrlT1B00qiufxMR+QyIVZSF3vzo/khqEA
	I4LUo4dam6f8pzL1eVnElJcU4gLuWinn2iZ8QSSlxj5gYWBTCdv7dhkG6Jtb6E/8S33o85/7kS0BN
	KjTHZmS0RigH4cgdS1XYxskeRp2t9ckyeLv/COj7HEAbnhGKdb6aMHxFpolchEJ3mqFNhtdS+3HN7
	Wlp/LKrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFdpI-00000008raF-2yAg;
	Mon, 25 Nov 2024 18:28:48 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFdpG-00000008rZX-1eAS
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 18:28:48 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXVjh011130;
	Mon, 25 Nov 2024 18:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5kuRxtoH4TbhNGLgS1kx6q3NW6CczR79cFTR4AwMg48=; b=
	nXrUK0N/BBGlUGcCniBQP7+S86kHp+9K8Nncp/OUn4X0OvdxNYzMs83IkQBUt91G
	JRNKGPwpP3DhJoEsSvv1xM1izv6yzyiA06H4BCobUQCn5b7rJ4r4jmMzaQUKy9p8
	0OHbQ0BKRXqb0V7V5NvP1H4kaPwkA1/GEH/q/y/KLQLCcU+ygUDliZTfoq3tKMpI
	Ppw9olP5kMz80l7mJRcpoeEABX+owslrCjVnr1rGGQIDA5A7XcrY8W7v/9JmVl1h
	XxTZWyc1blTw3UQR5gjjJVw6/QguOAvGOzxXsZjqwAuoZns1dzr4ASnFfVECT6I5
	rWz53fLjvAnFp+EgKTVE6w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433874bu2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 18:28:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHeaPt023393;
	Mon, 25 Nov 2024 18:28:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7vcpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 18:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYrPEDgBfAHbKwRHmT9LalImSqQZJly0Tt2DqNn/6ZW7QwqYTPfgQDSIcAOkXz+dIsiCuzyDsNWF0dymMTeA3TWWtiJzDr72BL+7kY98GXgkBHeLdTBJBiGgZN6qFsNEGUxLAOX3WF/P5vZyyu4pMPITu3EMiFm3O+ZmI9gS3Qx9/5uj3mbTCEZywuIfwWrNB6c48rMGub8mJOCulid+/D3W/JjynaewkIS36Iwfh8tpwly5yw+L+Q1kpInsiJAk+HiVtN9VXX2Tknl8XBYDmybcNuVWuI+55yPShCt/KAc9ISp6BOcp5yJ4sUqEzYIUuj6P6Rbx0hmnSGebmkpLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kuRxtoH4TbhNGLgS1kx6q3NW6CczR79cFTR4AwMg48=;
 b=StBHbtTyq7sIFYkPJKATd0AoPfeKTdrhmPzzfSKb53DRVKUEDYtqDLLXOBoVRkOoiby/Bnv4kEH/qLDjPyA+VsuSsuap4Y4Dg1cGwvXJ27tvtKgLz3WTXDMXDtfj4Fb0rIOxy/8zQkNLaYhNIUNIdEOEYzk80Fbige46EQJ9rckU+GbK74+OrXF0A23Llk2nQn5vmZn1uLOjuhT6snbU/ZRG2IZRG2w8IAEEFYcyWUQzhng1LPZSerlaUL9rma/tpvYRsKOFJTzjkPldxR+X34mgiA4mYqFO74cFuYUe6AY0Ojyrs3GRG728NJLAvNkXG8ugwDqjWSKun8L31d/72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kuRxtoH4TbhNGLgS1kx6q3NW6CczR79cFTR4AwMg48=;
 b=BJnMgytwBpBVVTM9Nv6+YFnKx5Zovr2G7ERZ1QdvDkhkHiOdoXszy28LmjKSpzhNXvUv66q9jaEXkZbAU/xqdT0Hpa59+fUDU5NYWxLBzp+TTbHOFLhGz6hHnju/Mrpx6lnDIvtDNuSwx1Z0eaP90SUu0rdTDTfzH3Inr4f1uTc=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 18:28:35 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 18:28:35 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
        Jens
 Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
        Chaitanya Kulkarni
	<chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nicky
 Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Thread-Topic: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Thread-Index: AQHbO5QQcHjoRAVwOUOCdWnBaPnbU7LA2Y0AgAAWUACAAKqmAIAAN3YAgABpoQCAAP0BAIAAVT+AgAATHYCAAC1mAIAEihoA
Date: Mon, 25 Nov 2024 18:28:35 +0000
Message-ID: <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
 <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
 <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
 <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 83f41186-cb28-43c1-58ad-08dd0d7ef92d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWhjYVVZTjFhNWRDMDdDWndxczBFQXMvenBIdHllZlhCUFlBR1kyTS9vUnEz?=
 =?utf-8?B?ZVVmQWdVcjN4MVNSWHgyZ0F6QkF4c2lTRlJVYm1MdlpZRDZoakVHZk5XOG5t?=
 =?utf-8?B?VHJsbkxEMW1ySzZqWk5UeUxFeUZvTWVtMWhtTHpJc3FScnp4MXRtTXFtL01R?=
 =?utf-8?B?czNmSVRablJQTmdLMkpVcGIwQTFqcmJEWDBLUGs1eVV3cHNVT0czU3ZpVnYz?=
 =?utf-8?B?anhjUHdlT216WEk3WVhKa1B5TTJaSWQrU0pJMHJNRGZiQlNwZFM1dE9JdXNP?=
 =?utf-8?B?V1NHWmJsSGhZY3lCNHpFQldMR1hKMW9OaXZjN3F2VmxKZnVKb3AxeWhsSkJK?=
 =?utf-8?B?RlgrQ2FNYjdGTmhONk5tbkwwRW1XRVVteGJ0aWlPTllBYW5RNGZwSzN2YUFO?=
 =?utf-8?B?L3hOanpDR3ZnQTRkRXFkZmlGT1E0d3Y0TWdtVFlVSEd5STRqUVFZdmdtTGV1?=
 =?utf-8?B?cWVGWi9uRklOd09XZmk3Q3FTaVJTOVZrMVZyZXppUmtPT2tSMEFWb1djc2Nu?=
 =?utf-8?B?YVpZbXFOOHRWSFZBWDlrNlRKL1NLR3VEN2RoVThGWjR0enJZZjlhQ0NHWmdG?=
 =?utf-8?B?aFJzSlh5VGp1cEJUcUt0ZWRhTDV5QmV0d1BScnQyRllYdXRrY2daNTY1elNC?=
 =?utf-8?B?d2k0YXFmb2V6blhnVjF6bmF5M2RicFAxbkxTZU9YYWRrb3cvMUV3ZEFlYitB?=
 =?utf-8?B?RDZtYTM0MUpmOVQwcnVJbmloRXhhYlBjdG50OFhEQlFRNDJWU24yZDhkWnRo?=
 =?utf-8?B?K1Jzd1dJVWx0UzNGM0EzRGNUeW5GVXN4d3FCNFpNQy9kQlk2ZXZZa3VJMjgw?=
 =?utf-8?B?V2dhRmxOdFJnU0hkRk13N3E0YU1RTUNMYWNmMzF2QjFsaVlKWXZPS2Z5cEZo?=
 =?utf-8?B?TTJaQ2tNNkV0QlVkNWx5MXdqRm9zLzZDTDBkc3JUWjVRRmlnRWEvdk1tNXg4?=
 =?utf-8?B?Q2tVaWJUYW12WFlaa1U0Q1NJbUNkb1RNZGhnYlhwTk1hbFFCd3JIQmNIRXV0?=
 =?utf-8?B?cVhUcVVqcmJ0aXJsaTdrdnlQOTRMWmhpdkx3RTNmY3NsN0xFbE83MVZYR0Nn?=
 =?utf-8?B?aWx3ZzBSekt0M2hSREZYdWlpb2F1VllHQmNmdS9Hdzl3RHNVbFZaY1drNUov?=
 =?utf-8?B?ZFduT3U2TmRYUVZScm96WS9GaEFubU1OQmxiVnljU21nc3hhTFZZVWcyNnM2?=
 =?utf-8?B?ZmFHNVhLcjQzTXhNd2JzaFJvSS9FYzFveHJ6Y2JJQlFkSGs0N2YrRFlZU0xO?=
 =?utf-8?B?ZWRxd2JDNTB0VDBpUU5EMW1iQ3lGdVpkc2VlUkx2b0NqVlhObE5LKzRsM0E4?=
 =?utf-8?B?eUFoSEc3dWptSzhTU294YVZhYmhhb1dOSllCSWMvOEJZb3lPOGdSOFdCbGtv?=
 =?utf-8?B?Tlp1ejgxTXlEN1haRU5JUU1JNnpXNnFvK2E1N1RLVVEwUnd6bEthWWhxWHkw?=
 =?utf-8?B?V1YyYlNOYlhCb1JCY2Y4ZUVMTWVzZG1pU2szQmhrY1EwVHBkYkIvZmpZbTRr?=
 =?utf-8?B?bGRDYnJCTkZpdTBCTXQ3ZGt4ZmpINUlNbzR3OUt1MkoyV3lIeFBsS1pXTHEz?=
 =?utf-8?B?MVVtVHIvR1ZzT0o5dmY3MjFSdTE3L2lHYzBJQmY2dE5TalNrc0ZyTHRsYkl4?=
 =?utf-8?B?NEFERTVMUlpjMnlmbU5UK3crcTJCS2ppSUdvMlpZc29VMzE4a1FJWEM2Zmt4?=
 =?utf-8?B?ZXl3Ukw3dWRhNUxWYTVFbXpzVmJDUSthZW1oczZZY3g1bnZ6QlJPNHFVTURJ?=
 =?utf-8?B?L0hUQ1dCTHpkY2tzZTM0R0JwejNWbTJQN0FBVXhzTG5GbnpTeG9hWk5XVWh2?=
 =?utf-8?B?NFhISndjV3VzNSttL29pWTExKzlzU2VweStlaUNqc2RNdmhmYTZxRU9UdjYx?=
 =?utf-8?B?M0FFblJzbCtaSUJGSDFaVkQvSExZSUpmL1FCUXFZc3RSNEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFgvQnNsbHBwZjdWVUpCQlNNcGNIUHR4RU8wQ0xzWDY2YUFBS3hUZ0xIWTh4?=
 =?utf-8?B?ZWtOU2pUM0FTNDRlc2ZHYy9PYXFndlkzM29WemJTZGt5Wno1cEtWZjM5MXA4?=
 =?utf-8?B?YWttZWYwckw2aUtRWGRUZ0svYkp1ZExQZm1NTnB2REdDQVIzVERvWlBmc3pn?=
 =?utf-8?B?S2JiVDc5c1FPWTlqQUV0TkRScGxWdE5hRE53ckZFWW5ZTUdxZlB4RThxOUgy?=
 =?utf-8?B?MEFQTUVoYmlsN3JqK0c1ZXRqQ3RxQ2QrdHp3ZmJkZG8wNnpuWDgyQUdWSXIz?=
 =?utf-8?B?UTRUTkQwYS9hOW9CcDhiZW5EcXVBV25Dd2JvYUV0dUEzeWVTNCtLU1BOWlk2?=
 =?utf-8?B?bDFxcGFQOXBYUXF0bDEvV1Ryb2kxT2gwdkJmdU5ibTQ0SWJabm0yMjFtSmcy?=
 =?utf-8?B?L0IvaG9SVU1iWmtsaEtCVjNvbHo3dm5ZdnorQXRoQ3BkL3k4VGpvR1RPNmxN?=
 =?utf-8?B?dW9nMkpLSzBFODc0SEhycEZQM0tBVnlqR2NKTXpLL1hTQk85ZGNJcVlYMTEw?=
 =?utf-8?B?dHBjcDRxdmlvK2oxaXpiQloyVHZrWG4zaHRhUlpMSmFpSW03anZNRWNsbnNP?=
 =?utf-8?B?Ly9BdXFTQUlZT1dyVTFJZU85QjdBb0dCUFlKTFNaaHdQNEJjMmx3UE04YURu?=
 =?utf-8?B?WjBEbitaWUxUMDc2Y0xGUW82UWQxMUZycmduaHY2b1FmY0VGS3VOc1BqZVg3?=
 =?utf-8?B?WGpIOXA5VENMN1hyclFkUmJKVHl0bDAyUm5PamJLRlUvMy8xaDJ4ODBxek96?=
 =?utf-8?B?T2tkQmdOTUF5Q3dyU0pEaGx3c3lSRld5Z2ZmUTFrVGVTdU9IWW1WaXZmTTZv?=
 =?utf-8?B?MDhDODB5bjVQOGxOd1RiOTZxUzQ4dGpNenVCOUgrUm1uMmVqUnJnM3RTUzNZ?=
 =?utf-8?B?bmh1YXhtN204WDZoWG9Gajl6MWFyOWNpbXB3aE5hZ2wxMENBamdheXQ1dVd6?=
 =?utf-8?B?bkJ2Y1ptWnNBc3BVaUpoblcwTkl4TkZqRUJhNnJjVVVaTFd6T2FxbVY4R1Vm?=
 =?utf-8?B?M0RyN1dLeXQydnZoQ1RWNklZaUU1MmdjR3hYZC90QUgxWDBIY1VlTlVpSmpi?=
 =?utf-8?B?OEZKOFluLzVaUGFqbThIbFR5cTAwS2VTbXV5MjU3SzBTcDNhN3ozYjhZbW1I?=
 =?utf-8?B?VFBudUNxaDR3bDRaR2lySCs0a2daYllhbFNUWjRmaThheXVua1VEaVZLUkkr?=
 =?utf-8?B?YkJtSFVBVjJiZkZ2Uk1ESnFlZmtrcmsrOTV6ejdRdmkyMXZXV2FzR2l6bUlR?=
 =?utf-8?B?TGhoYk1NWFZweVQzUklXZzMrOVhqQTBzbVpJTDhUMGZZd0dZbHpKRVJhOUxG?=
 =?utf-8?B?NjdLY2Y0cHJXaVMrM1QrV1VrY05MTXllR25rN2FCblM2WGhtSWg5OWRLWVdS?=
 =?utf-8?B?UXZrd2o1N1dZcnFXZzRlYkxIbWFxcG9xMW5UcjRqblprc2pIcjJTZXppZ0kw?=
 =?utf-8?B?MDQ0QmlJNXZoSmd3TnVPOTcvbFFwNW95OUFhNzhkRHByK0tUdG1TcVRtWmhx?=
 =?utf-8?B?cjFkZ1p0T2s5MjNCNUwyWTBOTEs3SFpOOS9HT05PRXAyWC91ekoxSFZLaHJY?=
 =?utf-8?B?VDVneG01MnFLcE12UUg3bHpEck01KzdUcllPR2t5OVB6WXFMNFJtcU9sT3E4?=
 =?utf-8?B?dEMvc1BGUGQyVWR6UFFQeHhLb0dueHpRSUJZTmhXb2w2T2g4TGw1WUowUExT?=
 =?utf-8?B?VEhVb2c5TCtyWlNLbjJadnVNOVBqbUFEbzQ2WmVveCtnOUIzemh3Ym9DVjc5?=
 =?utf-8?B?d1RGR0hnS3pETy82c3FyaklHdmE1L2EzcGl3TFA2R1JWY2dpaGZjblZKVzIx?=
 =?utf-8?B?d1FUeS81UkFNdm81N3BkOEI4dnNtUXdYRDBjUG1HUkUrTk54bDd2VE8xVkRy?=
 =?utf-8?B?bzJYVDVWcm15aG82d2txODByNk5QaFZoazV3TWxIa2FEZ1V1OUVmM01wOGJO?=
 =?utf-8?B?LzNUWmlqV0VleEl4cXRSVWlVeXdZT2hJMEVlcmVsSGNRNWFUMzc2Ny9UQVdh?=
 =?utf-8?B?V2x3alBubnNYMUcwc2pXZlkzeDIrdkZzNVRuZFBsNG9WdHJYMUxOT3dpMVFB?=
 =?utf-8?B?ajhUSk9ESGVva3FrZ2YrcGs3dFdaZzlVbHVhbHhVNUdUSDFVZVNLb2lZelFN?=
 =?utf-8?B?ZjJRdHAvaTNZZDRON29vU3N2NUNsaVhEbS9TQ2dkdTRwNkZkQ2I5Sjhyb0pi?=
 =?utf-8?Q?GLz70HFvBNC+b+EIMdVkjKegjJkny/6GWeMsyNw/XeHP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C32D4113EBA2443B4355AE8E9A1226D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3gNCCPbU47e5AB2L2SHXA8tEq4phz19SYKNPVaIKGPKMFUCS7bLzlvuDUq9WfeAEkMXp9YLIFWAKjArNcxc0+nZLNQNR2pq3N8G1lB+uz/ety9uVpnd1OflSlRRbH4rI+2n8bDu2GAGTUHzlhJJeEokzWBjTv5D4ovwvFueS1ITLNqH2De9BCRj4WP6OUBQN8CvL9/DlKi9s919dkMLP2NAGO7ucBhDRjmlbF9maL2/Bk0xbSYE14eNhKc4EPwyk3i/dnbm42rLgiqoXHeto7jBb2jron38SYjmDF0IVFnpXp8bNFVDSc3xRc4N0kZzxloeg51kcmhxxHtnchSryH3V8owpMMTHmMkFmZymZbikHLZL2KbEvmdQ/mkQ8bkmJUVlzPieSTFoYcsOZOkz4AOmncb5Do4e/X71+xQdQlhSQwcBCi9XbBKB4KuwWXOBz3WqMpq8MNGHUWz4cAWRDpWNcP4QfT00ffbfTXRMrdD51lLufAQ+xXS6hzoO443o9e0KavqjO1aEsWjSBIko6dVPiHZe1ZB1H2XcHv95DDn5Vv0WrlYzpFkTVU6xcnDV7y17EGzmu2+jWaoX992BxVO74ImMk67FwxWSijnKunZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f41186-cb28-43c1-58ad-08dd0d7ef92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 18:28:35.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fG2frxuCHtIJ8Q0nHAVLYIJutQE0tjVqcZc8xfAj9fpj6Ky1pC6OT9+4hoHpawd4z566Un2nd03UUeGCd1ZBZ9/nSKiF1HBDSlLy+8cN4Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_10,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250153
X-Proofpoint-GUID: XTjDAwxTSC3pGjEQ2kfJ37J0t10gVpEw
X-Proofpoint-ORIG-GUID: XTjDAwxTSC3pGjEQ2kfJ37J0t10gVpEw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_102846_557007_6F90E4D6 
X-CRM114-Status: GOOD (  17.06  )
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

DQoNCj4gT24gTm92IDIyLCAyMDI0LCBhdCAxOjA54oCvUE0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE5vdiAyMiwgMjAyNCBhdCAwNjoyNjo0
NlBNICswMDAwLCBTYWVlZCBNaXJ6YW1vaGFtbWFkaSB3cm90ZToNCj4+IEZZSSwgVHJpZWQgZGlz
YWJsaW5nIHdyaXRlIHplcm9zIGJ1dCBzdGlsbCBnZXR0aW5nIHRoZSBzYW1lIGVycm9yczoNCj4+
IFsgMzI2LjA5NzI3NV0gb3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQgZXJyb3IsIGRldiBudm1lMm4x
LCBzZWN0b3IgMTA2MjQgb3AgMHg5OihXUklURV9aRVJPRVMpIGZsYWdzIDB4ODAwIHBoeXNfc2Vn
IDAgcHJpbyBjbGFzcyAwDQo+PiBbIDMzOC40OTYyMTddIG52bWUwbjE6IERhdGFzZXQgTWFuYWdl
bWVudCgweDkpIEAgTEJBIDEwOTI4LCAyNTYgYmxvY2tzLCBJbnZhbGlkIENvbW1hbmQgT3Bjb2Rl
IChzY3QgMHgwIC8gc2MgMHgxKSBETlINCj4+IC4uLiANCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCj4+IGluZGV4
IGQzYmRlMTdjODE4ZDUuLmFkMmNlNjAwODA2MmUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYw0KPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCj4+IEBAIC0z
NDI1LDcgKzM0MjUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZtZV9p
ZF90YWJsZVtdID0gew0KPj4gICAgICAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlS
S19TVFJJUEVfU0laRSB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZNRV9R
VUlSS19ERUFMTE9DQVRFX1pFUk9FUyB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5RTiB8DQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE5WTUVfUVVJUktfQk9HVVNfTklELCB9LA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBOVk1FX1FVSVJLX0JPR1VTX05JRCB8DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMsIH0sDQo+
PiAgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgwYTU1KSwgICAvKiBEZWxsIEV4cHJlc3Mg
Rmxhc2ggUDQ2MDAgKi8NCj4+ICAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJ
UktfU1RSSVBFX1NJWkUgfA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUVf
UVVJUktfREVBTExPQ0FURV9aRVJPRVMsIH0sDQo+IA0KPiBDb3VsZCB5b3UgaW5zdGVhZCB0cnkg
ZGVsZXRpbmcgdGhlIE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMgcXVpcmsNCj4gZm9yIHRo
aXMgZGV2aWNlPyBUaGUgZHJpdmVyIGFwcGFyZW50bHkgdXNlcyB0aGlzIHRvIGFzc3VtZSB5b3Ug
bWVhbnQgdG8NCj4gZG8gYSBEaXNjYXJkLCBidXQgaXQgc291bmRzIGxpa2UgdGhlIGRldmljZSB3
YW50cyBhbiBhY3R1YWwgV3JpdGUgWmVyb2VzDQo+IGNvbW1hbmQgaGVyZS4NCg0KRGVsZXRpbmcg
dGhlIE5WTUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMgcmVjb3ZlcnMgdGhlIHBlcmZvcm1hbmNl
Lg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9wY2kuYw0KaW5kZXggZDNiZGUxN2M4MThkNS4uMDlmNmZjZTJmZWM1NCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2ku
Yw0KQEAgLTM0MjMsNyArMzQyMyw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCBudm1lX2lkX3RhYmxlW10gPSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5W
TUVfUVVJUktfREVBTExPQ0FURV9aRVJPRVMsIH0sDQogICAgICAgIHsgUENJX1ZERVZJQ0UoSU5U
RUwsIDB4MGE1NCksICAgLyogSW50ZWwgUDQ1MDAvUDQ2MDAgKi8NCiAgICAgICAgICAgICAgICAu
ZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX1NUUklQRV9TSVpFIHwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTlZNRV9RVUlSS19ERUFMTE9DQVRFX1pFUk9FUyB8DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5WTUVfUVVJUktfSUdOT1JFX0RFVl9TVUJOUU4gfA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVk1FX1FVSVJLX0JPR1VTX05JRCwgfSwNCiAg
ICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgwYTU1KSwgICAvKiBEZWxsIEV4cHJlc3MgRmxh
c2ggUDQ2MDAgKi8NCg0KDQoNCg0KDQo=

