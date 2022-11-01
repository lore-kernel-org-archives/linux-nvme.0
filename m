Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F89C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qn+LcyrvPY/PKFAc2roebeATRVrToeGJgMOPjFv2keI=; b=esWVDw7KFBEr/6ILlrObAynvLw
	Mq3SabMIj6ZXeK03oJKSJvM3LC3EUKmyf/RLjS2zYYy3wd2qg3COaxo0OuNvnRU5Mv97LcCLrgFiw
	MBC+IUbbhgv23Z/q1KVkucaD57RaxJrzqBKNr/OY2D9EAldE7u6TU69tLpc6OBOTXxIGcWdXVRu/T
	HpDCwSthQs9BirUs0RwvDxnjDIxXNH0wGBpDf3qxryGKGSxlNseo45TT/8CJu2r2ksm0eSUR7dlnc
	ykuw86vdmzgbYvo65feh65GuEAoETOJcI5kT0XCj7mM0lIFw/MO3gQCLBpf4bghSlQ7Q6uN+ZOwty
	7N25+ZFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1optW1-005ubT-Bx; Tue, 01 Nov 2022 15:49:25 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1optVy-005uZs-OO
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 15:49:24 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1F5XP6009945;
	Tue, 1 Nov 2022 15:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Qn+LcyrvPY/PKFAc2roebeATRVrToeGJgMOPjFv2keI=;
 b=VNVSTug+cXEhK1uqMzFxUaAq9R9Qf7k9spfbpX8n/8W+4yxJS2ipCWOYr6RFGZhQvN6d
 TTbm9bJvElfg9Ue0YS+/onyaE0HNlJR+YmFQEhylBW/UnwVRqCkbsO4EXbjNFsocU4Bc
 YZdviO/8kr8sakkRH86X8NB4RyFeVZqVy1/7gyWwrMCssPD1MfHQbG9cB+kt0g4ZgAJq
 gxUbQL3X+0xcd384nyvCJYF9LH6TZmAiq4chLg3YyDGBvibQ5FAgBosUF1s8/+FKc9cM
 UzcZJZtifVeLNaHibMlOp6v1K5efhJcfaioFEFWE6fM82ElOt8K1hdlE8tVS/lPkyXHv uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtf31k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Nov 2022 15:49:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1FboTi037376;
	Tue, 1 Nov 2022 15:49:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmaveeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Nov 2022 15:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWqIH92G0KFuVSRaA3HdylaRDJvZeE2yX2OyqCQZxAYwMWYgS2ayWeachLJwBifImodbll+ShBeAlPSHAFyGHuyYmdv2KejSaUMqi1OvTeSo3iI+1DJNhHo1pEyBjau5ljpODA7pRREksAwszko7qDsE/Bk1IRw9P54oREd8FtXc3LXnulfF6hJHe1acJKSa0b+6J65VKPuSsLnobVtMvE3o+R7DvOd0rmW2Hq1Nbk0uByJ+Q38BD17/GWSXfc4divYXtzUdtuZnf02+C471C1SDQqvjzGj2XAd1glY6g7+SwAx7jHVhUNWoeOBjnPnTyuayNJRwMLyMdNcCaM/A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn+LcyrvPY/PKFAc2roebeATRVrToeGJgMOPjFv2keI=;
 b=SuDR6I/pg1suNNkg8PvsZo6dl2IcfscNMVS+3NACGzXbOLzgPenrc1ctNZv+pJEDqmayYVvpk+9Ss2B0a9McTihjg7hisaSEb3uQSBDCawtMEtzHc3Akdg5UctrP2YTHCKc454V9GcjEddavaq5Gj2xgTLA4ymHoStdBUY7mEnk68SQHzZneGpoSKyeVygrXZxoa3DnccBwzXidrc584IQMnJvvl6ruM7W/wAtFTbrD+rQnq8TWTgaO+rhWhjB+rj11jl7rxx1h4183SfCs2vrNt/AFasTfqZoBO5XJkYVV9DymcJduYa3J1gideTYpHoPkk5Obz20AOJm2aBZXdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn+LcyrvPY/PKFAc2roebeATRVrToeGJgMOPjFv2keI=;
 b=nq0TEWhW7IcXjJqK0u28B2F9si8D7eE7pT6xigB7YN9NolHUaStYepydKpbgfdTd/5Fl+qAYIWeUXshl2i5PBIjyE//hVO1DCZd4BPrI7DFeQEEpqlcCUKotJ/Or2nA8ggt6ZYVG1jKPgAZf7a3DjH7vAc61m2Ha8z6TLHy8+6M=
Received: from SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19)
 by SA2PR10MB4555.namprd10.prod.outlook.com (2603:10b6:806:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 15:49:09 +0000
Received: from SA2PR10MB4763.namprd10.prod.outlook.com
 ([fe80::e5c9:87e3:b349:e063]) by SA2PR10MB4763.namprd10.prod.outlook.com
 ([fe80::e5c9:87e3:b349:e063%8]) with mapi id 15.20.5769.015; Tue, 1 Nov 2022
 15:49:09 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8nypu8w.fsf@ca-mkp.ca.oracle.com>
References: <20221030162906.3390-1-hch@lst.de>
	<yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com>
	<Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com>
	<yq17d0gq9oq.fsf@ca-mkp.ca.oracle.com> <20221101095804.GA13058@lst.de>
Date: Tue, 01 Nov 2022 11:49:06 -0400
In-Reply-To: <20221101095804.GA13058@lst.de> (Christoph Hellwig's message of
	"Tue, 1 Nov 2022 10:58:04 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To SA2PR10MB4763.namprd10.prod.outlook.com
 (2603:10b6:806:117::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4763:EE_|SA2PR10MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad4a7ff-b4e8-4776-d3dd-08dabc209d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	U9IaUXtDGxS9P+rfZ5br5zFcguULEnc/SjRdrc8mvFKXOzswFdHyC8G4d2TmpX1XrOIJfx9cpOZHJTNQJWpnXZVMF3oxJ942/O93VKFGdQ290hR4Zk/bNPApJAJPXTb7r+xdREMlGx5WWPeTr9DC/hrqo55cFyetTFbGp/EHMtAjpaOWGejWG56frKz+RKmdDWoJOIQwK1CvTpxosCYaVoBrRkSqBzw48CDGZdiMYh0FS4BuEpZ7xvd0LbXe6jH79nw+fpAx9HOL8Gkc/8lARxEmrUYo/lDryraOFUmbp7tIoMW37jHbJ6a+KwGuqyjHV3P0SWjNKJekyTseD102DaQasfbB6fdG+AS7phpRe8YeSLKTyWSVXzbpsdMP/Y45PDivetTXZmuxOKZFMg+TpraqpJG5Jx7VKv+CtNggWpuA8tYANsvOzxyNSrqHzEHbS4KzENhjkAiGfsRkUyC9vOFYTWBIGc5NA0XguqfrDwS91Z0RsXmqGPxvC96Oh376Ja8k2ZCzrlYrJwREd8vFsCqz0QjSz5dlP9Lj6GeEq1xH4gnJaJulYmaDDMJyNRoahMFk+Hkt7fiE29RsqwyD9ioAK1jDuG3RW8dj88o+UYW+/3fsZmk5tyfODmbB40Vu5UtlRXWMYVpn5gb2030Dwv9KIv1RUlycI4cCLzHegcem9GJ8v7ZQKlApaFsLEUrnpS+clMKs75hWTISA/e8k4w==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4763.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(478600001)(6486002)(83380400001)(66899015)(2906002)(4326008)(8676002)(316002)(36916002)(86362001)(38100700002)(6506007)(186003)(5660300002)(8936002)(26005)(41300700001)(6512007)(54906003)(4744005)(6666004)(6916009)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?m1DmU6dTXP3tYWfUiDWdCb9kKbAt9KZmJeSag18zMQeXF/cdXv9DYLiXCHlg?=
 =?us-ascii?Q?suLCAQRh30NDwkAJraoYTNLZMoP4b0cQBWJau6T16CWd7xCpXUT+wCoOIumh?=
 =?us-ascii?Q?IbMnSGUAfcQDisD5QFCycRhuKY/9TPRr2ypoRu0hQ6FHa0JPYD4tDIHqxXa5?=
 =?us-ascii?Q?3SSs3eWLtI6r7klQiQ86DTL1ES221o0lP1yhFN7Awwqs5W3O1khK72Wu/XFP?=
 =?us-ascii?Q?QQRtzj+qUFdKyeXsK+wVxvks6Gk1Z30TgeOtWQM63NKc2RVldg9Vh1nts/tF?=
 =?us-ascii?Q?SfptLrJ8WBWh8Vs4rVMSkbLwxdmxbJUTsD+qvkKq7D1yDu01XwR1aTB80cGl?=
 =?us-ascii?Q?a0niseKrlGDehCeHM6q+Wx6SiJyP7oK5bq4pLaKN9ZBQH3tUcS49PcjFp5kH?=
 =?us-ascii?Q?+3gXLJrUWQrr1RaaKlrtUD1MrRbVbVbdYkx2m5j7WHtCg+sQExX+Gf8EoIQ8?=
 =?us-ascii?Q?eU9dS0pmoqSNawDp7D3zfb4X21dtj7MjBUUC6xqNGOmn+h5MAOeGq3D4mCj/?=
 =?us-ascii?Q?G4MgbAq+UH8JFyF0CeRBeSabSS4to4F/HGxU5/rD+wtPZInlJ/d39HvafsjY?=
 =?us-ascii?Q?dY17iJkmYpOoUJFpSgI16YmBDNL9o1+kWPflZF+BiLoS7BUxqci6JqYZm4Al?=
 =?us-ascii?Q?VqtxOoyUVK4NB/BbTgHkJ/ZlWZvZqufO92VMKX4v0UtakU13cXKT/nS43JNt?=
 =?us-ascii?Q?AorHb2O4jz3x10hpAktbVYFtnnulNLDBrTUWNb9YsMNlmXPb9nEhAiRt+njV?=
 =?us-ascii?Q?k60Fs9iuNnurum1S/9H3OBuGCuTqcsbqAq6kskJFe5YAIPLmVaN3+75JqgQQ?=
 =?us-ascii?Q?EDrmD44m8SC68jfIhdkIDRPTMsrb7QD/b2ZWtf+PrQgvAiTMs82Pp4vOVYZX?=
 =?us-ascii?Q?FkXzvTO7iiFZqST5BuHuJDZGPRQJJOifSC7SFnGg+jOPgFo8deq8ABZVz828?=
 =?us-ascii?Q?9zaZ6wLFQsMg4mLxrvb+i+YjR4EHnKHDP7OdwLklpCewb1FbGh7HVZjeTUzT?=
 =?us-ascii?Q?c9YRnzqukrvlMYpV4BaJCu53xe6jCKqYHJOkur6nSREtIcyOoXl+5y9ukEZJ?=
 =?us-ascii?Q?+sEq7DE5B0BFok5bXgxZiJ3c1j39eN8sOueu9GXo6P82VGb6WUNuNw9JG/kV?=
 =?us-ascii?Q?ZOJ7gCBikDGviNdc0ZKYAvmR5brfnZB4cC0KmuyI7f5TUsRysVwQ9ouYNTDj?=
 =?us-ascii?Q?o9LZ8rIge7H2dFqsPInHP5W3cHOu10T2eqnL3sNTilrFbXFsnEvzYFqE4zcA?=
 =?us-ascii?Q?KB2tlXVIunocHeThqeO04sbdZ1nYGgohWRgtboahjDyfvnyIKiXB3/1Hy1og?=
 =?us-ascii?Q?LZ/NsU5eVZN8ZEzFwi5yPoJpZAgt7ETVADX27tIe7JxqDnQGJnmKXZCqudBo?=
 =?us-ascii?Q?/c2wMHeQjYwJkSRMaHha8LHG5o7yHsP8HSIf3vVUtYKVrW0u8Rw3jslF05v3?=
 =?us-ascii?Q?E0+wpDvZgzwq+d0EHhm7oU3k6FSXqZ1/D2dU2oB7rUL2Sg6/913CNCFM8wgC?=
 =?us-ascii?Q?nWuz9WIGSFApvV604/7Jmj1zymrEnaV3tTxlVv1Uk0d5Si0ua4bggTaZbSg8?=
 =?us-ascii?Q?pSGG+GItj8yW1ploOXPx2Wyx78R4t6bzTZ3qSq4smPxDQGMuwE7qmbTG6mVY?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad4a7ff-b4e8-4776-d3dd-08dabc209d3b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4763.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 15:49:09.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOkMVNrIwJO4lmt+dclDP8leeMELszR0aelmvvC2BiJzm1swMdTZJoLD1+HUtScSi6eB4lK95lCOg+hh8753nTxSkD9nVUg6/x+Vm1mnjAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010119
X-Proofpoint-GUID: EiHmd4TkDtRynxsM80SqXuO7ViVifxe7
X-Proofpoint-ORIG-GUID: EiHmd4TkDtRynxsM80SqXuO7ViVifxe7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_084922_866547_F46D5E5A 
X-CRM114-Status: GOOD (  15.04  )
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

> I think SCSI actually has the same semantics as NVMe here.  WRITE SAME
> must always ensure reads return the data written using it,

Yep, but many device vendors messed that up due to the initial ambiguity
in the spec wrt. how to handle the UNMAP flag. Based on experience with
the SCSI UNMAP command being able to ignore blocks and ATA DSM TRIM
being non-deterministic, several vendors ended up not treating WRITE
SAME with the UNMAP flag set as a data integrity operation.

I was just concerned that this practice would carry over to NVMe. Bits
2:0 being set to 1 is an indication that somebody at least thought about
this scenario during device implementation. But again, devices that
return non-zero blocks after deallocate are rare and we can always quirk
them if there's a problem.

Anyway. Not a big issue as far as I'm concerned. Just tainted by the
twisted heuristics I had to deal with in SCSI...

-- 
Martin K. Petersen	Oracle Linux Engineering

