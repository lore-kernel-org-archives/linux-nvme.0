Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3EC67871
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 00:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9XnL5g59nsMGUe83LpGNFWjJe26OS8wmZFtz6OWkkA0=; b=RvbBNGkj/LTlD3ok5ncGORFBPq
	OU96tZWfFWkZJjD2aV+Xo+w1T93maNhz/5Ot37XYF24KmnrlH3iODNllnJUT/YMrkkEPbKZISu2fL
	8r3QxxS9npfUH4MbQT5aJW+bCzD6QmE/rV9zPFlrJTT65oYbUIrisZW4tda7OHJ3gN7TaaoqNQjWq
	MQhKMkT7++othdduymNWKzDlMNKqkHCaFjWtA1/uFChfM/7hDzYyOMqbWXfel2VhEGS+IAyS2Xn8t
	5GnIJbIRAdJV+gofDJRFREVhY8iLCTVUq3kbfY9Y4E73Ur++/PAt9C37wqF/EruErvmfzegpj2fkP
	UJiLx/Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on7TF-003OvI-1w; Tue, 25 Oct 2022 00:07:05 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on7TC-003Ouh-7L
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 00:07:03 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKO2Ko032284;
	Tue, 25 Oct 2022 00:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9XnL5g59nsMGUe83LpGNFWjJe26OS8wmZFtz6OWkkA0=;
 b=B52TWFS5uSm87lwQ9449lfgRmzYMMQY7hAa2GCvmkmj7V/wbk6DrbpzIboMeDYhCLoVR
 3tbqxwtBRP7KVpVblhU6NxL4ourW8nXcBqIm72RC5Hc0I5KSrT5O2XQm56R2aSFfo/72
 Xip/noxe+p+PZ81C2H4BKbtpIqTh/IMcgT1VsCr+N9EfB5qO6XVAWqEEn4e22SGa2hMV
 8+VR9QWnyopKmf6VBv3BSrhpyGsi07/d+ZE4eTbI6YxMAYozxKenpG3WloR+P56Mv0As
 LRYGUnXwlfdIhLqxLQhwj+rrIij9ZWN+AjD9V/wcTGU9Ul2J3tSRt4ghhfeI7T2ptLDk 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84sxmpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Oct 2022 00:06:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ONua6P039830;
	Tue, 25 Oct 2022 00:06:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ya4pmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Oct 2022 00:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU6rUCXfi9oY7T8OYcUiasmSQFC1A+89fFvfR7o+KI1mIVAoraqvqb0X4dqDHodV1DxHCVanoJd+hO1S+Po5F+rnD7m+iCRtp7GXwtyrf8pa+qu/RTV1bD2GWqvvaoWGun1Lx19Cp6vMFinbmfEq8ju1DNctrXQALRsgsi0cJvVNA5wx+e6/yccpPvGF7bTNh7ZR572gTskcumn4PotGpcIJmueafbJbqHvFZnY/YaEk+GEey0bDjuzDlGpbyOs5wd0+Fx8fAvBMxnIiqa3bwo+E/cGQkWY0Q35zNkr2fwD+r/B4Iekhw0uLkHE7RFjNE3Cvg2W86vVw4kPxB+fd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XnL5g59nsMGUe83LpGNFWjJe26OS8wmZFtz6OWkkA0=;
 b=F7u2Dt8aBUsDgrH5hVkkyhNx0yIXb5k9dXQvoh6HqZeExHOM02fYLggE8va6TO+l5C2YiHMt9B1c9lJffIeACOpUP8/5Uy+qn98xwyEYigV0d0t4Z/MbycURjmnEyEqHA7XrkCnWGuQOlTGeWwliXEzjSdrmerRVSADuZZ9Vzx9T4kQI750BHjVETmGbKRmBwUilFtarqLM6+BI5O6R8iY6A2ON6TaMtLqeaHJgm2BstQjn8f9LBXKzwuyh+cYr2ZQm+M/wjbJQF5syE+L3P/j47VVli7Ri3O8dm03mW35lxBaaivG1iL70NrR/poLTYjq4+iLjMdKLQkZ9l9ej1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XnL5g59nsMGUe83LpGNFWjJe26OS8wmZFtz6OWkkA0=;
 b=jsSskHecyjZw9ZE6vajZualgBoOZsCrcrV+zJqB8FUrJiMlOmOs9dLZaDwHdU/qx9/xTShhGZ0M4EKfeWTpxaa7jY0SVm6YaeSov17HT9SeoVqKI5OXAaSxAN+L9qVDXUc4EfG10giQrjieSPpAYXpEsNVYlTMyWe1XBODugbQ0=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Tue, 25 Oct
 2022 00:06:51 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15%4]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 00:06:50 +0000
Message-ID: <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
Date: Mon, 24 Oct 2022 20:02:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [External] : Re: way to unbind a bad nvme device/controller
 without powering off system
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
 <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:8:2f::22) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: b489ddc1-8ad4-440f-52d8-08dab61cd0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	LuQRfmS6UQKPGQ38CDn0viurB9j+SlGQuOhjCAfcXNmzfb0CE48GH67dxo8qiq0Mciz/X7f4xynw2KLgcIaX+pkmMP07kISWPzmUtsLCKnsrSUv7ppmOhGowZO6bR//KkU/tphVE7lO90P7cPrr7hlgURYPUXWqcHk92/Sa31ubdGJcvQ/6TQ25zAOXRQieNY2MwMnSb3suAVCslBwDJV9FBS3TPRSqhMWMIRZ8h9hkuWhiFsxb07pcVrQAggUvlxWCpyOf/HoRc85W1Wm5gzaDDrWQqu5JRQHcl08gt+100pwlw7oS4PTiKxpnUsWzS3lGrFcDsFkndWndi5OdZOy4vlHQjDFgr1WKeTpz0ABzNrPW5W1z7dBEu2US3buv0j83pRxXcNgxQMPNe3kd9L44kwmWqqxKBe629fjVbwdPcAUB+xKvK2i8ApS8mlKwcA9BX94lB7/TGvoIjKBVmYHL+fmtqk2fZEdM7eHOAklwYMAZDiaQYGvp2fX5AXOKzRCaQnUct2mhnbqukfUhx3Bsr54i41y/uX9Nn7DwtZb5v/sYyS7hyuv+LNj5+xHBF7oI3DoxBFbhVUCmtiTj0k0mjmns7euTR8PYLv/dfQSbsu23h1mwoWWmRUnx4ZZHBfmDx4V27hJBylFIDwjb0RX1hontAnfX5U3G43xEITHkSLx9I9IHkF4kvOWxbNo1QXtQ2eYo51ykP8yCRw+trB07mVnH/TC62fuPY+/ky/uOgVyD1Jw4PrIp4fgUbLPic7SRoyzkiRB/XQB86gAjjUSH//S1Vv1ov6E8UpeTmtjJEHFjb3ps5wWEY5W5LJo9IcQ9K6mJf67K5DmN2FrC3cg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(5660300002)(66476007)(44832011)(31686004)(66556008)(316002)(2616005)(6916009)(8676002)(53546011)(26005)(478600001)(6486002)(41300700001)(4326008)(6512007)(8936002)(66946007)(186003)(6506007)(2906002)(6666004)(36756003)(83380400001)(38100700002)(86362001)(31696002)(43043002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cjAyNE5sbjF4emFMMlUrbHFJNWlXQXZmRzBjeTVEZm9MTHZVT2ZjVnFqSDNU?=
 =?utf-8?B?YUVaUnJmWjhpTitGcmF0dWUxTGRvV1U2REoydy9qaU8reWFmVXZ2enUyRG9k?=
 =?utf-8?B?djQrbkJ6WlltZU1XdU4wOWE1ZW1IbkdZQnFEYXordEpGRlBvQWxsYmlnS0ky?=
 =?utf-8?B?eVcwSURMakdHcm1hRlVZUlZFdGpQeS9hVWJTSVRYdDhFNXNwUCtjOCtyOGlq?=
 =?utf-8?B?ZGhwMkFYRHoyLzdINHk5TTYxdXFkeG0zRFRackdzbld0QVFxVXZHSXVLa0hU?=
 =?utf-8?B?YnFLaURoRE9jWGN3VHZqMHM5THBzR2pTMDFPbWlzTDlQNXpNZkdRRzdUSXlu?=
 =?utf-8?B?ekRLOTc0cE5IU29ydi9zY2EzenkxalpWVDQvNEd5STQvV3NIRGRzMGlCTW1L?=
 =?utf-8?B?am5rbFZVUmx5SGFOYW1vQ3dOUnMxNUVPYVppYmY3a3JKbVpvSG5GWUttdHJ4?=
 =?utf-8?B?NU9yc1VSS1hyRWg2MDdUbXAyQTZUUjkwM0drME1wVUpwS3NDWWFCaHliZ3M5?=
 =?utf-8?B?N2hzWjB4eExxa1NPanlRY0NUa3NPLzZ6Y3NiWHRSb2NWNXdSNkJoWTRaM1FO?=
 =?utf-8?B?dWhTYWx2bFZOUzk5MWIyZG9KWFd4Sy9vVVdwejU0bC94N3BlMUw1MXJjbVFE?=
 =?utf-8?B?RGhaY3gxTjBrUHhteWpDNGlkb3JxTTh3Z1h2eHVVWlQxekF5NitDcU52c2ht?=
 =?utf-8?B?cnQ2ejJaVS9oTWpTcnNGZXBkSjF4NDNiZWd6dDg5NjE5b3dybW9iaU84TDE4?=
 =?utf-8?B?cU1jcExOYU90eXdmMzk1Z1lIZFNUMFhOV29BY2pRMEJIVXJ3dlFjaUx0N05j?=
 =?utf-8?B?eG1uNzFXSU1jNmRRQ0t3T2hKa25BNnh1REFQY0ZXWHZwZUJheVNLblA5Y0ph?=
 =?utf-8?B?VTFQTW90YlZDMThYcTlPQXkxbkRicXhONkhya3dVQWc3V1I4YXVaMzVOdXZO?=
 =?utf-8?B?dWxzNXE2UjhvSzBiUnlNNHdzNzhDWURlakt5eHFBazZLN1RraldWeVFUQVBY?=
 =?utf-8?B?bE0waVpKZUtLNGNxc2t4QnQvZVphUzBGdzg5eHQ2UGs2VXgwL3RMZ0o3Vm45?=
 =?utf-8?B?NWpmVWNMaGtKSDM3RDZoQjhNVkw4bnp0T0RKSXNJc3VtT25NbzBRejQzYkZZ?=
 =?utf-8?B?YnpOV0FJTFdDRm5TQ3hrbW5kdnllMTlRdlgrUDRRcG1mbXBabVZOQkx1UnhB?=
 =?utf-8?B?UGMySXF0d3FOQUdCSzZyOVF4d1FwVzQvbTJyTjZMbGZYL0JtM3dadXBxcEV1?=
 =?utf-8?B?NEJybkxIYUtDWmY3UUNNZ1Fya0c2RmlIMGdwVGZFYkNCM2dNc2RyVXplSndG?=
 =?utf-8?B?Y3hKSHI4Nk94Sml1TGVVMnNBcHE5UXo4WWZSTEphM2xrL2NuSzZHb0wvYXlT?=
 =?utf-8?B?SGhOeWJSdHhvcVRGemxMZWJ2WStLQi9zMml5RmQ2K1I1L2l6Z0ZLcldoZTZN?=
 =?utf-8?B?a1g5YWp2REJKR08vd1FQWlFXMnhMdnRhOG15NjB4ZjZIRTZ0RDJQYUVGaFRL?=
 =?utf-8?B?aGoydlJQcVQ2SVZQby9DVkxDZVM2TWNjRmZEczRKWlJTRUIrRVU1MisyaEZu?=
 =?utf-8?B?eDFCZmoweUphM0tDZG41YVc3anJ2TUZyTjRvOWtCL3hYOExQS2tmb0hvdXM1?=
 =?utf-8?B?RXI4YWRBKzh6dzdUeU9nYlBTL2VWd2JYSUEzRHV5NkpzeEoxcXJmcHBhSzZU?=
 =?utf-8?B?bzVDbmZ2K3BaTlo2MnM0bVh1TVF3NVZ6dEJZdVYzblJWZmZCKzIyMFBWMzBZ?=
 =?utf-8?B?ekhYcWdyVlFFNjVEMVovZGJTcGtoNGVVaHlXRHQ2ZTBGK1hERkptZEhZUm9p?=
 =?utf-8?B?UVVlejdEcVpSN2hJbTdwK05nNUllTlhMRFBLdnhIS29nUlBpTWI5ZkgzRnR2?=
 =?utf-8?B?QnN4Y0lNdFhQaGYxeENueGFCdFh2Wk1la1VxaktGOERQRlJLaTJHcXA2MUc2?=
 =?utf-8?B?M2dnZEU1RzU4OHlMcjltVzFVMGovWUE3QUJ5cGNBd2JEVnZLQlBtcDNXbkFP?=
 =?utf-8?B?TThlS2NJNkNNTWtiK2puSGZqUzRwdSszZG4vMnJ2R2ZiaGtjbm96Q2pIZE1n?=
 =?utf-8?B?dzNBTXpRcHBtalk0aVo1RUZ5cFJ3MGFqeFo5eVJUMWhPSWo5cG9xY0k3Qm0z?=
 =?utf-8?B?VVRqTG96Tkl2V2J5dFpjWUl1ZVoxLy81S0NxZHlTd2UvcXZSUU5zaHhHMnVM?=
 =?utf-8?Q?9x0BbeTcdajxmruocwBBpsM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b489ddc1-8ad4-440f-52d8-08dab61cd0ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:06:50.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngMIsqkkJWieMrE5BTItLMaUtXpRpKyGjtZHEEkWHuLJ6eojR8t2hMj+1psAdKGAmaoek8dMOKOYRPTw0/aT6WOSx0plaZhwJkQiWzzUFfLgayxitMCO4BSVmGFmqUzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_08,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240144
X-Proofpoint-ORIG-GUID: rjy97MoQBVoVR_4JERymrSsJxZQAvloM
X-Proofpoint-GUID: rjy97MoQBVoVR_4JERymrSsJxZQAvloM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_170702_412519_3A5D6AA2 
X-CRM114-Status: GOOD (  28.74  )
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



On 10/24/22 18:36, Keith Busch wrote:
> On Mon, Oct 24, 2022 at 05:40:30PM -0400, James Puthukattukaran wrote:
>> Hi -
>>
>> I'm seeing a scenario where what seems to be a non-functioning nvme controller/drive where the IO transactions are timing out and the controller is not responding to any controller commands. The controller seems to be disabled (nvme_dev_disable called via the nvme_timeout) but we're still seeing the nvme_reset_work thread  blocked and not making progress. I tried to remove the controller via the HP sysfs interface and that also hangs behind the reset thread waiting for it to complete. 
> 
> If it's in a hotplug slot, then just pull it out.

Looking for a programmatic (remote) way to do it. Also, doing this will cause surprise remove and won't it leave the nvme controller data structure in a bad state/not unbound from the driver?
>  
>> I thought the the disable controller path does not talk to the controller and simply unblocks the queues and cleans them out before unbinding the controller from the device. Not sure why the reset thread is still stuck then? Does the reset thread have to finish its course even though the controller has been disabled? trying to understand the flow here.
>>
>> I guess what I'm really looking for is a way to simply unbind the device from the driver, kill any threads and allow the device to be powered of via the hotplug interface (trying to avoid rebooting the system to remove the device).
> 
> What kernel are you using?

5.14 based kernel

> 
> Generally, the default timeout is really long. If you have a broken
> controller, it could take several minutes before the driver unblocks
> forward progress to unbind.
One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
thanks


