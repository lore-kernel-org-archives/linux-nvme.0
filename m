Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743C3CD6E55
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZwWrNC2kbSqyltvo4IctuL+RC9xekSmzW9GS5kWWoc=; b=JQVsRwqlXx2Nkwh/sovsGOkMFZ
	bRav248DRzMEPfqoIfpJw0wY1jDz7Lc1LOEttuuKDXcFT6AhwurSEBSkmURwJpaY8636M6pHvCo9r
	/gc3n+i68Gj7A8egQTgm17rkRcnG/BObN/J+mcX+OShdVfwtqbxPiOkhgERNwAlQOXvVCEvuPpYQR
	bA4SuUspc77UH52MSxr+pms1ZcVtAQUVEVtlEUXESL5mRClD08FNQDz9s0JtBRSW4j8PpEvYfFVXx
	R0+S+fq9pgLpSM35RJby2EkIhbliNIp+Ob20x8DKD1BC5iX7JGWXejnsB5a2y4HlP+s23w1CYkaYa
	pPKqGQ5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4Wh-0000000BNMK-1aTh;
	Mon, 01 Jun 2026 15:26:03 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4Wd-0000000BNLk-0zcQ
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 15:26:01 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Eu94j915454;
	Mon, 1 Jun 2026 15:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iZwWrNC2kbSqyltvo4IctuL+RC9xekSmzW9GS5kWWoc=; b=
	mdqbTuNx3kkmO4Msfuae9dOw1UwhHzsfoNmmZkL9lbql3m61YKy1zSYMD0wZsviI
	saePKB2TEL4lmpxtYs5xXTRy4yD8yDhLnCTQXWAfcpNoMqn0AAvCaemwEOnHA02V
	67XC7kkvqLXE4RoPTdqNK9yV4m3npZ2Fa+b05DvU3CF7ugebmJTmB/w3FN6xP1FG
	ZcAes1V2HQH3zZk4ZpmaOr8GfX9Ej06kJC7FCyM2VNG9IQUHsN4+nfaSj/JN4gn9
	zh3wVk1cZvGQDBhhZdC03sLROtIW+nszKz6IodMtv8opOyf5NbpDsQxSW3ObKmyQ
	di/fytDz+jHfQlzBpwsUkA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpp1tf1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 15:25:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 651FOvID022374;
	Mon, 1 Jun 2026 15:25:32 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbbkfwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 15:25:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGkri+a4747Ea8rBL2fupyTJqkPghqpeOvvVqjvfypp0McVKmX5LQxjo8aFgFGWJHXE4h7rPHPqWx843SYJNL/Fp8HZQYw42bcgroDwb4BhEIfrMuo43HqlApW45j/9Djxs1VzcOTsNGH4K2+23ETQO9468vRjvBT2lP+VbGx/01ffGFL/UDJG4MKF6nJu5kesmIuzDuNg9dgT5cw0DGZvZJwng9ee1rbVD94LR3qx3cTzeikG5E4OOr23u89NMyE+YhuPSTyMA1TV/vUqm+gLWZE6sEhzTEfZmsaDuDQS3B+bl3Yni7YDr8oih748YcbowToiPSqJ1F5gO2YJGZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZwWrNC2kbSqyltvo4IctuL+RC9xekSmzW9GS5kWWoc=;
 b=yjky5FPhPbduMvFtF2hjOJBeMFN8sOGv5E0i3lICr396o00FkLVAfK4KIPjKZIfu2epaASLkRGcQLkk/AYj+Dgrqr9P9Jsv4sR5hVfcT4APIb0q7pzZpR/UnjJ7yPQDKavGjmANb8H1G3uV7wQC2nmAtxzjSZiqa7L7QjicBzv0tekfecV1bSLCdoecineC9AL1YprUQLxMQ8pc1eXmRyZFfiiyuRuT5Nkrg/4FMIHLS3Mn6i9t7D7hMZTxeg7cdHTXox1yh29IgvwD44T2N2b+7iss6iUpSRpzdrsDUciHvWHkXYHO01C1vzfPzmzJiZBeDya0Fn76Paayw4fyb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZwWrNC2kbSqyltvo4IctuL+RC9xekSmzW9GS5kWWoc=;
 b=ogpI/JS4op7/gxhr1D72OfulckCzo725wCDqPDv5EXYCR7jWTh9dW73v7F4dbSFvQrjMTHw66EUOvKly0RpQcwq2iCKOCzWk7duKo27N8DNBWYArlQ6R3r8JHp09Z6glncye0hRcd6O/ggEexkeZunPRJ0gDhTNWHpkIaV4B2yM=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA6PR10MB8064.namprd10.prod.outlook.com
 (2603:10b6:806:43c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 15:25:30 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 15:25:29 +0000
Message-ID: <7d15da62-74a7-4ebc-b4b7-9415318a6f02@oracle.com>
Date: Mon, 1 Jun 2026 16:25:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: require exact iopolicy names for module
 parameter
To: dayou5941@163.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, liyouhong <liyouhong@kylinos.cn>
References: <20260529085143.2016914-1-dayou5941@163.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260529085143.2016914-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0467.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::22) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA6PR10MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 217e6e75-241b-4603-752a-08debff20386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: gSeOhoAYUVkbEH3B9ucRbhIBHvvldC/fpi2CCCuf3+rw6i9C1tx1CW8T2XSn3NEuThFbXK72a/Ol3zT9mDPEb6i20Y23ASQwE47zCiIhFzIEXx730l0we2Hg1+FUk4ITew0q7MnWjBd8GkBA+KobfpyJ2BePOKdTfr4FfDwrmi1N500dTqs9Crhfpi0bXF+drezsIC3sI1JwE6Av0MfKm09om8ommnCaKZJjUaji5qNC6WM3qKgJ6Wksj848BB9F6pj/WMiwheqeV6t9lzb3cbqVZEDmU5Okc9QbiCoAkHh6tqALC8Uo1d/S9UOz0xnbtb9rGt9UGsg8BX317dwk/ZsfieLoZjHtIj534eTyso5Z14jHlifQtlu3epE/hOFxdjeYknE//QE7aIyr6SjHLLSaoZ5ekxkDNrW78D0XfSdAsM+lW7oeNXJOYCqpMMvkOT0MrOimDG4IqQdCemSZVitF7ys1ROfEtKH8e1dMATj1zVK/SzeCKsV37SwPoAKnea7hZMX5c5RpINpu8vAlC8xMKJgeUFaGzRmiujhSFY+wbNweymeqPNpNOS3wySSBr5sdjnw9unXCUEj+11ccKMHnkM7PN6aGWKpTXbqm0McfHc8BecVQSrvUydawhOMiS+M6BRjFwA8DCWOxChvb5lq9dBgzC3RpjhHY6CyYS6LxTSsgE4njiwtIUTb4lRMe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05rT2gyZVhKTVRVZmt5WHBKbjN6cWUzOG1zcy84bVYwTWtzaStpbW1kMUxL?=
 =?utf-8?B?UEI5NTlKS3dsc3lneHkzN0ViRFhBTVJWZ0g4cTFuZWFrNlRsbXNjNU9VZ0FW?=
 =?utf-8?B?dHFxYmZWTUJVajJyMEVEczM1cW5NLzdaQ3JKSDk3RzhaU2VUOC9hUFh1dEd1?=
 =?utf-8?B?c0FLaTB5SjlsNGZwNytkNGppaEJjaGluUmdLeTUwaGhFcHV4VVYyckJjbDNi?=
 =?utf-8?B?VDNaMHVvRHpXZndyRG9VV0ptZnB6VlpaRHZ5MktTUHZhUDVIU0hCM1dZL1Jp?=
 =?utf-8?B?UG9HWmw4MWVIY1VXdkNNdlF1SzB4VTZFaEtWNDN3UXp6TEkrUjBVNG96Z0M1?=
 =?utf-8?B?b1dyTVlTWkdTWTlHcXJhWUNpdUFLNDE2Witzbm5HM3hmRFV0YWhyTWFleE1V?=
 =?utf-8?B?VTgwaGNYMkIwUGpyUjhhTDZleVNPbUljd2lkVkRYakNGVSsrakZJRnhBOXA2?=
 =?utf-8?B?SncyRGF5c1dPanRwU1h3RFdCaTRDNktvbi9Qc3R6SjIrcTRialNSSGpRaHVy?=
 =?utf-8?B?bjVjdGJ2UzVLQkRJUVY3QWwwUnZQSXAxa29VSE9RQ2w3bmt2bnk0VGFxekFi?=
 =?utf-8?B?ZW5QcFdYczh6Z1dXU09CSkYzWkdENHBHWHBsLzhEYW5oQjdublhjVElsVUxG?=
 =?utf-8?B?eXh4N3Bjemp1VDNjVGR4MFRMaTQyQ3lEeGt4WFN4MThYR2dmMHZGcWJ2cXlw?=
 =?utf-8?B?YXM0NzJ5M2RNL3BJZFRxL1pNNEJoYlJIOEpWekhGdVluZGMwcVYwWXkzVEpO?=
 =?utf-8?B?UGhCdVd0d09ZV1k0OTFvaEFRNTBnQndwdHY1cDVKVTJPaE9nRCtjREtJMVFi?=
 =?utf-8?B?NFo1a285c050MkRxcjFyVW5oU3BPWE40RUZuRUtPOHRiTmlrYUY2aVRudUFa?=
 =?utf-8?B?ZzIwb25EUDVyY0xvaFY4ZUswZ0wyRkdDOHVNNHJFS1QxL2lCdE16ZENuVjFO?=
 =?utf-8?B?VXNsUUhSSTBSL00vM2srdkdaT2hLRTlkdkRBemNuSFQxaWlWTzVYNnVmK3dB?=
 =?utf-8?B?eWdRbEliSDgzVVJLVzFJcFd3aUt5UXdaT0N2cVA2S2lzVjRnSENpL05NTTNS?=
 =?utf-8?B?WWZCWHhQQitheFpySVgydTduVUlOOUY1bE9NTU92N0tRYm82WWlnaS9GOFBw?=
 =?utf-8?B?R1RWNEhxeG42OVc4MHoxTE1taENHZ1lZUnFsZEVyMFZ2c3hZb1N5dWhPNDFZ?=
 =?utf-8?B?MVhseGFienRGWkc3RUJvQk9panl6WGtRdVVSZnpLa1JCVUgwZWx5TFNESVhR?=
 =?utf-8?B?eG5uMEh6cm5xZUk1WktveG1hVTQ1Q2R6VG9mblREdVZIaXI5TkNodVJaaGRl?=
 =?utf-8?B?TlFIeDNXclpqWE5wSWhwY1Raem5nMFp6RVRLUVNHelFwR1JxK2gyejhJek54?=
 =?utf-8?B?Vkk1SXJ1SkdGeEVRYlV3WWZHbFlPNW4xSFE5U0xzdVRXZXkyazVJRWVPMW0v?=
 =?utf-8?B?dFYrMlJDdHc4TGQ5NjVuN2lPbmNaZEpaQWp0UlNrOVBzVE5VdnljWWp2M1JM?=
 =?utf-8?B?allnSmdXYitmV0NJbjJaczhtbkJnbVA0N3FSU25rRVljYzBKa2hYYUlHWisx?=
 =?utf-8?B?TThieGRickQ2bzBsdDd4MlFJNk1lVjQ4c2JCVmxlQU9lZFM4cjNkZDVnZE1H?=
 =?utf-8?B?UkQ0d3lNSm5oSWQ2WitySTZkT2sxWFNJcytTei8waGxid3NjOFYzMzZRUEpC?=
 =?utf-8?B?elYzRi9yamVmd01Lbms5VXk2N1VkVGJZNS8xVjZxU3pxWTRtSGVEODRrZWI3?=
 =?utf-8?B?YlNpbElNYXpQeDJ5TlhodGx5UUNvTVErSDlHVkM3TWc1RnJkVDB1SGpjbVBx?=
 =?utf-8?B?SlMzRTJzbUk3amx1VFFtVmJhN2IrNFBlS3NUK2hxY095dWViVU5yUEFiTFIy?=
 =?utf-8?B?TWM5YzI2VC9LeHlkR1lVWDA0K1hLdFIyVEc5bzVLU0hDSmVaS09qZGRuSWh0?=
 =?utf-8?B?dFp4bFdiU1VlVFBwN1JQZitSazh1WmNmRXVJWWRmZTRKM2ZnM1FmeDFjczU4?=
 =?utf-8?B?Q0lsd1I2YWl1cVVSTnVWWmJpVWFycVkzNmVYUkJrUXpZNTY5UmlRQ1dSaGFw?=
 =?utf-8?B?U3B2SjRSbGFWdkJIQlJObUlLVWd3NEhPRG9yQWJ1K2htYTFLcG9DRWltMHlB?=
 =?utf-8?B?ZU8wTTg4NENKNGNjenJReU1jenRQSTF3djR1MGJFYzFHeWdlS3hrV1Q3Z05k?=
 =?utf-8?B?dENsbmZYZ1ZKa21MN1VmMEh5N2Z6TUlvTHpjanNZaVBFdWIyN2MzMlEwNExi?=
 =?utf-8?B?bXdIcDJLZ3QxSXlpK3N5VmFIQW13cGxXbytOdEZXSWhXK3BsU0N2OFEwcWlK?=
 =?utf-8?B?aDJoTUtISnFCc1g0bTl6Wm5CeXdrczdKWFBUWDE5bVNyMkgrS2drYnh5R3Uw?=
 =?utf-8?Q?0jS4s3I8eirTI0Cg=3D?=
X-Exchange-RoutingPolicyChecked: sQTB0xkvvwIZf1sBnb7SJxqsEL82fAUtXm9uRVbbecwzgj4I/8MVPnpnY7bnsS/4wGNZ6/Nt4BFzJL09LPOpqkecUvmGf6gXIw53LPJ6hFFbgF4c3dFnkAYCns43OPYLKjCymBpjDYgKPDlGRPjW3C/O1wjoWvQQ11nhHxcGv47fU8YrG9ZlNfEkIeJusOar7adjCeLtGep0R7XfRx7B7elbeUGky1ncq+hTrbvfbVqdXNneC3lM9NMoCBb/LGpNQ+9Ps1nzsjvVdQCpySXqr4oyWpWOtBf5n49+S9wLOclbrp/VhWk2t24qXx2PUkjkQPhy+mUFuXIyyqbwWmZHww==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QF0kPFEb6GbMHzeD+lHfr4iys55lGu1NaRWJEa/akuJqBhyoVHvWKcDA5JNMtXT7FpJyiKTWTtZ2kOW6HLQuswWjf+84aVJZTkKi7Ny73BNaM8x+N1u50QKYTvGJg4Z/ZKOASK8FBCSYA3kSn8Fzv4pdddQmBNKiZQw2M/L7klCSGV3TztdyJ6qhiO4yGLHm7PT0WME8fsubEQrPwGeoGpWWxEcD0fWYplaXWY/68c5INU5GfFQu2SFVso7EhYo3eh+yGBzsWmjk7MUX7cSMmJ4KQHR1tz6AQEVjCbd/rceIGX3Wqv21NjMrhY7OW9PsjSq4IiP58Nn/CjVnLhWJBx3G50svTtKcTRqH8t439lEq1r6fc0Ok0RlqwV3YlfsPeWz0Kt0TUUqTjHEQ6CKf2ZyzyY0c8jwO7H4Son8DwunSyLaFUcFdCyzqLft31Jqn9VYtXh9i2IOIbYVITFFgNkodeCdI+uqZOZd1vJ3mNmObVLtkzoekAbv0DZaDVlEkQ52AU2Jx6I6nGn73m9Rd6mo0w6T9FogoUNz5RcQrSwe4YtX47jCiSLShghVSkv23OfqAy1S9W3YJVzqyE70wfajJOU1WHq7NdcxPKisHgM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217e6e75-241b-4603-752a-08debff20386
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 15:25:29.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5um0mybsX+iCp9WQJXNKiX3DlgqoeyyVeke7OBC8PoUo/LExNob3cqNF7QBmr2Z2f374BiZfspPZyfCBUgnkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606010154
X-Proofpoint-GUID: jRw9caNvRF7R-Nx9wUrfz2Arurri20dm
X-Authority-Analysis: v=2.4 cv=BMWDalQG c=1 sm=1 tr=0 ts=6a1da46d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=Byx-y9mGAAAA:8
 a=yPCof4ZbAAAA:8 a=CvEJ93dzqiNNYlXcahkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jRw9caNvRF7R-Nx9wUrfz2Arurri20dm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1NCBTYWx0ZWRfX0hjrCwcDE4/5
 5VgXK4DgSSHJ0Uv/3FzTSHMo7b3kCF0wxxlWUXLQpKehznZC//Ml5ot1vqiQInQdQohd247GKF2
 YUMNbA9tZRM3x3okV3YngYT0mrg1xG2CpjmnnAI8ILqQNrfWE9K7bP3e3hJtlnQsor0+B39C56g
 OdrupB/wS0mLdHGENRa33763+9fHhOXMsG7SwkuQD50i31fWqhRDOHHZxZ6UvQsze8EKFh8Owte
 jriWmg1rIwi8wA3t4wHVqRZdPCTNkjWIRMZPCt2nvbDWPejg0eJNgxtR/sWjV9uoTHfeb6ckF+F
 GTIxwgPPdV1eyYEtApcp8BzwLLJmdX66swfl0yHuLgKZthqE9gQiwXjkzQBSx823dqzTa/aBuYy
 QsatFW1sggwyQg7PuN2OXWCqXNJvdGDtoTbW//i3mUcciXAkkXgj6UlH7xW/4TR5Ie6rluNR3GH
 R5g9rSwpBwQ9jSqZESA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_082559_400748_2D08B6C3 
X-CRM114-Status: GOOD (  22.35  )
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

On 29/05/2026 09:51, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> The iopolicy module parameter uses strncmp prefix matching, so values
> like "numax" are accepted as "numa".  The per-subsystem sysfs attribute
> already requires an exact match via sysfs_streq().  Parse both through
> a shared helper so invalid values are rejected consistently.
> 
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>

Feel free to ignore my comments below, FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>

 > --->   drivers/nvme/host/multipath.c | 40 
+++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 263161cb8ac0..ce8dbb741d57 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -73,19 +73,29 @@ static const char *nvme_iopolicy_names[] = {
>   
>   static int iopolicy = NVME_IOPOLICY_NUMA;
>   
> +static int nvme_iopolicy_parse(const char *str)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
> +		if (sysfs_streq(str, nvme_iopolicy_names[i]))
> +			return i;
> +	}
> +	return -EINVAL;

This is nearly duplicating __sysfs_match_string

BTW, going slightly off topic, I think that nvme_iopolicy_names could be 
made const char *const

> +}
> +
>   static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>   {
> +	int policy;
> +
>   	if (!val)
>   		return -EINVAL;
> -	if (!strncmp(val, "numa", 4))
> -		iopolicy = NVME_IOPOLICY_NUMA;
> -	else if (!strncmp(val, "round-robin", 11))
> -		iopolicy = NVME_IOPOLICY_RR;
> -	else if (!strncmp(val, "queue-depth", 11))
> -		iopolicy = NVME_IOPOLICY_QD;
> -	else
> -		return -EINVAL;
>   
> +	policy = nvme_iopolicy_parse(val);
> +	if (policy < 0)
> +		return policy;
> +
> +	iopolicy = policy;
>   	return 0;
>   }
>   
> @@ -1039,16 +1049,14 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>   {
>   	struct nvme_subsystem *subsys =
>   		container_of(dev, struct nvme_subsystem, dev);
> -	int i;
> +	int policy;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
> -		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
> -			nvme_subsys_iopolicy_update(subsys, i);
> -			return count;
> -		}
> -	}
> +	policy = nvme_iopolicy_parse(buf);
> +	if (policy < 0)
> +		return policy;
>   
> -	return -EINVAL;
> +	nvme_subsys_iopolicy_update(subsys, policy);
> +	return count;
>   }
>   SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
>   		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);


