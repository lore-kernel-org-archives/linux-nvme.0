Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287DDC5AC82
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnN7lzR71tkJSqjBPOjG7eST4xXdc1FtoxYof3Wr1zc=; b=tCyeFIE7ylkj9TeQe/Csy5Gmd+
	BkZZPdoLodstBwtt5ZeTE/lGMd/TOCe1dIP958JUsdPre1mJPj1F1vLS1hjckKIq1Uf7eZBIyPL04
	vOLb76+n6VYDGSSQsgkn6ZOhYy7Zvd7ynRCbTR5oe8WPJV1f2n23LnnctDtl4r3DltmQv4k8N/nA1
	E7dP38As1SpiN3VDhPVD311THi9FtNR15QcVyHjmvoALSeOC1HgiTo+P1dQ5mZsf+b4k12UImri1v
	LB7EnwJ14z1CGqfDOvBZGSWZzk4RDlY2MdjMZGuQp2CYFWCzcERZ4ffH9s4iRS7T3PdiOiqOoguFk
	YDWWURBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtLDT-0000000BGHR-3lHP;
	Mon, 10 Aug 2026 08:18:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtLDR-0000000BGGC-0TlY
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 08:18:38 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679NRpt02694117;
	Mon, 10 Aug 2026 08:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AnN7lzR71tkJSqjBPOjG7eST4xXdc1FtoxYof3Wr1zc=; b=
	V/x/8V7LMOtKHJCV2q+b6LC0qdjkjr+/sM7Lp181YFq631PW9vyztcJ7yWqHPgzD
	L1dAeFyKslAgj+yoJHC027lM+GkUdnEQH7jTbHGhJ4Yp2Z5OyDh2gvAw9/CTLUOm
	QJJw8p08q7OhAmzofRp7gQXUXXZpLUsTnP1SEKePW7zQMSqnZITDmY6z9ZZeinwQ
	1I4Upl1jAx6JoAgPebA6ItuuxHqvurK3IgKKA3mWZTFOYnr+U0hxRBTKnFY3HQJr
	/x6fTmGEK8kNMuVhu9juYjjjVhyf8SeEJoXqTQZWt6mwAQbjgTtRT0EXkSSTp/qk
	FoWjL2EA1kwqIlZRO6waAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxt506-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 08:18:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67A8Er7v019212;
	Mon, 10 Aug 2026 08:18:18 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwbuqrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 08:18:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8PpNR5RSyai7q1keQBHISxrpMu9WclPRSVmGgjxcbPPQA0r9o7jI3rOLlMRikW1qXH5sElWNjO7JGO4QKyPJxZD9cBqdDCPWTJ47a8pc/4FzEYsp8+cAeyX5sdILq6ETIOKfKY+zs7acPPl1u60znaYT91i7P4kUj2HDwE6Xs53ClfP/k/8Iol58HyhEKMWZHh5spIfKe0FKDTti1CuqtowbjsAokNJTV3k8WAZTvsZVq3qY03zVAk4LFvlcGXUhZHER5PFvypMGfK8AQFuoGme3WJZo6nKvlmvuP5Rj+Y2EcGnVPb6DcpfY0+7HDcbAoat2/3QPXLZdisOx4bn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnN7lzR71tkJSqjBPOjG7eST4xXdc1FtoxYof3Wr1zc=;
 b=PNMMoYlYhiACkH8/AcAxx0a8hKqfJYvxmIlz2JWhzcTabvp/oo+lhKMnICRsbMRMb9MVctBSdUfnpkcb6JUAxvv1zC57ypbZyz458vuR3rUIOmzu2NWFSDPbnDj6/UXwX8I7Tst9/EN0upvaTzu8o3Ef4IxF/UViAHRZUaUf9DAH8fjaYvlaQjO8SgP9+PHrOisqnnn7HaO4UoWEje6DowyOzVjdxAo6QO/Dk4YrDmxC8c7gvABw2hBzHGVlwYJb8FwBR1AqewksFwXX0cQCedC/puNOYUrhcDj44wSPsr6+YxMvcOJK2ONZk7MuaHOv7a+PUvPSX/fdEqY9crd5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnN7lzR71tkJSqjBPOjG7eST4xXdc1FtoxYof3Wr1zc=;
 b=o2w0w2dVNbvn8JfCeChZLpluULcFM16FPmzf4Q8+/vxpjXOLU+cOD5j96yH53WGzMvZ0NM8E0e4tor5SC4qWI1cSmyhhN7D+kmI6nPYgcSkDtDAIKEfv3cVeAP0P/6Gb/H+/66M/wsgGdLvIDIHL+k2TqZMKkULHOjmthppjJI0=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB5644.namprd10.prod.outlook.com (2603:10b6:510:fb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 08:18:11 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:18:11 +0000
Message-ID: <3ae08feb-d9ef-45e6-b5e4-c50645b4c411@oracle.com>
Date: Mon, 10 Aug 2026 09:18:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-2-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260809100825.2014133-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: a04e1b7b-f316-4680-c023-08def6b7ea88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S/eG4ura5UZModbROxNg97ihvyCbB8/elpiIqrABhx7lx9zoAVNbyzvlBnvZO4dw7HCURDBikgT2Sbmiy7EFzAG6qI0uyfVkOqNWQqYtVZi6LHN0iq58blhiefmrzDWM3njUaJtlrqDfB9j4t0ovD0nBD1GSe6TmP5nxhOqNZX8SIvYdp455u9DquGPA7grtu8kcvkk3PGY401K+xWSzmGWYoO414iSLmmvH20t/01HQrPK5VncWMvijpG4Unwe/LjCAcnKvLS+sw2qkYNWEMulIJ6gYEk8NZZLWGlv1xB7XfSqGez5WuKWlHaowO6bhbmwKvmzmei0mYExDbtpzcFlQattcYZW7JJle1fKBo/3FvOMu/RWqZ9wfJqk17JEMsYEuoNT42bHrjMNoTD7+CLXZK+7gRVeTGWVHELW2x093plBh0XPrXXZl/wu+0f/FlfkYRBVqErMIJ8f+qKxFLXikn+qQ374WxR3owSKmVQAHTJsyP9xl/VHCwn09kRsxtdNhnvM1Mh0XfqHuEP9g4t1nsRDeiR+78t8ih3umLTEPL9skAlm0vAov7gcmnefev2L2WuBmm0Hhj1T53pXwx/8agFZHNmEVs3g0sFSB66eprNu2YM2P/xGkCKr+QtfCrBnmBqQUjcJrsQAVQIDuGmNA65GbYtJSTE4IqxZ4rLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTkzTWo0M1Z5S3VUdTlKWnJoejNGMmNVd2lVQ2pINWdEcUpXS2swNG9uTnln?=
 =?utf-8?B?eExranBNUnl3QTFXdHdjeXphcmwxVG5yMkFVelFkbldtdW04RHJZM1NQZmxI?=
 =?utf-8?B?bDhzNUdnV2Q3V2VzYlZONG13d3dzeFJRclNVNXdUdEExSnZnQ1B2S2ZIOEJr?=
 =?utf-8?B?K0JTM3lSZXZlWXNoeEk2Qy90YmFobGg1Vk1OY1NGL0x2TVlvc2ZIN3JRUTNE?=
 =?utf-8?B?T3dwZVJzSGcydEo5YytPa24xZENhejZLNmRxQlJTTm16YTVZMGdzdEo0aHdB?=
 =?utf-8?B?SlhreHFsM2lYMytLMytOSFZVbkh3enNxZ2ptSGJVbUtMK1BRYkM2amtUcjRU?=
 =?utf-8?B?RnduKytQeEFTYlVRY2VvZXNFWW1uVXdiUmdoREtMVTdFcjh6MGJWdGJjNlZD?=
 =?utf-8?B?bjE5T1ExRmNQVHpRZ3JWRlpWeHRGaHJoUFpiY2dBY2lSb1ZETlEycWVoV1Bz?=
 =?utf-8?B?Vy8ySFJLRHgwTW40STRITWpRTERxUDZEcnYwNy8rT0xwNjFZb0JSWlBJa1hG?=
 =?utf-8?B?V00rMmR2MXU3ekJnTk9lSGdsbDBnZTErbUtPY1hQdm5seTYwcVZRNjNjbFdy?=
 =?utf-8?B?OFVFSS91a1p1RTA5cVc4R3pFNHAvQk9uNU85Z0Y3SlhLMnpMcXJIWlhVUmZG?=
 =?utf-8?B?eS9mUW1SYVloeXVodlZGbXVvSmZkb3RWSWk3N01VcDN4NWExeUV4c0o1QzVx?=
 =?utf-8?B?Tk9INzZpL05xdXF6ay81dzlSaWI3Q2c0Z3hxbmViNmlZRmdxdVRqdHh3Vkwy?=
 =?utf-8?B?UEUwOTJrVTlGWXZvQWtSd1VQczNJekUyMEFlMm9VdForSEd6dENGUks5WlJ3?=
 =?utf-8?B?N1R1ZFZXMGJjZGxwTHNNSHRXZUprT1h1ZjJzV3Q2Z1U0QnBWdVBXY2JNa1Z5?=
 =?utf-8?B?Z1hWeVl2Y0tYdHE1WXFVZXNpY3ZlYW0xZFFTVCtWTUU0N0RFVmpMTkhBaXNa?=
 =?utf-8?B?ZVBwYkNrZUEvWjN0bEJkRUZkSFBoSEFsTFBFVThKZXROYmlDS1Q2RXJmUHds?=
 =?utf-8?B?LzIyT21vRVdtSjBENmZ3eFVBZDFwTTNtL0lWNmlPRlFiNW5id2l2cWNVejZm?=
 =?utf-8?B?V1hjRXJsam16L0ZGVUVtbnRPcWNXMVR3WlBSSFQwbngrclpXQjMybXFXdzBY?=
 =?utf-8?B?ZW9OYUN1WTFNeVI4ZmU1cksrOGpTb2t2ZDRFTVR0UGlSdFRqTWtsdWd4OTcr?=
 =?utf-8?B?OUhoVS9QS0xMUEoweWJ1M3lkZG5QN3JOU2NqNUV3TXlkQm5aLzMreXVmenhr?=
 =?utf-8?B?NjBuckNDRS9BVUxqREFXRzNGSmFWbmpURGE0ZnFIcDJFZ1VjYjRUWEM4bUZP?=
 =?utf-8?B?YlNCaURhYzE5cXZ3QTN1a1VEdTYxNXRVK09Lci9kb1VQMmRVTDR0NmlKRzgw?=
 =?utf-8?B?Wi81Z2VyNnF3RHJEMSs4L0ljUXNFem8yVUZRMmdpdnlUVnlxWkJIU0YwUXdN?=
 =?utf-8?B?ekNROGxxbFp6d2picHIrcTEzMGZxNVZFcmFBVjBvN1lTd2ppTE5Kc3N0QXhx?=
 =?utf-8?B?bXMwbjQ5NmdpSGlVb002WHgxT0VFWFF3WHdHcVcxM3dyWHB1VWNsaSsweHc1?=
 =?utf-8?B?TUNWM0wyVHRNbkpBYUZMNitkU2hxbmQxTlMzTi9NeHlBOUNudnc2UFlPQmli?=
 =?utf-8?B?OEl0UGtNZXh0N1A2S2hTb3d3bVVweUIrejhKK3pUdW8wYzJPc2Uya0tFdVJh?=
 =?utf-8?B?RG0zV1FGeHJjS1BkeVBOMENhSUUrblNkK3VQMFRRUTJQZ1J0Q0xqSjlSbkN5?=
 =?utf-8?B?K3RKSk5pc3B6M2t0UzA2Z0xEUWRqYlJHVnRhR0VDR2czK0twM2lhNFkwZDU0?=
 =?utf-8?B?V1VoRDNFeDhKU3ZyK1JYbFhpVGY3Y3NCcnQ5aHVNNTF0MzdTTkVXRTF4aUZm?=
 =?utf-8?B?SmZacEIzT2RUbXNMSnMwN1JDbktiMk1sQjRRSllPQUFqRnM3NkZ2N2N5U2p4?=
 =?utf-8?B?OXJlUEFRRnNjdGxCSSsxNUxocFkxNE9iN3plZFcwSmRJYTB2Z1VhWGU2bndL?=
 =?utf-8?B?aklQK2NaaUJ1UXVOSHY0TXcwcUxSTDhLUWp2MFNXeFRBSURhNTlobUprdlBv?=
 =?utf-8?B?YTBaaFdjaEhyOWd3Y25TODduVlYzU3RqalQxK2dKWmxtclZnSDNIdWxBc3Ar?=
 =?utf-8?B?OWo5T3VFVExjdnN3RHVObkhUQmZBYVpha2N2amRGQXRtRHllRW9kQllFQ0xO?=
 =?utf-8?B?K0pZZG9CWVA1U1R5bFB2NnJacDBCVmdsNndyRjdMMUpGS0V4ZURyS2hpRkZM?=
 =?utf-8?B?SVdmdGxZV1Z5S2lnRVU2WFRxVXdLeUVZbWkweGtwWHpGM1NPTmR6eTFmcjVH?=
 =?utf-8?B?NXBRMnZiTmhyTVgvZlUrK2xqd0JJQTdZbW41eVBKMTl5Nys3ZXJudz09?=
X-Exchange-RoutingPolicyChecked: rzKvvpXnpwPyqju9P07w0T5hzIKvlEfuao2ZUsJ8Y8bnQH/wgclMSg/a7acJLtoPz1Y7rdAh7SUvPUVQTFeoWXb7o94XqLK22INRYvjbcQfmETzDS7kr/txEsTBJBnKq1ZsTz0ofnrG4c0JKmwoHtjbIo0O9bNtXO5e5u3QhHAg36AdVQxjNTdrAD8Kuqn4zE4nROYi3HKH4IfSdTfmN7e1Jx0zOvTBJ2R+uiWw+297Xhh38maabnbdSo2hYnfrkiRwrdEy36OTlBBOcVUWtuQrHAQHFH0i2D4+rV697xQf28UXDSUZUs2wbRO/fcyuW39XrnjaXJw9VkxF6O8+42g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KUqt6r2VuHWuN2HkbqGyrSzhn/GrTMMz1x6HHqmRxHy5OkZSpk+2SImGEmh5VHWNSDl+iGoVGf7mc9ICQtCjavhmjMlpDjkoQ9aJw5VPFaE5u3prImRtVGfoxu4l2kZ8tYWTvTr8Im1CbL9WBzI0IU3TJRG4L7JzY2Ku5D+/HN2pyhpXewroE1z/Fb1A/x5HULwDqGplo3SXxOOqOBltDJ5endRrRWa3yjLL+tR+tr2NvXsGX990e0h/Bg0q1KSbdLrGH8M9KHexQI0u8G7scH4XslSn0NRJ5oPs/HvKXbVsu7HnGwXD7FItJfkkDwBHqNe38bppwAkJAQcF/35c9RhqaDBqJnnEMtGQGijYi38yxiYwlwrk/+eay5v1QKPwNLhO9RTz/dRgmAY1w0JXp4Egel6JJU2HWnTo7F5DZbJcuQ1mZAUQKeNcyrV+mJ5uFY5pmvv3DwgW4BGKaeGJIgEIpb0B2w9Y9pE64H/XOARFSuIUjORNOribARZnUdgCGijhknhxvyoxDQGuDeCYLFh+WqiC3IkTCcxOOjDmM2n545k4OUQHmz1fS/fPj++Js+WJCp0j5JMxkbHcwYOD8WP7etKh4H25dKq7ocyvpLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e1b7b-f316-4680-c023-08def6b7ea88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:18:11.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QEldVuxY+3qdxmFB4EZH3QiBjwojFg42a/YpDFS75QlTOxWfakn9QZNsVsKZzYrx++Fb11mOX1B2bDZTPT6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100070
X-Proofpoint-GUID: bBHvxDVto2rhEXSpMns_VSBPr7_U3xeu
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a79894b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=nARipHbfEPCvZBunWeEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bBHvxDVto2rhEXSpMns_VSBPr7_U3xeu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3MSBTYWx0ZWRfX1cGwXD/c7DvL
 DVGXa/ny+RGmGfJQ7Y9PaM6yIlUVmB9Gp7KNdjCkWm288hcmFr6dkMjoq7YpObBRrwmk91dtU61
 kGn0Bt1GMjaovY1uczenzTB66KLFwhHQlmrdmMpj8Uh0q8F3qUxaPgU7r/IIj97I9vJHFjUvJTF
 y2H2dG3LZD2eu2zZOZMpQhPsyxtB2dv3uhyjPx6MczzyceY5QtwdaTEunw6Vve4JJpG1CjLHDgo
 Chp5r6+Z4en6aSyGEYlD7raku1P7Xwk61NCQZk234ylsc8djE/C8e8/27JIN6ANjeUaIVNu1a/X
 pQwVqxivc/g2n6K8o/GF/LXf4dbxDKelIH06fKUj75PfRLFvsJkAjILNCnMLhu5libxlHe7mGiy
 OQroRtjirLQSj0dwt0eBAoZYZURQiU2ZllIRxqi6aX+0bR4W2Yg8AiWlm0hF3KiGwU3CHV/J0VD
 uZEfQ9NqpuiRKDSNPFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3MSBTYWx0ZWRfX6YPNz3Kei3Qd
 A84CV7YZMgqXMnTgRHKc5dxJYHR6sgEi8aJ4yX2ezSzea0DoA4vjXYtt9y0Wkd+0CxSKLZ6yQ+f
 0wiB9M/DEoe/PaVBKITJUbEHSX620gMV4X2CBJM40rfIhwZfsh8v
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_011837_275928_F7E75D82 
X-CRM114-Status: GOOD (  11.09  )
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


> The functions blk_stat_enable_accounting() and
> blk_stat_disable_accounting() are currently exported, but their
> prototypes are only defined in a private header. Move these prototypes
> into a common header so that block drivers can directly use these APIs.

It might be worth mentioning somewhere why this is in blk-mq.h (which I 
believe is because that these accounting functions are only relevant to 
blk-mq queues now, which would not be guessed by the function names). 
But I don't feel too strongly about this.

> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>


