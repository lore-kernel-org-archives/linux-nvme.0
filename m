Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF1AC5AE5D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+AxNjKVy/3Xfpuu1AGOptGt9wwcw6ZTYr/YOX2Gjns=; b=Nb4QqA2Ynnuwo1MuLwPUfrjYXg
	jWN+iS61BWrecbWZvW4FWMM1V01UuscJWnO/AUILjrU3RHXDGMDlcQlA9oo0j33isXGu3E/KsUcaZ
	OrY09hemfBSgE67kX/usDIPJW+vsBPjHywbHnz68Xrgbf4c1oTiFp3N5+7NQRn/ZWw6SNEXT/K951
	Oh4ssmDA8U4cdOOqKjnw+P2WRDY/1aokfB1/ctVqvOBZCUCE/bTJVP/5Ng4+YeTwd3GWar3+Mdzkm
	lhp8/MIhL9GtHPC6p27YTcwcY1qYU6ta93GZOpxjEikf9mrCYdS7kel4nZnNFJIFv9cKGp91yY3U/
	j+mbhK3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtNXA-0000000BXNd-27cX;
	Mon, 10 Aug 2026 10:47:08 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtNX6-0000000BXMr-1gKw
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 10:47:06 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679NL7XF2691298;
	Mon, 10 Aug 2026 10:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q+AxNjKVy/3Xfpuu1AGOptGt9wwcw6ZTYr/YOX2Gjns=; b=
	d/bWbBNJn1Njg6lhv08pu4vDWQhSK+O+pgKji0VdeeF0fI9SQnWJPwWAW4OHfOdb
	fQKxlEv9i7kJUBhx95xyoXEcj2u20A66tvSfvSqSf1IXZcuiQKRnMY8QY+mMwxEx
	9dnXyb0N+vBAMkVt5VSjIt+5P/zaKGfah9NJKYtauvox2CFV0mwDC2Kg99fpI4RB
	mHfITvjZkMSCMqrbhyw43dqln93sbAipPd5e67pneAnjVdzOmLPsE31gxP/zXcOS
	H2/C7lN3dEAudtrbjcPTEiZIYUe/4Vjc+BH2Ig8AvrHKlCCN+zs9IRbvAfQrx/Ib
	/QAj91fA6SjADJ7ycFeauw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvh2aaq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 10:46:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67AAiuRJ038450;
	Mon, 10 Aug 2026 10:46:42 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwcapk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 10:46:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxEaih358xk68pBLQPm/MypmZcgNN0atZaeWWVQTmF9+RcQRorf+6QffTfNfcD88yj1gzsD98pnwQxTmkxZWOJ1TaWDjfzmIORUV5jCKCKy2R1+UMQUJflFGiI8MKUzDHv6QltxQbMKfNLauY2NF0dmq2aR2iKxPlry5CDjzIyqVmCnI5iCYM/KvPRJMac/5oGjCxExpgjtzgBsjfX7+UYFoDS0eBzW3cYCZgig1uSJbcWV5hiDDTczmXxhPjxXGEZRYRCaM26YMsha1jOvQ4TbB6fjEzoh5gpQ0fj0gj1f3krZ89AIo/iyILFoM0U1rkVrMuFx+mRPbkTKa4pv4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+AxNjKVy/3Xfpuu1AGOptGt9wwcw6ZTYr/YOX2Gjns=;
 b=pla2mJ9EY2IubB3WyS53p0j/MfIX7nxQSPPdVGDyWe7QttZOkXSHeFST3cdO4SQesNgn8O1iQdpGQ4XOCennICOUnIRNnDoAlckq9h1xxTdhmz29m6yUoaWze/W59CkyxdUQmX9o3KApJTDqXy5dVR8mhlAV9aiWyme+ifhoYFOafqMBf71KJvaeUqiR7t1OqL1dm/bVPoQwn7QvP7WC0K52q2QKfjLMm7Szu2r/s2d+k2uEJj2DZgifa5g+qEYXabHFmFEuVl7idgEPyb6h4m0v0GTElZS0x9kiTZJCs8/RXeUqnOL3u5b+S9Uelg2IjPIAkDwMwbuflbWr+wMNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+AxNjKVy/3Xfpuu1AGOptGt9wwcw6ZTYr/YOX2Gjns=;
 b=L4bIHgQOcCA58v001A27WBT8US2wCmj/78kt/PC7pfz0z9FcKN1ANiZbt9ErX+z8ALv8ntR3ykF73Y6WuSsbyvvsMwPr05ESDBGr8bUmf/2gmCzaFdLbd5RycDmUNiySzuSk+KjbM+9OXM8kbGjM3dV9OhrUydVyBfvMWRHlkXo=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 MW4PR10MB6629.namprd10.prod.outlook.com (2603:10b6:303:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Mon, 10 Aug
 2026 10:46:37 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:46:37 +0000
Message-ID: <055c80a6-16f2-4d1b-ab6e-fc4fd24e7227@oracle.com>
Date: Mon, 10 Aug 2026 11:46:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260809100825.2014133-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0610.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::12) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|MW4PR10MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 0419fde1-b5cf-4356-df0a-08def6cca70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|5023799004|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: w+zo46nq4i9f00178Ro99ermzaOu3EqyxwLpYjQSUYaXxaBS8SgXgbNaiaf+PuC+v8rqThINGCRz0ZetdxTaswHdXcYw7xh6q0/gsR460/jukZBggRhELqFPnRxb2kbG56T5r/zVWup+WLKrnc11TtHkAmEyBPDeeUtnHYgTa6EWDg80Q1ZkF3e7sW0IAn1ZiWbfnZGOg4y+DTXbC0T6XbOp4dGmukuozNSlmC3vwyWhJO7e6qHLWABjUOriRg7kwGzY4JO/XXl1h0AInf/fq+gG/rGoloPf+2evFpXdV52oo9cfTyeeKtIcpNEU6Jac3H7/GxkAtSIclKkGOZPA2ptaMF6o4XgyW2aRIgt6XGrGYBxui1+/xcxGzUelXPWARTvxkDvn5WwBlzbVufD6mLuHt9kx3taiez0zvkauZ08V/X8mJAIPifX2ZcKENwbbJiqaPbF3hprmNGXt7yNfCBNhP7PfMWI88lESRQLdj3/2ZuAxUZa/vZMXlXtalzByrKppIGlFq+GJ3neFf2MRwrxTHXOgJV0q7r1KCPAPOUA9/Kqt5Hxhwrkp6n5eJ4f4V8GgYNbXra3BZ5V4khulAqE7YXWOq+vhMWkyzsqahirOOx07ukvz0dAuGYyrB863P2bFYc60HmauolEeGmtTUEGlzbbrpt9aKGW17nfsBS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGQ5aFc4Y3dneTUvbTVIbHpZNW5GdVNXeDVybjh6bFBjb0h0M3VHNDUwd1VL?=
 =?utf-8?B?T1NHSlpGWC9jNnh0ZGVNVGw0S0F1Zmk3TGY5WU12UUp3R0diRVp5R05JczVT?=
 =?utf-8?B?dUhQRVV1Q2MrTTZYdEhZb2R5R0IwWGFJSDdxRFRrODJXeVk3NytEeW1NYWR5?=
 =?utf-8?B?ZFNXNUZIUmJMZG1lU2pGNHpHYW5OVWpwV3dicmg1UEg0YVR0QXV0dWMycUxt?=
 =?utf-8?B?a3hGZDk0eVJpWGVHSE5lZDJRNHRNakxZcGRHNmw5elpuNWhQR3NidHluQ29N?=
 =?utf-8?B?aVZKMUcwR1U3MzJaS3kwamUrTVR6RlR1aE05VURsZ3U0R3BuNUg0RkdnK1Zh?=
 =?utf-8?B?R1N5NVVoajVEaDYwNjdPWUQ1VFkyU2J2TUp3bFlYcWIycC9BdDA3b20xYW0y?=
 =?utf-8?B?Uy9hUkdzdHVvbTNqY0ZYQWkrL1NCRG1ZOTIzRlEyTFk3Q21aMXdZS1crOGVo?=
 =?utf-8?B?Q2RnVjBIM1BOeVlmSmZPSTBIV1dXdTN4UDEzb3hkdCt5SmUrbDQyQkRMSEtZ?=
 =?utf-8?B?NmgvcXJqYWd3bkNkdVdJNEZSOWtmUWp4dGtCdnVPMkZ3RkZCdC9kZ0xacjk3?=
 =?utf-8?B?dFZZOTM4aUlPOTRQWG1pbVFxMmtpRWdqUndpa1FPU3R0NUpuVkJ0eHlld3ZR?=
 =?utf-8?B?S3FxTS9vaXFodkN5ZWNCSU52RW1TYXN3NnJ0ZDlUbjBRdmZXK29iTTcyUnd6?=
 =?utf-8?B?WDBnMVk5N3JHeFNUQklObmR3blhUV0xscldwKyt5cDBBZVNxeGY1RU1vMEQ5?=
 =?utf-8?B?Sy9pZW9Rbk11V3B1ZmlEWDZ2L2t4S3o1aXI0K1ZTMmRRQllzdStjOWI1YWgv?=
 =?utf-8?B?VEtSdlNxdGowRzljL1dpYXJsT2QrNGFoNXpqYlh1eStjVEQ4djBGcDAxemtF?=
 =?utf-8?B?MFFHUGRjWDg5VnVBWXNBMEowT0ZadjBNZ1ZaTHBBNS9samlYNnU3YVY1NVJE?=
 =?utf-8?B?NEVhZ2plMlVYUlVkY285S2twalRhZHFhdFJ2WHlaZ0NLZ2RlWE9XOGcvOVRq?=
 =?utf-8?B?enVPVzJBeTJtRDZiSXFBOXVuVXZoMHg2aEx0Qm5Vbzh3TEdXMUUvVlZEdmVS?=
 =?utf-8?B?VlVwQUtyQXBYM3V1M1J3TW9jTVR1NkN6cXdlbDVWdE5jdTc4cnhIemYxdlBJ?=
 =?utf-8?B?cXNsMG5jOHN3akdjNUpZSXNMaDFKRFUvRnp1cGZwZDlnenVVODdaZmlLZi9p?=
 =?utf-8?B?em1HNG9uT1lSckhrOUlCS2NlMVhmL25ic0YwSHhxVEliWXJkR2l1cm9BMFhG?=
 =?utf-8?B?QjlyWjY1UXpKRmw0M2ZGN0RrdVhwcjNoTGk5aExQZFZPUXMydmk1cnR3cmhF?=
 =?utf-8?B?NjBOZVpETWpkOEJ3MlVNS1llcXkxTlkyYjhqS3VaRnFYUHVJRUtkVnZUUG9N?=
 =?utf-8?B?UDlUTkdUb0l3OHdoWUtpOHBWQnZManoveFRsM2YzNkZZcnBhZHkxMmdGSmxJ?=
 =?utf-8?B?eVZqczdXVDNFQnpaQkJPQ2RHak53WndBeWYya1B6bm9UQlQydTRpbzVpOVBD?=
 =?utf-8?B?TEkvZmF2WnpNTGxvaDlrOFcxYW03U3VQbERidzFTRjZEK1NnUDM1VTZRR2R6?=
 =?utf-8?B?RENOOGFyWWs1dWVpbGpFNE9YUmdKVWxhT0JtWGZHYWxTUDFXaisrQmFTL3Rk?=
 =?utf-8?B?TVA0UW1KS1JtSlJYbjF6VmNwbVU4UGFsdzN6WFF6Yy8yUFplTFJoTk5sNFBT?=
 =?utf-8?B?UGU1L0dQM3NxR1hzaVZScjFLQmF5TnAyeGF2ODlXM1NKVHZUeFN5d1NTQStx?=
 =?utf-8?B?RkpMOGt2L2NMS2NQSW5palVOZ0tFMXYrVG4wNzJrNGhCclFIMzJYMlk0K0lm?=
 =?utf-8?B?emM2bGcxY2xIY05lbE1XL29sMnZWbGN5cllBbUo0eDg4TU5vb2tDZUowcVdw?=
 =?utf-8?B?by9Fc2xEUDlvMTdLUzlNS0Y4RS96Z0NEaUUzUlVaSGZ2VTI1V2NmaGZuL2ZM?=
 =?utf-8?B?dEFERW1TUENrK0RKY1BjYXdjQ1FVaGg1ZkVuOEhkeUwxdnNyaWdLRHk4NmN4?=
 =?utf-8?B?bWNSdm5aZTh0RGI2MkMzSjNFZkp4dHhEbkVSbTNRc2U2S1ZsMG5VWW1xbjNa?=
 =?utf-8?B?TFR2VTBFaEErVGFYdU9PeXg5K1QrcWRWSWNuTFVxQTNSU2c3MUVzd25lbDZE?=
 =?utf-8?B?czRwSFV1KzB1RWJ2ZjcwY0NVVUtMdFI5WmpjMFJEcHpEUkhoMWhRUzdOZmRK?=
 =?utf-8?B?cE9IVmNqS1FFT2dGZ1kyVVU4UVBiSnJhMHZTQlNQQUlaU3E1V1lNdUlZbWxD?=
 =?utf-8?B?Q2pmejBWTnlXSVZ1cXB4ZVA0eDVQekk5N284Y21QVEI1dmN4OVdmVnZHL0wv?=
 =?utf-8?B?WU0wN2hFb1JLNzUwQmFvU284R0NyZ2VnN3J1YzBTY0NHOXVJTWZkdz09?=
X-Exchange-RoutingPolicyChecked: U//9t+Og92a+Dc7oqoOXfGQZWiTWKFRIwcPZB86ucAdxr45CbIzWKdzU1r1ypS3pWSlmFwJZnqZ+mmsswCvs+p++1TO+cE5aTewudAvif/V5041loONMWySm4+sneVkzJgiOD+uVjOH/Rk5Le79iYJZG8vRilbQ2mIM3QQZOb1XVa8XFkiZ0XHkBcedrAquNszCXMhR9XNwbX7cTqPe/Ki+NkOY/6H8QHdDq3umdDU8rpwf4k16uBj0bRZ0R15NZXD+oPu+V8j8nedboP+eJx7MKKmKlqrKNXiyoeNhVW73UykTi6VA1lhrCVMG0+Ycf4Ls/q1iHdr+XZjDGCtxeOQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ikbGjUho1CT0aFZ6BJZM90ARuLswHW9jneVE20s48xjTESKHKP6ZYOrqzGGHSEzzfTMD6ljjg5xML2BkcCnBPr6bzslDD5miKqthu/2UAd6d80u9fo94O6+sUIx9x2Gzc8dTMaoc/xVD2UA4cpxN6cHv3ncG9YVJkAhqzCisaeaYyvMykx6aNmLrWc8n48L2E0uuM8RZu7JzHWSmzwtPJiFrxmU5xCrUEVaOWauSDaws1Rac9UwLCmKdPVMewYycnM4Ml/LFy4whjsaaHPRGVQQV5cVMRU/MnT9cB6RZJDQ/sASbgnLGqYG5cKOKNJrn+9ROV/8tyiehBDZjBgdw3+LD+yqNGVDAjr+cJz2ZKIxkzCMyMDHhTWYI2MEQYICBwTs0nx/y7MY14AlNHMdUCYeawGc/2xH0Pk9SUR+yBtopjGyEEX1WIvzZm9hSi1GRZROprTyONsaeHKIwNHFI6g7CBnQ9h9NQdhMWfNq6VyQaZImhuKFyXnpbUU8fLSr+4XrmO2G9s1fhXVqf+uFDfezZ/RAA4uUfANHAjOWnMAd6qao9vynZDAuzfhaJnO9+MkU2lqZ/MboMvJR7v3GiwHh6gx6ADWRQKkqQ+P/01is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0419fde1-b5cf-4356-df0a-08def6cca70e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:46:37.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPHa8WK4Xi7nfenN6YpdYLrZdFKHktdwKG86SAkBZT/6f5Duag8oduPuKcGm3tlpvlS9cOrpTfML4bXFRquuGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100094
X-Authority-Analysis: v=2.4 cv=M6V97Sws c=1 sm=1 tr=0 ts=6a79ac13 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VnNF1IyMAAAA:8
 a=NCt0x_SNAL5zCdXvqGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ndlerVRnsBcQn2joltUOWt2gauorhOCm
X-Proofpoint-ORIG-GUID: ndlerVRnsBcQn2joltUOWt2gauorhOCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5MyBTYWx0ZWRfXxyLgsbB+pTF4
 zyHfR16WY3yFuFv6hHxRopEPSMhIOK9vMP/0vz/ikGtgwWVmVKd8Nd0hKAYVkj/fZ92krm75Ucq
 jEJFLg/CaIq5vuUHxaiJ26ERy98H5meOeE3Uf0F3PnJFBLQj3zMN2SQd2pCd3OkF5tp0EP1ryvv
 ykm87DYsUu8DgL6C1tHeVoEPbWVZuz5oHCkn6wVdL8Xb0LbsmVkItbgniBSjIl+UHZjBywEnghx
 3DJ9sgjXXr9+jFTOKbLUh6EpV9wXWcnafDYE5sRMnin0ckF4CWgidvfCw2/96kO9k2QKFfn9Xp/
 16MVq01XjG7LVuWep7IMjYb3m88jgryt5VFWlni58lutZzHxW+ozysM3+KJy4jOKsgr323LtApy
 BcRLAKBc5tc34skHTiEZp6/fBkm2p8IhncQVBkUJxBDXUpFYPPjz1YLJJbrQybOyOpTqdv0h7ZX
 gPKKuA97AXoO5OwGbCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5MyBTYWx0ZWRfXzX5wt4eeQ7fN
 GisSPFotVm3rmKQIO3AcJWKo8QbI6O5tRC7SBbYXjdOKehSk07Wje8L23JYi0xt4kYNnFgpk80J
 OyW6FHMNGNk1MTm1jV7Flfk1RkKRgIiIE1/nidTUqy2nX/kdzUnz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_034704_636961_C2898A0D 
X-CRM114-Status: GOOD (  19.93  )
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

On 09/08/2026 11:07, Nilay Shroff wrote:
> This commit introduces a new I/O policy named "latency". Users can configure it
> by writing "latency" to "/sys/class/nvme-subsystem/nvme- subsystemX/iopolicy"
> The "latency" policy dynamically distributes I/O based on measured I/O
> completion latency. 
 >
> This commit introduces a new I/O policy named "latency". Users can
> configure it by writing "latency" to "/sys/class/nvme-subsystem/nvme-
> subsystemX/iopolicy"
> 
> The "latency" policy dynamically distributes I/O based on measured I/O
> completion latency. The main idea is to calculate latency for each path,
> derive a weight, and then proportionally forward I/O according to those
> weights.
> 
> To ensure scalability, path latency is measured per-CPU. Each CPU
> maintains its own statistics, and I/O forwarding uses these per-CPU
> values. Every ~15 seconds, a simple average latency of per-CPU batched
> samples are computed and fed into an Exponentially Weighted Moving
> Average (EWMA):
> 
> avg_latency = div_u64(batch, batch_count);
> new_ewma_latency = (prev_ewma_latency * (WEIGHT-1) + avg_latency)/WEIGHT
> 
> With WEIGHT = 8, this assigns 7/8 (~87.5%) weight to the previous
> latency value and 1/8 (~12.5%) to the most recent latency. This
> smoothing reduces jitter, adapts quickly to changing conditions,
> avoids storing historical samples, and works well for both low and
> high I/O rates. Path weights are then derived from the smoothed (EWMA)
> latency as follows (example with two paths A and B):
> 
> 	path_A_score = NSEC_PER_SEC / path_A_ewma_latency
> 	path_B_score = NSEC_PER_SEC / path_B_ewma_latency
> 	total_score  = path_A_score + path_B_score
> 
> 	path_A_weight = (path_A_score * 64) / total_score
> 	path_B_weight = (path_B_score * 64) / total_score
> 
> where:
>     - path_X_ewma_latency is the smoothed latency of a path in nanoseconds
>     - NSEC_PER_SEC is used as a scaling factor since valid latencies
> 	are < 1 second
>     - weights are normalized to a 0–64 scale across all paths.
> 
> Path credits are refilled based on this weight, with one credit
> consumed per I/O. When all credits are consumed, the credits are
> refilled again based on the current weight. This ensures that I/O is
> distributed across paths proportionally to their calculated weight.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>    drivers/nvme/host/core.c      |  15 +-
>    drivers/nvme/host/multipath.c | 444 +++++++++++++++++++++++++++++++++-
>    drivers/nvme/host/nvme.h      |  52 +++-
>    3 files changed, 496 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..542e2ee036cc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -690,6 +690,9 @@ static void nvme_free_ns_head(struct kref *ref)
>    	cleanup_srcu_struct(&head->srcu);
>    	nvme_put_subsystem(head->subsys);
>    	kfree(head->plids);
> +#ifdef CONFIG_NVME_MULTIPATH
> +	free_percpu(head->latency_path);
 > +#endif

Since head->latency_path is allocated in nvme_mpath_alloc_disk(), can 
this free be done in nvme_mpath_put_disk()? I know that we would be 
doing more than a "put" of the disk, but we do other tidying tasks in 
nvme_mpath_put_disk() already.

>    	kfree(head);
>    }
>    
> @@ -707,6 +710,7 @@ static void nvme_free_ns(struct kref *kref)
>    {
>    	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>    
> +	nvme_free_ns_stat(ns);
>    	put_disk(ns->disk);
>    	nvme_put_ns_head(ns->head);
>    	nvme_put_ctrl(ns->ctrl);
> @@ -4220,6 +4224,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>    	if (nvme_init_ns_head(ns, info))
>    		goto out_cleanup_disk;
>    
> +	if (nvme_alloc_ns_stat(ns))
> +		goto out_unlink_ns;
> +
>    	/*
>    	 * If multipathing is enabled, the device name for all disks and not
>    	 * just those that represent shared namespaces needs to be based on the
> @@ -4244,7 +4251,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>    	}
>    
>    	if (nvme_update_ns_info(ns, info))
> -		goto out_unlink_ns;
> +		goto out_free_ns_stat;
>    
>    	mutex_lock(&ctrl->namespaces_lock);
>    	/*
> @@ -4253,7 +4260,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>    	 */
>    	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
>    		mutex_unlock(&ctrl->namespaces_lock);
> -		goto out_unlink_ns;
> +		goto out_free_ns_stat;
>    	}
>    	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>    	nvme_ns_add_to_ctrl_list(ns);
> @@ -4278,6 +4285,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>    	list_del_rcu(&ns->list);
>    	mutex_unlock(&ctrl->namespaces_lock);
>    	synchronize_srcu(&ctrl->srcu);
> +out_free_ns_stat:
> +	nvme_free_ns_stat(ns);
>     out_unlink_ns:
>    	mutex_lock(&ctrl->subsys->lock);
>    	list_del_rcu(&ns->siblings);
> @@ -4317,7 +4326,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>    
>    	/*
>    	 * Ensure that !NVME_NS_READY is seen by other threads to prevent
> -	 * this ns going back into current_path.
> +	 * this ns going back into current_path/latency_path.
>    	 */
>    	synchronize_srcu(&ns->head->srcu);
>    
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 8c20ff516e61..8086530b5350 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -6,6 +6,9 @@
>    #include <linux/backing-dev.h>
>    #include <linux/moduleparam.h>
>    #include <linux/vmalloc.h>
> +#include <linux/blk-mq.h>
> +#include <linux/math64.h>
> +#include <linux/rculist.h>

maintaining alpabetic ordering is nicer

>    #include <trace/events/block.h>
>    #include "nvme.h"
>    
> @@ -66,9 +69,10 @@ MODULE_PARM_DESC(multipath_always_on,
>    	"create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
>    
>    static const char *nvme_iopolicy_names[] = {
> -	[NVME_IOPOLICY_NUMA]	= "numa",
> -	[NVME_IOPOLICY_RR]	= "round-robin",
> -	[NVME_IOPOLICY_QD]      = "queue-depth",
> +	[NVME_IOPOLICY_NUMA]	 = "numa",
> +	[NVME_IOPOLICY_RR]	 = "round-robin",
> +	[NVME_IOPOLICY_QD]       = "queue-depth",
> +	[NVME_IOPOLICY_LATENCY]  = "latency",
>    };
>    
>    static int iopolicy = NVME_IOPOLICY_NUMA;
> @@ -107,7 +111,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>    module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>    	&iopolicy, 0644);
>    MODULE_PARM_DESC(iopolicy,
> -	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
> +	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth' or 'latency'");
>    
>    void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>    {
> @@ -199,6 +203,203 @@ void nvme_mpath_start_request(struct request *rq)
>    }
>    EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>    
> +static void nvme_mpath_weight_work(struct work_struct *weight_work)
> +{
> +	int cpu, srcu_idx;
> +	u32 weight;
> +	struct nvme_ns *ns;
> +	struct nvme_path_lat_stat *stat;
> +	struct nvme_path_lat_work *work = container_of(weight_work,
> +			struct nvme_path_lat_work, weight_work);
> +	struct nvme_ns_head *head = work->ns->head;
> +	int op_type = work->op_type;
> +	u64 total_score = 0;
> +
> +	cpu = get_cpu();
> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	list_for_each_entry_srcu(ns, &head->list, siblings,
> +			srcu_read_lock_held(&head->srcu)) {
> +
> +		stat = &this_cpu_ptr(ns->path_lat)[op_type].stat;

get_cpu() does a raw_smp_processor_id() call to get the cpu. So why not 
use the this_cpu_ptr() equivalent which is passed the cpu, which would 
save looking up the cpu again? I think that is per_cpu_ptr(), which is 
actually used elsewhere

> +		if (!READ_ONCE(stat->slat_ns)) {
> +			stat->score = 0;
> +			continue;
> +		}
> +		/*
> +		 * Compute the path score as the inverse of smoothed
> +		 * latency, scaled by NSEC_PER_SEC. Floating point
> +		 * math is unavailable in the kernel, so fixed-point
> +		 * scaling is used instead. NSEC_PER_SEC is chosen
> +		 * because valid latencies are always < 1 second; longer
> +		 * latencies are ignored.
> +		 */
> +		stat->score = div_u64(NSEC_PER_SEC, READ_ONCE(stat->slat_ns));
> +
> +		/* Compute total score. */
> +		total_score += stat->score;
> +	}
> +
> +	if (!total_score)
> +		goto out;
> +
> +	/*
> +	 * After computing the total slatency, we derive per-path weight
> +	 * (normalized to the range 0–64). The weight represents the
> +	 * relative share of I/O the path should receive.
> +	 *
> +	 *   - lower smoothed latency -> higher weight
> +	 *   - higher smoothed slatency -> lower weight
> +	 *
> +	 * Next, while forwarding I/O, we assign "credits" to each path
> +	 * based on its weight (please also refer nvme_latency_path()):
> +	 *   - Initially, credits = weight.
> +	 *   - Each time an I/O is dispatched on a path, its credits are
> +	 *     decremented proportionally.
> +	 *   - When a path runs out of credits, it becomes temporarily
> +	 *     ineligible until credit is refilled.
> +	 *
> +	 * I/O distribution is therefore governed by available credits,
> +	 * ensuring that over time the proportion of I/O sent to each
> +	 * path matches its weight (and thus its performance).
> +	 */
> +	list_for_each_entry_srcu(ns, &head->list, siblings,
> +			srcu_read_lock_held(&head->srcu)) {
> +
> +		stat = &this_cpu_ptr(ns->path_lat)[op_type].stat;
> +		weight = div_u64(stat->score * 64, total_score);
> +
> +		/*
> +		 * Ensure the path weight never drops below 1. A weight
> +		 * of 0 is used only for newly added paths. During
> +		 * bootstrap, a few I/Os are sent to such paths to
> +		 * establish an initial weight. Enforcing a minimum
> +		 * weight of 1 guarantees that no path is forgotten and
> +		 * that each path is probed at least occasionally.
> +		 */
> +		if (!weight)
> +			weight = 1;
> +
> +		WRITE_ONCE(stat->weight, weight);
> +	}
> +out:
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +	put_cpu();
> +}
> +
> +/*
> + * Formula to calculate the EWMA (Exponentially Weighted Moving Average):
> + * ewma = (old_ewma * (EWMA_SHIFT - 1) + (EWMA_SHIFT)) / EWMA_SHIFT
> + * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
> + * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
> + */
> +static inline u64 calc_ewma_update(u64 old, u64 new)
> +{
> +	return (old * ((1 << NVME_DEFAULT_LATENCY_EWMA_SHIFT) - 1)
> +			+ new) >> NVME_DEFAULT_LATENCY_EWMA_SHIFT;
> +}
> +
> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
> +{
> +	int cpu;
> +	unsigned int op_type;
> +	struct nvme_path_lat *path_lat;
> +	struct nvme_path_lat_stat *stat;
> +	u64 now, latency, slat_ns, avg_lat_ns;
> +	struct nvme_ns_head *head = ns->head;
> +
> +	if (list_is_singular(&head->list))
> +		return;
> +
> +	now = ktime_get_ns();
> +	latency = now >= rq->io_start_time_ns ? now - rq->io_start_time_ns : 0;
> +	if (!latency)
> +		return;
> +
> +	/*
> +	 * As completion code path is serialized(i.e. no same completion queue
> +	 * update code could run simultaneously on multiple cpu) we can safely
> +	 * access per cpu nvme path stat here from another cpu (in case the
> +	 * completion cpu is different from submission cpu).
> +	 * The only field which could be accessed simultaneously here is the
> +	 * path ->weight which may be accessed by this function as well as I/O
> +	 * submission path during path selection logic and we protect ->weight
> +	 * using READ_ONCE/WRITE_ONCE. Yes this may not be 100% accurate but
> +	 * we also don't need to be so accurate here as the path credit would
> +	 * be anyways refilled, based on path weight, once path consumes all
> +	 * its credits. And we limit path weight/credit max up to 64. Please
> +	 * also refer nvme_latency_path().
> +	 */
> +	cpu = blk_mq_rq_cpu(rq);
> +	op_type = nvme_data_dir(rq);
> +	path_lat = &per_cpu_ptr(ns->path_lat, cpu)[op_type];
> +	stat = &path_lat->stat;
> +
> +	/*
> +	 * If latency > ~1s then ignore this sample to prevent EWMA from being
> +	 * skewed by pathological outliers (multi-second waits, controller
> +	 * timeouts etc.). This keeps path scores representative of normal
> +	 * performance and avoids instability from rare spikes. If such high
> +	 * latency is real, ANA state reporting or keep-alive error counters
> +	 * will mark the path unhealthy and remove it from the head node list,
> +	 * so we safely skip such sample here.
> +	 */
> +	if (unlikely(latency > NSEC_PER_SEC)) {
> +		stat->nr_ignored++;
> +		dev_warn_ratelimited(ns->ctrl->device,
> +			"ignoring sample with >1s latency (possible controller stall or timeout)\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Accumulate latency samples and increment the batch count for each
> +	 * ~15 second interval. When the interval expires, compute the simple
> +	 * average latency over that window, then update the smoothed (EWMA)
> +	 * latency. The path weight is recalculated based on this smoothed
> +	 * latency.
> +	 */
> +	stat->batch += latency;
> +	stat->batch_count++;
> +	stat->nr_samples++;
> +
> +	if (now > stat->last_batch_ts && ((now - stat->last_batch_ts) >=
> +			NVME_DEFAULT_LATENCY_BATCH_TIMEOUT)) {
> +
> +		/*
> +		 * Find simple average latency for the last epoch (~15 sec
> +		 * interval).
> +		 */
> +		avg_lat_ns = div_u64(stat->batch, stat->batch_count);
> +		stat->last_batch_ts = now;
> +
> +		/*
> +		 * Calculate smooth/EWMA (Exponentially Weighted Moving Average)
> +		 * latency. EWMA is preferred over simple average latency
> +		 * because it smooths naturally, reduces jitter from sudden
> +		 * spikes, and adapts faster to changing conditions. It also
> +		 * avoids storing historical samples, and works well for both
> +		 * slow and fast I/O rates.
> +		 * Formula:
> +		 * slat_ns = (prev_slat_ns * (WEIGHT - 1) + (latency)) / WEIGHT
> +		 * With WEIGHT = 8, this assigns 7/8 (~87.5 %) weight to the
> +		 * existing latency and 1/8 (~12.5%) weight to the new latency.
> +		 */
> +		if (unlikely(!stat->slat_ns))
> +			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
> +		else {
> +			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns);
> +			WRITE_ONCE(stat->slat_ns, slat_ns);
> +		}
> +
> +		stat->batch = stat->batch_count = 0;
> +
> +		/*
> +		 * Defer calculation of the path weight in per-cpu workqueue.
> +		 */
> +		schedule_work_on(cpu, &path_lat->work.weight_work);
> +	}
> +}
> +
>    void nvme_mpath_end_request(struct request *rq)
>    {
>    	struct nvme_ns *ns = rq->q->queuedata;
> @@ -206,6 +407,15 @@ void nvme_mpath_end_request(struct request *rq)
>    	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
>    		atomic_dec_if_positive(&ns->ctrl->nr_active);
>    
> +	if (test_bit(NVME_NS_PATH_STAT, &ns->flags)) {
> +		int srcu_idx;
> +
> +		srcu_idx = srcu_read_lock(&ns->head->srcu);
> +		if (test_bit(NVME_NS_PATH_STAT, &ns->flags))

Some may ask why check NVME_NS_PATH_STAT twice.

> +			nvme_mpath_add_sample(rq, ns);
> +		srcu_read_unlock(&ns->head->srcu, srcu_idx);
> +	}
> +
>    	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>    		return;
>    	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> @@ -239,6 +449,78 @@ static const char *nvme_ana_state_names[] = {
>    	[NVME_ANA_CHANGE]		= "change",
>    };
>    
> +static void nvme_reset_ns_latency_stat(struct nvme_ns *ns)
> +{
> +	int i, cpu;
> +	struct nvme_path_lat_stat *stat;

reverse fir tree style ordering is nicer, in my opinion

> +
> +	for_each_possible_cpu(cpu) {
> +		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
> +			stat = &per_cpu_ptr(ns->path_lat, cpu)[i].stat;
> +			memset(stat, 0, sizeof(struct nvme_path_lat_stat));
> +		}
> +	}
> +}
> +
> +void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns)

why not static? It seems to be only used in multipath.c

> +{
> +	int i, cpu;
> +	struct nvme_path_lat *path_lat;
> +
> +	for_each_possible_cpu(cpu) {
> +		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
> +			path_lat = &per_cpu_ptr(ns->path_lat, cpu)[i];
> +			cancel_work_sync(&path_lat->work.weight_work);
> +		}
> +	}
> +}
> +
> +static bool nvme_enable_ns_latency_sampling(struct nvme_ns *ns)

return value never checked

> +{
> +	struct nvme_ns_head *head = ns->head;
> +
> +	if (!head->disk ||
> +		READ_ONCE(head->subsys->iopolicy) != NVME_IOPOLICY_LATENCY)
> +		return false;
> +
> +	if (test_and_set_bit(NVME_NS_PATH_STAT, &ns->flags))
> +		return false;
> +
> +	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, ns->queue);

Please explain why it is required. nvme_mpath_add_sample() looks to 
mention this, but I think a brief explanation here would be good.

> +	blk_stat_enable_accounting(ns->queue);
> +	return true;
> +}
> +
> +static bool nvme_disable_ns_latency_sampling(struct nvme_ns *ns)
> +{
> +	int cpu;
> +	struct nvme_ns_head *head = ns->head;
> +	bool changed = false;
> +
> +	if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
> +		return false;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (ns == READ_ONCE(*per_cpu_ptr(head->latency_path, cpu))) {
> +			WRITE_ONCE(*per_cpu_ptr(head->latency_path, cpu), NULL);
> +			changed = true;
> +		}
> +	}
> +
> +	blk_stat_disable_accounting(ns->queue);
> +	blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);

eh, what if QUEUE_FLAG_SAME_FORCE was already enabled before 
nvme_enable_ns_latency_sampling()?

> +
> +	/*
> +	 * Ensure that we wait until completion side samplings (if any sneaked
> +	 * in after we clear NVME_NS_PATH_STAT) are all scheduled before we
> +	 * start cancelling those.
> +	 */
> +	synchronize_srcu(&head->srcu);
> +	nvme_cancel_ns_latency_weight_work(ns);
> +	nvme_reset_ns_latency_stat(ns);
> +	return changed;
> +}
> +
>    bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>    {
>    	struct nvme_ns_head *head = ns->head;
> @@ -251,6 +533,10 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>    			changed = true;
>    		}
>    	}
> +
> +	if (nvme_disable_ns_latency_sampling(ns))
> +		changed = true;
> +
>    	return changed;
>    }
>    
> @@ -268,6 +554,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>    	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>    }
>    
> +int nvme_alloc_ns_stat(struct nvme_ns *ns)

Surely "mpath" should be in the name, no? It seems that every other 
public API in multpath.c has "mpath" in the name.

> +{
> +	int i, cpu;
> +	struct nvme_path_lat_work *work;
> +	gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
> +
> +	if (!ns->head->disk)
> +		return 0;
> +
> +	ns->path_lat = __alloc_percpu_gfp(NVME_NUM_STAT_GROUPS *
> +				sizeof(struct nvme_path_lat),
> +				__alignof__(struct nvme_path_lat), gfp);
> +	if (!ns->path_lat)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
> +			work = &per_cpu_ptr(ns->path_lat, cpu)[i].work;
> +			work->ns = ns;
> +			work->op_type = i;
> +			INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void nvme_mpath_set_ctrl_paths(struct nvme_ctrl *ctrl)

what do you mean by "set" here?

> +{
> +	struct nvme_ns *ns;
> +	int srcu_idx;
> +
> +	srcu_idx = srcu_read_lock(&ctrl->srcu);
> +	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
> +				srcu_read_lock_held(&ctrl->srcu))
> +		nvme_enable_ns_latency_sampling(ns);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
> +}
> +
>    void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>    {
>    	sector_t capacity = get_capacity(head->disk);
> @@ -280,6 +605,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>    				 srcu_read_lock_held(&head->srcu)) {
>    		if (capacity != get_capacity(ns->disk))
>    			clear_bit(NVME_NS_READY, &ns->flags);
> +
> +		nvme_reset_ns_latency_stat(ns);
>    	}
>    	srcu_read_unlock(&head->srcu, srcu_idx);
>    
> @@ -404,6 +731,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>    	return found;
>    }
>    
> +static inline bool nvme_state_is_live(enum nvme_ana_state state)
> +{
> +	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
> +}
> +
> +static struct nvme_ns *nvme_latency_path(struct nvme_ns_head *head,
> +		unsigned int op_type)
> +{
> +	struct nvme_ns *ns, *start, *found = NULL;
> +	struct nvme_path_lat_stat *stat;
> +	u32 weight;
> +	int cpu;
> +
> +	cpu = get_cpu();
> +	ns = READ_ONCE(*this_cpu_ptr(head->latency_path));
> +	if (unlikely(!ns)) {
> +		ns = list_first_or_null_rcu(&head->list,
> +				struct nvme_ns, siblings);
> +		if (unlikely(!ns))
> +			goto out;

out: checks found, which is always NULL. You could add another label 
after the found check at out: and goto that label to avoid the 
unnecessary check.

> +	}
> +found_ns:
> +	start = ns;
> +	while (nvme_path_is_disabled(ns) ||
> +			!nvme_state_is_live(ns->ana_state)) {
> +		ns = list_next_entry_circular(ns, &head->list, siblings);
> +
> +		/*
> +		 * If we iterate through all paths in the list but find each
> +		 * path in list is either disabled or dead then bail out.
> +		 */
> +		if (ns == start)
> +			goto out;
> +	}
> +
> +	stat = &this_cpu_ptr(ns->path_lat)[op_type].stat;
> +
> +	/*
> +	 * When the head path-list is singular we don't calculate the
> +	 * only path weight for optimization as we don't need to forward
> +	 * I/O to more than one path. The another possibility is when the
> +	 * path is newly added, we don't know its weight. So we go round
> +	 * -robin for each such path and forward I/O to it.Once we start
> +	 * getting response for such I/Os, the path weight calculation
> +	 * would kick in and then we start using path credit for
> +	 * forwarding I/O.
> +	 */
> +	weight = READ_ONCE(stat->weight);
> +	if (!weight) {
> +		found = ns;
> +		goto out;
> +	}
> +
> +	/*
> +	 * To keep path selection logic simple, we don't distinguish
> +	 * between ANA optimized and non-optimized states. The non-
> +	 * optimized path is expected to have a lower weight, and
> +	 * therefore fewer credits. As a result, only a small number of
> +	 * I/Os will be forwarded to paths in the non-optimized state.
> +	 */
> +	if (stat->credit > 0) {
> +		--stat->credit;
> +		found = ns;
> +		goto out;

this goto is superfluous

> +	} else {
> +		/*
> +		 * Refill credit from path weight and move to next path. The
> +		 * refilled credit of the current path will be used next when
> +		 * all remainng paths exhaust its credits.
> +		 */
> +		weight = READ_ONCE(stat->weight);
> +		stat->credit = weight;
> +		ns = list_next_entry_circular(ns, &head->list, siblings);
> +		if (likely(ns))
> +			goto found_ns;
> +	}
> +out:
> +	if (found) {
> +		stat->sel++;
> +		WRITE_ONCE(*this_cpu_ptr(head->latency_path), found);
> +	}
> +
> +	put_cpu();
> +	return found;
> +}
> +
>    static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
>    {
>    	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
> @@ -464,6 +877,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
>    		unsigned int op_type)
>    {
>    	switch (READ_ONCE(head->subsys->iopolicy)) {
> +	case NVME_IOPOLICY_LATENCY:
> +		return nvme_latency_path(head, op_type);
>    	case NVME_IOPOLICY_QD:
>    		return nvme_queue_depth_path(head);
>    	case NVME_IOPOLICY_RR:
> @@ -754,6 +1169,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>    	if (!nvme_is_unique_nsid(ctrl, head))
>    		return 0;
>    
> +	head->latency_path = alloc_percpu_gfp(struct nvme_ns*, GFP_KERNEL);
> +	if (!head->latency_path)
> +		return -ENOMEM;
> +
>    	blk_set_stacking_limits(&lim);
>    	lim.dma_alignment = 3;
>    	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
> @@ -762,8 +1181,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>    		lim.features |= BLK_FEAT_ZONED;
>    
>    	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
> -	if (IS_ERR(head->disk))
> +	if (IS_ERR(head->disk)) {
> +		free_percpu(head->latency_path);
>    		return PTR_ERR(head->disk);
> +	}
>    	head->disk->fops = &nvme_ns_head_ops;
>    	head->disk->private_data = head;
>    
> @@ -819,6 +1240,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>    	}
>    	mutex_unlock(&head->lock);
>    
> +	mutex_lock(&nvme_subsystems_lock);

I am curious - why use the nvme_subsystems_lock?

> +	nvme_enable_ns_latency_sampling(ns);
> +	mutex_unlock(&nvme_subsystems_lock);
> +
>    	synchronize_srcu(&head->srcu);
>    	kblockd_schedule_work(&head->requeue_work);
>    }
> @@ -867,11 +1292,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
>    	return 0;
>    }
>    
> -static inline bool nvme_state_is_live(enum nvme_ana_state state)
> -{
> -	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
> -}
> -
>    static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>    		struct nvme_ns *ns)
>    {
> @@ -1049,10 +1469,12 @@ static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
>    
>    	WRITE_ONCE(subsys->iopolicy, iopolicy);
>    
> -	/* iopolicy changes clear the mpath by design */
> +	/* iopolicy changes clear/reset the mpath by design */
>    	mutex_lock(&nvme_subsystems_lock);
>    	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>    		nvme_mpath_clear_ctrl_paths(ctrl);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
> +		nvme_mpath_set_ctrl_paths(ctrl);

Do we need to have separate loops to call nvme_mpath_clear_ctrl_paths() 
and nvme_mpath_set_ctrl_paths()?

>    	mutex_unlock(&nvme_subsystems_lock);
>    
>    	pr_notice("subsysnqn %s iopolicy changed from %s to %s\n",
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 8a9ec502912d..3c82f67f8926 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -28,7 +28,9 @@ extern unsigned int nvme_io_timeout;
>    extern unsigned int admin_timeout;
>    #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
>    
> -#define NVME_DEFAULT_KATO	5
> +#define NVME_DEFAULT_KATO			5
> +#define NVME_DEFAULT_LATENCY_EWMA_SHIFT		3
> +#define NVME_DEFAULT_LATENCY_BATCH_TIMEOUT	(15 * NSEC_PER_SEC)
>    
>    #ifdef CONFIG_ARCH_NO_SG_CHAIN
>    #define  NVME_INLINE_SG_CNT  0
> @@ -483,6 +485,7 @@ enum nvme_iopolicy {
>    	NVME_IOPOLICY_NUMA,
>    	NVME_IOPOLICY_RR,
>    	NVME_IOPOLICY_QD,
> +	NVME_IOPOLICY_LATENCY,
>    };
>    
>    struct nvme_subsystem {
> @@ -527,6 +530,30 @@ enum nvme_stat_group {
>    	NVME_NUM_STAT_GROUPS
>    };
>    
> +struct nvme_path_lat_stat {
> +	u64 nr_samples;		/* total num of samples processed */

why u64 and not unsigned long long?

> +	u64 nr_ignored;		/* num. of samples ignored */
> +	u64 slat_ns;		/* smoothed (ewma) latency in nanoseconds */
> +	u64 score;		/* score used for weight calculation */
> +	u64 last_batch_ts;	/* timestamp when last time avg. latency is calculated */
> +	u64 sel;		/* num of times this path is selcted for I/O */
> +	u64 batch;		/* accumulated latency sum for current window */
> +	u32 batch_count;	/* num of samples accumulated in current window */
> +	u32 weight;		/* path weight */
> +	u32 credit;		/* path credit for I/O forwarding */
> +};
> +
> +struct nvme_path_lat_work {
> +	struct nvme_ns *ns;		/* owning namespace */
> +	struct work_struct weight_work;	/* deferred work for weight calculation */
> +	int op_type;			/* op type : READ/WRITE/OTHER */
> +};
> +
> +struct nvme_path_lat {
> +	struct nvme_path_lat_stat stat;	/* path statistics */
> +	struct nvme_path_lat_work work;	/* background worker context */
> +};
> +
>    /*
>     * Anchor structure for namespaces.  There is one for each namespace in a
>     * NVMe subsystem that any of our controllers can see, and the namespace
> @@ -578,6 +605,8 @@ struct nvme_ns_head {
>    	unsigned int		delayed_removal_secs;
>    	atomic_long_t		io_requeue_no_usable_path_count;
>    	atomic_long_t		io_fail_no_available_path_count;
> +	struct nvme_ns * __percpu	*latency_path;
> +
>    #define NVME_NSHEAD_DISK_LIVE		0
>    #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
>    #define NVME_NSHEAD_CDEV_LIVE		2
> @@ -606,6 +635,7 @@ struct nvme_ns {
>    	enum nvme_ana_state ana_state;
>    	u32 ana_grpid;
>    	atomic_long_t failover;
> +	struct nvme_path_lat __percpu *path_lat;
>    #endif
>    	atomic_long_t retries;
>    	atomic_long_t errors;
> @@ -620,6 +650,7 @@ struct nvme_ns {
>    #define NVME_NS_READY			4
>    #define NVME_NS_SYSFS_ATTR_LINK	5
>    #define NVME_NS_CDEV_LIVE		6
> +#define NVME_NS_PATH_STAT		7
>    
>    	struct cdev		cdev;
>    	struct device		cdev_device;
> @@ -1100,6 +1131,8 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
>    void nvme_mpath_remove_disk(struct nvme_ns_head *head);
>    void nvme_mpath_start_request(struct request *rq);
>    void nvme_mpath_end_request(struct request *rq);
> +int nvme_alloc_ns_stat(struct nvme_ns *ns);
> +void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns);
>    
>    static inline void nvme_trace_bio_complete(struct request *req)
>    {
> @@ -1130,6 +1163,13 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
>    		return true;
>    	return false;
>    }
> +static inline void nvme_free_ns_stat(struct nvme_ns *ns)
> +{
> +	if (!ns->head->disk)
> +		return;

this check is not strictly required, as if ns->head->disk == NULL, the 
ns->path_lat == NULL and free_percpu() can handle NULL.

> +
> +	free_percpu(ns->path_lat);
> +}
>    #else
>    #define multipath false
>    static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
> @@ -1221,6 +1261,16 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
>    {
>    	return false;
>    }
> +static inline void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns)
> +{
> +}
> +static inline int nvme_alloc_ns_stat(struct nvme_ns *ns)
> +{
> +	return 0;
> +}
> +static inline void nvme_free_ns_stat(struct nvme_ns *ns)
> +{
> +}
>    #endif /* CONFIG_NVME_MULTIPATH */
>    
>    int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
> -- 
> 2.53.0
> 


