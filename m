Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8664C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyV+xoPjOp6aDTr0H9wSCpnX3XXLsBWqwcV0FoHw5XY=; b=fGkHZ6SVVgPieeHoW1aes20Ukp
	0zwn1QsETwc+iAp0LMVMz0+0K6bGlDAeJo7lCHr+CLKSMlW2gGsCbD0Tp+Ol/+4v+0YsItaOB4RfN
	QEKdODDVUn2+gyx9y7qPZU12yN/avov/FbqjTpmlvs13yooQ1KMnt6OqjE3+koTfhRMoDcMaBI4vz
	3umDS4EIuIHLY/OMMtXDUigzIfEwLDSKOXoJgzyBou3wZVb3yjyC2iLZ6yVzgvRLdhde5+GORms26
	X517yaFYr5rE/g0NxqPdoMxAJ2zF7iFTNpqSvuPJ4WfTs+gH36+clpjCScQJlwuP/JhSveq93Yn4k
	Y5I/bwGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDFR-00000008mUJ-0nzO;
	Mon, 13 Jul 2026 09:46:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDFP-00000008mTh-0c5Y
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 09:46:48 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D0Fw07182323;
	Mon, 13 Jul 2026 09:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZyV+xoPjOp6aDTr0H9wSCpnX3XXLsBWqwcV0FoHw5XY=; b=
	d6FcUPhCH27kRKYgeKa00bgdd68cA3dADGEjjzPYC22IfwbEPAcwD6YC3zTG9HXr
	ysIhBXBAX0fFh4YhmfWNvhhD7n1r6v5IhMO3tu2G7FI3xnd5TeYRrd1TS0FvbRBp
	q4+tXeLjWk0/r6as1JZZL3arqJxBnxsr0pv5Vrcvf4lm2gL8DKb5kNLBSQsodvoR
	iyJY05jqED+Cs7b3EIj6g9gW1ipo6BswmsTc21We4bZCqzP+vXJwSaBfw6ArRdZ1
	nk9xpRQrtx0i0UlwVK7FS7nkYCCCjVUOcwYb1U2xpRLxlDcijho63OFiSkp4SvlM
	TNaXs//vjMXT1Fpt9dZGUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeh61w2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 09:46:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66D9cXCc037292;
	Mon, 13 Jul 2026 09:46:35 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9q3w3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 09:46:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClazmRM5+f/d/YxwbyMiH+oWC3p5R8Jj11uPi4r8g/KyOt8baeShkzb/Xi+I+KvIgW6kKwpsIxgRXktPgy1zcTCw9WNqJOzW/ksnxL8Vayg928En91kp2OOV3P8k5g6FJ5RCGdVwATY2ME22JPeCAJl77Fi6VsJywTAw8NbAsjyOR7B0kmkPvtnY8Z9c4lms9PonyCWgCgJ0wq8hQfS8hF3y+578LgIySM+ql5EnTaNbj0rGJy5SaIdTwbnR/BWbgogixfLPrqfNS0DpOpmkJYwqTnKwaunVnaL5MWmr64PlLq+ao+yHB0dXhY1x12e7S5xvMsjZpo2GxpA4uhJ5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyV+xoPjOp6aDTr0H9wSCpnX3XXLsBWqwcV0FoHw5XY=;
 b=RUt9IGigbRMweU8LdwtCHDIJKY8/fosuNMS74IWuYMAQyA3R1Q/lLGHWdQ+bgolg9is9tUVq0fhbsPlKk1911SpVZVMIsve1635s8823BTdTnmpRzkA9jB7zsWhEdw544t6p+jmy2kKoh1diB4uiUGZFKZDxdCTd8bKlPa40u0DBw4JHCUFdTDKusdYVy514f8iRtj//0iwzrfsKzQJKRxdS2huT4wH6PHHpc/rIwyrbsP2qQnDCi2cQ/hwE3JMBSJyCfmy4FNIBs1PbxJY35/h3L+P8FbmhxKTcTCmDWYtsKWjHzcFNFujFW5W8RA9tW9ww3f98ulScI+BMQiAL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyV+xoPjOp6aDTr0H9wSCpnX3XXLsBWqwcV0FoHw5XY=;
 b=JLg7ozg3UBw+pSIWUaY5DGtNxLCd5kN3hRQXD80O8AvFQy8WORc3BvGWWyYQCBd4eN+Af93vdctHFK7NM9+gX+GnfnFSvNQ48zF88ctaUQjLL5CJ/w+Y1eRoRaVvsFtBQEgXF7te7BaG3gdgG/XU/NgyxhUpZnuxzEz3gzNUIig=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Mon, 13 Jul 2026 09:46:33 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 09:46:33 +0000
Message-ID: <92db8054-c7b0-4517-873e-8c0fb18c02ba@oracle.com>
Date: Mon, 13 Jul 2026 10:46:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix cdev lifetime
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org
References: <20260713091546.3013427-1-john.g.garry@oracle.com>
 <20260713093044.GA8706@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260713093044.GA8706@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0103.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::8) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM4PR10MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f78d72f-2e79-446b-a48d-08dee0c39f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8x6qGzWbHaRyBTQqsWWrp0kK4fdAd8wS3zpXkuXIBLW/5kY0CC4kZOLdRn6pm88oQZowHn03QyOPnm35lrq/J68MKDShhjZBjXlAzUk7klZDWFPTuiBwz9golzmuNY0D1oPmpMcKCEi3NqwNHJB+mPu4XjZNGWfHJ+5vXeXObTs2cBDzty1PjKS7cXUpsjfuRwZkj08/4BgHTDMJNZGIC7fF82KMxeAUIiBjsDVPkysOlUssVeDLVT6jaDCYTmCuGXw41swzHni8Fc9OQhvO17qgUIapGGAnvdkuULbb7OeiovFkOiTwcBZjRMpYlq/dQ7fFutuAoa/yZLVxjCsrzR42DsDALydg/XMpyhwqnGgmmplzWVoXciRe16pXVMreO48JTCw/tvG0rQQXnngI3tog/wgu3hiaZlfVtdpcVUSp5KKChhPoquHCeU4javt+xtkZkhZBnP9A2XvF16fdEYeFs1vatB7OPWKSGKehAzslKfgoVcMqU2T39+n5fXie9W6l3uFwd0Zwz2ovX+BmT4OkYhX/UrPiVisPtw8SBlSmtmMjDxZ8z63yoxdLowSz3w8Ae4gRlYooZdpq4jq49J799h6jpvQFAJ6lRdW02dVNzrQBABVJbMEQZYdXGI+AG4sXRQ2o67Qldtm+ptlXFuT85jVBifhUvKlrfN7xJcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VQZFBaOFF2V3V3NkdXWVRwWWIrWHJwUTVKWU16NW5uZ29nMERMS1FWR29Y?=
 =?utf-8?B?MGNPaHhVS2c5eW5UbzBOY2N2Um42Z0FaRTdnM1p5T05ObWkxMW1rc1UrdmRz?=
 =?utf-8?B?SGhFVU0vRmVRaXVqTXZqUExhK3NOWDR2VU52ZGFHZzVrZTFsSS9IM0t3QmRH?=
 =?utf-8?B?TGhVajdaTXVWSnh4UXQvMXFBN2k4V050aU11RXJ2cGFmMkplUlU1WDJiT0Z4?=
 =?utf-8?B?R05OWFBDT01ucjlObTRIOXZjWFpwUFBvUGZCTnNwV2V5QlpxTHRWRDFUTGVZ?=
 =?utf-8?B?OGJqdXlZMW52K1d4c3hCbVJzN2ZlOXFaNlJXN0x4SmtCZFZtRE9tZjFoS000?=
 =?utf-8?B?c2JZYnJoekk5dnFhVXpQbVZiTVJMeEpoSS9JYjZ4NzNUaFNGTlltSzBpQ0c0?=
 =?utf-8?B?M1U3bVdudUhSY1RWSWVlWEJVQlQwTGhhcnpJZTFDa2U3ZklMbXRaR0wrZk50?=
 =?utf-8?B?bDBGa2VxUUZ2M0Rpb0xsdS81bHNPQ3Mvd1A0Q3hya1JycExqME5mVnZKbE1r?=
 =?utf-8?B?dVhJU3ZqNHdIczV5OW93TC92dFFhT1JZZkhSWFUxczZSeGpHMm1sQTEzQWJW?=
 =?utf-8?B?NWNtWDUwK09JNWdIdXdlNytOVnA1cDZ6MDlyNy92OGJZNmFsUE9lYTVIMnpC?=
 =?utf-8?B?dEFudzlvQlJKM3NUMS9vbm9UQlAzb0JKczZFdnFkSnYwdUM4T3gwT0twTkwy?=
 =?utf-8?B?OTE0UHNWZU1wejZVZUxOU3RXT1YrZWY2VmNNMmhjL0JBZEdQN095aUpDVll4?=
 =?utf-8?B?OHZvaHdaY2FDZlY2RFdlalh5NXNiTFJpSkVaUkl0a1JVcE9DSmJoWmwyNytO?=
 =?utf-8?B?Mng4VHpFYUhlTlNYUk5FTFZVYm1FWExSei9QRmYvUXNKcTU5TG5UMTd3MHVm?=
 =?utf-8?B?SEx6SjFXdlhrK3E0Z1B6RWpwRi9EN2Y4SU5QNWRRT1dVQ2dKZFltc3dSc0tz?=
 =?utf-8?B?WFZOU2JuM0NCQWNJL0FucWE5YlE1dWJhem0ydGM2bUN4bzlobEJkV08zbU1I?=
 =?utf-8?B?Ky8rdkxTem8zMFk0YTZ1TGtHSC8vdXRBWU5pdGdSYTdDcDRGZ29ST2V0RmFm?=
 =?utf-8?B?aDhmMXR0dTJTalB1dHBwLysrRCtEYWxxYmRMYjEyTWdCUnhMNWtzR3JLa1Zp?=
 =?utf-8?B?Z01Sd3FjcncrNXlhYmVZY05ueE5JVTdkcUVOeVN1Wlp6eGswUEhxQTJObVJ6?=
 =?utf-8?B?WkZPVkFqUUw3VVZzV2VseFZINFJwU3lBVmJKQTZ0eUtBais1NnRlOGlhL3pv?=
 =?utf-8?B?Q1R6dVZhQmRaemJZWFczOHZISDh5b0FuL2ZybnpIYkhma0lDeGwrWVo2dkRz?=
 =?utf-8?B?cjhGcmg0VWxUYzlpUjJHcWZqRExhbDdOWGwwdzRVNUNDU0w2dkRRMTVWTkc1?=
 =?utf-8?B?LzF5NHRSaVd4cmJtdmtNdm9EOFl3WERSUFBCUG8xWXFsdmVMWUFKWm56UE16?=
 =?utf-8?B?cXdFUnY0QWorN0Y4ZHdQMW5jRy9uVklQMmRHVkFJVTVKM3ZDRG50Mm81bkRR?=
 =?utf-8?B?N0dTcXptUm9VUExKWTNRY0xwNnIzN2RhMDhXZ0VNMVVHL205RklSbEJvTnhC?=
 =?utf-8?B?UnVqdnRkSXgzVVJteXFGYnIxOHRqU3dVdTg1dXRZK01ySG1nOER5aTJxRHoy?=
 =?utf-8?B?VzFxZXJKbng1clFrOWhDS1ZYRFFuejQrbG9MaEE0b2p0Q3pZdkxpSnpvVDhq?=
 =?utf-8?B?aUg3K1lBN28vN2hKL0o4WTlQVmJaaU9kRFF0d2k1Mm1yK0hadkxvWjRnK1ZH?=
 =?utf-8?B?Q0NPY2JwZko1RStycWJ0VEpwVXNsV3BSZjJaTzQ0M0NlaEJLWkR5TXBPa1VP?=
 =?utf-8?B?RHZ0anZ0Z3lFWGx4SjZUaDZlcFU2TmM0bTFuWFZUN0FxYkxpUTRwMnNVT2F3?=
 =?utf-8?B?V2lmZnI1SzZ2eDBBOHpRbjBCZStRSm1KakwrTDNwS3ZhQUw5b2dmK1lBamFN?=
 =?utf-8?B?L0EvVkZXUkgvSjJIS0hyckt1M1RQNDdVdmFwZXZkSDNWZU9FTnBkUkRzZUJM?=
 =?utf-8?B?dm8wRU0xQXN3WUsvV05rTDlEa2JucnBaeFd5c2hVa1NjNDlQeXB5R1Q3MDY1?=
 =?utf-8?B?TGp6V05aQ2RxYzViTS93MGFiM3NjbVZLMVFZUlNGM1JpQ2RocGdsUHFST1Yz?=
 =?utf-8?B?RDJvTTQrMDJRQUVOUDNaazV0cHpGdllyT21mRm1mSmd4ZzFrYWRueVpTWDlP?=
 =?utf-8?B?MTFhM0s1NW53NXN3M2o2QmNCZEtiYmdpZEluQWxmUCt1TkNKR3lDVDVsNFln?=
 =?utf-8?B?cVZOQUVxQVR2RXFzS1l6SW1DYko0OU4vWlRURnJMcWhYVGxzS2kyU29heFpB?=
 =?utf-8?B?Mlh1U1Q2YnpKQit2VDBHTU9td0JrREdPbGZLd3hlOE9pd3BxckdNZz09?=
X-Exchange-RoutingPolicyChecked: RB2mFG4GWy/8Tv00qgXhpjxHqwf/Eg10/kx2Wnz3/RuqelQjs9rpXfssA/YBzWGeWrKtkcI9uAJ1gBEcEZSKaQ9XQC57ojL7tWZf0O36jRhKLBuVR7sMAEfQs92dMhSzO+yto0EdkK/VcXsjP1u0249wsjbhUqDK5HJoPlIS3R7Pq8T2LB3qdAu6zl+laZcB3edPlDGUzL+/C4W0tqypraxysnuYKCRM7bXA4b63DtjbUDWTmm0rGqQ844Tv4skXfCqU5R/Rv/w/lMB9RXRmjNrPw7pOtcfLws9Vr58aU+YPgJY3YKvInZmv8JSpP/e51QeoI2oGmDADRtauPfZV+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ly9HtxUgM4svGntKvwgFLHuIYNQcSs8lFM+g5C4GstTKGbG52KO87Th5hBdfZaSeGFGRdbM4mfUX3oc5NR28Rh1GKL5eq3f2pI/Pi7U+u7ktostssBJWK2iAZiiDqvHd7ytAhKktMZMznZtuxy+W9Ll9AagH8ohPGgqoIjTQdtLB6PQZ77bpM+h8564wUi5NqM/eXPbKFRNWeVxafX8jYRN+T/rhvYB+Gun8oNraRCFAb9tj/ReaqDowSEXFin8qmuSm7zkddx3Od3OtipdZIk1mY4KVocrLTAcaRzFZkjmpnA7UD8W4S1OepNuxLti1pcMgTJN8LFFJi4AxRNfuqlifrWS3vlBRy/RTVrzm3fUcf4RWogfavICWbhusGz13S7FtaIPQdP9RVOzYnMnhe33inX6S5PeGjOwnypYEmt2UeVcUftTD2v3vBVFKCmjmzTVWBjO0PZuSuFbUQo3i5ftQFoPPR0b4VPre8LZks0lG3zdxQoHkvSay+TlApgqywiGTQzGIz8WRQ6BNc/3Nvj8DRiOsS1ygn7NOIWMeWrPxhB5QG5J7tWa6U04u5ql95SiIRK2vz+odmXen9vEvCyDXtMUZehITSp0Ku888c/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f78d72f-2e79-446b-a48d-08dee0c39f12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:46:32.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+gOhdlIZSsSdUwjo8fOqDEPeWeiLZMiqNsHR2xg02pxndP5QCQ8cNpHXycMyGnqEkhs5vSe5w+IVVs5uGH5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=922
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607130100
X-Proofpoint-GUID: 1ztWc1WIlnO8xYtn_SfLOoGRNMOWvlWM
X-Proofpoint-ORIG-GUID: 1ztWc1WIlnO8xYtn_SfLOoGRNMOWvlWM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwMSBTYWx0ZWRfX4MZNFd3qtGbD
 obNbX3K5/kZLvadgEXnOd9cphqmzSHkT/2isTXIcdWCqZr1jXEz0rtRBK5iiEkBb6Fty1/Qbt33
 1fMcV4zuIi2n7QqR+5NLWlzR3bTVFQEKvZEpFDhAF18rcN7hqoVm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwMSBTYWx0ZWRfX5s8lBJ7oBqrN
 +leqoQYagKxwLOkW9zDYe/uaO3JpKnerZaji2FhbjI+26J1iGJkqfIJqGxnusUwdb57CQE1XSAX
 BSVZHc7wpmKN2aPaYkDvZBl081V4/BGdFySksVSzcmMc7CeJq4VI66YXHvMLC6lD/MNr0fbtcc8
 OLuDXTy/32bRb24HKg7CY2hkZsRjvrVCV7lDv//P1nfWJQbSlpjmmfTz/yxEEoA4MKatBxsjiRl
 33TyDwb6XxKOnUQ46uIxhaA5oWRcfZV8/x3UjCyD5u+BRq040t6edNH/36+B24wvMB8OsTYtXiz
 mv0aebFKE0OHvt71fiGTnN6PRZDFNSKJn26v8WF/bCH0/nY1Py2VF8cpN14xYP8N02XEVX9as/E
 /HDEg2vIW6G7/zE+f4Gi2A94gHLbGep8nC3Xya7oxg6CmMsEQClTX/ya6SYHPBVZsPcQI1gJcx0
 iSptM3Zl3MA9+QV4uwEUcXAECAxe16nSk7t0O/SU=
X-Authority-Analysis: v=2.4 cv=c+Obhx9l c=1 sm=1 tr=0 ts=6a54b3fc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=hxaqM1z6yEkJ6eaYAGAA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_024647_309073_08953D60 
X-CRM114-Status: GOOD (  12.07  )
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

On 13/07/2026 10:30, Christoph Hellwig wrote:
>>   	.compat_ioctl	= compat_ptr_ioctl,
>>   	.uring_cmd	= nvme_ns_head_chr_uring_cmd,
>> @@ -666,10 +646,12 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>>   	snprintf(name, sizeof(name), "ng%dn%d", head->subsys->instance,
>>   		 head->instance);
>>   
>> +	nvme_tryget_ns_head(head); /* Undone in nvme_cdev_rel() */
> I think we need to do a real get and not a tryget here.
> 

ok, np.

Then I am going to propose adding nvme_get_ns_head() also. It can be 
used elsewhere and it would match better with nvme_put_ns_head() (rather 
than using kref_fget(&head->kref) here)


