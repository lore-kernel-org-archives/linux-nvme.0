Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ED1C5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aF+8p8+pZKe3DThGf4AFHr0z9MloJclq3XWVeEu/EiA=; b=mkvtfQP/IYIs4enY6dQFvQJ59M
	GhRmV9RDpVbxuQTOakp/SCIMlRX4dkftRbkD7qjxLZnvOas+kyTpjn6dA3+O2Rd9Fu/Dbx+5JJt5y
	5xabGjfZuHatY4rfmgHhk2c2OCIUX+FHGYx2C2Gw4IruzGjaSETZMXgbDRgqbMOdnRnujDooIh2yU
	eFc5f/VoidrT3ixE7Uz0pEDsgiFuCVDvgjI28J7NnwfjvVMwPXA3g9jeaz49hBH0jvNrhyiU3V2rb
	K56fnDvnswADO9i7sg2lMva8wdvLmCsId20eUoiRSZBrN5U/FaOs0LpdhRRVLHD9ImTjGovKacw5a
	NbqsKClg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjhI-0000000DqoC-1ptJ;
	Tue, 11 Aug 2026 10:27:04 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjhD-0000000Dqn6-37Su
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 10:27:02 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B9MdZk2021970;
	Tue, 11 Aug 2026 10:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aF+8p8+pZKe3DThGf4AFHr0z9MloJclq3XWVeEu/EiA=; b=
	ClqCa9Q0U3W+Bt1GWN80eLSRD21/BzNB0L3P872q8PwYZ5AZzS8iIli4VELoNas4
	FEHqsMgJiNAj+s0lGu0vv7PgMyXhbKWsWKzzP6fQquQ3qQC0NmqQJJvNoTs44/+A
	9hCWfF60kAS6uHFqeCUqZTjqCOKTsfUgubfn+jip7LoGAcpQvVvS1aFtA1bFlWpy
	z20dU9WF5L8kMDKk+BKAwMkJ7yZldIp7uNfnpLn1lP0FLBir7qmnGJpqwcy7nAeg
	ycWuhIpvvKoCM6W9BwBpZMjHOmj0CuPQVR/Jq5nbE+uNVrYH2Q1I8ADk1PyDuXve
	h5woYCejUl/P0rOtkU7h3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxvkq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 10:26:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67BAPVDc021200;
	Tue, 11 Aug 2026 10:26:49 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwqbuyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 10:26:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DutnsgGNPObIZC/HZISoc1PJ/TWNjzCMAdbbR44dRPgWn/VpvFnUCEa8/9HwN2W6tkdIjpTUtVwsKHI2mTWzwgfP4kKrkN5AVv4oIUJdwQyhIDQz5YvkXR+iJuSW9jUVFk/eJYiL6EQXVdWknlI/XkdUt5RuDqJFTGLa9UUhac//vcH85b3ItkKYvF+ZpMbs7UO47bIv0ekNbRcakLuieH3tXVAJv4z7bFTDXox7ndlvlhFAvXkJY/IZdWsgauUtfuhNpCUZH8vw6D4SFUuRwvE2Di1Ui4q2iEPO1zV39Hf3mzeX2egdapyg25WDSBTCHtfAHgM8t0n2Z3pmKy9s+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF+8p8+pZKe3DThGf4AFHr0z9MloJclq3XWVeEu/EiA=;
 b=G9bxfHJ1JgHbySRCXs6kP3m/Z3BCOukMJLQQpODDRnCU58mDfY2kIqZlr/dzeCB+65ttcx0lKe5zqnU1ODIeoZSDHyThA1O8lfD4a9QUg04BQMACfr8eekHLrNpUzCIeEjfKVHBcIrE+Tq6dxFhCMvOb3GYNgIPPNbqRipG1UjRMdVpJfmqdgbY4CMj60akvjuJgeDAJhAxtT2vLYtojhJsDdG2vUnbEpj2mMH9Yh27g8vaWj6A2z1IXcW5uFXfUFcXJVWxJ2eXy8gqnvXqHZUDa2JYG06i6Bc1onjLN3podCzHtIxp6N3eztO+U94Qw5OS3zSGikc54I4yJVDi/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF+8p8+pZKe3DThGf4AFHr0z9MloJclq3XWVeEu/EiA=;
 b=fazGmVFE3TrdF1dEbhIr1/P6wlYXEfBrXmOK++iAWgquH2nitgGQ2h64pDu/6I3HCAD5tBl2qjG2Awhn7CM9M2YNIbJmFnir/nm+3KdHzrVzf3lEuXty+kI1wDGaIgGjiXxscdeJ3SRZhreNeplo4Zy0F705eqNFhC0jhVX3v5I=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 IA4PR10MB8568.namprd10.prod.outlook.com (2603:10b6:208:565::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Tue, 11 Aug 2026 10:26:45 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:26:45 +0000
Message-ID: <a9d2c427-4360-402b-bdc7-136f85fd4d9f@oracle.com>
Date: Tue, 11 Aug 2026 11:26:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
 <2d0163f0-ecf3-4f59-9121-587f98eeb54c@oracle.com>
 <4e157ebe-7afd-45b9-9d35-f866b6f92097@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4e157ebe-7afd-45b9-9d35-f866b6f92097@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|IA4PR10MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d9a77d-e63b-4dc3-eb12-08def7930aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: TgIk7nPYg3lA+MOiw3rg73cvyho8hwk29fd5PMKMpmQoHmFDy5gnDwItcAOXBo/1090HXSlMzmgIZQplZGtUwKjiPiLs3Pd2FNvX0Az6VkP1GjWanpQA0QN0xOkKLFQH/ygbb0XGFK9Igno3V+W7Uq6HdYOlNoZSjauqsGBYVkCxWH5otTcrcNOJlTUEnD0slg3QIa2Pp3F8a9pWqHSc5J+tznVKAUZtOv/MoVElqCs36Z7vLZxXjQf1ZqQJl+TeqTrBWDMEdql+QIgbMDvRGKnZiWmapwUN4YKqI0DhFn/FIi7gL8a1QBNZ/kCX9wTGYmNlrJOlZKHLFQWltOth8XKYHEEmW3ZlRduQTTaNEHIb3N2dWaRiYgCj+A2gcCOh66jZCyvOjlYTwF5w4JpHlOeDdz97mix0KooiWsAPxWv4gmuGZcEhxRRoDzIaL4fVi4ooj9xEIy0qLrzcLVWy8Jx6ffZ2E68G4DIswBjKXR5m3/5iLDiQlT70JlGJ8WPivOyW0jsTRlryseQpgo1LCmky/V6QJRMPv9k0C/Q42vTxNIrbaOemJum+/IKrfLgfeC1Up9WEs2f6yNi6RyGFo5knW+5M9hKkGjBtUpqQSxPj7v4/7UQJxs/CS5FsD31WLO50EF4yf5IMiOcjTXa2+ZcWSyiTccS2fcUdw6JaOaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0pacjNqMzR6VXJZdWJ2UUhPeG44RlhCYVN4Y3lZWENGYUtjcHR0NlRQaHRO?=
 =?utf-8?B?Vk94elVEakUyMUVXTU5VeTB6TTVnZ1FBZHdxWmFGUk1YVTc1b2wxU0hqbkly?=
 =?utf-8?B?aVlhNVBpS00xNmZkUC9XNWNZNCtvcWVJK3RwUTd6cnRkQ1lmMDZmVXZTbEN0?=
 =?utf-8?B?UlZVZ3lkM2hQV0FiYVhNdS9YOEVkTkFkTmpib0wvM01tWDU4T0Z1d1pvSUhV?=
 =?utf-8?B?RU0zZStRR0hWRnJPWVBBK3U3elpOYVRvR1RZSUJBM3l4Y1l6ZFJndm5LdSsr?=
 =?utf-8?B?NFZPdWgvdzU4YVVqSnpRZnpwTDV1ZjZIN0pqS3NmbjRwN0RmbGdBWTlQUlhk?=
 =?utf-8?B?eWJCN1pFN0NiZURnNCtsTFZNaHNhZ1BJczJlYzNIVjgwbkFadzdNbTE0a3NS?=
 =?utf-8?B?d0FRdis5R2JJOEY3MVo2RWJLVExWeGtzcmoxcXhqSnpOT1lZQUZtUTNWS2dS?=
 =?utf-8?B?ZzAzUTl5R3dpQnh1TzhVWTVUd1JZWExDTnNuZ1hiQVhhQkp5YTd4UDNnZ0NP?=
 =?utf-8?B?VU5Rell6SEFGYUZBMXZXc0lXdFpMVGVkUGliRXh5SFRERzdQV3l2N3p3T0kx?=
 =?utf-8?B?TWJDbEl1M3JQV0JvcG95NUxCamlBWVpueEoraEp5bS84Ynd5N1EzS1BpZmJG?=
 =?utf-8?B?TDNMZ1Z1WDdWNkF1MG05Y09maVV1emU2RC8vV1R6NDU1am5ZUXJ3cWxZMk95?=
 =?utf-8?B?MG9RNDk3YXg0WFNneWlWYTBLa1ZPUlExRXRiNVhXTEh2c3pOMExKQi96dVFy?=
 =?utf-8?B?cmo5ektGZWdPRmxITVVlVjJ3a1EwVURLbG1JMUc1Mm41SjF3RTkwUkhjZHBE?=
 =?utf-8?B?QTM1azNhZWhpRERrTVg4M2hGR3h1YXVybUlXNERRRXlOMDJKekZ5ckFHRlI1?=
 =?utf-8?B?bGF2Z20zT0VUUkUzcWlSamg4bit5OG9CbDlPRVJHZ01YRXZkMCtkbVlPV1Bt?=
 =?utf-8?B?all0a29KWnA2Nm1WMitLT21NSzd5YTJIZE5PeXJtY055Wk05ZzQ5UjhUdUVu?=
 =?utf-8?B?b1pVN2c2eHF5WjdoQnJNdThpeEZXSFhyOC9tL3JSd3lvdXBDcEhCa1J4UHpn?=
 =?utf-8?B?dDlHUCtsUjZxM1ZQMEdOQ3Y5VTBKSm9DUmxwOWZPOWEwRXZaYjgrSjRSZ3RI?=
 =?utf-8?B?MGZtcjkwUkI5WkZCTm5sRmlTU1ZybDEwcUVnQ2l4SDBjL2FaTzhIQmpRWHFW?=
 =?utf-8?B?NS9iMTRlZlloUFhZMWRiQmtQY0V4OUNmMEpBcHEzdDE1UHI3bzkrejY1Tk5I?=
 =?utf-8?B?eE43UjREeTg5Rk9GUVBoRThFczlmSXcrcVEwakRiZGVLZ0NBVktLZkt4MERT?=
 =?utf-8?B?aHdySVQyZTNoVjFzSW1GNDQ1WVdYSTlacXR6bFJOVU1PaEJpc2M5bkpqWTRU?=
 =?utf-8?B?MWtoaW9zMXFlRnBsU3B4RHhGenFvTXc5Q3piVzBTck5rb1M5d28vem5DZnlB?=
 =?utf-8?B?Ylc3aVZsQklQMFVBTHhHSFI5Y1FhQ1NoQTNhcHdveWE0d05ZL3VUTE44eXI1?=
 =?utf-8?B?R0paU1VvNktKZ0x4QkJIWG1JdUJlRjZWd2k1Uld5ZDNGTkczVmQ2N2ZaQmpV?=
 =?utf-8?B?dXFUbFFoMEtiU2UwOExOdms1RW9yQitRRW95dkh6UjRtSTFLMDFCK1g0ckNV?=
 =?utf-8?B?ZzhRd1RVVVd5OXlmWTRvbVRCY2ZQMnRaZzZES3FGVXQ5N2xJMXo5WUZnc0xI?=
 =?utf-8?B?Nkc2dVlLSjBlNjdUZHV5R2dLN2RXNEprd3BtUXArWEQrTENvUDBwYStMVHFh?=
 =?utf-8?B?UTI5dlBKMExsU2ExMlJvOUNCUGhlTzZLTkh5d2Q1OStkSGwzbm1hMEVwRW10?=
 =?utf-8?B?UzZadXJ6a3YxQTVodXZWY0JqQWlZQ3FLdkFUWkVNMVd0Z0Rac0d3enJsMGFQ?=
 =?utf-8?B?TTc4N0ZTU1A0djNoM2dvaXM4d1g4WndHRm5uNGhibXBaNVhuVGUyQWZhMStR?=
 =?utf-8?B?SkxyMi9WMlB5a1VZdUFUUXhXUW1TYzZncktpV0hURkZaTnJOdnp3SkZWdHdv?=
 =?utf-8?B?aGl3NmpudjVpb0lUNmZKMkRESmlOb2RBalAwMHN5VlByKy8yMzBUVkQ2Kzlt?=
 =?utf-8?B?dHZ3a1NDb3ZjQThEQ2c2bE4xVXVKRnJrejMvUWdxc2N3VC92WTMyTDZ3ZnN2?=
 =?utf-8?B?VHhhR3BqUSt3eWoyZXUyWXZ2NlV1LzBQVXVIWU9Tb2JpUGNqM0NFek92L0p3?=
 =?utf-8?B?Tjg1TENZbjQ3a2JRcTNQbEJNS3Y5QnhtWTg2WjFBZ2krQWdoK3hLMFZ5akxj?=
 =?utf-8?B?UFZJMWNmWGp5bXJ3YVJCckkwWllaQThWY29DM0pJaCtjZnlhN0ptVnlJc0k4?=
 =?utf-8?B?NENKY3NkSnFDNktadkkrS1g2ZHB2UlFIMVR3bFVsQi9PK2oxU3F0YjFtRldY?=
 =?utf-8?Q?yIvO6l51jTZN+c4w=3D?=
X-Exchange-RoutingPolicyChecked: kecqvB7AJlpAgIps+h/tD1hif9366w8o+WvK2embORX4/yrfKRA62Lu/9PhR19Lxw+6Nw/mOPM2vCHQOc+v5dDEW7CwGEyq6zHZduSVtxxQfuXTFqIbfdJYegKMC/8aRuCXtc8DU31VEu+cEcmMiE3EcbdqV+fir2+2M37XQLeJSCUChQLmhAg2FHDrPywNEMkCYshqdcOU1eW9NJeBGaL1JdDL+pQD2o6qL60852W2D9fbQceGC6RIdnnVwBwOlqrXoNz6gWsI1KBZZEdLu5bWmQtwpd/TLOUAwuNcHUJw47n1ej4PGUcjF3GmtTbofnNe/ZwSIDhbTBOfnZl3o9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aiUUdsqN99qjnaH0FSjUAArIJVKHz1lPJjA22enZG+6zBqSUy1suO0fzT9O6TBGSSaM5xHOv4qbnrLz/dKVtmyRXVNQ4BdEEGav9XhNo3KMO+oO7diQDf+BInjod8CIdm9MTC9/077AwuLZgXW8LG1SkI9yWrVY2QeOkVZa4AUOTpF2ADQTDGhdYmPmD/6heN/O8kSJmXruwYhAFA045eae12H7Nl+FMxNjRDKvGLRaR5+jp+PcMcqJJoyGpgB8W5yzEY06L554OlVblRjOQ0C9aGuSxbyRyXLT2tx7UYbBcX6Z2tyylX/j78RvPxGClQXKooOM3i01On01tjj78j/lsp5c4yPs4VYG1qM3PuAW86DRWkhH9XUyoY0SG3z/kR+ybKP5gYLR6rCB0qn2CCNUEZ7qdlIB2TKQOj3yipA6XLrvj6hmUzF6vNkFwfOzwBClHKogxOeapMcwvgeCwJK42XUmjQ35SK3VSiEeYiptZoD4wIcWigjBtmF8vg5GBxqjOQhCe+yBG8JfLII2r0eRr17+wvYMKm98wm7N1vQR7ZUHfUsgexaoYrNPIEwDAM304Av1Ff8tPcuwnolOrdqH+7rpXTeE7D7HSZT96dZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d9a77d-e63b-4dc3-eb12-08def7930aea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:26:45.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMenzcUpa8bKeyuaEB+ujyXADpZ1tBIvVGaUjMJA4hSSBIXYNCuMYYVF6KibfH+d108c7Be+cqwPjPG99frUsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608110086
X-Proofpoint-GUID: fY-fbbadaNWK0-JoH0qtqTwAbxmbnnRW
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7af8e9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=iHgAl0Gi9Iyf7exeVugA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12098
X-Proofpoint-ORIG-GUID: fY-fbbadaNWK0-JoH0qtqTwAbxmbnnRW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NiBTYWx0ZWRfX8E5kUSxFZFNN
 UYOSkxhxisHtHop2hKbF1waMRnYdBlpyFpN5SlfdMPgKCWcI2GRMQ7BlsKQGW7Q7zBztto1CrMt
 hiPNFX0n+yxkmb4YcFM9Ezp8nFxYX9n9zg/c2IZE0j7MdHt8K+u/WclYgQWmnAvgQ1FKgNK/43G
 F6RLFsNo5u2PhdghE2Hbak1ki8LblACQviEiKGEqGtXsHedbFY9BU+iIKDNRjhsOLSrh4xB6aUx
 wzr+88jsCpOBn6G6RLQXgB70BebNBMMxgo43rqvvXXBoV4fmoxkcEYryJOTHl3DGetPyK7TOTv9
 6YqFsThnVaU3RNDzcN3dcP/ArDSPVOXKyl7bLh8CG4PMYmMWLCiw5lzdZ8Bz4LkVolYgfqqnLQC
 a64EpLRqXrDiyl4TxCEGMlCTynJek+TZILFqBycDC4WfBDJ5s1VZzx4y4SRzeOJ2yadu3IniW7d
 g/giFiJhnMq47vuBv+I45QZuywVv1LJj+ihCfByE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NiBTYWx0ZWRfX3Uw7rB0mDvOB
 yq8+Q3G/pnEm4wN3FENRnxOOu3/zdrXKvElRpzUkxD0AtboFXrDD57NiBr/keYFHT/P3rk9025C
 tLgf0fXa6zfMZ/WTHwwt1bJHmAXM/D/4oW1WmuB40x93HViToTvP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_032659_907974_A76ABC02 
X-CRM114-Status: GOOD (  13.18  )
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

On 10/08/2026 18:25, Nilay Shroff wrote:
>> 
>> iops: (groupid=0, jobs=10): err= 0: pid=821: Mon Aug 10 08:08:28 2026
>>     read: IOPS=9239, BW=36.1MiB/s (37.8MB/s)(1434MiB/39744msec)
>>       slat (usec): min=25, max=110836, avg=129.22, stdev=537.18
>> 
>> Note that I do have many heavy kernel debug options enabled, like kasan and kmemleak, which may influence this.
>> 
> 
> Thanks for testing. Given that you're running with KASAN, kmemleak, and other
> heavy debug options enabled, I think this is expected. Those configurations
> can significantly increase I/O completion latency, causing some samples to
> exceed the 1-second threshold. The warning is also rate-limited to avoid
> flooding the log. That said, still if it's causing a lot of noise in the logs
> then we could change it to dev_dbg_ratelimited() from dev_warn_ratelimited().

Note they these warnings go away when I turn off those debug options, as 
expected.

The max latency I was seeing was ~1.2 seconds. Maybe you can just 
increase this limit for ignoring the sample. Or make it a 
dev_warn_once(). Or control the warn print rate with DEFINE_RATELIMIT_STATE.

