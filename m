Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE34C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qj3lKLonkyvsXjgw6jndwtAcId9iU7q8/TXMfb4DaiU=; b=O+PvmLLwjeqnVuA5hHWOi+CF9l
	L7SUnQcuITudHW5Uj8Rtf04W3RDSBqPQ9Mr7wRPxnRPvkPgbCxUgDsQ3sjYLiLibxAb+OovHFmIMA
	PJjRNU/gB05cooG3na0zKo0oWH4vnu8Dcf5vwu6rW+L/BdI4xUF1a1W+9gpD1zTXa73wOIBocIaFE
	dynt4DrZ3kgPkq+JhwPlzrJKa8+bn7f2eQeASPp6fbECp3dz2T/01eVQiyFd8P2CEZM0kiLzC5lEg
	X9gg1Qcj/1nZkArt+TVPcS/ulYld/7FDK1Cm3V3PYmC8hxxfrnYp6vSTZdlEeEkLnkTYxzRUuOUcb
	9dJj9rGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfIjC-00000004iyp-30ga;
	Thu, 02 Jul 2026 14:49:22 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfIj8-00000004iy8-3I6o
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 14:49:21 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662Cid0B1067582;
	Thu, 2 Jul 2026 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Qj3lKLonkyvsXjgw6jndwtAcId9iU7q8/TXMfb4DaiU=; b=
	mRzGeSHQ2u3iJGINr2OSUnaGkh2aqHCOQ8AUBNgbDOf9ZuRevVu0SX/QNEtS7JYd
	WTn4J4dV7GJ5Jg1N0ZYhC8+4NdgwwNVNis2CFJZ0Km0YjgLjCDQPRJgYiKpvlAGj
	CFs8F3GlTYMjX7N0uXybgvbr8vOpEdX2TepdDSXe++zvYszP5zAv59ShJYrs57Wn
	6vnvgDWwt+/wpR5FS0AHUlJ8aV07Z+AsRANQu2a7PnnK6WLB4eZQDrPyG8+y24UI
	YoQTBzWYxZhMdpccIZhyBy3IOFUucrimtTmJEyPntTXdZgYS9qZe5o7q4Bt1BfOb
	yqoa8zAXa6aP4NqlwYm/EQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26kygg50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 14:49:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 662EmaXJ030146;
	Thu, 2 Jul 2026 14:49:01 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f3u1ye7a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 14:49:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE8HPGJTQ0uPbtTWogcxSmvft3mENq1M5ocrsN54LU1hYcKSawpDMBpaQ/s7LeTyzuQwWb9rRW9sOX9z563GDcghXMCJsoX9PUKUEj59Zjft78ljO8/cPDjA5VhG2x5mlpDwP3g0YKUmDP6JqT2GDUtRUibjSth9uxyZ2UNmLsVF9GUOZ2EoR0xQVA1kJYYKZufXU5+miuxqP22MY7ALEph6unn0p+yPJ+ArYtHgNeRF47HZvMa+CgALLVFFlPhftRyAl5/jmcEiIJC2Hwmxh9AQwPdtK5c1BfdjoesjxobK6rEuQ43i56mOIfOIxinvUVavXTFE23CE2XEzhRBRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj3lKLonkyvsXjgw6jndwtAcId9iU7q8/TXMfb4DaiU=;
 b=aT/zRZNoaOYQTP8CBWhxPPGVwOQoPtgMucsriEkVghcjbhr6OL1mguklq0gjpuDIwJAnW2tNUyo+zc31qyZLT8M5IBF9hppXjektE9A4jy9jyrfWBncL/pMfX9DJGEJx9xoSAjmgxBnt5kdvmX16F9l2ICas0HeMmF36x4Y0UR0iI0QPhsmO+XBvgOPkPrne7epR65pkXu81iWBgX8VFhomyt7/wqG+uF0qI4Xia4ISnYdyp+272AFzSEtPQZo7Ft7XT+HEdb2i/S4V2FeKm2Ntk4oCjSw7iZxXdaqiALPC51QA3BE4aeo8R2PobufV8JN5f8YqQvSTzIiYBsc28vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj3lKLonkyvsXjgw6jndwtAcId9iU7q8/TXMfb4DaiU=;
 b=Sjwp2LIpBWsdzSz+WaW4Wxb/qLgAZineIL6UQ5u1zAlzy07zjtcSDZwKICYgJE97wQh9zaongrbvY17rmT4PSRZJdBzRxw5aUA1U0gBJEJ354UvN2vmo0eHFHTca7MmrLCjOk97aQCautqvCuKkqnUrkgnhgn6Rq4R0fEXVw63k=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 14:48:57 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 14:48:57 +0000
Message-ID: <6cbf1ed3-9637-4c8e-a4f6-84a762161556@oracle.com>
Date: Thu, 2 Jul 2026 15:48:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 6/8] nvme: export I/O failure count when no path is
 available via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260516183709.269937-1-nilay@linux.ibm.com>
 <20260516183709.269937-7-nilay@linux.ibm.com>
 <3bfd53f3-16b7-4585-b528-6745ee64e980@oracle.com>
 <54c163fa-91a1-4535-aded-4beee698591a@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <54c163fa-91a1-4535-aded-4beee698591a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e23298-aa41-4be3-b759-08ded8490b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: dezlofxXZ5WxK+DxoqNRMjMtVOOSOKs9Ur/D3OLF0Q5Rw58D92+HuI3c5OqIlDJGB3AIzg6aucJxBtvkfg5BShGQZBAG6z2HogLWfTmLAoCejefkGbzdh0JDhQ9v97M9VnWiSRv4cUT8RiXqZZ1frANQBVzb/avErtoE/ve0Le+QBCImMW77WXCwnHvs12GwD3tM4+AzZupJ1Bjyb5MM3sOmaBTXyJKa2BciFxLMMLCDUjMkjcieHlMRkPo6/+2O7ZMDMm80YY9/m/PzF81SjSLDIP8GwXGSaslfu7iNIams/1cne8JGmWtjkrCt98aQpIjk8Oe1nCzv+aCjGQsyVX62XvNQhvvxyufa4+laxeM5GhN9LyJfG5+j2lKVzex+rhQdKHi/B3l7SGPEzYka4lvaZ+Rm6m7HVgSvtoboLmXcY1laBET6+eYpYRy3IxLsDxByOoHNTbp0RmtAOVzcqMkoVrsh4TxOi0j5akGktG8V0bkLtP6brKpxl0E674zqByIp8eoymZMEHkj9cYqcU2yPOhHIgaqVbpl3qAiRoRpyV7UJX+dSTk0uQCdcc9jWD9R4Gjt2Y8wjopeQM094NoWCoAOB4jouEPLdrO5N2tCRLXMVtwPeWMsqyT1yT6PnQzdqpLtHv+ulUzfxF8QjT2yZe0F6+g8G91o7OI6KNO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJkVTE2UFJ1VGx6cEVHQUNKaVZXV3JzWVREdjFjaGhKUU5IWmxBaW9mZlBp?=
 =?utf-8?B?ZnY4TXJMZUdEd3FFUFV2ZnlmYUNLUS81YVVjQmhHbzhES1dEYzFMV0xIRUZ0?=
 =?utf-8?B?RERGSStGZEpNVUxQU3FYTHNTU3JmbW5JNDQ1c09WQm9qRGY4SlhMWTNSM24x?=
 =?utf-8?B?dXhEdWY4eVd0Ky9VUThwcTB1Ykt5dzJLQUk4SEdkUExmWGVYa3hyVkN3S3Nn?=
 =?utf-8?B?MkpMSHJwOGhSM21SdFo0VnR2eUIxS1p0cXExV0hta3lORU5FelJxN0JkVmhM?=
 =?utf-8?B?Rll1Uk1zMXlZaWJtNlFjY2xzSk1UNUJhbDE5NnYwNG5GVE52RFpBYTBUMjhC?=
 =?utf-8?B?NFRIV0laT1VKMXVSTmJZc2dvMXNvcUIvSDJtdmxhTlBHZEgwUHFFOHNueHZt?=
 =?utf-8?B?Q3RvTmhxVVlEZnpvNUEyQ1pqNHdxcnJmYjhlVmNVbmh2eGVLOXhlTG04U1Q4?=
 =?utf-8?B?aFMrSVhxN0UwQTVISFFhdjNGTnBQRktIcmxZUGwwZm5TWW1Hbm9nbG9iS0dO?=
 =?utf-8?B?U0pIOGZCVDk0ODRPeG5WOGk0YjFxTmVyQnlGRkJkNFlOdlNtcWM5c0VGU3pL?=
 =?utf-8?B?SGRwa1IvS3NWNGplN2tjMnJLWmgvdkZkZ2d6S08yQWJoK016NERNazZSNjhI?=
 =?utf-8?B?bXpiakVaaTB4R2loZlNzMGsyTThuL2daVkxmK1hCRmQ4cmpia0Zwc1BTMGtS?=
 =?utf-8?B?cW9mSEZ4Szk4WWtYUmduNEs5ZTQ3ZUkyMUhsaWphMzA3QVdVM1dBWUowNS91?=
 =?utf-8?B?NU9kKzZCTnQ2SHBjUFdxUHo3dmxScGU4ZSs0bktzaTNiS2w3U2FlT1hWL1h6?=
 =?utf-8?B?TDR5TGRVOEJVU0pTUld3K3dETXRjOGMyOE0yZklEdU4rcU55aHR4UFRHM29D?=
 =?utf-8?B?TVRhRkwzNUlaNEZIc1JINGZPWUFYM1RDNm5SUCtkQ0JZRGY0ZXFmOVJMend1?=
 =?utf-8?B?eTlxOGtMeHFjWWVOWGNmWmo3d2JGNnJ2OGthNkthdkdoaGx2NmpTY0ROU0Rk?=
 =?utf-8?B?djBpMlV6OUlFL0gzVGZ6ZGs1cU4rajI1c1pidm1OSE8zTEFRaU5wZVF4ZTRI?=
 =?utf-8?B?aFMwelBRdm50a0V3cXRrTGZZVEtFWlp3TGtWQk15K0dpQlY4Rmw1TzRJd0Va?=
 =?utf-8?B?d1dLM0IvVm95amg3a3hiMzA2ZXBpSUFRYjUzYU9BbTVZZnZ6WnpwblFqc3Jx?=
 =?utf-8?B?bENYZmlKUjBnV1R3N1dBZGFzOWxhWlN5SldLbzJRNzZzSlJ0QjBTOXhmdkZ6?=
 =?utf-8?B?NmU5WE1LZXFwOTdlbkZDTjNjVmY2Ny9TZ3hERTdlaCtkUm1kTFRoWDRENTBK?=
 =?utf-8?B?VEZKS2wvRzlUUnNEU0VydnA2R3JES0VsZTdNNHUvVE40MFlmbDhWY2h2bUhn?=
 =?utf-8?B?NjE0WWFreGhmWHV4Y0tZVHZUUWJ1YlZqVnJHNkI1V0VTUzBFN0Z6Tlp6UXFv?=
 =?utf-8?B?UWNjTmZSbFNCQUFYRkVGdUErZmRaZzhxRWhTN3diWDR6YnFRUFdGVnM0V2tk?=
 =?utf-8?B?aDh3dHcvTEh2SE0zbUVON0tTVWRST2gyOXUzaVJZd3BLZHYvWWROT0tpMjFG?=
 =?utf-8?B?VFFTUzRpWG56YVlOSW1uNXV4SE14SlZTdFI0V0xDYmxSYUZzSWFweFc4MGMv?=
 =?utf-8?B?cXZydmQxaG5KRnBFSmxYQjhLcWpBajdibHNETFdHYVdnM1A0b1Z3N2dpWnVl?=
 =?utf-8?B?Q1VCbElMblF0TGV0NWJVSDJMM3ZtdktkVi81NmpWcXltVHM3N3BoTmZRdWIx?=
 =?utf-8?B?SHhNVTNWY2lCY2NiUmVSY0hxZSszOGplaFpCNVM3MzJJWmk0UFkrMk1UUmRl?=
 =?utf-8?B?U3hJakJOam9oNHcrWHpIdVZLUytUSDYyL3FDeDI4UTAxNjVvTC9XYzdBQVFh?=
 =?utf-8?B?NEpMVklkdzFJaFpXQytua05NNG5kUitRVVFHcDNnbXN1cVF1WXNDVk50Uk4w?=
 =?utf-8?B?OEJOd2tNTnR0OVQ1Yk85b2FXeU91WjJySGpIVHF0TkhsWTJMY05PanBONEk3?=
 =?utf-8?B?TUhVZHhRejRsN25MMGc3QzNsUVpVVHRGczFqcXdMU3dyU1l3TUp2cHFtaFlj?=
 =?utf-8?B?NFNXSC92T2RzSlNUYURYbzhEY3RHZlhUSW8vV2RHMUNudTF3anJ5QU5WWnNJ?=
 =?utf-8?B?ZVNSbWxOT1grSk1ZR2krTm1MYzRjTzVHYm5YckJBMjhaSnJMVThNNzgrcTdB?=
 =?utf-8?B?d004bklwQVVHdXliZjFHend1RnZFZjlwclZYWkVWQU5SdlljTDQ4WU1OQkNV?=
 =?utf-8?B?NGJqSFFJeFVaSkh4Sng2cTFVQmgrR29mZHUxaC8yVWtscHNFUE5RanNYeWNl?=
 =?utf-8?B?eEpUU1lkSUpMbURhL1dmZ1h1TzNhK0kvdExlaHlyL2ZBMmZEZlFvQT09?=
X-Exchange-RoutingPolicyChecked: sN4B0GEWhffjhT5zLJnuLUnF64rqeVTcV9VbHJBimuQkQ52mWO1XoSlrtk3dqn+/1zixTrAWLoFqhNiDvAv0jqZMRgafirMAMEajDdd6cYpvy8UMjKy3LwzS+5eVi96fACSWnm89COUDtiRmCBKRgyfYHc+3/vP5BcCoZ0H9j0lvBSfzKmhJfnOC/BkCRc+YaVzCTirLJB+UhaAKMEDb6ULsHxxYqpAJhET7OE8B3dx18tGFn4iPcJEO7db6lOj+sbaWI4ornvlSmZn7ZmSo5onTRJ36dW3FAlm4sVl6c5alDVUVROtfXbO72ZYojiyvG4O4CV359kEICFL5Uggs5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nWRIbt8Fi0g+1TZBB8MW5mtqSWCxSCmXMnHznMDuKg2duW2SRcTT121uH41B9L34IFAq4wX7rbqbEsCNZybkgIfqTzbgPQV086I2Nqjg5jaIPTMKE10dbgMBpj/Qk8jqSTMZtJAsCtrMjlRF1cRJ3QzW1LCljygAXGMF4uvpJU58qqNmgQtM/XhfTtwzh7voyjx6X8Z0Uum4CTawei+4bgGoQFSLbkRqtcZ6tgY9h9q31FUA3dTWltzdWRV/OOQWKJh4OlbPI5ApCMm1QSTk3K6LaXP6PIKKbCc+Ir8ccW5sUafeheUaY5VSAIQO2R/ixlewVOSpsqxCoS/40aFKpd9te8wNYK9qMdjk2izaujb7MT1wo2s2oO2Fo0DokGoDMiri3tfcBoY9/M9h7EHUyBSqlYYetAtOlSuKUdwIJ40QIdzWviXfKDP3qFcEq9DEf+VxYJtgHxbSYtrvIZGoqp6lE7bFMh9X5+zmdarOhsEE6Z4JgQ+Yuj+RcQ54jtiDKbd2221HJ49Nj0UjJCU7s5qYOBgpa8NrY4DsMQSKA+8aBxcUcLmtqLfQ/3hcHgE0hD/shLHTshgL2kP2GKzvOqfXoWBPS/YRu6xldO9tDok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e23298-aa41-4be3-b759-08ded8490b78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:48:57.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 197LrAQ1VuVvjR2tKVWFWxczBXnDPm00ESJI10Db7bHkv6lo+/2HQ4NusopphmR2+NY7cOw24Hh/EuBVbx3+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020155
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE1NCBTYWx0ZWRfX3T2GXsUawIOp
 eMsahI3aDHI68Ku0GD4i7I2A3pEGo6XAsrLEq2SE2SXzRe6uUUpRLbklAt+cntQo8El2XgMlXtr
 OXXrBGTqhiIyu2LMi3HodWRWW/+/fwn/oNlyurVKdGq+hh4ojZna
X-Proofpoint-ORIG-GUID: D3gTC5X6JH5ApRFFOLv-fKhLAmRPgaVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE1NCBTYWx0ZWRfX/B5RzOxA2aOF
 A6j4JuA42v9AVo5lI7EiJpHLz5/KmjpFnfuRA88QXlrBaFN/H/Jo9e8ipkL4ei9u+w+Oyr8C/ae
 +rQeeWl0ze/JE8m8QpnNsp7r2n+vVYOL+sshXkwCKShU8KDMgez3iIzo+KZDg2jmXQ76SHtlcaP
 dK/q7Phog/k0KlAwK/KHZrZw5XuRGPR/2n7QgEMb97h8XAmSJkHHYpCbp/ugEuSoVlDaLCcnR1w
 2V2h2vlfKXRiiZP5SGsBthLLk9BcZr/jRiKi5HDLhEroSozslJwuPJGe+ykwjdLOhoR3hYR5eek
 tsxZ+5K3anWo/BWSNqguY2ZnJrBYtq/YOa1RAjLGQa8V+9iWo7M6NYdkSxaONo0eOCPe1uhjeG4
 Yra76yy0UEWaKQxC3+5ArEqGYNT8YWRZuaASJ4nepm0fra2IWmYgcCnmRkOEtHuPcrxsHgJfzqG
 959soj4d8FysolyrPBeJf59RruaDGZN2s6nRNQoU=
X-Proofpoint-GUID: D3gTC5X6JH5ApRFFOLv-fKhLAmRPgaVI
X-Authority-Analysis: v=2.4 cv=ROaD2Yi+ c=1 sm=1 tr=0 ts=6a467a5e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22
 a=FjsF3RreEQCNCqowwUQA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_074919_139233_D77C15D1 
X-CRM114-Status: GOOD (  14.75  )
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

On 02/07/2026 14:10, Nilay Shroff wrote:
> 
> The primary purpose of this attribute is to aid debugging. Under normal
> operation, the counter is expected to be zero most of the time because
> the namespace head is short-lived after all paths are removed. However,
> if there is a subtle bug in the namespace head reference counting logic
> that prevents it from being deleted, a non-zero value would remain
> visible under:
> 
> /sys/block/<nshead-dev>/diag/io_fail_no_available_path_count
> 
> And yes this attribute is writable (as all other diag attributes), only
> to allow users to reset the counter to zero and then observe subsequent
> events.

It's something minor, but it makes sense to me that we only allow users 
to reset the value to zero, like:

@@ -1249,7 +1249,7 @@ static ssize_t
io_fail_no_available_path_count_store(struct device *dev,
         struct nvme_ns_head *head = disk->private_data;

         err = kstrtoul(buf, 0, &fail_cnt);
-       if (err)
+       if (err || fail_cnt)
                 return -EINVAL;

         atomic_long_set(&head->io_fail_no_available_path_count, fail_cnt);


