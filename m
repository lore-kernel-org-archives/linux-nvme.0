Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AC4C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ziq1S/JbTL9mvB7G8t0wqLKmVwfTMsuM5DWtKovICZU=; b=fGuCOt0UDaEimtXeXC3GfRgrFq
	uJ2LkWaamexb3L8Y99KDHnfa8tNIw6SMKWkdhVx4PQj5jjrYIT14yD60yYndZQKtq5NUfSwsxrqLL
	40GcRl1IhZ+iqBql/G0/HgOe4jXO0av3lIokdCb4FW7BaqXkGbQ2Z8+VLz1xUEBSjbqn71ABJTVER
	6H2dx8v0VY7Qgndh7o/gZeJQ65XFf2oO6C8hKcG/dHJ2dGHdjL7UQjjgRpuoaBpNNTocc1YbRzQxT
	RAaleqM8pU3geKzIaudtdUtgngHWAg80BXIjcyTEbMNr7SXK///vXsoYvSFP8gH2gYqxvKpAs02Of
	o8iBMbIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgiqC-0000000CVgQ-0KQM;
	Mon, 06 Jul 2026 12:54:28 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgiq6-0000000CVdh-3FIP
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 12:54:25 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6661PijS1350597;
	Mon, 6 Jul 2026 12:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Ziq1S/JbTL9mvB7G
	8t0wqLKmVwfTMsuM5DWtKovICZU=; b=U7+kpkuPfd6FGujtRghOYM88+b4uXdif
	EPP9UsaKgiMsSDLASnM4sU6KPlTTNPeKVtsrrDtVKiGbT7sXupIzgIb3wvwDpqx5
	QdlWUjXdnjhiNdmwH0uLkGUvh1/b0wsCbLqcjj6r5wYC5K2lUPF8QaOC2mGmF9rt
	LgyCCqTSAwEcqZf2UcTNyI/g+dMUl8v2vvCKZ7Ao1PwgcVKfhr51WfbEC9Zb1Eh/
	aCcqx4KoJv3tOa4gvwRl5jkH/QT2dRNDb7nBjVLwRx33rubpJ4WZLB8KVpur5eRN
	Wehjx5rThbBoKJwnYWUTjFDuuLqDwQdGgailLC5LBNT83Ie/BHoNnA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6t2a3f5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:54:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 666Cr0ub031174;
	Mon, 6 Jul 2026 12:54:13 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmcav0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:54:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx4Xpo5GWeYYAthkbPzuaQJ6llxKx7stRTZcPi8UdOkgQxlElHBiHZnnjHvB2MTpzGA7l75N4zun0kTYpejN8N+JDJbj2aI4Z8fOWdV8+nUGgdUDDkJqjUUEu/me18LlzNYZAnA/Y6zGUzYjLjS1oXl/BWyIlp0sis8inP5OO2LUrxXKCZLGxve3ZY0CXx766+q8cFPO0kUbBr9cvrF0dHV+LgaCsvIINdNFcfshsVBPVBB+w0k5JflGVEpX0YTn1nnMKqqLoSsM27QdVvnCMI/IL+hxFQ2H5B/01xASJREZal4C89C9OKMMAYMiz5Z7bwl0r+UVn8rTYHSrzS4G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ziq1S/JbTL9mvB7G8t0wqLKmVwfTMsuM5DWtKovICZU=;
 b=k8zOSJhfmljbVRzozfeCz6xfCrDFSIz/XrR+cBCayH+1n8KQCQYvjU4oUDiKd16q9oRd5tLoRnrVaa39XUC7s7tYXie4SC7RmstAZ8LQiduR9cWRE7S49+0vRhby3mRFu99vFR7ZO+cattCtaVJq0Ilao+doLrRFp1Gorm4wkNGVVQt18I67GNK0s+nJeB4f+sch8c017mYqq7K2e1r0jYXZswKutSLACn5wlPFsVcOWdDMaHdYrsP5QE/Qla9xMWq2cotEY5NmtZCmMPuwhbi2iWqzHxUz9bHxKPDuv3fyk/OhTy3qA5mAcAQgk8if7wFJ6QPCUvY7APabdOdN8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziq1S/JbTL9mvB7G8t0wqLKmVwfTMsuM5DWtKovICZU=;
 b=HN2albHHwAy+RkrQ+FKBl3PaWqU+0lU4EgatzRwHQTmrrfF0mfGmeH9PtZPgEN1+1SsBcr1XmF7aMg4DxF3RN2LDE4/vqMsFvk8K2Ij25u40jXLQhzxvbVpbtMEfJzWUvAbR/4g6Wyx4RrTdx99fQpW59WBHuxNFt6YitPG3ukw=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:54:09 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:54:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: don't reference NS after unlocking in nvme_ns_head_ctrl_ioctl()
Date: Mon,  6 Jul 2026 12:54:02 +0000
Message-ID: <20260706125402.615277-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:5:174::16) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc3fd1c-f9cc-4adb-9353-08dedb5dab8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ITfs62a1KIC229ayDpVY3LlSsHp7zrgd3xuqKClyQvzDxQivw7ec4CKdqmucoLY9beGQNvRX5YBFyhz8qrqJlPR3i5UDfsuiSZvaI6rBJLe44i5D47ZpWfTHW8JQ0AI+WpEqzPhNLzMFgb4YsEsC2j8wvpMJ0eMWTyUM8+7/tKcHuZzA54hCG55LX6aNcS2rz9/vvTHuMfMfDKLitF58y09AaoqGPq+SgVnPv9zNm5q5oaGpu7Q9rmLq7OAvue1wqVwzbrgpnsyegkESlVOEWba9ogO4+5gGNSf6uhPy9JQcRoe0mgtbTIkZb1ogGYYP2uMhA0v5pRWIztpV8WzG8cAdC/oNM+9emQCPpABTujnmlfPCZ8/J6ESESltZ0vkNM/PYnbINpXHXEJw9cMvH91YnWLrGkLMJP1Xzca1Y/4aOlJNsXmyye+ydrax5pksKzzT0aGl14Anqs+C8EeEfVfTOH3QOIWBT/+apdx5OBpXAu5s+FogQ4n+aUt2GCzpkILPUZPQJH3B/Wt7V4vhMRyB+bmigPjV0+412c8gGX42Prp2XjhcnOSE8FN28SYUnNSzgGRSwLQ+IH/vbPGM6vA/rLzdKbCU2N3JYQopCf/ELynep7kaymvvrbpRZiHp7bOUVr98mLtnSBSDLFi+aIpl1Iv8io1tpQzO3MwdThT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?moZceV0NmOlqjnWgOtF4uk5v8EOzJjixStWbBfoWJxKyobayQdMm1O6Ff3jZ?=
 =?us-ascii?Q?XwGDhxc059WEcWaYorPq5muuHOBY0GW8eGt1LwfT9wNwSPdGnqsSwVTUNo6K?=
 =?us-ascii?Q?aalH6RbuC5c6MnmUpNi6ot6LGtyAsiwlCJrVH9HqCUOI/+G7NrNW7NCApfT1?=
 =?us-ascii?Q?qMRdltz+dJaRNjueqIIt9CJ5HXnvurqNyf00RlE/1NaetsD9W1x+XRhfV3DU?=
 =?us-ascii?Q?Djk3HW3ltnRDFi8yifbbUrKVychmLPy8xUdhhRT0e0g7TbUp8DaoTJdFJE/V?=
 =?us-ascii?Q?rLLqOtQm39V3lLFtdZrZcGLN9BullOmGz1W1QtVGo361DKGUpfcaZxy+Mk47?=
 =?us-ascii?Q?Q1oy8tg7qM7O6DNP36Rjh72VVrhw6Ja0QCmzctxIRppLp6dck1AJa3SPR/3Z?=
 =?us-ascii?Q?FcBff/m6cFHVxwAA0jOH1MvUXTrLgju3qeJofTBXkeS7eLoH1IYZHtSpfBB3?=
 =?us-ascii?Q?jkakG+i2+3zkDZ9wXUPaoZG3BHAFdKVDRRTX6FQw3NqdNnnn+EmOZAmf8Kaq?=
 =?us-ascii?Q?uFJ3HNpXZfuMqsV50ifeBbg0NLw9MHVQLcM1SuE8WKpFcq4WvBg1ZFA1SRlT?=
 =?us-ascii?Q?ppoprF6F824MRRPD1XlC8aD/quKw4SyX+vOtpV97uUAxQS6GI3g/Xx376e1F?=
 =?us-ascii?Q?JtsvfYNRsXPZqzGAJaigXiPBaX29ox+XIyTi5RHGBVYBzIh+5Tl+kZ1btlBk?=
 =?us-ascii?Q?F0G6XAPpLJgxLhl2FylTw2sEViVx/VsScqVvumaJ/E/YQCX0Q98I7E6KOeBP?=
 =?us-ascii?Q?cSNJe6j9yQ1w2LSwjAIYndcgGsNTl+4d31o7OT+P6e22mEplQ4N2CdrC3jVX?=
 =?us-ascii?Q?rdh51naG9wPTdSzUe0JuR0tZcpBZ+5NR9Grs8LNqn+So5Y+1RKiQn5Bdr2Do?=
 =?us-ascii?Q?QVQZpcZdVLGgyx4YwMNqDI8/aqv79pUBMoA4JMd/n3FEYapVBeyT2N7OIIsx?=
 =?us-ascii?Q?VT7m6rsW/lnNXaR1Lr5/rYY0fDPSdzfJyjiWujaoUFTkTJMYOr+y5NxOQeSz?=
 =?us-ascii?Q?ppo0DfGvdHNdw1fdURQVOEXoxM4MlAqoLiDA6BW7MsG/G+k2cZdFvnkyVsXQ?=
 =?us-ascii?Q?p7oKSdz+uxwpwtdIoIjOrBfrtx2z9mkBTlvXGrmaqZPRcdPLB4K9I1qOHvQJ?=
 =?us-ascii?Q?nlkEhisDlmqDuc4Cy4bH0gMmq8Bw6fOG4yKNqxJoygvbuu6WGBwalxYUFYyS?=
 =?us-ascii?Q?TsLGTvHK4ffd/WCatue7vDVufriOCQoUCCaCKua0YQI2t6YRGznYM6u/Mk9Z?=
 =?us-ascii?Q?L5MHMTx+sFbo6xfX9dvJhSTbGnTJpdurxlIOqh8LlUBhzZeaulyx+uj4lbTh?=
 =?us-ascii?Q?8e7RNxaS7hvq0mYNS0hob8k6Gk4nL3OBIgwSv6O1wRHcRkUaB8g+N1ZVpn2X?=
 =?us-ascii?Q?6znhXx1ia/UVHcCDIa3rSS1XUsVpJkN39K+RJqkNunHh7+v2LnTIyoskGj4D?=
 =?us-ascii?Q?zi4YAsoIOvM/NNEQp9Cq/5nFSXgXFDvVF4SA+H7EnV/+MI9I1yhPVP2/qnKU?=
 =?us-ascii?Q?vIDFBgzy20vbiqF0cTW+/1X8VSYhzgGgwUxOQ0rJxU6yTV8Yn/EqyK6Yj+B1?=
 =?us-ascii?Q?3Wldh1ISGAqHCyDDK9vLXy3OAbD1fKO2Mi7DjPu0VrlHxSNqeA+3UoEuatvu?=
 =?us-ascii?Q?V8o8WJk/c5sAmuyNOgIbJG5aXQMQY/v276Mcxxmv5mZAtokQ3gHenvqHjwWr?=
 =?us-ascii?Q?65VyibCq8CA79YAzjD85YSgIcHIHv1b3IZdHtqx/XcY6cqTSZwfRMdT1iKeu?=
 =?us-ascii?Q?vtrTsnJ+uQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: M/kCu8/NgrvaGaugvPagO3kDzt7Hy295OYvxV/htwjP8352/OCEEdWfEtdNYfucdyIZfFIGvsVUzm0ZDr7OWahY+xeA9fyrG07trnewXMXXndBY8eA3CRPDWI2gPIcb2OgvPPSxn9uOxRMbbMKwTQvOgB1BZmnSIQG9OoCPX3EYy7G6NYbgQ8hJlY3dPfx9U92VNlUGTNmzmEKGpW5KDbinQIBNFa+YMZvMiBchKf6vBrOhyBX9GWvuocBsNExmoOOtUmpu87RRKcIami8AJ173X1Z7XfRNPhwmhJswL4pTmipjNzWOFvpRaN2oSphHRsNh3Dq1D7swjXJNGYMjLbQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uAidehw9eaJpXsBouhbMjWHGBQrJHmG1aGRcMnKvU1TbTB5vWQRfSZ2zhOwS8YsPhL40SpJmvDxewUaQQvRyl4mKFtQiH3ifRByHg2e2sESGHc4ZSXBlniWeo8ABYOls+QTN7nJSARn3Bn1rm6W+222RWNlTHz+4piJZSePCjmN9WxACv4hKHH3CSeIUyYkO1OT01LvydTlUlfW61TCRaKkOtOsTi8H//b0rgkXOpYTRtv9bx6MRwWyNb5LmPSgD4ku5ZcYzY9B2PRZM0OxVWFF9y1eKnf95HUx/z+gJtUWk1+zSktQrrviP0kkO9qPaLoMUuUrraIY/Fi2bn29b6ohyFDqhiWOq2mGhcrpYqpTXPjPVMRrErTzVNBiV4VoaMry5ZoOAKOlzo9Lpk7FWWmU9JLK4HpiH6WoAKb3iwDj0TfPVDUKP8Yn489r/Xyq6dTXx+lOwv6PjVKsYr3BqbW5t7dxYOj8T24hDh1IDUivY29w/atN/7Qaujdnos3olDUeLqy90KWTjKsFNCOOZ+DXwVR+zLOU1r2k+XxSWHMQ7LId5F5OOHjfRli+qZuELSXhcO3/brfqMwaR6rHsv8syJ3LUyVC4dPzFasiBav9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc3fd1c-f9cc-4adb-9353-08dedb5dab8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:54:09.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGNsWOLBSXvX610cUQ5wglf8HrsTjxXvi7+LY0qCia5IcUg6oAZ3lmWh3k/F6QN03Xk9CccJdZCLSz68HxiBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=842
 mlxscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMSBTYWx0ZWRfX1BvGg8Zk0nSL
 5GcW6fabnk3lkyRdEmPQjyz3i1NmPkOZvSHIme05s+/XqZAN/54B0JLiFSCrGBd9+F/FFM08yB1
 xNz8CJbmINK8ykwxtWDllAwRA1N4A0I6XhyaQu5m4/N2FzjM0J5ZqQB8sxWuXQDZ5lbbuuZgBt2
 I42jLvIdXcWv4/OkjRPfP/dfOCqHAhzV8B5T4xD3hp3yYpEWQns0z8hWFP/Z9L1Ibc3GQ5dDwEX
 lCrJBnuVu6bpmHK+pb/ldUYJwAuPnvgctz7HFEhtNHsD1CAEjDp+qp6SwLHFVWgJy1Dp5z/8ZRx
 m3He1yT9XcUUKcRq6Ng9pDzoRVkAaFocpxm5LyQ/QBxW9TjF/8KzKFoQXv7WL4E/1WPIgmZeOPO
 waj5qAvpBkoNK69X0fiVOwsbIxCTYQSIuPHWuTuwQCSt0PheIGuj6ucZ9lZjWs7uXXL3g7StWiQ
 BiKmzPqxYwj/KcAV4OQ==
X-Proofpoint-ORIG-GUID: 5IAXG_DExXSuCxxiTNcvUWwhtukX_4Te
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMSBTYWx0ZWRfX7KU0an0NO41G
 SW3GLpzgOCEq/EN8Gjbdeyh2wCTRF9BY+ncDrf7TyOUo2hRCiZBb1fbySIx8zWZav19/cmMu09D
 PJgg5TkMcoCIsnl+T34iF/TA7vTUDGNsmpykEgf1AQAHepEBM72n
X-Authority-Analysis: v=2.4 cv=fdmdDUQF c=1 sm=1 tr=0 ts=6a4ba575 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=hefOv3mhlJ2iR-t3CqoA:9
X-Proofpoint-GUID: 5IAXG_DExXSuCxxiTNcvUWwhtukX_4Te
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_055423_079568_7CCC08FD 
X-CRM114-Status: UNSURE (   8.93  )
X-CRM114-Notice: Please train this message.
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

In nvme_ns_head_ctrl_ioctl(), once we drop the SRCU read lock we should
not reference the NS to lookup the controller, so use the available
controller pointer directly.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 664216eece4a6..d5a8f375953bc 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -699,7 +699,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	ret = nvme_ctrl_ioctl(ctrl, cmd, argp, open_for_write);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
-- 
2.43.7


