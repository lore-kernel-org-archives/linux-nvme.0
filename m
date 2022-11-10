Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED4C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cA3jVq7YZCLg7oV2nglhKD+zada+3DaEGKEgIRjIq40=; b=Kk5wBN4gyf3LmrJRdS9HnRRBXt
	tkz5NOdymmhgWjONJcVFoOJWtb0t6GDsc55av4iIZiU+aTGYrdc+8Bxoc50ZBUr2tcVwN4F9Ebt+H
	smUUiNJm9Jx9NSoI1yTQQHfIrUGnotBASKka2KAx2EgdL1SZB2eWH4ecERNiMXSyHRotJXb+AoNB9
	jlLuuoRNNqx/AdrAsH5s/cVkYIjJDvstrhKdLIadA/sX1i6yI/PdKZth5Ad+cVCMpfqK/xG1vwh0m
	2M6w1/ziXIrI0tGJEstOxv1+d1E+UI04gm6iQWHZuNUg6vzVjo+i5lal0jLdm0exsLQZK6J7BhwJ8
	zZy1y7Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otAs7-007Oly-Iz; Thu, 10 Nov 2022 16:57:47 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otAs3-007OjK-Af
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 16:57:45 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAGjrQX009692;
	Thu, 10 Nov 2022 16:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cA3jVq7YZCLg7oV2nglhKD+zada+3DaEGKEgIRjIq40=;
 b=jyqsM7D6HQF4UQI6DA04gVP+/kL83U7cBy4/V7RySu38krUXZG710NvERuyuviaHa0cp
 HP41vsj+GSe9W9nHhy/2D/RiPvkltMaHYeMCcH3ErtVemidVevpmyX09X/iipBq+HEC5
 bhROLIlgX1h96v3Nt199XsQe0/woe+VzlCuATyTtsY1GEMtI6jC1ja22binVaiTc7CG8
 9J9w6GSt5DSnsRymtgxv/QzMzYOMlH3io57KPXF4BS7AG9oq3x0edA/mh9qzRDfxDeRW
 ISKwci6B9u47ytmQhrMqt4tEXY/cx9pnXCYW0otChnIxXyKdOpvYsZPDPnTJDdXUNS49 qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks53x8204-23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Nov 2022 16:57:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAGD3WV023052;
	Thu, 10 Nov 2022 16:51:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcys3rsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Nov 2022 16:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWtSyYWRRZgVFL2ABCAl2MvHfTAAI1gNGzeGyHRYgHYSokxGCy1sQBLN6fZQz8mBgxZOf68HC1Ayxa7eyQBr1A+0dl4IWfKFlguyb50G1abTd/+He1WuA0hysJUe70NVw1arztzAxqc5mefAo8dsmCZDpxIy+HG62VAgd6UPyAhY9zIo7Q1A/dpUejGplQj5hBgGF89GCzDmpgO8nONRQvr5BvwIMVyZHaE8wpRuJlvq/RDtybGiBCI07tgKqd+g8YN6qWlapDYFxr/2qi16YUsOYfZlnzUvkORqpdbpXBpDerBoFf+xf/fFYJ30Nc80C0DC1InqbeTy7lvWszpmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA3jVq7YZCLg7oV2nglhKD+zada+3DaEGKEgIRjIq40=;
 b=atS/EHQIJgcZoxNQz61AFlqKNe4qZOdFhXWJV6pIc0Q8xCbY4BJLeUgrd5794Me41E77ouar8JbYK7i1UM3WaDH8DW0Uc8tL+pXpP3jCc25MQIlP9z41Av9Ay7FEhkk97p6djY75iPgMReGbat62RXW3dK0dr3WeAq3palSNp+yUC9hCb1DcyLrs3rVlSkGXUU84X0xjlYXV7vUXJ7j1qRT85e8LhWKrcLmTDaCJwOPtNH+Kr6KHn/GVB6wSa06C8KQz+1ptTG7t6Y8HHY6k5uVbQFfItwGTECT10Kw9Y0UHS7kGBaJdo0CIo0M6xfy4sjyX7v03p2Qy/Cpverloow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA3jVq7YZCLg7oV2nglhKD+zada+3DaEGKEgIRjIq40=;
 b=MZCD4N+/pR3o4+VOER+DXxZiSHvk4mgIXBYZTcyfow+hcO24FJU/HosddQZIhN+xsGNOhXlOJGW2vVnEjqqI9wNMhay1mDQFc3LUUCPSf2MvG+c1jTN7ixcfYuaKjv1CUymrHvIE6o2SOs11l09R27OYRafUwfI7gqLcCeEwY3Q=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by CH0PR10MB5002.namprd10.prod.outlook.com (2603:10b6:610:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 16:51:45 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15%4]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 16:51:45 +0000
Message-ID: <0ddca4f8-95cb-d3d5-ec89-282523c0b914@oracle.com>
Date: Thu, 10 Nov 2022 11:51:43 -0500
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
 <5862c074-5546-7d69-f398-e08a42adff65@oracle.com>
 <Y2rjJZlDzWe3DqkA@kbusch-mbp.dhcp.thefacebook.com>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <Y2rjJZlDzWe3DqkA@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0949.namprd03.prod.outlook.com
 (2603:10b6:408:108::24) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|CH0PR10MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2866b371-6307-4986-b276-08dac33bd9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	FpgjKG8wBsHENunU3Wr816QZvhv39+DsqsykmkANXG2CqL71aMdlU/qVj++ADAi7lRzWy60BGKYHy86ByplmRwdtvpo8knx/PZ7IGl2HTSP5dCvYgIZoXna07yIaYFPjEEALsn0ujomzKWJrLjS5YexgZBAyskyKibyZn9dEuibir8cvHYf33u8IjunYmgn4De5cyoSQlApkKAMpTMqA4oFzIDaJarKRprvQX4qscKMQTKHfPQjQMlha+Kn8FxQYm77DODFCA5JKGtC4I8SD1oEhVYdmXP9cq2KDrmshLYVpd6l3JzqI73lUvTYej+BwAN7iaTu0LrmBLAVetlY2rvtPcDputq5E9/qjlpywCoBD0eK5gmO2xZyGBFVRcJ7iATsZt1FpEyESifXD9tceboic5/O4a3+n5fi8gaD56EhUi/GvN3QPP7Wwmkn/JQXPfnhyeJKLPZxDsCZkK27gsg14l7fYChDSZLmP48FQ6xhGBtYtLn21iovaU68SQ5x2f9fQU0+XVxyLkWZaUi1Jxn0TnBAamAnjwx2vTOSjDk6gtHgoGHpfrnpgEXDuOyf9q4QidwKRvMRU8RB8go7qtIxy1r4hkRdmlqiDM139DQ23U9PngmiYV4CDyIMZsp4+HcJuq7YBT91DD58wib7XOF0geM2K6jCusEV67P4CG1RoKWSXo/cwRTQDVv/ZatLFRC3LhcAhRSg+1sjsJMqSPlRzs4tduKPP9VMT3c4/j+lu39hRsnRhtwclkomrur+fxloHrAyNPtDPAFKB3Je4TthHQfbpSiDSI39dYAxA5cU0K9MQHOCJJ59gj9nKtefc
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(31696002)(86362001)(66476007)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(4326008)(316002)(66946007)(6916009)(83380400001)(44832011)(2906002)(186003)(478600001)(2616005)(6512007)(6486002)(6506007)(53546011)(31686004)(36756003)(66556008)(43043002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?WUlrWHN2ZUU0bVZ4bjBqWWJpQTZVTm5pOTJLdTF0NmZneW5kbFVGd3BZYmdw?=
 =?utf-8?B?STdPeDVadlZsbkpZbEtRMnljRTJwQTZXaVk4eTlMZ3ZRcmNoUWczb2picnla?=
 =?utf-8?B?SlYrYnRnZkFqQlNYUnREa3BHL2xvQkN6ZVRxaWkvamVublJrRDhRVzBvQnd1?=
 =?utf-8?B?cTdtb0ZIZ2RieGMweU9tVDlraFB0SUJNQUJrSkpDc3hCQjNMc3hLS0dZc0lQ?=
 =?utf-8?B?eGg3cEx6SCtHZ1NUMFhZdkorUllTS1FQWFBYOStSTlNXcUZ3VEtRS1BtS3h1?=
 =?utf-8?B?dnVCZGRLcUVteDlLUkJ2YUJ5Q3dlbEJhSkpmUWVxaGdOR1dGd0tFUmtKbmVo?=
 =?utf-8?B?VmlsdEpSUlBRUDAxZHExVS9OMit5V1VyK3hEZTFaOE8vdUZ0Ry9UNEZ1dk11?=
 =?utf-8?B?dWFwSE1zMmx1SzZ0QThGVitkNjJPU0FqOHJlWXdrRUEwQUJOSDcvd0JhYUs2?=
 =?utf-8?B?a1E4SEhpZkI1V0xoaCtGeUppbnBBeUNkTlUvVy9hN0RNS2JaVldiWS9pM1pI?=
 =?utf-8?B?STRMM1Z6TUFGemJiV1p3QnFGQ3g2R0M3eHUwSGJ0NTkwSlhzNWlGMXFNK2FV?=
 =?utf-8?B?TFRxcWk3OFppQUJyNjJKTkdiQk41dXY3M000dk1ScVZLUEo4L2k0YVo5clhD?=
 =?utf-8?B?ejBzNldYV1VJWHhaak15RGYyV3phSWNlMzB0ZU41YVhtZ0JtTjJqQzNFTmNj?=
 =?utf-8?B?NElyekEyMFpmUkNmUzhyQnVhc2FuTno5bDdWUDhSN013Qm1JWWZWOXJta2k5?=
 =?utf-8?B?a3g5T2F3bUtqcTloS2Z2UnhBY3ZFZENCQmxHTmp2Z0N6OHhOYkgvQ0NFS1E0?=
 =?utf-8?B?T09vTVVVNWc2Q3FqWmdhakxyaW85dG5ndmdraUlnRW9FNW1ZWVNQNGRMZFFn?=
 =?utf-8?B?Si9JbjA4dzU4cmdweXRwcEx1RHBHajJMRGlvbURLdU1GVitkNW1ZRmN5SUg1?=
 =?utf-8?B?UzFEdUVmWkt4MC9aN0M3TlQyenJ0UDdYNENHdHZyWHVOelh1d3dleUtQZ0JL?=
 =?utf-8?B?eGQxNEdIWGdVdVBTMGgzQWZWbE5aK08rVmtKcDQyL21pWWtwU0tRR2FPeWJu?=
 =?utf-8?B?VFZraklxQ3YzZmExODQwSWdOUlF0dE9KY1h0Z1lWUnhrOXhxRWdqWGRnOFVK?=
 =?utf-8?B?bDJoNUw3NnpYZnppU2xjWFlwbWNCUVgyTnBXQldHUlJsTDgrZC9yaUloZEN1?=
 =?utf-8?B?anVUaUZkSE85RW5vNDdIcVdzZVgydElVeE4xUkIyL0I3UndWSVlSSmxLZkhr?=
 =?utf-8?B?L2k3dm92VmNWZUxHdUVVVU5iUWhuaUtNYW9NdnF1cXl1VnJkSit0bk44MVBG?=
 =?utf-8?B?NXhFOHI1cHM1R2FJK3B6MDJ4aEJwa0ZqYVdTUU1peTl1QWRNRENobFVEb3FX?=
 =?utf-8?B?TXdGaFkyUllkSDFCdmRoaFZlRUR4dzNucWFLejZpRXZQWFMzaHc2TTNOK055?=
 =?utf-8?B?WW5BOGR1WGlZdW14K0lwY1lPRy93Um0rN091QXUrZ0pRZkY0Q3VXd3lBT3p1?=
 =?utf-8?B?aVVPQ3dRZklVRHdTbHJWZlIvdFBFRFY0b1RrSXZtUnhaUkxPc0dGY2JtM3Q2?=
 =?utf-8?B?WkZucmd5NFd6alliVEt1UHZsVUt4d2Nwc2t1ejFEZkpiTG9XUkFIMmxQOVpY?=
 =?utf-8?B?MjRiYXJMMGEyeUhmV0FsaXFISktMZ0RrdWd3bzBaMXA4QnZVZ0EzNThMb0xM?=
 =?utf-8?B?SHE0SUtVdXF4bFcvUmVkNmtmMWVmMENoZVdjSDBZQWk2STV5SlNVMy9qeGJT?=
 =?utf-8?B?eGNtRUN4UVRNZzFIalJ2cGJ2aGozUEpaTkY4T3BMK2hEWVVsL09YK05NUk5j?=
 =?utf-8?B?Z0ErVnZwUDByUUpVQVcxblZ5WEw1WnJUMjNEZnJkN3JSaXA4dWJndVV1WHF3?=
 =?utf-8?B?LzZ0L2JWVVp2U3crQVNHNHFiQnhybWdsNk8rQ2VNeitoS3BGaUdISHZ0ZlB3?=
 =?utf-8?B?OW92OGt3UzVkNXR2Zlkwdnk3K2dOejV2dE4vMGJpeE1aNlh6SmJJYW8yVXdK?=
 =?utf-8?B?andkU0U0UXZhM0lxSFZ1MGJFc2xuTWtVaW9rb2tiY1VMMmJ1MFNuOStnZWdy?=
 =?utf-8?B?MXl3S2xxWVhrSjR2bXg0Q2ZNM1ovdjUrMnMvNi92NHFxTVE0VXJkb1JZS1Vp?=
 =?utf-8?B?Sm9ORVFybTVhOGFiUnlvY3dnTzdJTUphTDgxMDV3Y2UxNWMrMlo0eGNmQnlk?=
 =?utf-8?Q?ZXLSL+KUOIFASRDLvD+oWCiJ+WcpbRKIaezZY1FU3xkZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2866b371-6307-4986-b276-08dac33bd9e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 16:51:45.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NInsmjelA25kfTu/bdj1tEugvAIyV25AeV0zze1q/SP5J12Fh0eqg+NKx+PTdSTi6VPgqS2lJsaRRuiD5BV0p7YB0eR8Q53uQW1hiEqKANWf6/l2Xjv6AJYR6Ukkb8Aq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_11,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100117
X-Proofpoint-ORIG-GUID: ptANks3fug3GkxNTv0ZXUxVUkhWcHCoC
X-Proofpoint-GUID: ptANks3fug3GkxNTv0ZXUxVUkhWcHCoC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_085744_255559_73CDE538 
X-CRM114-Status: GOOD (  27.96  )
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



On 11/8/22 18:15, Keith Busch wrote:
> On Tue, Nov 08, 2022 at 02:13:25PM -0500, James Puthukattukaran wrote:
>> On 10/25/22 12:56, Keith Busch wrote:
>>> On Mon, Oct 24, 2022 at 08:26:54PM -0600, Keith Busch wrote:
>>>> On Mon, Oct 24, 2022 at 08:02:33PM -0400, James Puthukattukaran wrote:
>>>>> On 10/24/22 18:36, Keith Busch wrote:
>>>>>
>>>>>>
>>>>>> Generally, the default timeout is really long. If you have a broken
>>>>>> controller, it could take several minutes before the driver unblocks
>>>>>> forward progress to unbind.
>>>>> One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
>>>>> thanks
>>>>
>>>> In your log snippet, there's this line:
>>>>
>>>>   kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
>>>>
>>>> The next action the driver takes after logging that is to drain any
>>>> outstanding IO through a forced reset, and all subsequent tasks *should*
>>>> be unblocked after that completes to allow the unbinding, so I don't
>>>> think adding any new sysfs knobs is going to help if it's not already
>>>> succeeding.
>>>>
>>>> The only other thing that looks odd is that one of your stuck tasks is a
>>>> user passthrough command, but that should have also been cleared out by
>>>> the reset. Do you know what command that process is sending? I'll need
>>>> to double check your kernel version to see if there's anything missing
>>>> in that driver to ensure the unbinding succeeds. 
>>>
>>> I think there could be a mismatched queue quiesce state happening, but
>>> there's some fixes for this in later kernels. Could you possibly try
>>> something newer, like 6.0-stable, as an experiment?
>>
>> Is this the patch for the mismatch?
>>
>> commit d4060d2be1132596154f31f4d57976bd103e969d
>> Author: Tao Chiu <taochiu@synology.com>
>> Date:   Mon Apr 26 10:53:55 2021 +0800
>>
>>     nvme-pci: fix controller reset hang when racing with nvme_timeout
> 
> That doesn't look like what's happening here. I was thinking of this
> one:
> 
>   commit 9e6a6b1212100148c109675e003369e3e219dbd9
>   Author: Ming Lei <ming.lei@redhat.com>
>   Date:   Thu Oct 14 16:17:08 2021 +0800
>   
>       nvme: paring quiesce/unquiesce
> 
> It's not a clean cherry-pick, though.

Thanks. We are desperately trying to reproduce the issue so we know the patch fixes it. The plan is to run nvme IO along with attempting to do a reset controller (via the sysfs) while another thread repeatedly attempts nvme user IO commands. fingers crossed.


