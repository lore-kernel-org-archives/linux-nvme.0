Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB84D743DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oc8E2ERPqnAvCT6DapZtb6VC/fZSc4FxbOiCweP6pG4=; b=lrmDIrA9YaIrcoofBwW5tiu0HL
	62S7D4SaiIOn5l8gLyRb2pEcv2ojN5qdPKjXGnKu6L1WvwPBu4+Ibjvhv1xH8LuDSEuokqINZeDl7
	YDIhtB4lEz5/aRVK7ppv6M3y/gH1UTr4tgJtbN0EsibkzEE4aM08ub8z3VRi5TTy1AqVStBHB+M8v
	rxBm7IqFIrrfYNYqEVtgceasA/k8Pjh+Ci+DuDhOPd35zv5rrF+QNjl30O2Zj66nlW5zHAEaz9j4D
	N5Z22+vdoEH8RoEGroN8PXVDoODms4C569YWRYt1Aw3wK4XnVu4fqb20p0G13gZU02V6qBL5yYygD
	0ouLIDXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDsM6-0000000GHXI-28eJ;
	Wed, 20 Nov 2024 21:35:22 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDsM3-0000000GHVL-3v64
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 21:35:21 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKMaAK014481;
	Wed, 20 Nov 2024 21:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=oc8E2
	ERPqnAvCT6DapZtb6VC/fZSc4FxbOiCweP6pG4=; b=eflEmM0cDcECx4j0zEzh/
	/9BOC8lErat94QDoqVZJiW4fyK084pqL0ozns4OK5v6NWoiieScJ1iE10RrF3Qbw
	Bv/qj2dzaYmFh4J2sjs2Nr7x4Yyum6dXpZNtVFn3PbUv0cSSNrred3/enbU8qZJr
	7OT8Jp6GubCD7uYuxdhGggP4osRE0sxWENM0BgwRYQ8AEnIa7OGr47QfXGK8qMq5
	SPezsAm637LUXs8i65FnvUsjKQYAIME2iLSFP9EQgmdVUyV5vPNmpLNrsgedbuHx
	Q5dalG33PuWwartjffIZR+asJ2NSaX+Xsvk109g4OtNwhBdyDLu1e3b7w902MKuH
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0srdmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 21:35:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKL5ND007706;
	Wed, 20 Nov 2024 21:35:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuarj4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 21:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT6kHtS6q6MrY3NyYQRIutnvC0pLDQ9VKl0L9QCkLkA7domAHyISZM2Xe/TK1pNKFRc1QM1PJYaRehob0w2e1LzmVe63rAL1Wjj9kJJoQAvvEQGSzUfvZ/ozauds0EVP/d4Mq02aFYkO9p91x/15mdUGL79zAh54ufTPSTy/3fTvVF4KiYS9IqvfBDvTBNIC9zp1yodRhCnAJ7tX9s9uGnybt/rrDDAEER2NmqjQRfS461HtUFcdDa9gucxCbBOgRUTmpWW7CwJVCWnWx6alMfq1mnfsKMvTWS0xDB39c2IK0i/yneNUrA+eB4/XmAUkcQ388yzcVJOtrGBO7RLndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc8E2ERPqnAvCT6DapZtb6VC/fZSc4FxbOiCweP6pG4=;
 b=tsFalySbCpMxZ572OAtLHkjP6Xh5ylWlCSPBFQ/jACDEeVAAo+Vckx8yaTdP88icz0Q3e+q1e4QZ+5G9jb8FdgiaLwrPbO1xDfkE5GRrg47W+1NZAkmJBt20W8pnbyQhQ1GXMwF615O3KUJWyuiIfQWigBUs5a6QhYLTPADn7cyqb367k5WzR5Fe+YccuVB5e0ZWMsUaPKFvym9SB1UVpOiK71Qa8ROHsQqe/3UFtWwGaXgqARI06H4ejF4uKFD+ep2xa6Uq6/Fd+OiJIqH1POpdO37i2jQOtAOP/ICLkgui4yepJrSzoCgFkHRqtqzGoqEZX9KGh82OtYN1W0M5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc8E2ERPqnAvCT6DapZtb6VC/fZSc4FxbOiCweP6pG4=;
 b=SwbmBpH9kCBrG30V7Ma/ExnqMDJrbgumJ3WZ2bDgO+ZBbjXrom7OwUh4Ezy7wE5Obm9DbMyuPpqftYwKc0PcpBIRM/lvl8OcwzvHBBWhvctIACz2tDHQoxdULMl05s3ipZaH5UBz12SVdWNeps1lWviZV4VOL91rma92emOxxqE=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 21:35:05 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 21:35:05 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Paul Webb
	<paul.x.webb@oracle.com>
Subject: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
Thread-Topic: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
Thread-Index: AQHbO5QQ9DTUqPPC80KBpz/0L4RKDA==
Date: Wed, 20 Nov 2024 21:35:05 +0000
Message-ID: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|SA0PR10MB6425:EE_
x-ms-office365-filtering-correlation-id: 96203a87-b835-4130-e0c0-08dd09ab32c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEV5MmRSUnVwQUhCMXdrdW9CVDMxdUFXMHhTUFkvQWI0RlNuTkVlWWtEUEU5?=
 =?utf-8?B?NnFPc3l4ZW8xVjlMVjk4RGVKdG1wMjN3U3pUck9kcUJBbndwSTY5UjE2b0pp?=
 =?utf-8?B?d2dXNUxaSW54RHFSZkZNVTFhazEzSEsza2JHUVFyOGMySDQ0VmVoVFNuS1Fs?=
 =?utf-8?B?L3NJb0dyTHdYR1NBc2JQOHRaMHYxWjdySFRKeFIzREo1NDZqYkFMWUd0dkc5?=
 =?utf-8?B?dkFLaHdJNHd5eGtsN1RyeVNxZFdYRUUxcWhEMFFzTnNyN01hUnlFRURoN1pK?=
 =?utf-8?B?cEZQMnM0Z2NQNXg2LzEwK2tsTkVIdVNBUXpVdnBUWVFxdzhDRm9icG9ONkR5?=
 =?utf-8?B?aUNrTDNVYUNYeDNta0pHN2RKS3JUaVU1NDRxMjFUenQ1V0h0M25lQ0Q5RG5Q?=
 =?utf-8?B?ajY0OVJ2aWUvNnl5ZEMzSXdPMGdYY0hGSmtDeHhOWTJSbTZqTXhOcDFGSWhN?=
 =?utf-8?B?Tkh0Z0ZrWlAxV2tpZkEwS3RaclZqOG1zbCtLU2xjbVc4aE96WmpkbkhUU3NN?=
 =?utf-8?B?bVpSejlFeVh3RnJKdTdvWTZpTEpiY2xjQ0ZldEQybGZRVUQrRzlPamNURWhh?=
 =?utf-8?B?QXd2N0kvbnVoWEcvdHpwS295NDhJK3QyM3lYK0c5UVdGcVFlNWIzbGRxYnpm?=
 =?utf-8?B?L2E3Q3JCNnVkcEJzc3FOU2tiQXVkaFQySXhjMlNjaXRUU3NmTklETVJwWUlY?=
 =?utf-8?B?KzFpaU5VSUYvVGxKNnI3dEVEYk1qamdjOVduR2t0SFBKa2VLdk4rKzd5SThX?=
 =?utf-8?B?OEEyRTVZOW0yMXlxc1E0d1gvYjBmV3lqeVRnTGwwOEVqQ0RNRGJGQTZlNXox?=
 =?utf-8?B?bmRKTGtLZUd3OWlTTHpidDZEaTczclhzYkM0TE9ORXFnSFRwL00vTFF3N1E3?=
 =?utf-8?B?Ykx5VUltQmFveGZ1QWlLNmlla3EvNWV3NGNFZGxxK2prcmdLT3RLZmFnSWJE?=
 =?utf-8?B?RzhmdEtZSzlHaWFOUk44MnpsTkpTN0p5Mm45cGhKRVJPV2ZZa0lZRFExVFNY?=
 =?utf-8?B?TVI3REtWdEFRMHJ3L2Z4Mm01MThLV2FpYmNrM3B4VGhHZFVJa3dEK2ZHV2Zl?=
 =?utf-8?B?UGZxWm9YY3YzQy8xL24zM1grYVE3a1VsSEdQd2xsN1JDUG1NKzFBaXhkMkpC?=
 =?utf-8?B?Nk1FS09sRy9lMWlZc2pyS0hGWFQ5Y0daOUw2UUJPVkFJV0VFcWEyOFlWNTVp?=
 =?utf-8?B?bGVoSmRoQ2FGbkxGeTFjcWJZS2lLZ2pRZ2NzR2NLb0V4bWJOTW4ydGhxQUdR?=
 =?utf-8?B?c1VjOWh2NGNsanFtVVpHME00Q0ViMlFFUjdXQ1ZNb2d2R0FZb1ZzTDIyYzNT?=
 =?utf-8?B?YlBZMUFaTDFVZHRrU2ExYU5qVitsSzdKZXlWQlJmbnBCVnhsRXBLTXVLTC9h?=
 =?utf-8?B?UG13R2xBUnRQcmNMaXFGbzVGMHF1bWZHOVlMbzdzREtnT2huc055dWxyWkdt?=
 =?utf-8?B?ZjRlSkdORlZyRlNoM3F6Z0dnY2krdUF1bUJaek1tM2xPNlVaUDQyY2JJM0d6?=
 =?utf-8?B?SFdoOGVXM2xvVDJMdEp6eExZOWhLMk52WUxzak43T09mQ21CRzgwbTd5L2Qr?=
 =?utf-8?B?Qlo0WkVkaklxL3FRUEVONm44VzJUeExpNzlmWkw5d2JJQnh4b211V0QzM3BY?=
 =?utf-8?B?Mm4vMEpIUExxOFpFVWRsMVJkYi96Vzd6Q0Yva2xEVDU2WFJ2QVNhcFJVVng1?=
 =?utf-8?B?TVdkZTVTaWJucE5wdHRPYW1vNXZ3SFNkSjU5ZG1nU1V3RWhPQk02U21sQmxM?=
 =?utf-8?B?U29TWGZWNC9udFdmQzZGYUFwUzB1Z3pZT0dzNVBreTR4MVdNYVRyOWZIQU4v?=
 =?utf-8?Q?P8hz+VB8u3U7tiJYCOGmAnapBvusgsYmpt8UM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2hUR3V2WStyM2pIV3pRQ3BPNUN3VGxoNjBnRFJvbWg1bnp1QnhOK3pFMEdS?=
 =?utf-8?B?MUZ4bkNEV0RYVlU4dDl2V2FsdldQNVQ0bzhOekJ0RDAvZ1lJZ2IyTlVhUHdF?=
 =?utf-8?B?L1pQZmg3eWFLb3RKbVU2RjYvNHRBZ0cwcGZER3hqSE1RaW5VVGhuR2RjMG5h?=
 =?utf-8?B?VXBSTlRBQ2hZZFF0eGQyN0lyQVZCUHlSZE5JaEgzV1R0K1NEWGJIUWJaMnNS?=
 =?utf-8?B?Zks0aUVwc2NTZnhaS2dCSzdHSzNDbHlSZUttK1NNMUMwWjUvazlaSlVsQnQ3?=
 =?utf-8?B?cnpGUk90Rk5ZZ1dmZEQvcXluQVRINkV0LzNOdXlUcXhIbEJKY2kzZG1ldHZC?=
 =?utf-8?B?c2xpTGR0d0JpQVJFdFhIQklBdXMxeXlLM3dpZk13M01obGd3d1BzZTEvVXFZ?=
 =?utf-8?B?aWxEbDRPbmZyR3NwV0twUkU3RFlGTDYyWmxDeHFVNGlYQUlEeEdOU0VKcUZW?=
 =?utf-8?B?UzBxeFBkNUU4bnhjcGN6S2JISUdWVUZWTGFUSitQVlZGVXF5S1l4NmNVZmtS?=
 =?utf-8?B?K3J6VkVYcnZMc3diTXBSc2RTZStxY0J6ZmtLYjZERlVOYjZDMmlXSVp3aE9D?=
 =?utf-8?B?WGs2K3BHL3lRL0Y5WXFscEZsMDI0Z21HTlJYV0xUblRLYmFzRGp4blU0SjZG?=
 =?utf-8?B?TTl3MFRqaWNpZ20vOVJ5ZjNQNWpEZlZ4a1EwdUNEdWpIeUE2Vit0QnNPdm5E?=
 =?utf-8?B?K3R6d2dmOGhCbmp3aXdBdDZPcjVRR2ZMN1RtckdtbkFHSllqTUVzTXVHNmFu?=
 =?utf-8?B?bUwySDdiaGxDZ2F5Nit5REJhVW1KMndXMXBnTGdNdDB0ZjZ3RGx2TzJQTEY1?=
 =?utf-8?B?ZUZrR2hidkpVb3YwUUdBbDdxZUE4R1hFbUU5a1ZPYzM5UUIwWDJuVGNYYXFp?=
 =?utf-8?B?N2dBN2NSQ0FTZWttdVNDWCtjUERaZ3VVZldYT3VvVUNkaVo1MHZxRlo5MmZs?=
 =?utf-8?B?UUNic1hjc2VBQVl4L2VieC9hSGRvclNMclhnUlFvQXgwZC9McllSRVZYSGZ6?=
 =?utf-8?B?WGpWSVpkVkJ5dmVsK2FUYU1ieGtQalgyOFRGNmJxcnA5SXljOVllQkx6b1V5?=
 =?utf-8?B?WU50b3o0N3FyQkZnTG5LMm5Zc25HckVhODQzbmNOaGp3OHF5d2JRZ0FmSnZ0?=
 =?utf-8?B?ZDNiMkZwRmlaVkhyYmVoQkp3ZTZIeHBTVXpUV1VobUl4VmdxY3pCbkY2ZFh4?=
 =?utf-8?B?cFp1cUJja3VyMmFRWFdkWTd5UlNScWx2c01CQWNQVHdFVURwZXhQU2hiNm9l?=
 =?utf-8?B?QW9zSE8xVWQ0V2ZLNEhYeDVVeTR0eERZWDhTdkc4ZXlCNWhKT0RkOFlodmZ3?=
 =?utf-8?B?QlA0bE1HY2wrN28xUk1zSDdpZlM4ZVp0OVE5NHFOeTA3K0k2N2FrbnhYT1FX?=
 =?utf-8?B?RWl2Y1Z2ZklEMHU1dVR6NlEweVFxQTRhSlJpSHR5bjJRVzVtcFFLZTVUUlZL?=
 =?utf-8?B?cGxJQlJlTXBqZmtyS2xtWTNaVlFQU3dJZHl5Z3pZNlB0MXFSWGZpdU12RXFH?=
 =?utf-8?B?eTJVdHAwVzdYejNqSWozZWt1YXZmdzBDNHU2SCtDTXk3SktoemtkZjV2aUNx?=
 =?utf-8?B?c24zYkkrTUM3dTRPd2EvcEhmVU5VM3NVQmJSU05ITWVQRXM1ODk3R2xoZDQz?=
 =?utf-8?B?UmNNakJORjhzRFkvbjRTMHhJSXpienBpNmJBS2Q2U0dFeTl3ZkJ0b0FhRGlF?=
 =?utf-8?B?TCs0VUpyWm02cnBWNlM1UUQva1YwMHB2MXc5VTBia2JyNlJxZnIzZExSd2la?=
 =?utf-8?B?NnFNN3BlVFh4U2pVNktTNHhZdk5rSkNDQjRIbjQ2aTJ1Vi9BV1BVMUtySW9j?=
 =?utf-8?B?dVZPT2dBTDRWclZlL09EeFNYcFVyUVBGZSs5ZnlUaU8wM29GMXhiN3A0OW43?=
 =?utf-8?B?b0tSTWVqcGVWc2E2TmszR082d0FLVWY5QUkxcUQ3TWgvem5aTDNRemZRZjNF?=
 =?utf-8?B?N2lyMWZlK2x1dDE3bnB1L011aVlhQ3BTU0JwYXN4WjBPOWhZeXh5ZWMvbi90?=
 =?utf-8?B?d2hFMGtXRjFNNzJqVDJZaFRNdVNPYzJSLzlmenI4aG9zMmtJOXhiWDZBdFhy?=
 =?utf-8?B?U3k5Z1N4aENwSW5YaXFFa3BXaGgvTWVDTE9vSE9DLzdleUZLTi9XTHRRcCtj?=
 =?utf-8?B?QkV2amYxUXc0eS9UUVJUTXoxODlGUmd5a3czbDZMVDBCWGVOQ3ZjWmpvdUxy?=
 =?utf-8?Q?HOGe4IcuVCtygDXYnXUGqK8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21EE00DABE82C84088FBACE85A4FB9CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rtJf8XSaKT3I2Jj8yfeJb1SHihELGcI37wvPZfYNeCi3N1gaEYksiXoaaeDZpTfoHAryA3u9EHGjxO0M8N1a1wZy8KnT4nJwI0p4ShzoZeaFQ4bXOot3Y72F7PqsmMoHIb+rJ7uAAhX2C6p/sTcKij03/jdG5ArJdodofIJLTa9IU+GIycGTG/GDRs4Zwkxd5MkHY6zCE7LLEV+Cpuug0UR4WQTZwke0eaQcx00DbQd7HdiX2oDb3hHqsHh5jpBXvxm5ilwFAfTMs+Lc2OXj2Hjm61oWLrtkM62oC0lIffxPn7MTGN2kZrvRZ7NY+Tu+mREPKh2vhsB8salGJ8ASp7/O0X4Mgs/8YKW1cz6oy5xYhO9I3lEpXkjmeY7QHyiQjDCqM/hnUxXsM9sIJZY5FCj8eTTANJycS1S0fDooQxLgtoTEu1buHWaH2W0MXkInQXwfjM6EJJ4bVElwSRIak78MrEJ4j3T9N25W2J7iweuk1SVwkSyTkntQzN+XYH2QyWXTsNwXbA4FD3RXmuJZfdFHrtjImRNRdV5nW8Vqhjr78U7k/VvcrumvqHvTfq3ISBvgjWRkrlALCwOkPBnrafz8rP8+9yRt2cszsCKiKTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96203a87-b835-4130-e0c0-08dd09ab32c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 21:35:05.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwMDeEH2z4haVTmtl0//o75X2m8lXCKso2zfol8uJ0ulE224LOz7jolHs3mKc/G8jgmQSTbXh0IrVHk6llr2N87/HxaxphWDJYA5ZHl0p+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_18,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200153
X-Proofpoint-ORIG-GUID: vkIeIXLh_cS3OjU2WSD_NgetjpuIjwgP
X-Proofpoint-GUID: vkIeIXLh_cS3OjU2WSD_NgetjpuIjwgP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_133520_463585_E1145543 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

SGksDQoNCknigJltIHJlcG9ydGluZyBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gb2YgdXAgdG8g
OS0xMCUgd2l0aCBGSU8gcmFuZG9td3JpdGUgYmVuY2htYXJrIG9uIGV4dDQgY29tcGFyaW5nIDYu
MTIuMC1yYzIga2VybmVsIGFuZCB2NS4xNS4xNjEuIEFsc28sIHN0YW5kYXJkIGRldmlhdGlvbiBh
ZnRlciB0aGlzIGNoYW5nZSBncm93cyB1cCB0byA1LTYlLg0KDQpCaXNlY3Qgcm9vdCBjYXVzZSBj
b21taXQNCj09PT09PT09PT09PT09PT09PT0NCi0gY29tbWl0IDYzZGZhMTAwNDMyMiAoIm52bWU6
IG1vdmUgTlZNRV9RVUlSS19ERUFMTE9DQVRFX1pFUk9FUyBvdXQgb2YgbnZtZV9jb25maWdfZGlz
Y2FyZOKAnSkNCg0KDQpUZXN0IGRldGFpbHMNCj09PT09PT09PQ0KLSByZWFkd3JpdGU9cmFuZHdy
aXRlIGJzPTRrIHNpemU9MUcgaW9lbmdpbmU9bGliYWlvIGlvZGVwdGg9MTYgZGlyZWN0PTEgdGlt
ZV9iYXNlZD0xIHJhbXBfdGltZT0xODAgcnVudGltZT0xODAwIHJhbmRyZXBlYXQ9MSBndG9kX3Jl
ZHVjZT0xDQotIFRlc3QgaXMgb24gZXh0NCBmaWxlc3lzdGVtDQotIFN5c3RlbSBoYXMgNCBOVk1l
IGRpc2tzDQoNCg0KNS4xNS55IGJhc2UNCj09PT09PT09DQpmaW8udGVzdDogKGc9MCk6IHJ3PXJh
bmR3cml0ZSwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkItNDA5NkIsIChUKSA0MDk2Qi00
MDk2QiwgaW9lbmdpbmU9bGliYWlvLCBpb2RlcHRoPTE2DQouLi4NCmZpby0zLjM1DQpTdGFydGlu
ZyAxMjggcHJvY2Vzc2VzDQpmaW8udGVzdDogTGF5aW5nIG91dCBJTyBmaWxlICgxIGZpbGUgLyAx
MDI0TWlCKQ0K4oCmW2N1dCBoZXJlXQ0KZmlvLnRlc3Q6IExheWluZyBvdXQgSU8gZmlsZSAoMSBm
aWxlIC8gMTAyNE1pQikNCg0KZmlvLnRlc3Q6IChncm91cGlkPTAsIGpvYnM9MTI4KTogZXJyPSAw
OiBwaWQ9NDIyNjogRnJpIFNlcCAxMyAwMDozNDowNyAyMDI0DQp3cml0ZTogSU9QUz0yNTUwaywg
Qlc9OTk2Mk1pQi9zICgxMC40R0IvcykoMTcuMVRpQi8xODAwMDA2bXNlYyk7IDAgem9uZSByZXNl
dHMNCmJ3ICggTWlCL3MpOiBtaW49IDUzMjYsIG1heD0xNTI4MywgcGVyPTEwMC4wMCUsIGF2Zz05
OTcyLjM1LCBzdGRldj0xMi4zNywgc2FtcGxlcz00NjA2NzINCmlvcHMgOiBtaW49MTM2MzQ5Miwg
bWF4PTM5MTI1NTIsIGF2Zz0yNTUyODk3Ljc0LCBzdGRldj0zMTY2LjQ4LCBzYW1wbGVzPTQ2MDY3
Mg0KY3B1IDogdXNyPTQuMDAlLCBzeXM9MTMuODElLCBjdHg9NDczMDUzNjAyNywgbWFqZj0wLCBt
aW5mPTcxMjI5DQpJTyBkZXB0aHMgOiAxPTAuMCUsIDI9MC4wJSwgND0wLjAlLCA4PTAuMCUsIDE2
PTEwMC4wJSwgMzI9MC4wJSwgPj02ND0wLjAlDQpzdWJtaXQgOiAwPTAuMCUsIDQ9MTAwLjAlLCA4
PTAuMCUsIDE2PTAuMCUsIDMyPTAuMCUsIDY0PTAuMCUsID49NjQ9MC4wJQ0KY29tcGxldGUgOiAw
PTAuMCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMSUsIDMyPTAuMCUsIDY0PTAuMCUsID49NjQ9
MC4wJQ0KaXNzdWVkIHJ3dHM6IHRvdGFsPTAsNDU5MDU5NDYwMCwwLDAgc2hvcnQ9MCwwLDAsMCBk
cm9wcGVkPTAsMCwwLDANCmxhdGVuY3kgOiB0YXJnZXQ9MCwgd2luZG93PTAsIHBlcmNlbnRpbGU9
MTAwLjAwJSwgZGVwdGg9MTYNCg0KUnVuIHN0YXR1cyBncm91cCAwIChhbGwgam9icyk6DQpXUklU
RTogYnc9OTk2Mk1pQi9zICgxMC40R0IvcyksIDk5NjJNaUIvcy05OTYyTWlCL3MgKDEwLjRHQi9z
LTEwLjRHQi9zKSwgaW89MTcuMVRpQiAoMTguOFRCKSwgcnVuPTE4MDAwMDYtMTgwMDAwNm1zZWMN
Cg0KRGlzayBzdGF0cyAocmVhZC93cml0ZSk6DQpkbS0wOiBpb3M9MC81MDA2ODQwNzMyLCBtZXJn
ZT0wLzAsIHRpY2tzPTAvMzg5MzY0NDM4OCwgaW5fcXVldWU9Mzg5MzY0NDM4OCwgdXRpbD0xMDAu
MDAlLCBhZ2dyaW9zPTAvMTI1MTEzNDgyOSwgYWdncm1lcmdlPTAvNzM3MDMzLCBhZ2dydGlja3M9
MC85NzMwMDkzODcsIGFnZ3Jpbl9xdWV1ZT05NzMwMDkzODcsIGFnZ3J1dGlsPTEwMC4wMCUNCm52
bWUzbjE6IGlvcz0wLzEyNTEwMzU1MDksIG1lcmdlPTAvODI5MDgzLCB0aWNrcz0wLzE0NDM3OTI0
NzksIGluX3F1ZXVlPTE0NDM3OTI0NzksIHV0aWw9MTAwLjAwJQ0KbnZtZTBuMTogaW9zPTAvMTI1
MTIzMTM0NCwgbWVyZ2U9MC82Mzg5OTMsIHRpY2tzPTAvMTAxMTc1NjAwMSwgaW5fcXVldWU9MTAx
MTc1NjAwMiwgdXRpbD0xMDAuMDAlDQpudm1lMW4xOiBpb3M9MC8xMjUxMjI0MTYyLCBtZXJnZT0w
LzYzOTE5MiwgdGlja3M9MC82NzI2ODg5NTIsIGluX3F1ZXVlPTY3MjY4ODk1MywgdXRpbD0xMDAu
MDAlDQpudm1lMm4xOiBpb3M9MC8xMjUxMDQ4MzAyLCBtZXJnZT0wLzg0MDg2NCwgdGlja3M9MC83
NjM4MDAxMTcsIGluX3F1ZXVlPTc2MzgwMDExNywgdXRpbD0xMDAuMDAlDQoNClRocm91Z2hwdXQg
UmVzdWx0czoNCldSSVRFOjEwNjQ5LjY6MjU1MDAwMDowDQoNCg0KNi4xMi55IHRlc3QNCj09PT09
PT09DQpmaW8udGVzdDogKGc9MCk6IHJ3PXJhbmR3cml0ZSwgYnM9KFIpIDQwOTZCLTQwOTZCLCAo
VykgNDA5NkItNDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9bGliYWlvLCBpb2RlcHRo
PTE2DQouLi4NCmZpby0zLjM1DQpTdGFydGluZyAxMjggcHJvY2Vzc2VzDQpmaW8udGVzdDogTGF5
aW5nIG91dCBJTyBmaWxlICgxIGZpbGUgLyAxMDI0TWlCKQ0K4oCmW2N1dCBoZXJlXQ0KZmlvLnRl
c3Q6IExheWluZyBvdXQgSU8gZmlsZSAoMSBmaWxlIC8gMTAyNE1pQikNCg0KZmlvLnRlc3Q6IChn
cm91cGlkPTAsIGpvYnM9MTI4KTogZXJyPSAwOiBwaWQ9NDMwODogRnJpIFNlcCAxMyAwODowMzoz
NyAyMDI0DQp3cml0ZTogSU9QUz0yMjcwaywgQlc9ODg2OE1pQi9zICg5Mjk5TUIvcykoMTUuMlRp
Qi8xODAwMDA2bXNlYyk7IDAgem9uZSByZXNldHMNCmJ3ICggTWlCL3MpOiBtaW49IDYsIG1heD0x
MzM0MywgcGVyPTEwMC4wMCUsIGF2Zz05MDY2Ljc4LCBzdGRldj0xNC4zMywgc2FtcGxlcz00NTEw
MDgNCmlvcHMgOiBtaW49IDE3NDMsIG1heD0zNDE1ODM5LCBhdmc9MjMyMTA2OS4zOCwgc3RkZXY9
MzY2OS4yMCwgc2FtcGxlcz00NTEwMDgNCmNwdSA6IHVzcj0zLjY1JSwgc3lzPTExLjI4JSwgY3R4
PTM0MjA1Nzc2MDIsIG1hamY9MCwgbWluZj0xMjY4Mg0KSU8gZGVwdGhzIDogMT0wLjAlLCAyPTAu
MCUsIDQ9MC4wJSwgOD0wLjAlLCAxNj0xMDAuMCUsIDMyPTAuMCUsID49NjQ9MC4wJQ0Kc3VibWl0
IDogMD0wLjAlLCA0PTEwMC4wJSwgOD0wLjAlLCAxNj0wLjAlLCAzMj0wLjAlLCA2ND0wLjAlLCA+
PTY0PTAuMCUNCmNvbXBsZXRlIDogMD0wLjAlLCA0PTEwMC4wJSwgOD0wLjAlLCAxNj0wLjElLCAz
Mj0wLjAlLCA2ND0wLjAlLCA+PTY0PTAuMCUNCmlzc3VlZCByd3RzOiB0b3RhbD0wLDQwODY1MTc1
NjIsMCwwIHNob3J0PTAsMCwwLDAgZHJvcHBlZD0wLDAsMCwwDQpsYXRlbmN5IDogdGFyZ2V0PTAs
IHdpbmRvdz0wLCBwZXJjZW50aWxlPTEwMC4wMCUsIGRlcHRoPTE2DQoNClJ1biBzdGF0dXMgZ3Jv
dXAgMCAoYWxsIGpvYnMpOg0KV1JJVEU6IGJ3PTg4NjhNaUIvcyAoOTI5OU1CL3MpLCA4ODY4TWlC
L3MtODg2OE1pQi9zICg5Mjk5TUIvcy05Mjk5TUIvcyksIGlvPTE1LjJUaUIgKDE2LjdUQiksIHJ1
bj0xODAwMDA2LTE4MDAwMDZtc2VjDQoNCkRpc2sgc3RhdHMgKHJlYWQvd3JpdGUpOg0KZG0tMDog
aW9zPTAvNDQwNDM4Mjc2NywgbWVyZ2U9MC8wLCB0aWNrcz0wLzM2MTQxMDQ0MTIsIGluX3F1ZXVl
PTM2MTQxMDQ0MTIsIHV0aWw9OTkuOTElLCBhZ2dyaW9zPTAvMTA5OTg0NzA0NiwgYWdncm1lcmdl
PTAvMTMwOTc1NywgYWdncnRpY2tzPTAvOTA4MDczMzMzLCBhZ2dyaW5fcXVldWU9OTA4MDczMzMz
LCBhZ2dydXRpbD04Mi4yOCUNCm52bWUzbjE6IGlvcz0wLzEwOTk4NDQ0NTMsIG1lcmdlPTAvMTMw
OTc3MCwgdGlja3M9MC82MDY5MTkxMjEsIGluX3F1ZXVlPTYwNjkxOTEyMSwgdXRpbD04Mi4yOCUN
Cm52bWUwbjE6IGlvcz0wLzEwOTk4NDcxMTAsIG1lcmdlPTAvMTMxMDEyMCwgdGlja3M9MC8xMDA3
MjYxNDY0LCBpbl9xdWV1ZT0xMDA3MjYxNDY0LCB1dGlsPTgwLjk3JQ0KbnZtZTFuMTogaW9zPTAv
MTA5OTg0NzA0MSwgbWVyZ2U9MC8xMzA5NDMwLCB0aWNrcz0wLzEzMjc5NzUzODYsIGluX3F1ZXVl
PTEzMjc5NzUzODYsIHV0aWw9ODEuNzElDQpudm1lMm4xOiBpb3M9MC8xMDk5ODQ5NTgzLCBtZXJn
ZT0wLzEzMDk3MDksIHRpY2tzPTAvNjkwMTM3MzYyLCBpbl9xdWV1ZT02OTAxMzczNjIsIHV0aWw9
ODAuMjklDQoNClRocm91Z2hwdXQgUmVzdWx0czoNCldSSVRFOjkyOTk6MjI3MDAwMDowDQoNCg0K
VGhhbmtzLA0KU2FlZWQNCg0K

