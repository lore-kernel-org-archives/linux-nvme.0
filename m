Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94792CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3EcXM5n8muiy2iT+0X0u2a8jYgwbcKwSndVOVDaYI4=; b=0rp8K1G3IHX6jgGZhhXlGbtEaJ
	dxvmX0hxG59w74i0QR7+fmKuMC862Bf5Wcp0tYBxO4dKahIsWYt4/gTCs944bisjDCmFZQxmDh1jx
	RXLVSsEm2SD/tzRaO7Zwv8HDjrXHuFd6AMit47mouvugKLYdQupmxl5ZnZkwxUrUGFIT5RdLtD/PQ
	L98FLm5wwxDzriMmewipjJiKvL37rqGlIDOxYrPvPIa/lEpq/T7e+sokHFZklhguAZLK19KjE3RvQ
	IMwMd8EDRwDMod70NEYMAtHlLN/CZcyuZiHh3XO4jChBtr/lZUNbefZVShS3k4ml3OnLV2jFNT4BY
	0cyWzg+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1OB-0000000AjKC-1naq;
	Fri, 26 Jun 2026 07:54:15 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1O8-0000000AjJl-0Hpi
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:54:14 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2wlXh2164280;
	Fri, 26 Jun 2026 07:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K3EcXM5n8muiy2iT+0X0u2a8jYgwbcKwSndVOVDaYI4=; b=
	TFo7FYxwzCdtZEZm9gsyKCDGe6LVBeye56MR/uY6S893WQGRRAMZDlu0H2iQ0+5T
	OBp7zspyzRcL52Z2TOxHAY0cyneddGKWsms0hPjTplGlzplcswjNiGLIPx77nfwd
	0E6Oa9dH4og7bIvn4p50jRmTO+FKa+FFlhdjqhGzrFFOKjc4Z0YERlyiNjGbSES9
	vfa2Vky2Cq25NapB2NOWdwP91+BsY3QTM9KT9StLCXRmNK8VArLmjLQrlubeq1zs
	zl/9YcucyuF2hhkpCQv4lvDNYAlE7f9RcMDV4GFOVMhTvaa/mCCqW2LLDjUMDErO
	twrtWAhtuhXaqj8B8Y4JXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjr7rgkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 07:54:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q7rBG0018508;
	Fri, 26 Jun 2026 07:54:02 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhag27p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 07:54:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0Cn8oq0Av9YwuRqT31zgwu54x6TmQRi7rIdZr9QlZNgMOlKKGmcpqD0S5/RFvhwGtgfFsFlzSBj8VMK+kkZVkzb4aPXARAMGcx+a7s2PNIQnZDV3wwgijKcHZeyeLC5nY6SQLIfo5PGae+m+5iHj9fTmtDHI4A5onSd5RnQ6NBdU5QVvbayYgrEzybwj6qMml2h4au6S9NualvY+kKfaf2qP6VZ18zvlUZZ+XZUf0R8FchwaHsp258hGoCD4H6atTZADceSdjhqppMP1SLZ1Yt7W662CFTf9k4sNbgHKLgp98S2ejBacOj98HOhZpK+Hrtj3ms4Buyn5TZHFTuGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3EcXM5n8muiy2iT+0X0u2a8jYgwbcKwSndVOVDaYI4=;
 b=K+1UnN7qWJuaMUTXvea1lcmB9dmSe8LDJXNYTojfhysTcft/sk4jM7P+XVNCLG+eLUf0HADr94uOj7a/+Qd0p7+YYSyXIsQiNW6oFeBDu/T9SKNnL492AjoRTECQYJiAvfnCfrdrCMrrwkYGdQMPNfMU2u/f5Cef5SW5RjKqoZcneTBzAjM9jFOZ4HuLKHneF7ORNAYsDT5PUwIsk6KsfMGlWNh6PTJe9q5kjFoxmGBmwNjXTqrvu1CHNCCEyV+7YIqHhdR2XhK/FLW3iLcpa1+ZidgE8TO/YrUabWNU5maKM43Cphh/h5dWYUlqrLPSrzztBoelCCAIonFNtLCcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3EcXM5n8muiy2iT+0X0u2a8jYgwbcKwSndVOVDaYI4=;
 b=Tz/i4/8uwjLn/r0ZizDDSbxMF6RswddxKccTPkaoA0UR6vkWwwKdPuqs9CDFEJ+Do3eA8uESBs/ZCPlzJ8Tumo7k/WDjvIBKU7ALF0gM0FGzGIy7GE5b+9/RZWEYLa8AP4EB5t13Z9403Vb1xKoDxSv5AE0HSkLM5kyd3K29B+E=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB5015.namprd10.prod.outlook.com
 (2603:10b6:408:126::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 07:53:59 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 07:53:59 +0000
Message-ID: <fd0463a0-a94e-413f-a2e5-3a7494ab2179@oracle.com>
Date: Fri, 26 Jun 2026 08:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: Avoid C=1 warning in
 nvme_auth_derive_tls_psk()
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20260625175911.35094-1-ebiggers@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260625175911.35094-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: c482605a-8495-41b3-f73b-08ded35814db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: PCBpf3/ik5XVok17S16zP/ItKt3M89S4hqm1kbs1Yh/1fzGan2As/5CFAUWv3+X9zE3CS2RgrVL7jcuskQSSDsfjatWHfK9MX1UeAqjLv2n4N+TdsMdHK3JdkrlozWV+6EAeOH8WD4mrqCTWyg+3oecqlFJ/CDi+IGdN8SfGqtUM0S+UUz+zitX0j/xQsd5ocuEA/d2+D2o+k/hRoC1+LA2GhWlFFKZxCBN3Z4JcYToMf2tmsMsWKm+pgSDoH2PzOEDQMik1SJrfQ78DOUGamYrGyzBEMuo8iDHgxsbBr0/pGdJf1hixQHbb7pHyLc/9ZuzIitnOLUNWJMPexlt47CIlErt7cGqrHLSFIsYFBWHJ6yaeENSzopr3aZ9+ziMQqlpEejVBgBwaHITN8nizel7dIWTIVC1ZEKTFeENWNeuFNjF0FMfLfpLKVXKyQezDlqT0aBPvgVadAzBPrVobugRJ3B54D1C/hL8ch6TF16uFBkG/orSPwxtCRbTO9ZCBx0g98yruiVImck1FFj2FeUEB9Xnp/JR1W4l+LTDG+CLYq3cCF6/nrjYpWFyC6utLCE+opejGQIUUycZFKT+a4pKcrayraBpGJvCUGRntx0kApV3k+AnYOlcM3lL24V8y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFp6M2FHYnJTMWpxZUtkQWVqVFJyZ1JscjB4N0hoOVIvSW15alFpQ0Jxb0Fa?=
 =?utf-8?B?eHRGT0xDWnlTZk1yaEdna2FYWFV6ZVEvMnhZOGFMMnBDWkZITDI5RkJLTWpa?=
 =?utf-8?B?VFhZVlBCc3lZNTU3dWxxMWtqeTFJSmUvSHdhVkZGSXVpMkhEWnYzU2JmaFB4?=
 =?utf-8?B?SldmQ3krbHRkanR6UVZjbm1ucW1meTcyMUFVN29uSFAySS9LbWhqa1dSeFFa?=
 =?utf-8?B?dW1hSHdHczM4NFBMRC9sZm84ZWIrQlJ5cnY2NTY4RkRlMjVRazVvRnBrWGov?=
 =?utf-8?B?cDlVaHJNa0pOeDlFSXplQ2NUeFp3QUh0ZnhrQnBuSzRtekdNUGZ3U0g4b1hj?=
 =?utf-8?B?bjVKb0o2RnpmNFdDOTUya0dsdU1WeUtGb1VIWXptM2FBeVNTb3V6eHdlY0Jn?=
 =?utf-8?B?clpSN1NRUXRtWW5adjVzREsrQUYyay9EeXVMRGZwbkhmN3Z1V3NXMFNmOCtz?=
 =?utf-8?B?YzJqc0Jxd2htTlVOZXhRRDQ3cks4ZjBrZncwZ3VnQ1Y5dXlWZTJTSVgySEtS?=
 =?utf-8?B?blBWMXNPNEorMVNwdGtuMVJiUU0zeWc2dTAyWHo3bDhseGJQSW9NZ0hYeTJs?=
 =?utf-8?B?TnowaGdEaGJITHVuamk0K1d0Y0lZZUxrK0RpQ3Y1T3ZxZnU5dHphQyt1NUhT?=
 =?utf-8?B?QUZwMWFORFBKUjJuTzBpZ0tobDByRkdnMFhpU3piSGQ5MksydTBaUHpZdk1L?=
 =?utf-8?B?WThja3JTcUdxNTZ3ZzdFSmw3ekNWM004MXNzNHYwUUFDemlaN3hBS3BXdXlh?=
 =?utf-8?B?RHNrSVhVYmRJbkhDTTVRNU9zWXFuQk41Y3hpU2lMZkd1TEJNbWdPVUtteWF4?=
 =?utf-8?B?bW4wVncrczdtMTJLbFN5emtUUFVySXhFTzduSFpEaVkwaHprQWJHOXZRK3V1?=
 =?utf-8?B?U2xmUGYyOWZqVHJ6RWYwdUVDRGtFUUpuejAreW9vaE1ZTFRDd1F1dytWdkhI?=
 =?utf-8?B?aWQ3K2E5V3F6MVZkbXNDaGlPY2NuOUVmU3krTmtwMU1tdXZRWk16Mld1U0g5?=
 =?utf-8?B?dDhuQ2NISXRFbVNqaWZJMnlvYldMVVp1VjhmOHhTY2hOTDR1VDV4RHdLSk9a?=
 =?utf-8?B?c0VLYUpPek1DdHFqc2l4Y3RYdGVSWGMyaHVBZ2Y5NTZoS01HdG9sMWFPcTVF?=
 =?utf-8?B?Rm4xQm5vZjB5UmlMRHBzUEQ1YWVUUyt2QjA4S3g4YzVCandta3dZNDRSUVNh?=
 =?utf-8?B?Zy81eWhOc251QTV0RXBOM3lKUkx6YTRDUW84N1ZwdUhseGMwWmFIKzRPMDFM?=
 =?utf-8?B?SVBKOXlMUTU1cENmRkNuenF2OG02ZktLWjM1cSt2bVcxbWY5b2lGUmNVNXFi?=
 =?utf-8?B?cndnVndIV0NKZWkzeTJHSDlJcFRrYmZ2UmQyRE1RaXpIdzZiYzc2NW4vdmk5?=
 =?utf-8?B?UW5BTjhqMDJlZ2Nkbjh3OTIwNmJvN0gxRFgxekhheG5MRFpDdnhYVHZkUXh1?=
 =?utf-8?B?K3Z3dUM5OUZnU21ENkdRakp5U1AxNXVzd0NWT05ISjVhWXlKK3BENThuaThZ?=
 =?utf-8?B?UnFHUURGUU1QK0VWQ0hVL2hRdysxYmNBclVxeEdNcDdVZ3dEN1h6ZndUdms2?=
 =?utf-8?B?TmJrRnFUOFdDQWhyZStGaExNMDZOVzQ0WElhcnpNQjZTdXRPV2FrYUVadE53?=
 =?utf-8?B?NVp1SW4rNThjelZ6WU5ZZlhRZmlEdVU0MWdDRzI1bnVUNVhkcG9HRjhDdmZu?=
 =?utf-8?B?TnVSVUFRaWk5d2NiL2JiTXVBTzVSUWw5Y0lQRVFzcGd1dnpCUGpSN1FUUmFE?=
 =?utf-8?B?MG9sVkVPdC9Va0JZWndrZm5SRVlyeTRBYnNoVXQ2Q1BDQUZqcmE4M1djcGlR?=
 =?utf-8?B?dkFZVmhmdDI5MVhPdjVTMiszR1FrbHF4QTlRcmlqTmw5TGI5UkdiMHVVRy81?=
 =?utf-8?B?Z3VaUkdxZFFRWDJWSXpiSjhEUUZJcGpKeGZRcW1vaGp5RG8zVUVTY2NKc1Zw?=
 =?utf-8?B?NENheW1wbnZJanFCT2ljQ0tEeXRxYTYwUUxXS2x6UE8ycDY0dGxON05tU2lh?=
 =?utf-8?B?ZmFUR2FkK1d1bEgvQlp6eHNta3NJSjFnU1lIQWxGbUpYOSszV1U1R1NRbFht?=
 =?utf-8?B?a2hxVENQblRoOGtPVmYxanM5WUFiRFdIZnl3cEtsWkpGZk5NaWlDSEpoWGZa?=
 =?utf-8?B?ODZMcTQrcnJTSEZwNWRXWGlOTXlnT1g3VElkdDRLclhIVWpsZEdQNEtiaXZn?=
 =?utf-8?B?TmRXNXFCMktUTVlYMGNRamhHOXlFcWJnaURNeCtvMDlPQWZURm54Ty82TWVz?=
 =?utf-8?B?SExob1dJSVo1KzJ2TkpMdUttcjZIN1g0eXZZVGFONUFKenJZL1JyUEpiV1FL?=
 =?utf-8?B?aEVYMFFtRHRnUURBVXg0cVFtSkVqL0tiY1ErQVJXZGwydmU3UDVjdz09?=
X-Exchange-RoutingPolicyChecked: Rv0Yj6ClBaiUxNSt2+Dq+zwjLfEUChiBMB5EW1GVcOwx0BBelrUv9pBSu+6lsJMklmkG+OEnIlupRFjeBdcDQA5MRWHXRx2I9SBGr8Af4a3J1QYyMVJtorLUzsnXiiM625XH+xj03eqqVQVxGYGrVMri8AhLeFJ07g7TL0jt+pS/1wdZwyexuf1FG8M3CnXxamZDyHM170qZdk4q6WaExsJwKlATIG7GM+FYJKE0S2t9fYWjqZRstJSXiYBT02Flig1tNStFdvXXyritl57bFTV5ySx9Y7+2N+XA+w8qk8J5FCJCANNneb37LeCB/lIk+huw8FmcfNeNOM+VEpLwMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pnf4rsekUb37xDtc7EgD5yHvQaCj8ZDQy5oGgQTql7Nai6quUU5+flhbNAI1Y1R7oMq3FCFSSOKemFliXDH5R//a4ZFFxV3zYVyijMchTn6j7O9mnjsAHxg84acTGIcyvp1qP+6WF80t+u+3g7bAivGRmz6boDZY7mJsECMP88Q+Z7Ipi7ty/LVJJ1Iw+m1AC8Fde1/8YMhhZ0CF5KxDHH8vIXkWOmnUQOiqxC/R2dEjDhdhoi3LozF1drjLdFwaHjus1bnsA2hCbOV9H4G6MxOVYAOqF66LLvVY02YQqNtUjUnZrt/R9qOoWvmDrsI+Hmi9skm2YSQCxYcMWXcmuzoXCaZALSHPT+gWHxqBl5flGWE86Z9K9dOynKafdrQAY1J8EMKjU5KTGQy5poj3qXihs3ZvVta30g0mUrTxh6LuV4H0Y8hQZzXjOMZxszrac6mPUieB8GA//wuk9SnWWw3CMnW/FlSu8+3aED7mlPccD5VEB4W5XpS1UdVJaHGzVaaVoyFP/6as9k8nmySswdBqS/EE1AgXsCOSn+Hq0bDrHSCD6h4yKymXtJTOIRRulqgeu57UFWNjuTKksJQhlQkcT0ZXbDELVNLAPSBzSuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c482605a-8495-41b3-f73b-08ded35814db
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:53:59.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXwnaqSVsRHA02TqGi55exDYXYGLaJfcJWNONFv/xiA2fc9rcDVy0hQpI/deEVBgAvyGKFBmnDYWvQZaQ+gIyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606260062
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA2MSBTYWx0ZWRfX54Ood+/jn3fy
 OqQ84GwHLMDu2BE1pIQjaD/LYjmhDdyl9z+0R+oKq6WOkhpOr7pB5QwCtgaler32bGGBkWVeENk
 NLCqTR2/pKC/NTjd4K9zv0/2XW4XTqSO1yQmhnRN+xOh9OOJinFs
X-Proofpoint-ORIG-GUID: pT3CPn9KMp93lfG3phlx4FBCSfERZw9t
X-Proofpoint-GUID: pT3CPn9KMp93lfG3phlx4FBCSfERZw9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA2MSBTYWx0ZWRfX9H6MLoSlwFrz
 2va8x67dKQV1MFrDmv30i9EXbclPMElD3ZIQDyRxZ2UREJBXPohlNbN9EmJAl3zbJ1quts3Cbgn
 lj6MstK/YaB8/bJefX6OpPN2r1B0gWmarkgd8ZpZtqurpcegepPi7akAEjyfvSjizfJy86xb/WZ
 Q7UxZkMg9S2meqXZcStkOEAIPOMhCgRRGhg914GLTt4z20IdjLF0sWWgeBW5OhlkdQt0UfMTBuw
 tKyXBHMmmq0RVD3h1NL/dZnlUSFjh/k7sAdNDCBEl+nyyzu7CKnKVPL6CD/AKn3kjvH9UTx4L2x
 jFp7t8sv4sY8BwWavXcyXa7Oaf6v6po7i4tVAbsEfGv2F11dmbDxJ1LPaO4F1coyLDpxbJtwNeb
 dLpFooJ3mZ2C3eZRalsxMvGtPShmMMASAA42vV7jtSsl6QZsEXj9Cr6Je1IEnA4D/q847JK2Gcs
 a/QhQY3ogFBZUvXKxJQ==
X-Authority-Analysis: v=2.4 cv=av+CzyZV c=1 sm=1 tr=0 ts=6a3e301b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=lbU5m4VXKnX9NEPTSwMA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=0lgtpPvCYYIA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_005412_406415_F1E2F07F 
X-CRM114-Status: GOOD (  11.62  )
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

On 25/06/2026 18:59, Eric Biggers wrote:
> The following works fine with gcc and clang, but sparse warns about
> label_len not being an actual constant expression:
> 
>      const size_t label_len = sizeof(label) - 1;
>      ...
>      static_assert(label_len <= 255);
> 
> Avoid this by giving label an explicit length and using sizeof(label)
> instead of label_len.
> 
> Reported-by: John Garry<john.g.garry@oracle.com>
> Closes:https://urldefense.com/v3/__https://lore.kernel.org/linux-nvme/965a37dd- 
> f698-46b6-9623-1099a13f7e60@oracle.com__;!!ACWV5N9M2RV99hQ! 
> J8XE1bwk2YdSyC1OFLwKfqW-6sr8q1CbdbAt7eLiiK3apCc8fUART- 
> Ty_XUdFhzZih5QzMnkLbrQTNUK3TBi$ 
> Fixes: d126cbaa7d9a ("nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()")
> Signed-off-by: Eric Biggers<ebiggers@kernel.org>

cheers

Reviewed-by: John Garry <john.g.garry@oracle.com>

