Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EE4C5CFDB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UfuP6iL7Za8di5XzzLq+WxpJgSZe1BikOaZkRR6fbG0=; b=okTFlMa8fNkKdUb0u97g0Uy5yZ
	/XdgqtgVCU9IdPf8LdvzXZK5I7M0sofLG60CcJ7K4Stg9kvLTgZ287DPYldE/NtwCiAmLm6qc6xiX
	WSpPnNSUR45FLl0Jk2L8pH6Njtc0Gy55ZlIt4gwisgUMR7VTpazdm7mu2T/d0cgKRA4WRxlM6CyJh
	m38UI5nAc1XYMMZmyRiux7KDYDZDhz4OX9rbLoWN71I7cmrz2tpWl+FGC3mq5y75ODNP6e0JsS2Tp
	lMo0pY8Gat/JVgo3xz8+tekh6esTYlkUOQ3S7W861HGyWHyeKGbxZicwB/tU4MJ+91UZAHpo5scyx
	e4or7Ulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu4Z0-0000000FfTX-3QK2;
	Wed, 12 Aug 2026 08:43:54 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu4Yx-0000000FfSJ-1v7o
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 08:43:53 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BLbIuY3328867;
	Wed, 12 Aug 2026 08:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UfuP6iL7Za8di5XzzLq+WxpJgSZe1BikOaZkRR6fbG0=; b=
	Y7Mai4LdvOJKpr38lZ3yy3sLmUI8HDzCIpqL5cZIdyyAvQOtljeg4VeOKs4vmrSA
	T7ha251QtRQ3UTiuDcF5LQtV2OjpLSxDS5u64l/u+eojHSqOimMrcx9f+CW1Dtu6
	ereS1x3ZkQjHsSGrM4dXTehNTEILft1kBJnYOfAL2h+hzndbZjXtfC0FHrce8Mxe
	W0GBm0fyalO0RYRpomLvMqw/pvg/xrgro79WEHDx9trg4DtChqeRXAH9LRqb2//U
	XryswejFnLSf7GHRVGmHPqWtEYOHE1zo/DuocW1Q2HCa29WOScZJNomNrcoFVZUQ
	fkzHkcXuq1sKFxRSe3NqiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxxd4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:43:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8Z9nS022129;
	Wed, 12 Aug 2026 08:43:45 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwet001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Aug 2026 08:43:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDSgo2Ia99skLqA+KfzLWkPR/tiWp4wfK2Q9PD+t8SLuRslrw5vnoj9JGh58DXuX2TCuUv4aft+ZT8CdEN6nPbLp40wd1Oy3pFyiytLaLgIJepEURPfH8HoZm020/hBJNwFqu5YuwnfWFfd3Fi/lbhVqlEX8OoNprmaMd0tiz4wakjDBpakTgOVn77rDvQhvdjQtl66DfD09YSxTURjfo09YDbFGT6KwY9HVJxY5fIQtfZDD9faxAsDRPswj77meqZ8INyAr2PC5x4gGQVsg5V+/wK3xAYF92HKMxO8lu0zJ+eU6N3QgHSRT2i5mT5Bun3JvqGG4RHjruZT2sc4KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfuP6iL7Za8di5XzzLq+WxpJgSZe1BikOaZkRR6fbG0=;
 b=nn2vWuzXcay+efEf/6Z841AeLaacPu0Id83kHlWoH4FsxiCUVGngDOPX1yBu+nJuG/l2cHALCr1YueoEvdibA+I9+FCBLefF0q3Lfora6aBc4cGvqumqyrnG5oEsUB3nU+1MN0VZPO5l/88bm5dTwJCE9EXfiUajjI+c2sKFhC4hgoVq9hyviHgxBbR1BOWrz91qGNt9mfJq3Uw0CtS/S38vrtJZKieiVKyK3kJYkODlsytCMtHQRfGCg0OHebGpECCk2k6iHI9Xbe3yMZYJ5HvtzNAzL1ajtyrvsB+qAJ8YY36lg4K3uW/k3PcDDIKS4Mu5JtTYPYlF3d5yyR9IaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfuP6iL7Za8di5XzzLq+WxpJgSZe1BikOaZkRR6fbG0=;
 b=rWEfhdSVLYgbQy/8iyJtRJc/bY1lTTlFDzLm57ZDw3zFMC1ttPhhgifpHvlv/3WATHd6XFymWd+IkHy8jd7eh+wf9g0qynxlMcHD5/ufm2xlqoNOJJMI2p7HxrPQ/ofusLFp//lix4uVM/VgUIw7Awto7W4caKz4AGCyFBXI2yk=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Wed, 12 Aug
 2026 08:43:42 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 08:43:42 +0000
Message-ID: <0c8b8a88-8f0c-40cc-b6ba-59b12b8f555f@oracle.com>
Date: Wed, 12 Aug 2026 09:43:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@linux.ibm.com,
        wenxiong@us.ibm.com
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
 <92d55da9-2cb6-43aa-8fee-51f2c86101f8@oracle.com>
 <936b1d36a4292c9501eec5a5df3d7b47@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <936b1d36a4292c9501eec5a5df3d7b47@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::15) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|BLAPR10MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 6597d606-a869-4ad7-5dc5-08def84dd003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|10067099003|18002099003|4143699003|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: P16+Q7dKWsohmqQki6gXW7fNK0uwQE4VfuibtoUTjFxKCRGQD1h6HBCsIrRR1mP3L8No4xYEbk04cCQJmy17BCSHf83pbPwxThKkF1vFuIwFCJISzSZxE0FDTx0oaPQmrNbLinQFTw9zY9r2OHcOW+OInpG+TII0jvcsBNM4oRm5dUFw3FphbnefkGfWEJi8TUWyKirtoekVzhQN+/v5VaQ5NCue0KIyLC4STE7ZtyAFWI6wdv9j2y15Y61ciVPtsc5EsbGqk63WGQTtQWZSD8baYzRJxEP/WThcGcBhLEBiC6WjP0rloCYPkDUk7v4aEGy5vlXuG3QEvZMZgq2Lt+KIdQhHU8G+EDsMWlVwWgXD8HeU7HIUUUbqHXJtlhYINJQtdYQc7y0JEt/mRUcD54f15RUUEcJmi0UCnUYKbu9A9YGpi/QnbD1YirS8kvI5U4xtH7kvKV1kuqxnTvssUsOASkK92Biwvq36I1DJ2smt2ejy0BWx7wx3wU3cDefUNoZQ4vMjMO7oxoc6A23zgBuj3NeEQTW2SiNdMT7aM+u+pZvRYdL+scGvc1pKkiGK3QHK72zjn0qOpmlqVRkGLhFE2FxKDhk8LWufj8TyvdD8ZDiuf71Zqu89E0ivb6Y4E+w3t/VebMBEKOxybob10PSnRY9ZQVR/JdhN9vPRGp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(10067099003)(18002099003)(4143699003)(5023799004)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01LR1laUW9HZ2JEZ2p4d0hCalBRclA3a2hhNkFkSzh0UGNaTUxjVmhQeFhz?=
 =?utf-8?B?bjNiSmNNZ0J4NVU0ZWlOYjJicTMzWmFVVnFnUXBBWGp3b21vcHp2aWpxN1Bh?=
 =?utf-8?B?Y2cvOFQ4aVV6d2RCWFNGTFExdlZ4VHpmTnFnb0xCaVJ5a1dsQ2JoS3RIb1hm?=
 =?utf-8?B?TU9kcjJGTG9XRS9YY3RYSU1OeWRSWklqSHZMZmhUR09zYkZEWS9FdS9xRUM1?=
 =?utf-8?B?cSt5OFllcmFMRHkwUjQzWGx1RmhPbmJ0aE5HMjArZ1RtWjcwR0dvQUdVQi9F?=
 =?utf-8?B?YWhHSGFRKzlISGhHTUVLKzFtK08ybXo1d0oyRFdXK1JPajVUem1qSFdMZkpU?=
 =?utf-8?B?Q0FYeWRwT2tvaHVBNG5TeE1QVXhPU2lQWHQ5ZDNncVlYUHRlMkVubFZueFY1?=
 =?utf-8?B?S3BDK2J3ZkJreG1nenI5eElwaDFveFZ0V1BtcERnTm5FUG9sdnBnaVFtYkda?=
 =?utf-8?B?c0d0b2FKQWlUVkp0TXNjNHBvdCt4VWtCaW03R0xyNHVpYkNFd3FDUGNHUFcv?=
 =?utf-8?B?eHIzREU4djNhRDZRVEFhUStjRVlzUENWUk1kdXg1bFlkYWU4eU9xN0RnUGs3?=
 =?utf-8?B?LytXYzd4aFlFaldlWTNYVkc2UHZzeXBGeExBV01rdjBzVnBIcFZpU0dZZCtt?=
 =?utf-8?B?MVYyVmJoSE82NEFQQ01IdFRCSVdjeGtSRjF3NVRna1RnMDZEbVo3cEp3SmRs?=
 =?utf-8?B?R21zb1R3T2VhbWZySHBoNWNnajVIR1ZyUVgzeWFmM3haMXI0UjR5U2I2M1RK?=
 =?utf-8?B?cXVSSlRSNkRaUllSYlhCNXQyM1NxaUpmazdsQUYxMm8xbkNIWm13OXpTeVlB?=
 =?utf-8?B?SlNPMW1ZRnZQUWxXUHU4bG82VytUZWZyUWg2L0JXTmZsVXh1Ti8xTlVpN0l2?=
 =?utf-8?B?THFwdk40WTlLUWhxYTNKSkpDRGhHOGtRbmxuRkcvaXdWdUU3RFp4d1RZdXN4?=
 =?utf-8?B?MzZBTnUwV29rMDdzMEVLY1Nrc1lSalBSNm1vMWRpcDB0ejZCVUhkZVZzRjBN?=
 =?utf-8?B?UjFWTTRHRHc2eitrb3N3cnhXVU5kNFM0U1dYdFhJR0lpVGdtbUVpUnhRTkta?=
 =?utf-8?B?eGNWcitMdXd6TmEzdXN0cFMzQTNQS05YT2FSQmtreWRKVjAxQlU2L01EZksr?=
 =?utf-8?B?NFhRZjlUeE11Y01wcVp2VmV5NlVtUDMvcU82dy9KVFlrZ2Z4K3NBWUdZWVlN?=
 =?utf-8?B?a1JVR0U2YVBNOTM3cUJscmwxWHBvWWZ3TjUwV0VHTkhFRW9LbTJTc1d6eDJp?=
 =?utf-8?B?czJZeHlqWDc0aGxKNU1PZG5HT1JxK2xMSzBQcnpYNGhmK3k1OG5rb1hPSDJR?=
 =?utf-8?B?a3hnRUpzV1JraWR6Tlc2YWtNZVJoSTF0TExTZ0dHMTI5WHVoOEJtUTlYak1u?=
 =?utf-8?B?MmhHNlY4Q3JHOVpsYUl1MmM3eklZajc0eUZLeGY2Y0NMOVF0T0ZaQ0ZUdjQx?=
 =?utf-8?B?d016V2szTExzMUJ1eVN4cG5uUVpRSEdyZG1HSW9STWovNC9pTmc0MS9yNFRL?=
 =?utf-8?B?TUF5TWswdUJoY2dvckhqVURJdklnL0o1OHNOWjdmNjdTNm44VTdwVGwrUm0x?=
 =?utf-8?B?WFkwZVVYVXcyZFJjY3hrQ0FUb0tNT0tzVTIyUUMxaUZ5MDZXbGFWUGNyM2RM?=
 =?utf-8?B?K09wY3oxbzhDT3JZa21aaXkrZmloZUR3NWVuNVV6MUNsYUxSZzM4VG9zbFBy?=
 =?utf-8?B?eVBkbG4rSkN4Y3VreE8xcmxVdmVFZmJEcVZpNkJISlNFWHBmSjdxaEgzb3k4?=
 =?utf-8?B?Y0FHMW1YRUhUM1ZpT1YzcnRQVGpMQ1g4THZva1I3MmtKS0Y5Wjk2NmtiaDdF?=
 =?utf-8?B?QnJkcHpqM1VzY200MElLejVFRTRDM0o0ZFI5eWFIblpXNnplbXN0UzhucVFs?=
 =?utf-8?B?Y3dGQkliSWZicHRQZEwrd20rSXFSRi9lNDNMSUVXZUJyWFZLS09hZ2RxR0ZO?=
 =?utf-8?B?eldOcUtmeURWbEQxNjNNcG5Ib1FhZGNLMkVkMlRMMTNxSVZZNVRUcERJQ0pC?=
 =?utf-8?B?M0ZoQ21iQnBJeG9kSStOT2JXR2VIcXhSMG1zeWpqTWFUQ1d1bXpDeWhYQVlE?=
 =?utf-8?B?MzhsK2lxazBYUWZjZGtJVW1JK0NHTUFIakxUSFlGdmZiR0t0UnFQTm9mWEZx?=
 =?utf-8?B?TUI1REhqbHVxZEtwQmxpYVlxMnRkQzh4MWYyempEdjNmMjc2eS9pVmh6WjJU?=
 =?utf-8?B?ZnpSN0ZhemhTZncxTzNRRHhEaUNJQTBhQU4yTXM1Nm40cldnb29odDV6bGNl?=
 =?utf-8?B?UWpuUjN0RUZzK2djV2MvaXg0SklyV2RyTTIrOTRoRlhYbldqL3RWREhpa0JM?=
 =?utf-8?B?VC8zVTdBZ1dhOXhjT2FYbExqcmFYSmFMaUJEa3hJc3V3TkFrSUUyUT09?=
X-Exchange-RoutingPolicyChecked: EjUuAZxO86MqYwDzmnmKAoz2eY4ZL30UBQt6Z1IOSMBlZBDspyPt4hqjxBJEbkT77pd1BuVfcG6hQDHck1qBKHg3jYnD/eh9bfu12kUVFVpFhzSWYJnxK0R55tQkNFPqaFo+IWsNGf5gonR6XSEP09ksDsS+o8bl3KI0lXSEEILc3o4K0pHlZOwO7wEUhF8lTPge68gLBGRnRQoNsmfky3iTI2YLKppUV69WLZfOhkZh6WfYPplWzDaIjLHOyNa8OjrP/BPD3HOqDqsyW4VO4sGdOWOXlAhx+pT1hiMshvG63SqiheiU6dEVXxttePHtwM20AX2yB9v657ZiXsO79A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6PiG95i2Ytvl7jvlNniskzRA+6FE/4yTuFsTbL1EIx85LhZSC2nRaTWVB3G35MGIyYyLdfrrBi0ZsGvvEQ991/O/ssK/lIGsP0jarhXxvlQCmLvil+WkWTRd1rzI06E365Y5pQ1mtQqBprnTlZqRg4bmyfyqmNRPoXrCqQ+agE9Rf92VcoIs4M+p5nnJNUkM5eIKAxh/O9W7hXPftPKKLVlY4y5gJRAm55v9ndLnnwbSVAD+0cnmqKD2YLcHWZlivGHQ6ZI4TcMRpfBUy8dhzMJNyEzwOdO8JEey9LPcFJuaqXo/rEMOOzyutvP1gAUc7+6DPFrkZWGtqfScqccJdwPmXmvSo+XHw+V3ZYPDicKJ/fQ+D0SmbcW/xgtaFdbwZqbUNSN/MyWGwFtmBLGGXN5i0e6SrMrItgkQzsdbpYelapxCc5q9mcrbTOr5c0JBaVP1gIWYEau1N3xxI55l9AHEF/7OB0WjxQtREfDefDZiUSueoQNyeVPkuW80nzW5YaJiK0Uwz1DMv+tL5U16GHt7j37yhRIDNUilByOy0n3LQmH6PJutBOQTuEhz03OGjdYs0QOWNanxj8ZMEUSFrQAgDHpCySqOVBvGPwrGqfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6597d606-a869-4ad7-5dc5-08def84dd003
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:43:42.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5kslU+/Cra1MQLSzKrabUwKPcYPUFcfcRBOKUmGgnWI9WTe0WPZnZbUzH4t5tAlDTvPoGd7c4kNLzPZK7Yqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120068
X-Proofpoint-GUID: e5OFVmZo8G379aQKDbpYZ_BUOaeO2IoZ
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7c3242 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=RKy2cARTXwKJjOylwcMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e5OFVmZo8G379aQKDbpYZ_BUOaeO2IoZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2OSBTYWx0ZWRfX77ozvITtyU8/
 Or1c7LEgVXaiKnEVkAofZtvXE9oVsB1a+Jnzx2U+fTGuDNW/Ahnnk/tsRR8/z+9k66aGFgWEwoI
 XHdJarWRQWAxp3X12hnmALfE7F2LcltD67jllAbcwvoUbcF9ZXudg2hRBvoBgq8TxdxNANseZO6
 3Oy7y0VzPnECh2/Oq/22ed4xg34yvMgMkXY2qvaUOchnuBh08G6bsTjMr/WCcQeAPhUplSEylxR
 yBh3xTXdF8PWG9DKIr6XycXM5IK8Yx/v1PKpJ54p0BMnp6VXzlRDD002dmjeugLeZmltiRewyvm
 rHYZJHqtcgxVdVd4BYfs6Ul9MLigk7ZkITd2w7KkpKQPcKOesk3B90ujTT5eKLeWmSlVEfmidW7
 NwNeMuMbgVncw973L9USiHW6QxUobTPt9gq22cckUa951V/C3vVVZP9rzEk6dFSi0qdKcpA9dwh
 Xnety4zKtF5Mm+gcqjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2OSBTYWx0ZWRfX/BXgZVevB+mY
 +vw4dkL9dqdfjjF6nmJUdDoIqEMk1UG5DvimOarfVT67YUWZwPQFCl06X24SsIc3Kjv3X2weIVz
 JEUAMU1J6frMZlMgVG2LrrfO95Rdm5SMCEO0HHGhZleIVnJXXVqs
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_014352_040666_E8F7A5B1 
X-CRM114-Status: GOOD (  19.31  )
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

On 11/08/2026 19:54, Wen Xiong wrote:
>> Can you demonstrate that this is a problem?
>> 
> For example, the Linux root filesystem is located on a multipath NVMe
> device. During system boot, the reference count of the nvme module is
> zero. As a result, the tester can run rmmod nvme, which causes the
> system to become unstable or crash.
> 

Can't the tester also just unbind the device from the driver, which does 
the same (as unloading the driver)?

Example:
echo 0000:00:04.0  > /sys/bus/pci/drivers/nvme/unbind

For this PCI case, we call nvme_remove() -> nvme_remove_namespaces() -> 
nvme_ns_remove(), which removes the NS path and deletes the gendisk if 
the last path. Same effect, as I see.

> linux was installed on /dev/nvme4n2.
> #lsmod|grep nvme
> nvme_fabrics          262144  0
> nvme                  262144  0 ----> reference count = 0 for nvme
> module.
> nvme_core             458752  4 nvme,nvme_fabrics
> nvme_keyring          262144  2 nvme_core,nvme_fabrics
> nvme_auth             262144  1 nvme_core
> #  rmmod nvme
> [11312.100786][  T937] BTRFS error (device nvme4n1p2): bdev
> /dev/nvme4n1p2 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> [11312.100855][  T937] BTRFS error (device nvme4n1p2): bdev
> /dev/nvme4n1p2 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> [11338.724061][  T624] BTRFS error (device nvme4n1p2 state A):
> Transaction aborted (error -5)
> [11338.724075][  T624] BTRFS: error (device nvme4n1p2 state A) in
> __btrfs_update_delayed_inode:1096: errno=-5 IO failure
> # ls
> ls: reading directory '.': Input/output error
> 
> In the current nvme module reference count increase/decrease logic, the
> operation is skipped when the device is a multipath device. As a result,
> the NVMe module reference count remains zero even though the NVMe device
> is actively being used by the multipath stack.
> 
> static int nvme_ns_open(struct nvme_ns *ns)
> {
> 
>            /* should never be called due to GENHD_FL_HIDDEN */
>            if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
>                    goto fail;
>            if (!nvme_get_ns(ns))
>                    goto fail;
>            if (!try_module_get(ns->ctrl->ops->module))
>                    goto fail_put_ns;
> 
> This patch adds module reference count increase/decrease logic in
> nvme_ns_head_open() and nvme_ns_head_release() for the multipath head
> device. This mirrors the behavior of nvme_ns_open() for non-multipath
> devices.


