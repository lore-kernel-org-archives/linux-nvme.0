Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE7C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I2wo/qi+OVLPRNHaDeK+2IQc+ScL9p+wtulTRWc+lXQ=; b=a8n3MI+Wf83Q8O0tZ4WauS6upq
	+O/EdA9Sk+L7zQbUTo2xjQ2Mj3EcQhIYcrA6S4FkLOVH5YS+r+775e3b6qfw3l6RCT4rVyBOLF1BL
	Lwxl0v7imItipRiO5DFKfCFdhGrYffm8GAsi6ckyWRJZ76gOoODHXgqRVsLUdKHczV6YhLdE/pltZ
	RvAdOZVsCEWZfpXPb4tjdB6pzj5FgUf1KF6R4F9DgMripiqF8R/xpAJFsYPpUsAgKcOAJB9p4BxQn
	Gxy0S+tzQzyyI3eD4zeyEI5ajc2qEJIXdirC4BuHJjUu6Kn/tffbvw4ekAwHJVRTlJT8DyRyJTxHR
	3GovxVCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmg8-0000000BTeF-29h5;
	Wed, 07 Feb 2024 18:29:48 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmg5-0000000BTdT-2rzQ
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:29:47 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417IIwkm003848;
	Wed, 7 Feb 2024 18:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I2wo/qi+OVLPRNHaDeK+2IQc+ScL9p+wtulTRWc+lXQ=;
 b=eYOV3ioyjhQ27QJdUO19fvSYJZK/rF+qCDcDGLOQq2bSC0BMP00UK7AjCboXarjIookA
 2dcCb5Jqn1uwFjoBfwX+Li3ww1QPk3biQLaWE+/twfkFgdtcJiaaPLdfFTrBuh/v76kb
 tvyzMGn/F89EnkSuBQNJD/GW/wKW7uNUFSvzMCZISkaBfSMG0Pck/sebz/BhcO1xlR0E
 YiVYoRa5AN7iAylheV8UD/EvDSkmCHm5L2kKmfI2EjDOm3LwprMtV9qyCYkJFJvR0Pcx
 D0xI2rfbJbMOW81W2y8lDNxZQIf0nTH6UuYFMOIx9U9Z7BprPH9m/v1aJH94Tf5XnA1Q Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ujkd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 18:29:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417HjvYR036711;
	Wed, 7 Feb 2024 18:29:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9f5d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 18:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApkTnImQhtydkRevgQvOqNi+SPWlScPIJ3d+xjYbNs+mowknyydi0PSciEc45PdDuC6drf++XDyIQJNGjp99URQkDIbHffPMSffwlsNtVSGgYpw36QSJBS0txp2RBAhOxuKCrC3ynl480UYiLQKxfPd6+0PgL7Ew1jIwXKFdfkUcMqMYM2TqzQtL4uQnTI3uWeObzvuhQ9WXyIQ8eSEf4+3UgRcbPhEtLakTslrRDhQg3FY+FXijZz4mokitAII5XiR2Rg3j0YE53F9pJTO2fzkihb4AE+TT1c5gD83Mz4w8BhBG8pb4dKsGytR04jCuKx2YjtrCnVnzIrCi2cfoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2wo/qi+OVLPRNHaDeK+2IQc+ScL9p+wtulTRWc+lXQ=;
 b=oUHY+r79644sE/6V6cOu7qK0WlTdDKY4j3jjXM/ph6+s21dbJmk4wJOarhdnv3e0MfSnTS1LrU9GDDEoa2Rxuz4j3yCK13msXpo3P6HXRfW/aD9BB8zqSL09q2K71FKG3lCpb2L8Tk25y+ElNBWHjFSllhqzYaHkiKooyncXQshdhbgBFONAE3sF9RT1uTJDM//p4ls7hilflcGOl2xWsfBXjCk1FL9glBJnQoqKLczEgT/oAyRTmNcvqTTnJFvhxdV74Ft0JFGm+K8WsQrLjkb5r0vqVbRUlgi65d0R4Tvw6+1AfPTWeD1hTfDsQknpYAscR6R7piH1X5nzkTdaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2wo/qi+OVLPRNHaDeK+2IQc+ScL9p+wtulTRWc+lXQ=;
 b=qen2kl8O44+jTO4H7Lnvkg0peH9HWVy28erLY3KUAzO+O1FYmIVTYZAOoK35V4NTdC+41btuaMcXIGMWVlseT432VqBXeCi5DRSGBnSVJz/IzqjLM+athvmCaMZh1OlWOxnJHPj3j917C2g05DSHpHBohZhA1S/6276U40zDUvM=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 18:28:21 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 18:28:21 +0000
Message-ID: <11e49673-d25b-4677-925d-ca6f8ca39fd4@oracle.com>
Date: Wed, 7 Feb 2024 10:28:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move passthrough logging attribute to head
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
References: <20240206175040.553999-1-kbusch@meta.com>
From: alan.adamson@oracle.com
In-Reply-To: <20240206175040.553999-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::15) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: b613b509-fe52-40b8-5023-08dc280a8fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGF3jRHiPGcHjkLmwDY1lvdV0GUhgmPy8ZNZVdblgUv0CDFxJw10BVzMK5UgiaT28s8T4KkI0+C5HX2MyJhWBtspoMZhLXK11+Ah6GBNVz43rRLLfS01jl4HsmuseknYMgg3S2bN49s4+2rqpX7NUU3r57wWnB1EzOUfuIQWOzjnIOTrWTFrRBf6P6c9ndlYR0exmRu2/fa+84YXmxy/08pTlRUZE90EDtfWVTTmnKmEjvDS5spvBi8re5cvMYTAy/U1ByN/t22m7UH5ACa+YhzCDkjEbMXbvWMz+oaFtn/sGrBOioZhubqKjkmPKz3CQbZHxm83EQ0TD2gNMVVFqLutiMwmuv9pdX21SOAftGvJkrSubMD42IKyxNYSXM3G+f3zI62bbVQBbfpHpGzkfyjOo+oUBC4uU5lJFA47ZDD3NgkNRKc7m/HQcjoIcLY5/+nWFLD6NXSmToUsmoieyvX7XZq0kA8uW1Ttz0aa5GTNjR1RUQjIt6QpShxTiNQ2kDO+vNsA7GGFDhDbvLcV3tWgBjVkDYdQX/9XPHbjZ5m3ZvQgANv5pqVaUhI8vyx4ygWeu3cfp0xb71pCzYfRsmGI4pscNgSvjIrkI4OPZC/v9NmWTfct/Rz2HHtkXui2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(2616005)(316002)(86362001)(26005)(4744005)(5660300002)(2906002)(478600001)(6486002)(66946007)(66476007)(66556008)(54906003)(8676002)(8936002)(4326008)(36756003)(6512007)(9686003)(53546011)(6506007)(38100700002)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3p4T2tjOUtPOEZPeCtTTjhrY0xyUHFiVVdVSU1BRmxhT2xSUVlVUkJ6Y2Rs?=
 =?utf-8?B?TjQvajBXdHVna3lQdnZjSWNDNVVBV0NxL0c5dzdJVlFJMWEwaUhRejRKUGtz?=
 =?utf-8?B?enk0U1k1R201ZnBKOTlpcFhEdUIwQnR5SUNDTnNORjBWbHFieUJVdU10WG5j?=
 =?utf-8?B?ZVEraGtMNG5RTzNrUEJjc3RxUzl5WER6U21TWW8rbmx4OEZQcnNKWmRlbnpL?=
 =?utf-8?B?T3BLTUV6R0tiVTZuYS9QSTc0TXQvdmsxNVQvbGRLVUsyTWszTzA3RG9ya21K?=
 =?utf-8?B?Q0RZNHFRTkdWdWEzQVlTR1YwbEdyZ0I0NHJraXQ0UW9VbmxoVHNrTDFVUVFa?=
 =?utf-8?B?djkvSEpsMEJJUXhkSUcxS09qR1p2bWNyVnBreWczdTBKSFl6eEg0MERVQk5Q?=
 =?utf-8?B?NVRwbFdHSDAyS3BmL0dTbHZISHladTR5RDgzYlJSRTBCbjdBQnk1eGV5MjFm?=
 =?utf-8?B?ZHZVSHo2OUg2RnFLZmdYN1BweWRBTUFtcnRHY1VhVTEzQitjb0tHM1VYbjdh?=
 =?utf-8?B?anpTdHF0dGJZdlFTK1FZcXZhZi9nai9qQkZjb1d6MHI5ZVhvQnFna21oQU44?=
 =?utf-8?B?T0VGNEZWeWNpV1VFK1pUeUpXMVVRVkNRYTBlYWlLc1JhUWhrOTNXSUQvSStQ?=
 =?utf-8?B?Z1RHRjk0a1V5bncwSHVQZGZsTk1OVUFsRG9XVFhiODBKcC9QVlJXNy9oeDNq?=
 =?utf-8?B?alpEc2FKQTJoZWxqRVlCdmdXMTdOaVJvZ3RYMjVnSFl6RnNIKzhjOFVzUnQv?=
 =?utf-8?B?bTFMWkxGc1dKNy91OWNVNWk5T2pwbDBwL1VOVXN4NDJjd0I2NkdJajVuVjNK?=
 =?utf-8?B?WlpPRmxUSnhhVGorVURsVVpObDlPNnJrWjNtWUpIZ0cwa2VOLzlZYStIM3Rl?=
 =?utf-8?B?ZytvcXg2U1F3ZmM5MW0rcXZBTGtYUVA5V3NSQkNNLzRtbVF0STk0dk5Hank1?=
 =?utf-8?B?UnozTWpxc2tCZFlwYkRQRVNtbHJzMWtUNzN1UHBXdjdOTi9nYURTa3hWL2FQ?=
 =?utf-8?B?ajR2R1p5ZEQ3U0FuT1RlNGh0YytEMU5JTVRLZGt4ajFsaC9mTzJNNEZ3WU9L?=
 =?utf-8?B?R3RXYkg4Y1BNWUxjRzRkNHNOZ3lCc2pva0ZRWHU5L1JxZThCN3ZKOHNmMXZB?=
 =?utf-8?B?VG0xUTdVNDVkS3F0bnQ0YXVqVnQzajF5SXhMYzBXSDkvdEtIUWN6VzRuUEtx?=
 =?utf-8?B?ZDRDUjBNdzU4enc4N1d2NFloZ3RFRk9Ib2hzU1BHdm15ZkdXRjFVYWJleU9o?=
 =?utf-8?B?dkJ3SWNNSXE5bEtiNzEweUhvazRaeU5zRXVFc0xyOENhNDdCNjdCaE94RzZY?=
 =?utf-8?B?bk1YQmNWdmpLd3psZ1IrbThFbTAyMUo1Q3J6K2pvRUE0a0xqdkxNMEhDdEcy?=
 =?utf-8?B?SFArUjZtcXVZaG5jalFZTDlCMG01ZmwvMVhvSEw1TlVQYXovS1pSelNnZ3VB?=
 =?utf-8?B?Tkx3c1RqODBqOGJ4MGlBN3h5TWJPZ2ZBNmtiTE8xcm9MeTFhdGlGcHdRVEc5?=
 =?utf-8?B?dVNjSk00bzd4UXdEcGFrb0NDcEZJOThQL0tXaEdwRFJvN3lic1RsNytvSm9J?=
 =?utf-8?B?c0lpWmpuM2tIeUE2MmtpRFhZbEIvd0EzTENXOTEwRWtzcDJiTmk0V08rbFhr?=
 =?utf-8?B?YTJTaEUxUkw5OURVNzJCcStUQlA3cXk4UU8yWk5BNEFkRUJxZTE5SlE1U0cy?=
 =?utf-8?B?ZG1mWkdyUnBnL0t2QSt2cGZwYnorV1hES0NGVHJDb3loZHRCSTgyQktlVTF6?=
 =?utf-8?B?VWJNZ0h6RXNKekhPN3h1VlZFVXFkMFc1WEM1MGNZKzRON1d5bkVqWDBObDdn?=
 =?utf-8?B?RFpvTDFpRVZ1SCtpendXWmUrajRkOVVuS3JuR3AyeFNQYWxCR1J0SDVHYW5p?=
 =?utf-8?B?M2J5d2VYanVibmF6dzducEJMbjFCa1Vndi9RSEFFLzdBZkpMNGkrRUdNcndN?=
 =?utf-8?B?T3hNVkNDWlNZZ2h4SndHRlpwMHV6dGxVZllFSVZNeGlFaEhsV3g3UHVLSlpQ?=
 =?utf-8?B?THozSVN1eGRONmV0WDN5TnZPNHpJNlBBQjhEZFJuTnFIYXpxQWlSNUU4dm1C?=
 =?utf-8?B?c3B3WXVVZUpUZTZoNjZ0bmw4VytZc3lTS0JJMm9ZUm45ZSt0MEI4aEdTNEpD?=
 =?utf-8?Q?dmOfw2oS77pSoW5T5NCbRjHAL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xKlzE9ALo29fA8KgDam9U1FoCqlvO3wYKEmHAHcU6BzEtw2fdEyQHQMJtPf/qY2MvvnqL1mVRGprOLN3t/QUNmIu17MSEwXeFLLqH9lfzgsc8jxhvpJaOB5+jnuZ2rMsA7RIcP9wx7nIFHKZI2Y7PCnfk2XwjrFjTP6Tu+KhrxWKSrhYTTf8dbF+otm7VOmT0pcK8B5QY0lpEl3ITzjatZW9OEESsOuJmd1Spd6AzhFHk2LPRULOSrMJMcoUY5aoDKRBDyaSwngFy8ruPUgKC1B2SbszrubATS1cCG6vKPWzi9mRJzvc8vf7XBaboWCqFPyEmvlWSLJdZ0QZpiksPcaBcKUFOpD8bMzec+sJvzO+fwfH1RuzcvqCzW1Eb+nME0G0jGnX0Tus0toog3GwBY+My1r/GqH1evJNA5KSvIPCuLkAIj6MuUOvXiTnaxTHoDsSc0oTXTAr2V7PO6lUHhj8hSKIYC51oGl5w4cWM7ov+7QrXRiEr69shEg/G7VfWdI6U4cPYKgQzVj0yNK67ubKHP0A+nCKJsRth7lSZh3KFdpZKRSCVXEDkWBfhGnjMnKnp9to+T4nmAlkSE5F3IIs78KAEpzR6UD3DO/t75E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b613b509-fe52-40b8-5023-08dc280a8fe8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 18:28:21.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B63JoBm1ri8vLvTUYUCOtXA1Okv/tfV+Li9hKmHomghtNrOXvZosc/6PdMyzp17johvSsj4MaANXh4f46ZkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070137
X-Proofpoint-ORIG-GUID: 1Y6Phd058sNm7-9fIQZyJf7ojZJFlODj
X-Proofpoint-GUID: 1Y6Phd058sNm7-9fIQZyJf7ojZJFlODj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_102945_873574_16B697AF 
X-CRM114-Status: GOOD (  12.69  )
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


On 2/6/24 9:50 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> The namespace does not have attributes, but the head does. Move the new
> attribute to that structure instead of dereferncing the wrong type.
>
> And while we're here, fix the reverse-tree coding style.
>
> Fixes: 9f079dda14339e ("nvme: allow passthru cmd error logging")
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

I tested it with blktest tests I'm putting together for passthrough errors.

Alan


