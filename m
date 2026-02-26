Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D93FC590F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxg6/DwAWRzh2ZhM+HB3zlHzjadvoK0cDHJY5CS+d7Y=; b=E9R7ctXvkpfuJ173ouzcTiUWs1
	Uwqd2A47mw3S/6fmNor6NfsWo9sp35uFqfPE3kO8ui4TmiuSAjFGQCecL1/gYmdd/gwKeJ60WQttR
	3tXo3dbjy9n4PUfywyZ1jihmcFQaW9nj4H/wtfQt18ZX4a6l5tmbYbP/1YP2/lR5tk5nJTghB+a7U
	CFGXPg+MpIeCX/VZLF3sjChKNA9GNO0ugGxNwFYRgKu+phKttzh+XERbklSLVXBBd4cLuC529/dnG
	jcway/3Cy4Oc8GaOd/IjG5ERXXes54iJHXbc5EUX1WlhscWGaTZVNEht3MrdKcwLlr4ZpR4eBfWwA
	cNWn+sJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvWme-00000005elJ-3yYy;
	Thu, 26 Feb 2026 08:31:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvWmb-00000005ekp-00SR
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 08:31:43 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvEnw3554615;
	Thu, 26 Feb 2026 08:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dxg6/DwAWRzh2ZhM+HB3zlHzjadvoK0cDHJY5CS+d7Y=; b=
	TXFAqkXZRb8VVs6ok5Xt35ssCI0kLoQldTT4tg+QeU+bwq4QAPUGjVRIs3XOSq+q
	JTrR+S6EP/9FuSkBY2aYANVEARVx0oFHdSFxxhk1QrfSyAHTPGc2srmSm0YyaxZB
	6SnS53oTJx1GKtAg6/mDEWUDlM1pZ/3EUT/cGbNV/T/65we+GD8jVtMCqhJTd3nm
	0KUEYE8X3lR83aSj/dzzx4Ng1EAD0ulB8WiaQ6wNtgMZHVIPs+q/Lb0hpbJzGDeI
	+suris1Dm9frn8H0Ygv3nvMbayMFoeCc7If5hdNJokHqGczNBeXb2CTttQ60uwcA
	u/cVmpgWwxtqWZCg52DRHw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7yu5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:31:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7hglo027931;
	Thu, 26 Feb 2026 08:31:34 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35h7v6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfHz0PhkrQ/ENVQjiHaDhFaTDw/o1/LUMqjI/BAOrTmIXVsmt2GoiPbLyiJNrwLO98FxeSuGuJLYLWlT0M5qyscQd0pDkd1g8Mjf+lteM9aUY/N14jvLH5yOQ76OnWi+LNKJpsDsmdYL2YWOoBxu9z/IRioOgGpvfYWriYzDYn8bJ2LZpwBKZRu5WBHQ6bK+76PZ7F9Gedc0q06Sr0flbq1zZFSnqMigQWWP88brpMDRe00IOs9izfQwGI1qO3XN0Nr/RtyV4O/ovc9Sw6OpuHGra8kN13WX1XZrxr3bwS7XiV6IxEV/NpnYGCkrXVoVgnRGUF/WdKePCVkPBOTxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxg6/DwAWRzh2ZhM+HB3zlHzjadvoK0cDHJY5CS+d7Y=;
 b=ajMipOQ/ir/fSkjmS0GDw4NBDq2n/2x++GTVkShOvjlpsX/tMkFc4tPvsdLq/NpiAtA4f6gWOortf6t9pwT8+vqDR+gZpphiMSalX6L+7rjkN3PQIr8D9QuJvuLNVH2uISzgivUhKsFaNCmouqkfwJm5ODeUzYKBNOTddBBRObYyV299MeTXKTP1/ug2LaZHoN0mp+M+B6i9/A3LyuIsVsgVPmyVWPGBwUjsxbKpUI0twpkjUwquEfk2vVjLtGuBAuPTpMAi2ifYo4cPVRNE6xnOYoSgOExTx+i5LxQe9P2lq5Xo6nCPpdPWVbrKBOVMazwOxVZb8zdWxOEjHKLbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxg6/DwAWRzh2ZhM+HB3zlHzjadvoK0cDHJY5CS+d7Y=;
 b=gzvxZQckXmpAqk69ppycoVoUZJR3xVIPoJxM01uQXLLF3RjkXR+HYWbE9UNZCyQ203eM8o35BWepc81fgKowxqXKlvUXmAaLCHQFAJcZaYTFMfaEJ43g76Aeeu+tcIBy1AVEAJYGAhUBCuM6cVNU1bMy2DF3UYK07woZbC2r3mw=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA4PR10MB8422.namprd10.prod.outlook.com
 (2603:10b6:208:561::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 26 Feb
 2026 08:31:26 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:31:26 +0000
Message-ID: <e5b7e2fd-1509-449c-85c1-da156eb41ca8@oracle.com>
Date: Thu, 26 Feb 2026 08:31:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        nilay@linux.ibm.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20260225202109.447144-1-kbusch@meta.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260225202109.447144-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA4PR10MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3a4a98-7fda-423b-8596-08de75116e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: zXhbBHEjU50JjqNvmF1lF65KF/PVBPBwManQGR5FNHeB5FdDC6uFFNGkW3/GgMvWQcAcEldmd+St9Q9WGINbGT7kmYPil4/u1/MkzwnC13fF4BSeLkdLolGlghIkPWqQI29RHAo+/RCl+TvRoKQhNE7A1QT0w3PzJqnM6fo7pLAiKja+WJJlbceoaWLZyiSF4XIxKuaQHbkvmzorrRgEIcTjzNlOhTPignv6sDFG9nI3R3KZ18zj0JePNxJCYdWV13E/Lv+S/LQg/lxKGu4Dsr9hgJBZE7vIiVWjJIS5sxrH5JsDY0Z8Mxyh9ddjFGHP7t82qg2zh3jn+rZowPFtSNJNkuzWOQewyLf1+fAUhy8iGvHeeTVYUkU+Gq7yHUxKdwT4VkWvusOiqTPz9n2BvWZW71HR39OgDNY6a2/QPH0EioB46Au+Vdyu736Wjdc2R7DWBPp9xg4uUX1DaP2Er57RoqgjvZNCBMw+q+sRhaZ/8L3K6gg5Y7NNn/dVAGJ7+VUl1VNoNuHlQ7Acb+wmCqf7V9mwBON3CrxJwXhVg5Dd96sZi4wsY0dLgO95K4HIAkps709RPCnUMf/ybsqiq4FwCDDn70qhVk3yr+sFuluCHYuVRnhadfUpleheb36o1qPQnvoBhXJLQG5DrWZE7NdLwlt9oodaqq65G28ZeERSG7YjzXLjV1qP93yTwPO1tmoq6i4SOamcsIDMKgMroN6WINedj6SO44lPkcF027Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhpODNOdVZqczY3N3pOTW1qbys0dmMwVkhQb09sY24weitKMFRFbXZVT3k3?=
 =?utf-8?B?azVEVSsvd3AzVmsxVVVFa1BOa3pMVWNyS1l4eWRGWEJ5Vmo2V3R2ampiTXp4?=
 =?utf-8?B?RThWZXU5ZzBudW9sdjkxL3lheFVZVWh0Wjc3ZTBaVkd2aFk0OXVSNUhKU3dj?=
 =?utf-8?B?ZDRFUi9kUmFvL0N5RzhKNWx5YmphNnNncTZJNUY3dS94S2Qybm5ielhMTTdF?=
 =?utf-8?B?dFNkY2g1a1dKYmoza0pUcCtmWUwzS2IzTjc4ZFluRGZVdzZhUXQ5cEdUMG94?=
 =?utf-8?B?REo0K3lBdzBrVk1COS9sWDJFa1l1UnlsOW04VldJVnQrWnFuUHllTzlrNlAr?=
 =?utf-8?B?Q2x2RTBhclRkd2c5bjNQdGxiNElmaWt4U3VHNHRJLzB2QzlpTGlkYTNtalIv?=
 =?utf-8?B?SW5RWTlNeHduaEJ1S1I3NEhNQWlxbEwyS0NjTkJNeWhUUGZZRnBnelU0Ni9M?=
 =?utf-8?B?SUxsNk96RVlDS0NVY1h0Z1duQy9JazBqQnFlb2dwdTN0MCtyTDY4WUlSZ0sr?=
 =?utf-8?B?TFViZitrVnR5dyt0WHRNMGlHNGQ3My9BcEswdmNPOXpiKzM4RHNXemh2YktS?=
 =?utf-8?B?MDBXcEdqY0dJdXNrb2pRd2xJb2Z0ZjV0M09pMVhBR2ExRzdwcnNTK2lZSUwz?=
 =?utf-8?B?REpacUNHNkp4cktCUXU3L1lQSW1iRG9BVEYxU2ZhaGNFcTBwS3lRcFhGMElL?=
 =?utf-8?B?UXRtbW1mNzFUcHBHQ2hXbkJCeWFjdEhrMkJGWkt5c2FNOUJmMGdrSG5ZbFhC?=
 =?utf-8?B?cDN2QTljTFduMEo0ZmliZ0swVy9kNEpZakI2V1JGcVhTT21HSW53NGJiY0FT?=
 =?utf-8?B?V0JsdWFidllnZDM0SHdYOWZqN01WZ2pNcUdLWnhpa0JibmNGZW9pZ0VTekVD?=
 =?utf-8?B?NFJSM3NhT2UyWmtBMnhOY2lKUnpCNnIzMTZMS0lBcEZ4bDRIaWpNQ0xZbG9u?=
 =?utf-8?B?ZWs4UVhpUzQvaVd4M1M1Uk9IUEk0NHN4cHMraC9Nak9VSlF1bDBBaVVNMzNh?=
 =?utf-8?B?NG1VZ3MwODh5ODNPdjc3MEozbTdEZm1WajhndWNXK3J5ZVA3Q2JJcVEzanZj?=
 =?utf-8?B?Qkl1SUpuRmtTTmhjeENhRzVOOUhJY0dhVGs0RXFRV25mMmd6QkVBMFk3STM0?=
 =?utf-8?B?SE1nQTFkeWhiMnJ2NlJxeVdFcFpkM0NiQU51aHRXYjJiVjNUOWZwb0grZXVn?=
 =?utf-8?B?SzBqY1IveGNzTndiRHZrM0xaSXRwMHMrbjdiYThHdWlNYitXVkJyVzhwaTRG?=
 =?utf-8?B?TTBkeWhCeVBZS2xlU0g5ZEx0VGxMODRlbTQxUm10UzBiMFBPOVp6ejZVN2tp?=
 =?utf-8?B?R3VYME9WSkkrbUcwNzhOSWxaVStaS1JCY2Uxazc0TWYwcVJMREt4TmRqQk5P?=
 =?utf-8?B?cGYrSm5uQ3J0T0I2eVYrME1mMWNPa3grR0thMFdGcVJtT3VqUGYyVWRHM096?=
 =?utf-8?B?dUpYS1ZkalUzZFpZTVVZd3NBRUFFb2dqUUdubm05U1A4ZWp5Rmt3ZDViMkV3?=
 =?utf-8?B?dEpwN08yUXEweU9qZkRRRnFzYlpCaFhXYmcwR1loQm9hblNyQyt2YUErQWx1?=
 =?utf-8?B?YUlpcXhuWjV2dFByeG1PM3RYMHQrUDhVZGVUejN3T0xmSkZsUTgvdzVXUlVy?=
 =?utf-8?B?ZUlSSm1xemlSaEVyeVJ3VTNuajhiUGZDcGNleG9vY2FZY2ZQWjE0Wjh2RU9O?=
 =?utf-8?B?ZFdXNitpTmNrdWJveGVYaFhFZ0FyWStDMk9sZjAwWllML1ltUEZSbHFCSy9R?=
 =?utf-8?B?N1dQdEdTdU5pOG9MYnJROUM2RGdiU21KbmwxeXhIZG1UdzhJOWhCb1pXU2tB?=
 =?utf-8?B?ZmFmeDlVcDRlU2tZcFpnd1I0NlF2NjYvd3BqRzFpeGF5TGdGc1A5WVFRaWlr?=
 =?utf-8?B?d0JrMWxGdlZuSGQ0VGJ6QVNwS1NaU1Uzank4Rk8xWGMvbnVSMHM3blNmY0t2?=
 =?utf-8?B?Zmw4OFc3RDNYZVo2VUkrZnUvNjlPUVBNMTByUjVOT0g5Ym5sNGVxSjNFQ2tr?=
 =?utf-8?B?TDJGRVdGNHVpMmZqWEF5WjdYOWlmajNpSjhqSFBOVXBaWjNqbnBGOVgraU1u?=
 =?utf-8?B?YnhJS2pJTXIxekhjTFFFMXJ0N3diSmt6Tk5mUTRWVE8vRFF2QUFBdnhMNk9I?=
 =?utf-8?B?aFphNHA0cEk4S1Z0TlBEVWJWQlBidUIremdnay9odTdydE5pblZvVzFHemRa?=
 =?utf-8?B?YWRUeTVJSWZQNTVCZ2tyMVoyNndsSThqNlhpZlBkamhlaWRJY2lSZ0JXdHZO?=
 =?utf-8?B?OUFody9zNlk1ZVIrZ3NYWUlkc0taOVkxWWlKTWhLYjY1RTZSdTlnQVNZdzZI?=
 =?utf-8?B?RzB3dG13SmtUaEE3MmlleG9lbWZKVk1GSlQ3aWZEdjZSYUxmVjY5RFcwVk14?=
 =?utf-8?Q?GllQognD+sXsSVow=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HGN+DMXxhPEthcoesTi4pAi7/+CxNVERsaA8iyCf0d2+7dLpI9F/9sh9pDzrgICSK91C+vTqk4x9DX3GSYKVA6xgewJNP7JQKDMayYR3Lu+X/IwsB8oU8KTAw365ccQC6g1mUI9R8LhFZ4+SkoAhf6Jsq6rPUNrAoWixmoiEYZoD5vAE9q3fD7HjyQU045WZ4q+CzUXL+SvffHZbDgcxg6v3jJXcJNUQ2ylz7UgfkRGF4F7/gnpSSvYa2AnaOveAGa0Xk4aDltp1mkh4jvL/FEMzZ0M5HzCZW17VAYWlfkM3RoFKIZCG1IcTpyyrdvaeCuu5lT7/mdhyUHh3CZTY8Ws206lhuPjNPLrAtPBw902BHRRVKnH4r0a8Z0n6LKTo1bwI8P0q7eWCNTUt2cfcgMPkh9vBz/dRWTVGS/phffUbEQMyJw0vvBc/TSquKShmbkEO4HokN/Bgt8B6ezUBZxEeUOBpIdYKRn0jR/Azv080x4YZ77O52pZgYo3/h5ncQEj97EuoKHNp82ZT5CynmQ5ijPPHJQGy/eFcpT0H4mC7UBX0zkwcJcqo7ccUnTSof+noIa/2ZVPK4OlhoPo1GwBRMYW2NXlUtSwfTYDq8LA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3a4a98-7fda-423b-8596-08de75116e58
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:31:26.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ygy1g32/rXkXsbJZmOQ5KvTexJrVSUc3Ys4xDaddGF5NeWOaAZua8VsoME4FC2VU8V78f0GciZDs2u74VNaKKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260075
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a004e8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=b4uK6I5pMT_NVDxAfj0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12262
X-Proofpoint-GUID: hXzR6QkZmm308pU9KoXTn5TNNo8rND7G
X-Proofpoint-ORIG-GUID: hXzR6QkZmm308pU9KoXTn5TNNo8rND7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3NSBTYWx0ZWRfX2piL+0VUtzrB
 DvQCaqDLGvVcjgOLgLHYI2pS7P+yJQg9uz0OX8EFHgL++px617YWqie3RJaC4+8GVDTig80OYzn
 2C57NIUz5kp5i6lEhxsA58gNP8gc0Ndo1a2uP1ckKbWZ9WnIVwRyUFL6cZz1f58KBZdyEG3EBBr
 UItw6mKtYHX4F0rEK0drziKkZ1KAhQSUrJx3jHmsuEiiqdHbmVclAQGsNWZSCLILHmQfQ2NsfeP
 bBhV3o8XqKOwC1KYHdrZJROrYFHq8B5RdRcsyXjXRMXVfX/njMYRBBV9LAyfXFwmQVB33qlFeLm
 VpcgWc0GM+8hFd/joSnreXuIpGC6U3KPSVWdSTJkSlig4mC7VABQ+dWvQeDwPSl84nQT2KfR9cf
 PECD/Zu88DyZaHLckapfL8nSdDWaRbL4i/uO0IyGZHQnRB427vq0wCOVg/SXO1y7HJhS64XC5pi
 hAkp8tesUkBZVoiPVtwQJ4RwRIr27pHgWrqUD1qA=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_003141_062264_161D36AD 
X-CRM114-Status: GOOD (  10.63  )
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

On 25/02/2026 20:21, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> We need to fall back to the synchronous removal if we can't get a
> reference on the module needed for the deferred removal.
> 
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---

Feel free to add:
Reviewed-by: John Garry <john.g.garry@oracle.com>

