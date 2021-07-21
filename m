Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495FC636C9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 15:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF3E6121E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 15:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF3E6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:
	References:Message-ID:From:Subject:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+30YIzdNXzIAZjr+HCyF6V2rKfvIUJ403nVi70fryg8=; b=1VYrg3fS2QJqvWs0J2QgDh1Pj6
	+cY96FwtSL3zdaTgSeFNW/8l8eOQJd6uclI61qPPDkMCqckp2ntYVd6OXEIeoRyheKpFFU7O8JQSA
	SjVFO17nX+PGmqYaM5vdLayjI5V7WZjRKc33mq91LTCGxZuzPUl4gJ231S29GSEX4rMNLHJ6hbbTE
	FVg0gsKwqdvMOhS5ZWpeRkayP9oEj7HEgI97W2DR7rf4C+1ZDoywJmNlNd5BG4NSnwu+KTLH8AbYw
	xhynyIzmlHhc3v+5/TXUYdTS2iS5Fl+AO5HaZgyZbqX26tWzym84uogvj5shDrD5GKYf19WKZUEty
	MqAoHkdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Dsd-00GDGc-OL; Wed, 21 Jul 2021 15:11:28 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6DEA-00FyfT-SC
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 14:29:40 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16LE6j7U010487; Wed, 21 Jul 2021 14:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=A5nD+vcoiZb5idaWeTBFs9gEHn6cGonaLb8Zgm5DChA=;
 b=ZFohw8UoPw6O5tQNgVZUkQ4Q+RiQcAZUlY1VtdSV4IzsVCF3CriHr4Cj3gWatmzPPLT+
 CBnsjwxv63br/ltdKBNLUOe/RXRvgqpqpnpXDOerHoBoE0ZqVKVPLlVFirEbabY0tZ0c
 HER4zUMn3QExVOActzyindJiHusvcJOUR2M/FRAw+sJ7X7chr7FJq87F86IpMygrWWQY
 fISQuV6EV2MM9QaN6kHSVYDi4xtkx+Eu0uumVcEfXNk8Uk0usM2D+fTKLjmVtX1OnolS
 Nc7WLaEwbdTI9x4TY8zDOSbWxoFsSUeeWm3Wvni6lIamEY+Wm0Tt8WS+ZHwREFmPeQro vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=A5nD+vcoiZb5idaWeTBFs9gEHn6cGonaLb8Zgm5DChA=;
 b=qSrHLjbi7lfE/cvFIQfLe7p5hdgklmcZFnz+OKwlKPYwr1Iy2NZ4Sobipjmy0V+KNkfO
 7fGKjs8oQDURYzM1aaS5uDdIRZoyPUud+n3gfyEnKGvxjob5uACScnT3wIkNVGGi+Sv/
 GGTc1RgEGyLVZ0aOjuvDS5zWww2NWz/s+lgVlaaEQLt2ayS0N3Ue148eLVFKk0vNMpj5
 IyxCztfYGajwPF/5hIf2+eAG+9DCYmloQwgFjUEI4BCs92gHLBa0XN1m/Y1TNKwjK60h
 P8DCLuIavQkwBbThGdvrcIj7UfZz4Cu5POB1vQG5gnPBXRQXIW7AkrqyhNKp2f4fcART lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39wwmttx17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jul 2021 14:29:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LEGOkk009271;
 Wed, 21 Jul 2021 14:29:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
 by userp3020.oracle.com with ESMTP id 39v8yxgyah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jul 2021 14:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4Xj/nFo6v3P+axjQ/xibFbY/EoVtcxozRKSXFbpOO8ABM8mQOcuF1opYq16pr58jNgYNCKWHWLC0+ZEKQ8W6TAe14f21wdJGj7LA3W1gDheN/BcAxaDN/VSLYjzk8YXIaZDmznq46ahhxLG2qi0PRMz3TYkaQXM5iiskPQavhFs0nfXiPPzZHygm4NNvLgUyf9kXJ3OnHS/vAlQ2dCfKiOjtul6V0IeZ5D7HaPC6dsokEIXr4IZwmtVA52GMNGNzImhvBIM5p2KxMyNW6pS5QkpprHeuYF9I9bgktWQaAerJUS1VZIl1bTstNnpeG9FHbP8p5D2ejivIpkDWP+ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5nD+vcoiZb5idaWeTBFs9gEHn6cGonaLb8Zgm5DChA=;
 b=IhmzsSNUmC3HBj0i3Eleb+v4ZYDTdEajOnRwYI4aRqiEEEeQtEF9Wi/izW+Mr3q6wZFkl8l5F3qE4KQRz7KDcvrSifurDd3hAAxv9dgcRP5SOv5hyRw+VDebL0hkWxBVs1orWa98jK/XlIVx/Z0L64dK9UZqu+pWUJqpz+vrVrwp/1wlNuwwSC3Ef1wYXy03ZKyRanOz9zt8OeB0QHJHFXPYQjYg7Bv+GHfZjD/Jo8/BBVLC+4Ub6p08MEH/r5e/qg7PbMKWSM8d5wS68kdpsaT6YOPUftPdvmLlH5LEqwxFHM1vu+5XbyhqN9y5YyVKG5CbkrChzVZOf2r1vHl9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5nD+vcoiZb5idaWeTBFs9gEHn6cGonaLb8Zgm5DChA=;
 b=U1Qv2/8WCzJ3W5Co856T4gF0CpNNTZyeon5qGtvT3nGqUcpL4nMenTpo716KgqrSf3hxlGV+BHYveJBF/5L0zz4Cmttbfd0oy/9HnFBpmQmfTdbSNaAZrB5rRcCq5v1zFkEISp9j/E8cHbfHfGlv6CHrxArUSYFpVVr+mj8KlpY=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 14:29:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 14:29:25 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
 keith.busch@wdc.com, sagi@grimberg.me
Subject: Re: [PATCH] nvme: set the PRACT bit when using Write Zeroes with
 T10 PI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1v953yc3w.fsf@ca-mkp.ca.oracle.com>
References: <20210721080556.600892-1-hch@lst.de>
Date: Wed, 21 Jul 2021 10:29:22 -0400
In-Reply-To: <20210721080556.600892-1-hch@lst.de> (Christoph Hellwig's message
 of "Wed, 21 Jul 2021 10:05:56 +0200")
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by
 BYAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:a02:a8::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 14:29:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84df9d8d-5d80-4c46-5eab-08d94c53f063
X-MS-TrafficTypeDiagnostic: PH0PR10MB4613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4613AA538EE1A0417292DF398EE39@PH0PR10MB4613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8eBrSszazBIzQILS6r2zsxv7C5x46E5jmUnPzvnTxJ3ijsFMG94ntaVWho6E4lWn+6CByWU6uYzLhb3XRF4eShihiNOORl3m+3qRSJaiHdbHly9Erm0hZ98MBsY9imxwiXvpNvhc1ATmq6/pf1TcdDoHLehUPxc0pHNFveiuta4ItC/ewvSfbKKgfGNGF+pE6im2G/OI9nndI8xZGZkkbAFoCndZmF5VAM6RFBmHD1Toi8gR0BA8ZS2EWhgexJ2sVlnWZhpPgooMmLS+sBUzhLtIGqU1k2L4rO3/oZC08TMmIOML1LRMFs9raGcuCSSrZbEf5vi7/B7IqP4pBOpBU82RS3emtCEHS1FU14jI9K2CwCJa72is3djVtGmOc3ieoW57EBotQp0bMuCWBdUXgssaFfEt78iwvlqRN5SU43Cukz4RzJdzo/SaV+TCotQ373GVnZn5GXcoYyOlbMU0gIyUCG7poiMeoNuVwDtZuiiAjrPpBR+jST6i+wE8Fp23nz1h46Vpn7otYbAgnJjjD1sZKfQG8rEydhluH+nyZHk+47W0qs35BjZK39TXa7PzmAVxm5qpWNw2XxLFatGftD+V6fKTPSy0FkPC1J2KuOKFlOaniLTw6KwfKFXFCSruTkSeASaaHQg3l5Hb+7F1r/CR4OMh9Po31rUwq3L7844v+aiNetV9ThbpzL9J+aLb1ehZUitB6P0oUqjMnXUHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(83380400001)(8676002)(956004)(55016002)(66476007)(66556008)(2906002)(86362001)(8936002)(6916009)(38350700002)(66946007)(4744005)(38100700002)(316002)(4326008)(26005)(478600001)(186003)(36916002)(7696005)(52116002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jz8kf9gPPU3s6ZVek5cb8dJE8/vAX67VNgjWch2QVxHv+rHb1nI7ZMLc4aQS?=
 =?us-ascii?Q?S5i2u+rUo4mlP9kd5yIFPWm1UVJvVR+WBuomcuxPf2CaZiUu42lwxlftjkjK?=
 =?us-ascii?Q?RpRoKu9MWxNinm4FEjly/3FTU28lrjGRjaoFJdroDQQjSFWScKVvFS7CT/mr?=
 =?us-ascii?Q?UFPU/8PVGNlhXn0hKbfyqHYGv88XF9akI7oSyxpBH32HNqksahgR2aJa1YBU?=
 =?us-ascii?Q?BAqBkumYVfpfp/9r3RXY+Bk09dr8YYi1p3l1OXyr4H/kUo8MBD3jiYbPiN1O?=
 =?us-ascii?Q?prTLD4r5ghwxS+l0jpzK6bD1XRN9/nYlJLBz+fMmFkGy/otq3DETN8Rryg1/?=
 =?us-ascii?Q?/yty1bQqId0xOdVZc2HLnj6sOq3yQG3jHpNnCtKf++PivVO8QgQrjH81vv5R?=
 =?us-ascii?Q?pWG4i+NEkNLfEG5eUm8IsUOQC8q/hM+QFrKTmTiXJMN01kbk8vij5iGiCR9H?=
 =?us-ascii?Q?EaOA086ZbTh61TrPYRPb/eC/9C3nr4OmfN5OmyZlgDXoviXHV0U/9HEcYE2X?=
 =?us-ascii?Q?Z+7o50T93SKCzy1vYH9D7bhRl1sbCaAmGc9r0M98SNcF9AkCvAS8ylYsBKW7?=
 =?us-ascii?Q?llJImGEFPIaKt7h55Q2U0of8X29oW3kT6peudzFalzm0gjomB/czG62WUrWW?=
 =?us-ascii?Q?BWzE8v567aH2ObXIpH7ub7VKKH26YHSYQ5C30Aq72MXGmSfTnZ0lGySs/GKM?=
 =?us-ascii?Q?/DKpcCdg/bYx5nPS8wjTObDvU6Z09nNj3zKlUFGKV4/7oyiCN89F+7R6OZyh?=
 =?us-ascii?Q?bz7GPROICyv203lao2jXGjMQsAYYbb3BSO/N3GeF+JoiU7Nt4ZNLvvcrTKNr?=
 =?us-ascii?Q?zSHD1+qz1S7wGxIGYSDCQsl9zNeGIthaZlz/ida0tOuW6RUhps+sYBrbHqsq?=
 =?us-ascii?Q?m8nG4My87uHmoPFVug6qnqxSWn1UVClf0nEn6GX5J+VAEKVk6D5bYjm5jJjz?=
 =?us-ascii?Q?4IjWugD1ce1ET/3V5U5oS/5UAsuNW8BiHPjDEizmsr1NxxCUR6e89RIOpDZh?=
 =?us-ascii?Q?3bwqnMwncKeFz0WNSphWRj1sBbm0wLjL9Y1p3SKyjr1Cid6JZd1O24wW6AnT?=
 =?us-ascii?Q?YldjfDXYP9GGL4+sBvzvQEu7wiMa21QWqoiMW2uRUUqAroZErnZcujPHYSWD?=
 =?us-ascii?Q?omHaR0ESZAc3blqc2Cwgj+SJVcYSPFVdrwcclqTC9vuVBMYsTBOrGMoNXiIv?=
 =?us-ascii?Q?eE7UPDdgs8dNVZSKP5paBIBjk0wk2o1EtlKA4ZreRzHlUZ1nvweQrFGlZre2?=
 =?us-ascii?Q?Mdq+BW5YXfHiiKk20wAnuQzFoFCuZkEmrFd9sP44VsxiWDUUOrUAvZ6s4QBC?=
 =?us-ascii?Q?CgwG5cur7GEPDgw4mwN9r1pE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84df9d8d-5d80-4c46-5eab-08d94c53f063
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:29:25.0169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWT4+vNPwUUsNbY6jawNubIcf9XUGMWzE1PkldeqQVWqqvbqKo2/OzLmTVKZ4cFCQnnXptsTHQmXUc7rRVeL2asZIPwVArjGp58QFIUPsXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210083
X-Proofpoint-ORIG-GUID: tVOpi3e1Hw0a4YZT0JD0-zevAZKZGswW
X-Proofpoint-GUID: tVOpi3e1Hw0a4YZT0JD0-zevAZKZGswW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_072938_998944_64BB8C09 
X-CRM114-Status: GOOD (  14.51  )
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


Christoph,

> When using Write Zeroes on a namespace that has protection information
> enabled they behavior without the PRACT bit counter-intuitive and will
> generally lead to validation failures when reading the written blocks.
> Fix this by always setting the PRACT bit that generates matching PI
> data on the fly.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
