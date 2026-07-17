Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6D4C44514
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsT54inBIQ2Zivg46f5mVNPYAKUkWoxwVPRYuQ8p6m4=; b=uKxqlneDMn9PpcNzYQI7geGabP
	NUEA1k5Hq4AKCOKTvPhE6qrpbX826mu6MImt315NcRm3ADyKw1LVY/qXsKvHu6V39Af2BmnyZ7UPx
	4N0IouK7gMMA0FkvFN2FzK3indM/vB7UtzU49Excyqn44gPbMxLEo5Uy0g9EK0Iwhs0d3a5GO6Hd1
	OxYldWub/gT40066DIy/FS5UxGC0CnrFdaEuQ058R20HXp0RU8kisrUBZ/OayhuYsYv/ZNMxaVkSE
	I9e+R7DSR0Zt5It+VpGikce9NreWUOvCdo1sbAdG5LzH/DvN2NKXRNrYXU5z07n8CUA9hjMu1pH5g
	YPC6Iwuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdQs-00000001WW5-2seW;
	Fri, 17 Jul 2026 07:56:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkdQp-00000001WUz-0PTE
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 07:56:29 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3Dacs2865213;
	Fri, 17 Jul 2026 07:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zsT54inBIQ2Zivg46f5mVNPYAKUkWoxwVPRYuQ8p6m4=; b=
	HUGan2XFcdERoX24Xxj58zCrNYVVw5hgfau6198COB1BfVdabw58YYMymQ8yDDYB
	GNuTME6/Jn2bD3/RkEw3Tu7yYblUQLLYPBgvjEiPInCLzx1CnMW849dEtGoB5Ba+
	70MYtnukuORJniMzVkGJVepwXncwrRNV3+/lLNOT9ykmE5AWAWQfyowyfkjOE+vh
	rCKu1+rpfsu1kr/TmeYkCZg2n6Ql8T+cINdsIGyiEVrQC3o8Aa/3oB4ooZ0Q4Gt8
	zm398NeJHAMRDI21ljTOjUQ6Bq3M1i9T0w/yew6LMVOvYxAJHZuKTQBuJff0bCWN
	N0z085KGOxqwu9AEtZLePA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fdhn0ecqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 07:56:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66H7raKJ024240;
	Fri, 17 Jul 2026 07:56:15 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9msybq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 07:56:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfjLYfQneKju+IjiNDZ0YMKYw3cUafEHComyGlvhN90VdzQso+6KIEwpfx5wM4gANebDyP301QGffSCZ+jgwa4JhbaGSG/QcZTv4bqIxrgAuFVm8tXLNEVtVIFVYqf6faEK3WS9i+C6L8MNK6mrqZxiGbwSJL6MORCrPPJ494Yzuh1HHLyMXp+B8EqfkT/jSHcysTY52hYG25cr3SfmJMkjjloNBAe4W1MuezmYdzeQ7F1P3/LLKCkrIFLym5viyPDrhE5sjp88zQUA0h9N/wSAPHO2978LnFpN5FjeAyspqnszx2Wk0AHCqta4+qSljyuhT8dNyO6RVz9FHjy9xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsT54inBIQ2Zivg46f5mVNPYAKUkWoxwVPRYuQ8p6m4=;
 b=DRQTIgieYlKlCq8hGgKbNA+A+jfdUIpqVpyA70GzPJ3UJhniXAYF8wMqF+WfVC9vZyx84j+jol2X7pv0hIFLbGYsqboRsrX1o3dTubeAvfJbYImtFd3sY6SLP9Je+unp92G8T9HOdimLnQXtnnf83FLXPS6SyErIzZFay6P8FOiIabRb9jjQtS5nGWlAnNJ1sSGBx/QxlJEgEyx5va+cNa0ecRs8/oaTKvQQR3RlOdAXfrAbVOgXYkizXS3aD/os97pAnC3Cq6Ijfu/71OvSU3EJuAZRS6lQglM1rqtA3tgDDoxvLS4mDtnDzdI4xQVjsqdvYeHJo9HD+RKf3QOZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsT54inBIQ2Zivg46f5mVNPYAKUkWoxwVPRYuQ8p6m4=;
 b=gg0QIDoEtSZIQ5HvOvZv6ADGWouPXAdq056sXxtwmXXfs12aeTVqTKo4EuPCTFUNlCHzKAKeNJHAsqKx0Rl1NY6KfMLOn9ZHGOVLk1qByOGdTTzSnzgMsYkRDbf1l61NMmKMU/JO2FJ+onhaWHRY+B+fmZDY/+fgTmD4acDL/9w=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SA1PR10MB997607.namprd10.prod.outlook.com (2603:10b6:806:4b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 07:56:13 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Fri, 17 Jul 2026
 07:56:12 +0000
Message-ID: <b376afd5-cdc7-4493-af80-ac704c06aeee@oracle.com>
Date: Fri, 17 Jul 2026 08:56:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: fix cdev lifetime
To: Nilay Shroff <nilay@linux.ibm.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
 <20260713104238.3034640-3-john.g.garry@oracle.com>
 <01c56065-b785-4cc6-87b7-47a0078ebc67@linux.ibm.com>
 <d00a2702-4713-4f29-a7ee-7eff52aa5c23@oracle.com>
 <c1df32ff-07e9-4f1c-b7f5-2dce2c43352b@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c1df32ff-07e9-4f1c-b7f5-2dce2c43352b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::19) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SA1PR10MB997607:EE_
X-MS-Office365-Filtering-Correlation-Id: af22466e-fa6f-4e52-6f6a-08dee3d8ded7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|5023799004|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6LV/Dp09FtnVWaRVkftFiADw7FqpyHz5eXhoKDfIGFJ2lnBen1F0wJhB77H11n0Xty8KgbsHa8ejBO77YAtgaAq6OF8VDZ0pCm2x6Yp3yixOjjzSpIIdZr1imRtiKBv5KvoRkHcBiB/qBHTk4wWlZ8J5bOff8F3GmjDyINpkyn2tjY1BrFFcxe9xIFvifLRy2h6neFMZW0pmwk8AFCaWDLZQX449rg6QNYUhgQpuB/qOjJZn+TcV196OYuDlApVSHw7EHasXYJ65wrxwUEaJU02p9jXzfvB9xhxRo9OjcDtrtE+wcH3acCCv9+/h7X3HB7FmezxSd9ZP+/SRAcEX+cyPcMFgZsXrnLTlEzVCN+ekB9Zo9AZlVNGytRWPzglrsHSSIMBlEKkiSrwTnRJ5H7al4rNZX+RCZuYKddpK60u+FSnYeQFXKe6ajy8WjZH1TBDC46EsmA1thwdulef/dUhNoF6E4DVBFUr99gVQeQPwSde6+4CkpynD9J9qVG8MEhn9OmlufjV4m7+JvegY62+I7+bVXQwiUAPb+H4OKJR5Qb1nN5BQVhCnzYq7lspAVeVn9eS8bdHVfR7/Uc1Bn2z4nm39kTOU3RgxS6IkjxLU67R4V6gnnNgKhR+PQ2a/bgSGFsIDyZA7Z19sY5tf4f4/USX1HO3lkWUCuaE5WuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0c4T0pjbVZDSVY5VWtpNmVjU3lkTXEraVVzYnJVUVlFTjhnTVdXZUxMTEZk?=
 =?utf-8?B?MUlBc1F5MUZ2OUs1TFEzelNDNEJvNVgzOU9lamVETXB5bVlIZ2pLMEY1Z3Ur?=
 =?utf-8?B?RWhKZUN2YjExTWcxeFRCSkRDRjcxblZHdGtEV2pINnhYNGQ4em1IUXlaa1FG?=
 =?utf-8?B?NnpNK1E3NHR1ZjROU1BrNGRNUUxaWk5HWHhLUGJkVHhqSHF3L2pEa0RTNncx?=
 =?utf-8?B?VVc1TC9GWisxQ2QxTUxDZGtKaENoa084NmlKZjgwU3JRaUZIaW9zZWJIVHlr?=
 =?utf-8?B?Y1pGeWhvSVU1b3p5SHEra0lCNEpUckNIeXJ0bEZ6bVhQY2hiN05zMXNnaUtZ?=
 =?utf-8?B?WngvMmUwdmpxVG16a2pUS01KVTBDckNYQVM2akh4NlRwWjdhNGFHbG5BR3No?=
 =?utf-8?B?NGx4OWZNbk1Td0ZMU0h3UTlCMlZHMi9yTDUvNHJrbDVWWE1oQnI2QlplbGdI?=
 =?utf-8?B?akI3V1RJL1N5dlFlTnRXUHhpUnRYSGo3UUtZakZ3bXU3TjVudFBPZnlyajIz?=
 =?utf-8?B?NXhraWdJNENKSnpDeFp6STNidnl6aC85YnNtM1ZZQ3c4YmZPWk0zaytKbEUx?=
 =?utf-8?B?eG9lSzhwWGh5RDAxdnVwU3N1cnhSSHJoNUdIVXg0b0VXbHJSZUtzREh5TFZt?=
 =?utf-8?B?OXFmZ0dhOFJGWmNsWFBBNXQ3KytiUTU5MTFrVS9KcURSNkhQeXljVnI0VTFj?=
 =?utf-8?B?NWkyM0lqVDFkNk5lUHpXUUhqUmxsZUtINlVveDJKZzR1VUQ5U21kM0c3d0xW?=
 =?utf-8?B?S0VuYVJ4Q2NQZEUyMTNsdWpqb0w1K0dlbUtYVDBOdkFWeTBIS0FWd3J0OG9S?=
 =?utf-8?B?Y250SVlLbVBIQlZtSms3Zklxamh6MjRtZmlVZHFvRkxvVDJQOFFaSnJlYmRP?=
 =?utf-8?B?Vy9jbjd2Y0tCcjdHOEN2SUtCaTFaYkZ5bk01bThTaGNWUXJQMTdNV1FvaHRm?=
 =?utf-8?B?OVpqbTFGOFhrUHlielJnckZsWkpWU2VkNzBaL1VndHlaTDlWVnpxTnMzZ0d6?=
 =?utf-8?B?alF0cXlzaS9ISTkyYTRTaFlIUkxETDRJQzNKb3VjbjBmY09xUVBIaktGMWJj?=
 =?utf-8?B?bEllUUhvOEpjS0QrSlB5ZDZwZEV1UFhmZytQZVplRSs1OGJ0MXBMdXNNWkd2?=
 =?utf-8?B?TEx1cGdVY3ljdWROOU1uU3lDZnZJTWM3SjhVQVFsYy9WU0FrNjcxMUNoL2hq?=
 =?utf-8?B?aHVLWW5OSVY5ZHRBZXpCYktsbTdBS0hhQlZkV24vMnFEN2l3TnpSKzlOeHRD?=
 =?utf-8?B?S3poRWpNSElTOStvc0NhNTlTNmVBc0FZc0MreEdzR2FJVVJ2cFZxQmpPM3dO?=
 =?utf-8?B?dCtRYXJkSVIyZzdiTHRyM3NWamlod09veTkxSGo4L3Zia0Y4Z1NITzZoNUZr?=
 =?utf-8?B?ci84MjdPMFR2M2FYYzhJYXBOSHhmUU1LbWo4N3I1bGl0Wk5EbUFkYXFxRjRH?=
 =?utf-8?B?My9DcDZiWm8wVEs2SW5XV204Y3ZBVEZZM0FJUUdmRDZWc2VsN1ZJQzg2NmQx?=
 =?utf-8?B?ZVRkQUIrUzg1cXIrZ2h0eWtaeVlhcWlZK1Z2WVNnMGVWamxDTDVNRzNNMWpV?=
 =?utf-8?B?U2JwUXFudVAwOUxrUlJjdm52UGtndnJOVE9rbVUvVmJSOWY4M1FmNmk4NExF?=
 =?utf-8?B?MHVRZExFeExzWENxdGtpMWtiNUxFYjlDbDNIM1ljZ2phVHZhZVZIckNOQmgy?=
 =?utf-8?B?Q2Zod3pUeXZNOC9WZjBxZW1xbE5RYjh0MDJGMnhFNXcvRXFKemphZE56SU9M?=
 =?utf-8?B?MC9tT2luY2VjYzlxNkRnUExIbFZUSndOMFVINDBmNDVmRjdFSUJjdGVBSTBG?=
 =?utf-8?B?MGtWTVpkM3ZlcEpMRmhLTjRPeFU5TjFoYzdNZ1BnWjVlK0ZOdjVFL1FOZXM3?=
 =?utf-8?B?NEdaSGJuYkxRc01JbGFjZzhMZEJlNGt1dUYwKzVqUU1BelNkMjFBczdxbHpw?=
 =?utf-8?B?VlE0ZDVCQ2JpdmsrNlVsVTZnUnp1QVVnSUhxb2VRTjhROXlNanJOQWJLQ1U1?=
 =?utf-8?B?TmZyeWcxdVRhV1lBOTV3b25HTUZ5YkU4aWpVZy9NUzZZbzJHeWRrQW1nYm03?=
 =?utf-8?B?VUI1djl1YUk2QnJBd0lIakRWSVJiZnVma25paTFRMXFHUE9aV3lPRS9WTjZx?=
 =?utf-8?B?SlVQdkZNdUNKeXI3YUtMVFNVMHVqaityRFI2bjBZN0Q1YzVtM2E2d1h2ekha?=
 =?utf-8?B?UnV4WlVCUzV6TG9QY2FkcE5KazBIRjhaS0xoZlFpSG02SjFyZ3BsdnZQQmRm?=
 =?utf-8?B?SVF4WlN0ejgzQ2QrVzdMeWVLdS9nR2lrdG9scnNmcU9jWFZDams5MDQrKzBP?=
 =?utf-8?B?N09OYXdpUWVXeWUyTGpaUDBKTTR3bVBBSlNqeU41SHozc3VlMldlZz09?=
X-Exchange-RoutingPolicyChecked: GBSAvJI9pFEZ0Cr27doIde2s1HWR5GgCgaqsYuwUtcZ64GxNwEb9mN/sD0n6R7Ubx7hTAqMMLP2b1+b+JEYRe9FQ5UrVmfHM5GHBMb07VYzes9J7tV0Svi7BRkreHg7iFMgGmKypBr6zIz+lcGmkULHL4mBqaEVvtFJFpxunT0j5wpn0rS0tQLUVwA96OFAdzNfIUgH3BdjkCd4qR6PnMZC1J3jh4YC0tsIkoIpx+mS3KMm5QK6qL2q4aKhHsoLURB5uzzMx1msGrwdkQbXMqXPTrvHR1pOWiR1We6wRjecsS4TAkgufG21c0FPBYOLaxbyHbY3MlxTL7fJ+rzugXA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oTu5/ONFdOBxdrqgcRL1lckFhlz1v6/KmkGzrL+F+MAX2rzU/l7DMNmOPJUHHmdhTZaOPYpvKWddniIEZqjYvlfpOnCBw1rtC8PUqH3Llt2QJNsCMewLEjEjMN9G8xySCCRmPm+jM8J07kU6nU9F10cwA4L2SyOBJLV9rd9jJjbgKLTyQLrSfFsh9UWSKI3MZ3PBhuQ6YAQgaCFNa/fpkw6sn2CbsBBBTlyRhjLQMfCMJLjMYD6EKUWX/depV7r/7eOCGTSCBYeL3S4X2oxvhW832qds+yl48fnlgCvWosqVGDQJd7TCDwsH62r1MY1/Lp6XPtUtMQQGPyDk4LBwi3Q2pJR0gLX0W1Gp5XYNCqVPZx4fTgPgVpBhUZlzPfzL4mzJNzGPmzyycovbT5AhNv+5AfWTm+Qc2d7I0FZRaSmwx6r0boJqayZNiKmqLtQagjh7r0i48LDEWoYRhaDs7KdoDte91rAofpcXZaKp9lUnJRCn53wPE2vC1c8pBl88dLWFW/Y7x3OzwUkG4mcvy+K/fqptNzRrJCGBoN+HaGH5/qNYDeyq1qDdBeqM/7kePFixCKWvBlJJpknsBjUN8Ohq5790GznLzFap4s+XSng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af22466e-fa6f-4e52-6f6a-08dee3d8ded7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:56:12.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSHzA6SWtj1uXlM3H7CF9q+r6cvmbdhwragRcnYQ+s2oP6dw9nkY3f/mbb/62Qs2oNqdZvgvYHriLxvYWxDGTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=940 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607170077
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3NyBTYWx0ZWRfX7sI6o0jPkfsY
 9A27rDn/MHBr8A+BD7AQbS0JeJiFrhBwtJ6M3iWkil4fK85CtVte8CgZl1HSrx3MWDoeTj0tfE0
 pnrAppeoz/iDsePzgCKCuuhATcj9GOivNt5EfuF21exi5Poom2H+
X-Proofpoint-GUID: Me_AedLFJzjAOa_bkyiPLIHE7blg7igf
X-Authority-Analysis: v=2.4 cv=ddewG3Xe c=1 sm=1 tr=0 ts=6a59e020 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=SZ2RtgVRRiorzwcwxokA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12218
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3NyBTYWx0ZWRfXwWnfK4Ly78Wt
 BVMAX0E8dM8rx8t0KK5N782gACWu9rMK9YM4SVYg5OGbCTi2WaUdUcH5s24uG4x1tL2kAOcCu8F
 9//i5QspexJvtqDil4fPrmOCCmaImX33UfmXehAyGM/teEaH5X8xtCY51SGwuL76LXxYwMLsnxQ
 H3IjV8jIYKkVmAiEESNwUc9T+QP5a4JH1ijwE2UjoXm1GMZZmNiOdTi6PrsvONDzQDZqnq6ihCG
 j9SDLfBLeTLWw4Yv5T31PGDgYWrwE96Z5JLJlRYLGCAg6WLlB1j84y/WLsm1kffJAXtRqz7YpRn
 yKrpKEqPO7729p2vBYjAuZHL/zoj9JmKxmxb1OW8EMtTeo4Ex47elF6X6lUeMrHYcRNxRmdqNNp
 woxH8O8s9hQn6gIBHsR/aBpFAf5aPrpnoZMrYNtenzzid99dhWG+559QBlBX5WpKi+htE3p79gW
 NdPyQoZrZEs+PfHUW0NlL1wUGoBUqiLdiRm/Q630=
X-Proofpoint-ORIG-GUID: Me_AedLFJzjAOa_bkyiPLIHE7blg7igf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_005627_684488_19EE6A88 
X-CRM114-Status: GOOD (  16.40  )
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

On 17/07/2026 08:10, Nilay Shroff wrote:
>> nvme_ns_chr_open() and nvme_ns_chr_release() call nvme_ns_open() and nvme_ns_relase(), respectively, and they do more than get and put a ref to the NS - specifically they also check that they are not called for multipath mode (as the NS bdev/cdev should be hidden) and take/put a reference to the controller ops module. Why are those addition actions not required for the cdev? Or should it be done when we add/del the cdev (like in this patch)?
>> 
> 
> I think the first check in nvme_ns_open() that verifies we have not entered
> while multipath is enabled is essentially a sanity/paranoia check.
 >

And just a nvme_ns_chr_open() version which does this check has no value.

> As for the module reference, I think that is redundant for the cdev path.
> chrdev_open() already takes a reference to module before invoking
> nvme_ns_chr_open(), so IMO, nvme_ns_open() taking another reference to
> module appears unnecessary for this path.
> 
> Unless I'm missing something, it seems nvme_ns_chr_open()/nvme_ns_chr_release()
> don't provide any additional lifetime guarantees for the cdev beyond what is
> already handled elsewhere.

Yeah, it seems that way.


