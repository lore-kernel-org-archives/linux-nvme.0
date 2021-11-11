Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 13:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD11661152
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 13:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD11661152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9B7QIQ0aHJ+aFyZSlIcwbR3mztNcnwv/FKktcx/sDY=; b=yQtFo9EIBe92lrauA6c2UB+REV
	Y0BcCvUxOL8u1hGGYBWbbPG+K/4rhEryQxPhqoQYDei8m04s8qhZGJejucsKrX7XmtQhMkg+csIY3
	ytVhdiXyf6S8nyDbk8QEeJNm0hytOBRinWyZx2SzTA3HDp7ILVV+Xu1evYBUarglhByiIjDz8dZmV
	e+gNb/M0SOOeQ3P13Kr9DM4M72PnXhk/Q2qIjuS5+abLtI7/8PGNF7lq5QzH5KNNbKGi8fijUjfzl
	1V3Ne7wbrGCpvt8bblHwgjWEI+r7qhIe9DSXb40BHJRbssuPpGUUb9zPsKxW7To6vOO/mYLFNVlOY
	jtYe2ZVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlADF-0080a0-Vc; Thu, 11 Nov 2021 13:33:58 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlADC-0080ZI-4m
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 13:33:55 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABCn40U025614; 
 Thu, 11 Nov 2021 13:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=P9B7QIQ0aHJ+aFyZSlIcwbR3mztNcnwv/FKktcx/sDY=;
 b=Cxc1lNTpzuMNbztjrg3AfI2p82ca2rO4I+81YjYR2nHnTLWAPmfObjd5aAdb08U794aR
 VArA3WsSNDDrJl3W/RYeBXzn65bkr5i40oTUiq6jFoVS3bXK1gORQWAgPCBMydw6cJnG
 qfNrfuxxN0suxZeC29WdCWinb+8SR2NXsZ4wtQqsmwLtl+paK22rHejfLXQUcVIn3Wks
 N2bdNt5d5pxy87ALxQ2CyRKLKk1zn+SjAeI1XjPrKU41AmrHup8lP7aEHS6i4R6Swk7S
 z8ey9omEafn6uLHF2avQKj+Q9LYiuDguk9tj0mMvEXVDwLO4n9P6a1qvdzN8IqWfjvJv wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3c82vgjgnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Nov 2021 13:30:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ABDUONc010453;
 Thu, 11 Nov 2021 13:30:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by aserp3020.oracle.com with ESMTP id 3c5hh6uy4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Nov 2021 13:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR2Ct9lfg2lWYmHuZio1fqi+W7Pt7kih7W2FOwYSPqln6jtzFsuKPKYoYqgPIXUc7+1ZXiBDQ9YrI6/BuMvUKtBbqP+UmEQnIQe0qCR+hfmRlU/yJ00PO99vydhWK31ntaoK+i51ZkUiABJ25EPYn+yPo4Ab1g2bcJuKD0PJwK4RaGxSfC6xJyDA5Qn08o1JeMhKXExyh7CBXvDlFLDdxEMcVrONLkLiGmKaf0MMUFapLQljfJVxZBw87ULVSnq3XsTD0FosDpO3XBfTzb7BSZop1+wNKu+B/rcb8uI3y4g8t8+oU6Gyxn+zWdyG+YX5keq1A41RMP/jHNJ5bzcEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9B7QIQ0aHJ+aFyZSlIcwbR3mztNcnwv/FKktcx/sDY=;
 b=XsVAqo+eiIui85ZPiqVPRnNkX9q2kD1/g0yGgXWCromAsk6X0rtiw0bE+1N6sieBubAXuijT6PkblSbO2VekSQZbo5iRqtWi5j8FzIYXJ7PsqEZL0bHlyJfV56ivKBvN/XCI4LmVuXXLZ8Vz9t1uLhrTH8V4xARU/i3VugyoYFr/w+W9ZFjZhd+wvAbHFg6i2V6u8ZNvPlDxTRN1NoEVPqujVkw1QR2sJQQCrU1ucWTgUa0nGpiOnaEpQu3qA92WcTg9o15+BRxTvvDUTwXWb+eDkqrHQLJy2HU2FjyrfMBGz51+KwmVQeTLTzt9KVKRDALWYQ0L9y2alD6GsK57Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9B7QIQ0aHJ+aFyZSlIcwbR3mztNcnwv/FKktcx/sDY=;
 b=tENv648DY+6aeK+cKQHP2bJdgrlcgkswpGfLb9ggWCpqgG+RCvhF7wFS8ew27v+iO9uibWG13QcoqBVgmSluK5j899lCv1H5YqEHvus2c7960hHEZIG6SNgm6qOvo973As0qCRw/uMQHcxxQTUzB0wlHB048It1SmcQDfoJP/w8=
Authentication-Results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 13:30:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 13:30:32 +0000
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen
 <k.jensen@samsung.com>
Subject: Re: [PATCH v2] nvme: fix write zeroes pi
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bl2qg6se.fsf@ca-mkp.ca.oracle.com>
References: <20211110091906.20958-1-its@irrelevant.dk>
Date: Thu, 11 Nov 2021 08:30:29 -0500
In-Reply-To: <20211110091906.20958-1-its@irrelevant.dk> (Klaus Jensen's
 message of "Wed, 10 Nov 2021 10:19:06 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.5) by
 SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 11 Nov 2021 13:30:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ddd11c-22df-4920-560d-08d9a5176f77
X-MS-TrafficTypeDiagnostic: PH0PR10MB4693:
X-Microsoft-Antispam-PRVS: <PH0PR10MB4693D02ADC9B2BD663C04F048E949@PH0PR10MB4693.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtX04zihErbruA0BqOWbDKRuE+DM88BfDUcxq7aahn++ARP3e/FRD+dw9hwoWiR8wXMIxREZfQLCG7Pi6nVO5TCIlmMGYgupbt7GS9jW22zRpLtwrokYLipEio3ZCoCa2KmaA1TVjBSHGJ/x4fIcnJxcT/NZA/FmUTuGuXgeQM0ZgRlrj0LJsWEHjQADuVmpvwqZ4a5GWgXQ3WT1OOK0EVc2c8WU3xsRLGBv/3q1u1h0eF9e6fFHugR90H+o3c3rrTaRjQSOmawGRlvMWtcxIRLvxWyZVJE/aS47WTj5w3xTOkKYZSrfa6XOV8TP1l+7dzYyFD5Edwpvu9J/dW2KIMvA9C4/kvvUNijG53hLSxHr8d0ZUmOShU78Z5Phd7oI6W8GZqtQWd+afOcWwr4SwsvFTsXFQF4+OgUwFrP6+ma3Gt27tEh31IL4NjUmn+T5UWzqxzhGiSdfZh7rzs23RsyaXwLK8gq3rU0xfbUDDXcBi08Q/oWRQubPvQhEyoBUa1x2F4s4SZvRyT13DgqOk3+TalmxWYfm9389SQbg+wTicaEaExRV03PlxnRGgrn4XchYQebLINk6dz8pkDe8LsPYRmNy7Lcky8zPsTkO68drpRepoROZ8YnzcuSqCPjdn0VKPwKbEkvAVV65RXkP4v1fJ78MyR5sPBA5aS8qaPHl1cC/B3XTPHg757MkvWANyep6pCafhiiPQ9hE2gBuVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(956004)(86362001)(4744005)(508600001)(52116002)(38100700002)(186003)(6916009)(8676002)(26005)(36916002)(38350700002)(8936002)(83380400001)(7696005)(55016002)(54906003)(4326008)(5660300002)(66476007)(66556008)(316002)(2906002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QooHEptCAX74DE9sYhH0AzKvZTuyQnAQ6zSQmGUkiaZF6D4A065sEYsC15bm?=
 =?us-ascii?Q?tiArLipvk4TUACZMB46uMMDh87tYqTrftpnE5S/HimqtDek/30ux/hr437AF?=
 =?us-ascii?Q?GZIdulKYMqj5LA/lJV7qYXuOofTAx9Zfb7A8xifSkC5fjpLDNPB8WWJBmORU?=
 =?us-ascii?Q?VWZstB8cf5jayx6cyIuSJTty9Coxra4hHP5v+x5FrH/+fq4Yhl0rtRBEGbvH?=
 =?us-ascii?Q?O4S8+oGZjpAouMvwrGEpYnWgw8JHaZYyOxiFQBAeTuk66JwVPAh/aN2wyxn1?=
 =?us-ascii?Q?yG7pW5yXRvrplZxHZ31TV2ZSWPXtw97qihQOv3VznOIzcHsUAQ+qRMG7i93x?=
 =?us-ascii?Q?EIFhvb+LJioEi1Ucx5IN8N+l9hH1Z6r593NSZp35jeqTdKgUk9eBsSU8g2eq?=
 =?us-ascii?Q?1++a4/WniWby0xNIKzJ38uCHdLfE7Pek5QVIKQWQ3V83K3OyS8xRA28s3zL7?=
 =?us-ascii?Q?sUt+uhovG2RJXrqJOjMio1KFoYHGtjUzLDJAwx3ZVpjbo2JDwSKl8zmCkXBX?=
 =?us-ascii?Q?I6pHq2uS45qoBTgb063Ig8L8MoHqCeG+BjPckXx/TeB26sP/rV9u2MbGbosl?=
 =?us-ascii?Q?QHm/F3akMOSxni+0uOcH3f0NIGNk9zr++0Up6MYWFfLQmriYixVX00aNUBmp?=
 =?us-ascii?Q?cs73XHK3zJ0eB8vhiSCVl2GmXg9a/Ay1JIuI6c/3LuMOZ1K4xNoBm6s7BMYd?=
 =?us-ascii?Q?IhD1G2u+zayDOE2yKb7TY/2wQbIaAWLovRq3+ymL6jEzebqHR6TUXaqx52Dp?=
 =?us-ascii?Q?0+bUAY9SjN5wkQOQ5t0HQ0D+3XIrTYIpyc7oX8DSAun5SZ2xIDdlkRMj0Gxz?=
 =?us-ascii?Q?R6e9mB6oReVL47CYPgQwz8FZVNzDvleQ4MlA92bkxUMlT8HlJqoKvrLAREup?=
 =?us-ascii?Q?Icwx8DOGbumTLAprFrfXyqA/NeJiLsTb0fTrJ5j03cb5IoPIWeCVC/mK9o5D?=
 =?us-ascii?Q?STUxvWZENR+lwCptqLfzqXYmL8aOHAznzsbccTFT6pFlC3Qm8zRXAKWA3gks?=
 =?us-ascii?Q?3WbKKJaEkJpBce6BCu9nVQSxsyKM2XUPdbCTbtTlWfcypgsOWtldRCJZcst9?=
 =?us-ascii?Q?fD5VECJgJOemFlWN6gdPbzkFQwAdq1/v1QaMcWcUOVP0i+RDb4j1KyXeuB2C?=
 =?us-ascii?Q?wwsjWh2Jv7XSdfxHOdja26z+yCQobTX45m1VIRDbkInhWb2GsKu1Bb6+TwbY?=
 =?us-ascii?Q?0FRv2UBLHkv8xsKxHQdVRcqGi8uaEQ63qlH6X4dyPiaAIR7m8hS4YevZlHyF?=
 =?us-ascii?Q?KBP+k+UQdGJE3nXkajHkrDVNeflUoU5wr290SyHSC+EvMXAqUyqL0UkdrCem?=
 =?us-ascii?Q?jRReEQfdaKKy9qcFA11OP8AlDAFpO9BjijlbJdDzGuWThCucR+EAkri7oPRP?=
 =?us-ascii?Q?fyFMpFZlWllVRVfVM7f7HUGLMQzAggt7UFHtusfPdd8oOF2YTWqtG1EFu/UI?=
 =?us-ascii?Q?lYQL8R8CNYBIznrq7J/PQk5KmOto11Yhe10m6d4oXzMDR4T9WZ/HAc8ySNZu?=
 =?us-ascii?Q?+8vLs56zAp5I0W0G6ieUQuAWxw2YdwwRiAgVcKdGpojZ3Xr4+QyYHoT2Tnl4?=
 =?us-ascii?Q?7ZfduuvgVSLkwxc8vhLg5DovBo4zw15TilTpC95MSd0S8Sfoqgbrrpk/gQeN?=
 =?us-ascii?Q?tdOyocQT2Li7CpRpcskANHYpS12MBXqcwh+FX8hu9ug8dBpbLYCpjBt50jjF?=
 =?us-ascii?Q?jwP3TA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ddd11c-22df-4920-560d-08d9a5176f77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 13:30:32.3982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J5cg+x6wC+dVkWcHmhH2hL5EHBjUx3b3VXRbrLuTXJRfxJZfRy6rO91WL+2EbVi0V05aRsuml7lkTXE2hrkkUZO661Uf1Fc4mY42nAPmcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110080
X-Proofpoint-ORIG-GUID: QagVRpjpwuJIFsv8gTtaCi5B0IhhOTV8
X-Proofpoint-GUID: QagVRpjpwuJIFsv8gTtaCi5B0IhhOTV8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_053354_328043_5C63A029 
X-CRM114-Status: GOOD (  14.31  )
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


Klaus,

> Write Zeroes sets PRACT when block integrity is enabled (as it
> should), but neglects to also set the reftag which is expected by
> reads. This causes protection errors on reads.
>
> Fix this by setting the reftag for type 1 and 2 (for type 3, reads
> will not check the reftag).

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

