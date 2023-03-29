Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39ADC6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BcYtjsllXEZlPBNFRokzXxk5CbAZmTgcXpGVqgmN7v4=; b=QBRMTO8iQWhQrTWCUfJZROSW0w
	QC64MyA3SeTLGQuynUgTdWVjdF/q/3PsyBBSqSiOQf0xpX44M4lO6XfD4NV4uv35QwckdGRe4UfTF
	7kS3Ny6+fh5D7WvksR6dgJLalpk0fjn+HIe9aqkjWnekRh+GkDLyhV9my9PuSM6MnM/173B8iOOYx
	ZaZSI9tzf51feoTNaMrDtZR3hBYstFzhbqMtHLwmrtKWssorVl8nDtixLE3BfL0o+0oXm9pGPAkvR
	pVFZDd77METHkqPH4C49LNPRjJtnFR3k6rfd464fnqyA+wieuZVYgl2ov1GzLdoKgJzHCd2WSgS0f
	tBKJScHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phYLq-0011MC-1f;
	Wed, 29 Mar 2023 16:08:42 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phYLm-0011Ji-2m
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 16:08:40 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEix17025285;
	Wed, 29 Mar 2023 16:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BcYtjsllXEZlPBNFRokzXxk5CbAZmTgcXpGVqgmN7v4=;
 b=S0qRixXVRCYBrCrw40rH0MQLwYiiX//g5ZGK8QPRkL/HH7U654xsaPkjAQk9Y216kWDr
 s/FM4wIUS4seQ4JXT+M+OzE1HiZ9Zt/l4ZnFxNyaxe3MgVLWd3bYFP0c9x82dEJebave
 4Xl4C/3/X3uDLAlY7yy2T0TAd8u5k2hnKg7U1tuy+ivo77ALuMNV7p9BL+vnZar+nbG6
 13XkwuBzDTMErfiQW6Kvra8ay2luqhwDeaw09ITR66ZE1NzPEOdoFUq8Gueg5gQaJUA3
 Glj1E5btTkhlbCyL2vlunSO5yUGdqzVBqb29q1x/bwfGwohzi3B+9k8EE22xVR4RO5mD Xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyr83s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Mar 2023 16:08:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32TFxCEY035035;
	Wed, 29 Mar 2023 16:08:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd8171p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Mar 2023 16:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAoE03aGtsSr6na1GiPCLeziaOhjsY4lX71/xiN1B2+p22nEwNfqUnLEUWxjP7v0Oh56ULLkt9+Xhval9MkMdFdhgh2D/glyqA8CTR6ozmAIQ6y/vyHOsj8LwWVLAdlGd04Cmau/65t6C0egQj1wwBEFh5rVC0RYIXQCqoYEUY1dDAtOHG1I1u0YneUIjNFxT/RjsGQUrnPyS6hQJaF2h0CL6WRG5jUo1vUfE/JarV0/ZKyFKTnrqE8Nx7zk5Ou/1Yzbj6LmXADMLpSe9ULC0BTItswEzBmPf6AKdyBJHANNu3kTexQSsQlldilv58u/2DRHmuhdppmogbix1pZRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcYtjsllXEZlPBNFRokzXxk5CbAZmTgcXpGVqgmN7v4=;
 b=L/K+KWxIbdWSsrIJY8squ0Mpfq5zNFVbeRTdqwbxsybW8UwbDlURu7N3sxec2tyJ/neHk4nvl48r+mI4pl2s+F9nEZPazbB/bp7pKksiGMcXr5VxImV4BVbjKfJCtSwTIn+JRJ+RnHPgsvGdd8a0XqKCMU4M3TbHpBQpyvEvkth1Hx8ov8UI6M9mfKbhnRknGuRWO9jmtaleRmF0wmnk00gM007wyYISVb5H30ihsjyiLCvhcfPZ74knVOiEa6jj5TtEW8FwwqCM49uCnYjE6F9H/H44GJ/cLn0gfdg3gRiaO1qtMYa9CP5gfC+Lz6DryWfWY+gS2TUwlkDmsoY6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcYtjsllXEZlPBNFRokzXxk5CbAZmTgcXpGVqgmN7v4=;
 b=CtZLYITin/N7ew1bydK1ssftDUEjR92y7G9a2mzqNj5xZtp6c97UYUDjSaLW/3Qmw7yBDW5iBocYi+PaGQAjBkrCwWJcll68rdSnU6VfJ+iZp21YIJbEvZDfoG+lvt7+LXOFa60kq6A8wHc2D06pGC18GNhaH3ddh6f9b8U0Pus=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BN0PR10MB5240.namprd10.prod.outlook.com (2603:10b6:408:12f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 16:08:26 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 16:08:26 +0000
Message-ID: <6c9fe658-42f0-a006-b8fa-1a8d87d681a2@oracle.com>
Date: Wed, 29 Mar 2023 09:08:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v2 2/3] nvme: add error logging opt-in
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-3-alan.adamson@oracle.com>
 <20230328005735.GC21497@lst.de>
 <89ee30c7-7c7d-b0c6-3234-07e698d211ed@oracle.com>
 <27a9d788-869c-93fc-9a24-48c163621098@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <27a9d788-869c-93fc-9a24-48c163621098@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::31) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|BN0PR10MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0fabea-2f21-4aee-4f7e-08db306fd433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	JidQweqCIRWrZwN5QQYutC+kDYONWaIHPMCoRl0L1QedyUl6dDtGagSUspvPPbBHTsit3LUv8J6rasuuMu/1E9JZuK9mcRtjTrBXTeHdABZn0tp1W71x80/1ZlAwjhKp0/lqAs1vh2p6KQwTcyR6UfnfY4TMQfF6qCGeAW58WQuf+0tdpucru0V0zfqQL3ccOUqbTzj7WPT6WmQYq4Jfu6c+sGOou3DL0kAO036mWD8vIjw6lGoPH/OgFE9ROOV1HAcmE7/6GiLEZNuW7HU6G8LY8/V/GvMsY2U1BYJSEm5nC27zxcPiI8BxkPbKTnRmDvfozqpYS3RIo35UDeKyM7e28gaXqXtSK/d1C5HUQhV3YI8GRCoWIgR9bk3yu2Ne2y1/BO7F+GQClTtwGMcyWYskaTKhY1LlUL1EEVESoDT8QksQ1M8WEZXf1Ff6oX6uY56cHX3hM13rgxQdIiEh5XgSVkC2IltMnhfSBpAsLkaLewgoAKMR8eG52DSHXSkEXUBNw1vy/0W0+Tci22pWuxAvhJWHgkL5ikMTe2jmqE/vBljUVCUmcsD4V1413N4MxB01/PHlO3KwM8TSvfvMCfx0cjo+S8smv09shDzTSthL5UKQtqeFYH9yTUj8XmLL
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(6506007)(6666004)(26005)(53546011)(66556008)(9686003)(6486002)(38100700002)(2616005)(186003)(8936002)(2906002)(5660300002)(6512007)(110136005)(316002)(478600001)(36756003)(41300700001)(86362001)(31696002)(66476007)(66946007)(4326008)(8676002)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?SkVOby82ZXdsRXVHN0YrTEE1Umc3UlFPSGZiQzZNK0JwMVhNM1EwcmpzL1Qr?=
 =?utf-8?B?ME5HLy9TeHBQcDROUHRhejJROFBWbWpxdnpmQTJjSERPNWJJMXJIVWtxbzFs?=
 =?utf-8?B?T3VialJBUnF3TGtZWU9BZXdWVWNVbDk4Y0hJdWJqMjBidzlhU3pwVy9DU0dD?=
 =?utf-8?B?SGs2Y3VVd3dQYktjOTZ1Y01WTEJVZm4vSkw0UU9MRENoRGNsdW1pOWdvZXRF?=
 =?utf-8?B?M0ZDSE9aZzIvYTdjZnU4SkJJVmw2Rm9vQnlGNG4xV1BPMjF3endveXQ5VzEz?=
 =?utf-8?B?U1JVMTgvNU9BQWJudXRpY2VNb2ZCNjRGaUY0M0F5Y0tlNmpVTm43Q0NXVjVM?=
 =?utf-8?B?RW1mdUp0VHM5N3A3Y3JESEhzSXJldkJ4Q3NpaVZVbzFLbHBPODBCOERlQ0tm?=
 =?utf-8?B?OTFRbjhFcE91WDRsUlpwRER3TmEvZzRFZmNadzlyeTUyWEp6OUs2UnNrRGUy?=
 =?utf-8?B?ZU9QRXhBYlBtbUNlRVZXV1FLakYyanNTZ1lYcjFTUHhMSG9tRjZReVNzVmIr?=
 =?utf-8?B?V3podlJYa3MwRU9qOGhrbXpiVU5Za1Nsam80VDZoOFliM2lvNUZVWWpIczNE?=
 =?utf-8?B?eTNwUURBUkNpbGRWWDBubnBzUDd5NUwwNEdzdndxQTNkOFFsMmF0L3gvd1dF?=
 =?utf-8?B?QzNKWFdYcytIUG5BamUxeWVJM1dCTEcvZzRFVmplYjIxa0dsT1hzZnhweVM5?=
 =?utf-8?B?eCttOVZZMlJqdEtxY3Y4eTlKY013Nlc5UTBjaHZhV2hIUmRIcGFCUlhBR3ZL?=
 =?utf-8?B?YWZjNGQ5dUxuZXE4UldsbmJ5ZEt0ZkJNa2tkQXZiNW1TaFRLc2dzOVN3VDFa?=
 =?utf-8?B?eGdtZWtDN1dxUUdLSTNKbkZEMjJZSWV6ZDFRSEQ5RTBJbDlQU21OdVIweVB5?=
 =?utf-8?B?bUpJUjAwRDZzNks3eUtNeXZ3enlwSm4zdzhiaEFkUDVoL3dySTU1V3A5YXI1?=
 =?utf-8?B?UTMrb3d4dTcxdjJmZldyS3YrVUhXWnpDcVRrZDFicThIRWUyMjBxZWh6Wm5i?=
 =?utf-8?B?SzNRMzV3aDlaOHlXbGJvcm44T3FodnJRRjFWMkxhN1NRbEs1bmJvT1ZMbnhT?=
 =?utf-8?B?ZUl4Q21CdGFWZFBPUDJsMzZ5Y1o0d3g5WGU4ZTRFaXNWRnR0TW5QbWxJbE5S?=
 =?utf-8?B?S0FKT1doNFlLWVY5dG9OL1lkczRBdkJ4N2YzdGVTaHFlOWpVQ0tmNlBWcXZF?=
 =?utf-8?B?OVNieFRMOWM4L25XQ0E5OWtOMnppemthN0wvK0NZS0k1ZjYxU1h3MHdCMUdn?=
 =?utf-8?B?MThKZ3NKZE84L0pMb0NISVBkK05IaVBVWFNqTG5oRGJURUNYVkNVRWVBQmF1?=
 =?utf-8?B?NDgrTWV3dHlDb2g0SW1KZnhEWXJMYjBxdWlrOHBZc05sREYwYm1pSzJzMndS?=
 =?utf-8?B?VUZ2OXV4UnZlZE5JRlAxZkVtTndYSWNKMFIxdnlGcUU1QktQa1R6MUh2eFo2?=
 =?utf-8?B?MVVTWG9oWFBYMlJqNmZHZVhMWXVPd2p1YkNISzM5TlJrSWM3TmxBVmhaY1kr?=
 =?utf-8?B?dTlFM2RpOWpOMGkyUEF6bVhVQmEyWEdZQVVaaXlVQ054eFl2Rm9lbi9Fd21K?=
 =?utf-8?B?d0xMQnF3OTRuZlZzQ3lidDZCMkhLZVlhaXZCSGpSMTN4RFRTQTN3SVQwRndL?=
 =?utf-8?B?WklTODg3eTlaUnRUdUVZUUNGbzlmSTYwL254Q3A2TmZadjBWNmY5UzdIZ1J4?=
 =?utf-8?B?RGl1TFJHKzVSamJKaDhuL0Zkayttb3I2bGxnNWdDVm9veVZQVEVkM0pXV05a?=
 =?utf-8?B?L21pZzlwSFN1cTcrL0FxOHB0aVIvU3VGQkpkOE1UZDE2Wkg4cHBINGxCNFYv?=
 =?utf-8?B?eG9YcWdqRWR2bi9kb09KcHlKbGFvL0lVV0dYcnBRWExtUjVIVFpZRityVS83?=
 =?utf-8?B?QXJmVWZoWEwveTJiY2ZXdVN1ZG1xb0pLNExuVmw4MFp6OHp1ZEZqUGFBQzdI?=
 =?utf-8?B?Q0J4VmROM1ovT0E0OEVHQ1hseEU1VWVybEZGOXU3dHE4aW1NWEdzTk52T0tM?=
 =?utf-8?B?enhOL0Q2S3hjMnhGbHNFdHVvYVRyRkR1V1RjR0ZmTmJGanN5bFNiSDNkaWRo?=
 =?utf-8?B?Q1VJMWlLZ2wyUnFRZ3lBYTA5R0pDUXJHRHRWdDdvaGptRjFyV1J0dHJFWThx?=
 =?utf-8?Q?++wSP0IOp7DaKAUSXmDCnwgCx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	Y6pUUPmDb3aL1Okbrw8aPj2xPERmADGv54uyVjOZJRAD113RIhzpIYNElDpDRFtT8m5vLfsvyVZFyfbSa2nZ16IYQTuVXq28oPUkZwRnW8i2cp6WBE+rDIfnm66+E/rxSK0Jn/cuC3NrwLwhAAxrODCUm/X7ChFk+lBf0nTmnXUjl1z3xhKlZJ+vsLsh4UYQLa4OIMUveGVOlGrf2sluFBXjjAGSpXMSqaw0BQAGD/+fmeGJYV3UBrK3dKZbJ3LslEcaT25+5vn4VjntZmX2WiH15a1mCDZkvl2p+XQ3YrWlmvQ2Gj21mKMOFxYj2C9Tt3SeZz3jHQJ47IjJXIeP6BTPyS6iQj3AgOjZ/oQtHrLgVqGg0eHbrL+wzCK06YJbMW9SwmBaPONGgPFRKpZUKwxujD1Us82cw4llA3rxgQEDPtVa3QZavMYb1tgrJWrBKvRcorWHcamCh/LEG8Z4KGOJckGo7r0cd/CPJ8l9XI1fcGKrcPpmm9afa0tGop/NHX7vZn3gHc/zVN12vxmLWSs3NjgROcB3cZFIHZQPpWuiCeJTBy1Hm9eJEAyYYUBHyGUlOTdHWWchKC38T3yAdC0tBGPawNRj1BxO/TVTvJpsmRJcoVRXQMhcFB1J6L0sOKQInMTueokMI48HUS3AbRM3oe2N6SFSJWQf3JXlIl2EVGVlhZGkcnIc+l78/ntlTr/hCgcowwFi7MFUtlbHQSBZvA2TNdvguv96bKJD2Q/XJ1FO522zM0qH5z7xljM2ZrfVui3iOoS72nj54hCJitzC0zHgn+7IUfYHV9VrsOrCHOAdNv5ELCktrKtjuZtE0v4OvTHkuHsCBH6TIeECcCxoX4uvlaJm4Vf7nwoCvpbb5hqOo/e/A1eCvHeln4bL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0fabea-2f21-4aee-4f7e-08db306fd433
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:08:26.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SspWq+WltsL/pjNcuFZ4KXYzLoJ6MFY/8JCfiVPT+NVopn4ZMGRN5tzoDWpk0txfe06gWmelQO/ANG6sL1Vow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290126
X-Proofpoint-GUID: DBRatTPI8LIeejWFoHyQziaKh7DcL1h2
X-Proofpoint-ORIG-GUID: DBRatTPI8LIeejWFoHyQziaKh7DcL1h2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_090839_017795_AB2B1F7B 
X-CRM114-Status: GOOD (  19.33  )
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


On 3/28/23 11:37 PM, Sagi Grimberg wrote:
>
>>>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") 
>>>> disabled error
>>>> logging for user passthrough commands.  This commit adds the 
>>>> ability to opt-in
>>>> to passthrough error logging.
>>>>
>>>> To enable passthrough error logging:
>>>>          echo 1 > /sys/kernel/debug/nvme0/error-logging
>>>>
>>>> To disable passthrough error logging:
>>>>          echo 0 > /sys/kernel/debug/nvme0/error-logging
>>>>
>>>> By default, passthrough error logging will remain disabled.
>>>>
>>>> CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
>>>> to enable passthrough error logging.
>>> Any reason to do this in debugfs vs sysfs which is someting
>>> that we can a handle too much more easily?
>>>
>>> Also why do we need a config option for a trivial mount of code?
>>>
>> Putting it in sysfs may make more sense and not require debugfs to be 
>> configured.  See below.
>>
>> Alan
>>
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 53ef028596c6..24b4dcbfe819 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -337,6 +337,49 @@ static void nvme_log_error(struct request *req)
>>                  nr->status & NVME_SC_DNR  ? "DNR "  : "");
>>   }
>>
>> +static void nvme_log_error_passthrough(struct request *req)
>> +{
>> +    struct nvme_ns *ns = req->q->queuedata;
>> +    struct nvme_request *nr = nvme_req(req);
>> +
>> +    if (ns) {
>> +        pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) 
>> %s%s: "
>> +               "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x 
>> cdw14=0x%x cdw15=0x%x\n",
>> +               ns->disk ? ns->disk->disk_name : "?",
>> + nvme_get_opcode_str(nr->cmd->common.opcode),
>> +               nr->cmd->common.opcode,
>> +               nvme_get_error_status_str(nr->status),
>> +               nr->status >> 8 & 7,    /* Status Code Type */
>> +               nr->status & 0xff,    /* Status Code */
>> +               nr->status & NVME_SC_MORE ? "MORE " : "",
>> +               nr->status & NVME_SC_DNR  ? "DNR "  : "",
>> +               nr->cmd->common.cdw10,
>> +               nr->cmd->common.cdw11,
>> +               nr->cmd->common.cdw12,
>> +               nr->cmd->common.cdw13,
>> +               nr->cmd->common.cdw14,
>> +               nr->cmd->common.cdw15);
>> +        return;
>> +    }
>> +
>> +    pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s: "
>> +               "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x 
>> cdw14=0x%x cdw15=0x%x\n",
>> +               dev_name(nr->ctrl->device),
>> + nvme_get_admin_opcode_str(nr->cmd->common.opcode),
>> +               nr->cmd->common.opcode,
>> +               nvme_get_error_status_str(nr->status),
>> +               nr->status >> 8 & 7,    /* Status Code Type */
>> +               nr->status & 0xff,    /* Status Code */
>> +               nr->status & NVME_SC_MORE ? "MORE " : "",
>> +               nr->status & NVME_SC_DNR  ? "DNR "  : "",
>> +                   nr->cmd->common.cdw10,
>> +                   nr->cmd->common.cdw11,
>> +                   nr->cmd->common.cdw12,
>> +                   nr->cmd->common.cdw13,
>> +                   nr->cmd->common.cdw14,
>> +                   nr->cmd->common.cdw15);
>> +}
>> +
>>   enum nvme_disposition {
>>       COMPLETE,
>>       RETRY,
>> @@ -381,8 +424,12 @@ static inline void nvme_end_req(struct request 
>> *req)
>>   {
>>       blk_status_t status = nvme_error_status(nvme_req(req)->status);
>>
>> -    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>> RQF_QUIET)))
>> -        nvme_log_error(req);
>> +    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>> RQF_QUIET))) {
>> +        if (blk_rq_is_passthrough(req))
>> +            nvme_log_error_passthrough(req);
>> +        else
>> +            nvme_log_error(req);
>> +    }
>>       nvme_end_req_zoned(req);
>>       nvme_trace_bio_complete(req);
>>       if (req->cmd_flags & REQ_NVME_MPATH)
>> @@ -666,6 +713,8 @@ static inline void nvme_clear_nvme_request(struct 
>> request *req)
>>   /* initialize a passthrough request */
>>   void nvme_init_request(struct request *req, struct nvme_command *cmd)
>>   {
>> +    struct nvme_request *nr = nvme_req(req);
>> +
>>       if (req->q->queuedata)
>>           req->timeout = NVME_IO_TIMEOUT;
>>       else /* no queuedata implies admin queue */
>> @@ -678,8 +727,10 @@ void nvme_init_request(struct request *req, 
>> struct nvme_command *cmd)
>>       if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>           req->cmd_flags |= REQ_POLLED;
>>       nvme_clear_nvme_request(req);
>> -    req->rq_flags |= RQF_QUIET;
>> -    memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
>> +    if (!nr->ctrl->error_logging)
>> +        req->rq_flags |= RQF_QUIET;
>> +
>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_init_request);
>>
>> @@ -3418,6 +3469,37 @@ static ssize_t nvme_sysfs_rescan(struct device 
>> *dev,
>>   }
>>   static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, 
>> nvme_sysfs_rescan);
>>
>> +static ssize_t nvme_passthrough_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +    if (ctrl->error_logging)
>> +        return sysfs_emit(buf, "on\n");
>> +    else
>> +        return sysfs_emit(buf, "off\n");
>> +}
>> +
>> +static ssize_t nvme_passthrough_store(struct device *dev,
>> +        struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +    int passthrough_enable, err;
>> +
>> +    err = kstrtoint(buf, 10, &passthrough_enable);
>> +    if (err)
>> +        return -EINVAL;
>> +
>> +    if (passthrough_enable)
>> +        ctrl->error_logging = true;
>> +    else
>> +        ctrl->error_logging = false;
>> +
>> +    return count;
>> +}
>> +
>> +static DEVICE_ATTR(passthrough_logging, S_IRUGO | S_IWUSR, 
>> nvme_passthrough_show, nvme_passthrough_store);
>
> Is this something that we need per ctrl? My assumption is that
> if someone wants this, one would enable it for all controllers.
> Maybe this should be a modparam instead?

Maybe both?  Have the ability to set the system-wide default value via 
modparam and sysfs to change it per ctrl?


Alan



