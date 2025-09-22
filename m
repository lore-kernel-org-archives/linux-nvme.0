Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5085CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrwDelNOUIFnIyLx4movB705psEmvrSGRlrDoxncUn8=; b=VP3Zak0D+o9mitNqZU1js5igfa
	LinY9VVJhsULVbWSYpVKMsLEW5Qr4D7JFTp5fgn5iD4zCjx5GhNJOqRLiZuxJVrEVScr9u3pVV0fj
	Sy2RFZhpZTyeRJCWLARwcpTDv9bIvBtMt5OHvNFZ3TubEiEgHbaz5eAuX3HG4Dts7iLs7ztIsDmhG
	v1mjROwMTwAYO/N4hPoTbV2dA9dV+5pljyPmjQF79YHMSq8Zv5Xab+ga8CS393vYxUaHYVIeRo2H9
	btFsfe+ZxvwWTIhhz/k8BTg8PMSyB0ghgZszN6+VXIXiMv87doziFpWMzaPUbN8moM/FDAzeqNzUv
	BqINXwYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0mK6-0000000BM5e-0VZh;
	Mon, 22 Sep 2025 19:35:42 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0mK3-0000000BM4o-0Q4s
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 19:35:40 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MCEsMa006958;
	Mon, 22 Sep 2025 15:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=O
	rwDelNOUIFnIyLx4movB705psEmvrSGRlrDoxncUn8=; b=vDagpfKYK82wA9gxE
	Hns8GFdyFY3MpwD5/h/C90e0DhVkOOPoQqmNtvJpCi21QhMAxVPevgK+9ImIyq7H
	0SWaPqiKI0HB18POGA6QZ4yP5wCoC8SNIZAapPZidJp33LP6Utqtk06I4jhQBLNw
	vU10d3qhGJ9YwhCdYY4KnhsGbpq6Wnr9cxYQXF2HEegqXCd8YOz56EAQtc2wzJcD
	ceY8hOqUNHcSz0JDyEQOKXA2Jpqj8LH10Qqr2X5FgV76Xd8Hufa25Qa2AOqxGBAi
	SFPHeKghkxz3v+aPFKbB7topYwhhxxAYXQNeNWbBLUGJ7OYxuH+MZV4Hj9vbQJCq
	oa7gw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 499rxpgek0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 15:35:27 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MJTdTT037704;
	Mon, 22 Sep 2025 15:35:26 -0400
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 499pgsdkhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 15:35:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3auI5z8APFRtV8iXt4shXdh8weRuM0mmqSCMKG4jryt2cL9MGciGj3Epschzl4vFq2skGDuCk+nYFt4+2TtDv3850gMXMaySNwJftwpGn14m6hxkyT2SOYCwNg1DLTU8XTBtqGhl/Ml83sdYg+gu6UdJtlgGIBaB+yo//be0LCVhOVAcKe3mMz4VglA6IcxGBHudfg1xEpT7SXrrmkihl0XFcYhQ0P0BAOI2u3NFfKMvSIVlVnjxE/ZOGx1xGI3vi7S9Flk5G0QeYDn0jYh87NQE1aNuV2nRElgIq5yiZHAVkZL/aI1WcqYTYG6QScPFwvoSiR+GmO4oRKuWTTOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrwDelNOUIFnIyLx4movB705psEmvrSGRlrDoxncUn8=;
 b=OODNJpu3HtqLLqjxCHKHfVR3A70+Xwgk91EH4w7+T9eU45/r2NjQyNdDe+OcqvcUn2FgezsVmzOcLYbBXEfEGZYpFcJWeuwcFFQeCuHe0puYKIgnCoz2HZ8re0/wOgiB0R62n9xtHEsWY2XinQ2scx4YKruGiDmmBfmBnBTFli5At/HC+xGSP9dA1ZGqKRxh0GZhiTnJV1n+GVVQKiBnDY8AN4A5xddlVzFpOFtmxjYSoKFUI9/Dk5xuPAla0HdrJs+mHLDJSuJB5yyX2j48hU6DJPicQ4E+yFg7w+h79HuB9lgjybHTTrxkdLCukIuPZv6Pk2INBBESJbNVLzvPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by PH7PR19MB7462.namprd19.prod.outlook.com (2603:10b6:510:268::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 19:35:12 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::3715:4e28:3472:a0e4]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::3715:4e28:3472:a0e4%3]) with mapi id 15.20.9137.017; Mon, 22 Sep 2025
 19:35:12 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Keith Busch <kbusch@kernel.org>
CC: NVME-ML <linux-nvme@lists.infradead.org>
Subject: RE: [RFC PATCH] nvmet: set sq_id to zero in NVMe-oF CQE
Thread-Topic: [RFC PATCH] nvmet: set sq_id to zero in NVMe-oF CQE
Thread-Index: AdwrGMc2X2Us/6EgRai2jL6czjeF+QAy/2uAAAN7mbA=
Date: Mon, 22 Sep 2025 19:35:11 +0000
Message-ID: <CO1PR19MB48856EEA39CD993D3EBFA17FEE12A@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB4885E6CA8A98DEBE649A4D89EE13A@CO1PR19MB4885.namprd19.prod.outlook.com>
 <aNGEp4KGtDOSdlXo@kbusch-mbp>
In-Reply-To: <aNGEp4KGtDOSdlXo@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=0d373c63-bf75-4d1a-a479-00318a85022b;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2025-09-22T18:57:32Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|PH7PR19MB7462:EE_
x-ms-office365-filtering-correlation-id: 9124eaf0-77bb-4316-24ad-08ddfa0f25ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SVFrcTdOOWE5MmY3K0hqWEg5Ym5laklBamV1ZmljbWUyemh0NVU4KzJyaDc2?=
 =?utf-8?B?RDNIT2lqblV4b1NDMGd2d0N3TmRQN0gva0MyMzgvK3haZGdpb3R3MjduKzYz?=
 =?utf-8?B?Z2lpa2txRmcvTFpwa1F2WDlJMG02VFlRTWFnWjF5bnpXdkhrZDV4MzdYUS96?=
 =?utf-8?B?aEY0QWNKYnZ1MnZKdW1TTjFiN2xWVERaeDVWOEtvM3QyWHdLd1Ztenh0R0xa?=
 =?utf-8?B?ZGFmMThrWUkxS2dmWlhJU0NXQ3crVWhEd2pOUnJJeC9Gc21TQzV4d0Q2OXZM?=
 =?utf-8?B?VzhQekM2enVaWlhSNXNVd2ZJSWErcWRPUGlFTEFyT0VqV3RSQlQxV2thYS8x?=
 =?utf-8?B?YW54V09FQVJaeEE0SVpBV1FydGJlUkRVVmE4cnNjWXdtZXFlL0RYTEpGMmRm?=
 =?utf-8?B?QlArUGppL2xtMUdpeENXMzhUakJKb3E0WG1uUGNTN2ZmRkd1K1pPTWlOTG9L?=
 =?utf-8?B?dnQxbEl5L1UwekIzTHBIcmdDYUpDWklzcktCZ1UzSkpNVHYydlFFWlJiSWhF?=
 =?utf-8?B?UXJMem1VYzBpTWRMRi9RbEdiaCsvbTM1cXFoa3ZSSEVmQzJSTVQrbkRLVEU5?=
 =?utf-8?B?NWdvNmhoajl2V3lHR3htVmkwWUJ1ZFVlYVNWTlYyY0NZN0Y3U3VKd0RFaFRm?=
 =?utf-8?B?REFjMm9GeitCMFluclZycVZEa2o0QXY1Z0hERUQ0T0h4bXBuQjMxdVhERzRa?=
 =?utf-8?B?TFpjZHZLeGVtS1VIVExnTUxYcDVhYVpNczcrL0piVHdqNlQ4MlVsK2hIOGM3?=
 =?utf-8?B?VTFibzNGNDdjck1RZE9wWGk3cWtWZ2pYcnRUcmhST2NIR2E0aDE3NUhqMVNC?=
 =?utf-8?B?OGErbUxUa1JHKzEwei9JWVE3ZHNjdEk2SnVlaEcweTJ5NHpzL3FUQk81a290?=
 =?utf-8?B?bFI1T3pGNE8zYi9TeHdWTVZLampwd1RMTjFqR1QzUXBId3RPa0hmWml6RFla?=
 =?utf-8?B?VVIzcDN4UlFGVnZkR3BFNDllUFFudTJQcDdTOFQwc3h3a1ZqRnlnMllZMHlT?=
 =?utf-8?B?ZklIZVBHcFJadGdBVFVNWW41Q1locHhvNmxjWGR5ZFdtVllyVjVEdWZqUCts?=
 =?utf-8?B?d2RHczZQRGhyb0p2WGdFSjIzQ0VRSG4rblB1ZHlsSEcvQ285RkpmVG4yV0Ra?=
 =?utf-8?B?dCtJM2VLMUZyMGtoZGhYVXpqQ0hOOGVzYjVrNGZpNW9ycVc0amxnMWJod2NZ?=
 =?utf-8?B?NVlINVEvcHE2VncwdFBaYnFwTHBGNGhXRUM1WEJ5UFdRaS9VZ2V4WVpOVVIv?=
 =?utf-8?B?WEUwMWhUd2UyWkVyNDJaMXN5S2RreUt3U2RnM001eXNKNmRqWUtJZkRpRGEy?=
 =?utf-8?B?aGQ0SW05UXBjQnBRVzc4VDk5c3RsYnRhNHF2Ukhkd3NUUExRUFdqS051cWNy?=
 =?utf-8?B?alVHZDNpR1lzcFF6SzRXT2Y0a2pFRlcway9adDE3dDY4Y0JUYXYxRXBJT2RY?=
 =?utf-8?B?cEFBTlJoQ3hGcERHeFZydFYrL1NCL2ZNN2NIWGIzb1JQckhWZ0I3bFFtQjBG?=
 =?utf-8?B?OVhGNEZyaW1Ka05GdjNlalg5Mk5JY1FFY1N1TUlyNHVhdlFURUJWYk5lek5N?=
 =?utf-8?B?L0JzOFpUSEVMNncwb0RqZDBzYythNTZnbTJjYVNsWTRXR0RWbjZ0TXRUdWFU?=
 =?utf-8?B?dDVZaXZVejZJckxNQ096NG5Hd2hzUnRvSXpoc2d3WG41MkhxNDlDSllKc2Fs?=
 =?utf-8?B?ZjB6dmtqcy9GVHFXODl0Y3dFbi9SeU03TDlHUmhJdGdyRmp3NjZvWkgvWDJv?=
 =?utf-8?B?c0hENTl2Sy9NTnVzbTh0dGdXa3JmWTlHZ1ZIN0twRzNwWWYreWlJaG1WQTZU?=
 =?utf-8?B?bDJxWm9wYnRJRFQ5YjRwLzBZZldMcmVjd2tidk9kK2xBcVZlWXd6c2R3OTRS?=
 =?utf-8?B?akErYUNsQjErMGErNjdVOFBJR0YrTEg2K1oxZXBMY3JrMVpwcmZ1Mnd3QTRZ?=
 =?utf-8?B?NmxDUHA0eHZwOGRGQzRhL3NtdXdMSmxJQlhnT2IvNGRqUDM1aUFyaVBXYS9S?=
 =?utf-8?Q?Rz7eBZ9DsJU+8hyJiLH+vVMX5dH4TY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklFOHVUT2M4d2FOWmlYQ01HbUZsT2tVUDBkS1NWSlFuSnBORVNxRzZRMnA0?=
 =?utf-8?B?OU80cnRxTWFuT2tlVEl0YWhrQXF3RUdTN0NYRGg0MVgzbGxFT25Ka3JJVWdN?=
 =?utf-8?B?bGRpYkhFSTlaQnpLdldSWGx4WEhPQ01wZmhQWkF3cGp1Mk01c0lIaVV1U0pi?=
 =?utf-8?B?eUJqM2taQnJ2d2Y1WGF5aUhFdk5MR01jb0RVS3hkbFg2Y2hYNjZwTzRWTXlq?=
 =?utf-8?B?VUYyM1lYOFlqVlVzQU1RaTlJNEp4L0xqY2hsVklmSjhjOW9BZ3pCNlFOaSti?=
 =?utf-8?B?SlBpRzJkcS8vS0FRTWtGTUxSdEdCbFlxRHZmRUU3S2IwUyszQ0dVZjVuTTZa?=
 =?utf-8?B?amhKTi9yVUZmWGRUcFB2ekRwTlowVElYeVBCMjA5MS8wQlB4djZ1NlJydlBv?=
 =?utf-8?B?QnkzT0VqSzREMlhaMkQwTGdKek1VT2xpNVlpOUNQUmU2ZGpoME1zbzQyV250?=
 =?utf-8?B?KzREQ0JnTjM2UVhLWUJrdTdWWVVqMXlKSklkUmI4WXJxNUNZbXlFTWxlaHNv?=
 =?utf-8?B?Q0RrR3VIWm5NSFdpU3RNTllVZkxpOTJSVTBvM0hwVUM0U3JYVFFqQWVOTlln?=
 =?utf-8?B?a0ZOUGNORzdISzFHcjRuODdNalM3Q0dab1l1bSsvZ0JFbi9RSE5OckhsM05s?=
 =?utf-8?B?Z3RzOUpud1JISFFKMEdBQnRiWXNvdW5MKzFjNVFENGZZNlo0NHVqTEZDN1V2?=
 =?utf-8?B?K09yQS9nZklMbmRJZ2RMeDViaWxzT2RpMUdzMllNRldQVE1CMXlJdFNVRm1k?=
 =?utf-8?B?RmdJT2gzQU01TWV4N090ckpGUzc4MVpwd3BPUXNpb28weWYrTElMSUdWTXp5?=
 =?utf-8?B?WnA4MWFzMjk5SzZPbWhwSHZvcnpCMXEyOStQQmFibXRLZ0pWRXJLZ0U2Rlky?=
 =?utf-8?B?b0t3RmdGN3RzVXlYSUZGMER5Y2RnT0dMLytITldnSzI2VDdHQ1RUYWxDNHJN?=
 =?utf-8?B?QmpMNjFuVHBJTDRnaHV2Z2RBblVBSXh6K0M1K3llYnY2MThSbVpMTEFZaHNz?=
 =?utf-8?B?NFE4UEJmbjc0V284dFdqbitRcjRhdUxLV1VYSDN6YWo1b1dDZGtORm9sYnZv?=
 =?utf-8?B?emMzWXZSNm1yODluT29hd1VzTVcramFIM1QwVmtEQ2RZT1ZZcmx1MHpKMFg5?=
 =?utf-8?B?WWdWeGtUZWxMNVBzbEZTT3ZMLzRtbEt4cHBQZnJGalBKMHRYUGpwdjlSdk9F?=
 =?utf-8?B?UFRlU09rWnpjbW1qTXhCbHNZc3dzakhjWUlJOUs2OVNhcmJoT2w0NmdNZGZB?=
 =?utf-8?B?dmRIYlRRVVVpNFNlQWd5cXVscnFmTGFRYno0Sk15Si9rdzBBN2tXbjBFblA0?=
 =?utf-8?B?R0pJcnh0cVBXVUVMcXhybDlLcXJuZEhhV1huTERxdmFhNFdaRlRUZCs4QXNR?=
 =?utf-8?B?UHJidUwzTGhMc2VILzFhemhQTXlmQjFDQ2xOYk13U1FLOElsMnBTeWczby82?=
 =?utf-8?B?S3RYZnBWVWRDMUdHLzlMMTA2ZU91c1E5bDRSTlFkOVpwNjVrZSs3QUtMWWxi?=
 =?utf-8?B?OFZUYUIvMVUvRkJKdnRwKzhKNEY2eG5sUTNXNlJTTFhsUU5vTUhFSEY0bXVR?=
 =?utf-8?B?RGZOUzArYkRMcDU1VWxyeE5pMWpqbFFIbGhFS3R6Mjgvc1pvTXlTWER3c3I2?=
 =?utf-8?B?NjVnb2wvcFdCK2NKRkE3ZU1PZmhwSmZqQ0diK0xtdXhUL0ExMVhpZ0FQRCt1?=
 =?utf-8?B?UU93eFF6STRlbDY5NXh4S2dqOHBvcUN0TlVLbmVFMU9seWJtc1BhV2dRNXRF?=
 =?utf-8?B?cU1CWm1ETmw1ZVRWUmsxTXI0ZlI5SkNTbWFwQ1VEUXNoYlBLRlhoaTc4N3hi?=
 =?utf-8?B?S3JHeGJ3dUhRRjBXbUYxYVNSWlhDcUlXSHdNTE1CUUpwTTEyMmtoWmJnN3F5?=
 =?utf-8?B?Rm5kM3dsd1BOUElMcnhoNklpZ0RNYmVWQmxjVXJoQ2FmaUp0R0U1NjVNY0NY?=
 =?utf-8?B?VFZqMjhSSng5T2RYYmpwcU1QOG4vdnJ6RmF3dEhNbFJTdmNlS3B5Zk5MVy96?=
 =?utf-8?B?NU9xMDJubEJDcHdGWXR2Umg5R3lhUzhZRFFSbSswTXd0M2IzTHhTOFFCRER0?=
 =?utf-8?B?emV5cytTRDRmVUNZS2xrWmpvTFFNUGs2RFNQY2pqR0EwVkU2OS94V3hpRGhk?=
 =?utf-8?Q?CQAsR3e8yBApj2lqgE/Q6nVLL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9124eaf0-77bb-4316-24ad-08ddfa0f25ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 19:35:11.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNWlgJagAEN0PcyeGhUcoOsYD8Zeon3NxnlSJLdsIjN61ZVPfs1EjoDTFn4J5BUyQs3PtN4mt54CILz0tHbC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200054
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA4MiBTYWx0ZWRfXwilki5uIyi3y
 5ku5X4WzBlZYNLnsk+xg+rH6VaRIsCgsdpbkVrMoziPlOeyuj+HOgGADQtDGTVMzg+ytCrXo9mv
 WAqWg0D5/eV08PxkuPwsIXe5aTXvFub1r422dXqWRdNLcqsM0hO3T29ZFGEbAUWhbOngyeBH1Do
 v5YBT5YOxmH8oQ+1rh61m77YkvK6icfkh0k9Ed+I8Tyn5nFuvhpJd7JBG9NZcdyPuJx5mz+8Jef
 NLyankUQ6Gb16Tj+4OoAN1je3O/nxO7DGNpGWMLmGSVEvCShnZ45Pv9K3NnxV1Ba3EUaganz85Q
 KNdXG7FMpnacfP2fPkip7f1ure5MUH0iwImVnrD1Nd5BAuB/b6qKCp/7W4SsA7u4nDqom94rp2Q
 9JraxME7
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=68d1a4ff cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iLNU1ar6AAAA:8 a=JfrnYn6hAAAA:8
 a=d-b_o6iv63LPZdpzJPoA:9 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: on0szljfkRi8eDecypOwWRNmiq7gNVxD
X-Proofpoint-ORIG-GUID: on0szljfkRi8eDecypOwWRNmiq7gNVxD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_123539_344473_DEB6A691 
X-CRM114-Status: GOOD (  16.51  )
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

WW91IGFyZSByaWdodCwgdGhlIG9ubHkgcGxhY2UgdGhhdCB3cml0ZXMgdG8gdGhpcyBmaWVsZCBp
czoNCmNxZS0+c3FfaWQgPSBjcHVfdG9fbGUxNihyZXEtPnNxLT5xaWQpOw0KaW4gX19udm1ldF9y
ZXFfY29tcGxldGUoKS4gV2UgY2FuIHNpbXBseSByZW1vdmUgdGhpcyBhc3NpZ25tZW50IGFuZCBy
ZWx5IG9uIHRoZSBtZW1vcnkgYmVpbmcgY2xlYXJlZCB3aGVuIGFsbG9jYXRlZC4NCkxpbnV4IGhv
c3QgaWdub3JlcyBzcV9pZCBvbiBjb21wbGV0aW9ucywgYnV0IHRoaXMgYXZvaWRzIHBvdGVudGlh
bCBpbnRlcm9wZXJhYmlsaXR5IGlzc3VlcyB3aXRoIG90aGVyIGhvc3RzIG9yIGNvbXBsaWFuY2Ug
dGVzdHMgdGhhdCBtaWdodA0KdmFsaWRhdGUgdGhhdCBzcV9pZCBpcyB6ZXJvIChwZXIgc3BlYyku
DQoNCkkgY2FuIHJlc3BpbiB0aGUgcGF0Y2ggdGhpcyB3YXkgaWYgdGhhdCBzb3VuZHMgZ29vZC4N
Cg0KQW1pdA0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtlaXRoIEJ1c2NoIDxr
YnVzY2hAa2VybmVsLm9yZz4gDQpTZW50OiBNb25kYXksIDIyIFNlcHRlbWJlciAyMDI1IDIwOjE3
DQpUbzogRW5nZWwsIEFtaXQgPEFtaXQuRW5nZWxARGVsbC5jb20+DQpDYzogTlZNRS1NTCA8bGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnPg0KU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIG52
bWV0OiBzZXQgc3FfaWQgdG8gemVybyBpbiBOVk1lLW9GIENRRQ0KDQoNCltFWFRFUk5BTCBFTUFJ
TF0gDQoNCk9uIFN1biwgU2VwIDIxLCAyMDI1IGF0IDA1OjA2OjAxUE0gKzAwMDAsIEVuZ2VsLCBB
bWl0IHdyb3RlOg0KPiBAQCAtNzQxLDcgKzc0MSw4IEBAIHN0YXRpYyB2b2lkIF9fbnZtZXRfcmVx
X2NvbXBsZXRlKHN0cnVjdCBudm1ldF9yZXEgDQo+ICpyZXEsIHUxNiBzdGF0dXMpDQo+ICANCj4g
IAlpZiAoIXJlcS0+c3EtPnNxaGRfZGlzYWJsZWQpDQo+ICAJCW52bWV0X3VwZGF0ZV9zcV9oZWFk
KHJlcSk7DQo+IC0JcmVxLT5jcWUtPnNxX2lkID0gY3B1X3RvX2xlMTYocmVxLT5zcS0+cWlkKTsN
Cj4gKwkvKiBzcV9pZCBpcyByZXNlcnZlZCBmb3IgTlZNZS1vRiAqLw0KPiArCXJlcS0+Y3FlLT5z
cV9pZCA9IDA7DQoNCldoYXQncyB0aGUgcG9pbnQgb2YgZG9pbmcgdGhpcyBwZXItaW8/IE5vIG9u
ZSBldmVyIHNldHMgdGhlIHNxX2lkIHRvIGEgbm9uLXplcm8gdmFsdWUsIGFuZCBpdCBsb29rcyBs
aWtlIGV2ZXJ5b25lIGhhcyB0aGUgbWVtb3J5IGNsZWFyZWQgd2hlbiBpdCdzIGFsbG9jYXRlZC4g
SXMgdGhpcyBhY3R1YWxseSBmaXhpbmcgYW55dGhpbmc/DQo=

