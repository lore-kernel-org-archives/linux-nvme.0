Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35624C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mvud0BEY6ckKhTNFaHQeBXG6FXU8EzXm85GcjpGCMq4=; b=vsyZf/4/X27JXo6lQ+DSVxI5Gs
	DyOBexut1aPxeZt71Gk+0GAyD+JA1x5N16xnGs5fm6OVaHjmDpXzoClTxUAr4MtwupT+bWy9JVD39
	RcpiEE6gawR1rSmwmaW+0//mnj7aaKWIbsRyvmmRul17/x6fcDQuYeggmWcp7BsEHVOHM7BUc6nKm
	szR/KVtMFkrR7KACL0FFN2VAmmMIUbkwCAi+B9TMPaTVeF8hpK46BgjbCe7Hd1YuKAFrZik6164R3
	x+NxlxmJT1QMeoU4sDTLky6Oa1q/iVS6uU4VvP+OUY1PyWxRy+HnEvdWhHdE9KGVHpYRYEXnA3S3a
	3JkEPRMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nehwa-0028rO-CJ; Wed, 13 Apr 2022 18:42:20 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nehwX-0028pi-Hk
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 18:42:18 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DG2xJ6028178; 
 Wed, 13 Apr 2022 18:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Mvud0BEY6ckKhTNFaHQeBXG6FXU8EzXm85GcjpGCMq4=;
 b=f6/gvCWt5kPrV18OBNKbr0rknfDfZSRGI4/aC5iiYTzNuugAE9Pzw2m+WAhRCYTffQa5
 FMDeDChiNjSQza0YtVxOBKGq8DuYeOnDXK66IhOFfz09ZQIdBS/8ZUI85xHkFh8ikJkf
 RhyufB778jFuC4Kbb6/hf041DEDoasRmclYHrTWscoFLserF7q9bg3qRf9ckXKZqTWx7
 VWTjw1pl8U7I82DWMvh/QxwoWYR0D7np9egT4jbFME7KhU55n/Lsob+iOx78gPZw9lxV
 tkLXgIp/RShbxAI7UenNHuRrOWjl94BbYr6G65gaRywYaD/7NBHzMZB2WhE/IF9DU6nt xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a2emy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Apr 2022 18:42:09 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 23DIRhmh006345; Wed, 13 Apr 2022 18:42:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fb0k49kac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Apr 2022 18:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5eL3YGIH4gw9Ad6HX8c0mkocDDEtw6W8QBLUb91HIWvIEf2lTdBcSd8tnGXbfcT0kMPmqypZHIGx2rFFylKKYY9xSdqzOXj2BYZ/GLXxJ2EMigJpPE1pyOGcmpWiL99M32iAR/Vo5lvwlRD0IQ0LzBfwZAbeCkP4t3PwVwxxwDJ1cTygn5nF1cWGMVfi8DnsaDBpEceJZ07eu1QPEzgTlMrFSJvKCXC3EilDWCRXA84r06KAi/hbvwOVSsQW6wytjJ/zaBrS9epKdIsrTbQfsko+UT6bulvY5lehGfKZO1snLprFfj0W4v4U9HvKwMke/K8HBFW9zetTKMfwpOWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mvud0BEY6ckKhTNFaHQeBXG6FXU8EzXm85GcjpGCMq4=;
 b=DLo1QnwVkjkjXOtd53sShIwE3oa6VTKDOnRn1v2E5mrOkcGtmemTPJAHeW6Iwfp4JdeMcGvf3UaihCieBVnBfnVy/fEQyf++1grITHMa53Wzbcjs9qFhQ5/+Lq5h5fUUI0RCFemuA3LuYnrxtfoPIdYrRlsCjUIio8IUWSu+osuZwwqJI/8MbfAO0F5rFnH7Q6x7scY3zZaCXYI0FboN2KqfErcl5/YByLOntoewX6X/nGl/G26I9//gv9jlv2q+nza5rcopx2hyWDhfNcmpJKXU09nXLy6P3ipXmpApgPZKH0XSBjWxjDRtx0vjOT2LzA2BChIK38OXez/70KUjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvud0BEY6ckKhTNFaHQeBXG6FXU8EzXm85GcjpGCMq4=;
 b=h4t044jq6+HKpGOehETO5wltMd/d7ZP/PV+TZYn1K1r8cGqx50cdX91wI6L9l9UFM5JINJplmEcGJB6t1LpT6WZXDQRF2/9C0rGf+kqKI+uUgIQm8ToAPfwxbC+4f3vqQ84LzbIgLYqrqXu//d52UsUTodFlZV1Pd36HVM/ucCo=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM5PR1001MB2329.namprd10.prod.outlook.com (2603:10b6:4:2c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 18:42:05 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 18:42:05 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Topic: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Index: AQHYTVMGDC4n3dsJk02M6hir2l7GBazuMbAA
Date: Wed, 13 Apr 2022 18:42:05 +0000
Message-ID: <D7A351EC-4EA2-4409-AE63-914DEF433D11@oracle.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
In-Reply-To: <20220411031249.5158-4-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ebac58e-76df-46fa-52df-08da1d7d4ec5
x-ms-traffictypediagnostic: DM5PR1001MB2329:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB23293F30B586B01297B25F66F4EC9@DM5PR1001MB2329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzSakk7RoS+xTtB6B2azA5JDPAW7HD+tErjFeFFLMilkZC4wx34vVvov64vNZVCi7cQZUBEJ1PqPIz4H52ZHi6I7CzW2JMUR7ENf/g4ZTDGH8AL+HjIUkSw1m/OKA8M1W/2WdNnj8PB83MFFXrNxQnuHOrYhfToNBAr7HLP98B2720XWbG2B0SlVQ/Sh0TeWHRflAsz9MOYPz5fNLPOcno8ZgqB8X1LGDUdRZ7KQUJlHN/gQsQVbVwb9uqd8qaM0ebhQIs95rtY/gkxlc/vZvc3y8Q2zNomshl4C5ZHoPjzt1pbBbqDc/cbH+lwOn28KSKVRWsyyrAPEbQwKx/HfdhQ0STIXuZ0CWgg9s49lhpUWMQELIgwvSFA5BDJT9XaVc4YAOvupOly94Vex9hZo7VGLWCs++cdMRQZejviUDayYbYPLib3t3ob23EurmqWWqNkv42ccZObTvuODZkxEpPoDshDuee95hkBw8OfF0IT2GF6xUYkaatJapgRt3jQ3vP0pqL1WE8LXcRZJTPPfortsZ0YiLMXl/7hFt97Oqki5xNhhoKYaqkyyBk5ze0LCHW+Zg6J94ORwHEtUlfufhut2YR6RKDbgp7TEwkWnzL+kdsWeFBzk8ULJ7GH0cKvSkTNtk4phOhoQfZwKr8Z8b9llQOMICmAz24PcQYILWZv6VKj9ttnPtROSuWf5OfyYKwzr9Ig0pF0XGq3Y1gk7KdpX0qywsh9DB7wiPzn4sqZxa2vf6fcwFV7K+WqAXWBF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(54906003)(6916009)(71200400001)(36756003)(86362001)(316002)(38070700005)(38100700002)(122000001)(66446008)(91956017)(6486002)(76116006)(6512007)(64756008)(83380400001)(508600001)(2906002)(8936002)(66476007)(6506007)(2616005)(53546011)(4744005)(66946007)(8676002)(66556008)(4326008)(186003)(44832011)(33656002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hR0aQK0o25vaD/gprcueyIhTLmT8yJz/s51QzJRG6rA9iE4cRw5EdoNfRSsm?=
 =?us-ascii?Q?qmO2bLA/0BFxdsMt2h9rxyAyj3PrQytzZySEdNROsOELi9fvCBcUUPqbtQY5?=
 =?us-ascii?Q?GIq8PRRR9xo+x0pATrSTk17qWxRkc0AL5qOtIgpldfBSjfvlo+tACCnmlSq2?=
 =?us-ascii?Q?8mLVGv3ymqfOt7fN+qwplQKz+Q0FlOFkrpulUKfZXxnKqWNpeT7ayIIBdPNQ?=
 =?us-ascii?Q?zSpYVqpdPQx+vV3+p3VMQ7W9BjJmtGB3qjDmbBmzMQqjnfCA1H44HMZbZGAd?=
 =?us-ascii?Q?E+Ceaf/BS/LbfXzJ0nH2CxlmnqvRJMM/IJ6snVshdQ5PwD4hkUkuIYvdBcQo?=
 =?us-ascii?Q?aUBEmcNc7nbgpp3Vq94YqgTV58WJ1GUo90YMwaKxwwtkw+BsNbgpmIdyb6Z6?=
 =?us-ascii?Q?/DNUhNCC5B6UAAM4NeZu7Uk+jDBEEH7B4eGxgT3pfQx0TOPAwaT0fF2Yhxi5?=
 =?us-ascii?Q?0jub9ow27y/XNidaW468d2pKDIG4LeI4Y/aiPw+uF72p25lof7ix+kv1j7ex?=
 =?us-ascii?Q?+3DuLdfiAsXMolMYtVwLvimuj8rTR1caojowbK02+ue5ZE09YWpjzRUcL+vY?=
 =?us-ascii?Q?R9Zuzf5FzlhR5tGQEiJJmpo5CEl9rHZ+uWuSlA52XUMrYBqQWcq/xJ9Tol5o?=
 =?us-ascii?Q?qn2Wc/JSA8SZXxoXgfYyfpkcH/WQT8bDJnBLcRfmEIn61/Knrns5wn8GCubY?=
 =?us-ascii?Q?+iueEGrtCWjC/hOS4KuDZuutX52DJAJWawITSw1DgZ3pNXlvquYmLk26lLYZ?=
 =?us-ascii?Q?9olYyYRQLbSz8r3cI/MS9WTwDYwRcM4QRqag8U1iwcZEkgFAdYi/87D1KR8z?=
 =?us-ascii?Q?MngVd0gV373o2ZwCyUmMc40fw5ChjrAY/Ppo8txJLQBJcrxFxKapAMi37bxM?=
 =?us-ascii?Q?eKm121U1c8i3rBJNszgku0i4f6x0Y4JtujmqSJEKl9BqaEAOJMN8d4yqzoOU?=
 =?us-ascii?Q?khoxclPhAJenZ3Z9T3MzgPeJMSH1pcPE/Lo742AAXOv6KonvTfSDikXYlplh?=
 =?us-ascii?Q?coWzW22Y3we7kS8fpvqCSKEZ+A1aDI+md460bcWv5NoyjA2wef62qZ5ouDae?=
 =?us-ascii?Q?bFybg/uXiTIgzHzvrAPhkqIGAQ6vbNK+iZyCnhmjw9fzAvNRRjDhuHebxsNj?=
 =?us-ascii?Q?XZDlmj8BL7IXoatP1cW9ztJylWmHFU04rrbWzBwQ7nG3E9g/LnRoIh7jRcjX?=
 =?us-ascii?Q?kTwyxrnElIg3nNJ8QAhbq8/n5qJAUrltjV1xL5QDFwOFCy8VtsaPpX+wxLdi?=
 =?us-ascii?Q?cDjuYu2jubLWjgcu/F0WPoIW86BE3IOfLb55+gnjSxiLFiLaTJeG453wJJbp?=
 =?us-ascii?Q?PVAqsU43FV9dmDZIW13YQS6SKTvQxKjIBJAG2qn2IEfnhLj6U7Mp/Frep2vK?=
 =?us-ascii?Q?2+aiR5V3vLSKka9HwKeIvFo63dlzE1UmhaJzD8PB47VkWwPrxR9mx9eAVmlE?=
 =?us-ascii?Q?esHXniVvvT1/FFSG/LouwYgVfLK9y5ywbMyK1snD/aKzMy0MeTaKnDShjQLi?=
 =?us-ascii?Q?7ZYVQNksFrXreKnmpWRgraS2jud20xserTMiEmaXIYU6KZ71lwjpuGzbRqNS?=
 =?us-ascii?Q?E4tGb2nXHd86TPq/cBC6o61W2sLhjKGGW9xQRqJNrr7dSZi8c6v5j2+2KWDU?=
 =?us-ascii?Q?98Jk0LAMDGfgKlpnwIXZl0Dc5V3vMgkMdmNGldn0TXIrHEZ83nXijdiYQK9W?=
 =?us-ascii?Q?1qPCrLFPok3A7vnBq1EMnbfn2tfxjK4wjt4EJBr1jM294bACnkGE9V+mqYrE?=
 =?us-ascii?Q?DbIHNmfjm1tXcGmyub+DZxfnDj4YMlBhXTOMzhCMzQyu7/19SfBFqNNeusPt?=
x-ms-exchange-antispam-messagedata-1: bWdcamCNg2Wpyg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19F0D69184DD054A81E96420763B0ADC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebac58e-76df-46fa-52df-08da1d7d4ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 18:42:05.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDJoywrJbdlGH0JSS5UWPmk5pYGQCYaLwK+kR9u2FUIcFtcG1coHBeLuSUQJ2cB/KtbPuFCvCLYoj13VU5dkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-04-13_03:2022-04-13,
 2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130090
X-Proofpoint-GUID: sTVs_N_BVoumTMoLNJ0TEkZXc-TcL3p3
X-Proofpoint-ORIG-GUID: sTVs_N_BVoumTMoLNJ0TEkZXc-TcL3p3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_114217_638898_C9E7B0C2 
X-CRM114-Status: GOOD (  14.56  )
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


> On Apr 10, 2022, at 8:12 PM, Chaitanya Kulkarni <kch@nvidia.com> wrote:
>=20
> Mark internal passthru requests quiet in the submission path with
> RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
> path, if nvme request is resulted in the error and request is marked
> RQF_QUIET then don't log the error with nvme_error_log().

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>=0D

