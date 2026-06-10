Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A094CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O3NXQfu8TuXhAdRXef9aIogGM9KhaVSw7cYijyWTYk4=; b=1sMDmFvX1vdBDfsEn9548jG6yd
	nMw+eyEtX42eyWZWMJ9HbiNTLlhln11RGxuLfpenOfq99bCyjlZQuLpcacgTPzs1XDzVrql6Ahq2V
	XnUbeV9IpvCI/wNCC4hqPTxtvCrqFivCCc9YgUiDmMOZ9zHLoCIyQs/K7kSv3915Xasf3gYz1dy8V
	Ds56zDSOb8n3jUuNSzhGSyQaaCXNh2gpW2N8vuh3AeArQYkIoBWxzuegWEoiW81IaJNfxSwHt6r9y
	Ieg7Osays+mhBHPg3Bw8WbjOhmODzZmUH5leVJLkfwfl1Zga9P9dr4yCN9AWQTyqU1qAj86nRxJ5F
	PDMFDqzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXFQI-00000007IDb-2HuE;
	Wed, 10 Jun 2026 09:40:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXFQH-00000007ICt-0hzR
	for linux-nvme@bombadil.infradead.org;
	Wed, 10 Jun 2026 09:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=O3NXQfu8TuXhAdRXef9aIogGM9KhaVSw7cYijyWTYk4=; b=VFNOZa/Bv8Ecnvk/7n1BRHbES7
	vudMOU6iK0J7e/ceLW/l/ZCEHbfFUOX6S9GjRQmUvr1wrPo8/urFNUF/S2DxIvVbX4+dKPVEB9mBL
	SbP/5vwiFyoRgq8mOep/6cDwWsjtn4qcbt2ak78olOQlCNuuxZRy/j2OjNGd+c0mp7Rf1hlOq9MKJ
	Vi/y7uDzHEvV64KmxAQrp9yHYDcOkUCieqTSE3vc4vzBhrrWPrMTpAGfnoiTl6qpswBAX3iD8OTrc
	0V/PIerSJSfsPuR6gfJry+IN70utiQMD3UVd6sU/zBZ+WXrnCT4fBjylwG0/U/Dteq+rF5iDxdLT0
	rsh47VBw==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXFGC-00000003gp0-3HTe
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 09:30:13 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6MmhD1262170;
	Wed, 10 Jun 2026 09:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O3NXQfu8TuXhAdRXef9aIogGM9KhaVSw7cYijyWTYk4=; b=
	SRZeNQlBOeK5MtB0U/kkDy7yjDEa0tBWnCpUxtg9mBCBUkFpx3ZgG8WyHBBinMyE
	LeTmkG5YeQ7e1BH2gy5tSQd7wPh0aRIavFUKg+Yv1nbT4hYgmMqPtCk6gFF/4D6R
	8NfHMneqGBqvNxMSv5Sk17D0kplLg1yEJutnvKhlbsksFpKN8J9VRYFxe2gJ+May
	UgTXbiIAX07tFec7QCTSN+oYJjjK+OkmedUVNn69lHkALtA6ieA2TPwe53N57udW
	utBe+2JR9xfgFEac6vBPHsM6Ifojs7lmCLbWa2OOyg9oTWNVG6m9XkZtYNwSnfNP
	SlVQzXvw0MOBlSwxtHizwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emab4p8nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:29:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65A9S78E005676;
	Wed, 10 Jun 2026 09:29:54 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eq56yrd5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:29:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg/cDP5ufeeXCQ7U5aCwwjDHpLeK6lszk8d8y4E3U7051pToG7LKenwmQZbp49KXJZ7qOjOSF22WBjPJKjLgyYsvitccv3p9ZRp0XY2V2j+Rf44VO+5ZhrGSAOrc7bdcXas4yjzbJ4nfmihQA2MIvfp+lN3xBvwzdA1mm6aqcMa+aduELNhRU1awlstFtbvdQ17KboEWRdK/WDcmhD1seFG5qJdxHrFak1IbPqoBUNuWvuDONoYWDQcPOm01ZIjHHOzr2CTonbNZAsQTc+YckNns1dAfRa2WAm93u9mqpbrF+OW4pO9gkNRYqPyur9zvtTjlapzzLrcP9kB4VWcyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3NXQfu8TuXhAdRXef9aIogGM9KhaVSw7cYijyWTYk4=;
 b=uV2JPHFaNX0XK6OhrBf7tFQ7bGcX24sJ/0wwnhLxuDWeIDDsPw3BKBgEy5qZuT44rjL89pUR0VBBb/zWBVu/QroghxU5Tk9dnkgANbMyi8QE749rTD9QArrjmVfdb0nELAR2hEgqQBqH/DhK1cQfhhqGTKh5hg0NG6X9SG+fdkqL07UJiTpL3TNdw7gHrPTEU0pNpIVCCciB5Leahvcb+LLIjK0CagZ4Lv+ipw+p3tOMXGa5h/omA7uRNKbLxVEpFiI/s08Fh7ukrjC8THAHKa/z7RzlSyqYc7fZfKkLl64V0PGz3OF5iF+dKfF6UFPeb58zYeq3xPhAIXKRWC/Pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3NXQfu8TuXhAdRXef9aIogGM9KhaVSw7cYijyWTYk4=;
 b=GHRMxjw6dHvabFQ2+oMQXJbXAylQ90ATVC+fTAzQ+AAbQR38egUPZ3Kkb+yXGRCmn4rSirKNrxlNxs03acB6Flv9tYoPkpfVzwLm4BwnEJEuQxk2lEAO0KjmGETSWB/LgYU1SuzAedx0npPiXgWpHLkykD1/eHTRlAxNMYKrVpA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH0PR10MB6981.namprd10.prod.outlook.com
 (2603:10b6:510:282::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:28:48 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:28:48 +0000
Message-ID: <8230e53e-dd29-474d-ac8e-2af2b49cf459@oracle.com>
Date: Wed, 10 Jun 2026 10:28:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make some sysfs diagnostic structures static
To: Nilay Shroff <nilay@linux.ibm.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260610085332.3213760-1-john.g.garry@oracle.com>
 <6f7fee87-8d2b-472e-94a6-150c25c0465f@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6f7fee87-8d2b-472e-94a6-150c25c0465f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4b5a0d-0fe0-4572-d60c-08dec6d2ace0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: IjF1WpBAGAhulwusoWnEib5Y8YjqqN1ctUUIvzUUTNud5qPSobK3tavFO4bJFU8J3fu8nG6aXI52pUYHUsmbkJsSEFigKk7HXPi5sKTHlvf9RiouZRNsn5b1q1bcYJitU8lx4uIXG/PLycU9pa9NdVPhzFNJqCoNyJVYXNyJCxnI+IoaKz20lqT3uZdQkOjdsjjPPwWgmGAgkDrTs6Ymv31phDp/XTlX6ZmqCXUbVdLvKhiRc6/bxdOPSimftFzURWFWLwS2uindjayVFNoTyUSFTJZ21iD1qt9y7eOoDv5Lp/wzzlOjd18lj6s7uj6Nb/quKrXjErdOeVxd8jXbsnUEQWCjsta7izZmCPh3sHPw/73YTTmmvXmF0uf5+TvZTUJpr+5ujrve8M39Jv+n520PimiOrtaskHNf8ETjOTRkVE243Zw95251o2kxX3yF6EGeTOqSNesc77okOay3rP5E13dKxRx+pd6qU6pNrx7wmpYIME2AL2OSoXC8cPED24dunsKGc5/CmpnRf7VJp9KtwzSSdVyOypUgxZwKMET3jIR0kAq6X42WWze+ihho5pRDbH8wRMXhfLNOzBL9C/uY7ZM59YC5yarWaBQvT7DvkOQousXwi7+VoKez8SbWhSo7/rtIw0WuN+uo0fwZGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4133799003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFU3VGJOcFdSTmIzSTZyaDZURDEwZmZWQmRobDI1ZzFyOGpyYlh6ZTFvUHl3?=
 =?utf-8?B?aGdycEhJRTIzUXo0RlB5d0JNcTZKS3VkYkFjYWlJeUJsZGtUaUR3RVBCNHpn?=
 =?utf-8?B?cnpTRHN2eUJ3SncxRWV4Y1hhQTA4ZnNGVUJiT1NqemtMZnJBVWUrQUJjYzdR?=
 =?utf-8?B?UFZTWEVEY1N3REQxM0U5eHVLVFR5VWtmMlBRTjVXYXNOQ01oTVg0bnBla1U1?=
 =?utf-8?B?cGdmQmJLN2JDeWVrN0JBMytubmtsNm1zZnlJM0JHaVMyN3c1WFMzRDVPZzNM?=
 =?utf-8?B?RmdMTFpIZENVbkhjOElCVlJrNm1NNnMwRm94WUJXdXhSaTdIVTR0bzJRcmd5?=
 =?utf-8?B?TCtMSTBEKzA4YndtY0ZpMXJIc1FLQ2J4WTljbVNmanhnSWZSQVI3c0FmRFk4?=
 =?utf-8?B?dWFsRm5GNmUwQjNOTi9MUlRlajlERWZvOThNSDJlam5FQ2g1aURuSUxaVmhs?=
 =?utf-8?B?Mm9WWG4ybmc5ZW5hU1RvZjRTdlhodG5HeTdqOHNaY1VGb2YzczRFSFZYeDlv?=
 =?utf-8?B?SjJlTXBUNStieG91bUp3aWxXbno0azE4SjhjdHJiZ08zNzBHZ3RQS2wraVZ5?=
 =?utf-8?B?YjhtZ24xdUEwSUJwQUxNclRhNDBybE1ORENxajd4RFdLOG81Q01VTlFsUEZB?=
 =?utf-8?B?M3hadU9aSUtrNUoyOXgxeG56U1IvemNUQkcrb1V2cWJadmJBUmhzQ2swangz?=
 =?utf-8?B?U0FNaDNNblVOdmR2em1xV0UvRktrV1F0aThUZ0tnUWRxeGN6OCtQOXpiSlJZ?=
 =?utf-8?B?RHE2aCthVVJGeWRycEdvdjh0d2RFcmpvcStaYUJCaXRndks5UkN5TmV4MEpP?=
 =?utf-8?B?eW8welZPempSVGt5NzQ2Q0hVUW9jSWJIcnFhUldNMlNCVEx0Tzg4UWFwaUNU?=
 =?utf-8?B?eTE2a3ZxcnB4TmNWY3VSNmlJQ29JL1djREMzUkphT0l5NFFMVEhkWXZRVmtE?=
 =?utf-8?B?OU40eEJqWXVRVm9XOFBBM2FmNEh6UC9tcXlzZ0xVTG9EZWI4aW55NVNwdldM?=
 =?utf-8?B?enBzb0hzSURXUVI3UlBuZVhweG1Ia25JdjJKQ0pFajdLK29VTzRVMFJhTWhy?=
 =?utf-8?B?ejE4dU5scm81T1RtdEhSVnFFRlIxeVZRS1Q0L2Vxano1R3BQSzh3UmhvY2p5?=
 =?utf-8?B?UFZWTE9VR2hrNkRYaHhzd2hLVEV4ajdLbkU3L2E0UlZVVWV1SEFuaGd1RllL?=
 =?utf-8?B?cHhhN0s2SjJDR0J2RmRkZkJWU21qWTF5ME9vb3VkdVd5SVdYMTFQSXdJWmUv?=
 =?utf-8?B?RHoxVEJEbCtJU0cxekhwTFEwNGY3TmVrZFBzWkxWTW9wNmxlN0lwTWJTcS9Q?=
 =?utf-8?B?OEdYVTRGNE9BL3Y5SkxBVXV6azNIMnJJQjlYM1VjZmVNbkZWUWVmak1vZ3FV?=
 =?utf-8?B?eWltalBJRXBRdmFhUExwTmoyVkdTRW1pMDBidTA1Y3NMUXVMc01naDN4aWJk?=
 =?utf-8?B?Uk9haktXcFBwTmplRk9CaVVmRlR0VzdDa3Npd3hid0VRUllIa0Fxb3grNHZr?=
 =?utf-8?B?NHhwbzhFSzF6R0xMbFpoeWUvSVFjMVROdUlzTFhxem1aVXMyQW9hWkkrZTVW?=
 =?utf-8?B?LzIzNGRMQTRRZ2ZNb0VaWG44Y3NSMmlIV2VUR3hva0pxZWdVTUZhSmRBa0Zn?=
 =?utf-8?B?MkdXanNlUkZWWjBwc2s5ckp0byt4TDhjMGp4eGhLbGZuTHp1eVdobk9GbUF1?=
 =?utf-8?B?Qi90bytSUXJhcXVPVXVjZzM5SHdKT2lhT2g1ZzhQNWNqMjAyd1Y5YlI3MllR?=
 =?utf-8?B?NzdyRlFGNVRGcGZjUko1WnovUHpFdW5GazZCVTVWR2FWOVFQeURaWmRmV2tY?=
 =?utf-8?B?K3V2MzZTTy9tbUNOQ2RhMXhVZzdVNlhDUU1qQVM0TXdmcmQrZlNLb1VIbm1j?=
 =?utf-8?B?UkVINUFPcmxiY29TM3QyYTBEWmFIQVZNWWxZRWlTbGVTb3JwcEF4Uy93NHdR?=
 =?utf-8?B?QndUaFBvRHVnK1hTZVdrRnlXdG1SV3JFeVp2TUpwQ0xkMEkrMGIzTmFWNkJ0?=
 =?utf-8?B?eTVtVmttWS83WG9COEZzKzZGWUY4NWhna2lEVkhOd1FyemUvRUNqMExXOWdD?=
 =?utf-8?B?bm5XdHoySkFQNUpsNFFNUXhSMnhwK2NIc25Obm96aCtEaHB6RzVDd01XaWpV?=
 =?utf-8?B?eDNNV1QzY2ZUaGlRYmV2Rm1xQ28vcEMrSFR6K2tqSDN3N0c5cW5QUDA5UGE2?=
 =?utf-8?B?R081VzZJb2tCWHlBOGRtT3dnejZwQ1M1WTI1eUtwaUM3SDkySnpaQXRJd1ZQ?=
 =?utf-8?B?R0RaT3ZGTnlhS3JKVEVLeHB2SW1acnMrUXhJVDdJVUJNamlqVEsyQzdLQ01J?=
 =?utf-8?B?NThLY1RPQnp3Unl6MjNhQ0VoZ040VzJycGliaHNGajF0R25oSTd3QT09?=
X-Exchange-RoutingPolicyChecked: po5JVn5CxSd4JQlifdpQrpqFk/5pVe8eqYg/c9w2Jf9qjQaIpMkiSkfKM11QV4j+2AD+McbJTW6UzAFvh9fJvmj7wMaz8TRfkp0yqylQhMrfJWeXLYXpEIO3U51mCaOIk390VMYHu5g/0DLGewZk9iKBclbGRzd7nqgdyck9/MX3dlrnA+jDtAMeYZcHG8Zq2tTNR8APj68PhtRwY7xwctgxU/XPUsHiHY1MUMuySPDq2TekSJ+ZAViLNzsoBexyDuwvkBCRAIzVZw6B73MvDBDpHrBlD03QDGir2LCPGASKzPxiH2MfP4fQvsJTcc1COZzkydoBVt1NubnmE15Gxg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ytAc4LTbRokdsks6DHcFoKHrESx1UypsREUYCca2fAUdxQHOI2zwJfUN1w9DyEYGf+hRUeE1YhWN5Fqf/eQfc5v4dVOj47mbIeAxdfZaAzYZObhKBktnMz8Z1C+wGVWsJPuffNG828hV6ChXmWAl/ihJcjvkdWnEY6wL0U5bZsarp4mDQCMqsssEaMcn0Hhuu83XZU3BC6Y8S2dTdyG/+T2rTDWrRWujF+fXbh/juqpHTA4F4LPJkZITcj7pOmHHZ2nkNbnxByLZ4mwzBQtrMKvOqxz6T2wHdP8Jvf4pFnIHb/3ygVPhDJ1TGyb+DuwWR4QvL2yBh5DyJ3nBtXhIqxe6HXm/6s7nCEFg/+lKzVdODk3mgDFfxlYhcCj3nYN5VZZ+jm7WpBcRHi+V42aBAStpLwwE9nVLg673+eLlZbGLVodp67NUwqbp7d61aK1YYXHHwpA+m8MjuzxfByLP6TXLD+dvzthtcpUI2TWzVxxXKbyaT+IaSSiAiQalUjvGkdyV6kY1fzwxrZnM3pihM1kOmvmOBAzuW8SUatFakT+uER2LmJaSnZ/buUwxGmntnbcLvvZPRpIA8hkw+HOGXu0+MUEaVwaFVhlnuqMusoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4b5a0d-0fe0-4572-d60c-08dec6d2ace0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:28:48.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef060Y2IqmcRKyfBEjGkUIPWtDXgChONxUehOjlr4wRJ8bpN/rwaM4V1+hu94+iIm/l99SAB4X3FACi0/xz2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100089
X-Authority-Analysis: v=2.4 cv=cL/QdFeN c=1 sm=1 tr=0 ts=6a292e93 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=Zv8I4HwSogZNmaKNnQkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3s5Ap5O5b7AvMfMF67jMsFAy0hRfOs3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4OSBTYWx0ZWRfX0GlCisjSckV0
 kxs9m9RJ9rlftIw6ADSOzxkwUVpDuaHrVjHnkStrUMAaVEKG4kAVyxkokZqMHvwWEPGsdxttu0q
 iB5sC2O6815Ic1CGeh/99LHy0hAin0kMWaN1tNTctRlwnWvIrl/rpryu9LUKjGQ2q83Dur8nWq1
 FkTsK033wmBlO0isbgSytI7/DIquNKrrn1RCMsZYHFbsD2RF8GhivQ8aKCbHrvDdmx9bvbpoGH2
 vDITcgAtZF0upoiaK5A9Fpsp0w7noIcV+1+viU93OhVtVkJnTrEIlNQxlbqCeKj7r/lmuDWDz1K
 7NQmAR0VzotOgiZTBLIpIoewnXpnSL+/AD4Bd7PUYmsD/+0YzaOsi6qU0SSldF33KU5p+HqfxCY
 Qo8JYIymG9BFIeMfSbrHnMEyKNXKG4tySj9OL+LxqWQdQHe0BHqNP7c/YNBzFJ1N0PpxyFHf9U9
 m+5/mpaT5ZtBSz++Frw==
X-Proofpoint-ORIG-GUID: 3s5Ap5O5b7AvMfMF67jMsFAy0hRfOs3n
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_103009_530053_533CBCAB 
X-CRM114-Status: GOOD (  10.73  )
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


>>   }
>> -struct device_attribute dev_attr_adm_errors =
>> +static struct device_attribute dev_attr_adm_errors =
>>       __ATTR(command_error_count, 0644,
>>           nvme_adm_errors_show, nvme_adm_errors_store);
> BTW, kernel test robot also reported this same issue here:
> https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild- 
> all/202606101329.T3zXNqdy-lkp@intel.com/__;!!ACWV5N9M2RV99hQ! 
> P5UdkxQBbB6XuNloxfIJKNALsPKk8vSXQENG4khm- 
> SufSw1QG_Ndga5ZvcKhtCypHWJDcNkaE1KDvZZ8pO8$
> So you may want to add closes tag pointing to the above link. Otherwise,
> this change looks good to me.
> 

I would not have noticed that, but here is the necessary tag anyway:

Closes: 
https://lore.kernel.org/oe-kbuild-all/202606101329.T3zXNqdy-lkp@intel.com/

> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Cheers


