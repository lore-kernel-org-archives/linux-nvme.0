Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0958DC83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BAn1FKkeeOlaQdUdsyNO0AojhFHV75ZJZITLfsmVlM4=; b=zD9gQMCK12TAq14RbgakSp314U
	zoT9sgyvZHNJqMc8JqONOK8WuzQQLa9jYCzEq3ylLMYR79mlSSCaWqiisi5skM5xsjyA1J86xXA7E
	RZ2LU+tfPAb07MGnksOR7G5hiCGua5gVLt45RpQE0IiuhnzJmw9PntX6VqVy42XLwaj/2tRflp1TR
	ziNY1x1tS/g+5O5HxkAM7Z9kGCPDXghDrkpYX+kJ+nnagpy1kF7sNWxdgwsVrhGbFLh18VknSPt3G
	YVt6ItkcoMJEV74bfKrQnz1D/yF0LrwJrBBQrFJdjhOinSi99SEwRvoIkBnezt+PRmNSOElZIuaix
	/HhQFGkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubOFp-000000034Rt-2sXq;
	Mon, 14 Jul 2025 18:50:21 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubMsw-00000002wnq-1Tzy
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 17:22:39 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EH5D82031472;
	Mon, 14 Jul 2025 17:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BAn1FKkeeOlaQdUdsyNO0AojhFHV75ZJZITLfsmVlM4=; b=
	LkcmGrgpLXpRt2dP3T9azIKfa1D8DBuTWEGfrtR6MS1xFjAx41MzyhFjG7eVbglk
	JTTgDgFbsOAYR6FWlhv9ERdOY4EuK1Olp7++lGTgNhgkSmOA11BHOV9H2PVvfkX1
	Lf6sHYQ1e12xjuvoEtH6yz36H1XZmIo2spD4H2gfUV89jv0/Bjv5XZjQUkdsb1Bb
	npze48KCCVji6XztxLzoiaM36zlb1NszgsYeT74swTTrPl3tj/RprotbkVYxumVk
	7gWsKf6Cp0glMp7qDPqLj2oHZldIYJjqKxiZsX68dD37gV2lORE2uh8iS+fuJcXr
	DRRdOz78mXCn8fAwj2Swlw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4mq50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:22:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGKYpa013811;
	Mon, 14 Jul 2025 17:22:26 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012017.outbound.protection.outlook.com [40.93.200.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58b1kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9VkYW1GpNtkaXwOD+eNRAcXhM/oC8lPKaUatDMqoRTz9IRcezbYoWrbjWGDLwUWoP1uVCsf+IaMg/miVlUlIPw6Q3OKR0WiS57tORvXd4xcx5/WLkET8mhDIYfL7BpsbXM2q7Y19us9AUbXux/fMouVJ9r8YsdA/Cxy0idV0K5631+e3cgIfTMcROKGsMkUevUAiY9Al/PSnsB7FqXxIUTBTRIw/sKrrG9tQzpCTbuy88N+4PlIiB/9S/4alFpDNOmCEaI+zArLLhcKVKy9G34BMUuJHvGQ4YEohOeR86gawzjfz2xnG4e++xw1KPvWe4BCC75oDkF9xVbGVxa2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAn1FKkeeOlaQdUdsyNO0AojhFHV75ZJZITLfsmVlM4=;
 b=CkvKIiH5P6uHqntEvHIrAn+J2EUvKlIaQGg98GueDauuJbPVUfDpKSZxu+6xSAcAHD7aY07wLigl8nCJVI7WCPAmQA5Gjezwn/zfS3Pw1zf5xyb/8gKPI61ZuqS7CcsuZOx9U5ai0tW4q3Gm4nIGA4WMjm2HUSUX80uKt0KidsI64Wa/axKgZkHiQtIP0WEeQ53vh+L/W5fxKtrznMHCjMO0xJRQ6pLZ7tsSzZPOj3l3KGDpkpk3XzvcLFuxxvjEm5W4p0+KsRNIxU/IEf1cuzukZ1dHJvW4DqKVzYECZk1Q6TnPNrEknw80fmBI8Pk25pX6hoWDljZoiaqic/Qyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAn1FKkeeOlaQdUdsyNO0AojhFHV75ZJZITLfsmVlM4=;
 b=iyrbWGYPgVkROGCY3sJzd0ZUedobybfGlQ3hyPuZU1/K6tXnxCDmTdXShal1TOHqxmolIoakZpK/f1rF9db/QkhuLkYeST1nDN28o3N7tm1kqcCR0/zWK4Kd6IOg0SLFuHG0ncjdHyQgwGQp1N3KiRbKELeHiSekckrbYgYfttM=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 17:22:23 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 17:22:23 +0000
Message-ID: <f56cfed0-2722-4f87-b838-df68121ea069@oracle.com>
Date: Mon, 14 Jul 2025 10:22:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: revert the cross-controller atomic write size
 validation
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Cc: John Garry <john.g.garry@oracle.com>, yi.zhang@redhat.com,
        linux-nvme@lists.infradead.org
References: <20250714144406.1692041-1-hch@lst.de>
 <20250714144406.1692041-2-hch@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250714144406.1692041-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013317.namprd07.prod.outlook.com
 (2603:10b6:518:1::7) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: a5126031-8f9f-450f-30ef-08ddc2fafeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEZOYStkR2xFZEFmL01yNEtpcnJYdWhsRnhMTTJKbGgwQlhMUWVCMDhZcUFx?=
 =?utf-8?B?ZEphb1EydTlSQjdodTlTS2dOUmQrai9OR1duc2l0VmNtbEhBQ1VNeWFpelNS?=
 =?utf-8?B?dTU3M2R6d05LMDZKY2oxK2VMRitiRDQrbkFXMDh3TGliRGdiNHJEa0ppTHhz?=
 =?utf-8?B?elVVVjVPcXhHNkJmaE51U3UzTTZyV0FXZVlKUmswSFlzMHlNM1NvZFIvdTk5?=
 =?utf-8?B?d3RVZzdnMmdUV3NUcG5KNHJnTTR0Y3QxSUxuWkd4enM5RlA3dmJlbllzeXVQ?=
 =?utf-8?B?aHY1NXIvZGloSVAyWHFQZE9UQWFLRmhhMFpWUHB2QlQ4QjVUbVNwLzRlMFhp?=
 =?utf-8?B?VHcraXdRMGdXcHUyTXVMNUpSTDVqQTJmd2psTFZpRkVKa0VFZjUyYTAwQjV1?=
 =?utf-8?B?SmlaTnhxb3BpeFVweDNUU2hlM0hPWjdHTzFFdjc1Q2FpMFlVcWM2YkR5dERM?=
 =?utf-8?B?Mko5L054ZXgySVNLS2dPdmVRUjJvSFRQUkJMT1IxNVdKa0tNeStFeEhXUkJY?=
 =?utf-8?B?aVVSSE9rM2IzaEg5dFhwc3RBcENrekhkdWVFUG1IOUFBSllTZThmQURoZS9h?=
 =?utf-8?B?aGdJTDFzQzNIdWoxbDhGVXZrcGIxOWdUOGVMK3Jlc29WcnVMczVDNWdsbTUx?=
 =?utf-8?B?cW9UUnhucTBBV205VFFDVFVheVVKV3AzOUMwYXZEdVptaEFlMjlKNXpMYzFk?=
 =?utf-8?B?MUJvNlRZcEZkNTdHenZCYTlyaXdwSm1yUWdOYzBKeGNocnJtb056L3dvSmtj?=
 =?utf-8?B?UUNBODBmQy9wUTJJWnJNcGZQSjhvaEdMdkFZVVdLelNXaFZBbEZiS2d0MEY3?=
 =?utf-8?B?UEJwZy9EMzFGQTNLQzJqV2dwSkgraDMyMUU0UGpxdzVFa3Y4b2ZPRWg4MWFO?=
 =?utf-8?B?YkZnVG0wQ05NcjRmQ2lWenJwUThYcWZ4V2hwTUI2U3hDUW1YNG9kcXVTTUMw?=
 =?utf-8?B?M3VCeUd5VTFlTGE2ZDdiRjJkYXdBQW84OEpuUzEwYTNWdS9XMlR1VGJ5VmZi?=
 =?utf-8?B?cUFZSUZDRlVMalhJaVQzNGVSMGErMGRDSGZEYXBUdG5UdW02UlBkNkxiMStK?=
 =?utf-8?B?V0hzTVBQekVoaTRRdWlJem0zWERTRXlsazVsK1V0UVduN0R4bklvQ1h4UWRt?=
 =?utf-8?B?V2JBRUFqSHZJV3Joc3RGb09mQkM5UEhreWlNbnZUdWkzaUtObndYVS9TVlJG?=
 =?utf-8?B?VlFWNCs0TkUrc1hrQ29Td2FxeFk0Wlc5ZUt0NjNWdEY2bHltYVJYTCt4REVv?=
 =?utf-8?B?OGdCczlsdjVwL2Q3ZHhPM2dHT2V3QmFsUjdsRkM4cmt6amVwcGRxZHpZTTEw?=
 =?utf-8?B?Z0NVcnduRXhmT0RqTTh1eWdoT1k2cEk0M0pwU0g1bW9rS1BTaXVnS3lHSFMw?=
 =?utf-8?B?dlhsNFlIaUZ0OXVjWmZmY09KSXRhMDNtOXFob1RTR3FZdTJiMGJjM0ZpK1RJ?=
 =?utf-8?B?anBMWE1KZFBBQmsxYVZqZ20rQWs4MExpOFg1aERXa3lGa0dJaG9IRGRXbGZu?=
 =?utf-8?B?N0xvaFBWSFFCQ25URFdmTkNMbzdtTTgxUFJuSHpJaTlMNFlWZWhHWFo5K3Ru?=
 =?utf-8?B?c3ZHTkg5ZVIyWEFtUkM1QitsL1V2cXRVamQ1RGNnTXBWWDlFOFZpV3Z3YnNU?=
 =?utf-8?B?aHNGNm9jcU1XTVBNdjZUQnpidE9IRklBWXJLWWdaMjlnMDVlT0VRT3JWcFVr?=
 =?utf-8?B?UnJDbjd1T282ODBiWWZkWmtsdjF4dHZMa0QxNTRGclZEdTR2VytFSzF2UStD?=
 =?utf-8?B?NU4waFF3RS8yT2pJNFBBQWRDM2ZLYVRuTDBic2c4M1hJWk9UZXBCSGx5dFNQ?=
 =?utf-8?B?RkVzdWFWZCt2Y1BJSzRLWHduckdHdzYvWGtCKzVVZzA4dUQ5eVZUbTJVMjJv?=
 =?utf-8?B?UHpSUGVlOHVhS01ieCtObkJwTUxEVFJUSmtRWmRDUWxORmtSd3FQQkY2Smd6?=
 =?utf-8?Q?udTXYHDJEGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThZMy9nN2Y2MVJsYjdGbys5TXYzVTJ0bUdCMDJxM3I5N3kvVkdWYXBGdUFM?=
 =?utf-8?B?Y1hIUkFuZXBod0JvaUIwR1ZqZkpIaW9LY1J1d21XSjQ3SS90VmxqMGdrekJ2?=
 =?utf-8?B?MDZKQzVKaEVNTFpBODNPbkR6ZE5lWks3WUtYeGJqMFpVUElZOTV6R1pEaTFh?=
 =?utf-8?B?a2piYXg1Szd2QmZqUmJldU9mUXhuRHJoSnhNUC9JcTF2ZUczQkZYdnE5YlNV?=
 =?utf-8?B?UGtISDd4dmVBTXd2dmZmd2FRT3ZTQmtxMWJwQ2N6OFVkc1NCcUdYdUx3RGp4?=
 =?utf-8?B?dnJsWkhlMlNmelRiWGU4TEtKQkNhNjdNZjRlUCtzdDJuV0U5dGVGZnB5b0VV?=
 =?utf-8?B?ei8zSVpYbGYzd1p3RWpNUzB1aCtsUzJTdGpHZEJlRUJyLzI4YWdGaWZZcTZj?=
 =?utf-8?B?a2VjTzNOTXAyNURGaU5rNWJmN1ZHVUZOaVgxZUdGNkRaWElnSDI1QTFLQXJs?=
 =?utf-8?B?eXRlaG5MdkE3U280aEdSdEZUR2U3QnJuNzhBZVRyRHlVekRhS2tKeWlaeldI?=
 =?utf-8?B?WHBieHVnTmx1NS9vZkVYMHMybWpIK1BINEJPb3AxOGRPOHdoQ3oxbERWeStO?=
 =?utf-8?B?VEIxNEpxMkdpY0JFcnFjdjFkc2FLeWRBTGErNVVuRTgrdnpwNUNDRzAxS0RU?=
 =?utf-8?B?djl2WVExeDI4OWhXbVlmYmNtZzZNY1lUd3lvaStwUHdkWC8zUlZFRkJNU0Ux?=
 =?utf-8?B?Mkl3NXZyVVZtckRRU3ZhblJHVGNWU2dRakNxVDA2SzRSM1BmYVJia3RtY3lK?=
 =?utf-8?B?MExmeUVmNlYxTlVzeFJTem1oQ1FFaUV4bm9VTHBpVERWcTFMc3FkMm96YUVr?=
 =?utf-8?B?UUJIdmVDUnVkcldGTjRVTmVWd0JUVW04UVl6Ylk3TXJMTkExMVhJRlJPVGZk?=
 =?utf-8?B?Wm1qYzVvMkRYaURmM0Z6anp6R0hyS2J1b1VtYm96MmxWamMzbWhwZEN5MVBF?=
 =?utf-8?B?eExoT1UrSk83QU1keUMyWkpqMS93cWRpYzYrRCtITDlRb3orcDgyWVNaL29s?=
 =?utf-8?B?eDU0MURYL3dpUnN0UFVPWkVLK3d2WW4xRFVOanNWaXo2ZW5ISGY5bU1EZXNK?=
 =?utf-8?B?LzFKc3k4eS9OaHVMVkpKend2bGhoK05jd3lLQzdhNU9aY216QldUcHR0djFt?=
 =?utf-8?B?YUo2ZjcvUjdRbVlOcThvakFhN2lWYW1XdzZWZjc5V0pTYXpXRmdKM0txd3E1?=
 =?utf-8?B?K2VZNnpPRExkckFvVisvMUc0RzZmVys4M0ZLMDd0REFaRlhjanY5V2tYSGdo?=
 =?utf-8?B?eVQvdjZoVHJxQ0F0V2xFU2FMVG1jWkxaRzFNcnZzbnBVU1QxRUxVa3NHdVoy?=
 =?utf-8?B?YlJrczJuVlJnTjhkL21hNE5WdkJNeVVQcjJuRFNpZGhTVlIveVFBK0FWZnNL?=
 =?utf-8?B?dDdLeitNWVNFdzBYYytCVXdRV21YSG1JTGpzR2ZoakRHRHFDV3lMZ2tZOVdF?=
 =?utf-8?B?cXEvOEFFdnhhVHBLbjZtcTZaWUdvbGxsUHoreTlFY2pOblpzZ0J2QlhLQnBO?=
 =?utf-8?B?UVpFdkZIYUp1U05lR3pqTkZKMnJkZFNuQzkxUTRiMVloKzZlbDZ4WmQ3SC9v?=
 =?utf-8?B?ZDFONWlldUgwTTlVd2kzQ2tpRU1rZUZvbXordlo2TDFtdkJRNTRQNnJXZXpy?=
 =?utf-8?B?NmFUcW52ZzBta2dBM3NEVUVlelR3em8vOEduaUFOVlVJNEljWWhjWWJiUDlt?=
 =?utf-8?B?TTlxKzU4ak1oc0ljOUFUVExCUjJ2dk8wY2laTDFXdm9xbmdLbmI3dmxqV0Uy?=
 =?utf-8?B?N2ZhYS92aUlNWTQ2Mnh3YVdiSVNER1NkcWVDd1hGZUtRZmZsV2lmM0xQd3Ft?=
 =?utf-8?B?ZG5TQXJKYzBPZ1IrWjhqOFl3Wk9tUzRGSUJ3ZFFQVDhRNmhFbGk2UCt5S0xR?=
 =?utf-8?B?cy91Ujdod09TUkNMUFY1aVNKelhYbFlzVEt2aEZGd2FOaHdPR2tuNk8rWUdx?=
 =?utf-8?B?MVJtSXNxYS9ZSGVWSU9GVFR0LzUxUTBXY1ljL0hDcDF3QkhINXY0bTVvWmVE?=
 =?utf-8?B?TExMa1VUckFoRmVIVlpUYjBwa29JRmd4YlhCd0d6dHJ4QVR5czRUeHRIbTAr?=
 =?utf-8?B?dlVjNlBZYmxlWnJYTUpNSTJwb25RdFk5U1FLak82ekxIK1RXdWVmZyt6amZJ?=
 =?utf-8?Q?gdTOGqlpgRhEgNVrODZdN2+wi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aX/QNGJvoIdtOQI1AZ1HVeZKg2PrhV/SNTxzu7TaxxH8z42gnnF+3pzDMIJeaPY+mPpATkkXbljf4FfePvbM/ouTO6Lpk6S3MEVt0SGkgMZ+n3Lji1goTSoFNoEI2EMTPrTuyvy9/ebXNd16tjBywVnD5Ohm6x+O7Xp+CU8EUID7Y7/11hZepbJ5ic38+Dei8K+bDEYAtFN3x2L2CZdnq7wdcHBA4ExAeOcZh4nM4RCnY6t+h2DrSTPpo7onuO9pBEP6lO6Kfe3JrhucnPzXFSUt8kJSiyQJPWFfbKtJGG9NdvrhXe8RbjulU22AmXCCRH1PtPqpQv/clOi3SRm1wKZ4+I2j++wQ33jIJA45vJJl0y1pc++LT3v0aAsRQ0xBwqFIGKycRxVuuMbJqsj4I9QgMDUuWJh9nMGs+JqFsO2llLqF7cj+St9S5zWokSXaYXR+GlqjLeWgSqcjPzBega4s/YtBd+gWQakFkKbEdBFQsEsDDCis/507+ezOfXYd7wOfGDDCapEVskzClglUs/A/M00T4ege3D47QL6KYuq96MrReha4bjt7qPj83NHL/UMmHbRlzj922TpX+tL6lUOdC9PcL9l6v7Q3GYHHDJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5126031-8f9f-450f-30ef-08ddc2fafeed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:22:23.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvoC85BBBZf7AsKN0RXd1pLmXm3HjLVOXNIbXj/ZB01/b4eIwGHV05n7LSqw/ulacS105fcomoAxHibyqTevgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140108
X-Proofpoint-ORIG-GUID: STzcFdQzZJgV5GTknmLzIJ_wFPkjpD-Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwOSBTYWx0ZWRfXwTHnGFWPjQ4X BCFz04IC6yoB9woIBLDXcxQk6xCvNd1D+Lpugaec5L/dU+4tyZ+gEYEIQ/rRNvFlq3cSD/hNm/t 9iygydFguN6mBdseB+EFRsDQEMoj9ABnFZMRuprtfhL45E1DKDRzIzTfJdCjHElhGIk31uk4iQj
 8igECtRE+YnCJWe1dfEQPvViAMABa4ZPg82IDmtRq38CALECPUDI6Ke4Oi/xIkgo+INIMoiZw2S b/CWgPVSR2JP+MRwKPi4QyhYcDZZVw+RVtSWcZ4NrDXdIXSeY08P0ADj9Zzjg5q4bF5FOm9Op/p 3PvJ7NJkcAQTJhRBj547ajWy/J9ezfedaTEXAdisLT3sGyLzLqNHnQnv0y++hz8JbDneZq9zLfd
 2i/L9K095FbieyCLb0A5whQ1Rytei+doMuSwxR64WYeIzv2ATO6Q9C8/r9U6XGfawaJlSof4
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68753cd3 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_3-NZvQfHRNs47lwsW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: STzcFdQzZJgV5GTknmLzIJ_wFPkjpD-Z
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_102238_402939_E827443E 
X-CRM114-Status: GOOD (  22.63  )
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


On 7/14/25 7:44 AM, Christoph Hellwig wrote:
> This was originally added by commit 8695f060a029 ("nvme: all namespaces
> in a subsystem must adhere to a common atomic write size") to check
> the all controllers in a subsystem report the same atomic write size,
> but the check wasn't quite correct and caused problems for devices
> with multiple namespaces that report different LBA sizes.  Commit
> f46d273449ba ("nvme: fix atomic write size validation") tried to fix
> this, but then caused problems for namespace rediscovery after a
> format with an LBA size change that changes the AWUPF value.
>
> This drop the validation and essentially revers those two commits while
> keeping the cleanup that went in between the two.  We'll need to figure
> out how to properly check for the mouse trap that nvme left us, but for
> now revert the check to keep devices working for users who couldn't care
> less about the atomic write feature.
>
> Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
> Fixes: f46d273449ba ("nvme: fix atomic write size validation")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

Tested-by: Alan Adamson <alan.adamson@oracle.com>


[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0   39G  0 part
   └─ol-root 252:0    0   39G  0 lvm  /
sr0          11:0    1 1024M  0 rom
nvme2n1     259:1    0  250G  0 disk
nvme2n2     259:3    0  250G  0 disk
nvme2n3     259:5    0  250G  0 disk
nvme2n4     259:8    0  250G  0 disk
nvme2n5     259:9    0  250G  0 disk
[root@localhost ~]# cat testxx.sh
set -x
nvme id-ctrl /dev/$1 | grep cmic
nvme id-ctrl /dev/$1 | grep awun
nvme id-ctrl /dev/$1 | grep awupf
nvme id-ns /dev/$1 | grep nawupf
cat /sys/block/$1/queue/atomic_write_max_bytes
[root@localhost ~]# sh testxx.sh nvme2n1
+ nvme id-ctrl /dev/nvme2n1
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme2n1
+ grep awun
awun      : 31
+ nvme id-ctrl /dev/nvme2n1
+ grep awupf
awupf     : 15
+ nvme id-ns /dev/nvme2n1
+ grep nawupf
nawupf  : 0
+ cat /sys/block/nvme2n1/queue/atomic_write_max_bytes
4096
[root@localhost ~]# sh testxx.sh nvme2n2
+ nvme id-ctrl /dev/nvme2n2
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme2n2
+ grep awun
awun      : 15
+ nvme id-ctrl /dev/nvme2n2
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme2n2
+ grep nawupf
nawupf  : 0
+ cat /sys/block/nvme2n2/queue/atomic_write_max_bytes
4096
[root@localhost ~]# sh testxx.sh nvme2n3
+ nvme id-ctrl /dev/nvme2n3
+ grep cmic
cmic      : 0x2
+ grep awun
+ nvme id-ctrl /dev/nvme2n3
awun      : 31
+ nvme id-ctrl /dev/nvme2n3
+ grep awupf
awupf     : 31
+ grep nawupf
+ nvme id-ns /dev/nvme2n3
nawupf  : 0
+ cat /sys/block/nvme2n3/queue/atomic_write_max_bytes
4096
[root@localhost ~]# sh testxx.sh nvme2n4
+ nvme id-ctrl /dev/nvme2n4
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme2n4
+ grep awun
awun      : 15
+ nvme id-ctrl /dev/nvme2n4
+ grep awupf
awupf     : 15
+ nvme id-ns /dev/nvme2n4
+ grep nawupf
nawupf  : 15
+ cat /sys/block/nvme2n4/queue/atomic_write_max_bytes
8192
[root@localhost ~]# sh testxx.sh nvme2n5
+ nvme id-ctrl /dev/nvme2n5
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme2n5
+ grep awun
awun      : 15
+ nvme id-ctrl /dev/nvme2n5
+ grep awupf
awupf     : 15
+ nvme id-ns /dev/nvme2n5
+ grep nawupf
nawupf  : 63
+ cat /sys/block/nvme2n5/queue/atomic_write_max_bytes
32768
[root@localhost ~]# dmesg | grep -i nvme
[    2.613613] nvme nvme2: pci function 0000:00:06.0
[    2.615487] nvme nvme0: pci function 0000:00:04.0
[    2.617269] nvme nvme1: pci function 0000:00:05.0
[    2.618234] nvme nvme3: pci function 0000:00:07.0
[    2.707583] nvme nvme0: 1/0/0 default/read/poll queues
[    2.711550] nvme nvme2: 1/0/0 default/read/poll queues
[    2.727280] nvme nvme0: Ignoring bogus Namespace Identifiers
[    2.728661] nvme nvme1: 1/0/0 default/read/poll queues
[    2.730096] nvme nvme2: Ignoring bogus Namespace Identifiers
[    2.742041] nvme nvme1: Ignoring bogus Namespace Identifiers
[    2.752341] nvme nvme3: 1/0/0 default/read/poll queues
[    2.755530] nvme nvme3: Ignoring bogus Namespace Identifiers
[    2.755774] nvme nvme3: Ignoring bogus Namespace Identifiers
[root@localhost ~]#



