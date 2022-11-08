Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C888C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 19:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYv8C7xUmaYdWxiMQv0vmOFgLAgE8slXwO3FF3LaUoQ=; b=gNYDt9k8ExUU88ioz//WhIkgT1
	+L8tyamoCbd0+BBBl8jOx9xY+AlyLQMETBJxxq5pTCWIjPGWmG/Ptij+MpqBms1biybeCjncX+0Ke
	JgdQJXKu/5HT7ak6dFICECwVRhmFM1lAD8NC/DBKonrsrRbof6q994x4Tb9CZZUcmK9fC5didULAP
	BIHfK6pnzpA2wkpnF8zY5D0ulhHGq38Tb4MMK+QAbP0ddQSPQU974L9T8TNPiDQGXRnG8DjNidcCX
	cwuqoO5jBodGoOSuOHv0Yk51HuuSTVJf9SPUQW9qGN4ardOd/ZGZ6aH0uXrgRlWQUHCMYp2GtEnJK
	eAkA0gOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osU2m-007mpg-3l; Tue, 08 Nov 2022 19:13:56 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osU2d-007lx1-J1
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 19:13:50 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JCHIK028988;
	Tue, 8 Nov 2022 19:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SYv8C7xUmaYdWxiMQv0vmOFgLAgE8slXwO3FF3LaUoQ=;
 b=mts+UgB8hmGwEPkQcbA3Msn6fhuT07cise1cPQxdz3fBRNuWM/5TZ7xIAPHMv3As/oqt
 Oocb4tn/ATOBnNXjYXS+8cdA6l46NcDNKVYLs5WGK6hWz1i/rM8y7P81x+paAHea984h
 3xyh5JOKKwaY1A9dvydcRSJED+bQ9/0bTM7aU/kCgLR3Gj726NppSvWNTtZigHtcGTBA
 mWg1H+ckgi1OKAOCIPsK5Jf64FtxBWkPNu3Zqw/WYwCDwYVBps6oGnY2vC5PcOetaqhn
 V4eZXLq2xP+5k1hDHXXSEIQ3GtPqsh4vwCMBfRxfFv1Pb2t5g7KVDgsN/abCrjrWdpyh FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kqw2dg076-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Nov 2022 19:13:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8IDMXq017802;
	Tue, 8 Nov 2022 19:13:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctcjsp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Nov 2022 19:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjzgxyHlpttHbDu3lS2rHW9GmuVwcI9OZihJTVcaIjpvCYO3T3ZIivnB69mE7/OzyVg8IS8jpxcHjrVGmFiJPeJUVGljoRe7gC8JBXY98mgPmeW0Ct82uT3vljWuSuC5Us/ntpgZNd0HDeMcrJaIWpTFlNX94bwJ5Xt4mO8E/LgxqZ3onOaloWXToF4zkoLoF0GhXubbYfvhP9NYBnW5f5ToYkGpxQQupcBF0ovPJKW+m4alWDZ9ssEfnllnzmkUgH0uUeMctvrMwPYgVAjs3vYhbQqe/iEvLmwDoNRCNUykZgdyPhsIKBh2HXWR1nihaC5xV0dtfMHY7AhxoyckGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYv8C7xUmaYdWxiMQv0vmOFgLAgE8slXwO3FF3LaUoQ=;
 b=h5uIkIO2vgB/LE1dAKvpR4/A03D5Nr1/uDCY9IpIkCgWuea6QXpsqvPQ5DTbP37FRVmhSdzsGOdYET0NowY/lt8CMu5dfc2b6AJcJuUsZxF6gI4FcvA5i0Xinibu/yvKBAgP2AMRkpcQfhZf6vU12u0A6Mk9LK+LoyBMHje2ppdeINVvpmebHXC0xwT1SBfSHKaXWFkQJdhqDOQyuXsy4IhcbwjcU8VVBgcEiuH3ufn9VPCcNlTB3QnC0uJBSGLgEmgMqw1/T60Ry3stTaKItK2OuxcGNgkYJwyRiI9OvEWjrqsj6Kwwh77ggFrxDpRAMgrbdgZbluD8lssxvTO34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYv8C7xUmaYdWxiMQv0vmOFgLAgE8slXwO3FF3LaUoQ=;
 b=x86gTVXPh4S25GjTVZ7UOstzr245Uq6wfqelH39bV/6OlRSVTpVJ8BYr0axKCklpCIcO9xZyj9sRSwrtb5ec9BP7Lx6PFYhPiRTWNMJkupld/INy5a8NW5UEBjrFKKAnVA5Vpv5xR8ZvzwR3bABMUUnOnLqjilUC8wX9xPAEpAo=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by BL3PR10MB6236.namprd10.prod.outlook.com (2603:10b6:208:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 19:13:29 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:13:29 +0000
Message-ID: <5862c074-5546-7d69-f398-e08a42adff65@oracle.com>
Date: Tue, 8 Nov 2022 14:13:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [External] : Re: way to unbind a bad nvme device/controller
 without powering off system
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
 <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
 <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
 <Y1dJbgKZUU9z/7Ok@kbusch-mbp.dhcp.thefacebook.com>
 <Y1gVOK8VXhZZbm/C@kbusch-mbp.dhcp.thefacebook.com>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <Y1gVOK8VXhZZbm/C@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|BL3PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 885a33ff-70f6-471f-1cc1-08dac1bd5204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	/sfs5b3518eLKJo5e4MV85WMbfbQ9oWBukI5pUbMJ4TJDJFhut3UzsUre0h//xJqbc3vBlRatldllHE56o5r1/5nFF1MCKekTp0yGBf7i4dQTBSHW/UNU/vFeutMYt4BLeqqZmgyrAWxYOSFmZIZHIWAeWn/v7YlwkU3MR8YsNX0OkIOdk52SBLzuenYwm4T0xkvsrNifKpcSNWDIANxkPiJ404v9/8AWeZ+fk5vXhjfOEoWOfLrSJa9BxO9q1C+1gi71x3bKCdBUKOGOBch5hkMPgS0JQnwS31kh3FE6tdxDag61JZvS1mdfrOs8At3aavZ7hJX2RDe/Kc4A3qLJr8tQ1SmRCPoaHjsdz0DnRVVYNlWT6WQqyFIz3i/AIhcBE9TqActYBxwy9USP2Op6JrY0c99OoqLAyzCZyU1wM3aHT+hmEUheUaqpwXFH/wOsrEpn9A9yDoHYI8m1fr9W+h6mYyX39LkaKMkpNpV72EKoiTAEb5s7hX1RgqtlGr90bnclENaL5Pb7679lZ+sG/E31kRsgCh7VTOtKmBQy7c/SK55yfH12A8Aed1L0a5AbhrrUKXxpALCHbDymZ2KONve1Bq1xVsW/Qnwl0EjDJioIKEZWoXGSQGLwsOJEnRGRoCwu84J+649wOkc3+i1Dpr4bHa71N1M09wtvKJA7XCBp27Mb8YUOGihKrEtsJ2Yelr5DtjrkYij/n7+HqNa1BUNcNx++Zpz3yU7V05mt5ZGr0pOjOsQBCNvw8o05gYD3KXToANzRhJvZuNo5dEEIGNq67hjNxJ5SUCYnn63FVKvo2fpU15ZOvqxBpMSNKSD
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(316002)(66946007)(31696002)(86362001)(36756003)(41300700001)(4326008)(6512007)(66556008)(66476007)(186003)(5660300002)(6486002)(6506007)(478600001)(2616005)(8936002)(8676002)(6916009)(53546011)(38100700002)(44832011)(6666004)(2906002)(83380400001)(31686004)(43043002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?MlBhZGE4QWZIcWdoc3R5Q2NZcWVlT09uRGVjdHErRWVHUUpDMmlNYmFSMklX?=
 =?utf-8?B?VGxETWxpb3dOTm5Fa2MxYjhIaDh6d1ZsTDY3K0lORjcvZklnNmFtWjhpY2tE?=
 =?utf-8?B?R1h1aW1TNVJDNmxjMVFDTkZDWXliMndIU0VQVEc2NW83dzRjOW5UKzB1ckpQ?=
 =?utf-8?B?MFl2ZG10VHY2cDE2djd4OHdTVmFZbG5ZWjNNZzlpa0NLVFA2bGY2MmNOdXMz?=
 =?utf-8?B?SkNBUnNGYldQMjFkSnZQRFVRSUJFVlRLMG93d2FEbzlvelc0eGMzbXJjRDdR?=
 =?utf-8?B?b0g0enBhT0xlck1IbGZmS3BIRnNta3FwcWMydTYzSUF2WlBFSEtnRFViWEFi?=
 =?utf-8?B?aVQ4WFk3dGg5VXRidnQvNFRHMHI5VDJHOGkrOEhXSUlmcHk5OGwySHZqNjA0?=
 =?utf-8?B?RzFZdUlvdlg2VGZBNXh4MUpaWHJ0NVRRbTVBYUs0aktHMjhoYU8zSU5KeDgw?=
 =?utf-8?B?cUdwdmpIWGFiL0JsRWxBQXFzbWRQVzRPL2RJNlQ0ZUZuWnRtMDcxMEtYM0sv?=
 =?utf-8?B?YXBUY0tFL2xSNjFpQ0dIcDU2ZG13cDZaTEtKMWJNNXh1c1pTNk1MTkQyOUdo?=
 =?utf-8?B?Qmx3emtwT011RmNuaVBZODdRWEVoR29jTjdycUcydkVqYkZwbHNRR0QxRFdJ?=
 =?utf-8?B?MS90LytrTml4aDh5N2daOVVOQkJXc0xwWTE4bGxVVHROM3JGWDNoN28yZExo?=
 =?utf-8?B?Vmc5WEl6Sk40YmpTRW1tUFFCR0JCRGoxbUN4MzNONllMUzdVOGJ0SVVId3RL?=
 =?utf-8?B?N3pJMC93eXE3MkFFSGtrWEdRVjE4UEpjVEJzLy9MMWpSN2xQcDVTT1FiSGZ1?=
 =?utf-8?B?eHduOFVKQW1iMTJxbEJNOTlHdEJMaGlaenRsTEdsZjJrSEtkMnJrbU44RjdJ?=
 =?utf-8?B?QVZaY3hYZDdNSHhGSmt4enRPUkYrWGlCdzJQbFVZaVRLR0tSQTF5emNiWTlH?=
 =?utf-8?B?VzdCbVBnTjdFUzJBMFFqODNtWWdrOWZwWE4xMlp6NkdnRmpORklza0VCd2xK?=
 =?utf-8?B?N29KZ0ROUEtUZ3FRQi84RVluOENlY2w4cjhSbGFBeWR6Zml6V05BUVU2ejlV?=
 =?utf-8?B?U0pZN3hGa25rNjgydDRmNS9XUDFpUkNrU3R1S1FPUUZZdHFHaDlCbVdCdVpv?=
 =?utf-8?B?bEVmZ2c4dkF1aVFWN3FNSUlrNjhmQWtJRHp6SklzWW1CcVRSeStFNWNGWEp2?=
 =?utf-8?B?RW5mVUkwNW9WSFQ0VnVDQWlKMHpld0ZBS2g5MWxUN3U0SGZkbGl5VWxKY1Zv?=
 =?utf-8?B?aTNtUXE2MWdWeXVRaFJpOWd3ZlB2SHpCQ1NvTEVDRHc2ZTVNZ0swcWdkRzJK?=
 =?utf-8?B?YVZYc2I2d1Z1V0wwZEFTa2dWTWQraE5YaVhza0tRRzc4cWtSblg3Y0RVLzdk?=
 =?utf-8?B?UnN0K0FEbnZDeEdlWTNKSWFKRWZFUk1CbTVON2ZpUHM1ckRJT2RVdWJEVHRC?=
 =?utf-8?B?RnNmUEpmUm01K0JFRXE4dk03Tmc5TEd1NTNTcEF5Wkw4T2JFLzlRcTJxRnFo?=
 =?utf-8?B?OWxWT0JFUWd3a0Z3TGdHWXZObXpxWkZpWDhrZU1nSGw2SXBuOVA4SU4zNFdE?=
 =?utf-8?B?OW9HTmdaU3hGa0w0UGdBaDJXZ2lsV2NrZDc5WjBicGhNRFg0OW9WeXlUZUV1?=
 =?utf-8?B?eCtmNTdISzhhNlNLTGY1ZHJwWWpoNnpsNk9QMHJObFVlNU1ZNGVNYXF5MGNJ?=
 =?utf-8?B?VDJsVmd4aFpTVWtwODAzL1RZUDA0ZS91NjFJcGFiUTlxdWhWencyblREN0Zs?=
 =?utf-8?B?WUxIS2pUY3h1ZkZUbFkxaldYQ0NLem05aWhDS1g3R0luNlZKM0EwQ0Q4dVFH?=
 =?utf-8?B?MzMxWG00RldLUlJnTldOU29qbUw1UjJvNWpGQkZWVU4vZytWUERNMVRsaGxD?=
 =?utf-8?B?SGpLQndHUVdZV2gxVmEwemU5S3JrOUM2d3k1YUFVTHd0S2IvSDZJTzgzQnF6?=
 =?utf-8?B?VUZXNnRyd0FoSVgrcUtub0FRUmVQU3BNOFpMR3ZXeG1IWStUOUQvRlJBRU5w?=
 =?utf-8?B?Z3RLUzhaYnFWbnF2YU5KZEJOSmtZbGNPRm9peEpsZVBxVXYyaFptWkxYdDh4?=
 =?utf-8?B?TGRYbWlFT3lEcmszOGNQbWtSTEo5WEtMMDhkL0JXRnJURlRiL0dSbTEzak56?=
 =?utf-8?B?UlZBNE5TenpnbWFib3NyRWE3cDNzM1Q1M3dzWkNCSFBkOTdmT3orMy9DV0J2?=
 =?utf-8?B?T2N0eGlmanJDc3B0NzNPY0JPT21Hd3VTbUVqQ2FtR0lWdm5pMjVoRThVL0N1?=
 =?utf-8?B?K1RMYTZDTFZBczRBTUMwSGQxRGN3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a33ff-70f6-471f-1cc1-08dac1bd5204
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 19:13:29.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylhd+75vEzFOqW5vvEbJdIU+ZFFn91OczZ5f4+Ub+d26noQx4Nb9JCHkElZwlY+mYjVHdE6xLhMxQpJTde22KHuEWFqAPIy/wXZW9Mimu549h9kbNKN73DRoB6uTiN/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080123
X-Proofpoint-ORIG-GUID: Gw8Nr5lup9yr60U10gYfr4L6AkEJbAv2
X-Proofpoint-GUID: Gw8Nr5lup9yr60U10gYfr4L6AkEJbAv2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_111348_552489_10124DDE 
X-CRM114-Status: GOOD (  24.44  )
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



On 10/25/22 12:56, Keith Busch wrote:
> On Mon, Oct 24, 2022 at 08:26:54PM -0600, Keith Busch wrote:
>> On Mon, Oct 24, 2022 at 08:02:33PM -0400, James Puthukattukaran wrote:
>>> On 10/24/22 18:36, Keith Busch wrote:
>>>
>>>>
>>>> Generally, the default timeout is really long. If you have a broken
>>>> controller, it could take several minutes before the driver unblocks
>>>> forward progress to unbind.
>>> One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
>>> thanks
>>
>> In your log snippet, there's this line:
>>
>>   kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
>>
>> The next action the driver takes after logging that is to drain any
>> outstanding IO through a forced reset, and all subsequent tasks *should*
>> be unblocked after that completes to allow the unbinding, so I don't
>> think adding any new sysfs knobs is going to help if it's not already
>> succeeding.
>>
>> The only other thing that looks odd is that one of your stuck tasks is a
>> user passthrough command, but that should have also been cleared out by
>> the reset. Do you know what command that process is sending? I'll need
>> to double check your kernel version to see if there's anything missing
>> in that driver to ensure the unbinding succeeds. 
> 
> I think there could be a mismatched queue quiesce state happening, but
> there's some fixes for this in later kernels. Could you possibly try
> something newer, like 6.0-stable, as an experiment?

Is this the patch for the mismatch?

commit d4060d2be1132596154f31f4d57976bd103e969d
Author: Tao Chiu <taochiu@synology.com>
Date:   Mon Apr 26 10:53:55 2021 +0800

    nvme-pci: fix controller reset hang when racing with nvme_timeout
    


