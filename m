Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D34FCD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PM26yXelfceNMfPjZ+6sRKzZlMGtc8YdWRcw1YAfx5M=; b=M/omLEZBAcA0xBBo9dvfcL6BYH
	+RPzMSJQzMYFR1Apv7am6pWPVRq9Q7guEvZ/Up+cSv0CoujvAKb8W66+BMW9DOmUFyZr0daDXCLSU
	PYC122opGmG4IrWH54CJmTCNp7SOjSpk7XYNW88rzkRg80/gNtsBdy9Rw9isT0z73ZMbt731jY+IK
	KWtqSwB+z+6zVGRM8SBC+AJSgbOgiiJg3IxdZsJ6W7zuDcBAnvnB/VjDO+gUJGnZsFcqrvfjbpq17
	lc147uCxqqXkvy75fukem6+F4DBzAatfrWcqXfLHmt3kr/DO2G+M31kK0szNh1+PI7q1mdQshUNDc
	QU4eCFOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFhw-00000004LTI-3MUN;
	Wed, 27 May 2026 14:58:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFht-00000004LSW-2fyo
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:58:07 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64REhU4X1250740;
	Wed, 27 May 2026 14:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PM26yXelfceNMfPjZ+6sRKzZlMGtc8YdWRcw1YAfx5M=; b=
	jCP7nEOtjK2Oe7wkoWVBghQLJh9cjKZMQrddNO2Tp077cMYKlw9WvcGk/yAZosDY
	iufSmyihvBZso8DuJ/XIAUEX/g1lQiOCE0rYLO0xEbEwvKQpvntO5NxUs+cpctVG
	1SPknK6lw4XevqSiqyF2z77TdmVDzcFy9iL/EE7XD21W66DPUYocxk03cR3bPpb0
	vgKwILI3BUyxZNK8xz79gSruzM74/LrRfRS85/4SEU6g9R6RRgcYm5YswTtE5uH9
	PJrwgbgL1aPFHJXK6UZAqlTPB4UD7P+vFzbfa1E36UaM3KxfEB9P4mpbUJArsIMg
	x592Vayks34i2iGecTwvWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4sq5nxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:57:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64REssNq002161;
	Wed, 27 May 2026 14:57:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjwy55d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:57:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+MtcCv0UhP8gKFNN8oDiwV+WyOOeWTQYdqlt7uzGkjopIaL3P5jOzmN8hnB4stF9UV+wWtaWcBJvxKAYCiYD6pvLotIiAEJZXiEfvmJH/Q60M2/k9ir80u0PMD11qdR4KCGGw+XWGoYOxK10ufpY/IIqtSAFwb4Y30wYO1zNO/AA7O93/z+cX9fhldlZ94PHxNA0upMpsUGGr7OPE0W6kXSwjuxXtpXrrrL0oz9PCzp6B3Ea1CW1EjEHnMNr9QAY0gY/GA22LRMVQBVc8a/nDQqSi1NKE9RoLUCDm0s33IzdVGD1twcgNa0wjn5OyslTkGccjQeE7Jn9GqfIKSpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM26yXelfceNMfPjZ+6sRKzZlMGtc8YdWRcw1YAfx5M=;
 b=j9B13jVv5AeRJl9JKBXHZP5uOI5NyFxxkbVqMzgx6SRZdWQOtSv3HGuZ2uoPPPfzCI3qAo1COJD8HiPgQJ/0k8FkMBlQkduBM3YIX0wXyVvTsLlpSfTnmg5GZ1KCQmkmDNPHwExKkOuWQ22GxNVTcminQP1AFnQBBUGzRhNeAYxHKC+cOwh8N75a8H5hOt7km+938GlRdlmXFodfr8gDQJXblPs6V1XIivvWy43vZclHbLst6F3Cwq9mMqGEOB0th4VNmeX/18kzNhwdJ0qppcQRbppZbBbzjcABB2P552DMF4m4chE2kA2coIcBATWbmp6kjEoIUhPyp5UKwX93Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PM26yXelfceNMfPjZ+6sRKzZlMGtc8YdWRcw1YAfx5M=;
 b=jTepgTahyV+CjRAdEy/hzgmXzD5LlGjFmksbznRJX1GK9IkJ3TN8++tMyj4K6orG1LS+RsydYQYBKrcr3gdNzV0Bf1YAPrkVedcOyTimjEBKFoeZlpl4pOACVeFOiMicIDCxUKYmGHafngBAFWaNohKdAA05vYKEYQdixxDKAvY=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH5PR10MB997758.namprd10.prod.outlook.com
 (2603:10b6:510:39e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 14:57:51 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 14:57:51 +0000
Message-ID: <1db1cb2a-8975-44d6-a889-ff158d1c328d@oracle.com>
Date: Wed, 27 May 2026 15:57:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for
 multipath_sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, bmarzins@redhat.com
References: <20260513095030.2771178-1-john.g.garry@oracle.com>
 <20260515044529.GA4003@lst.de>
 <bea351b2-2cfe-4a3c-b2ad-7185b29a4af3@oracle.com>
 <20260515113459.GA25213@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260515113459.GA25213@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::15) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: c74d0801-86f2-442f-57f9-08debc005306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: /n9LaUwiFig7IldzDGwGzXrn1g6bEFoSZ7Ig2TLOGMyIwZtbQGsvnPnOfWIHPZgA/jqmUgJM5Gf+iknYw/dm3v+E+MgYF7pFtw+U+BMWOTg7rn35DxjrkBSMDQna6OVR4hcsaquUMxaP30UwVv8WPl/2z1FtYHhvH3PJE5fEx+xRmB4017W4MKlMbTD+HbXZXetZ9jfVDt6FWATWe2OlzBY3rdqddbBUUbWsBZXX7LNG73J7//1Q7CbDnjAvIjU1qdA4cVgVPjTIRP0Ea0PV3sLk6Ns13inDkCEHa3zi9cz/jBq0RfrQDfR0Doy7sCjcz9T5yIALZKj69NBZvf7cBRZ+JzzHtfJsBchSDrExVZT1m32GZ66LM6B8x5FvhEhSBPLSa0b7BCbIm3R7T7HBcvAqOYq9qA8+otHtdf/wPyg2BgmVcQ/awMS2m9hEMJdkiRc5BreApa6gElvIsKu4wtKJEYTPA7TTD2svx0lDkU73t59JrnwAE4K200j2AEpwzxHzXEESFETw0e/MxbjASM3ZNo3b1ZLcS53ErA8LipJ0jg596yG7Ad/tDHi/GXCVRZL8XlSVHSZ63jtHj/wRgW20ckpUjrZgk5nW5Cv0+JNhOjvgiIt03d39taPKHa0DzKAnpifeDp4aDUyoeqMX19rQf7iW1oH26HeRURN20hvDGypAffF+nxmhsvdkd76d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FWLytwUExnbW9VOUJ4Mmk5azRSTmZ0dVViWGdwdmZ5SjlNVURBdzV3dVpL?=
 =?utf-8?B?cmZKWTBlWXczVmYvRUVEQ01WMHE5YlFDMm9HdXRmWExhSll0MnBUaTZUaFRP?=
 =?utf-8?B?TUJBMWVvdjkyMFZ3NmRrV3B6d09zWmlsaWNkNlVERlhUcU5uUHcyWitpdUdu?=
 =?utf-8?B?VEduazlXcEI1ZmRMZTRYWlcvdDlXZUp3L3VrbnBxeUlTV3RUcHVkK0JWdDA2?=
 =?utf-8?B?WlJZSEJsRm1mU09ETWxNaXE0alJDK0ZVa1RVbzZrajdBTmM3b2xjbzRDZE1z?=
 =?utf-8?B?dStMVXlKd3NCbjZwNlQvZWVpZ1RPcktDb2xXd0FTV1Y5NFA2bjhzNVZ5R2Jp?=
 =?utf-8?B?Vm1ER3BhQktzRnUyV0xpazFhbVlBTzVPcGlaTVpZZDZFNWlxVlFqNXNQVHpW?=
 =?utf-8?B?bHQxWG1nWkh6OHR2cEI3TWtoSkg0Y3krTFhvZC8xdTFRNDRjWVhTUmpMYXFR?=
 =?utf-8?B?NXdMVEExOGU0VTRWM0NMMWJCaDRKM0FxSjRnMDFaWS9EdGx6V1ZGMkQvNmdn?=
 =?utf-8?B?YWJGcFRvU2kxRXU0TE0yaTBsL000RXJoQ0lpcXltcXBrUTZkUkdDbmxTLzBD?=
 =?utf-8?B?clFRRWlRdWFWYmVpSkpLSTJMaDBZWTRwb3lZbGJ6OFhBT0dOOXAvS2ZzVHI4?=
 =?utf-8?B?enpjWE4xQUhTZnB3UWxObUo5NW11LzJaOWJqRVhMRkk0OFhaN3IvNytRVVZ2?=
 =?utf-8?B?WXJXODJvdloxYy95TW1Wc1J0anZISUFsRjg3a3F4MTFVbllVWDdwWU5TcGU4?=
 =?utf-8?B?dlJ2c3B6eklMaXZCaXZZRFg2K284MGJvM1RMNFhKSTR3U0MzOWZWMVA5QUpH?=
 =?utf-8?B?NTd3NzRDeG83MVRmYk43TDNSY1BOemZLSHI0SU14aWJleXBVeFNzU2pkUnM4?=
 =?utf-8?B?bElhSldRYnU2RC9udnJObzM1Z2paOFFoeHZwcm5JUEZYdjhjeXRrbXdQbTQw?=
 =?utf-8?B?aERzUlp6RmpKdWdLalFsdGIwanlLbDdkcXFGV09aeG1tak50MHQ1NzZlM3Nv?=
 =?utf-8?B?dE1uSWRydmIrZnUxQWFTSHl3d0xiVzRCK3d6MTl2K1BET0ZXVXdqSkFoTjlM?=
 =?utf-8?B?MG5FcDgwWDE0MzFGMFJia2JVL3FodDJadUhXdUZ6SnZvdlVTRFhkQzJqam9m?=
 =?utf-8?B?WWEya1ZyaEpscHN1L3VSY2ltWUVTR1RCNGkvMUN2V2JSSS9QbndEblQxbjRF?=
 =?utf-8?B?NUg5K09SSUhxeW9mZTZCTVRiWHZLYmRRa1d0R2NJQzFkV3lncnY2TUpIc1NB?=
 =?utf-8?B?aFlxeUhpWEtqM0FwckUyak1VbkVESkFBK01XQ3Bsc1NQWDdwY2lhVGNqemFP?=
 =?utf-8?B?bmxoZllDWmRra0Rub3Z5WGZ2NXZtWDB2V2Fjb2FDNlRDVFp3S2xvVGR0U3RU?=
 =?utf-8?B?TmR5MjRBRkhPNVVGQkRWTUk2QmQrTDdwVDRxQzk2UHQ2dTVGcjJvNFVBNDBk?=
 =?utf-8?B?LzNPRnI2TWRvUDNkQkt0V0xVcWtXdkpIUVJMc0ovQmQvc0hNbXYwdzJqKzBo?=
 =?utf-8?B?d3Yxd0Z2N0l0d0FUWVI3Um9oeTFObGxyM3NFcXd3b3hTS21UejlGaithZC8y?=
 =?utf-8?B?QW9kNGVxR3RZUG5oK3I4WCs3dzVZVzdEZy9SeHVKTzkyNWpTOGJzMXc1N0sz?=
 =?utf-8?B?enAxRE8wOGpZZGoxU2tFWEZXUWRteWs3UkZyWnFwekQ2MTJtTFIydHVYc0hi?=
 =?utf-8?B?elMzTWxyd1ZaN3VobURJK3dQODZTd055RlJmME1QSnRzczIzYmpxZmZIZTd6?=
 =?utf-8?B?b1pITnVqK3RzRk9XZyt1MTFDQ2FFSlhTREkvRWpCcFpYclJMRUhGMHp0UFNr?=
 =?utf-8?B?aTdrRWNIS0xEcFhjWkRBaURKUDVoNWVRYm4zV2sva29GZjJqRm9aaXZ2NTFo?=
 =?utf-8?B?WW5mT1Jqd0Vta0d2L0tCRlpZVkptdkJjUTJPTlBLc21uMmYyTXgxSzZ1U3lF?=
 =?utf-8?B?R3BCVlh6REtSUUFJQno3dmpYbk1tRG15TVBvQjlMb0d3OHdEcWxhRzNGV3hz?=
 =?utf-8?B?OG9TTnRCKzBtUk1PZWdUc011S0ZZYVBIelBSeGJPR1JkZDBrQTZPVUxOVVUx?=
 =?utf-8?B?VTNEVFNLQS90VytuNC9uYkpzMGEzVWFFaG00TGNHRndqbW5Ic1RFVWZCaVpU?=
 =?utf-8?B?OUZwVkRaT2FSTW9adm05YnpONndZbUQ1dkk5YmZKcFRrbFhvUkVNTkJKOENx?=
 =?utf-8?B?Z0xXay9ockJUY1dhMzJUZVdZd1lVc0NVS0d6Q2FwYkN0bEZHMHl6b1VjeWE1?=
 =?utf-8?B?dktmYXRhZG9UaVozamh2ZFowRjNKMXh1YU50c1NlOE8xVncyN1F2U2wxamkw?=
 =?utf-8?B?Y3pSak1kbFVoWmZvYmg2SzNRbHREZko4OURRRVk2VWNhU3NIZkZUUT09?=
X-Exchange-RoutingPolicyChecked: rHJhKzHytn4BHuLOaYtWP0gek23tQ+5MWrzlIVvyJGXag9hoaKy/CC2d0LZ2XynnkrSSS9LAV+V3S+dZKV8zyahdoagBYfl13iajqnnPJxG7Ploj1NoRP0XZhjSleRwc6f1Q/xIO3N+/t8Q+eO3S4PnwyXICOM9dILjnEuY0a1BEFkqnQE8N/CJKDKmVnZCiwjHadEzdREn4fYTO7BJb1k+YxKjbm67vgILCKzz2xU4zBlg6a03/NhsPwpGgSxcCghVw+1auQrsPW8/JC3nQAFuBiDCqGVedQpvDelTC6rGwjupWxhx9O9K43Aupyc6a/QWR1HgRVyxBeAZ2djEFHg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LfMmaoHwrOO4H3rQb6QXsSe73uZEvxUaYHDSAzi3tMtULCeWziKwAweo4UUIcnCbD7HXdZ7ju8mYeyB9nCmDOlvPi8X3/HwkKjLT58s1XIWJKbBRWjXij5aI3+o08U9JxcMSPrYBTQxNEmOxGB/MU/sqkTZsSxNBG1rbqke9Uv4n2VxcvksPsD1ERmXLGxOyi/RhHXVsaYLN0wL+zWwfVPpwSzAD34o0eNi2Gx/wTLqppJtPw2QOXdSsQnBlOwyNuSBFbSe/xx5pJ6IifMt/xPmPk0KCGjEymLBI/fO0/XYs82jaO3aQxTZipyyhsARq7CPJy139USE3ek8DT6LwY01AJYcujHn+Z/Ht8YKBv+zZBPKAqxN3ZFXEqKNqGZST/Zll0/xGTm6r9DJN+ud15nN9BY/yb4T35TGkV4AyKjJ0omaFoPbXgibnk4v6bySHSbhDLKZ+awx6wItudFkn1AkZ9MQkju9cIpmyvSW3P1JLFeGpWpw0k7irxGBT4K/rYO1CljoB+8s40GagKuZOvr+GGvukqo4/gd9E9yzNfWabSg6yiMRKazh2R6msZy+8A/g2lY5cm/ULJXp0br14xxDAVRW5IMTTdlKkHF37HiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d0801-86f2-442f-57f9-08debc005306
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:57:51.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZD41glbMDMD9JXY+wLjOkMDjSmROZvuxd6FyRvQdBbl+O1jhS70bGqkdXFbeEuZorndTVNCdOHaLI3eUp5dHIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=913
 spamscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605270148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0OCBTYWx0ZWRfXxfoyg8hFwoyC
 yO0sIPGuG1qRHuclpyK1tMdlb3N8unqsZASYUrXhKSO8DSTIrg3OcN5AdWnsSFaATxJXXQhYl1j
 NVFpnRSWpa5etg1cjFCWz7TDLGCUjIEpfn6sXgrSxWjuGjaA2r55IYDwOApZLexwY0KhK68H08D
 4V6e1FnOI+VxxYFArvPjnMRTqN70AfcRzLP3AvlAG+VRh1exSNnC9tXFaBZ5cEyGKVTAummJ855
 YHDX+hg0h7YCB5TgGTjiv85lRTsSVOPrnlX9XUILs8Q+AfJhk6kS7+ante6JSxjWWJFmS5dyJQD
 jk627SD4zEOpT1jDvnbvmszHXWHrLMNoQGCN9vPeiuo8lNdnlS09GEp8L7NG78uOBBlUgv0SUYe
 mCyaRJsDODvT/98PF/5wTrHmzvouei9UvQIU2tID6/O+LjdkHAM8NeCzYmSpSQcLxTxFJ4hzjv0
 5j+Qmkqd0falg2yVaWw==
X-Authority-Analysis: v=2.4 cv=eNYjSnp1 c=1 sm=1 tr=0 ts=6a170672 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=H44RaS48iy3EBdjOYWsA:9
 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: vOXWEKqLk5y6QqrTIS3jbfvu-hgATpH5
X-Proofpoint-GUID: vOXWEKqLk5y6QqrTIS3jbfvu-hgATpH5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_075805_688209_17DC77D2 
X-CRM114-Status: GOOD (  13.16  )
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

On 15/05/2026 12:34, Christoph Hellwig wrote:
> On Fri, May 15, 2026 at 09:34:30AM +0100, John Garry wrote:
>> yeah, lots of #/## from those sysfs helpers
>>
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Reviewed-by?
> 
> Yes, sorry.
> 

cheers

Could I get this one picked up please (if ok)?

