Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE1C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 07:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+hEP6yaarLwDP1bRA7RLqwroJEH31tQo++cI4fbLJnI=; b=dOVmd9qE2bAf8eK1CfI3cZm0EU
	BAuX5rcjZHkG2jx62dni/MgOrVo+MTkGriadXtVDy4m8miSiRs28yWVc/pEmZOE4NY0WayFAI8zy/
	oQLr+CzvzV1SaL+3fm30xA5e7L1rbp1/pSItZkDZJVd/xuhCUPzGkuhwPqbWPPJ7YSIND3fyiscZk
	PhrCewGN4EmO6TaeYw61cdbP4zhnf8045xXPdfCQLdT7ISaSCg7R0Y9pk514fw/toHrD3hU9IGUy2
	Xez3Hbi4msVuivc7i9SKLqyXpKJ+cR5M/9qWUv2+GOofqoJjD6/989GAFpRPKxyTOazH8D3sIlEyP
	Lgh++Avg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjGT-00000001J1t-0hM0;
	Thu, 09 Jul 2026 07:33:45 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjGP-00000001J14-0WQ1
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 07:33:43 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668KIBoL3146008;
	Thu, 9 Jul 2026 07:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+hEP6yaarLwDP1bRA7RLqwroJEH31tQo++cI4fbLJnI=; b=
	kqPrTOxb3gGNeiDtFBEnsDjn+ouwQRfIco1VM/PqNXnyXrnY/Ajj5nKbfqT2NsPM
	D9kWrWXtEOo0Dyqw70RO0WGoj7eDh7lSZFxD3gMFDi7c8OsVkUgVpyx2cHeeFknF
	6PSV2o2EnWM1Sstvg2hlOJotlJhOftxYeb/D8fKR3UqQ+7vRz1Apv2f0BxN0ZASO
	66SBGyoj/kHmV1PowbaVhJlA5MqRbgdcoJ4rX6KgSVeJr+C1/yDNo0WvEcmUPYYE
	LP3fSIOrp7SdJo6DMzA7IfEOcKGe/wN/PHDNz0mmWMqfQXnz1EQLm1DNp1h9zz0h
	S3CHyM7oHTgDYKJrHcAK+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6ry516ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jul 2026 07:33:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6697XB81017129;
	Thu, 9 Jul 2026 07:33:26 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmfwtxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jul 2026 07:33:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxC4TLa+4VqDe38magxk5FPl0/3bDG1M4+UmErM5ereIPQi7cOmQd9E9J/bUEXqN5Vhjq676n3Wi1mGKu32qYYmOVV+FEF2wkxbe2FUyug/SNkFl2G7MApcDdFmMBTRFJ2b+KMqPLR/1WdrxLkG4wk12iioIszX+T9M3OIrvJHpqUx/TKo7pw1w97m+IGEHa+rwO4hG1hUPaEs+7djbNsEJi9ZRsvKA10rVpxfpgPXfARkzCgZy3myi0ki+An9stZ+ZlCN23pbm1669usZdaWpFt9Uln+bLbML+FFpGpo3FIoFxK/Yl2YvSSEdRj0E+zvCDgjjzkX0fST5Nf38UbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hEP6yaarLwDP1bRA7RLqwroJEH31tQo++cI4fbLJnI=;
 b=Gzsrgximfh7nLuew0BpWbr27lRH/vpSd4J2y8bMeoosoYWYHlUsmgA/mRqXRUfL153lglfNxhBMtExdAJwySEIENK3v1enLpkdJNnudiIFi7B6LDk2C+t2Yr0xr9hQ/lcF6aJXfAMCIKrSKqOEBkWfcK8reJ8j09x41tJlOtqB5H0FZYYqYbcJGcgXrDyiI8vaSAileNwdvow0jZoTfL9B9VZpiblGktZZfJoTwuHHZmg4pQ6U/km9mOYF4g9884xovQ9A3Rqhd6v0wiNW7fOQsLEMbbXPxLpMXbJ2SqSlTAk93wO1RqEvfJiWiidTijWRuFq/Kb/1CyIb5IJFakpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hEP6yaarLwDP1bRA7RLqwroJEH31tQo++cI4fbLJnI=;
 b=BMtKgqSDhYBC6/S8bhiRP3RPbGVW+Z4NrxPf82hKOEi5/VCwszJfaHKs56Xopaq8oPsupXbru5hryT1NN7R1qwzPT8jqd5yxZ3GnlhfFGtDgl1yFl/1KA2VOeCROpYyLdWvrw0R6rkgtu2E0x6WJGXqmik9RfmVtv8lVweHIj5Q=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SN7PR10MB6330.namprd10.prod.outlook.com (2603:10b6:806:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 07:33:22 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 07:33:22 +0000
Message-ID: <349bace3-cb23-4489-945b-168e611617bb@oracle.com>
Date: Thu, 9 Jul 2026 08:33:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme: fix NS head cdev lifetime
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org
References: <20260706130146.617258-1-john.g.garry@oracle.com>
 <20260708092740.GB6513@lst.de>
 <d27cb4a8-cf04-40ac-a271-c7d83dadc8a1@oracle.com>
 <20260708161846.GA2262@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260708161846.GA2262@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SN7PR10MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: beea9904-2680-43c9-2426-08dedd8c5abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: /1lO5Vgsi+jJtT0G0GGXaFQJ6j7i9o403N/HjKEyzJX5caS18F9HuKYYO+WJQ5ZhFEQQp6d+usq/k0n/uCVRV2vWJJ+ON8B2c5EATGgPfesOXGZCq6Ait2JcdIbSdX/RlLvBPk2M/cAJYFhcSs4snW1b/qezwtSZ5PKvI/7RL4hdBBc8P715btaJkwDofIYfEZI+sNWfVvWvJpy3g+cMylfTyhxGN1EBNR47kevrK9OPwFcR6GvOC+iVd5Kk8rXiWvmIbVbuPx98+kne3aXueQGlB0M3b60T7HwzF4HP+Vt7XaD/vVZirXGsKU529qyj0bB5OmjX4/9vFJk/vuULFK0xnFq8UOVRChoSfXnn3QkAUQBvACGTdVIfavMQ4Td4l90i9LWyJuJ7wMzoLF6+CJgyE9lK19XuvcrOBkXHeejFlmoRbjmf/hdKW2/9CJaJNXQ7VkX+F5e9Ll+5H/Fjo9UAiFfz0WmKi0ZjKwpbqlpC/nLUeHgACUMccUjeGvl41MHpxV5rp1OexY51ubf1mMRj7AopQB4flos5sxLZyuKdM1qKhe3eg4GNNJotctppVRVfO2i/+1p2hsMz0kcMO8YXi1exWcbigpyoNPBd/TFC93vTYVrw1Oiii9UJ+T3YbMWQ9JlRf3YxdZ0RzSCYDaFJRigIQ+90W37v/5Z7MNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0puWmMxZ2ZaZXlpK1Q2Szh5ZTkwWExQZkdFVTVlNWFlUVRaQmVxb0RVQkZW?=
 =?utf-8?B?K0ZuU05uWlVFcU5URVUwTWl6Y3AxR0M0a3A3VUpYNHVEWkpHZTVYZ0RmN05x?=
 =?utf-8?B?UTZjT0tjeWZrLzV3VVNPczhSenFtWDY0VjY4WHMyeWtWMXc2S3Vwdk1rN2Qz?=
 =?utf-8?B?bHRwaEZ6TmZoTFF0THIvWi8rVkEwaWI5QWN3NmM3azBKeG9GdFNKUFdybVVG?=
 =?utf-8?B?d1RnNDNJOThuSlBOdnVHZUM1ODFSS2Z6VjR6YVVFaVBPM1I5WGlLOWdTbzFr?=
 =?utf-8?B?dTBOS0ZFazhKR24vd0tDSDRKSDA4OXlMWmtBZlpqUkJ6OFd1Qy83UXFJVTBv?=
 =?utf-8?B?SlRnS2ZuZXBxdHlpSm1vVktrL3pFUC9aQkpYV0JaQ1ZndmlDMTN1c0JoMk9S?=
 =?utf-8?B?cWlHeE5JbEQ4SGoxYllTajJ0RXJoNU5Nb216WldIWTYxdEh6cGZBT2xnMnZw?=
 =?utf-8?B?UVVkdmtjMEJseXhnRHZrNUZzaHhjbnlQTmN4Mk9kMm4wbWJEdHBFeU9OcXRV?=
 =?utf-8?B?Vlc0U1g3YXVhUzZDbG1sTnBkL2dzMlo3UWtndXY5ZnpHbUgzNTdtWEdaeEl5?=
 =?utf-8?B?OVJJMy85SEFOcUswY0RTY1dORmRrQk5DU2RYZEZoS1lNdlU2NHdJTHRwMnZN?=
 =?utf-8?B?Nm5PdUlPRHhWTGhXYzNITlF6VFhjMHQ0c2w4bk5iNEhBSCtMczZ3U0RrcGIr?=
 =?utf-8?B?enJuR1pUNkNSVkVxTkdMalgxbjg0c1hTR2ZqVU8vTktKenVaSXIwWlljdFpu?=
 =?utf-8?B?a1hFblMySkFTVDFrZ0FWNE9NK2QwTmJaUHN6ODU1QnFBSHkvV3VKVk8zU2ZI?=
 =?utf-8?B?eVhlMnF4SHR6UG5zS0VOUWdORUVrRHRHSjdza0V4aU1jVWFvaU5aMFBiVEwx?=
 =?utf-8?B?aHJPWEo5SzI2VVIzdTZ2Z1ZFSUNvVncxQjJIaTJFK29Ncm1HVmlrTUg2U2p6?=
 =?utf-8?B?T1lnV0MwbUgxSXluRnRxZnpFaVI3aStPSXBYd1FxT0NiSkd2NUFKUWVzM1Bu?=
 =?utf-8?B?UTJrcUduNkw2Wk0xSVpxdDN4NnlWVFBpNjhXR3ZlazNkM05pdWhia1QzSE5W?=
 =?utf-8?B?bDZwdTg0ald1dzJ4RHF0Uk5sRmJRUVF3Z3oza0xFMXlieWF4eEM1ci9aMzFL?=
 =?utf-8?B?TWhqYXpVZUZkbnR2Zit1L1ZBYk9ZYXR6YTZvRGFiYjlDWDMza25zOUpOVjc5?=
 =?utf-8?B?M3lRNjhhYlJOTzd5VDNQbTlpOU5VZHh2OW51ZU5oaG40dDFtOEF4ckZ3U3oz?=
 =?utf-8?B?bm1CeFhEVlU0YTlCNHZVVktIQVV4OWdicW83QkNFZS9oUGZBSi9DV25aV29D?=
 =?utf-8?B?dElVUzN4aERrVjM1bHVWaitrRko1alFscmhaZjZ6akVaNmI5ZE9peW5Gd3la?=
 =?utf-8?B?dEZmcFRhS3QrZHdLazRYOU5Kb1UvSm1ueHF1Qk91emJHaE9TUE0rWjczSGhC?=
 =?utf-8?B?dWxFUlUrY2kzWTdKUnBkdzFGcWNTYzdnMStYaXliSWFmbndsOVB4M204SGps?=
 =?utf-8?B?aGs5VFlnUitKdmZOTmk4K2NScmV0WUNDemQ3ak90MTN0bStvZUI5MXRldDZh?=
 =?utf-8?B?MVlDcjZYRXBGeWRKSE14U1piRnpUbC9YSGVsQXp2b1BvWHJobEZtalpWTHk2?=
 =?utf-8?B?bXNDRUh2ZVRGV0VBZThqcXQzU3pnTmhPb3FOa0tydVVRQXNLbnpxaXRUUVUx?=
 =?utf-8?B?WmcxdVJIYWRRRFVEbFdPUmFtWEE4T3VpQ05NYnhtV0Z1bHhCWkh2bkNIR3FO?=
 =?utf-8?B?b3FLODBFQUhZUjcxdlpvU1Uvek4xZjNXUnV2UG1Xakkva2tod0FJSnN2VUEz?=
 =?utf-8?B?TjA3UWRiTUh6QmlKcmVjWTBXcUlTVlBVZVVDTTZQQXY5NnBGY2xhMmU1TDZ4?=
 =?utf-8?B?dHh4Wk9raFo3MFIxOTVGQUtXanNCQjBtZUdDc2MzanVFR3huL1NUK2k0NUVY?=
 =?utf-8?B?SFl6UU1qN0JIY3NDeENqaWlra1lBQ01KS2wvTlRnVytVQjBCV0VCeW9wN3gr?=
 =?utf-8?B?eHJnVnhlUDJzQmNsYWd1RURsTDJaaVJRTFVjT2hOTENCNmhZbG82dmlYbkpr?=
 =?utf-8?B?K1UrZEFUZGxvemZiU3lCVnhBZGdZRmJaQU5iS3B2cUwyQm5hTVRBUW5OWTVh?=
 =?utf-8?B?NURqcW1YNDhYT2ZMWnEzeWd1YTRTVnRQTmVVRGFockMzTi9oU2ErcGpSd3hp?=
 =?utf-8?B?VnRxVmtpZ1ltS2hVNVlVc0ZpMCs2NzFIaEtmQ2haYSt6cmR4WGpINFlJREs3?=
 =?utf-8?B?RFl5T28zNU1qRG1teHJnVmI2WGpEdHRoa1RxTEVvU3JBRXIyamJ1Qk80WEFX?=
 =?utf-8?B?ZkZzRGtvMkRZSklsS1RRUlJZcFlvdGM4WDJQNDNpN1Y3TGIvZVRNdz09?=
X-Exchange-RoutingPolicyChecked: NXLKGNYCpFhMvDg4i5gqgCC6dL/aNEP2QNh77q4JwCcrmkqT7zGNclbjYZuZO5lhJRLhhuseDiqSKIhNhIEiLM6lJ7ewTWKwtAP9HGKyn5FZq06sygASdqjymmwi724CHtLFbDWyMpA8eUJwPYammV+oc6NXQ9bJcroVVNhPl6fH+hnl/+WXnOtwxDSXRrR7WJE6XyN4sAPUnvM9YfHHvw5JB4ceibyFK7D3Dz3N7zB11vCJ9wvlqKUGx4bkhUH0lgInvKTJiJ23ePK9M2zkYIQRj0fQWHSD7DtOU5x3fBjaDK41N1kYGYnVTp6T6FA2iM2+HI39S9Nh8HLj4SO9eQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z8EpXJmK92j7Mn/92ViOftH2RbD8586Vnz0A6FRr042YP3hQjGIxklmRRxQFCBJ8zudGr8cZx40onufzRIrSngXlpkwYRAgF0tO0SX7b5u5xkRRL0mjKO3rXKTeOwJe14XJW7gAnyTn3umljVIxMf0brr/ceB/ObNxEZFR/0tOZriPFKMCJu4NXXVxG4kgUhPVNZMBYAealGBcaqD0ti0YSA7920ELmlHru/mmzmCKT39RvXxD1uqZ+fYuZHj+1/wAVueSOxiVl5u33RtFbJGSa8eR98MPIeml1ayzRT5mNeP1ZtF4XcF+TFZ2x0Y7bsEUETjL95PR/EnejP8B2+3iLSvbbB7qi5+DflM2Rv6wiGOZ//y1NbNNgeWfwdH5PVSkE3Q6f1e/6unpfCZR9CcHZ1OHV5FcESlu4kyutI/jvO8ARw2Z7Fgr3yRNTdbO96LamBJyspuy52qz0V3zKUyePNPbwb1kl4W3BmREElNOb8B1za9IL6Rat61z261q9FTWTY4RwkY5JuMSyWWaeBjl2W/w7fzOJz2BUwAkjGwWrX7wgDGpohW/ftjBCPr+9sB3NE7geOUtV4yBbEIs9LlUQmxid4/e903bCN+yX/CfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beea9904-2680-43c9-2426-08dedd8c5abc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:33:22.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXnsK7o6ogJbUr260lnw5luxofpAM/BBKtD6VJjKGACGcIIdGmYso5M8Pg8ajE20dHy0vVGtc30MSfu3kXCK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=549
 mlxscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607090070
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=6a4f4ec7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=BVfMV1No2-zejJ6TlMIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dS3LGbHPTqO9udp6bMhHgMza_NdGBX9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MCBTYWx0ZWRfXx+xje2FDfFt2
 B64qGvC86DHo3WsdsaDzjGaKRNxcwI1RbjCK77359VaSJp+QHt2Pgzad7pTwqlow+B+T2kHIFch
 8YRkwF04od8ieNkV5YZB2Ez9S6xM3x3s71ygZjk14j3obvtDzfTgBwgUG0BkgwQDrVmTOqz3TZc
 eYWAEkJwFxz1iROOS1XEQzgkp4SlCHylDj6I15Q4Wwn05SJ2IRbhl5sp7c5YODbaUss7xjIJt3p
 QYCPgyfMcO488QI/O/iNjGIA6BkKNfnA/OWEiL97Yv8Wn0E98VpBCGsJlS/4MO6mWauEAFSrRi8
 ZiYIyJ83ti2rSYwUwJ+vSdHPljd7N3HuZOJjLT1eDIcPD9N6LKs2TiqLepRjqq4gMcaWN46KkzE
 0Xn12ogaLfubbdTNwWbuQJaInTk0NFwr36Olc/MJRCb3PKrkRSS0p12wUPxagRAszdNmgkDDm+P
 4heY+fI1ap8K5ff0LYw==
X-Proofpoint-GUID: dS3LGbHPTqO9udp6bMhHgMza_NdGBX9y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MCBTYWx0ZWRfXwqv2qV6Ngeyt
 Icvrf6weh5F7m2MRVu/hI0ZqbY5ihwXXCAiWP/NW6A8QWzHxNZ6bu45QrvvyTMrqGdrpIQjhnXU
 xdWW21bvU4hIUe9ypomtk1Ukpqm92uJfoHPppkNuGLMzh0k3yXYx
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_003341_298823_54A09445 
X-CRM114-Status: GOOD (  19.38  )
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

On 08/07/2026 17:18, Christoph Hellwig wrote:
> On Wed, Jul 08, 2026 at 10:57:02AM +0100, John Garry wrote:
>> If we put the nvne_ns_head (vs nvme_ns) in the driver data, then I can't
>> see a check to know is the driver data points to a nvne_ns_head or nvme_ns.
>> Unless we keep NULL for one, but that is not so nice.
> I think NULL just for one is fine, and I'm pretty sure we already do
> something like this in the nvme code (or at least used to in the
> past).

I mentioned in a follow up mail that we have this same issue for the NS 
cdev, so we need to do similar reference taking there.

So using a NULL check would look like this:

static void nvme_cdev_rel(struct device *dev)
{
	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
	if (dev->driver_data)
		nvme_put_ns_head(container_of(dev, struct nvme_ns_head,
			cdev_device));
	else
		nvme_put_ns(container_of(dev, struct nvme_ns, cdev_device));
}


Another idea is:

static void nvme_cdev_rel(struct device *dev)
{
	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
	if (dev->parent->class == &nvme_class)
		nvme_put_ns(container_of(dev, struct nvme_ns, cdev_device));
	else
		nvme_put_ns_head(container_of(dev, struct nvme_ns_head,
cdev_device));
}

any preference?

A nicer check would be cdev->fops == nvme_ns_chr_fops, but the cdev 
pointer cannot be looked up from the dev release handler and it's too 
late to even ref the cdev at this point.

