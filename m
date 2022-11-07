Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E9AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TbUX8KQQf/Ro4pDWkSpfF4xSxHlJIlPU5s0h3rLRNR8=; b=xL+GP7RCrPUWm5S6KL2ns4wTGF
	9F6RXru7tlg2xHfAhOogMp1PY+t6UJz9TkFE+hvc+/3xZw0TnKnS9lAThCMi/IXR7Sx2sdzWVb/3+
	6LY1UC2IIRF8SrMeRFRc++9P5FJMYt+q4kvZMxnc7Atg17Jt1zWF2WYraIvYrSjNeddkeyqQiXiLW
	ahBLoeHFQq5cq/BV4BLSQYopM+6SGWomF2lyo9wdksPJ/AMUb1V5sjUuy/F5TAXPCwITIxY/NY2CV
	CxDvMXCfLgHYyn3TZp6VZQAqiHfG0hviNadbqMjreVNADs6F9yK3noZb+Rpq+H0vdTRdR0xJxE0uY
	XRF+xX9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5cE-00GWYm-OL; Mon, 07 Nov 2022 17:08:54 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5c9-00GWWP-S9
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 17:08:51 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GT1pk007150;
	Mon, 7 Nov 2022 17:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TbUX8KQQf/Ro4pDWkSpfF4xSxHlJIlPU5s0h3rLRNR8=;
 b=zb1OQ+dAZSKKG9z/Rc8MIfLMjj716K7KLJhN/kFGpH3KbWkuCqphNfoMbl9nMB3yYhxP
 rWy8q5KuPK850hBDE4RYB3PGkmifViInoW6MVypWZtP8m57b5poO49W5MHa24huC9Jw3
 h/XhWvEx82fg75kk16jsnAuvxKi4jDjzLnDE5RJgxukyL2JvZ7YL11IfrFgWlwfwEWH5
 36jhDhtiglhyw6QYmhNh22GXmURmze7+FHmZ/2XCjQknUAJUtdsar5nXQFjKo3XhXNwR
 obW/p/0jO70DG6FjgILZApwbOIEafIPWPuXQasSaJypqf2D23G2ufNyyf+IKGkzkkvvO Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj4aqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Nov 2022 17:08:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GZLos034455;
	Mon, 7 Nov 2022 17:08:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsch2ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Nov 2022 17:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcF9YfJ5Y7RT9xrXUuxIAXnPrGqCFvRu+SwhHFQMJVJU0wUTBXPez3WCW/yxW2OYCHDwdgc/Gugy1xmYkJRXlQO8g2CPULwrDvQGE4LfQfo7sx7MFBhJBeLUSZXMrS/LnCkavd169gv92dMWeK5ZX6KbIYUekw7UIz10m9jkxs5YlRPr/qvAeGGdQwZv8LmjYyPKwkWEh0+D2I/nXPCPCZ+O40ivI3S4GKb+2fxckRs9RCbRhCkNdqeAa8hS/XtgNqMvH+TTDRexzFd9b3eJtvFJMMudYLVLzqASNKjMdA4F7EZg+LENwIOVY/DWmGrL0O+GGmRWWVjWDRP5Lb947A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbUX8KQQf/Ro4pDWkSpfF4xSxHlJIlPU5s0h3rLRNR8=;
 b=YJOgB/C+0Nqm1U+KdOtjTsqtlSQlFD97YPNPmJ6u+aSx/5rxc+SPJdbIWMFzN1dmOVkJCgTaQlf/O+voQ+iR1ZBWG6QTzhtm3LLMg+It/hQ30nY5/gnDcldz2n0wqfw6724ye7CVXkGxffLnrwTvGvx1Vk5+CTrAam2sIY07CQWyJHZb0rbRPQ7lHeGDlLLCfTKESQyZBAysmJh/o2q6eE8WA8f38dEwYaK8PMxseEktoTKOJACT3sbUOHOHhTmhvNazp08ngZ+ORosECX84NDybfcEg70OOrGUoEA/PuNlFEwXYBOzszbtCUwuSGFr7V7YRtJqcwJMVyBQ0lHfq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbUX8KQQf/Ro4pDWkSpfF4xSxHlJIlPU5s0h3rLRNR8=;
 b=otMkr/fN5MF+roG5pPaDkMgAPxt50sJ6pO+qV3AeHg3yTnozuxCrmafakdvy8WMpPiPCJMAtwe6aKQ3ZZawCQFWzlsB1xMr99k0GcYfiOJyG/lRJM5ij9gvN7oLJWF4PHqQiuZUJi/+5hFlXhU9nzGcAJSDhjaJk/1wZ5CWDGtQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:08:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:08:35 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: only allocate a single slab for bvecs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yfqn155.fsf@ca-mkp.ca.oracle.com>
References: <20221107140019.1503818-1-hch@lst.de>
Date: Mon, 07 Nov 2022 12:08:33 -0500
In-Reply-To: <20221107140019.1503818-1-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 7 Nov 2022 15:00:19 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 185d45ef-126a-4481-604d-08dac0e2b4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	4x7JjKNVqVZR9xmLlpsQVA1k/HYGB0ZfWpJIAH28Jcj2wuNStEUiKnfOzFunBWlLIKAJIy7ylPSHV3TWGUqS9BCp0UlD0THslEA1hvF+t8CSMm8EThmKOcGODtP2roXsXnlGi+FJBCiMaTAmNY6wv8QAyDlcL+ejmDAce7MF5IH/m7axOdb/ULbOyQQxPKitXumysIaI2lx9x3dhrYiUwRTIdMCmbI1A/OJJ0J9E1GLm/LkL8lsfiraBh5EgLdEKc6M8/eimRAvtrHhaNItgsdebYaCtskZpdHXHZ6b/4HbAdwwzbHURmJL2gNCYWvvZ2V1EQCnlCa+u8asjE+UQAY2k4/QLFLM0EOyz640BSNqE+SyeUpxFpazTnerf5bEXr3deIlyMZ9s8QDUxoZS++9IoCeMm9P7BKHplHyrrWYtwzdnRzte/D0aba6+mmXMdiCwqK4yJHg+JkUyx0FAQDHsp+xGYwPg70DCeBUeAUoBiGOMB++V6axv2fsY28kKOJ10RGFaMGJRwcpPEg3jPyAiupXAIxKrZEtpj0WXBuafYry0NaoQpDYp9/cXw2+bjpZQ7HGsW/imYE8S4fZWgzgAk3bElRwjUqbkYGe/3A2pMtgLlNsp9aNmwqP/ipRfMEGZ35k5IVWeFW2Gw3W2hjLDSqaOfjhk2C+AS0dt4c0IUeth76E/FzJR44LZzTSjRHo6r62VaJ4sdZneH7JySgA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(558084003)(86362001)(2906002)(186003)(6512007)(26005)(6506007)(36916002)(4326008)(66556008)(66476007)(8676002)(66946007)(316002)(6916009)(478600001)(8936002)(38100700002)(6486002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?tI5LgAm4UpnCVdETGHFZUEs1HrskzP/B6t/uUworwtx39gBpzNli3OQ2SmqL?=
 =?us-ascii?Q?XHOo9zOvgTArC5vxqR/OrUx4xSX0ZPbtaTJK2IHrwvPlETpqj97/+EIWv/75?=
 =?us-ascii?Q?NXX7Hf1sPEiWDSb9PR7w1osQ57XBS6oqlTnFmzsWtDRopFX4MzljdErBvntb?=
 =?us-ascii?Q?zH+IesS5LLQHyUaZzlx+20dub9AjAIce0lN3kl6L6rI8e5K6m81q44lzT0DM?=
 =?us-ascii?Q?qvXoAshEgNezyY+MFE9BeQBMsii3OhHk51/9AzG/BGz0SsTscGV2U6mwYVOq?=
 =?us-ascii?Q?cG6jPVMvP+7YrVqbg05msZRVFKCgAOwGPRps4hCfFu0aoqgNAFYLMpdj+OQ8?=
 =?us-ascii?Q?K7ss8TiDJL/jCJ+dohdFh+uLEmjQQjuc8CP+B0O6MgJaEup59MVVtEFBD271?=
 =?us-ascii?Q?UeTPUm+Di7EJvVaGdfwIG6xAxzIp3ZL2Hqig8ua0uXa/a1ggH1Njp9L6a8vU?=
 =?us-ascii?Q?F602Um4fAuNyAYgoWG2Z2H6I+9l5099/Yp5QHENw3u1Cx3Hyk/50sPOxJrNA?=
 =?us-ascii?Q?5cqEuT3Y6Zu7zKK0KHQKDyog6cKOydkK6SnV67FSwwD7pYAeoO1rZ/0HlvAP?=
 =?us-ascii?Q?HGkXx49GR+OLvcyF8ZiVrk+MrKFiOSyX/U0nbqywduKpHfAJQSaS3misYYLd?=
 =?us-ascii?Q?8MfaopqlsX1IHOf7kk3MnAP3b3bTDoUYzzfOy4sCpDp563qvK2gRQtYCRamc?=
 =?us-ascii?Q?sP/KCloYhROCo8nhqIuYwUK8ZbfQ+cOSBANH9SjEhfr1uSPcWZh5d07t+G8g?=
 =?us-ascii?Q?C3SQ09lcYhctXYTyRdB8ITR6M/ZKBYYvSPTeYFEjUPMcKZSKxxzbAqh/HYYd?=
 =?us-ascii?Q?cGh0wjDHifRQMO3SDcl7WYA5zuVWljhYX4uzmbrm8zleJRAsxNCMjfUOOOWq?=
 =?us-ascii?Q?41nwms96n8Qh6D/x4kz2RlyAf2iacO3oUeGFgRKYwKyaFnaqJKxJT+NSs55U?=
 =?us-ascii?Q?jcAJOQiJtje9hglp+MylwFWvtn6JzbqWlTtp1KWfrFhPgO8wim87dsvfPPkY?=
 =?us-ascii?Q?zlHHEj20XmUEwB928oi7m9IZNHGki3Z8vnF2qm3z9e9zhWm6KOOIJssxTfeY?=
 =?us-ascii?Q?DQ1Hwi2nWw27r8Q/Y9Eamnuwn0v8TkZTe7hPo8yGf8egOyoJBqvNBSZ3+9wx?=
 =?us-ascii?Q?FaVqDOkfc3Us2uqgXAQhKT1T+vC2qlcPIWPEICylE+P16mrVB18oCoRBTjbU?=
 =?us-ascii?Q?Dol9ni2I1Am8zV09PURP/vwABRyhoK3515w2X5tS9+9n99kZ3tftjTfuAwte?=
 =?us-ascii?Q?tga8pHkE/CKxZYbDnQmG9sZcVwfQ7cTrLLrY4Fmjg/2p8LOFqFaX9fDyhDCG?=
 =?us-ascii?Q?AIQ7F10hDL4Rj7bgtTRq+NlxqmfIPvdPVjh5HWjxMnr/w9hm8ebxDfe1U6gC?=
 =?us-ascii?Q?Q3AHVr9qggIufMWcEg3WyVxlg/FEKoDxNKfaU51s5ygise1eYHiCMQGK60a6?=
 =?us-ascii?Q?2hLF9e58oohpXOCA4Y5GOkjqZ5JYAxsUL5j9SrX65/lbiz9jBOMHEWC7Kmlx?=
 =?us-ascii?Q?4XqXxHmvnqecxDDfXbOHPGyQlbng30/Q1+aSIiL6Xv08oUSHxWcPgbAitOZM?=
 =?us-ascii?Q?Rg8XeeY88gPQoA4bWwMkv6q0qvpg3bPq127Sa3mjQTQvVtG9316SxiR0fKW4?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185d45ef-126a-4481-604d-08dac0e2b4d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:08:35.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7om9wOdeMTXW5BMAxPx9h7jyqkCYU3t1YGpaigJreKHPBnBLIheM8EBp7P8F4ISUejwi4CHewx5v5fPCSAELKPWgLvHDuXDdb/p66AuTAwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070138
X-Proofpoint-GUID: LYJZfYBZXSBr3cvdnIgbEqiTSuOHlWD1
X-Proofpoint-ORIG-GUID: LYJZfYBZXSBr3cvdnIgbEqiTSuOHlWD1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_090850_360417_CE5E71CB 
X-CRM114-Status: GOOD (  11.72  )
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


Christoph,

> There is no need to have a separate slab cache for each namespaces,

s/namespaces/namespace/

Otherwise OK.

> and having separate ones creates duplicate debugs file names as well.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

