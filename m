Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166A6C5B572
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d2mYnTzQ3+t+FbvYSIVB+jgEn1ji0u1paOInftWM4b4=; b=zobLmllYrViNdlTGjUXt5jCWE9
	bXVK0ZtFLre6xjloM5AaIId5g6UGHk2DJ5LF+RwRWliC4u0UQtFsORq4Ztfm+SqGAXotUnqF2FEDU
	5secq/JePR96YFFYD+BAB4aXQIWF/6O9jbZpTn9aKb5YBUB1LBts9KJ3NYfuF/kjhysQJx21Zax3a
	YOochrqPB/ofAsCh3tWoXuqA7OcnfRR3qlvHQHKOAQDfRgAXitTHnX2PxhNeufFfUMKSL859sxUT1
	6gIQwsB96P5FUapencbOLx6hFMAQGgItwGPssxj+xUf2RTJxqCLOwMuH+IzaguMiiBXzaxtHQRAfX
	hUDSc5aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmNa-0000000E5Xi-2P2C;
	Tue, 11 Aug 2026 13:18:54 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmNY-0000000E5Wx-2PL7
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 13:18:53 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDELgJ2426183;
	Tue, 11 Aug 2026 13:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d2mYnTzQ3+t+FbvYSIVB+jgEn1ji0u1paOInftWM4b4=; b=
	sZ2GHBfdKSf5YhhxYRBgPZFu1K9GowWq/+7ItZgvYNivxSSzgG3cs+IqF8/NoCrN
	GE7gu8JBzYAE7RsNjIu9zrV5UvKpQRm1cYhwLckhANmXJovPSVukctoRrgUKwKZ4
	aMCH3C6Rp5TMARUraaFoLE0tP/2kVYiLVHLLoSR1Ntw3ut0jNrT5PDuduGdEY4pQ
	sTrkw0r+3zYzGyA7Cz/BgtKCBSFHQxX317XPmpLKZRE5yUHT9qnBnkwmaJBXSDw2
	j9F9GvdvD5GadQV1/FjAKYPN9aTZKb1k15OAkZTqwW40efdAahyDpN7jU0tnPo6+
	tiwbVy0BwC2R0Est8XO8Ng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvk6cv3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDAk7l021410;
	Tue, 11 Aug 2026 13:18:48 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwqh7a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 13:18:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wERN2WZGFG/SkA8wj65uhc7QP5edl5tCDVUqC70cyPiU+jVn/FS+tYtSNCM0Yf/+ZUq2+DCNvtuvmXTWOobTsEAftxPSQ+d5crcSTNHuOIp72khy7xPdUbvNuDifpk6S/MZsn1+xvPO2iQIVwKs6Iau5hwaUOX6kTSBEoQo4/iT4izOkqIWZ8S7S/OmU17wcXRlwOYUctYQBHTR96Y1q+W6alvqhulnZrJ0PxnOwnR72XmMo4cQYP0ctK3xegCKRNu2yieUBbys0OcRhtTeNuq8Iujmk3HOl1YIqh0pt7YIK+MNM3HNEZDkDTjjeVTBqDkNbxEq6zCOB4LuUXEsIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2mYnTzQ3+t+FbvYSIVB+jgEn1ji0u1paOInftWM4b4=;
 b=CmMCW5tCGYeU7WSo3jZXsV2gzQllaF54HNnn+7Cq2myk2oo7dd1Kv7YGBg8V9v1aoIPTyfCfSJqHBM4UKGeLZYQM7yUh54Uj/AaFOBiIFXLjeNQykFEIIbc+8NQGRohWKT9htkD9IKECn5mJEyuI51SdmhdmTjVzczEKcCkGgNjG0Ry6JLrUx+cMSqouZ4ULsFK3kwgpQsdd67nFmGB5kWlNPiiNhH5DnDP7kzzExcWMNO7gpO7B7ThDoD1Ld7sOcTtY9zsd52W0JE3RDIkwsN6j3FumWx4g9v3tGqxLEbeW5bwA5bNKwJtUKYLroV9dVZ+f6upSAPrAWB99FGYuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2mYnTzQ3+t+FbvYSIVB+jgEn1ji0u1paOInftWM4b4=;
 b=zlcgN90nEuBIxsWfGnOur0I1KDESI7jQE/9yz1O3rJgHdoSEeUGOJzx8rY2OVTBo+wozCO3iQrzoBEA7Lb6dsM9AYL5UFUuVwkf6/g4S8ZnJF7wRQYO+CsxCWlEi1BnON0S7AX0XG+y94S62w+8lL+zVl+cgufrkVVV//4jhA6M=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 IA3PR10MB8324.namprd10.prod.outlook.com (2603:10b6:208:573::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 13:18:45 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 13:18:45 +0000
Message-ID: <92d55da9-2cb6-43aa-8fee-51f2c86101f8@oracle.com>
Date: Tue, 11 Aug 2026 14:18:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
To: wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260810235034.544797-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|IA3PR10MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: b32df85b-0552-41ec-e7b5-08def7ab1250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7Pl+zm7P2deiW+7Uilqv6h97fZYP96HVbmkzC5fZCLL/WYE6HgobKN9TGfm5D8AJWFG7ZItEbakPllses0n0BKUXrcs0ZV7VDK7ar5e6o7M2/ozPEqZF9wjsHlo8gpp2BHRKrsYEZ67anlS83CN5i+7bgzxe8M5E8sJjdoXnIY3rPfd3RVKFOG1e4RXvAsmRPiUQJfasRZ+bAuhGx0ltskqIAtP8DZe/g0C9s9+l+WKjNLoLpn3fJ5r9DDIu9bU6pvE8Np/rK5ftlvGftahmjhpkgZym9erMiX+r1ZCPMFohNEpj9dmqyUbEBsgJZ7u5fILIHM8wuepulhFysusMVK3qsh9RXxGhkk/e3vr2dgdEGqfiVflKSjnU3HxpOXWTm7ufiTEqkjYYRlp6CldDcXdd0I3loV/Tra9dJOYrq45hk8hcKtWMChKrujqFtluDtpSklmhlzD3EJ83nR+eGQ/crUKdaJBDfcpcvcn8UiyCPTJedg3nVXefSE3UTYxTv2avP0wkFX/ptmKmvh8pA0g4iAvKEYZ6F1tept8xeh2GoxRmY9irwtK9Be/2Uh3narqJkQtfRG8QGmavCpykEjXZWM8uU6IKY0cTHTL83qdlD7n0NDepTMH7Cq18A3S2hzlDEcbUPsoWkDekmEI1pImOl+JaohSDo844njBTjcXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFBRHViZXB6VTFKMC9xVy9pRlJZZ1RPV0Zwb0NCZTBueFdCaFJiQ202YVk4?=
 =?utf-8?B?L0llZmdGYlZUN3RWM0pKVFZZby80NkR1dTNPcks4cjdYbzJ1MGJaRDVkZ0E0?=
 =?utf-8?B?Y2JOREdYYk9NcE92MjVCeTNOY203cnBpdXFITU1yaVJQNUdHcVBsdnRCZ1Q5?=
 =?utf-8?B?ZGhvMG9qeHE3bkRncVJOYmNTR3Y5OUliWFVENEhZZ2VTZ3JpK1hvNk9nUEg3?=
 =?utf-8?B?ZFIxRllKenUydm1EeGVOak4rR2c3MmRmUFdwbUNCYkF0SXFaR2FiaWNuVldP?=
 =?utf-8?B?L0tKRW85SHR6VEhBRmkwSEw3VzJoOWh4bTJQSlhDU2l5OFo5UFp6V2I1cGhp?=
 =?utf-8?B?VmxDL2tJTUJVUisxOU1BREtrOWVjQ21tMmZlQW45N2hvb2REOEdpTWtkeFp0?=
 =?utf-8?B?WTBrMnlLYWM2bXM0TFR1bnhEanN6c2pMUHgwWG1VOHcybHVZU0F1T2lVSTR0?=
 =?utf-8?B?RG1WSzRzSTdIdHgxVjU4emNFcGpHLy9GYkc0ZWs0bDhiSWxtZTJmbkR6U3Fa?=
 =?utf-8?B?QkV0WTR6T01pNjl6YnZaZE1BbWp2RXJoaVQvV3poM2lnZ09pNWpMUFZTMlJt?=
 =?utf-8?B?TE5yOUs3SmhkVGFEQUFXd29tb1Azd0xmV0QxZUlFVExqb2NnN3dZRTFrL3F3?=
 =?utf-8?B?WUNRWWFxbjI3MjAzRGJqZGFRZkNIZmRQNm5RR2VlOTA4d0c2RDFDbUcrb25R?=
 =?utf-8?B?K3lrcWUxNjg1TmhkT09uWWN6VlZaMUY1N2tTOUxVQ2RRUjAzbFNOdlhyTWpp?=
 =?utf-8?B?R3FsWldEN0dVUFMvLzQ4OHJJaS8wajllWW1NdmhPODdCT0ZRMDdtTzl6b0Fy?=
 =?utf-8?B?WkxPdDk5c3Y2dFozRnhMZ28wZVRTeDVXOTJwYkozbkNKK05lZHZRd2hnSWFX?=
 =?utf-8?B?ZWRrMlFOVmxuYlhqbXJTL0NQVDZjV0kydjJENXFzcW1La1RXdjB4aVlGNUVP?=
 =?utf-8?B?cjBJenpOYnExTUF5Nkwxa0pBVkxnZUp3MUFhc1FWd3NkWTZmNUhhZ1VjcDRP?=
 =?utf-8?B?VUlhQWdoZGVDQXBuRjlrSktqYllpY2FjNk1mRlBZK2xCMUJ1UFFYV21LYlNK?=
 =?utf-8?B?R3FFMTdCTnF4WmRWaUgzc0lvNnJlc2Q3MFU4WHBBZzBsc3RWZGFwZ2NKN043?=
 =?utf-8?B?Mm0wWTRHMFNPS051YkhlV2N6aTFNR0d3Zm15SExvcVZ4UFNXTHNOOGZFbkVD?=
 =?utf-8?B?alpEcEV6VE9hd1lKaTJ4WTYxTFZXakx2RXhlaFExeHdHb29UVWdqcDA3SU5F?=
 =?utf-8?B?N0Y5bHNiQWZycDVyYTRzU2tqeUQ2Mnp6ZHBkRmhmMEYxMk1uLzBDQ01PQ2RB?=
 =?utf-8?B?RXpIS0JPSnBYSzNTOW9kYU1SRlRXdHdSd3pqYnE5bEpFeldnZlBXSTg4Ty9N?=
 =?utf-8?B?ekVmMXZ3aGtvb3QzVUN3Vmd1Vy9wYzV5ZmJXa0FSZWpEYUxINnltLys4MW0v?=
 =?utf-8?B?OXRyd2pmTnU4bnh6VjBTaldnQmo4b055cWEwSlFDZDdoRVVqQVFkU1ZpcUx4?=
 =?utf-8?B?SUFsSHNsS1lPK2RNd09mOTdPL3V6NmorTTQrbS8zcWVIdnc3SDl1NHpNTkEr?=
 =?utf-8?B?NVhOSG1LK1FQVUJkVW0zKzdOYUNuTitueSszNkVET1dJTHIyU3YrelM4WDVR?=
 =?utf-8?B?emtqVm1Ta0xsSlFJU0hyTTI4a25kOFJOd2ljNHlFODBHQWc3Sk85a3pTR2hq?=
 =?utf-8?B?ZVJnOFNPK2w5SG0xRDIyaURuNVNSVlpISEVwR01oaHpka3BnYVZhdmJmMUVK?=
 =?utf-8?B?MzdSaG5sRXpBdVgrc1c2U0JmZ3NGd2RpKzhodkQvTEpqMnhFRG5CTFJ0dU1B?=
 =?utf-8?B?eHZGQ3RPWlRyTGoyaHQrODB1Mk1UcmtXZk9XTFBXR1pmQmxvM2ZyYlFwVUZo?=
 =?utf-8?B?MktaalkweGNhaFdhOTBqTEgrdytHTmErdWNFc05tbmFhRW03S1YyQ3RZRTRm?=
 =?utf-8?B?STNkbUc4ZTlLSlQwdWJXejdsMGVVd2RTUUVLMnFCa3VNeXFqSE5ISkM1Nmpp?=
 =?utf-8?B?VHk1UFBTbDQ2andvZWRycC9LbjNIaXZjVFRSdG1hRzB4NSs2RnQ0Ri8zVmdX?=
 =?utf-8?B?YmpDU3lVNDVZcW93b2ZaRVVIYkdEVkx5YWw2eTRjZ1ViUEpJZTRwL25pNkpO?=
 =?utf-8?B?OUJ6ZTU1clhVTUtDeGxtcmtoYnRVY3MvQVNReVNkV2hRQXZDR3JnR25ZYTMv?=
 =?utf-8?B?WmFpc0NMdUtlT1BFazdKZDNvL2RzZ2g2KzFZTEZ1bTZvdXhzR1VLWnRNc2Vj?=
 =?utf-8?B?L24xZUtac3RPR1ZpOGZpVWhxdHZxcjR0OEM3TllTcllLWjhhaDdqa0ZpQkh5?=
 =?utf-8?B?KzVMeFk5amhHVW1nVmFYcmYvQUxLTmdqWlpZbDZwZzgwRDB5VlBndElDdlk3?=
 =?utf-8?Q?V+r0RuaAS0ANlJXg=3D?=
X-Exchange-RoutingPolicyChecked: AqglhFaTy1CQY/hxiB8jf493stS6GZXJPlv75VKU8KDgUo8VMRjJgoVSxC9dqM/bvzWeYnFdYGF/2dC0+Y/cn89bRf+KVFcT4gQNUHtItRDLVUxFri1u6W431t7wpcEUYy0LotrfKH7HsicqR1eG94aBalw8m+ela6nQo5UfMvT7uSC/ogpuLCJtkjKVWK7fV6ehmpPpdgUtAceug6D3Ly2y8G3buen9RtES8qVIXsUgXCY9PA6fCjyKBlVHQh0tk5JIEvQvnK1iehItUuSaQDvk7q0L0DaIi97l21lu3ecpbDZ9Tn0p8Xrb7g0VXW0p5+y3wow2ZmI7WbQNRIt6Kw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lH4S4FCNlSxAlYmjyfrGYXh71K949RoWSZcaWV5++q5WJMHdwPESTAZsFXYdQRWZyAeGXFltaB3LoSlYRjr5QBhNMn4abTnEiBXzrgiC/IboFLZS0gk7C6X6VYqK9rfpdq7Ay0DhRKYzkC4XrA5/B4d86s3JmYfIiReGB1SYAnkaTCSaMmm7cy/9SZ+zMpFOfC9Tp+7xPLu3eH034U/W7jTMe9IXRIT6ng1DNGpGlbhnFVqTqiHMppBPO5/+1UuEhCF9u8oPUSXKLcotVrybOsA36eMPJdASpibJr3mlXpsY9UYBmKcBalfN04lOspnc2uH6j6NMaFXz0LNCJcHWLUDHrtRx363z+ltuy+bGBSkwH6n6SXBJw9A49xPVaLJIe2/qyWn7yvLKkw0o3jpewickEpPyrrXbereUNgFbh8Ytak+qjZaNB+myJ1enurTo789hb5n9Nw1R6M4jhSKkGQ7LZNm0ZniM2WrB24qLLQfbc9W47cjPt/s8QCACoshx2i93GuoHSaPF5iz7worElV2jsBr+JoXpz1Q2iYj7+wP9lPtKS44m2RhwgI/PYVY8zjnKzCVr98jPVGz1g65H+XzWWvDWAIFY8epOtqMHgE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32df85b-0552-41ec-e7b5-08def7ab1250
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:18:45.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azSA1x3gl+Pa1Y94mxCCy0FQcWvYWMDXzUYMMJmhTiznCiLCQNch4q2yl1V6P+0D/g89JEMbNOsmW0hy5vYt3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608110110
X-Authority-Analysis: v=2.4 cv=GaknWwXL c=1 sm=1 tr=0 ts=6a7b2139 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VnNF1IyMAAAA:8
 a=k8HUj8Rg_O5Qwjr9YKgA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: xbRe6TtVDi_OSB1UU_IeYwCzn6BWuTzk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMCBTYWx0ZWRfX6rpdwWw97YTx
 pHkXlMPh5eExMdES9PCjq/u2q0vU+5SxYA6yyne+ISXO9CUMgIZfPKpHbPJCcPgNAWrDF4JlioH
 XRWPMRLvGNUxQEt9OlSfVhYFaJwr+tOdHNISJptOA+XEqH7RnnRr
X-Proofpoint-GUID: xbRe6TtVDi_OSB1UU_IeYwCzn6BWuTzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMCBTYWx0ZWRfX3dq2JoXL6kqb
 38BnHNqm2Kc18imvPdntOZrAy/80i/mXfbcxNqHrdpNZ5OfnOf+WGvWiCgDVzVK/l7VJOwgCmd+
 WvaxvZOpuo7HQd17SRNA0YGXqyp6IQWS1OTkeWHLhkOUGtxxLSxyLJPBtM0c5ovZf5Py2Tcc/GE
 ZzmhhSvXRixQ4iakbQZ8S35gdFMOzLR3EXRxfvAnhy8TYytKOhk9Qx3mct4GKW85yYPfLzagMCe
 diEtfUNiXjj3DIeTmYhA/RV7hZqzMZnUOfWh3EwcRRH1E7dCEbBnpPVWdb49VvC+2EsEbSGrOzk
 biVjZDAVCWFa0p3nQeaQmyJydu5SGTSDOfzUzdfyGVuf596iyiYJ6YErqdJZgzW+PRwGpvyStaR
 w/G1+9VbTltgjoicDeNLF/c/woGvXmB3FAyMiCexlDxgV5wydV2EF3ALcct2HpJ30cGJ0B75WO+
 cMFxmroBZ28WfgOMEPyrN9i40K++hI99F7Z7NlWM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_061852_634296_CD0AAEF8 
X-CRM114-Status: GOOD (  26.40  )
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

On 11/08/2026 00:50, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong<wenxiong@linux.ibm.com>
> 
> Ensure proper module reference counting for NVMe multipath head devices
> on open, preventing the controller module from being unloaded while
> the multipath head device is still open or in use.
> 
> This patch acquires a module reference in nvme_ns_head_open() and
> releases it in nvme_ns_head_release()

Can you demonstrate that this is a problem?

Can we remove the controller driver while the NS head bdev is open? If 
we could, then any NSes must disappear as we could not unload the 
controller driver module while the controller is registered and has 
NSes, right? Then with no NSes we cannot find a path from 
nvme_ns_head_submit_bio() -> nvme_find_path() or similar and would 
error. Or if we have a NS reference from nvme_ns_head_submit_bio() -> 
nvme_find_path() and then remove the controller and its module, the NS 
removal must be part of the controller teardown which does a scru sync 
per NS, which must wait for nvme_ns_head_submit_bio() to complete.

That's the way I see it ... but maybe I am missing something.

> 
> Signed-off-by: Wen Xiong<wenxiong@linux.ibm.com>
> ---
>    drivers/nvme/host/multipath.c | 29 +++++++++++++++++++++++++++--
>    1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..74c3710bf5f7 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -554,14 +554,39 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>    
>    static int nvme_ns_head_open(struct gendisk *disk, blk_mode_t mode)
>    {
> -	if (!nvme_tryget_ns_head(disk->private_data))
> +	struct nvme_ns_head *head = disk->private_data;
> +	struct nvme_ns *ns;
> +	int srcu_idx;
> +
> +	if (!nvme_tryget_ns_head(head))
>    		return -ENXIO;
> +
> +	/* Get module reference from any available path */
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (ns && !try_module_get(ns->ctrl->ops->module)) {

If you cannot find a path then why even allow the nvme_ns_head_open() to 
succeed?

> +		srcu_read_unlock(&head->srcu, srcu_idx);
> +		nvme_put_ns_head(head);
> +		return -ENXIO;
> +	}
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +
>    	return 0;
>    }
>    
>    static void nvme_ns_head_release(struct gendisk *disk)
>    {
> -	nvme_put_ns_head(disk->private_data);
> +	struct nvme_ns_head *head = disk->private_data;
> +	struct nvme_ns *ns;
> +	int srcu_idx;
> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (ns)
> +		module_put(ns->ctrl->ops->module);
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +
> +	nvme_put_ns_head(head);
>    }
>    
>    static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
> -- 
> 2.52.0
> 


