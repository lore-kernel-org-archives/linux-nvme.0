Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F074FC61DB2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 07:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0l24w9vUQMyuVdbLlb7H3MCM+JKaKaGx2G8iLIubHr4=; b=eaG3e7k3Aweorv69H8ej00mH/5
	u5+w7hMwhofgFd3BVvszgKCxqc0SVrjOmyfjDYUBOuD30FL8ykvCVfeGWvowqNcuC/zTyqrY/D7Iy
	o09mtJyC0X4r/NBmURhB4xPCOP5JRZlo1EPUElOyBub3DggC+weoccrxu8ByAbjNRw6Xk1RM3Vw/L
	9Og3C7bhSSirJcH7Z3kRlWomudSeaAR2Aeop1h4JKiC2HgKNe65IoxkrUJ7fQSO6C2HVG6dphcElS
	I3wdX+Vc8pGmHw3L4QKwdUatVG7uupyRN99io4MKx5D1nHrr9Tq9Z83n2xZ/q1EvxFyYq8hy72nau
	ZlTO5TEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzHD-0000000Fhkx-29ER;
	Fri, 13 Jun 2025 07:56:39 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzD6-0000000Fh9J-0XwD
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 07:52:25 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D711eE028714;
	Fri, 13 Jun 2025 07:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0l24w9vUQMyuVdbLlb7H3MCM+JKaKaGx2G8iLIubHr4=; b=
	akZEp4/ZX9nI55za7X5NMy3D4lqdNVZjEaxvwB41nF7FSyvgEamfhGbcHE5c/oGq
	jX9RDr/ln3Dl/Rc1ItelNPXlxmE8VZa2u0aCawPJA0k+qg9C4v5fTzL8W80I6/v0
	jnRNMkLOfF6BAIK8dZslrditQtEPm4aFZyFJepPO1tIE4YMvSJCspY1P7JwoYaZf
	D/q509upL7Jx7wwcBfzRIyV/8HZ+Y+viJdkQX8XR1FkhY9fTpe74iaq/ML51kVXk
	SsXYggcTpkLTiZTtKMgUQ+cxXC8nSCJm0C8EjfhFg1EhOTQ6tLqyTYYXf7zdqLxA
	xXhzPjW4kDnhHGXmbO2XPg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dadb027-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 07:52:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55D66bL0037979;
	Fri, 13 Jun 2025 07:52:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvjub3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 07:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo9vzJLwLDmBPeCP+TT2eW0JfL87SuNkpw1Mpxvi5ycYhDGkTcNR85Ah5XmuEIorjuenMF4p70oBWHmPElds68Js52CVZqdVatkKi8SVNVDCX2OWFYhvkVSHGhs7XF6LXmnCoJGhII9SM+joxxzgV/nWNmwJ4cisJm29GyqjIAUGMcI+6kVcydolduMZVp7CpKAQzK36CnIP9500+bX2OAa17WZ8m2k2w8W06rXSGlK+J8n77HGQy6GiXGcf5kcLsSkdCfN35HVFiI9bNiZSqncEFrd/eMYZrRD3zHLWathTvjUPkEHAoIRXqt946XLHUoRnbM2VV0tGkBOgIm0qRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l24w9vUQMyuVdbLlb7H3MCM+JKaKaGx2G8iLIubHr4=;
 b=r7vXSZvWOYidoLWqSHlFxo8NLCCzP2zXVEuCVCvnxK9/phMU99ocoyQ1QVCSlUu5ApRzEz64WDDMlWS9M3xUsVgV8WTjO2CtdokwkXLSpjbrvBvqM0xVPqH2iZOOLKB9US9rhjN3EB+u0xLXjWkmRZBWzhB181PdojObqh4qHdOU3L7kntTHKZ2O5BVXthhPNash7Mg7Il9GJHnuuHFwx2kW8u1v3KmPE0ip+NgXjJ0WzywHMvAfCg2jbFgUcbZ/NO7WkJcl51h6pbzomjpNGwk+nlTUkc/E9u1+PW1jbNqdDQmtDncP6s7R/zT02T2Fw+LgId3+BT5zmQKGgfdAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l24w9vUQMyuVdbLlb7H3MCM+JKaKaGx2G8iLIubHr4=;
 b=O8+eAUt02uP7XXQMxHX83k//Hl3c2oRpIJaQecVXw7md9Moic/dSdUkcJ6+xBcDbhk/zZVWdS/eCosYWSlx9R7tXu5dN6u/MIlfhfIleDbc59WnqtTkRoM7MEcK6+xv6bukwGOox8L+yuMYwy+afwSl3Jo97ltYEdQUleLebOec=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PPFB0C5EC304.namprd10.prod.outlook.com (2603:10b6:f:fc00::c43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 07:52:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 07:52:12 +0000
Message-ID: <ee5e84e4-77ce-489d-916e-4d9e6b269a5b@oracle.com>
Date: Fri, 13 Jun 2025 08:52:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: refactor the atomic write unit detection
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Alan Adamson <alan.adamson@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <20250611055432.2401372-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250611055432.2401372-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PPFB0C5EC304:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f810c4-5430-491c-9561-08ddaa4f3401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c29DZW94T3RaVkJrVXNvSTdDNFYrcDRQRkkyUkY1dERDSjdtS1AwV2QrTDZG?=
 =?utf-8?B?T2E2Z2c4WGxCZTA3MjV3UjJIV3o4NTliem5uWG1aakhSbkJIcERkb0UzMVB1?=
 =?utf-8?B?VFVEdWptamg4RTJVc1g4dTBkNU1sMHFRR1o0MkpXZmZxNCt6UFc4dVEzOVkz?=
 =?utf-8?B?dS83KzIwQjYyQUFuM3JNcWtSTHd6bXBHaldJQWw0d1A1TllXcmp5TFU5Z1Bt?=
 =?utf-8?B?eVE3aUl3WWhlZkZmSmJPNFZvVVBwOEc4SWtERUwzWGM4dnNCUkpKelc5WVpv?=
 =?utf-8?B?U3VOaGlaVGZCOEJZdVJKUGRwaW9wR1ZFQzk4dW5PTkZxODhDQ1U1cWlTR012?=
 =?utf-8?B?M1hMb2dVY1VIZW4rUHE2MXRqNHhqc0VyMlFLemlCRVQ3b0ZIeXdNdktJaHh1?=
 =?utf-8?B?MzRzNUtTKzVNTHVVRExCbzVuTmZiVm1wRXRkMlhWWlZjWHBiTC90OThxNUMz?=
 =?utf-8?B?U0NNbUdVcUtibFR0VG9HaitFbkJXcUhYU1pVazFCQTRYb2x5dU8yazFBWWJO?=
 =?utf-8?B?ak16dDQ4VUd3b1BaZWhxTzB5REpKYVVHbnJ4MkJ5UjVBN0RmRk1HN3Zka3do?=
 =?utf-8?B?QlBkaUhEeWlvVC90UDIzRkh1dG5WREFqYXNaNnVwNTcwUDA1L09nSzRWVEFW?=
 =?utf-8?B?dEJPNzA1WDd1Q0hncTBsNitkMkxQVnFyME1EbER2Rms3eTU3czZ2SHgvTGhJ?=
 =?utf-8?B?NTJrVGdudHMrRS8vYmFWTWQ5SDVoUkNQNXJidVpYS29QQnUySHZuVE0yUXdt?=
 =?utf-8?B?aW9jcU90S0VRTEtyYWdDSmR0VWV1Ti9mbG9hWnRWNVVINDVUdTk2NGZDaFho?=
 =?utf-8?B?NUdBOHdyNzNoTUk4ZXVwSThCYVNabjRpb2ZrdHFYaFMzQzNkSG5yYnByVXBr?=
 =?utf-8?B?SHVGZXlvSHQ1K0k0VEcwM1F4ZVpTWGN4Q1A0cnNONFhVYTlUR1Rta0V2ODJq?=
 =?utf-8?B?QVQyNlRVYzMvS09QN3RMd3BTNm54emN3djdTRGE2WXErYXc1Rlk4K2oxMmlw?=
 =?utf-8?B?YnRoS1FJNU5jSU8xWlNrQXlWR2xkdStTR0hKc0UycFNxcDJaenJaU29iY0dR?=
 =?utf-8?B?Y2JiMHJkZmRLTk9nZW9pSEdUUEp5aDVuU0JkNC9RcGJSUWJWeTVHNkdHVm1N?=
 =?utf-8?B?VlVKRUdacFRLcW5vWXo1R05vZkxHQ0l3UG1RMHJNbFBkcTQrR25VMVBEdXJa?=
 =?utf-8?B?dnNRa1MxTkVoL1gyeWRBSEppRm5FTS9GcUtDeHJuYU1HVTdxRnprNWY0eW5q?=
 =?utf-8?B?VmJYSkwyWWFNQmFVQ2swQ2JrM0c4U3hLZlQ5TzUzdzdNNG9jUlpwVFEzZkdr?=
 =?utf-8?B?bHhWaUMxZ2V3Z09jNEppZHp4dGFCMDQydGZjVlVTa2kvQ2FITXJHOGhHNHg2?=
 =?utf-8?B?bjRkdlRVVjFxOHRTa0RMc2FieGVodHBCTlJIUWJpUDFjSTlEb1ErajRvbWZw?=
 =?utf-8?B?bUdEcGhQa3lqakErRXI0ZXk4azkrMDh3YjFDY3B4czBvVS9weWduLzRLN25m?=
 =?utf-8?B?QkowSk9aenR0M0NPNmNNWVlPWkpGVXUxWllsSnprUENTeHJBVXc5SXluNlZq?=
 =?utf-8?B?ZkEwUk5qb3BNdk9aZGVCbzVQU3hhUDNlaEhGUnI2M25wMDdCZVVOVHExSndu?=
 =?utf-8?B?UXlSeEJDS2dvV2tpa1dDSWhsbWNXVVBNUmdxUEdqbytNYUhOZXVqdHp4RXE5?=
 =?utf-8?B?MTFxTXB4K1VxNkJ3UDZwODUzdGlKL2ZoQm1PbFF0WjdUN3BzZ291Q1F2OTcw?=
 =?utf-8?B?UXVjM2RRWEpOT2NBeFJrd1cwZEw2ZDRjUG1DNTdjUmFSMUpnUG8yTHUxWHd5?=
 =?utf-8?B?cWZRSm8wNWFQVFFxWkE5TVoyRk5RRzJCdkJNOE1PbTRxbnRtTGRYcS9yaWdT?=
 =?utf-8?B?QnBMeEw1dHBLc0x4MVBrUFR6WGhPa3NoQ2JqZ2s4cjBYUjByTzlTVDRTZmJO?=
 =?utf-8?Q?rofvVPN0h80=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhDc0gyN2pGN2lCNWtXWmcza1p1VUdXaG9TbjVpc3RXOEpoMjVQSnE1bzJQ?=
 =?utf-8?B?b0pDQmtOemxzUFNiMk9tVS8yNEV5VW56ZnJ5dGdhQURFdmsyaGpnVlRtUzFq?=
 =?utf-8?B?dzR6SjF3TzZaS3h5NDNueU9FeDE1QjlUMHlwMnFRd2szbndVTzh5OThtdzlC?=
 =?utf-8?B?Vk9xOVdkbDBxci85NXdnQXNJcG10Z3pSdTFjOS9HeEFzR2pUT3BSTGJleGg1?=
 =?utf-8?B?MVBVRHA5VUV1VTVYNFQwK3pwdksxMlErZGlPdWxhS1NSaDRtb2NxVndPZzI4?=
 =?utf-8?B?TlJvb3FFMk1OVkUxaDc2SHhWOWxaNjArK0NidDV6dGU3WDRjdU5CNGZjeWhm?=
 =?utf-8?B?VWlzTG5LY2VmU3gxY1kwVkh5M2hzZDZEa29Ha21RVytvajhRaGJDeTBtV3cr?=
 =?utf-8?B?Z1VYcEhsb0hoWUo5UGVwMlc1Q0lvL09BS3c4OU5vcHBYaUNRQ0ZTV01jTkRR?=
 =?utf-8?B?elpPbVdQTkhrRURWN292UTJ1QVFoenl0ak1tYjl6NERMUm5xdzRqMDdoQUlE?=
 =?utf-8?B?MEhlNXdwekQ0WTRIK21Bd3dLaUsrOGpvQzRSY3pJdUxJczU5WEk4QmtvNm5p?=
 =?utf-8?B?dFdpQzRWb1I2YWQveDFMWUJqcVpyYjVXeG5YN0xudFlJQmR3bG03eHJZSjJP?=
 =?utf-8?B?U0FXQWQ4Z0QrMHpyeUlUSUlHZm5CTXVEYzhmcnFLQmFvb0NzN2xjMDByNDUw?=
 =?utf-8?B?V2NCaXVHYVNiUmxTOUcxa1BTZ1c5WGY3bGFMNFRIMTRPcjFpNHpZc3I3MmFk?=
 =?utf-8?B?aWd2MjdhK1ptallpOTIvSFFyYTdGckVocEF1MElMYURkSUxGVGcrR0JGVkhT?=
 =?utf-8?B?Vko1VTluTGNXSVhqUXREbndWai8vRmtEamczeEdkRVhnUTlnMSsvYzVVOERv?=
 =?utf-8?B?RHN3Q3BsVWpXNFNBYUNCYllrWWVqdkJPMGgvdXZMNXZRSThiYVV2eFlaZ0hN?=
 =?utf-8?B?UHc3eGVLdFFqWFNEeWRweVU5akR0NHBGZDhpUElKSFAyT1JOdk5YQW1BeWVm?=
 =?utf-8?B?RFRMaE1HdmxwVEtSdGYweS9TQkhqVFJtbDhabjdLVE56d3dQOFhsK3N4d0JH?=
 =?utf-8?B?dVJkV01zY2NEcW1GbTdKK1pEZ1dvMDJoMVBBVXNjNXlUVC85Smg5WUhJUUIw?=
 =?utf-8?B?eERxcUFjOC80WEJEUE9BbWZuQ0trc1pBc3ZMVysvTmIvYmlWbDZSdGwwaHBh?=
 =?utf-8?B?WTJqa0lxTzUza0RyWDJKRTRGeFVDTmZnTzZZMXVWbTJFVElOZk55dWFxNHh0?=
 =?utf-8?B?dDFMZnJsVVIzM2xya1FwOUs4VGxlSSt3U0kvaFNhQi8xR1o4TElMYmthU1pz?=
 =?utf-8?B?dllkWWtJcDhwRm1ZYmFBYmdESmJlSGVGcGxNTmVjRVRyT1A2L3BQMmJjUk9r?=
 =?utf-8?B?ZzAxY09yWGZwd3hlOGs4TlVIMHMxcnZGaXNJK2xkMGtyYkJEMjBkdW5ZR1d5?=
 =?utf-8?B?VDZ0clMrdEFORzI4ejBUYmtQeWMwUXJoZktOTUY3Z2owRmM0Unp6Q0lHYVlQ?=
 =?utf-8?B?V2lMTUZqd3doMFhRbjBnbGtGNFZRV1VVdTZaYlNHV29FMi9ySFdnWjZ2dU1W?=
 =?utf-8?B?Q0VZQVhVcEZUL1QxdW1jdG9QQzB1d1FzNU5OVE1TVEFiNDBsNkVCV1RZTHpZ?=
 =?utf-8?B?cGRnbTZjc2pjMVNXNEh2dFlmdDkxNFV0VTl6K1V0WnkwK1E3UEV2K3RUaEhm?=
 =?utf-8?B?aGJyV3JucGNxbG9NaTlQZ3VRenNEOFdRUGJiK0ZGK2xoOGhxSjFhdFNqYk5V?=
 =?utf-8?B?UmlGR0d1Q2pEak9FRkN5M1UyTTRpczlSbnBFbEhpQTJSZ3pnOEhsQkd5VVF1?=
 =?utf-8?B?VzhVWDk1ZkRmZFhaZ2RlRlVwcFdZcnpTN3pROUlJTUMwRWhFeFd1c21McGI4?=
 =?utf-8?B?bWNkQlFpWGF0UEhYWG5sZHVOeWdxTFRSUGNmUzhJY016OHZmUkpKZ1pDc2g5?=
 =?utf-8?B?TVBJTTlDM2RMTVVWK1dOc0hNYnhoVG1US1JNSFcraTI5QlllaDZtdURoZmtZ?=
 =?utf-8?B?MjFRZDZsV2lxZjRQV0p5dUdxSTlkMXcyQUNYRGl3N0diVjZsTmhTSEluR1Na?=
 =?utf-8?B?VmRNQ3FEd1VhK3NYK0g5QlBFZ0xYVDVxdG1DNlNtM3NoVEhqMzU0ZDVCa0pn?=
 =?utf-8?Q?qqLJFgAHJphAcf/ZyIyHG/yRL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H9ZUyGiFkhwESCTDJTlJfKY8VllTbvz+q7N3UdczX44zQlg4WrSkSEIfNfgcLYhdCYvrTXH6p0tC6dfvarXJTkUEUIzRsMGivDJjw3WY87JmyiiqX/iqDGUKnNwdVr44VBRjUJaRHM6cVE+nU2F7p90FRgUkSB05QFbHlZ+W0GSZhQYJxgWDppXmUApsX1oz3WvTx+dqN8IDxNx95pyr5Nu8S+GleRB5AeI2sE5++7kQ0Mw2gFt01PnZFVx5k3nC+shFvlcwPA14rBLtjpbbbugNjdnB7gsLADzTPw7+UexbwciigSGcsoqNa2o9/zdVz0mSGKOrYC+WB/GNjhuAdN0+RYtofT5fR4P8aIyFSix67wxd/eSLnt/JHTGpBE9Ps+sD2/8und4JJAyFxQqt07vyAn0h+gKApg/IglXQ0vbq6Q7xLnGstxb2lvxF7SQctvimamuDDI5RCxoKWKTxjIcypOZc5SmggViTFqlj50YC7y+NFzCgscF0kQCSLruTt75VETdqgk1Qd02WwDgzO403NChAAYbpPcRwMNiyDJeNaf9JGkUCMUX7dJT66yh5w1Y1YGQpsRctLC2lKSs4xCub4TWh/r0RBpkN+rB9PhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f810c4-5430-491c-9561-08ddaa4f3401
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 07:52:11.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsOhPNhQIGNeGtDIIbOtlYdlS/zYJIwzqUXeY0Im2MKSxIsSUnk3CMtLzEKEZPAGafyQNdBGro4nF/5bYGmkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0C5EC304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130057
X-Proofpoint-ORIG-GUID: e2fcVfK07BcSDpUeS_aTDkFIs0rry68T
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684bd8af b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hwyyDsm4V8TiAVNdC1UA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA1NyBTYWx0ZWRfXyhkE9/DUMgsf EZR5CMpzymygZ2xgVeOAsOIZdviBT/PCROBPIvM6D4vWvT3xvM1RiM9yxIvnaRm91e6/2F7DjWF iJVgJ9lFeRHf690uO45O853QaDsUdS0u+H+Z5pRykLS9+lpWYTf6w19tBio4ZrTvyQpu5f6VKn1
 Xj01R/hi2R9ssfZTCPbLkVvcP3YdHiakQDwbPXHbnQ/sFxAJgm8N21PM+CsLvUCjyda/I3nyk+h Ki1Rp06lDgrmRIYWQVvMIlXGSYe3ItlnQdh5eppM6QZGlAckzgDaAMukv7Dt2VPYCJDajPmv/IO dLt4CVfMnkhEOpxejCrlktLtUT9SaeBqUEry9/VZ6+Si8RsJsOU8LZEvULsXd5FMuF2ofggInqd
 lMPjHiC8hsaWxjC7uzKNg6zr/KQdlY89ig9DFTfUt3YD9+DEJHAaRS0TFsu3KtpgTRxYAkPj
X-Proofpoint-GUID: e2fcVfK07BcSDpUeS_aTDkFIs0rry68T
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_005224_187319_9ABCA9BD 
X-CRM114-Status: GOOD (  28.35  )
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

On 11/06/2025 06:54, Christoph Hellwig wrote:
> Move all the code out of nvme_update_disk_info into the helper, and
> rename the helper to have a somewhat less clumsy name.

I suppose that the name nvme_update_atomic_write_disk_info just comes 
from extending the caller name, nvme_update_disk_info

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Regardless of a couple of nits below:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/nvme/host/core.c | 72 +++++++++++++++++++++-------------------
>   1 file changed, 38 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 724f5732786c..520fb5f1e214 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2015,21 +2015,51 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
>   }
>   
>   
> -static void nvme_update_atomic_write_disk_info(struct nvme_ns *ns,
> -			struct nvme_id_ns *id, struct queue_limits *lim,
> -			u32 bs, u32 atomic_bs)
> +static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
> +		struct nvme_id_ns *id, struct queue_limits *lim, u32 bs)
>   {
> -	unsigned int boundary = 0;
> +	u32 atomic_bs, boundary = 0;
>   
> -	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
> -		if (le16_to_cpu(id->nabspf))
> +	/*
> +	 * We do not support an offset for the atomic boundaries.
> +	 */
> +	if (id->nabo)
> +		return bs;
> +
> +	if ((id->nsfeat & NVME_NS_FEAT_ATOMICS) && id->nawupf) {
> +		/*
> +		 * Use the per-namespace atomic write unit when available.
> +		 */
> +		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
> +		if (id->nabspf)
>   			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +	} else {
> +		/*
> +		 * Use the controller wide atomic write unit.  This sucks

nit: I found the wording a bit ambiguous, as it sounds like the value in 
the controller-wide atomic write unit itself is somehow bad (which I 
assume is not the intention). How about rewording slightly:

Having to use this value sucks, as this limit is defined in terms of 
logical...

> +		 * because the limit is defined in terms of logical blocks while
> +		 * namespaces can have different formats, and because there is
> +		 * no clear language in the specification prohibiting different
> +		 * values for different controllers in the subsystem.
> +		 */
> +		atomic_bs = (1 + ns->ctrl->awupf) * bs;
> +	}
> +
> +	if (!ns->ctrl->subsys->atomic_bs) {
> +		ns->ctrl->subsys->atomic_bs = atomic_bs;
> +	} else if (ns->ctrl->subsys->atomic_bs != atomic_bs) {
> +		dev_err_ratelimited(ns->ctrl->device,
> +			"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",

nit on pre-existing code: /s/Atomic Write Size/Atomic Write Sizes/

And, again for pre-existing code, maybe stop using the camelcase



