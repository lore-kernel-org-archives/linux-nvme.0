Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E8AC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 02:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9YKiNErTbKa1u8U+5OohoCimpEJjox2byKzzDmSEuA=; b=LCp+IlUBWgOfoMEsKVryA4CNGL
	p2LzNQJhJs5VadrVl9ztJhLUPsNdWdcjvyl89oAazjee2ogDR4OZvPrjbJKFrazN+WoANxutGXF8f
	pKIkSoLgP+kdzc2Q/7zs1cJQl9Mbiku861fFNOf0qH8jFjoLRkXXe+YLPYRi2TYhDOogEaRLGeDbW
	TFDmTMN86L0yx+AUt6uQ6l++XIiUixVlvb/EySYX+0V0laESbXB+4AdEvK9Jj/KEOyTb8hxbYzZiB
	3wamvr7LV1CLyjeb7NYWUyNXTdRXniotTklJjvSeOCs7oKT9d90QzpyRBEuCiKSBPSxV5Rt518YlZ
	rwjj567A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPxtM-008MQ2-R7; Fri, 04 Mar 2022 02:42:04 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPxtK-008MPD-6y
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 02:42:03 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2240VecO017370; 
 Fri, 4 Mar 2022 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=X9YKiNErTbKa1u8U+5OohoCimpEJjox2byKzzDmSEuA=;
 b=MBUPuwdmxMO5AQdWcgevnhgHVPbqgcbcXSAMubqUcqfxW1bFsdYvi7w5kKgvNCyl2X/c
 1VFqknzliezttgmfHOMroNw4gvKYKzUZCos+JQwp5MLlj9UBM+02nK+GjydGRNfzFYO4
 yJJCDJuUv7d1c8vexW10YUpN0Ti/5Jw/RoXkxCX638uQeKyc+h7nue6tFznyCW7dBFGL
 ARMwO+fdo3xFekv2Ym5I/lBa0oyU3oBvwCDqW/Td1Ji4jjLk+Tgkm75XvbKYtG4KOpFc
 fM47xWVoExbLQuBfyjY1rWIC/hPSgeBd24jLkyT4H9Txig4L4/ATD9nt/Iym/yt5ckEX iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvgkpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Mar 2022 02:41:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2242aT7N017385;
 Fri, 4 Mar 2022 02:41:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by userp3030.oracle.com with ESMTP id 3ek4jtdt78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Mar 2022 02:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMgzPtpBYjSd6kVvqLHOEEEcRgF3RrHZiqBD/UXZ4DIHNNI0lOn4Y2F3IQeYUKJ8OQF1zKeCupCgSP2IoQnaJTkShNDWb7aj0vBNY4k6RrzyD56L0Gr+yeER+Ccfjw2DMI/7XWngAMNKbRxhG7iDoZuZadKlzonMdiSwG4x2y1G8wlNxcNTjcORi9BpGdWs+3Ax3545BAHEGGH1gb02IAPs1CqV36ZX3ZyLsRQ80bpL2wR8KTDiUqIP/lHrTxZCZJ5U5mg2Kf66R1Y/lih1qcaYVwyrTmFF8Dn3wyj1geYJHit225Koo1cIufP1xLbesC2VTthEJx51GaUPaVGKwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9YKiNErTbKa1u8U+5OohoCimpEJjox2byKzzDmSEuA=;
 b=aw9NY1asFJTl+4U/kndVvs5Gf/XGyegSHykoQGxLB5IBBaJ2qn2mhkfaQtWV19TMdZU62hk+mb1GC9HGrscy8veBUEZ7ux85TONvhyeN0CNNeyhZkFNymUf8Jwd36JQPMTZCfskT9zCOvYpSHiPsBHJOAQDHwV5kutVBY8DgudexvzfZLPfXe5+PQJbpBs4rJNi8zhtSxoseLYQnAzKCQF2jwebtYNYXk00k9JPFuV+3iVAXZdQvzCRApIT9g7L9GexWmeznThfZUn/zJS/YFcpeV3WXYLoreiInIDwRQNt2HRabPcN/wMPTO4h3JMmhr9+TyvltI9Z21CcTV+l5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9YKiNErTbKa1u8U+5OohoCimpEJjox2byKzzDmSEuA=;
 b=DI6kNrM9NkZsJMXQ0hdpTaQ7m0RIGqkeA3hcMWJjDYeWreLoEkzND/2B/BPMPpUXqL2Cp082GwSYOGN2ZNytGTGIJEi3aoc177agz13UFdNQCScWjFWTtAVLl+4jcgl2c7QThGBIfKJ7PAX8/ay7eSbarHoolnS8Z6Z4QhX/xfE=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CY4PR10MB1543.namprd10.prod.outlook.com (2603:10b6:903:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 02:41:54 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 02:41:54 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 7/8] block: add pi for extended integrity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee3iv3pz.fsf@ca-mkp.ca.oracle.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-8-kbusch@kernel.org>
Date: Thu, 03 Mar 2022 21:41:52 -0500
In-Reply-To: <20220303201312.3255347-8-kbusch@kernel.org> (Keith Busch's
 message of "Thu, 3 Mar 2022 12:13:11 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:4:ae::14) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f7f33a-dad6-46dc-dc63-08d9fd888b6d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1543:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB15434437EC99F2059B4089058E059@CY4PR10MB1543.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KCYxmlPMJhr5N8j0rsGk8VjCSmAVmFT/hwcPQfYk6QrXKBOjwu7nG5tCShu9aCu5NvQv7lmkUTuyuGuVl9KKlNWUjHfGYVm29hdCyVIS+zrGi8G8gptzqZQp5472B4BWa1lcZyeRYPlxSiBrDAu2P/FEr9LSW49tKzsVl8OEHILoY3CyZVLX2CWv2ifQiXIdqgASgg8r1WsiSTgEiObGlwNPAR44YGIYb/2xdnilHOP9erO6SD2FNeSnjlSJNxgfbpeG+ZTU3OlzlG8c2DMMvrzV2dMcjHRxx+ZanBj93OugJ69ga410PliY2pGFJPSWU4e1Ltd1bQQGsWiBrLL8A3f5EWRNomz8p1mWNXgIbMeKHv8xZ2axKuUmLJE3wkvJx7ztYhClPrqnsbCZdXdQBuoLs6A//4CeVAj9tz4NVzx1nkhM5kLgZSR7w2uyRNTtxWEmpIe+2cBkyGTzHitsoIEKsbpLYafwM+0zlAzCwGo+KWhHfjsPPenm6kzigbqgHH7G2Ao1UemxQrmTO2o3C2hxnDOGoq3cZxqSq6Wm3H6vC/n5GYuOZWJsMVg5NwSd2Hkg+QVfmHw0U/YcqsGgFhotFV5I7KrWzuXHN6oyKMEDIY45gCHzt7+X2u2LoB/clXNbCKTK2QgZY7s70cNPVvfCkeSfSEuJgYoh1MN6yxIf21eCRvY1oQ7N9oT/LQcODyMJanyAcvQWRIF55e62A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4754.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(4744005)(316002)(8936002)(86362001)(6916009)(6486002)(26005)(186003)(6506007)(5660300002)(36916002)(52116002)(38350700002)(38100700002)(2906002)(66946007)(4326008)(8676002)(508600001)(66476007)(66556008)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36NMQ6oladro9IfHViMhCHYpjwQnb20hcqPTpR2HjNQWVhcj+cXHSrt6WvMu?=
 =?us-ascii?Q?eypMCPmIxHAd9A+YdH1J7SRs3mMrFUtxkQg3LiZMv2S7wCISn0Jut5Nt1hWB?=
 =?us-ascii?Q?JVEHVdSgWzct/rHZJqLD8qbKT8Te8PfN/5EHYNmBqnQaoZs2vlvM4cHRz2I/?=
 =?us-ascii?Q?8zF6QQi3MNHEYLantN5cEnzvQWbFN/5s/VQ737W0366C35ok4jbiia/m8A/d?=
 =?us-ascii?Q?d8S0uRgEN3cAHw4M6lyjnLIDCXUoMGPGfC0r7MhRxLXI8XuCnwppWqrLzeSH?=
 =?us-ascii?Q?ko4lksZxolRSEcg0vfj3d5CpKGTTg41dRTg6iMBCB+RGkwqI/37JpLT5MWy4?=
 =?us-ascii?Q?fpMZ7RqDrCg/X7uuW1rTy+jTTZoI5bbpQFyxF9uLVTcBfEZjZkLNmlhSISC2?=
 =?us-ascii?Q?2nVvK7QcxT91ZxCGE3icEhq3MQoCM2+WWMQXli+UxAwHWhoTW94eCHuOWxiQ?=
 =?us-ascii?Q?xedKh5vHVm6OZ9PLKKmRYzmjSTbFM22MCVYw5Y62dXeO8hf2oBfQRFhC/mi3?=
 =?us-ascii?Q?JXWe8hPBXQ3xGqPqkEaVzz6Lu65z5j5nuWB2Be4te438U1CXFVSz1Wdq7CeO?=
 =?us-ascii?Q?N0bNIHRZvfOIN6ONcpQI2UULj3O+xmeoSF6TpyxSJJUSTDNRg3vJ6qKZgeUL?=
 =?us-ascii?Q?36zZE5zHZmlEPqdKOi5HRlyN/IGGEJ8oX/3HDbdZ9vdtNHXhTH8UrRVMjuo4?=
 =?us-ascii?Q?AktEkg0c8637fKLNfoFqMqBwYqt8b0ZVgxYaAD/BDeqMY2cM7prXgDSo+3LM?=
 =?us-ascii?Q?h3BtiDpgkllq2FajIU9efxTSH98fqoK/l8QWRjsjllc0a1IDWwQFhFDGQqhe?=
 =?us-ascii?Q?jR0MahbiSpG9PwpG0TDuoWt4/AHmGsl0hz26tEHMQEDbddFezyPsWZsvIxbY?=
 =?us-ascii?Q?0g7lGtSEgoQUjKXczJQoD11aYAfvKr0gWqGH6Sot6Q1oeznpkxgzZQQVdjpu?=
 =?us-ascii?Q?AY4Nj9DPwCS28CQtDVHrfelAI2gRu2O+4MO/HqZ8qBU98mMxNH8385Tz9Ik3?=
 =?us-ascii?Q?qd6iymXmdODu/UMpTIzjCMcEG1CAES9h0b2FAy2roX0puIvJ1w3uFsn1WG5q?=
 =?us-ascii?Q?bBZkfviYHDvMV1hejI5rMAjwxIfG0ogOCVnCtShlsSQihVF99oHuLp338sTR?=
 =?us-ascii?Q?N0pasgoS+UFp5hRNY+PgruKLgzo17hzclOw7dP5gZxBp+xpvFox1CQ3NCF9R?=
 =?us-ascii?Q?n01qkiQhWKCzSewdoHpicEGsy1JGe8Fy4g2DjAprjTjjlqK0nZbVN91SOyGF?=
 =?us-ascii?Q?fLzxt9X0t8gucrP38irkSF5AjmZIQKIByCN/m1TWfnfit+xfx6OGIBdzVZ4T?=
 =?us-ascii?Q?mBPN4MTeWWPDA7v31qDcIqmnuAr6afofhOsSdJh0/w3qRuNURYXQkrzXAOIM?=
 =?us-ascii?Q?BQ9eBlzYIzDyIB8xuOH9EVC6G0F6LpNE6fNKpGYtjcmbfGd33hym2H3jGBF2?=
 =?us-ascii?Q?OCkictgRlhNabFAAwHGSB8UNhsUQ2L/Pw+duGI81JfVOqRVyNznDWPL2Qg5j?=
 =?us-ascii?Q?9HasMxZoD6jJjcro/qsVgJH/fKF8+2jklATXoUCFIyDIH45aPdiQbIbo6CS8?=
 =?us-ascii?Q?B7syTymly6P6OvVw9LeuK+MjBm4pSITKm3Rd4Lb6P/VpoiSfM0hEzRe9jAFr?=
 =?us-ascii?Q?tlN8f+twwr0nzB/N4jKjx4ry9EP8plRQa7ot+cgoYhiENrOq32d3uAwrowID?=
 =?us-ascii?Q?NuF8mQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f7f33a-dad6-46dc-dc63-08d9fd888b6d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 02:41:54.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFp+AzgvA05SYIELAwuLKrvHNJTV1n+RjIq2wE53YVyTLKDFHmNrBTDRgOWh9eAkZfkhKjEzaIn/cCWzFcGY/2O4dgqgTk0+99fMRHlMaJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275
 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=930 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040008
X-Proofpoint-ORIG-GUID: uKjVgFJK0sXl56DIt4K7wOhU-Sre-CVJ
X-Proofpoint-GUID: uKjVgFJK0sXl56DIt4K7wOhU-Sre-CVJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_184202_298736_98C03287 
X-CRM114-Status: GOOD (  10.86  )
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


Keith,

> The NVMe specification defines new data integrity formats beyond the
> t10 tuple. Add support for the specification defined CRC64 formats,
> assuming the reference tag does not need to be split with the "storage
> tag".

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

