Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 09:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4750610C9
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 09:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4750610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ND7CHCP1Nry/4iIgB+OxDfqnz+ngexq/EttAvbCj4ac=; b=MpbmO7YZ+wGtzC
	9v1w89hc2rT04KsGZufM6Yy3nsny5WBtgKUtTuL8sLTw+Y7uZrJhCFKsFPSSf5P8AbsyzOr7v+Vqy
	CZ0HQCoq5TlQHGT8xmTRpVx9h+Z+oGzN0tbjJ1DPpev7xgo8/9n7Dlws+/FHE1cJKdYCwjvVo+mm7
	eFvE7fIHalOth4L2lsCYP/ZjkSfJBq8nyQeogmHDIIcxligm4p0pPMGWl8j7yKYNupbHwWgDD2nR5
	l0wraqVmdzqouQJcTeSGZ7arVc5d4vIpGPkeYtX6z/VVHRtG7lHjbaL2etrkpe2IbRXVrYduzcw67
	YSrQljt5/36wvkHELw6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOG9L-008kQ0-Mt; Thu, 09 Sep 2021 09:15:15 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOG9I-008kIo-QI
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 09:15:14 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1897RP9x021545; 
 Thu, 9 Sep 2021 09:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=0qhazibAYgMqNc1FkvTXdlPg5IebAD83rH+PvksjqJM=;
 b=hd5UpmVhnk6nouSIH1UYJrC4vhm3ETBWnDOZ0mG7QvPcItMbj9T3JO+cYWUNlAu2d8TM
 lQiZUsZZcQOlA2WuQcN4J9JhJw0lBsNCBzQWEDUBWpbwsonvUIjOsEcZM7GTesO5DRLm
 qqpBoqI3KK6UQD6lNw3VYptLN1T7ciuH2hs36ig4PE85k9zlxnYdzDjVpEY82a+n7oBo
 CWJRTCdVYbLNxwpiNpZiyN1N9OD/IFp8GXi7QHSk1mCWuGfLMp+gwbLGgmv3UWDF0SCe
 zr5VqILr6r+jn0qo1OgbbF2G/Xp/novOpEpNIL0RvuZqmLe4y7xk/RB8rpvifJbvc8xF /A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=0qhazibAYgMqNc1FkvTXdlPg5IebAD83rH+PvksjqJM=;
 b=SRKwKpe1wOOM33zTgxN12ujEL03sHVYaSycOW61g5WUVaRHIW/JB1Wv49VSQYoHWToZv
 500p/TqKN8otm0r7/WFZQos5VeKws+rO7LN2jVKaC8qHO85mK3HaZRibVEiyfSTfpotm
 f8krStzhLEFSW8Ei208M/jCYFbtbSgoVuCpGTcVCfSpr1pBveCGumWgSHKhgVqr4OZU+
 bKaHGgC+EFJslhIEFnpO45RVP4prM0cn4IdohgwwHJhe7yDqHZRdIl0kTIw6iRz+dB70
 FeOn/MELHDW8LMNJ2NZKSNOnnUf1wci3gv/AAgzUo3sbQGar1PvN2TPlErAx3FrF8Ib7 Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3aydw40dmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Sep 2021 09:14:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1899AFtO161154;
 Thu, 9 Sep 2021 09:14:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3030.oracle.com with ESMTP id 3axcppxufs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Sep 2021 09:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/IOlG0JfiCJGWpgV+URASrp5+eiJ43zQ9pjXclXArsgKbHR5pwTObBmUWXSk+IzOeo92bkzahqbDAopmNVpRIOi6E5WF68dbfJYypVMkdQK7QvRgtmsb9ALGLJuhwgE1Y7CPcfYSnsZNZvHTRPansm/R7r9Lg/2oK711CzRLH8DXYwetzdxgkGR/l/mQdeGYIAJQ+6CLFj8kmMoRgeBw6fKrG3EJP63EnEOLoBLiRhwr+DhsCbRUJ1Coml5/3bN8jPAse7i1SDOmMDAvgh7p7KLW59vBUAIMwXUgER8wVIbndcHKkD7g26wMKFc1VP6YNCP2798f68Md7iQA+LMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0qhazibAYgMqNc1FkvTXdlPg5IebAD83rH+PvksjqJM=;
 b=X9c+lIhv2tLzRFmwbCIxr/66nI+LngP1SD/UpF3s3wOi1bil9crPvPX+iu3Ldb9PNTK6CAWktBLvsP7ykkeR/fwxIQvlNREjqwHfKtRjHHCmRVyuk8sMgvVqQK9SAjFjq9xGKFZYcfiR8jg48i0hnLZXASced+y2hyvfzW2tv4u0Ug7Yp8BSf9PipaCkUwm1KXLClu9srYGFC+5K/WyYr70U7MmHg9yMf5mEYZi1hZYigImVateGJKXpV+Uf/OrruKpeKJFFUpWNeP30ht6a+sP47RCGXFvYq5Lq9Pdc+kuwJmJWEE4F1Ss6V/iVVWqWWaP4fkLnVMvpTID3PwHxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qhazibAYgMqNc1FkvTXdlPg5IebAD83rH+PvksjqJM=;
 b=j1/b+uKoq+wjQlsJbakfO09PB9wezGDMEtCVxZ+O1Qe84d5tHjTlBqYV+r7bnXQumwN+nG0OHHvmdi/tFL+AyjNVVV67KbgtrdCEfkR52QX/lgyL9cT7rL1eEpU0E5aZ2j9cSX6m1QzeIAZkqpj0Ob8Ap7W34H3j428KWfEBAmk=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 09:14:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.014; Thu, 9 Sep 2021
 09:14:44 +0000
Date: Thu, 9 Sep 2021 12:14:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvmet: fix a width vs precision bug in
 nvmet_subsys_attr_serial_show()
Message-ID: <20210909091440.GB26312@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 09:14:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cdc779e-ac85-4ec1-c199-08d973724321
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2366EE004CD096C02B4993C08ED59@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77HpWZ3HlzAKiORQwiurKF6bjsh9n9eDiYtnAWi4Pflro+AmMh1UpB7dVA7g3JXhHrk1eEJFXE2hD9nK9ZsuQhqRbhHJks3EYivmz2PTwCTjWFe+IV4Gfo3ao7ejyVeHmLZYIFB29tuM5OJq3JseQZyB2hAlxWaOUeKuZi6L0cBjXCzt7cEIKp6sd5Xz3HWc3f9K45PtPLKIQqduGB7H8gb/fOmIDZgTObifzaSMeUfDNx3+Ci5nSSnM+fZN8Rf9q9nSK2HuEQel+45Uf1OK3QQhvaBSBunBUY4Y1eP+v8Uj3BF/aQR7F2R6B+yKEJArqzwof5bxhf6k20r/hQBvvxMdyofFhFQ5pgafrGFU1OogNPlxFHcIRgQhB6cXriuIJkvfyyYZD9g6Q14AakuqjZZK69+i1ahCB1MXc6P2g2p/if82sVTq1OmLMgscDadKtMF5e+AfyA7ZBoU09Uzc+1NNqbhdv6Ug8WUQmOiITWrJVmQZLL1qm/zeqZ99FkjEpgl7T5XUYuLpt9Z8D6VtKFCXSPBnIw/4C9vbLQdmAxI7o0lHmpY6+5iDArPo7gH/ETG2YRdA7SBYktKMPfKCZUlAgrOhVmNHaMqmFp4HgApQE693VWvuAXpPbpFxU4HWgUN+9OSGKBoTqeAH4vV6tn9Zuc450Btyv6G9UFT+YKyVmX6Ad+ot26A/BLH6Ro3r5n3lUHtZgJFB3fOyE/lhFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(83380400001)(8936002)(5660300002)(186003)(86362001)(956004)(478600001)(8676002)(33656002)(4326008)(9576002)(26005)(66556008)(2906002)(66946007)(4744005)(33716001)(44832011)(66476007)(6496006)(316002)(1076003)(52116002)(54906003)(38100700002)(110136005)(55016002)(9686003)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wyat4wwIz5zHcIH7ZHCNQclH2d3dYV3AdnRouKPCY0OX2DntakldkXabCgHH?=
 =?us-ascii?Q?5k2MMVINrpb5fsZHRAR8hHrafEB0zUsKe4IZhAf08w5InX0i0Ge4V/HCDMdX?=
 =?us-ascii?Q?NzTyg1nDWI73IiB6NoG02dS73xL353dyjFmJ0g4Hkm76U1D6W9PGntPN2xB2?=
 =?us-ascii?Q?pSAHCE4xSnJ2ysPxtXLuee4PmI3Fzz6TWENkRMfglbetZ1gdSKj2Ec7F1fBt?=
 =?us-ascii?Q?9X4QFqD1wOXoQGmKDYGB3OxNQh2sa7V5F2fDd56mjyh+vWGPYBIwrWJ6OXBF?=
 =?us-ascii?Q?y42BIqYHD/Cjg46dK7Q//qcLexwa3eO3UnGWoS5CVchreCANM63mVE2Tk0JB?=
 =?us-ascii?Q?htik1jKuwPJ4K9XoD1vJMxbw49QOPahwPW/j9mSNfGUgvWN3Tq6rfeCOnU+b?=
 =?us-ascii?Q?hAySDyFTBvhjFUs7l4fsRKRIEXyM16LYtugyS3NCBZItLnoYxDE0qfY3x6g3?=
 =?us-ascii?Q?bfWdYomJbJ2O9j3P1h/3V7pGtaKQ997TEtjoRAmgnFeN3N3oQy3jjeHnya/A?=
 =?us-ascii?Q?LTGgHHyWjl/zta1rBdx12ZPTlohxYjzqGZ5stkC0fhgKZ6xDnqDtbSekGIT/?=
 =?us-ascii?Q?E70XV7lFr0q/MEVYrDSGBfHzEs95jU3D7p/WivLCtko4v4bW7eoLqTyZXVUR?=
 =?us-ascii?Q?h5oXKaZGb8wvFE3sztUwL9xiRnYDI1xDGlrgSSIIbCY9owlstjFUrcChS0ku?=
 =?us-ascii?Q?BbU8bTWz7yteoAK9VL8DEfzBJhPKEOeaYTdlptnNdpAY20GBI6EAEAqDqXr2?=
 =?us-ascii?Q?KL8/eUvbfVVZRMkzeyLYWqPDbKI0jSYMn8wfqcvHZn6gPhCp/krWA/osoNsS?=
 =?us-ascii?Q?7hN1WpsatTOCkDjfkr+LvDE/i1S+veECXn58rrddNx/Xd8wG4Mq0A541FzWg?=
 =?us-ascii?Q?mxBA0vyVsTBKTIJenDQBQgpU8aY8zRR8lk/qx+aNbqU1H0/zPkEMQ+QV1C2t?=
 =?us-ascii?Q?4pVE/pU69xYYQkXOcCnKctyYq34FjsQxbBZalW9eXkAov+yM2QsmwLNRyZCg?=
 =?us-ascii?Q?gs5o2gW/3Zfkwh23h6pkorLOq/7iYvQUzdXqUwrLLz9QbOcH0PSi72r2uMaR?=
 =?us-ascii?Q?qP/GNOgHI/3Hl2N029rP63pQXvkBksbaL8D7qpPI2odelva/nBZrRjMwjcjP?=
 =?us-ascii?Q?HZXKjVff1wAM6ZuYV9YjMb1VX4wZsO1Z2oQSJwEaardlQckZMsJ6+co7H/pm?=
 =?us-ascii?Q?xqvIPNedBQCRhyvegVg6Zxi7psAMgcVYACMuQU2t+OMAAbeGdb3e0AMXtYXi?=
 =?us-ascii?Q?j11k1U/Hd+Nj8HyO6rn9zzFJoIjIZCeAgbx62jD/dJIOrq1XUYCglY4M15tK?=
 =?us-ascii?Q?vpGb9mRMMxY0+IAyFAGlUMDT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdc779e-ac85-4ec1-c199-08d973724321
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:14:44.2095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZUSRrmxutWsQxe8v29gLI2avQT83NY/7GuyOkdd015nNv6R08uTDkMoe4Eur8Nj+0tOuc4KioGx1JKthTcLsMA8ChQaTlPDydIP8srIfgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090055
X-Proofpoint-ORIG-GUID: jSZModeMTrp0DBkNEtyefLSHgbt9AvqR
X-Proofpoint-GUID: jSZModeMTrp0DBkNEtyefLSHgbt9AvqR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_021512_906692_CF0CAB5C 
X-CRM114-Status: GOOD (  17.08  )
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

This was intended to limit the number of characters printed from
"subsys->serial" to NVMET_SN_MAX_SIZE.  But accidentally the width
specifier was used instead of the precision specifier so it only
affects the alignment and not the number of characters printed.

Fixes: f04064814c2a ("nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d784f3c200b4..be5d82421e3a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1067,7 +1067,7 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%*s\n",
+	return snprintf(page, PAGE_SIZE, "%.*s\n",
 			NVMET_SN_MAX_SIZE, subsys->serial);
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
