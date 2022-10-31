Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB4ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xyf7DYwbJDiDwpPZ3sjhlvSNKkRAxYsP3/2HIvmyPV8=; b=QWA1bK8F/NZoV8m9Oe3u4J1v4w
	YHh/o8ImJZ0vcTZVMP+U4ZTpq8aj78+BzoORi0BT9uFhS/YPEs0jjviP+WOHKGrodsk5K2DUWpqzv
	QsK2diErFBtlvNMgwVN0NNj3UIcoVXzQJQsQoiJ6++tFA2WU0PMW1TIh02e1PpSRrca33yzySvpc3
	UynvoekL/bCfvSALp1/86ooMUl5BkO29ZBMNcNq3qsBILfib3dxPnG+HFmDyxLdmalOzub2rXQs/Y
	skXfPgNLtiCDz7vMosG8faJQnBFNYgRf9bgbkYj3vH3GiSVCOm3fOmASW3PKBHuip8erP2hqukQBv
	H3PK0gYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opWBo-00CP8p-5R; Mon, 31 Oct 2022 14:55:00 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opWBl-00CP6e-Qy
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 14:54:59 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VEs0Rn018586;
	Mon, 31 Oct 2022 14:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Xyf7DYwbJDiDwpPZ3sjhlvSNKkRAxYsP3/2HIvmyPV8=;
 b=A8yC7//dWj6EUkvkV1A13EuWk3DL1aK0fAYGtRLDRNlKB3dtScKumNzPZeboYbqqfO6q
 W9cI59dzqWYGclWpcGrJZBtKS24FOGmWtybMQkpLuHxkp6mpJVK7ieap+1DeTRWjXgJX
 6ao6eMlc4ksXnH0Joa2z/sX8UkCW0h3dsV/qjG6TdPiy3Lni2jJf1N/+c57fV3kiFMik
 siUfWhL6wEbGbkMaGJ+f019Lx4hH/McrFQ9pOGIMdEa79PempT90Kk8ElPa/uKZdy+NM
 vGRKgqnwi1CnkxYtp66OvpaihRfVZbN2cIpGKD2RkyffBPS5A4nVFKy3wvUbEuSfW5SI Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgusskwrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Oct 2022 14:54:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VD9ue2030922;
	Mon, 31 Oct 2022 14:54:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9ddw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Oct 2022 14:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaSoptNtWoLeabZMSDokki8OkWdbAKB7ov8CDTLBvmBhyW9RMx34uMfKDQfQubYIxRga0BvV4WzuglmSVvOAuSQRPWht1hS8YP1/D5mwaCFBhK52y9BWEZbk1ry+otx41mxTPNqFGJROkrWhu7VSivKBplll0+LTxb7pwdaBfWSpETQR+c4LPorMbRZQkroRNSxhsfCHYDLOwywK2D3SUEJlILhaPAObyBfpZhEELB76Llt55x1dyh60KY7D3lMekR7FEiHgjERN3hxaTfqfCu6S3CM9NsilVGwm1dA89k1ruL+IkwdDvLqGGlent2qLwNRDB6dFISrbmUxO0owbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyf7DYwbJDiDwpPZ3sjhlvSNKkRAxYsP3/2HIvmyPV8=;
 b=JkVIRNLDnquQABE6hTy2IJNYWCHvMkXl3WEXDveLczG0T9o+eNYTuDo/jPia4lBWAP5zUaLW0r+l1kvC1LdIskazeg+aU62ssj/NoFZBvYOqni8pEgj66yrQfSkfPOecMngbcFYqLQBV2nmV0lEm6LfwexR/iIxoldaBQWak9nucIvXSTvvueW/3wD05udWG6g06eH3y5HrqqYYj4eaYe/CU+p/ILmnrOB4no+b5Md3dwl9qN5filIN8WUKF1fw+UbRSDkfwM4sqZ46HJrLiJEy1cKK5AryQLSpQ7skL7+BtirR18qVe1V9d9bMQ5/fIFjFOnZXvqtNhy4YeatDonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyf7DYwbJDiDwpPZ3sjhlvSNKkRAxYsP3/2HIvmyPV8=;
 b=GJry6xIfPqGw9HCyOgu/HOKFFVLxo7wjat4W1iI504RYU4Fc+4rQ6kANT+xzLW6WY/CeStyGnjVn2RKEudHSKlT93sChx0Z/rnxchdNjpqFz6iHyP5UgK3mGqJ7b6JkTY9aqQxdY7IHMTcwxEibq5dC3Z5y3P2H5eJw3Lv0g6Oc=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CH0PR10MB5306.namprd10.prod.outlook.com (2603:10b6:610:da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 14:54:43 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::13ed:5c00:56c0:93c4]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::13ed:5c00:56c0:93c4%9]) with mapi id 15.20.5723.033; Mon, 31 Oct 2022
 14:54:43 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com>
References: <20221030162906.3390-1-hch@lst.de>
Date: Mon, 31 Oct 2022 10:54:40 -0400
In-Reply-To: <20221030162906.3390-1-hch@lst.de> (Christoph Hellwig's message
	of "Sun, 30 Oct 2022 17:29:06 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:5:337::27) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CH0PR10MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: bd722e26-09e6-46f0-21c7-08dabb4fd81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	nRGJm9s6KAImOu7X45W8ulzSZaN5K5QelDeqQDqcBmvFQ+Qwa1qqORBpbRylluStVvp2RnXrZhCc8Pjs2xz365p5kcII1z7IRLF4blvmA2vtrs4nFS+VQxgF0W6Z5bFK9fQxG9w2rXSvPCzkmmEeeLwn+fYLci854yUzZX0agdudAjBPEXGRWPrnqL2bYO3ajxwNmg9YRKPCY+ZRh5kw2F5A9kvx3UZR/BUmAkIYnUuFbRfouDbqu9usD4x3D60/9EvKDk5nDDtZKlqztCmltXixPWLqrAQ1fyVhOzDPanSffIPe/grjIP/QTww/46G39viTiHSJD0MKym/VNLgGmLsbflAp/z3QgY/Uwl1bZ5LRyk6w2U9Sd5jBQFKoVtaNH6UGDWErSnjbOl+qY8+RYS5cRtU0mp+evHPpAunDq3dFR0J6fH6VyLmHcmlwjb0sxPnsU6HSIERn/GWsDFvncAHozlsQ2l6hnBZguAMoQ3eWfBXNe34HBvujhRJEmlhnNO4z7/NlzrF8IuyDfWC2rmUqOiuqVlzTpS3LVVTGk9vpklvAymZvAetryNTf3RNJGU7huDvpe4xH7LJ1QWWswVbqFMR3gmc8ANCZasN1EXPUnM8iRJde5OGY5SR/SgxshN+s+mm1TvlDGnqHqJGlB2wsiaY9KJgfqqcxHLCos42qd9MWGIPq3Nj0ROfwoGYOxtt0dh9fjuG1kfK2+wMbMw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(6916009)(8936002)(66899015)(8676002)(4326008)(41300700001)(66946007)(66476007)(66556008)(5660300002)(4744005)(478600001)(2906002)(6486002)(6512007)(36916002)(6506007)(186003)(26005)(83380400001)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?M7w8jIhVyM2AJL7Si5jh6FaXZGx5jBy3GfXxipGmYS3/cYlhXYuY8KACPsaQ?=
 =?us-ascii?Q?BcnXiesWX2UMj7aXYARbfb+kYi3YR1I7fZhszITmzmOlR/PiLIQGtTxio9xr?=
 =?us-ascii?Q?xFmFVToIbUtGdtdRdtMzebRowTaCTNfRde4A+LctvV8svk1khvRTXVH07wkd?=
 =?us-ascii?Q?28M3AYgPl/0Aif97y7beIiWw/7dKzNGSXxhiVfAuTyi/xEOQ1jn3ERdrsZ+5?=
 =?us-ascii?Q?zP11wimpG2qZ/Kbu4lEzXMTCMw9IXEMWQAiGA4jWlnFq/2ZvKd1Jh5EMCWKU?=
 =?us-ascii?Q?naLebGf+bBr9iqY7zFqRoAmsDlUYjfFtaN6NfMU8EeErf/SgEHLVsXQ+aPr5?=
 =?us-ascii?Q?FwF+poOvUJwybLnNUHC1i5nQaCWw118m15svtG9yQceNvVuvrioiM3JqZOaa?=
 =?us-ascii?Q?MpSl+HnorQH5chZSHFiEP7fQVy3N0RScd2myma7Wdmle8CfzyLSdyW0Qbbjj?=
 =?us-ascii?Q?J4ObkzXofQFQoi/Vv7V2XaFdp8n+S4cRjc69M4yUSgYSImIpdYGV55g40/fI?=
 =?us-ascii?Q?UklXzGxkD2E0lzYZmADo/m0Qhu92DgLW7ZHhk6x7C8j7c723QQapGFAqyIWd?=
 =?us-ascii?Q?022ydGgVBbt9/aF7H7tfi0+9Ueap3aCoPxNVIEPAyta/RUf7kP/W/rDNxz29?=
 =?us-ascii?Q?lq8G9v0rPd/TX2GLxyNaouZ7W6VJtjIMo9F4FEd9nq71rI/TKGzqNuXOke8x?=
 =?us-ascii?Q?09fcaUdGp+9lCJTbOhDsYxcX3PBY8G6S+de1ozPbvFFbCMu7ynCRPsJD1h+q?=
 =?us-ascii?Q?gItDE3Y1eJ8DKbYQ81CtNN91QqXZFBhYSuX7bn3TFUv5YCvmQrtcfRtTCjcj?=
 =?us-ascii?Q?P2Zu3TYIWN+irJpEfTc5B0FNDtZhzgAFHdGVIej5hXMZmcz0cCy9QDn4P4ta?=
 =?us-ascii?Q?S7srqzeYJcFPAMvkfkUAz5cwwnNMJzXwEMsXlvtdR7Fa/KH52YHz+cDqpnLD?=
 =?us-ascii?Q?x4i+gNmjkJy1vu7rj+4OxYYf/WjJ0eg9RF7SR3UmjD0GiAWm2vFOvnd9nTZP?=
 =?us-ascii?Q?Nkhi+13qSdXhEUGdoX035DrI6tE95vuQNdQqHYwyFy5c6b415e6I7/ztGkfB?=
 =?us-ascii?Q?P8SpjFxWC//xhf2yApZz4cZKOJrytb/XAA/S1MQAutxYdXdMyoOhl8ccQKAt?=
 =?us-ascii?Q?VIo1vAiGFd/jWvt4wZPOCyla9EEDzLtMQKA/wUeXybs9L2bLGmcESEwcpSfN?=
 =?us-ascii?Q?GsyCBcl+kax7cgFLFaop3kLWZb3R7HLCcXP8AgGosO1P5miVEUrhVl3c59nB?=
 =?us-ascii?Q?zF6JOeBYhedZl4nTPa9/fKzFB+fBmuZbp5TRsPaSGvsEmhggn4ROVApgIAiY?=
 =?us-ascii?Q?KLQsiejYS0smfrvdNq3QmIV00881DygyjN9V/IKYA1SyaJcvfaLs8c9WqL3S?=
 =?us-ascii?Q?XfGseOwuQanU44NzZK5gGY61NuS76bDBNA0/xLso/IHsvUPPnHpNjdXbvTMF?=
 =?us-ascii?Q?fjjMNuYEsRiamt82YmHsEiJc2JR/cwPhR8s97I7GxtcUIxngl1OIMJTIX/Bg?=
 =?us-ascii?Q?GcvQXhT/4pnRWoZdOvSRhnM4wCDuRllUMcXCR/NBZCAmJeA6BMBjgATFoUIw?=
 =?us-ascii?Q?H2Y8Ks96rjUhQ0eGdDAUx+7tjRqtoFIS7BQHnuiY03CXNjRe/Wj+NZVOFh3i?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd722e26-09e6-46f0-21c7-08dabb4fd81a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 14:54:43.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1I6rV9Rj7FZ9eiYN68AeNacznWtE5JkydjaVQhOFLSRPNdhuZqeBXzfPZ0+z4hsdIXbnU5bQabfsqrgQIS7VfaikVJOp44g5+mA69UH/ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_17,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=847 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310093
X-Proofpoint-ORIG-GUID: sdUAZoR25WeLPiiUshc_66OW6gTkx7g_
X-Proofpoint-GUID: sdUAZoR25WeLPiiUshc_66OW6gTkx7g_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_075458_009106_4CF3199F 
X-CRM114-Status: GOOD (  11.57  )
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


Hi Christoph!

> +	if (!(req->cmd_flags & REQ_NOUNMAP) && ns->dlfeat & (1 << 3))
> +		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);

Shouldn't we also verify that DLFEAT bits 2:0 are equal to 1 to ensure
that deallocated blocks actually return zeroes?

Looks good otherwise.

-- 
Martin K. Petersen	Oracle Linux Engineering

