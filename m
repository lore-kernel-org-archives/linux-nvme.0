Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B12C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 13:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A2561184
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 13:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00A2561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x8yKTnhMDf7TnS9EFYfdD2Xwx5cDTW2DmCXL8M43+qw=; b=QivAUBHc98yyIq
	+D1hBILLT0b/Jxspw9Q1BKaqH70XYN+zkaWCdw6F1Md/rKNN+gIZ7PLJ4me7ivnKFnW8hU0UaLVbv
	DqTZEuQUXPPl4AEW/NY74yq1cqw4+dq6ZN/QYsfIiKeqXaVG4uiKn+D9+0Ken5Om8WEAlYaoEV/Gd
	owm9FPGb4V30NMlkzYncjLYY9rLO8yZB03fUpSGMLz9GtYrJHcwJQS1iNPD7PWur68DhqwBqkKWQf
	TW49mtizGR+2TLNxD2xa1PBFJ5h9k9QPuS9+YIF2Mx9TbH4ZiP0UUDY15md5E6ZqBG6XpQz0F9n0j
	A0n+0Ru5hxJkswYa+i3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIWJa-003CCC-Eb; Tue, 24 Aug 2021 13:18:06 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIWIe-003C5h-9T
 for linux-nvme@lists.infradead.org; Tue, 24 Aug 2021 13:17:12 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OBG7p4001041;
 Tue, 24 Aug 2021 13:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+J+u+Mp5UbZ5TYX/dy4Cn3b/W2C3ceAN67WdVX4xaUc=;
 b=vrZb/HiM8BqSH8ysPRzc/8l4yL35J13sq7xk1QjVsX6bw8BPhxhuug2brBMp7yEXLn6u
 JYQrHlw7vnJHexdbVm0xrBmHTEDwvuMGwcJg4DPgyPgYWp2gB6vDSUNCbFKQmdYY32pn
 QWaRuE67bTZbebdreAeDKwmOqk+SEkJkSR3YuGSlI0WBY+vSoNNpRnU7Pj6XhwDpCBLk
 PzRwAZsN9CP+47o3RYssQx4d5sI74DXnBtrkzOzgtE6n1qxePxn+4B0gGRZr0+9FznZK
 n4dkiIOAyfQagrbw7w0FwKQhmw1gCbIa6no/kjM0OVWz+1wPFnHV13muLUVsSHuUu7KV ZA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+J+u+Mp5UbZ5TYX/dy4Cn3b/W2C3ceAN67WdVX4xaUc=;
 b=TZjgPID3iHHAfR45/ywe9QP/Fx3nertwEhlsUNvC2/WYW/x+l2H8PqbXfdKiVFkPy+PZ
 A7KUgB8dsFCEgFKdamRH3Hz8qrDQumxQdXPB4eteCg9GRo9Op2iHbpC8F9Ymdl2a7609
 0EK8FEIb4AaDbBr1HNBoHEO8WUPbP6rRFVotQmH+UWFYfdtBAEePP5w//ouO+F7PnzK/
 +gWvNeXq6csG/tKcfg8Unyv2yplVWQucF9FT2MIhDXXOh49UOWoUxshbrTaml9Bwnj1+
 FpYjj2/iiOVzn63uJXsOi/NqaIxbvEUdOrQMmOcEhV8eHi3VAdz/llWz/nTLwi6nER6l 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvrr8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Aug 2021 13:16:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17ODBRp5026944;
 Tue, 24 Aug 2021 13:16:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by userp3020.oracle.com with ESMTP id 3akb8urngh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Aug 2021 13:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFNnKjQWrsrzd3jWsU8W6aajXbmmAzHrK+IQQWXlBZaKB81B6xX8IXD+TrguPQ3gJyFpZcyD7AYRW18kqnjj9m10Lznvmj5y9zGj4Fs/teJN2mhezALUIyChjar7b3r61k1pnXmkDqKfbHfylA6AdL+oIxGTNSazr8ly5Mu+N86JPqoU8uiYWm7L7iGgeEq7dpjGJTv1aW710h4M/9L25kIX91Arg5ahoH+vtmBh5cnQmhVN/FQgawsyHHDcopCiX3BIc3tN/2JIHHgvcXnaTAnHFrBjirYfE6SXV6Y+R7QMNRd7TbHCv65NyxnG5f6mfCvxC/KvoT0H7nji6emOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J+u+Mp5UbZ5TYX/dy4Cn3b/W2C3ceAN67WdVX4xaUc=;
 b=cGwVkimEi6FMScDxH66MFljStwW6jcgvcwacN6i8u0E5RoC1cCor0lKHsJlhtAyi9cLsFjbVb01AUtjEwP2zvWz7i84Zuc/ZBTqvoz319EVphPGWRLyI8wNlxuqdCCjGyZKhxyGBldeGSajoYaH3dtMf2C6cz4KV9D/R2nZlD2gL0Xfgt+YHEf3XP+fhSivM6FeDCTSJyRHxxn7DO/iCsK8riIQ5k0eKNlX5+TzjaPPNse4bq2nXn6rjzZli/tFC47Gin9gNFNWfHndtKtug3ZZj3uZKIkmLKw+UF5Vaq8RvC/4JlsYU0sjQR5sKsZu0Ay+iSnrxF0Voq9EEgBdNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J+u+Mp5UbZ5TYX/dy4Cn3b/W2C3ceAN67WdVX4xaUc=;
 b=jB3TihdJdfJd/rP3lpJeEUcmSNHZwUx49LPbfDb06kwPKfGGoD8l1kcWJvxrueKkGV9cg5i4GvN6j+q/uMjFgsdx+j6MlAs9Fp7csLG4SPnScWoV5IJDdv1Xl5ur0yDvnwIFzd9dH8D7qS8TVhaMZOp4SmNyAl1ALPmfITDyuNM=
Authentication-Results: lightbitslabs.com; dkim=none (message not signed)
 header.d=none;lightbitslabs.com; dmarc=none action=none
 header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1448.namprd10.prod.outlook.com
 (2603:10b6:903:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 13:16:49 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a%2]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 13:16:49 +0000
Date: Tue, 24 Aug 2021 16:16:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: sagi@lightbitslabs.com
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvme-tcp: add NVMe over TCP host driver
Message-ID: <20210824131638.GA5558@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0172.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::15) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by
 LO4P123CA0172.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:16:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06eb69ee-4504-47c2-cef3-08d967016e31
X-MS-TrafficTypeDiagnostic: CY4PR10MB1448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1448B7BACAB453BEC8D7A47F8EC59@CY4PR10MB1448.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va+EFV15PQZZIZF2j2irImVP+ePnsU8qkkjAlxPZMOhd+iluaXcQw7Nm2fbq6Q1/TdJjMgKIUhfKbEkWb0cO1Cful1dSSFEUOeZ6+YPapUr77SEWLiXdyQgbb85wfpxgSZfgBki51gI7x65V0p1xdFKpLFV1DC4e2HAmp/tFZvDlTHseLREvixXWO/12xFqjN50mF3Wcyot8KpHocn9TQf5IOKOCbyVrBeEcclt8DKiHPFVKjscrCxV3CJ8cV3HmQa0YjGwKAFAc6/yNR/95KlrTbyGwIWY8cJ9jCjMl4WjwaCyUFblXr6HSWmJa3mQPA1kypTt+GlBZsTlYfIEi5SMe4x0DJaU8x+IwkNlXx8FVLG3z+lNu6KVI6BUGSyVFMAFX8OwrAB++vMUHx9gS4vg1x2Nq4CdB4tmTldTb6yDwcRajblvyxPZY3ZFBPt9RJg8bDPRyG11fLb1ltzChN0kWTj/wcptFPMZvhWAZ8vUDEte6M46GStU/aAvid4Kaj8e9GQ2u1KCeqLEXqIQbhX0b6KPqbADZU4+QhHGgmc496PWDgBNxgdt+GlN5ENWkEjcZ1e1s2pLx6GPnDe5BJn3tP97ufz8qCJ60f6X4BrH4WKvmq46H0FDvBYUI+0Fo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1001MB2358.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(6666004)(4326008)(55016002)(8676002)(44832011)(8936002)(5660300002)(86362001)(33716001)(6916009)(66556008)(83380400001)(9686003)(52116002)(9576002)(38100700002)(33656002)(478600001)(1076003)(66946007)(66476007)(186003)(6496006)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWL9gWECgBjz06szJutRityLenpshD025XPA80IVDp8qNM/wG0qFgJ87H7lo?=
 =?us-ascii?Q?Tw0YXHtRq/gi7j33PQRp8EFDYMEvru7buhOLKF/DStik9qf1oEKb0TQaI3od?=
 =?us-ascii?Q?5OptrYKK4yE5pfVyHdJXarrI+FEweW4iHaDH8N81IiPu82XBEtpZXdeAqZ2F?=
 =?us-ascii?Q?+WsFUfV0t08wKZLMgLcNmNo4vTf4eAcms1q1XYgeafkAoYOcfUF9ACRdr8lU?=
 =?us-ascii?Q?ZXLyIMCuwjG02yzStY4OVs3z8q0Z9tj8b0hgRTo/1DtmEcCwSezp52RWoV+5?=
 =?us-ascii?Q?Cb5KP2PEi6fe70+pPpjJDc5PUqAeo40dj9ccqnWRq0ba93mcrPsgV2GaUtgr?=
 =?us-ascii?Q?lyBsiqFoApaB1KnTuD0OxCWnYiBd5wGb1KMDNMPzOP4L9dUAZW6jNSFRQJsB?=
 =?us-ascii?Q?OkkqeQBQYXNv22H6EnlA8M7GMHRVQcRpuE3WU/5mRmG62Zt1ZbHdSBDGYWjN?=
 =?us-ascii?Q?AATPzolEPmXwPsj6xcfp+N0kGdkcE3YcWBI9qdzyXzN1GLK7u3HmS+E4+LyQ?=
 =?us-ascii?Q?hgtGT4A+bbyWWbsGsqEvwkJvqWOZ7s/7WUZHfHCp8HeFzR04joI5Sqec+QNn?=
 =?us-ascii?Q?nECHYzwWge4ioyLSa+887Y50Vv4cZ0ZITNYccajGkYzdFrzT3H3hCn7k7ijh?=
 =?us-ascii?Q?0dUy+GlHZB/YBTdZ83Vi+aBqZ8GMxfmJUlQyhE7Ld3fKxRmFyJakc/iVA+C4?=
 =?us-ascii?Q?4vJHEsmbVidY5xltrmpv5VCTnLFqSMzjdn+sJsmJn9S8oqBxnm6MnLLCQCEL?=
 =?us-ascii?Q?nqaN9snOnWMB5CI8uIoYWp0INYr9exCqRrSmyGZOoHzhBbXQOEotzrnCID3J?=
 =?us-ascii?Q?nmSnkMYV3rviALrLpwFC+1KnVtMV5+TiI6sPrSVj7OVbQQWRh3VwYHP789lt?=
 =?us-ascii?Q?tiK7lFmWz/E2t8kKCqubxOys6wyszlYcPSzQptcA2I5hQTDwYqLrNwM9vFf2?=
 =?us-ascii?Q?Z8dZg4s/WMELEM0774eE3jzOyOYpcpQlHm2U3nHtLtQZkGKT1AdjFS1epBIx?=
 =?us-ascii?Q?/CZ/PK/eYe+RBS0onsvlN+6V12nhmgDzX5yxRSIJBgnEADnC3PydgYJuWSqf?=
 =?us-ascii?Q?QD/W4EL3+RQB8cdN32HN1o1gQ3FM+eB7AmIgOOk2rPpf71aX4G3dHqnz7Qy3?=
 =?us-ascii?Q?5eZ7dNsS5E11f40zgIB4p7rnW+rzJM7915XTDol1icw/i+NhfQ3U9upS5BRB?=
 =?us-ascii?Q?7UdFzcEZb0q+N7jSmdcRkzeNL0atun7lAIOWtdMLn6KBhHlv84v34YFiw+9Z?=
 =?us-ascii?Q?f2cO7CGQ8zGOtnhMo5IeqHxSix4hL8cB+wDocgN8p580ZPDDWY28wMJcb0XS?=
 =?us-ascii?Q?lHMnEoNX60evjU4Fb64fwfBdsFtex52y84xsSyxx9jjSj17K+02W/5dkLRF9?=
 =?us-ascii?Q?B40rbWg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06eb69ee-4504-47c2-cef3-08d967016e31
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:16:49.2591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL2xpSDieVeLZUOMpM6TbngYwXYcb6o1y4d0s2YIsSrAjx2ro9UaDrt7NoISYSLtFIrIcgwijuMgZpEYnprww1IZkgk3wkyYWdwAYQZ/rsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1448
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=959 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240089
X-Proofpoint-ORIG-GUID: QXOp-UU5xnxRsGrASnUai6Wt5z5TAfFM
X-Proofpoint-GUID: QXOp-UU5xnxRsGrASnUai6Wt5z5TAfFM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210824_061708_436085_F1E90D97 
X-CRM114-Status: GOOD (  13.63  )
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

Hello Sagi Grimberg,

The patch 3f2304f8c6d6: "nvme-tcp: add NVMe over TCP host driver"
from Dec 3, 2018, leads to the following
Smatch static checker warning:

	drivers/nvme/host/multipath.c:101 nvme_kick_requeue_lists()
	warn: sleeping in atomic context

drivers/nvme/host/multipath.c
    97 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
    98 {
    99		struct nvme_ns *ns;
    100 
--> 101 	down_read(&ctrl->namespaces_rwsem);
    102 	list_for_each_entry(ns, &ctrl->namespaces, list) {
    103 		if (ns->head->disk)
    104 			kblockd_schedule_work(&ns->head->requeue_work);
    105 	}
    106 	up_read(&ctrl->namespaces_rwsem);
    107 }

This is a new Smatch warning I'm working on and it's sort of
overwhelming because it has generates too many warnings and they're
complicated to analyze and report.  I'm trying to send these
automatically generated call trees to see if it will help.

nvme_fc_unregister_remoteport() <- disables preempt
-> nvme_fc_ctrl_connectivity_loss()
   -> nvme_reset_ctrl()
nvme_fc_ctrl_connectivity_loss() <duplicate>
nvme_fc_unregister_remoteport() <- disables preempt <duplicate>
nvme_fc_exit_module() <- disables preempt
-> nvme_fc_cleanup_for_unload()
   -> nvme_fc_delete_controllers() <- disables preempt
      -> nvme_delete_ctrl()
nvme_tcp_state_change() <- disables preempt
-> nvme_tcp_error_recovery()
         -> nvme_change_ctrl_state()
            -> nvme_kick_requeue_lists()


I looked at the last call tree and it seems like potentially a real bug.

nvme_tcp_state_change() <- disables preempt
-> nvme_tcp_error_recovery()
         -> nvme_change_ctrl_state()
            -> nvme_kick_requeue_lists()

regards,
dan carpenter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
