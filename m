Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB01DD65544
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3+dlof2FE7YJNHbEhdbJ2H7QD+BI87RKZfD0j2HwY4=; b=mcy1JDcSKAwYwZDBV9FUlEyCBz
	ppPS+eQu+Qg04OBQNqaOfbz4c+GV6w0jKmFdStVNO6gDj778hvfKu+PniuDSaWmPNdXoT9vkMeYDw
	VPZRv6XkflrcrV1Of6cG61cVDWTYvcXQvZZFotlcT+R6acMz3pnSOYADgJTULGHNEdjP+PE46q55y
	ypCTKUCSoLy2XsTiLBtWttYeuMx0LOEyz9mCkBRjVJ7bvtKpux+zKs5q9coJSTXmYV9cLIYYogLex
	KAlibnTrE4MU+lhQY0YAvS1JrDBVAmgJZ6FcWopT7sqoGgLQv5rXBJPuc+9hAN+hF2VvmviRNjYNg
	j5HrThAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tG041-0000000BP8d-0shE;
	Tue, 26 Nov 2024 18:13:29 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tG03y-0000000BP7d-2Jvd
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 18:13:27 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDLeGJ023288;
	Tue, 26 Nov 2024 18:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v3+dlof2FE7YJNHbEhdbJ2H7QD+BI87RKZfD0j2HwY4=; b=
	EXSfXhJmSJKJEXt2HQVI9YiA+piAyCestnTox9rKvIxDpVdzIPz5z5dJDWaJl1sm
	xqLnegMibTEjB7a8pr62HUUw1qB2zoUSRLk4mW3BcEazsau1LGS54h7ybXBocGpr
	C/iNYPbPwYUmMBNXjVSruMKtFVH9cldPgu8eYya/udDVLFOZKBL+LxDEdqSoyqyW
	VUPaKM3a1a/lxB+52cnETAdNYcsyAk0MKpjgSZz13Z84Kdal8d05SpvHYAujOcxr
	p+6UpOuO1DmXjpfS/7gluw7xEgARqM9iryNVC9mXeZzAe3aAMEcSnvPMPiFrqFc8
	7GMzkH295jpvo04mnjaLZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433838p7bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 18:13:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQIAm9i009887;
	Tue, 26 Nov 2024 18:13:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g9hjbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 18:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEsDwJXXA03yNfsKveV/FNl9+Q2gRwbCiXZGYipehqxRldYUeGUdGrqaPbuEM84OegYCdHcY69uIxLvzNdf8Ix+d4tbLq5soBdJFIIHpmAMoohNRBpIlSPi4+tADJswUox2IQqXRGOp8iB9q+nwDVa9+JOQTnEAWNTxyc2CZzUITo/FCjGxpRuUq5IkLAmQ4xziZncDJlaKcHUUAke/3E7wE8E+mE2ydPP3yxec3CF+VDTU1wDpM1PEfhs4+BJJ2EF5FDbqn+3Bq/sDQ4EGb2IFC3KB2qMzVaRrMPVIku4s/wKXZbQ0L5RdTKaRuLos7VNbglAsKlN8nlH4WT/mChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3+dlof2FE7YJNHbEhdbJ2H7QD+BI87RKZfD0j2HwY4=;
 b=yr9+yxAbTg4boqLvByTPVM6HqThZcsI3Tzc1LR6AZuuwrwurBKnYWL2TR6mNc9BN+rVr/+aDfWhWaY4Ua2YBkdJkkIQKKmeWEa9shmps2k54RMVwOmnhn+VEpvTXDEELR+B7VLYXUAfP9MZ1pj3eT14j+8adRcNvH6eFglA2TkCNBIRdHtB9iXldYopRLmd+ctXBWnWg2IBC2gOL6FXfL0QR4JVtCIpE3h7ugL4Ul6jEwKw/em/NR/cBGRp/R7cXFIc6nDDt31pgpSooTswYU3jM4ewIrwiJffjttNHDo9q9nsgwGdFgtzAiJM4LBeu+Y0ijh8kAGI3anef5af5NmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3+dlof2FE7YJNHbEhdbJ2H7QD+BI87RKZfD0j2HwY4=;
 b=OwDNSwMlWYlVrjaLIRqKLavts+kIu6FijxO9TEQ8kSvOUqoSyAc7Ph8eXYRIN7lMxGwpqhc1NOoXjjRdhH6mLBCqMhtca9pHGb/xuMgE/opH+shiHs2a1L3vxFAQqlcTEd+JR9kMHXjR/TehnbkRDZYpVz9ZVRujIuKQxDr+rZ4=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Tue, 26 Nov 2024 18:13:14 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 18:13:14 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Paul Webb <paul.x.webb@oracle.com>,
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
Thread-Index: AQHbO5QQcHjoRAVwOUOCdWnBaPnbU7LA2Y0AgAAWUACAAKqmAIAAN3YAgABpoQCAAP0BAIAAVT+AgAATHYCAAC1mAIAEihoAgACvVoCAANzGAIAAAOgAgAABB4A=
Date: Tue, 26 Nov 2024 18:13:14 +0000
Message-ID: <305F70EF-8061-4767-B6B3-9207F1B4AF62@oracle.com>
References: <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
 <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
 <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
 <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
 <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
 <20241126045557.GA31032@lst.de>
 <D00AC7C8-8371-4629-BA39-E0BFB9975195@oracle.com>
 <20241126180922.GA18892@lst.de>
In-Reply-To: <20241126180922.GA18892@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|DM4PR10MB5989:EE_
x-ms-office365-filtering-correlation-id: e0cb23a1-d2ec-4a36-014f-08dd0e45fecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MUhNeDlGVXdlVThUd1dyaDBnVFRXdEdwRWdYRm01YVA1U3NvTjNDK1VzcERZ?=
 =?utf-8?B?bmVsL21yeGpqekRRUWNuQlA2anJ2VlFPYkpaa0ZndUFHWU9CM2JmUHBhMmxh?=
 =?utf-8?B?b25yWFE2VVZwa284VzlhMmJ0c3ZtTm5udDhZZUN6a3BwN2tuSW44aHZjRjBq?=
 =?utf-8?B?ZE5zRVhCZWgxbzBhQW5NOTJsZ2J1RHltWjFOOWVoQk9BYTBXU1VGRXRzUFd1?=
 =?utf-8?B?ZzlGOUtDUkVLS1FJb3RtSUwvejMwVUtyM3FPWThKbnVIYTJUZEVrNEhWcU02?=
 =?utf-8?B?MHZobUt4U2dPSnBzU2dza2VEWGQwU1lxam1jbnlXSng4YXNGR3liY2FKTGhy?=
 =?utf-8?B?YVRBQ0kyVnloQnA0QmxZNUU2TXFRU29sNWltWStzSTJDdHJiK1dJYWJxb25z?=
 =?utf-8?B?WlBQY2tZQXE4cVl4NkpZamtsZkRiY3NQNktrSm95QStHUDlFRkFUME9jUFNM?=
 =?utf-8?B?OUVCbHl5dFc4RnZ4RWU2ZXFFMkpZbC8yWnhkS1BpU3RjSGVleElFNDRDU3VT?=
 =?utf-8?B?b2loTUJ3Ym1kaGt5OXZWTFJ4SkpjSnM0cEhLWTVTSlg0QTlMSVhPZ2dRdUNP?=
 =?utf-8?B?dmI0TFVmakE5U2F4UFB4TEF3Zml4czQwOXJ1c2Z3VGYza1V5M3MxZ21iQWw3?=
 =?utf-8?B?MjcxNW1aa2xoK2VTT3NSb0tPcjJsTmFjWW93U2JvNkl3bFZlcGpnOUtUVmR3?=
 =?utf-8?B?enJIUmppZDZra2tXZTRDazVlSU5WdkZDSWhCQm03K0orODhUT3R0aDJ5aTJ4?=
 =?utf-8?B?c1lyOHl4cHpuY2wrSW41cUNGeHBjcDNOZW9lMGxQdzFuL2c0YkxPMkh6Qy9N?=
 =?utf-8?B?Zzl6MXRqQnM1cEx6VHZGV1BNcFhzeVRsU2tlMENRRUIwaTdTeHZFWndhaGJl?=
 =?utf-8?B?RVlXRG1LNndKZTI0S3hhOUJRbjZNMk5JOG9pL09mNHAxWVRoUGZtUVRPY1dv?=
 =?utf-8?B?Q1hLUjBCdnlLMTNkSUhBMUh3YU4yUVJLTHpiR3pDcWY0bmZsOUlHY3hXRWcx?=
 =?utf-8?B?dGgxdkJObVYxaUYrZ3hVM1NWMXRLb0FUZS9US1VROG5SbUlTRUhULzZGL2Nt?=
 =?utf-8?B?MFdJU0hhemQxSDlIUkRrTERVOENVUWV4RmNuWmV3cVd6SmNrc04ydDdvS0Vz?=
 =?utf-8?B?NDVYcmo0b0lvUVZ0MktwdnFHdUJSbDN4Yy83V2NnUzZXOHQvVTBhb2RaeWFk?=
 =?utf-8?B?bDB2U3hZVWh2S1ZCTWFnV3VHM0lQM1VuWklScUNFdTZycW9jQmxRNFp2Mlpv?=
 =?utf-8?B?dUF6aVJVYUxqVWlzaUF0UkUrdE9pOWk2V2RRTDBrckwyYncrUEdtUmg3Z0JP?=
 =?utf-8?B?OGZabmxBVk12RXJhb0NMKzk2TC9MbkJ2LzZRSHdIc01QNGxkTVc4Y0JkcDg4?=
 =?utf-8?B?RndpQVdLWWR3b0JlYjcrMkNoSGc5OFd2Um14a3p5OE1Ta3FHWDFXOWVYZUli?=
 =?utf-8?B?amVOeGlPb2VmVzh0bE5CNFcxME8wYXFINmtXVXVOWVFIdEx3THZRMCs4K2lr?=
 =?utf-8?B?Zk1aMlFDWnN4ZzBJSDlrbUxiU3Y4Vkd1dnBWSE56YmpQRk94NCtXNFY0dStp?=
 =?utf-8?B?VVpMRXl6STI1VWlDQ0l5K3FMVlhjaEZNUXdzWXd0alhLdCtsS1Fjbmw2bXE5?=
 =?utf-8?B?NklFU1NqL0FyL2JCNmRqSzR6ZHorU3ZzL3c5anp6WUJFVlZnbWkxZnhmVmFr?=
 =?utf-8?B?RVdJMzRQNkYrdHdIRm1mRlg4OTZoRHB5cndHUjErTlV5VW9KdCtTMGpLS2pj?=
 =?utf-8?B?OTFHaVFpYk81SDhIaWsyYlBOTmxGK3haaFB2RnVmeHBJaXFtVkhEZGFFVjlH?=
 =?utf-8?B?clJmU1dmdDQ5S1pMRC83ajdGb0VUK1JSZGs3dm9sOFFoei9zcC9IQjc3U3Bh?=
 =?utf-8?B?LzVTdXpRTkJJcmdhNHIzTG14Z28yVE80TmNubXBqUkF3eFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUZETzBZblhuUk5YaGIvY2tkWThlNzQ3TzU1NzVBL1NMOXFyS3Vtc3FLM2pJ?=
 =?utf-8?B?MmI1UzVoQVp5bFc0cnVMeTFKYWQrUHp3aFJBcUpPN1JKYkhpMVBwY0s1aGxX?=
 =?utf-8?B?blMyQWRtTnpkb0hvdUxwdFplSzhOby9hOTB6cFVjL2U3UUNMRVZ6YmdwRlpj?=
 =?utf-8?B?cGNIemZadDljQ2pndWpuSFUwc1JQRVNpSEdSbFVZeE84V2hlWVdCb0o5UDdk?=
 =?utf-8?B?S2tpNEZyU3FpblNlQTU5cEhxUWY0NU1Dam1ZQTlkTkNaYjZLdWJuc3cxMU44?=
 =?utf-8?B?em5kcitQaUNvWTN2MjgreUpCcmFXSXhYMHd5L2hHazllbjlUWUdjKzBaSFVD?=
 =?utf-8?B?N0ZNSEt1d3c4aUx1MkdjakZOMUJmWW5RK00yVmtlYkowQ3dtYk8vTEhBM2x3?=
 =?utf-8?B?dyt6UjlzSW4ybThvTVhoQS91dmF2bEhhMUhZSlhOSjNmVk1PVzdnekkveVRx?=
 =?utf-8?B?cUw5YVdrUXg4R285akRoVW5aamVjbno2MGJXNHhrckxPSi9PVDR2alFOQ0ZB?=
 =?utf-8?B?VE50QlZ1NEJLcS9INE1EZlEwdHpTYXN5eXZ1NVhBdVl6bW4yZS95cVNXZlZX?=
 =?utf-8?B?YVlhK2RySXEvTTM2SjVjL0ZYeVdOVGtzbXQzZDE0eFd1VWdpZ3BRU1lpRS9q?=
 =?utf-8?B?R2RtOFZLN0lyVUZOUlc5OFlENGY3WlA5OTd6bzBVSHY1MStwTW5KSHprbjU4?=
 =?utf-8?B?bmprL3Y1ZTZJMVJRdUlPTEEwR0Vka3pvYUk5QnIrdkVLc21IT0d6bzAxa0J0?=
 =?utf-8?B?ZHQ2cUlYNjNlVVFpM0VEMjBqb1oyNTkvd1dKcWhSZys0UjVIREsrVmxtVS91?=
 =?utf-8?B?TWhXKzVQSytQOEtQZkZaYTZjbFVlWW9aYlNtckJ6bGkvYXdodWRoVVYzSXJE?=
 =?utf-8?B?ODN2SFZESmlVd2c0eFRrN0Qrd2lpQUNyb0dHN0dROE1YY25FbVhlN3hrQ3hO?=
 =?utf-8?B?cHFYNlBId2lLaEN6VmxkeEZLbDYybEdlU0Q2TS9WWUQralArc0ZWSHBrcDhB?=
 =?utf-8?B?T1Bvd0ppQXVlL1lVc0NXd1NxdjIzOHgyVm53WHUvSnFuVmxiNm1GQnppblRF?=
 =?utf-8?B?RmVFWmxkTDFOZkV1VGZsZ1Zlbis4TEdWblhtY1lxUTN0eEEraFR3OHFibzkv?=
 =?utf-8?B?MkhRQUUrZk50eENhV1c3cVVEZnQ3VnRDSEtpaFNyRFd4dkJyQm1PN29wV2kz?=
 =?utf-8?B?WVh3azBvRHY0TDJ3L0hWaU1rRjVYMFZEYklBL0lWekZyV3RLOFBHL0pOMmtD?=
 =?utf-8?B?blVNdFd0ZWNBV3BJbFBjcDZQMmViSEdZMENRZmd6KysreHFvNmNiMU83YUpF?=
 =?utf-8?B?VW8vQkdNY3M0clNrMSt2TThVbFZmbUl0VDI0TndNdXI0Vit6RkN4VnhRb1M1?=
 =?utf-8?B?RjlJaGN1R3V2Sjd1VUwySkUxN1FxeW5PRVV5cW5mYUlvZXZjVVY0dXZiY3VJ?=
 =?utf-8?B?Yi9idms5Wk1jY080cUVqYTdZQitaS3ozOUtpQnloZFBDT3VqaXlsQURKVXor?=
 =?utf-8?B?U01mbTlOUndnb24xd0Z6Nmc0QmliL1JmS2xVQWRlYkpBUjBUN2JvYVZNSVRX?=
 =?utf-8?B?aURQeSttTTBHVzducWdmNERDSzJpNjJjUTRaUjUxdzltOXEzckl6RWVQZS9j?=
 =?utf-8?B?Q3Mrajk5QnZqRVlENVBVM3dzVy9tTStJRE5SUzMyTHVQWjRWZjRPWnVJckJW?=
 =?utf-8?B?OUc5dTJPZEpJSzkvSlVCUGJsa1JiK3plNTByM1ZUb3VXSmd0MGIrNWRleUd5?=
 =?utf-8?B?TkRlcjJLbnRqOEl0a2Y5c3lTWENnN3dsSzBSeTBkM2R4WnNYamJlQVE3VFd0?=
 =?utf-8?B?cm80TTFLY3VuRmsvRk1xSjhlZnMwdXY3MjdNditQQUJBL3VMUzI1c2J4Z2cy?=
 =?utf-8?B?OE9VMVB5SWg2MEd3ekxERm03ckR5SmJ3NEtSZXpIeHVHT3d5LytGZm5MQjlk?=
 =?utf-8?B?ZkRjS3BKV3J2YnNQMHo0NDA1dS96eG80RXowM2lVK0ZxYjZMcGdHeC9BTjU2?=
 =?utf-8?B?UTdkd0s3S1padXh6a2RCa29Ha3NiQW0zTmJjQjFtbFUwb2o0TC9tTXdwZFpj?=
 =?utf-8?B?K0RVb3A3RDdqcXB0UmplR21Eb1dxMExyMXd2STNXYzBCUWdtRnRsTnZJbjJw?=
 =?utf-8?B?MXo3VmR0MVBZSnlXZ2xIbXU5VkNtb1BqV0d4TlNhWGZ6TnVjK3Rnbk44Zytt?=
 =?utf-8?Q?MLSIwOgo8vd/bmze+Dk0Wlc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BACCC2E6126C2458EE64F0ED68847A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: htcnpKaRjjv1BY0GJsSNiy1RnExVcO6UsR2xPZqckD0+4hsWBMqS+71uctXNDSJoTroKWzrEeuALh6L2znRCf/HG3oI6QfWpbI0jUYu8ORfhHf1iRxTfam2VoROLLLcWC6lZUZCBkd0/05rfQLGyGf0g0XwSefLsq6Nl1gpvRycTPyh6ACFwuqpA1upzAYo4UzDabHMLC8puhIeHov7SKbU8ptZrFuwcZibAhJIoYhF5GBfAWh/z9/fXJRjUSdFCPnizmJaD5ziTm1Vm0cqTtDxxBGgJkpe49+U201Ok2eZv4vDnMXTYFPdrUyJkzwkXuWmk7xTA5h7fjtcmbRaRilkVDDUDBrbNF5xdXk3jTSHDk9vWnLgYtD7Ej/HlA0ewwpdvIf0SFuGSj3UpRSIxTQaq2+iOZ2DiTaSnqqe6KBAXRTUFT8G6zGFbjaZkqW25PM0krePY0OSSnjv27J3I5QejxpFXutgBJ5AVzZMp04hhf4/+DmRU4mJQrDzpLrhgdnTyqKuCIGJpxkohjulehGMCElaI0aPQiO3ZKGHDj3AsZnFjWa3KJ1mR/xPW/ZXBET/t9uGhlUYfzqsL8bLNFQLHPS3G2tuaiTXCsOfE9lA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cb23a1-d2ec-4a36-014f-08dd0e45fecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 18:13:14.6739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bPVwelniLwjkTu1j7wW4cV4URj3T5/atYeEx85ARyCMuj0k4bY2jtAwYpY54N8xTR0Zg84qNnHIjwLTIGip72aILf0VW5lTQWcy2OqLjxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260145
X-Proofpoint-ORIG-GUID: DDxoxJPzmVwxCNjN_1R-z1dX6PusoqKC
X-Proofpoint-GUID: DDxoxJPzmVwxCNjN_1R-z1dX6PusoqKC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_101326_596401_BF088CE4 
X-CRM114-Status: GOOD (  15.37  )
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

DQoNCj4gT24gTm92IDI2LCAyMDI0LCBhdCAxMDowOeKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE5vdiAyNiwgMjAyNCBhdCAwNjowNjox
OVBNICswMDAwLCBTYWVlZCBNaXJ6YW1vaGFtbWFkaSB3cm90ZToNCj4+IEkgd2FzIHdhaXRpbmcg
Zm9yIHRoZSByZXN1bHRzIGJ1dCB5ZXMgdGhhdCByZWNvdmVyZWQgdGhlIHJlZ3Jlc3Npb24gYXMg
d2VsbCAoc25pcHBldCBiZWxvdyksIHRoYW5rcyEgSSB0aGluayB0aGF04oCZcyB0aGUgYmVzdCB3
YXkgdG8gZ28gaGVyZS4gU2hvdWxkIEkgbWFrZSBpdCBpbnRvIGEgcGF0Y2ggYW5kIHNlbmQgaXQg
Zm9yIHJldmlldz8NCj4gDQo+IEknbGwgc2VuZCBvdXQgdGhlIGZvcm1hbCBwYXRjaCB0b21vcnJv
dyBtb3JuaW5nLCBuZWVkIHRvIGRvIGEgbGl0dGxlDQo+IG1vcmUgZGlnZ2luZyBmb3IgYSBnb29k
IGRldGFpbGVkIGNvbW1pdCBsb2cgZGVzY3JpYmluZyB3aGF0IHdlbnQNCj4gd3JvbmcgaGVyZS4N
ClN1cmUsIHRoYW5rcyBDaHJpc3RvcGguDQoNCj4gDQoNCg==

