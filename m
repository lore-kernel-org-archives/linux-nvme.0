Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B80C5AC82
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sN7pXyt4bkvCzAmH0dQ3z7GW3FANqrtxQCGji82713s=; b=kjdVwrv+2VFQg4OFXmAoxzMstI
	A5O77NuvG6oVyrSi0eM/Ab1dsWWDN5TYstPIRAdYK+9KHxRWeD/M974Phni1lWIPp+HJd6CjwzPZZ
	IB1PmaoxrSgwp/3ENWxyKMmvOuQcjrg7Qr71GDV7aE72ftIDpIhcsUIMNCrg33K2mM7e1LgTiXr7z
	xJFB8G/J+WunmWOHzTsznqJCiHPWoHaIrzm+ulcOytPXRgtarvhlrw3a0Re+mKTMTWMgKlm/EMc8e
	Ki91frkFGAC+C25Unvi43OkfOje9O+/sLYcmlZEYzTIwF+z4hUxzZDMpi51ITPudKcN0ectedDzkG
	jTBDnbyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtL82-0000000BFeC-0zEl;
	Mon, 10 Aug 2026 08:13:02 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtL7z-0000000BFca-42jw
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 08:13:01 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679NGlZq3801287;
	Mon, 10 Aug 2026 08:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sN7pXyt4bkvCzAmH0dQ3z7GW3FANqrtxQCGji82713s=; b=
	imeC6EN3GNWyafarajSe2jYWpi13XInZTI+mRScf+JZa68CXT8CSr44Iu1nX62K9
	3H00uM8spVeLmZ2gBdj0UNFhtM529iIqeL0cZsSIF8sgkGJy4Fj8fqBdis3Smopd
	1YQZD0zSFu4KOkMJmF/ZddDmo5loRxQ+9ISfgwzxubEgkkAFGpvuONiPYGklmQK4
	0KKyqgQpJBTjv0vZm+GTBhQvIwpdZeArLODznQj2rVzDDWy8fPg3a9GXSoLX6GeL
	Auk/8ifc0s4V+2rIRZ0VuKdXjnGCNde5VnHcS5jEzJNCoRVvcWlGGSJObWhkhRzq
	NsibNpXTd6INbz6FYHHc7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvhdt5xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 08:12:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67A85YtX003447;
	Mon, 10 Aug 2026 08:12:38 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwpx1uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 08:12:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2J5043t/ZsAVwnQBV6FlJsXkaAV6Q4D5aNewHCNgjd4dSpqa+qf3sWqOML5QdmfvQLzUfz+7h9VWmeAQsEulL+nMKvwaS2m6gVVnX14lDKNObcz4gBHzkkghANpt3GxrQOa2i/0Hvulz6Y9RVZ4/7rd88qf2ZBQdW+cBm7q6GQXXU5QofasNte+GDJ/IBD1Ykxk8sGoq2cKrfAjO6cL2rzxsFr+KnTUNEXHjDFnPR9yJPRgmhFOqDDAu+OgZo/ahawvkOMHTJx09AaZHdZVseksY0TaIqSa8vnVUfWFk0DOZfjj26mTGTH368NUrhuaRGgjLtO8cO4zo5bJ+fqcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN7pXyt4bkvCzAmH0dQ3z7GW3FANqrtxQCGji82713s=;
 b=BgeyJOttRxSLw+F41cR4G1/P5y5Pe/eG09fWDO2CdWRY2C39Mx7o4Gh4d667dEmC2DJJpBwu26DEYkNZQ7wkQd4xnrTPh6wtQXFl2veVVM6AGmkvhKkberVW6v+3VOdJYp+3CukN6yiPO1eBMAEF+PV8CK/64l2XMSnuujYVlRbdpSv0VtHsLnUQWAfGaLobKEZV1S7j9Rwd8aC68DL6q9qg7mr6lZ45700rG57XKijTjdwCn/DyIvB+Nw3RBmiLlOE6n+wky4SW4Ld8IS7hxUKTSCPnc7usyg4DnH75Wa5heHaHm7hY4tkAWHrYkuFZz74HS3LeFAEsGbq42uUupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN7pXyt4bkvCzAmH0dQ3z7GW3FANqrtxQCGji82713s=;
 b=tcPa2L0q1l9sEnGYFhiM9q2NE3/BecFSaXLbEidKBVGCBJDWX5QWOSjFIqZLwKTtQG96u7rJZLZqljsQD+D7HfJBnXtvBb0ffWji774VLDNkbPGGgyD+JKv0xXAOo+o6Xml9k9K1e7pK38zI5w8NM0F/FNT8QbW550soA0kTUcs=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB5644.namprd10.prod.outlook.com (2603:10b6:510:fb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 08:12:30 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:12:30 +0000
Message-ID: <2d0163f0-ecf3-4f59-9121-587f98eeb54c@oracle.com>
Date: Mon, 10 Aug 2026 09:12:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260809100825.2014133-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: e2698229-af17-4c62-d004-08def6b71f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KOTrpFR7AjElHI0b1FlBoCkpQ6euCacV2nOIdZRQ6HMks7Cj1H3EcFA8kjRUvMNiEfESRObi+EDuciYNWTvVtq38lUFi+5qNnJMVk7Hc/GTm7jJWLDzjOuc8FH5WzHKj7gyNPcl5ifKHMY9rsuHbCwNlV94xTJShMlwRQOdZ/LADuK9BX0dOJGHaN4TVrrW1FFNUzpkQhIFShDDczjxz/ZuKjUw4CXZik6Vk8Ulb3lVmEbP424DzAGniSh/GqKJRVHrwkw5MlZHiXTF4RIWy/XrDktaGnNIPmSbyj5apJCsTtt9Hd8nqzYotdGHsUXJXWQzgHz3pr3ZTtpj1On2pp4mumLViL17stO1UKCvHTqySBxsx5X+vFRIRoC/mTn4ur+0Zdto7ScJxOE17l9D30C5n+v2XVSHU27P6D9p0hUFOYqMjyph65AA9e7Ja5iojFjH4HzljY2DpbVZvFpQ/W0IX96V5HBKCO57l/55n8jQzXlw7/eiSKlqYVyazIHR5oMflmR+bbeu7P6ivdiKNHcpSxA5+iT/J5sZSZIRNuCoK4MYhintRyfKVzSGv956vMKSsLvyRD32Coaq9t3K4B+FKPW0B0Fmh+GCi0eIpLQXs2UEOABzi+Boy7lsR+8taPnxl908JmxQA+jA/eJLTasM/wOZLw4JeeNA2mBQBmyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTlpdzY3WWVWcmRqQ1VQRGlxRnBRSm9VWFZBZjMrNndhK253Z2t1WjI2UUdE?=
 =?utf-8?B?Qy9YN2hvZmNrTVU1M0ZkWkdwRHpLTXZmOVZUSlZ3NjFQSE93RitLK1FEUW9P?=
 =?utf-8?B?QWFKYXRFaXNHVSt4M3BiSDVHMXZoWHkvM1lzVEV6b1lDRG1SeEhma3I0OVdS?=
 =?utf-8?B?endwSStPZ3A3cFBTVXFJMXFWelMzcWJqM1QrRDFoSGc0RUg4WG8xazRtTk1X?=
 =?utf-8?B?ODJDMWp1djZmTHhNUTlKcGZWamtDcjJwM3ZpdWkwQk1mRG8rWnhOeml6K0hO?=
 =?utf-8?B?aWhpSEhKcDJrK0owbUo5V1BjMmU5bENNOEtyeFpzSWhlMnYwMEw1K205UmpN?=
 =?utf-8?B?azFnc3l2T1h3OGhsWWNiUFY1QlU5RU5qUS9kZjhIWC9mWUM3YlZiTURlNU5S?=
 =?utf-8?B?M0U2Rm5WUGx4WXVQMkUycjdNd1JzbVV6K3JYNzdZTUFQb1VhbFY3amtBaHh1?=
 =?utf-8?B?RFVNVklkMDZlcGs0TVJOK0hud25ZZUJGNVBrRWR3Z2pybkNwdXBlRUY3Q3U3?=
 =?utf-8?B?eEFuRUVKQnRVSFgxVC9JNzhrdDVGMmNya3RDK0Zyams3VXM1Skg3SXlhT0dT?=
 =?utf-8?B?bGx5alFMOHBGREtKeUpta01LeXJqT0R6a1NKVktpS3h2VGZmcTAyY1BvZWhQ?=
 =?utf-8?B?VjFla3dhOW10TkhuVmpndUw4YXNrQlZDR1BZSkpPVkhlbUl3MUZ4amFwUm55?=
 =?utf-8?B?aDZEUjVPaXR6azRiUWFiYnR5aGp2cjh0bERVS1p2d0EwNmdLbVYzTHBTQVg4?=
 =?utf-8?B?Qkd6TzlpWUkwQy9MMmFpTGR1Z3pJOEJHelR0cXFndFY3aXhqWnFmNDU3dXgw?=
 =?utf-8?B?V2lJUmFtaXRxaGhLTkRXelpESFd1dGc1SUw0NFR5NTQ5L0VDcElLOU9xdit6?=
 =?utf-8?B?NC83cUFZclFkUlZpVnJLTElMYldpMFgyVUE1R1FUVC8yZ1JOcUY2ckxyTHky?=
 =?utf-8?B?M2k0OUtFeWpyajZoZ2h6MnFLSUJxekVMOXdkQ2MvOC9uSDZkckl0czl3OTFo?=
 =?utf-8?B?SUJIdFhJMVRBV2RGTzNGUzAxYzNCVWFTRUxkOEJrZXdHN0IwTUFSWlZZTW03?=
 =?utf-8?B?akNrNWJnNkp3RHA5UXZHUGczcmQrU3ZudEpkTVp1OTNTdC95K0VINWNJV3Zw?=
 =?utf-8?B?cXF5UUxNTENYQmdOYjZGazcyeDc1WW9mMjM2UVFLdXR3bm9vR294ZG5XYkkv?=
 =?utf-8?B?Qjd5NlU0bFNjR0V5Ynp0VXUySVN4dEJtWVBvUG9oUHRBMCtad2ZlQlJ0RW5s?=
 =?utf-8?B?dnlyTjBNbEY1dEZmUTJSY0hnZEZlTWlmNjdmRjhSazVQNzYxSTdXNjZ4Z0ht?=
 =?utf-8?B?VG1aYktnM0JiK28rdXk2bk1EWWVrelArMmtnTUdKSmJDZy92UlVTQ3JYVzBI?=
 =?utf-8?B?T0Y4empRQ2dDN1B0aGg3RmdCT0p5VHEwb1UrRXkxNmdmM0R0Mm9ZK2UwbFk0?=
 =?utf-8?B?OEx1ZjVnSE0zditLUUhNUXc2QktyNzdMVWR2aUs0U0kwdk1nUXhwR2xnNjA1?=
 =?utf-8?B?bW9rTVMwQkJCdkNLOFR5WnFJY3lQNCsyT2xTSmlvUDR3S3JYVzl3bWd6RVI1?=
 =?utf-8?B?RnVOMUM1RGdKSXFhS2prOUl2S1hybmdaa2IyR1hKbW5FeVVIWE1YT3hxSmZD?=
 =?utf-8?B?UjJNcWVNV0dIUzRpYy9FcTQwRlA5alJxdTFwcWt1WStVSVJpMjhTTFRYczB1?=
 =?utf-8?B?djhGL3NMaUNTZlhkVVRnWHo1RW1WY1MwSlZrV2NmbGtnaE5tVVgxMGJzYkdn?=
 =?utf-8?B?ZHo3cm10VERSYVYrWlllVVBYclZ2blgvNCt3TGdBekdWcVJLaGNZWk5uRVA4?=
 =?utf-8?B?TElFUXM2eDRxVjErV1dUcGN1R0M1V0ViQkRkY1JzbnNIMmt0NXdYYXp0dVdC?=
 =?utf-8?B?N2F4V2hMM1kzVVk3WTM1UGFtYmVmWjFaYWg0MFd2OFNMdGwway9wRmNVT005?=
 =?utf-8?B?eEJ4OFhEekl6NERrY2t3bSt0UjJJakQ1S2FwSU1TVHBHSC8vKzBtdXdkOEdQ?=
 =?utf-8?B?NFRyL1ZOWmZFSzhMN2tkdmdIWVdsYVFROUpjWUw2bDZwUlJHekJQWW5IekVU?=
 =?utf-8?B?QjdIN3YrVFFaamQ0cE56eDJqenE0SVNhS0lSN2ZnckRQVXJ1TE9oRitRREgw?=
 =?utf-8?B?NHlEQVZpc3VTK3E2RHlIZ3JCUnljM2hUdlFRRDIxckp1YjVKY3BGRWZ3Risx?=
 =?utf-8?B?ZTlIdEhuOWt5WSt4c0E5T1l3cnFCaFdYcC9yR3hBd1NPVnBUZWpOcDJNamwr?=
 =?utf-8?B?ZTd2R1FVUklHZWFvM2REUDBKUENRdUp0ekY5Y1ZJTk1mQ2tjWjgzVXlFZ09h?=
 =?utf-8?B?VU1PVGZJdmxZVUtxcStzb0drRGZZZDFvV3hvZ056MEtHWjNGVlNvUT09?=
X-Exchange-RoutingPolicyChecked: S8UTSwGKS7c5tTrdAW2K4kgPV8v3rIgpIbz0DEQuTPOhvXUJDz6/YHV0FKLV54zWar9MnTBPS3aM4Z+MvqCMnRi7eIEB8H9M0I0bKdQMCSVsjsekD6+poxoMgPfmxYanBXxk9U7WWu9bTF+tW0hckADor9blX4k4uezq/Sww8sUkgOMpV5fyRkctdDY0tWvdVDdDvqmeo6+fP4iwHSjJ7A6fCcfwaRe/OG9GrGke4bNBePFV47SGJOtQfDDMYxxQGC95vTUk9wnwA+a7q1rHw+Tqs+iF8jaLi8FX9Yrk7CA/2EINzqGJJ3MYDF2EcBM6bW3ZQSf+RivlD8tQuYBzpw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MZEdsIFRbrssMZo61RJ54iG1DYr9Qg4DWIWrqpZrTO3HgIw/h3+JRlmnFhXNEVaZNfE18khMeggWpwQh/4v7sfhH8olqMD/UC5d5uEnx7tgol6hHfazcN8q03hR2z1BOqEEw8lVaCcCJV6/ZkXrcJk2brozhl9ymHNQvcAP1TogIQOF4Sx+T9Yf2OwqF9hjyHfL8D/VGd0Cp9qw8THd//XJU9OPj7NfWc6SQH+450ItieESz+9Faokk5j4dnOYgP7Pg/NyQ0D70o+ciyVY+WXipeBBezphjvFxSRBf1CZ6CCKhClLg0Nv374sQleceWTJZP6RG2O0iK3A1A3xZSgxKP2FBiBzeBkku0pkgpoamHbcVfHsdlbw+SL+LfujQEmzG67BqB4KK6uvZhmlmrsbOAJjE79V2IjyW1lVjIJDupsp4ZcA4Ql6sifQlwydpaYJyld1av89L7cH6t/qkz8ig6J0gsyMCUuavGoLSvIE5PGa8JnnsBW/IvBEr3k4pvcj04SIkgtJFJsyPJ+QIPlM0QyBbFkZdMywKFkdevDSqxp1i8MnJ0SkplNcKiSSuFtIBgZERO99K6m/+ixbW4kILMTinsJkT42NDA17RXulww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2698229-af17-4c62-d004-08def6b71f6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:12:30.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpFl9Cz74sjhaiVWnHDuCs3QmPPiSOZZvlAOLOV3s2Yon+I/RzJgyuP+GzDnqkQ1iFQgGTMEcNN40xDE1NFGtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100069
X-Proofpoint-ORIG-GUID: htUQ5Bheo9iY2Fj2yArHx7BS6rAhHDDH
X-Proofpoint-GUID: htUQ5Bheo9iY2Fj2yArHx7BS6rAhHDDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3MCBTYWx0ZWRfX3l0Ud/ogQWQV
 NejgxR6XBWXfa/oft40BXhz/S08fLsFyF4nHPosB5cb0xkt+AmL89aJbGmOJdOk2Fcz1h0mA8/j
 vaDFnVoHTONjBFxbQ4ChehIdHov+a5/xDBFPYA9EgcNtX82Q0rvp5x37mE9wh57NMjk3ZoPWnGd
 OArP4XSyQeSs2Ifp0xStKEMkftnjhRaUFq/jX2GCgFEXT40Lts5DP//LVAkRpbBWPD0RM0wK4MH
 kaEsDDFv5sazLE38Ol2aUjJB8o46QnZTO6I2x9M0k6C3+kHSmhP7K21/TKpoiZ5BYyXxUyGXkh9
 n3twVAT8EI0LgWtsMlfzXPSzwPxc7l3OPB6/6Vo5XnthaQP/IIRgksALD0hrBIeO/AG3naP3zEl
 m0Hez0aF0pIb3GMvRU+d++OJhavad4HtOCZdJ8QbLqh1MYpqzYHbE8G0Y6fzD/6OFxwBZ+Be42w
 nt/iS1L/yvcz/MauLc2J7suc/fmcVIMKsOJidHNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3MCBTYWx0ZWRfX1Ad+OraKhVEx
 7gR9pilDuwCXBeBSdgCMiwzJLdpCdwF+VLlwjPTtFvxcheZjakxhH8i+YAw4kYOFNweO7DtRaYp
 +T+p3D+EpSBQgeB4E0Bq4BgjGK82ywejBsnCMtfFtZNDCw9ZgVwg
X-Authority-Analysis: v=2.4 cv=L/YtheT8 c=1 sm=1 tr=0 ts=6a7987f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=XpjItPkNhAm3RvGIFEUA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_011300_136017_CF621547 
X-CRM114-Status: GOOD (  13.48  )
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

On 09/08/2026 11:07, Nilay Shroff wrote:
> +	/*
> +	 * If latency > ~1s then ignore this sample to prevent EWMA from being
> +	 * skewed by pathological outliers (multi-second waits, controller
> +	 * timeouts etc.). This keeps path scores representative of normal
> +	 * performance and avoids instability from rare spikes. If such high
> +	 * latency is real, ANA state reporting or keep-alive error counters
> +	 * will mark the path unhealthy and remove it from the head node list,
> +	 * so we safely skip such sample here.
> +	 */
> +	if (unlikely(latency > NSEC_PER_SEC)) {
> +		stat->nr_ignored++;
> +		dev_warn_ratelimited(ns->ctrl->device,
> +			"ignoring sample with >1s latency (possible controller stall or timeout)\n");
> +		return;
> +	}

JFYI, I gave this series a spin and I see this warn a lot:

# ./fio_read.sh nvme1n1
iops: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=libaio, iodepth=100
...
fio-3.38
Starting 10 processes
[  130.005374] nvme_mpath_add_sample: 29 callbacks suppressed03h:08m:36s]
[  130.005387] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.009968] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.013176] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.019576] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.022275] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.024762] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.027268] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.130140] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.132316] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
[  130.139279] nvme nvme2: ignoring sample with >1s latency (possible
controller stall or timeout)
^Cbs: 10 (f=10): [R(10)][0.4%][r=35.8MiB/s][r=9171 IOPS][eta 03h:07m:44s]
fio: terminating on signal 2

iops: (groupid=0, jobs=10): err= 0: pid=821: Mon Aug 10 08:08:28 2026
    read: IOPS=9239, BW=36.1MiB/s (37.8MB/s)(1434MiB/39744msec)
      slat (usec): min=25, max=110836, avg=129.22, stdev=537.18

Note that I do have many heavy kernel debug options enabled, like kasan 
and kmemleak, which may influence this.



