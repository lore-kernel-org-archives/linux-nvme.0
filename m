Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DDCC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:46:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355BC610CE
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 355BC610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cGYGEwf0YyOcEtcyqCEt6fi0uE9LMYDjR1lxBvNCMg=; b=SwsGWyOFRpDcyzM+b5h9G9Cmyx
	QDPKxfEFssKlNiLVuvNyDVywVt+1hFR+Yu0JsdYgzppvytE/KbHvwAFIvtxv6HrYJ8GQKbH6DsRMT
	fHGUCJ0KimWvWXdDlLd5+y8xr1jEvlJU2Fv5EQBuwNvyId1huf8tJzwlTf/L6dgWDzQA5zXKd6/vm
	Nrf61bvKV/FsHy27xPbzuaUIsEtzfdNjXf+It1AqTa1ldfJKySwnfvfDG+2nbO5CRQO0aOLe0UdcM
	nM03HrzAywM9z7Th6cPr+zMIpnS6HY6VWfEfNMTI5f6+Y3zIUF+5jD2c/ZJg427MpuIYmNk58BE5M
	fs+/4mOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1magSO-00HQoE-H1; Wed, 13 Oct 2021 15:46:16 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1magSL-00HQmo-9D
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 15:46:14 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DFNkRH009989; 
 Wed, 13 Oct 2021 15:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+cGYGEwf0YyOcEtcyqCEt6fi0uE9LMYDjR1lxBvNCMg=;
 b=p617ssY3FFsC6nVYaOc87zfnP7ZjcT2BY/qcKjqV3d/xoPvRrOWt++Wzf5ukdpy04ks0
 rAOw4iDTtLc5VpfJega1lTKeNaGvSRujkoSv2dhsVgfAkIeQuaqJcgc/Skn1l708i/1u
 4zMjkAI33HqHXF90/1Jwr19ksnWkgUmkA4wTD/Gaf4yE/u4i+7RbPZMOyFhydWDfPW++
 v3Spnz/BqiVBOGWuhIZZcrzR63vQO1GwJmwWhWvysDJPN4+9AfWhH41+lfemsmRg5rdv
 RfqFmejQ6/GmduehekclI10JsVsvYcq68SY81Do6vZVA5rQE0fSyIG4LnZMVduq9Tp/X ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbud3qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Oct 2021 15:46:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DFjB9K068884;
 Wed, 13 Oct 2021 15:46:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by userp3030.oracle.com with ESMTP id 3bkyvb126v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Oct 2021 15:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5DQbvnyqkKUiOl06jCdlChYK+TShXWm47iLhD9MHlJ1/whiZzMKAdw2DwpOY2nQiOzHM46Wd33V5Mlg9mSDClSI4dyTNqMr6xnnCV5nCmPJC3B5vTXBq2D89EpIT0lkRNB9e5NKbp7GBjdEirbWI3ITRORE3yaFyB7yi2oN7PXeUvbGX1LyE0xvFY+7weLbSdq0CGrjgdnvh96e1dxGwH1j5prZrbud1LLFtFT7LlFeoTH8GlMRZhYx2vRpkCllYxpiQ5SsaDKLddlH8QjDX0sgcu2pbVDUFRUfOySwgkFhaI6wnUpZ/8QnosR6KQvCtJRPRDzEizvaQ3p9teNbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cGYGEwf0YyOcEtcyqCEt6fi0uE9LMYDjR1lxBvNCMg=;
 b=MNB2PbBTE2sFa/kl8G10LgJBzPufYKS7Vu6HQw3/pZ+nj51y5JIAC4vG4BNLapL1xNpY5cU1m7QKCHrPe3onaeuz3bX2hp6vAr371xX+EBBUQOyO6Groduh3ZRhhh+71rAaOQX/AlggKuPfcAo6O+uEbXAhZBhExjBeWIA10CIwLxRvrnvUxl90cgxj5Tau+mjCZ0xwQPREy5A/ztMWbVqms9Y9jMvvwvDzOWBAs3yYLM3s1CFQLO5RJAYVwybzagFIWpJ+9BfihKr+7Yy4vCOvnxpZVayIiNnqx4jvKx75aqiRJI1cJBsNFg3bgMtWJdg2zJJmkEsxmhBXfHOX7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cGYGEwf0YyOcEtcyqCEt6fi0uE9LMYDjR1lxBvNCMg=;
 b=J/D2LTAWvdPeU/Qv4mpyKC+SDINItzRsNL3DygWmiPT5xGrpgskjnAGUfPrGGOYdGoSQ1WwEKYDYgVsTifOZJts4dSIISTQvl0v/e6cElrZOzWpCEoitGEc5d4EGWQtDDXt90i3QTMhbVMWcZIZ03xrTj7xw5SG6rKDT0inxiRE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4806.namprd10.prod.outlook.com (2603:10b6:510:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 15:46:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 15:46:04 +0000
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme-pci: calculate IO timeout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgrdnda9.fsf@ca-mkp.ca.oracle.com>
References: <20211013022744.1357498-1-kbusch@kernel.org>
 <YWb8iVY74vWZiMCU@T590>
Date: Wed, 13 Oct 2021 11:46:00 -0400
In-Reply-To: <YWb8iVY74vWZiMCU@T590> (Ming Lei's message of "Wed, 13 Oct 2021
 23:34:33 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.12) by
 BYAPR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:74::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14 via Frontend Transport; Wed, 13 Oct 2021 15:46:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9c651b-3b3b-4c43-5136-08d98e60904e
X-MS-TrafficTypeDiagnostic: PH0PR10MB4806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB48066256FD032588D53B2B2B8EB79@PH0PR10MB4806.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kHiCTpp4OWcUllY07uJijH+BBXLhbhoBh/YYIEsRW52STRiA0fXE6M/tETAQySBNBdwnftI+/sHVME9360tGPDRhz2QcNgB9LQK083EYCS/DlhUWQS63WvuYch43/1fGzAxZ+RPJzaSpdDhq00HoJyDQV9VF1qPpXzERA4YIFI430T/MxIzQMuojp7jwPqnpwBsRc5ZBhc39U6NYINdzXn9u3D1k+niq0GVE80X/c8dOWZJxHjaZ4Ab9h7WOL8oleQZRZm/skZHbMk7xMBEwR02TXfdLvDIFr9z8ULIaGbux4O97LVAZ5FMi8TP1ciUjYM0n9Q4RIYK+jJP9ST9H+fonZ7RNLdY2Fd7lL5FEz0XHuZL1p7qR2lzTiFG50uKLz7Lu4XtwIsSFiEVIX8TbzIUzBla8uKwWiAeV18rG+f3g0d8Qz2A0YbwzYJFSx21d2vGTb0Dvc4N92sILRUBSn8vX7ei3ggHukSnnizvC5pQw8TOvUSK6XElyImaQUm33Vqd1Uxh6Fn9B3bZY7M+tpV/QT1VYyVdoamixcThzv3AmRRAAL9EvFz7OMKkj30Jc7XOhJKeFRCnr9hwvuIAZpjuI9tsEUxQjGdDw+F7IWHIFOFRDezIfwTm5gGJVh3qsOdJiQYGhinVLqTC7pxzTBlkKkCip8Dz66CXR81JDdt2Yvlec8+z8O8GmvuRqT6cuYpZbManhfRORxJTNKPXgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(5660300002)(66476007)(36916002)(66946007)(8936002)(8676002)(55016002)(316002)(86362001)(52116002)(2906002)(7696005)(508600001)(38350700002)(107886003)(26005)(558084003)(38100700002)(54906003)(186003)(956004)(4326008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6xf0BrWiV9WB9HIZxsZql5cfEasSY21gcW1FNMIZp0CIsMcDWnVzG+PGz2i?=
 =?us-ascii?Q?lBHlKF1Cy2M6Fl72PnyChZYA7vDYMRA40ft0P96mGoRKhKMU0f3uETjpKaO6?=
 =?us-ascii?Q?VwnLF5EY+TW9AE5Lxt39txzFDrhpw52+5SMo4J6i0PJX5cuzdakp6OcDTCr2?=
 =?us-ascii?Q?TU0nEQCLt5lvQTnV0yonMsdnmNbsecjbovmPhuGvJbWJD3QO/g/3etRKyL3v?=
 =?us-ascii?Q?57ILpMNWnr2TiCzeMASRaDiAO/Win7ZIIcOdpzZBfjvC1XeAdUzeNli/4sTp?=
 =?us-ascii?Q?0YuIT7KQL7YqFsr+YgOaNtiOdoTijOS5E4m/Fk81PVMgmvAD9ATi0Q3QFYOo?=
 =?us-ascii?Q?ZyriPar9tVKfq38fCBW0UNjdUHxmDpMqLIME64iQMV1LKlDDe3Nn2PzkvtHS?=
 =?us-ascii?Q?K9Qs6jK5LUvPp7Auf/x2TBndlvlpRzS93ksUHfru65xu4AZbCvGtRBrVodtj?=
 =?us-ascii?Q?alvJMAakhOAZlUn7q7ofowTiiGQCvgIbsStUYcEnWTDlXlNHUCYxMqTYEzbs?=
 =?us-ascii?Q?UE/4l2FeQRb0bw8UGM66yQfbSS9f6fHTV198iFcLGr6wmVFHgCjQOYiM3GBU?=
 =?us-ascii?Q?UZ8f4z0lyu9Bbv35Hfnz3m2l9s9MaFLH8JIXzD+xNzfI5loAhCaCqkQyuPVV?=
 =?us-ascii?Q?9GUkY/GahRT4ciZ0Zoaw83OjiyyDnruRw0h/gNmEdWbhQoFO6IVSFiefomC4?=
 =?us-ascii?Q?4D5FwXDEHdxKPiT1FWGKJDzivpNuqC5tLLp7+uiFnYm3WCOnHIPKUUAjE//o?=
 =?us-ascii?Q?a9V+YVwdZoVRa8ZzVQ26Tu76ne1u+4VuX2+1P2pb+0AA+ysF4OM5e0XGWjZi?=
 =?us-ascii?Q?R5bANn5zgHH33WBFw+nJQhnq8FkaQVNVS2D5ZiKdMxPIKBYh8fsy07KrYhWB?=
 =?us-ascii?Q?JCJ7N60jsv0/vUYGQvGOdI1ovWUrJPb95IFt8v5GSSViL1LrTtgWepcTzc/l?=
 =?us-ascii?Q?N7wS2Y5EGES4mqK0vC80ELSfBL5I2X1cgWk+2yYwgr6DUQl61/SmmiEi6J1w?=
 =?us-ascii?Q?fHwUjJj/jMaO+2mQ+nwfXcLPh4PtBLiU3EqBsuBcIK+Mot8BxyYsZjWhLoSu?=
 =?us-ascii?Q?jhU5LJ50pfaox+NZgUI20lva3Ca18HcfthIpUwKXrlZ/Xno1n39WHDaCW4Pm?=
 =?us-ascii?Q?GmuXjfBejDKW/skExi1J6a0ME9V4gh7oFs+8P1T5+/gOHgM0iMvH1zAuXUpJ?=
 =?us-ascii?Q?2zxAD4L4cs32lwLbGGKGM6pQZ52aY6vZcH434SiChO017gKM8wME94sNkw+Z?=
 =?us-ascii?Q?yV0eNKaUQ1Mrh0KooRAyp9UeXA4iNPGktMHE9I0o/26nAmBFsQyJHMRGj4Aq?=
 =?us-ascii?Q?/hvGzd7FtfUGI5fnR89u9bMm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c651b-3b3b-4c43-5136-08d98e60904e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:46:03.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qX6658Bm+G+edrOY2TbA1+t9VM9Vpfy8WjwNeQJC+X5CROwXpDp9JpBZ0z5/TOX/HSRghcusvAqmxDmqYY3iUJ2n+5BU7uEZlC/W5ii/jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4806
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=868
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130102
X-Proofpoint-ORIG-GUID: OclGu_hLel-a_Qz_5bUnc6M08npML73t
X-Proofpoint-GUID: OclGu_hLel-a_Qz_5bUnc6M08npML73t
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_084613_527783_12440EB5 
X-CRM114-Status: GOOD (  12.29  )
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


Ming,

> SCSI have such mechanism so that queue depth can be adjusted according
> to the feedback, and Martin is familiar with this field.

I'm afraid that queue busy feedback is a bit of a controversial topic in
NVMe.

-- 
Martin K. Petersen	Oracle Linux Engineering

