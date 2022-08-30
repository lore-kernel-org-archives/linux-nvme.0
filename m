Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7870ECAAD3
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 02:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9plfHMs29e+65IIMqXUEkaK2JXoQAUuNH8VwrUGEifc=; b=DQiMV5s7+9UtxwD+t7fOLhGtfp
	8MGNDczeDIl/0/xYHV+NaWw5xK7Gfs3jCJyj3237oRID38Sogun0fpWACuVh66H6ScjGVP0EXM+EE
	xBg7LevDXo0bkXL+6wm58Q1VlvpjXfdC9SMX22iZSweq4OwNIHgZe3T17Dp66EIHHFh8/+g95TSZl
	wydUDHDPgWlGsoEIIL/s5alJOj9yFbcoFGZK0syIk6hy97WDPFZYg8zqKeD3WplCJfHgM2uQtG+JV
	iqQXHBVP0/HsetOh8mmJITy65jJnilMq75O00LfuoI6tcujLtRzycaFFd7TL5s7nzJpUwFBiLFMxP
	IpXYd4OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSr9i-00DdfR-81; Tue, 30 Aug 2022 02:39:10 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSr9f-00DdeQ-Iv
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 02:39:09 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0cfhf024132;
	Tue, 30 Aug 2022 02:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9plfHMs29e+65IIMqXUEkaK2JXoQAUuNH8VwrUGEifc=;
 b=PJW6XNZLZRFHFJNI31TQyIn28ioJ0Pyx2RkqfXLSBMKHEAPsoBT+iNU7aUaUHVOfeHN/
 lwl5bvOJWNNAvNTLJAm2Ds2h0br6tQiVLepDG3xBKTlxy5BR4aG8dtmbaarn3GD9BFrp
 VYab78xgq6K8OPEC8CNVu+czzTf+xkcH56i+dwC8Z2n/gM9Q2rGl+Oc2RNfojV9ZQP3Q
 C3aj7Os3ewDS5vkgnX6Km+qzof2E3ufc4wTPcuhSxpT3YD+L4zAQuX9nkBjKOSajgvP9
 VT7tfXGXLAJG90xo1KmhnbvO9wgv73CdQCvqBdG+O8jdYTqtod5hNP0byToCssjpiWlZ 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a225381-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Aug 2022 02:38:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMZAF1017970;
	Tue, 30 Aug 2022 02:38:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3ffwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Aug 2022 02:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBEu4X5dvwhBUo+i8hzzF2hcwsRlaNFMngpj5u9/Az0u9mqe4ddsFMhOb6FxigSPsAAbAuSMYvIkj1AY28N2sx4JnDW2IyiK2Y24xGBaBaQRYcJO23krs4FpkKF9EpBUpQqoNAeMsfl7zSEFmzcVDCPDw4zcidoZnjU3lWKR7MIJHUSCKxqn6N3NhElL43yVphxpmoXLPxzbYWw5pbgNcMDQ5sW9IPbzQubZAzGFORSLw9UHGKYHJdMi7JwU9JyhqeMyJ8CdX0n0QB3R9fSCuUuR0+fXEYtbpyhV/59ILjdNGW4qsfG81kEzTW0xnYgqa//62jcu/oqOiNZnP3FczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9plfHMs29e+65IIMqXUEkaK2JXoQAUuNH8VwrUGEifc=;
 b=ETlR7l4/sTPEUKSgX7G4veNbiXwVjmsKEyvQRr2zv9bKN5WQJsgyl72ei2m17gfcVAVpmDanJykDWv0esMgHp0Fw3rYUcVQIR98ypkvC+C43d2M31G7OU4OeLagK8fcOJquL42bWNsKfn33nayx9QVZkVRyzhauAgbgjJ5P0jbBI3Dd+X3wz9J3P14UjYRhe3XaoatyUhu/ispX4FFR1/5ovanZbBX2HVal7tuRBj7EJyswKeeZFOLigoL3kvaFZKlsmoGKhc5rsOJfSsy5xtrBW/Fw4RqIjMera5CUNO04VRDGHutRqub8aMQmAmNDXRaSm71phfbgn0GJtPXd1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9plfHMs29e+65IIMqXUEkaK2JXoQAUuNH8VwrUGEifc=;
 b=EnzLf/SM+uPfQuyLX8kZlvu5qcGvV/LEDD1ycI6cPdSvjrH8Y/m+yGHDX+qUqK2/JiYllCPdiZ4BKrXuBhe2YZKI3j+/NdG5Kk2U5ejTN4SFUMYOziD1TfdJatP2M6vlmTb/nS1P+pb4B8Gsn2ZfBacd5+ajv8cKLeh4cMzc+x4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 02:38:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 02:38:31 +0000
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com>
References: <20220829081256.24570-1-lengchao@huawei.com>
	<673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
	<59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
	<ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
Date: Mon, 29 Aug 2022 22:38:28 -0400
In-Reply-To: <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com> (Max Gurtovoy's
	message of "Mon, 29 Aug 2022 17:56:39 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0022.namprd05.prod.outlook.com
 (2603:10b6:803:40::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3600c576-2278-4940-c68a-08da8a30ba17
X-MS-TrafficTypeDiagnostic: MN2PR10MB4192:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	25bdoiRqo+s+icGqv3y4J4GRsBPzHkZaOUgzK8ryiKuq8xN0xlREYVvmQbiPrpFGxYBFZ9jOgTNBUlSQHUf8UxQD4NkQKQCsQUbLmIuAzxq/19LvHX6XlBn7ZHhylmc97DkFqyciMhHjtwYupOJ6Ee65VUZDuudkS9jSDiGIEidxp3TwjM9w10D8DBss83NVcDLl5MraaWhOZe/MguUULb0Qlo0b6NqcceqvRBAXRASMU1w2kTao/3HAOgS7IZ8gUIYxLgSXyqd0xeykH6TLQm9MAvmhZ/e+asWeiMYbaYymPXWvSzFeVaoFQUN30GkQB0v02jMC2o8RMvbO5u/0VCcwMMflq7u+MJwYl9vpSwB5I6UTBZXyYM6Y5RpUgRKAjhyC1qYS8m2ym7f9c4PRa3wtqgnHIG3WbyTm0rqWqYcXSMGckcx6tHZr7NV15pTpf4EtVszrlDKZ2dYzgeXJOV4sKQCeRfG4U2LjuFnXdXiGRoM/X+tZuXX3HOoFABkuCGOfjykF3hadvJ1kaaCGSwonyuBV9B+Elt9dJV7isKSM5voi/8EljrVBxWa6x794W5Mud2a00ExmBkmwwH8wqfXHmuyoIs5MtQ7gYfDSKNlBOG8zjTbPBxdlV3htKewf+SoZoPc6bSdQALy4ndGqQJa+7LyPinFrmcGEOJlC/EQWU77y0bGJzRuEI47CPMSBexD2vt7Ln6BewEygYYB2Mxi4xfwL9me2SLd/0AIniCXzqi4KPQmnvgnNCWbz9thhmC4jBy7lAHMx9sJh2pGa0w==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(86362001)(52116002)(6486002)(26005)(478600001)(6666004)(6506007)(41300700001)(36916002)(6512007)(38350700002)(186003)(38100700002)(66556008)(4326008)(8936002)(5660300002)(8676002)(66946007)(66476007)(316002)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?O2SvPpEiCxboKqVuJ+qlo872XaWT77cEIJf6bSH6jGtts4APy9iO6uddlNGr?=
 =?us-ascii?Q?EHb8gRuNadDguk5tOFtXr5N9j+IryqedCKj4Uam42CoAyBDBWjCfxEFIaVCE?=
 =?us-ascii?Q?1L3UAgbXvJ6D0zZIlbv3cqawaCR3IdnEGw71fv4FWSGyDqwvXU5g3TSH9xIJ?=
 =?us-ascii?Q?Mem+OzA3BlzW2+6GtoBE1yZZVZJipd9bftjp5mDQwGpTRi6IcMWyQ0pJuHf8?=
 =?us-ascii?Q?SxGg7k7DjwXdV/wRbmM5SyA0oeW8eEEA2O93yhFypBmcgr7FN0PZJV8UBMy/?=
 =?us-ascii?Q?AThRmdX1bDUQuTRwQSV/5pDsnS7J/8l2yxdr1jVZwPuZn5aKZVuSuJypJC2e?=
 =?us-ascii?Q?+FyI3fbljdUc/3AaLm5Z7laZwfkkW7yYgaMFlBCCsI8RHJifrsUOn1AqQ9mW?=
 =?us-ascii?Q?ooIvLQ74okNCtilENMo0uOMekYibZP0Lpjr3VVw0J4H8SRMZIErMwwtZeVat?=
 =?us-ascii?Q?IQR5lUJ8jRSpsjc9S2rvCsxIwZcR/SmVDnxEmN2z+zzG8RQ1U87FFWtdoYTQ?=
 =?us-ascii?Q?m62Sa7aHMOc8Ik63FRwNSxGsXopFn67KScvMZ6yLAHsWVOottR9enujf1r1o?=
 =?us-ascii?Q?VJciDDc2xqsTojdZLicj4jMqmAevAsq76ZNwqsMMYx48iFCG/oCPOpNs/uK6?=
 =?us-ascii?Q?iWCMAN3HVSpWuHXHhK78Ku3XWjSxnSkWhSGtnSnf2ZVqOmNauO6cuWlVw99A?=
 =?us-ascii?Q?dtV6bIS2NDJi6gMgyeFB6+WPuzTGu010kCbl5BKuPs9CRGhP+dOxYD7q/Mgd?=
 =?us-ascii?Q?r2VVnFCj1PE8sm0lKIbi/3SUSJzkvU9a+voSF1ZGFybesG5nq9489PQhkntq?=
 =?us-ascii?Q?eHrIBcFqdFW5gJRoMw8R5XXCUq5zUbN2GXPpsT+TeqGA9o094y7OEDgso7nR?=
 =?us-ascii?Q?hrYDgggEiMFjmt9x11TQ9nwMIoJUzSJuIntB1E55jGdaYxGlMfMTWYE8MwjX?=
 =?us-ascii?Q?J52qEuDXV4n1edmuFAzdf9rBk2ISo89EESKTK0pNnuIHc4w9xdIYZC2fr+O+?=
 =?us-ascii?Q?JJdtbuemfe7vVSDuixH/Laf0BuvsE7XvcVWBleWep6WCSQ73qC+aM2ZpXX84?=
 =?us-ascii?Q?i5HY895H3g5Xco0ldlhbvmQb6mL8+Zh0EbTvxwtEDXhsXlc4bswUkYYpeYKa?=
 =?us-ascii?Q?UIhTIVbsrwAeclf9/JtGVhUwvyXq96P4gqt0o6am0kEmg6bm68ntqvxuZ12a?=
 =?us-ascii?Q?tcFpO89+tQocrt/zX30WmkplOmzxZTiJlL1UvW1aeNZWUJb9mbDtJhbgenlU?=
 =?us-ascii?Q?1KytK84AxZGsL6aTeohSGZCYMa+Ln83VBfVBWyFYHpujTQR1iX4PSWWZrmLg?=
 =?us-ascii?Q?omExIUrlXmQ+QmjcmD+5TJ2cDeGEu0juuWzvjbYc8Z1tZHqSHdENoMYvq2st?=
 =?us-ascii?Q?vIv+6j9HYktAZh2le9AHoSMrLCRD2egmJag79gAYpka1e8H/cpgjaSOdY6vc?=
 =?us-ascii?Q?1UanOrHSe3TPs70sYqke9WwB4OfKRzHZY88q9yM0NpKJndurZzHhCBk5C0J+?=
 =?us-ascii?Q?BYJ2ru9OiVZZsDt8speDVBHQ6XrP/JDfXIxwSwlsTVHfdIgZRYXqruXAtlak?=
 =?us-ascii?Q?2G/exACjtNcDDqBaQtaHVB6mJBF2d5qaJqgrs37u+wAKVk7LpMOqri2xd8o0?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3600c576-2278-4940-c68a-08da8a30ba17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 02:38:31.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFZRg/8xR/1i+2ueqxfgyRrSe9Rpv2wXJNjyq1djhAFd2BGebmw7YKOhKnBbvvGAmAm/HCJ7+ThT70+7cKyYDX46YCKrJQxNfA5Uvji+Sd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300011
X-Proofpoint-GUID: 8zS3i0L_LSLr7LuQhPF2lQev-G9adfD0
X-Proofpoint-ORIG-GUID: 8zS3i0L_LSLr7LuQhPF2lQev-G9adfD0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_193907_784321_15FA88F2 
X-CRM114-Status: GOOD (  15.34  )
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


Max,

>> According to DIX define:DIX = IP_CHECKSUM.
>> To reduce CPU utilization, the end-to-end DIF for SCSI protocols is
>> DIX-DIF when supported by hardware.
>
> From what I re-call DIX was protection between host_buff ->
> host_device and DIF was protection between host_device ->
> target_device.

DIX is a specification for a SCSI host adapter interface which describes
how to put the protection information in a different buffer from the
data buffer.

The optional IP checksum guard tag was an artifact of the DIX efforts
predating CPUs having suitable CRC calculation offload. We simply
couldn't calculate the T10 DIF CRC fast enough on a general purpose CPU
in 2006.

Now that most modern processors (x86_64, ARM) support pclmulqdq or
similar, IP checksum support is pretty much obsolete.

That said, I don't have a problem with permitting IP checksum use for
NVMe RDMA adapters if the hardware is capable. But it would be good to
get some supporting benchmarks. Plus of course a description of the
performance vs. data integrity trade-off wrt. using the weaker IP
checksum.

-- 
Martin K. Petersen	Oracle Linux Engineering

