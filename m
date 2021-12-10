Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D867C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTSUjkycDCsSx7RNpkGWlp/DABpaTGm/4OjOEQSI85Y=; b=EEiXws5q7slFyCtzlxGPEpLaHj
	A+8CSwlPJWInOEr5jAXyKD2x7FlQEERUZwVUD6Sp1j3VCc4WiVkoEgHoSBZR15bEA1ZaQj/NtOJ2o
	PwN2xmgffB+lI2aSP2ygDySiFfnlxzDFPN3311iTjtcdJNAxXhZnhOqBtyXFcriXZsYNyZjtFMouN
	TiaI8Qvr4QjaXsKKrBclzI51/2EdGTqSx25w+C3iwApA42ntaaqN8jO3cJUdDG0taBCOxJHGOaW/l
	mP3krz+b7oBphSahRoOP7qxcvsW0OZMbMQq7iTwftGLP2vYp52sLDXZOxk2Y3WjTxVKhMMAIfZhVD
	u8DGKMcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mviEh-002Wy0-Lo; Fri, 10 Dec 2021 15:55:03 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mviEf-002WwO-BE
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 15:55:02 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAESxmg031298; 
 Fri, 10 Dec 2021 15:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WTSUjkycDCsSx7RNpkGWlp/DABpaTGm/4OjOEQSI85Y=;
 b=A7wg6jMt10ce3/gFDMrWWXb2P1EHLeWotiCZgUnUvx6zmvTcNFQZsWg3q/XrW7Z6sIr8
 jsuVhO5L/QHqyyxRFfjDlzIdfX0HciT7wxEIW5qcb/wJIjX/dL79X9IP26XA23DqR4Ww
 ZpgXLbOa5pTUrjIjs3csjBu7fanqk4dPckAZXEPV+ieRcApXVHZd2E8n2szqoUdXfr46
 ooEOrerIft5GAkBqTdJzk5icbeaoRAhuqjrmEIhk6n8Gy+XiZZJAITAijxynR61BBMXW
 7lh1V+HjZNTOyrRMXRMN4IocoOgns+HbETd8L0e5dsCP+GgFRwJGum4r33y9yl4jHA0L gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctup5663t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Dec 2021 15:54:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAFipUE096950;
 Fri, 10 Dec 2021 15:54:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by userp3020.oracle.com with ESMTP id 3cr1sue8ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Dec 2021 15:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1A8MGEJiInU9jPD1g1PUfK0nbVOnvzca3d8mrews9zPBNQZntnAbfHPtcM8GP1ZuhxqgOaTyfLpuwTqtIJw33cb3ihaEzNS5auL3eHDSDy7Eqx89i+y0Xv31mLl2FyldsRBFDQ/dqYjUwJiip0EWpZkdgG40EXp3BMnrVexUZEaEEWEND49OlUn5CXMmm4aD2T82qo25SU82t5xzatkIur/EODbiUBBTOU1wffUIIlkEkx2Sk1w/pd4uvwYVi0fxrzkmPLiB8/n66ecgieqSLIbiHgIHcPpZGll7THxFPBCcA6opJZhdNMo9OmIXOxj4Afn1kxHNFmrWBxrfpJCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTSUjkycDCsSx7RNpkGWlp/DABpaTGm/4OjOEQSI85Y=;
 b=YqI3BXdo+JHMqP4OglwhdXGDH5gC+WNDgMvXQjBqCJInt64HlroYGV1+HlvgaMiMg8SrubupEKnbbvkkeDl/aL9nVFhtHhc41mfkCLm1nR7ZtxeiioCvnWnGFxusUllneKOvVGw0KguWsH9eL3eMN4BrfBd/fdrQ1v6bxLvh1yhL0OXc3NDTcqenDv2wls4xnn4jORGoJucKinppjDSX0kl7Nilg7d2OwTqgL7VXD1eqxk4XWkUrXBVsQ1YNz579Wo7XMs7yBW7nJ1k8H0LzfhCiVd8fPM6UlSWU0OJ1Z2msy/vJEwDyltOcvPpfMtGLRqZym0BVdLHWX59/fVSQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTSUjkycDCsSx7RNpkGWlp/DABpaTGm/4OjOEQSI85Y=;
 b=mk5jAIAxnDJITFMqBH4mtWECTg3J3gmyHSgrhB3omhR+xwolUbOF0IDjPte41fm3V4azstHTfANHTMEcE/cLnFA3kLboZThptlNM7QCqu+eLTI8hsEpzrDigJgRiawwJUGVwpFIS+YnpRcscuwunCgqgT8UbiA8k50jxuzZVzYM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:54:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 15:54:48 +0000
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Alan Adamson <alan.adamson@oracle.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
Date: Fri, 10 Dec 2021 10:54:45 -0500
In-Reply-To: <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com> (Chaitanya
 Kulkarni's message of "Fri, 10 Dec 2021 11:36:38 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:806:120::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f10b84e6-f5bc-4b2f-2e22-08d9bbf56435
X-MS-TrafficTypeDiagnostic: PH0PR10MB4454:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44541097AF6F7BD1A290FF508E719@PH0PR10MB4454.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMHgeYLxlhy49RMy89uTegYBCFZL3HtVe1+epqQoPcW+k6pag/wTQQYmf0ONQfpAmQ2/O2qeoESZHbirAl3+Ucg9ARrQp8hAWPIG+pudxwFwCQwWC3Jo4Ec7gmyOukncXrEZWGruvbxqRp1LcqBEtK82hOQx8j8nruxah/jgKeq/CEAJ2Vi4buIu1xTmk+ijt3qroH9j2mMM02Ro0Ur19bhiC+FXh0MKC3+yE2sByUBakaL7UfxOXvAmgn62VhsRpfpPAd7On3GRuU7hIAk1SCV6aQSfKxIvGc5EgkAqG74x7goO9CBkgui9VxtxaoP8r9cJVVH91ENAhZBqRqaIfT48kJiWJ9qQ3128GTdky06Yn62y+0xkuVASjNEyYz7ldF3nhk8sGNowa8ZLnrJMb0HVAuH02xae5+eXl2N3owFz/xAwNduhdgOYdFimWQ0pxRN7zk0b/P42eTc/tQwu4moBYsZGSE40hqOGhfmrE/IteJMiIWjIRGIWq/f9X9hXPmUQphTuUvFOGLGYhKtKUlmHQ8/VBevaVF2woKzDAPaHaD+rN9cKPLkjnN/BtK8b4nMha5UQKcBrimSbcYwMS8Ri6SCqH9cNyLkGulrfP5rYp5Uig2WBB4gJKRFxd8yQ3miof3HAoybTtOPIrSOLZhnDrs28t8aRp5WuN6+AywUB3kLhYlDVy9pM/O0Ooe27nqqh9fVJBd97KUowaLqy4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(38100700002)(186003)(26005)(8936002)(66556008)(86362001)(36916002)(52116002)(6506007)(5660300002)(8676002)(38350700002)(316002)(54906003)(4326008)(4744005)(66946007)(66476007)(83380400001)(6512007)(6486002)(6916009)(6666004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zRE3mxYYZj36CrEOL/IJfBGHePQX9KOeZ0cZDzSUue41sKfNklRzjYAfXA1?=
 =?us-ascii?Q?gd/6JOZZUb92c2hvaL3bJ/Di1XcTJRmmbu4BH4ahsle6UBHOm2HD7y1L5BvM?=
 =?us-ascii?Q?w7Kmo0KazBnN0h51eHc0ofRNmlUaaI1It8eldr/Q7OCfkKTNT6+tdq2z99XV?=
 =?us-ascii?Q?GTBoql8lFTlY8rrJOgfe04wqStc6j5laiAV0eFg2q0X6qlCB4/xPd38twvnG?=
 =?us-ascii?Q?pULOzVhHqgBdEevKXEuhlK7ZrITFvis6lHeshBXJ8hs5ky55Sbh6oeO3eHTI?=
 =?us-ascii?Q?p19jelsSoZD5TH/MTuDX9HKwYevvkvG0FDzwyjI9JZ7Wa9sIo1s7O4se0BI5?=
 =?us-ascii?Q?DyDfLMA+dLYaONUx32LMnzZeuF42qRZx/B3EUqN2/kqsH7BGWx/gae/roLal?=
 =?us-ascii?Q?29tRUr5aHkfRfIWVuYIiZBEDPFWtVlsZtqJhqfKiENnSFE0+QNEeUUXbiOYH?=
 =?us-ascii?Q?iCbpa507LivOaFA/mlYj9hvbR3HSC8qWmd2SXVZjM19HwuP0zwwQ6tx9iqBo?=
 =?us-ascii?Q?wkuBdbwoz9ZllG5rlgdPYDxyG9SVs500bGHJ90jFYqd6F4Qu+RnEOZL6/LE5?=
 =?us-ascii?Q?hHtOKn3D2lQB4w9XuWKUUw6b9VKGaQInzNcDDE46WUi7pEkESTSN0fVa/VER?=
 =?us-ascii?Q?+O5eKEwLNnxL3w0vvgVhGfoEsvHIIGWAox53fgT3qVMvmusvFDBLup0n2Vwn?=
 =?us-ascii?Q?z0MZDq3NYCnhXOUJFGihv95/+VyUQFRmkSNlj46ExtKbd6p/yUfbssxSVmxI?=
 =?us-ascii?Q?bFbsux7uzUVuE4EgkaHRQWA9jITpvPqxNCGNQ5XnA5Nw4cPd7L5MTYbthe8Z?=
 =?us-ascii?Q?nQvycY6AseXbN2arQZbM9tOmqHBC1Yz6gyeXDtM3yDvTCux1E+6woWDZXMyq?=
 =?us-ascii?Q?fz3l5FfiSB9aCGdLPF+XH44rTzqp369I23Yp2EbkiCG1YgIbZwr7GyUku9wP?=
 =?us-ascii?Q?pdWEd24f9bojpPldHcyS1PIPrnmf+FId3B+Xwh92fRRKJWsv+0ShCjAMQlTC?=
 =?us-ascii?Q?uqngYj4W4AoC0vsHxxuVcGJjUdsyxceVFbIpbMFEXNRUr2vckTju+ElRB+vX?=
 =?us-ascii?Q?9QtAuOzqNQOY7ao4a3vfVMqAUWKmpxnJGy40J96i+SokPpmWqBWdm+DJb9sd?=
 =?us-ascii?Q?H6+tFLJ1I+kisXJ3sSKHZcK3yxTYhoRWtX1C0SZ6eNmWRHsvMhlw2bvk9yv6?=
 =?us-ascii?Q?Kpk6MM4smB5KP7sm0RQAKg2zTdmVj5jHaf+N3mxq4jlbdmdJGvfp78ZedBnb?=
 =?us-ascii?Q?wBtCQHieomYHqvRvcbWZfo4JGhuN59V9wiroLSr9RZBxv8z/I7yYTTQZPv9B?=
 =?us-ascii?Q?WZh6SAOc4el+wFa8iIVlLdZcEII1QSXounPOhnoNQAyvRtgLRRG3jaYY4RyG?=
 =?us-ascii?Q?4vAQE3HF0qSqtLj6ux1pqqW7KRnv1/JnATToGg+W6T/1X4FaXTVXNLf2IW0Z?=
 =?us-ascii?Q?RuHQM0DvIWWCTP8uCDTdNJFW7/TNbaMTib4HygKIBfyFIZhgsTmeEuyEXFor?=
 =?us-ascii?Q?lp1tGvJlrMHjGuSr1lh2TNdTtRt+o2CZm+InYJ0e3TzEU8zbK6hnI1bE+zdn?=
 =?us-ascii?Q?ZYt8Zt1OpZiXC4K39UW1M5iQcX4OXk20TncOqR8tMYlL04RFjCr9kEPUqCZ5?=
 =?us-ascii?Q?3YR1IoSq/bqWWIzo3kbtcwKrDm9c4aRM9aqdGurPYDac9tHGWcdVmYeIBTWw?=
 =?us-ascii?Q?+jaIEA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10b84e6-f5bc-4b2f-2e22-08d9bbf56435
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:54:48.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCyqXdbmLBrrizFoOe369HZoAoK0kmXF0EVg4RjtEG0K6R09UgtoexCtOygXyULL9/c4wZBTL2ld2gHgGFpzoGEgZZPPFDUCkATj4qFT6Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=705
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100090
X-Proofpoint-GUID: 4v9Al0FYx3kf4qgEwF-9kGeCRrUgRhMv
X-Proofpoint-ORIG-GUID: 4v9Al0FYx3kf4qgEwF-9kGeCRrUgRhMv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_075501_442762_F0C8449A 
X-CRM114-Status: GOOD (  18.12  )
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


Hi Chaitanya!

> Although I always prefer descriptive error messages, I've not seen even
> half of these errors in the field. This will :-
>
> 1. Increase the size of the driver code.
> 2. Require constant patching of the driver code when spec is updated,
>    I'm afraid this will turn into churn.

Updating the corresponding list in SCSI hasn't been a big problem.

> Also, we can easily track down the error in the NVMe spec from the
> error code that driver is printing currently, is that not sufficient ?

Only the block layer status is captured.

In addition, customers are not really armed with the NVMe error decoder
ring and are left with no explanation as to why an I/O failed. We have
had good results in the field with the verbose SCSI error logging and
that's why this patch was modeled to work the same way.

-- 
Martin K. Petersen	Oracle Linux Engineering

