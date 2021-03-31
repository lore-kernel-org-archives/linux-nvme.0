Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69476C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:54:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C606052B
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C606052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s5JEIikrTCqVOImWraLexGKnc6xcCW2HZSjQpf3mH3M=; b=jxNxUkHCNEbh+lc36jsa/agZJ
	iHSwqC7s3AnGa3HfL+jEvg9I4Frf2yhM4al+k3DYWmLAZ4UyEODycYB25SIT1YTsmTvkytP8BGtaR
	yxhm7RwZBtQmP4QMePvGaz9FloelKpPBlPJZzvjus4oJigDZJmc9zzsCHMinLWVFWG8wnPLxkARNc
	fHFdPJdnuo4ra1H6KoyMRhCh9zw2NmMOH1Uv+v9yd3GbHfyMEGt4+2UcLTzChv/hh5itMk16wghst
	e7vqxsXRV9WCv6sGm54wAvOqmEdUieAszN1oKZsQ1HYENG0cUOxkzliqVJZ3CONCcZ20g3oDolJCr
	sGi7XhM0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRgvG-007Q6H-Fx; Wed, 31 Mar 2021 19:54:40 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRgvC-007Q5L-Dq
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 19:54:36 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VJiPJg087227;
 Wed, 31 Mar 2021 19:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6EeFhXQ0d3tYNxGkFhfetxVTXk09jnpJSFFIwQMk3Go=;
 b=Zy5l4U9RDMjKf/AzK/OowMo2YJ/5CFsudyncc6AmMKv455JyLGl8qnlJLUtR/tBfexCL
 D1dtMrp1SbUaFsXrleUOq3v3037FQnKLanW6AvZF80rY/OX5wLkKW3igMpPtcHa5cpZd
 VFlzcKO+jTG0GfZbQncFSGdq+lVPrrAvVqClxK7U++rkMiSurvDTE+1LSgVBLjOBu/2/
 N4Lx46oll+HllZtxg8qP9eDjyiMrEuA6WmuTQTymg8VwGju2af6yYSmpIBUz6vIu+gN3
 SKHo+bXTQq5CsYDuHBxqJabO2mOTOSMR+H21yZb/W0+CrLx8vekRkJIIeEYy3gPmCYyF lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 37mp06sxqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 19:54:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VJpgc7128858;
 Wed, 31 Mar 2021 19:54:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by aserp3030.oracle.com with ESMTP id 37mabptt3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 19:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ9/AAOJw0m0m8ncrRBlMzLiJMT4DbfBER0siZ/v2pf0iBDJ/dViYm/oha0BuzmoxLZZ4oYZXGMhETSlo+gnDHHhlDjlcbqfsgJp0y1KdZUlnGfcbbKZfENTT9n+E6/khFfU0Tlxgi7/WCyZvHn36UKsL9v/qJbh2A59wKm2v7pnaYZQMbaeVsv4B+EgggNNLaYZqhuPVKNFDYxOofaMGG2N1c10MROmDRDDvcVvC6dHrZ1r+IHyfkFrIGgGTEBzJ0k5x5Knx44bq52LzvEhcUNbI6/naO0vJ2I/e7W57cu6xFbTkFpPqun9tOrD/Iq3r8BLFesa8HKPOFiLvm5Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EeFhXQ0d3tYNxGkFhfetxVTXk09jnpJSFFIwQMk3Go=;
 b=EQehDsKmnBTYxRrHnUgT/MAnWfsNpQcUz4Q3dRHVWxK9nbMVUv+GNyO85HKJt28Fw3dggJKtDvxcH5n893Ol4AfgY1DrwhcnF/D9S5ywJyrtBLPOGsjvbI/v+saWJXx9HKuqX1yYI5lZrmrEkXq/0HZa+hBCGEVcwRpf3zF1xKzP7l9CJaDbrFyo5tOBtmd41mZmAP4S9h2UfgOGCnEl8t3ycmI3gsjX8sT/cmIN4ZfXrXFPwhJ3S5elFIyOnRdQH1LQOFNrmJp8OvSzkzElqUbnNhHwEfY49jwVXi42bLugCungPp8NphAtBB6Nzh3CuTVM63WzAHNFVzfiMjd1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EeFhXQ0d3tYNxGkFhfetxVTXk09jnpJSFFIwQMk3Go=;
 b=X/+8krSNz1ITQnlaGOOCSWULGkMRR0zuhWSV09oS+EEnMLq55iB0hKt3r+56sVx85EdreExmwxk2Mx1nSIs6CkG2j8DZs2Y/iXMHkPt3MGpfayAoZgZRqHP5z2Bn755u49qIy7ekxKsjiaXEp3CY2VnqfH8e606fL5CrVS0TBmU=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2767.namprd10.prod.outlook.com (2603:10b6:805:44::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 19:54:13 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 19:54:13 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, Chao Leng
 <lengchao@huawei.com>, Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Thread-Topic: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Thread-Index: AQHXJi+uCqVrwISuNkOtIe+L49QAmqqegt4A
Date: Wed, 31 Mar 2021 19:54:13 +0000
Message-ID: <3DEBA033-50D4-47CA-ACAD-6BA01867FF27@oracle.com>
References: <20210331131228.131118-1-dwagner@suse.de>
In-Reply-To: <20210331131228.131118-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64e98c14-f564-4467-fb78-08d8f47ec209
x-ms-traffictypediagnostic: SN6PR10MB2767:
x-microsoft-antispam-prvs: <SN6PR10MB27673F895E0A9F32CFB70D4DE67C9@SN6PR10MB2767.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdvYrnMZsM4nstCPOPuBFtInkQuJknQwd+tmmphgHnDzyc5aWJvRdDk/CaZO5GOmDi72w2sHOqNAT9GLnnfIJVh9JezH50mZ5JFFKIH3lD+PSKVmG0bCwBjesDkrBPXOJ+1fkaZ+OIOZZwNQwapLkRPtn3Ysq+BuGuYllyERy6M70HUDdx/dP+IY1xET8DJDEMIp0cnIiQ/9dme2XtEJ/PBmQvkBaECgn2V6OY8fnD8bfUwu0pJh5OgJ4mmg1rM2ggaKpxPnX6QD4VVXlo50s0AfdFbv+tooksPZwgyzzYVvJ8KlTgw5KJ0SpivVIpr8p9a0ZWIzJzqr9JsQtunTqa/gsUxOLd3bgqtmH9UaDsAW/xIBdlI4P3lWxLYjUSeZgsTjZd1rH18JO5xiR6R+s9GnaJiPsHpEAOzPMdm22+tGw3Mn6S9mtqFPbQgHH6PY+/WtK69FXvSEmKsF2cDsEaqKdTxkTvv4XYvyJ6hOgxAFpX/QP3gn6xqU5oppujYbzP8pwYOw7bNGIrzH4XXz4AkWYmwEZg6USg6NDGf9NQCH0l0Jp5iimP7uXsfcmR+jKn7TSekmE59RtBAgV39cuD9aEnCMEquN7FhSzcR3NELsfHVT6uLqwOgQZqvQhKwXjebY8/bSMFp5vFDRBKKL+2kzAt/F+k3pWIsg3xPAwoGq8kDkcM2TPRquP+Hffjru
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(6506007)(6916009)(83380400001)(71200400001)(64756008)(4326008)(478600001)(38100700001)(186003)(26005)(53546011)(7416002)(66946007)(316002)(44832011)(66556008)(66446008)(36756003)(2906002)(54906003)(66476007)(5660300002)(33656002)(8676002)(6512007)(2616005)(76116006)(6486002)(8936002)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sx1xGYQ8GzkPCQfPuGVBwKFxTSQP7X/R+/4nbX200Tn1ca9PAHaiGfcokbgf?=
 =?us-ascii?Q?LpdbhLtGIHb62ePj3ISLxNpIzW+WowhqpXrfHhg+bOojdnjj3YjijX7eNh1Z?=
 =?us-ascii?Q?kzqb9b6yre9VaIAR9mAGB8XLE8QRbsOHidi7WIOc2+0lpiBy60j4w/GxLmb3?=
 =?us-ascii?Q?quBbfKnJOHOT4d1SNnwXu0sJ+dcZywfRQt2zkXhpS+WaIEa9NEv6MMCUoDCd?=
 =?us-ascii?Q?uA8oQeS/kJfq+Xc+n1v5UeoaDTGCmbpXslf//bkmlxMj9Ishnn77219l1Dk2?=
 =?us-ascii?Q?K2nujE7rTbmvDT7LbP5gfIRWp9h/QAPrgMFhazlLdpjD3jXpYY6Sf0R8ijF1?=
 =?us-ascii?Q?X1pb3NxsxDssrhcdoU/NJs0UVrytcQd7ozBs6Tw7f2BhtymqTah9nsPv8z58?=
 =?us-ascii?Q?m1Os1nrKAvukED4kk+sYHhgmATpy2iehEsXRWfryZRDevfUy/fW1OyFKMzGF?=
 =?us-ascii?Q?Dhau+9sVzRPcV2a1lmKCku9+Pp6/GaLYOCIp8k11vp2i2OKVQzWE3/E4VAQ8?=
 =?us-ascii?Q?VA6H3R3GnI0qfUUY8YJSQpWTKGKYUZ9bC+CnXZDYlzgkxwHO6bxbocL5vZ+J?=
 =?us-ascii?Q?SQAudVfk1YffB/OhBUZSETEHPjIMP9ZBpjZHPwzm+cKGWnfJWveafhFQkWWQ?=
 =?us-ascii?Q?sGD29iDHkJNYdTi85OgUnPdN6xYyQuR6krWALZPOuV8Mfae4cii6rh98sM68?=
 =?us-ascii?Q?aL0txQNeZ4E3bZg7DmJo7sipRPBk0DZPh2bS1iiOF8A4wKVbDva30OD8sOfq?=
 =?us-ascii?Q?tiXaSptYgrldLPC2PLwUaY04Y9Q6WbjIOGVCXZeMoVUPuyDAdg+HrGeWCE7I?=
 =?us-ascii?Q?OwzRicwF0dhXZUZ/RGMzhHf9AmzIrgFyNwHgFuiLzkGMUxbfsVaoE+Ae9GjV?=
 =?us-ascii?Q?Ar9QaOOG/zFve4P2KcUcpptQPq56HHjFk2YXvOcyZqDavEwj0Z1hBer0IsIb?=
 =?us-ascii?Q?5Q79QZ/P5K+EGTSCsPk9thSD0i4N1s0lovhwA613se476eLTeVgUe8jpwHw0?=
 =?us-ascii?Q?vj2jsj5KpXodtxJgUfa0IwhiA+gUYdDDhGs9Igf+XdyMVmX71WdMCp0QEmeX?=
 =?us-ascii?Q?iXNnErHXDmLDWgUcHYA1FQOJaYJJ/6HzKdqgcQLunIIOKTg8AuzzYRkOhmfE?=
 =?us-ascii?Q?F9Aklhe7+RwUgpQ24UHmIbrihB/1B5zMC2Ws+UO/RSaKGHK8S92BN9poKy0b?=
 =?us-ascii?Q?aR8e9DwJ0I9aY30AP8oAXVPozzKPS8JDvHDT/s3+CZApM/FaT2v0cLbv4BPl?=
 =?us-ascii?Q?2Sd/hFgquS1oe5Xl0rgQg4DgX9x9nSjSjn+VQoSo79D1okEF6QRKInP9kXeJ?=
 =?us-ascii?Q?W+QG6YndguWf8KfsdC3E6tWjmQhAn+lI4GRWbPq6jufzdg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <0B984C9FF9A72242A705969C30D4AC35@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e98c14-f564-4467-fb78-08d8f47ec209
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 19:54:13.0636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htTsdxX2IdJm/xmDv0L0S8VPr/dvXPL/Gcu+i6xWYdkTOuPH56Eol5KN+EuQSktA2Wt8SvoUMJu3E/90CfRYtmbNi+Oj4uhllG5GV6IjO9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2767
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310137
X-Proofpoint-ORIG-GUID: 0-7_CTVouELzBhmeT3NF8hKbJ57ZS3wn
X-Proofpoint-GUID: 0-7_CTVouELzBhmeT3NF8hKbJ57ZS3wn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_205434_907060_E08320CC 
X-CRM114-Status: GOOD (  31.89  )
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



> On Mar 31, 2021, at 8:12 AM, Daniel Wagner <dwagner@suse.de> wrote:
> 
> Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
> introduced fast_io_fail_tmo but didn't export the value to sysfs. That
> means the value is hard coded during compile time. Export the timeout
> value to user space via sysfs to allow runtime configuration.
> 
> Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> This patch is against nvme-5.13
> 
> BTW, checkpatch complains with
> 
>  WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> 
> Is this something we want to adapt to?
> 
> drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..c8de0e37c7d9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3696,6 +3696,36 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
> static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
> 	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
> 
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->opts->fast_io_fail_tmo == -1)
> +		return sprintf(buf, "off\n");
> +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
> +}
> +
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	int fast_io_fail_tmo, err;
> +
> +	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> +	if (err)
> +		return -EINVAL;
> +
> +	else if (fast_io_fail_tmo < 0)
> +		opts->fast_io_fail_tmo = -1;
> +	else
> +		opts->fast_io_fail_tmo = fast_io_fail_tmo;
> +	return count;
> +}
> +static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
> +	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
> +
> static struct attribute *nvme_dev_attrs[] = {
> 	&dev_attr_reset_controller.attr,
> 	&dev_attr_rescan_controller.attr,
> @@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] = {
> 	&dev_attr_hostid.attr,
> 	&dev_attr_ctrl_loss_tmo.attr,
> 	&dev_attr_reconnect_delay.attr,
> +	&dev_attr_fast_io_fail_tmo.attr,
> 	NULL
> };
> 
> -- 
> 2.29.2
> 


Reviewed-by: Himanshu Madhani <himanshu.madhaani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
