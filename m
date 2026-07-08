Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698A8C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qbGJ4UniPiJvH+Be7+C617SREQg2yZ7YS+D64ii3lY=; b=f/R4n1z14PexB0UCCmy15H9Okl
	eY57Jc+jphpegK7WKQqu4I/HsedDCYVivGJFaMWGP795EcK/OjyVH+H3r/KGeJzx652OrjKgHEDGZ
	sEe5LYfODhuS8BCdMmYhauAq0TB/U1V+CL8JM/VV+LVmO31bm7/U1KDHpyY02lyC6/cXGlfasGb7e
	5meGktgzyg2Qqo61PqWRX6F7+0128yCWbFlCvCoE4xvifa8FvZ67jSm7cSXod1rAy4ZRPf+2O5q0/
	gwDaPrOnbsX+O521hZ9Vy4qgGFOal9XLpN5doEgA1tIriOfC7dmrd3Ts9XL0EcHoJjRGt/uWH2NIQ
	pAUEa3mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whP20-0000000GnFY-1WkE;
	Wed, 08 Jul 2026 09:57:28 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whP1u-0000000GnDv-2uEW
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 09:57:25 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667JBdWj1635043;
	Wed, 8 Jul 2026 09:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+qbGJ4UniPiJvH+Be7+C617SREQg2yZ7YS+D64ii3lY=; b=
	L9LcyCsM/cg/qmqSaNynmWHtvSr4/Ffkeh043ymgyi9yZ7IbcBBu6BqWnVYQHndv
	8MrhVHvhjB80wLLuoPzc2eYnysrSftjrAJGGGYy/+r68KZlSogHsCAREIX6entWo
	dX97OV2olqnuQ3nIkUyQ3+xQPVStMkXVFst5HLe2nk2Cpq3FHB0J/TiIFmNRq/b5
	xSt6vBvyDnA0wmQuwFDUg5WMXPf2a71MntODZ7E3ZNBsNDjYVlC+hKzcPimxQhZO
	FOCPHr1tSiUu3XVEmd7e6HxDUXPxOlWRpKBQjNzH9mMOtDEalQIV/iJHYs3JeDhP
	x8Vd5+PZrFnbTEivvslxWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6t7cqcce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 09:57:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6689r97e003211;
	Wed, 8 Jul 2026 09:57:10 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f8wuybx2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 09:57:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDIq2AacB7gI7DXAQFY6cQEq5K63v6G3BxxKADLnAHyaoNFSynDawL8gRX9Ear5StCRJyki69a9d4vomXkVK+KUk6ItdpmGEkdL/oh6GT7aNg1D/BPKNKuvXTAbWoWh1k1Ra+4IC39bXgLj6VxqUSphKoYbzLaK7cWuwkiB2U1Rs6vFppBaV+cHdSAZwWz4O8KtejPZ0MPz5wzyDx9uz0J4PCloNn8Jrjx8gEhWYq9vkYuOgPA0fzyv9ZoSgKJj4kpODBbalN3EPdkOfBpB+mEeGHWUcZwC52m5Zw/VwSJYUpgSwLPVWqCr8kGpMVo3kmsejX2PZMwpM+9w7eHXY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qbGJ4UniPiJvH+Be7+C617SREQg2yZ7YS+D64ii3lY=;
 b=J/qJ1+zbUymOfSbaoVYUev3X5Q+XbmdhpKKXIj5xvCwSTHsHAZaRWmlDLJPHwQVK/3o503EOpxnh5ug1fTf3Le/KfhgtLzuO+94N1lgjsEljfprHeRYN7jIFhMv24ecanA6ji5eMHrh2UluAx6xHNQsPsjc0JIVQD2BOyrgSgMBlZk+UrDjlrIhqG+7jQhCp6pTJpVxPMsbZxe6E8jd6E14bMWibJCpRMQvKOvgR7d0ddPm2fN0jqy2sA0gbn/BPo1GFWAND53CR912z2KzTwtNJKkNAWaqDdZS0q++vxv7/GjSl47lY0Uc2nMf3Euyer8QsmTapBqGkDLWXlltYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qbGJ4UniPiJvH+Be7+C617SREQg2yZ7YS+D64ii3lY=;
 b=ur7HF/5z9lvzPxB6VHtaFY3UfWsiDrScdpjEYL7z6wGnFMAZJ+xKY9Ik0i1rDH22cdmLE1HjzYrG94v8HsXo53r8RKA58Gj/rn0bTA6DsPZFa97vdjKSERys1lan4Yk2BbkkPpg8X8pNZSftEHwsRVX3MWhJPFkI5N2gxe6K09E=
Received: from PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11)
 by IA1PR10MB7288.namprd10.prod.outlook.com (2603:10b6:208:3fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 09:57:06 +0000
Received: from PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d]) by PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 09:57:06 +0000
Message-ID: <d27cb4a8-cf04-40ac-a271-c7d83dadc8a1@oracle.com>
Date: Wed, 8 Jul 2026 10:57:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme: fix NS head cdev lifetime
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org
References: <20260706130146.617258-1-john.g.garry@oracle.com>
 <20260708092740.GB6513@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260708092740.GB6513@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::7) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6228:EE_|IA1PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fba290-f363-44e4-e6ef-08dedcd743f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: kxRq2PRV5YhQsxgrt4QH3qaZ3OuyaM88mFAGTZ9Guy2+BphghFxeapPO0aqebEmPKnbhdqluCMvCOgbd0nzvrhP5wEAw1wooItFTtJD5CNcPI/FljtugFC0y+WJA8ObNsD3VykGm/YjMzhFW1+zX4OdJDuK2bJP2BtIPxJhLVgrvn5CqPSzIJqQ8CmiyIo1bc65CAyfOaGiq8mqELDeOGjXqriXnrUJkDkasZutYraInIrmN/z4nsolARLayGdcx3Vwfv82nmcjo/le7KBj/zXzBA5DmzMzh34wsugkJ6ZGNsXbPKml4E4qVBgbd0pQagXi+klhREUm3XSTXolLi3KtTsvRw+qSKyjpN2yDLGfiEQCO46njNKtMPw9ZRCuXvW3dcDRlTRGj+cOZW/LY+ytZ+TmXKivPRJ/LdN/oq8qFAT8LD71/QmQZ7EYediUDlRy6CjTUtCnL7iXVYT5UGTp5OyTDw8XXODC1AtEZP7d6u2c/jr7pz18tqZKryoD4v173Rh6lIeFUwxwnE6/tJsvCOREVZKzv7J4hwKNWObP0rwUy/9qkytcAYE9unokF7CqcykLadUgb5Z9MiRFWv/4BLkNCvUI10RzG1QRaTuqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmwvRW9uL1V6SG12QWRTUURDb3pUblJJL1hkYit0eWx6WWJaVy9CRGhUejFQ?=
 =?utf-8?B?ZmkyUVVMMThUcktIYi9jb0dlL2t0ckdUQjJodnA5bWN4V3daUElvVW9GZWJR?=
 =?utf-8?B?L3piSEpHSHc0eDFqYjF6Y0hWbmIrZm1tKzh0NTMvMTd2U3VDZ1Q0UzZhLzN3?=
 =?utf-8?B?cGYrUjVEUk9qS3FmcVQzTmNuNVpLRllCUis2SVdaS1FMM0QxdXZGSkRNUFFz?=
 =?utf-8?B?cXkxMWVIcUJ1UkZJWEtlbUQzaU1RSVVqTXNIUkRoMHA1eHAyQlNqYW4zTGk1?=
 =?utf-8?B?OWVINTdYQnlHdk1iLzNXaHZRUnlQUU5nS0JpdGRlWXhqRG96a2VzSncrY0dt?=
 =?utf-8?B?clpVREZrSG5rWTBjb3FSZXR3V0RpOVRxZjBBYnR4bE8wemljaXNtNDFEbTNz?=
 =?utf-8?B?SVk0YjJra3VTSTl2dFM5U0ZUV0FXTE14dmNycTkzZkpjaU9jcGdWVE9PdEVW?=
 =?utf-8?B?U3ErN2JqVlVwWjBWMGNmckpvTDl5bVBIc3RiMUY0eDEvZk42a0RNaHJlZ0dZ?=
 =?utf-8?B?TUowaERrUHdZbWw2d25RM09ia3VURVJXM2pGaElQdEMzWE91anE0ck5JODN2?=
 =?utf-8?B?aFZWb295YWdlWlVoTkpRa2dTVkdEN0ZmZUNCdUVBMysxdytsMmowd1BsRlE3?=
 =?utf-8?B?Wm9Ndm0vaDBTUzVrUzUxTTlmMHF0bWN5eEFsallVNUh3dzZvSXBUdkpFQW9R?=
 =?utf-8?B?UGptcEdqZzI4aURoR3A2Y3RyQVlXVFVIOHVNNWE4eWdJZGh1OFVxcEJLQlA1?=
 =?utf-8?B?OWtLbzZ5V0xtY0JVTDRDcTVYYjVVSHZXdU5GRDR4VWhINWM4R3lwNzAyTHBk?=
 =?utf-8?B?bStFcWwrcWVyUi9kY3E5b1RxWnRqdmJHYTlWZ3dqT3VhVExVTUt4a1JNQXN3?=
 =?utf-8?B?am5oc3BJbXBTQkEwQmZWQ2NKTVBzUHc4cDVMbGlaRG1QM3BIQ0pGMktudUU3?=
 =?utf-8?B?M2ZCVFJ6VEYvaGI5aTg3RjRiU01md2hjQzFiY24zVjJPUytmb05XQWF0NHNa?=
 =?utf-8?B?NHJWWE1samV1Ry8vWVJmbjQ5dlhSOGpoVHN5c2E3L3UyQXBTNEtqUjltZCti?=
 =?utf-8?B?Uzc0bzh0d3ZGbTZaT0VIcURmWGhvMHJkREhUMUpzS0dDclVua1RlMkJWY0o1?=
 =?utf-8?B?UXBkOFBCM1hJYWRGR0Q5Mi9EQVl6UGRIcHdvQU9JS3JyQ0dlcmoyZnlreFEz?=
 =?utf-8?B?VGtTbUFLVE5rNzhmbmM3Y1JSeEtHVEc2dlpJVGZ5b2tkWUIvdTBMMGtlSjNT?=
 =?utf-8?B?SWlTOUFmWWhWMUhTblpYM2VwZG9TV2lpS3lYRFZYSGdPNTBleFlQcVRkOXU5?=
 =?utf-8?B?NGFvNUhDbVhoMmdBWVFOeCtaNFNuNkFHQlRjUkU1eW5UM1R1L2dBYitsYzBS?=
 =?utf-8?B?T1BoZyswL1NHeW1nUk5sZWpiRzJJR2VmYUVZdy84S0p5Wlg5b3dsclJ6SkMz?=
 =?utf-8?B?UnI2c2ZVNW1jV3g4K2JTd0VycUtmVEkvQ1h5VlpTT0Q0N2RrZUZQYzAwYXVP?=
 =?utf-8?B?Y3JaamJYS3h6UXBZZ1FWUHEwSkRoekh6QTRBQU5rRTU5KzEwZnozU2tGbEpI?=
 =?utf-8?B?bzBwZjVQUDhkSW1vSEhMRXowbzNCOTRnWEg2M0tsSUVBdjJZREpmSUcyM1ZM?=
 =?utf-8?B?TmlQY0diVWVlUW95REFMQkcrcVBwdWErM1RlZjFvWElib0dnbStiNzI1UGVj?=
 =?utf-8?B?VGlpOTQyUC9aNURRWmlnMUxKdGFMbm9XVjFxRG9ncHU3UjVpalBnM3lheUxO?=
 =?utf-8?B?aFFVRG8wZzdKRW8rT1NuZ1Y5STM4ZEVycFlGN3RONHZGT210SUZ3c2FvTUE3?=
 =?utf-8?B?U0lzK04wSUs3OXJFVEdKOHFVdUIxaGFZTGdpUTY1RnFsV2NxTTJSR3h6U2cy?=
 =?utf-8?B?bXIxK3JIRnRFbmRZQVNZRndqZXhXOEUvUkNWUEd6TXRGdXJlbEVLa1hiSWR2?=
 =?utf-8?B?QlB0djA3WWp2MVgrNm9seEt6czNpWmVVWlp0R0RZakRoTkFBSWpCVUhvYm1M?=
 =?utf-8?B?MkFwTzRjaUUwTE1MWTVyWHFOMnhPaG1mSmNLazlCcGRneWxPRnZtM2pqNEZM?=
 =?utf-8?B?b2JOZmN6S0oxSVRjcnB1bTE3cGVmSFp3UzlEdFd1QUZjZzVaN2FyZ1FoMnJl?=
 =?utf-8?B?LzBBQ0xGR3RnT25haEhTOThOcjlISmVxRjRSWG5veEwxVkxJOWlySU1jTkNT?=
 =?utf-8?B?YzZ1SUY1bnVsakV1MHdjZ203SUM0ZXlMb0hmWmQycExQOGxVVDFiSy8wcC8z?=
 =?utf-8?B?enYxdndUV29uak1JYU0wd3FlUlM3cHZJYXhhc3JCSHdtY1h5K0NMT2xxMzZK?=
 =?utf-8?B?dnErcGRUWHZKenVTbHNpZXpOV2FSTmZzVThzMVpsNzJpZy9zNTNjUT09?=
X-Exchange-RoutingPolicyChecked: m/r9T9kpOH/KpCjweVIM++kdSiDvx/xfGNa4YtQLit0Z0mWDJxTMb6RfKY3gxOs5dU4sBSFPVZE521t62+bEmV/3aTv/MQPtW3KzwQrsO0WnH/6X6zY4TeMA/QCJuBylW48RH08/plqZ30GSn6ZPZN6Xaas7jZc9JfbncHD9LWrpyJ2zq+tVqvksHZQNiQmma8r+joVkxGhKju/pfsmFkSMJNBUWQ23tM/fo5Fe/ajuHN2EKQscC13+m4lBqnsSDb81AS9hWAAbTlwghmHxdnlU+zo2+A5XcGEBEPUNXAxu48VwLRBiwIpAZI3QOo5OOXtCWfWUnV/XgCFqxWVBEGw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yUw0fu4sWEgo/4FjIASQeeVsJTbpmBkYOrgsQzWf8PJ8ATKcm7Z0bts3zjT5vFnfAa9dlfox3Tr2abXyc15W0i8L+AMkgk7MoyOw5/wQ5CAJu8XGNMdtzN6X7iIBxEKMaKP0hmtm+t+T+ON8yXVX5B6TXHRklRoPVSV+HY++o55K18ZUJSClTn8vteiERe/bz84jdH6yvJzVmu0by8e86f8O6on9j53sGQzxMB1NVoCxkbsSyjcBpe6kxl4a6vdCi46ghw8+uE4NyTWwbc0Aikc+LV89REg8IrSFUhe1mZDlngOSG3C1WZok3BRRgaM2PwlC/sWmTT/YstT6zZt9/VEINNxf1n6k3JyfEd+CJZHS5yBklhhrTDy+Lg+42FVUBhFALrMkOahsMsvOV2aLn+VFNOK36Gx66o1ummOIYJY4h/eu6790Lfk1DZZaQQ0wuTJmPgJudAqWFyB7kO+na6DJNJxBIb10s8Cb/hkz+a6qXxFOzhaql/9pvL+R78zGo0WWk9SCJwL31rdW8qS0OUk2R45lZ4uPCkTICVM0j3JkCRmDlFm2HBxOtoE2G6UcktYT6Sd84SiNPKOt1GsgBNh1Ynw44K+lXHUsfWGWurI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fba290-f363-44e4-e6ef-08dedcd743f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:57:06.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P67dj5dcFynwy8LbznPHMmo6t3nZvXhOB6khJHQWeXaperA6jHJSvciQut7ZP258rWcUruPsQirziNSeLCpK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607080095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfX6FBq1TWbuQqv
 3TbIcbUM4AFDgOeOhMCAm53sLdUB6hMu0FkXy19droN0DyeZfvgTpzSiOdTi65CVesU2x+8dKKD
 /pGd/2JFZ8YUNEKokyQ3Vj1JQzsd7bcvSoFTRnYuwi6Evta/qlbP6D4bxhJRdvxMskOACGwq8qF
 LLlztrl1SI3PgpiWGgpPchJ/EZRYj/S+kCLGALPtQXW2N9wPwgeHhPCbK9NQL0Q37ZfhYRUZ4+/
 YzY4yX1zVEsM8K+gVcBsFc43rwo/y9xq/McemVooRy5TvuV7SDzHgSI2nx7CaDWnrsBrnyYFzM4
 NiNTpr3IX49si8o6Lf2bLC3uu034SDAZ4ivrexxfsNBhjXhkhymrwefJG4k1pjQ+0ODipx/R0ys
 BjsuZKH4PWWZoQ2Fbc+0tOMaWkbUxLFjsLpo9dDGHnFFXtzBrA6KRnk4QW0XvFym0Kiwlc6yGOq
 EAQgQNnVOtUKbN+O7yA==
X-Authority-Analysis: v=2.4 cv=P+QKQCAu c=1 sm=1 tr=0 ts=6a4e1ef7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=ebLrI8q0IFon3RwC55QA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: dKsaWEUOR9lo6a0LW83imMIRjHPyRCN_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfX56aG2WgG7I+a
 4/VkCY6468tfzbEMchsIGMp9qmSiXuVQJnkvHrUTDlAgW9jmQsRojqr4g5WLT/jp6RkjYBlxlb4
 rZzPxbjafXpBoCyG+Poe5sHXGO51xYCa5ljxh1uP8C8/ktoSE7+P
X-Proofpoint-ORIG-GUID: dKsaWEUOR9lo6a0LW83imMIRjHPyRCN_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_025723_177354_E4D64493 
X-CRM114-Status: GOOD (  27.98  )
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

On 08/07/2026 10:27, Christoph Hellwig wrote:

note: subject should be nvme-multipath for all of these. I'll repost 
(with subject fixed) if anyone cares that much.

> On Mon, Jul 06, 2026 at 01:01:46PM +0000, John Garry wrote:
>> Sashiko bot reported a potential problem for the NS head cdev lifetime in
>> the libmultipath refactoring in [0].
>>
>> Currently the NS head .open and .release file_operations methods take a
>> reference to the nvme_ns_head to ensure that this structure does not
>> disappear while we have files open.
>>
>> When we teardown the NS head, we call nvme_cdev_del() -> cdev_device_del()
>> -> cdev_del(). However after cdev_del() returns, cdevs already open will
>> remain and their fops will still be callable. As such, we can still
>> reference the cdev after the nvme_ns_head reference count drops to 0 (and
>> is freed).
>>
>> This can be shown with an application which delays between opening the cdev
>> and issuing the ioctl while the NS head is being torn down:
> 
> Can you wire this up to blktests?

Sure, but I think that we need KASAN to detect

> 
>> When all fds for the cdev disappear, the cdev removal path puts a
>> reference to the parent object, which is the nvme_ns_head.cdev_device - see
>> cdev_default_release() -> kobject_put(parent). We can use the lifetime
>> of the cdev_device to resolve this lifetime issue.
>>
>> Fix the lifetime for the cdev by making adding the cdev add take a
>> reference to the NS head and drop that reference in the
>> nvme_ns_head.cdev_device release function.
>>
>> [0] https://urldefense.com/v3/__https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/*m67265e2906d617acd2743c0a00809246d0cfc506__;Iw!!ACWV5N9M2RV99hQ!LwK_OTvYSZQLpG5Nv_1ODqf95BdDoh-lkhsgbnFpKEnWh0bva-VU-DZdOOWPX5UR3G978T5cOhj61A$
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>> Setting as RFC as I am not sure if this is the best solution.
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 453c1f0b2dd09..c7578b7ed6b76 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3887,7 +3887,7 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
>>   	return 0;
>>   }
>>   
>> -static void nvme_cdev_rel(struct device *dev)
>> +void nvme_cdev_rel(struct device *dev)
>>   {
>>   	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
>>   }
> 
> Can we unify this and the ns_head version by checking of which type
> the device is somehow?  I think driver_data would still be free to
> optionally point to the ns_head for eexample.

If we put the nvne_ns_head (vs nvme_ns) in the driver data, then I can't 
see a check to know is the driver data points to a nvne_ns_head or 
nvme_ns. Unless we keep NULL for one, but that is not so nice.

Other options could be to
a. check the dev parent
b. put cdev fops in driver data, that's not as nice and we also need to 
make the NS and NS HEAD fops public

I'll figure something out..

>    
>> +	if (nvme_tryget_ns_head(head)) {
>> +		if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
>> +			&nvme_ns_head_chr_fops, THIS_MODULE,
>> +			nvme_cdev_ns_head_rel)) {
> 
> Messed up indenttation here as continuations in an conditional/loop
> should not be indented the ssame way as the body.

sure

> 
> This could be merged a bit anywya:
> 
> 	if (nvme_tryget_ns_head(head) &&
> 	    nvme_cdev_add(name, &head->cdev, &head->cdev_device,
> 			&nvme_ns_head_chr_fops, THIS_MODULE)) {
> 		dev_err(disk_to_dev(head->disk),
> 			"Unable to create the %s device\n", name);
> 		nvme_put_ns_head(head);
> 		return;
> 	}
> 
> but shouldn't we warn for the nvme_tryget_ns_head failure as well?
> Or can that even happen here?
> 
It should not happen as we have a pointer to nvme_ns_head. If the 
recount was zero and we referenced ns_head, then we have bigger problems.

