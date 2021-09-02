Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63422C4320E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 09:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD6661059
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 09:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CD6661059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dwlC0oMKGKDys3660OB53KGk1pvscFZdwHVCTkly8mM=; b=0HuKD086zRIgMh
	BASUQWSDdm8zPH+5AO+JmSvgr0/BD6DFbVGiNzA/d7zgh+s6zEZOhDy+dTt+HWH1wU/HE5+pG1oJS
	zZdnw6EExZ8BlvKbLZkOyEoWMC87nz1WGkE7rd7LHVCM5lhR078fqV3dJuOXZs4ESC2omSqTd88OL
	P04GVYTeTHCuv0iBPieFF2yjTHFFua7q2vSpY6vSOIMOANyat7SujhhQY7PAYfALsTXWh2s0e61II
	VauIwJdz1v1UqQNOMurKDElbICclCoaveFbE6npeDte5HGDMsI73ZYanROKvFiNrDK/GhEAgx3jvg
	eRqU4xME5ZqWhgW5FwkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLjAK-0098GC-5S; Thu, 02 Sep 2021 09:37:48 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLjAC-0098FE-1y
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 09:37:41 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1827OAEq002842; 
 Thu, 2 Sep 2021 09:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/1M0SRBWY68cvr3NFs/p+LsmYe22JK17fltmeCXcycU=;
 b=UgiS2ohdmmvP3lgSmP2l/4xbE55lyu9SKWciQII3bbl9/4tQQz3LC77cv3CKPCsj5EL1
 Xsco83XaAzcgkW6VyQA0IYNTExsNVW/pNLr2pJs4u/tozf0dBuoLhp+hn16WEw7T68zP
 qp9E2/nqVi2cjC+WFDVDM9jOeKI6FCiZyXg/wkhq0qbArvvDmrXZdspLLbdUg4+Gz34I
 oG7rUYYN36VAAhnOgOJ+TSXC9c3G7drEfBBqLgujZ0okRQu8Supy+L8JkNXfRMa72/GN
 PZR1CIe6cNOc0WPEsGprWsaH7i72KwM67qmjEDnHPQJGwjXFTEyp9nmt3lolfxnYtV4c 7A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=/1M0SRBWY68cvr3NFs/p+LsmYe22JK17fltmeCXcycU=;
 b=jobgGXr+l9gjFtOA9L5oDacOMDHTo9m66cyq56SzxZSjfdL4rsb9kDTrSeAL1A4F8WZI
 kqVtrWpQUaELMJgocpReck9uyazUhWYrZvVZWjYAH0QnRq7ofOz411LSCa50DLAr2+5g
 x1GEgJxrovuFKbcb+/iBgk/Su2O42uM0pBHRCR+yGmucxPbyLHQuymI9NJDyP142dMlm
 b39xKfGJWjzIj9Z++PA3xofCKT8z59XOJmrBiKnO7Kxz3ybIXAAtJpMLJyp6mL/craKg
 3+mEh2PEz3IxS2bXjHqf2CoMqrnU1+s1RYqoweYnv9d6Yr9++gDL4s+yQEoe1pRdF6CQ zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0j1t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Sep 2021 09:37:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1829ZjKB164236;
 Thu, 2 Sep 2021 09:37:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by aserp3020.oracle.com with ESMTP id 3atdyv8q7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Sep 2021 09:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKXe6s/7sA3v4QJV/c37OTfVlR4cOHBe7tLbtDYnCCPR2BIMAzEbq0ARN3vTOre70As682VeOQzKDHktu/gfVOp3uiQaaxsC5tr0pb0CHVnd6Djfx+guQ/rlXXlZc/Jum3mU/8lcUoIqEgSoilsTVyguziupQI4YYlO8/bDJK9e2joVz6KqBzPW8eGQpnaQ2tSD+6wD3kooeUXLRTZd4SqZ6pjrAudUWXUF4m0bpYi4eTb5EPfOFibxUJLAot4xZGPDVmMjQFDgDAFZE3lCoAVlP//201DcBiq84xbrf6yZ5LiinOcF7AlYrPXfWzlpxIC5wnIrF/obx5S/5sNM+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1M0SRBWY68cvr3NFs/p+LsmYe22JK17fltmeCXcycU=;
 b=eqs9T+fCKq+8piBw2FNqM8hnOh0+Up/1ngftdBYWC8OA4HN5CXf0H0XSwtV+T1i0ICrnoNotaD6tYFQLwPco4F6LJNZIjuNTfVCi30CpHTWRu8ddxNnRUos1VI55rmlLmOWzJRBdRL43gKz61QxOV7Xh7KtxRext+K4GCYXiY8ugXGx27pm7AMgQ9RJIkuugLKaYasoLHVblGowdLAaLVTi731jHjvp5RrqEQ0yfbnXtEqVfopox94IVYR7RvV2nVH/E4w0MFNGEv2XDEcWyHloI+EmnHmXJSZlsFbqnvfxJRQ9h1GcQfEnvEePsm2WbAvSgUN9IG5VfgfRcTgWqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1M0SRBWY68cvr3NFs/p+LsmYe22JK17fltmeCXcycU=;
 b=YsdFWiwj6dbotBTYYaq+vqDWN99cUCMZNVr66xKi+JikDpdg2QLaq1z2E11/qxZ2wPlMfR96DF2QdsP9zMtEfSGmAPoU1cBsJga4jBVJqdwL5XNOr84+ZArX7Qo2AsSNuN10o4p/HKEFLrPOlFRiHbg45MMNNIznIK2A/wUnVjg=
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4690.namprd10.prod.outlook.com
 (2603:10b6:303:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Thu, 2 Sep
 2021 09:37:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 09:37:24 +0000
Date: Thu, 2 Sep 2021 12:37:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: sagi@lightbitslabs.com, linux-nvme@lists.infradead.org
Subject: Re: [bug report] nvme-tcp: add NVMe over TCP host driver
Message-ID: <20210902093707.GC2129@kadam>
References: <20210824131638.GA5558@kili>
 <dc6d8f82-9729-16f8-bce8-1a81174a30e6@grimberg.me>
Content-Disposition: inline
In-Reply-To: <dc6d8f82-9729-16f8-bce8-1a81174a30e6@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:0:19::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Thu, 2 Sep 2021 09:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c68d2fc4-5df4-45ee-b704-08d96df544e2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4690977D5AF0DF4ACD3781758ECE9@CO1PR10MB4690.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/lu3ev3LDQiwlS9aWMj2FxS/OsrZtOFO3izS2qnViIg4n6yEdcsHjlfhyivrGj9CtlJMub+s4Zay3GzxVrLvLCbgr1t8iyhCU2AtK+FFxRrfPnTjPNtj+OEcA7n76OxC+uF1X5hS9bCb9yL9Da0HzJgwTLDlVFmHCaEmFH9H7vpEfNkn1ZG5WPugHM7LbtvzawSXMRx4bh1aYlpBZFH1LXjk2wHtQnREPMk9NoCM7JgAiHecacxYjQ4EQEbfbLFV/RyaOZbxRWMtZDtiC6RNwzuJrizlmRGodeGVcQ0Qo1mQgg4NP5DIkoH7t38Rw6s3sPPndnxtqhAmVIHjf4MvojTLBRanbWOMPsrsaWEjr+dT0wa1Tnt7bvuLs1w4cHXEQn9o9I6Ge/PYis1dGL0jB3HzE55qNPl5/dwPqWxEpM//pHCNo/6euxpuq/H1uSTCt+LXm+ZGpDOcpQdAwrDKj1iFztvhAAwBLWRRLz2hLRpL5vOn+T9JUlg/6ChFyyPXySik4Z7wuOpOqjnaRtOhW7P18nuHcZHmX90ecITOBBnUuCtb9S7UogYZbNyYYI2oCBvh0h3ecIPfvDzPw/8/Dn47KH8xbUnl6GEM/KL8P/BAcG1iwuCoqiRkS5tEr1F9WexpFVHYJgeHUHFrOQZ8bYtXWDyeXV/PlKka243VPlwRoOx4/1PcGhl772OjQ71wEAk/wC1jbJPV23z7FRX9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(6916009)(52116002)(5660300002)(9576002)(2906002)(8936002)(53546011)(86362001)(6496006)(1076003)(186003)(478600001)(4326008)(44832011)(66556008)(33716001)(8676002)(26005)(66476007)(9686003)(55016002)(66946007)(956004)(316002)(33656002)(83380400001)(38350700002)(38100700002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/BJyUVaUk1UrU8pjxTkjFaVQJvm7Af2ARQ6AV/hLQwcr9g/pl2TZpuK2+Kf?=
 =?us-ascii?Q?tLrep1UQ9n+7tLEHjQU0/9RAqVDDteP88hCCMfpd+n+GxRN+ThhhdiLUDUPe?=
 =?us-ascii?Q?77HMyb+EV7VGLQ1xYWHPLrQ6wDh7E+4lhhHO3qpMCy1r3CfDm0dCdBwwpcL4?=
 =?us-ascii?Q?3eufXuT7AzxYZONbPbro76G5kx+YoNkOop/YA6mAS5pJs5P1hP0tctywgyv0?=
 =?us-ascii?Q?4QUhq2AXAg2s+k1IT7jio8ocL0hP+BfziUELitdqnLVzusLi9K+kIf8EOHGa?=
 =?us-ascii?Q?QcCsv/8DWBkS2207JR5GA8RTYciZqK0BYynlYW/xDTlf97Np7l3GpWjnyu56?=
 =?us-ascii?Q?nWO819lbjM6uxMLNgKt5f9jiLNS4VCShkA/VBluBuewmRm6nWmCmuhfcf3au?=
 =?us-ascii?Q?qx6k0JTiQkYDv2dG4uMKvApE78s7L3LnqRucV0Ur+j96OiDtTv7ad6GDyQWO?=
 =?us-ascii?Q?6DnQDr0MT0JzOrb/+XjPaG8AWTuA3gVhhePZClPWS0HcO6rzuvH5A3J/NX3A?=
 =?us-ascii?Q?IOFNXXfk/AiRQ2Yww9aEamRocfzuK5yA4C0wc5m4Ejuzg/GmroFSp/hjQcJ8?=
 =?us-ascii?Q?8UI1FfURN/sVqwT7z5tTquddHOeRcv/MtLxBYN4oEvYih04n68u5K+uCBwxb?=
 =?us-ascii?Q?XsKiRqHzVxokqfm+7Hxw8TU/zufqnQnA6301gHOsEdNLWvVs3z+ko86aT1SE?=
 =?us-ascii?Q?rAs1/WecRGwFSIlbSekA5yp6fUHMtYtBzRNGZ9Na23uiidffFBTwzVoHKD3M?=
 =?us-ascii?Q?6IQ4U9a0DM8A6CyqKJnOQAz/izR5ctfFdGNATb5z6NarSWTZCL0hsam2K0MA?=
 =?us-ascii?Q?6vEXFJV1yGmK8k4OX3t83hzLU1m1kphFbWmRHljDza2+yrpDlloKmMrSwgXu?=
 =?us-ascii?Q?1bHzSp47WbKTIU9lv1rBkUTmzXkF03aNY0Plnazp1V5bSgNhNu8ZkicTunDa?=
 =?us-ascii?Q?emm9Dia5xgXn+SoCG69ThBxyV5TUUZRvLl8DjfiTREFFCzyIjmDbPvPnbFeN?=
 =?us-ascii?Q?yDElTnNwTUWKxLDUzoVjA5RSiKPvu67oUUsjKtFFir8hkDcoZlA3tOQbg0Dc?=
 =?us-ascii?Q?8GMR9UD/JJW+d//6P9bL0jBKTiLwjxebu5zndL0ncxgiBOqZn0FqatO/Pqa3?=
 =?us-ascii?Q?ht6mDL8mSFcOqUdpJZxma89Q14zkCn0VTBKr5UJbbOJ+NyTu6Qkq34Pcep+j?=
 =?us-ascii?Q?V35mjw+GxIFT4hYIuqc1vciV4JtE2+IhMo2tRJLekPAbB3JRW5khWbzxfmyw?=
 =?us-ascii?Q?ZMvgskMt0AOmJAmvPIYd1WS+4KgfJ30hbNyrcuID77O/b6LLkAacSYnzrP77?=
 =?us-ascii?Q?TufxbV4zlNiU5enkdRRKlMAE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68d2fc4-5df4-45ee-b704-08d96df544e2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 09:37:24.5496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVL3AnwcORHhDgP7Rxh7KsodT2EGPd7Q+CHNZx0fzI9ER/wgK5B3Rb2dhy77Eg7U2mWreM5VPuR2pYMyQdoEcM0lfWSJnwZo3efY58r7Rb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020059
X-Proofpoint-GUID: ZSu6SCBMFdVSwgyZEcKy301rjwudahs2
X-Proofpoint-ORIG-GUID: ZSu6SCBMFdVSwgyZEcKy301rjwudahs2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_023740_301880_70C76978 
X-CRM114-Status: GOOD (  29.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 01, 2021 at 05:56:55PM +0300, Sagi Grimberg wrote:
> 
> 
> On 8/24/21 4:16 PM, Dan Carpenter wrote:
> > Hello Sagi Grimberg,
> > 
> > The patch 3f2304f8c6d6: "nvme-tcp: add NVMe over TCP host driver"
> > from Dec 3, 2018, leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/nvme/host/multipath.c:101 nvme_kick_requeue_lists()
> > 	warn: sleeping in atomic context
> > 
> > drivers/nvme/host/multipath.c
> >      97 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> >      98 {
> >      99		struct nvme_ns *ns;
> >      100
> > --> 101 	down_read(&ctrl->namespaces_rwsem);
> >      102 	list_for_each_entry(ns, &ctrl->namespaces, list) {
> >      103 		if (ns->head->disk)
> >      104 			kblockd_schedule_work(&ns->head->requeue_work);
> >      105 	}
> >      106 	up_read(&ctrl->namespaces_rwsem);
> >      107 }
> > 
> > This is a new Smatch warning I'm working on and it's sort of
> > overwhelming because it has generates too many warnings and they're
> > complicated to analyze and report.  I'm trying to send these
> > automatically generated call trees to see if it will help.
> > 
> > nvme_fc_unregister_remoteport() <- disables preempt
> > -> nvme_fc_ctrl_connectivity_loss()
> >     -> nvme_reset_ctrl()
> > nvme_fc_ctrl_connectivity_loss() <duplicate>
> > nvme_fc_unregister_remoteport() <- disables preempt <duplicate>
> > nvme_fc_exit_module() <- disables preempt
> > -> nvme_fc_cleanup_for_unload()
> >     -> nvme_fc_delete_controllers() <- disables preempt
> >        -> nvme_delete_ctrl()
> > nvme_tcp_state_change() <- disables preempt
> > -> nvme_tcp_error_recovery()
> >           -> nvme_change_ctrl_state()
> >              -> nvme_kick_requeue_lists()
> > 
> > 
> > I looked at the last call tree and it seems like potentially a real bug.
> > 
> > nvme_tcp_state_change() <- disables preempt
> > -> nvme_tcp_error_recovery()
> >           -> nvme_change_ctrl_state()
> >              -> nvme_kick_requeue_lists()
> 
> That is a correct analysis. However from this flow, it is impossible to
> step into the condition that triggers nvme_kick_requeue_lists because we
> call nvme_change_ctrl_state with state NVME_CTRL_RESETTING from
> nvme_tcp_error_recovery which means that the new state cannot be
> NVME_CTRL_LIVE as the state will either transition to the desired state or
> fail and be unchanged.
> 
> I wander what action should we take here? make the effort to defer the
> call to a workqueue context? or we can safely ignore it?

Yeah.  Just ignore it.  Later versions of Smatch might be clever enough
to figure this out.

regards,
dan carpenter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
