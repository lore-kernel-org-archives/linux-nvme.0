Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:41:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323E064F2A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 21:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323E064F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vZkYwzjhpKp5ivza3nnFjX+qFCr8Bpif6+mW6VcuqCE=; b=CLTsUWoGYcDgL0D9Q0WKgWg/T
	z8LljBYGKM3mxyRC0wgHr2JcuoWIinmRS8Jzzyk8utwnGOdlCmgsT1qGEddEWR1O/I0+rfYU0rIT3
	z3nQYZigcH4idKnhFuvWRYNctuT0W3WgssCURzXmwMQPy1aOOa7k2MaUC4V7QY95FIRdc75BRqcOR
	ysFmV0SfJUh4hJnKKxB3skHlPOc2A6RzAWBG+utzjD5Wkgc06TYyOtnLb+irchDBnFwtUw+ydD7vf
	6ttHQBkwYgKoCX7g3MkX4OKDAoPxicrla0OCJtAuf/3BBe4ZmOIuBkYXih0vZDX5eBca3Y/nidDgo
	aP2lsJtGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMdvE-003xNN-9c; Wed, 17 Mar 2021 21:41:44 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMdtV-003xG6-8N
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 21:40:14 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLO1WT110322;
 Wed, 17 Mar 2021 21:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dFyhTKyp5S4/BUdl5+YvNMJU6ZrF90PvHXnv0XMH2hE=;
 b=PdGPIv+jjmnH3o0QmX8z5ofzR8FW12ORvd9zCiJkiDwteJklOfRtmZBdwame10juII+g
 cAfe3LcZ5Ot2083sUyCqIc0uCE3KKdw7EJrmezdnI4cXe5Op3ObDEJuelYq7ExklAtrS
 vy97df7ktR4IHoW5nynCiSJcmtNwJsh1swrGCX+TCmnyip01Tfzog0LNV9yxIDB/mYKz
 tgmFhtut81PLszZm46Kgcj30RFm8F2opNwKGsvggEx5M7X1Zk4UcfNc+bxRxLHTACy7y
 yLyOBzePjdxiSw/hUjx1j4hLZzgg2t6AAACrHdvaMtPZ7xFxjd2QHm7Z6w9yMyXqKLFF JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 378jwbnpv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:39:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HLQ0qB172744;
 Wed, 17 Mar 2021 21:39:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
 by userp3030.oracle.com with ESMTP id 3797b21wkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Mar 2021 21:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVR3kni+1J/SjNxUAWOljT0k2N5tssBP5YCuPLa6XyE4KInRYo6rgra8gnMORYLLJ4aP2qLcSRbbnloEId2oO+Ry9TZkrerDEEWhKhs29iA2DrSdysz1q8KHoZ5Kp887TPY0HKAUACXyW2F9QSvOvuWxq0CS9gKgQYjp0RkEkzTQKbJ3NR4Vla6v1vIOo+mjhHtQNY8hTwwG2bt3VOM/AV9aBsJwUFRZUen8AJanP5fxBXVx1yBbWLPd/0Glz60w2Z8sLrMyzv0uWNDN9wxREpnjklFtxcSMPQVk/9wB2C+AuwdEuxT8TWy8uzREEEEZEOAWIj3zrDJwqnVfcTGE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFyhTKyp5S4/BUdl5+YvNMJU6ZrF90PvHXnv0XMH2hE=;
 b=aE6tHaMM+oBylJQqpgmuThTgmFW9L62zfHBTsujl/r/rAJ8NqTl/nvWUqHVi4KPyqfPUEDneMEfAWMYv/4TdHV3dQg+NZFYuYVsZcz+MR01Jo8+8ycsyGCCJGIrn/6aad/MyNNbOMdP3ljrqpMZlzsRx6qMgaYvNOk5KzpFre1UWKeiHJ/VTkI10v6y0aSyov/2/e3UNeK9/0YhWgcE14D1XVXQ1lJRIH3GV6h13hdZ599P/Ug7g4rc59xvYgqZst6O+P4XD16Qks/P1KpFKyzWUxWIh8zJtg966hAOjPGivdfA9YUXT+IwWEG1biwD17DHtgxfLyaW1dQW6NxPOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFyhTKyp5S4/BUdl5+YvNMJU6ZrF90PvHXnv0XMH2hE=;
 b=pAZyr86Xk18TIL+3rYi4+Enbr+t80wqJRs+UXXYUPldhzYLMP7TIOOwgQVYxclnUk1ZA96K2c3K5MeDMSrbVEUagD5+qZJaFpRiso8oDpVLCeWoGvyps6xbPiZBAv81ZceQlMpaH/H14qmK694RIQO7+JRajX/sC+L3d/sx02LQ=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2718.namprd10.prod.outlook.com (2603:10b6:805:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 21:39:49 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 21:39:49 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: "joshi.k@samsung.com" <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2 2/2] nvme: use driver pdu command for passthrough
Thread-Topic: [PATCHv2 2/2] nvme: use driver pdu command for passthrough
Thread-Index: AQHXG3CXGi7OnX8xb0ezIHflc5GocaqItTuA
Date: Wed, 17 Mar 2021 21:39:49 +0000
Message-ID: <867ACB6E-A4AD-477F-BC2D-DAF2BBE98C4C@oracle.com>
References: <20210317203703.17391-1-kbusch@kernel.org>
 <20210317203703.17391-3-kbusch@kernel.org>
In-Reply-To: <20210317203703.17391-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08988667-10b1-4c02-da5f-08d8e98d313e
x-ms-traffictypediagnostic: SN6PR10MB2718:
x-microsoft-antispam-prvs: <SN6PR10MB27188C7D80478D9866A6753BE66A9@SN6PR10MB2718.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ugy14p9kqw/WkotM6oM+E19YG7Ct6xm3Q/zVP0TXlAB1Yj/6UGexrHjGwEKqMSN+A0lukX/HTbzzPmwp0SO3heFjjgc1wQFhvJfAzCWLqVhh1KsR+jjP8mL2bw7PWzKyWPLYQzF+FBo6gwQgVJaaPpmZmO5AdyiPbdEEiuCB+PzuNMET4DVCyjKYdsC8A0KKL8/wlvzSh+9UrBOo10EZLMw/wMGG2ioRVzOsqoRNHYu2VvlTOyJBlOlMvvSO+/j0rQhn8hlWyD7LDlxFZViP1Yti3LUEEVrr3g6JAofRynOTLPuMSVQiZsWcPlBF9VibkO0g27UJ5ngqF9kxzYGyxNGDx5vGAW/Cak5MA5KOJVud/cqT6MbtaLJWrDlItP7HXEPp3sljQVfToDTMKhhE0yY1vVRdaUTCCFPeluOcy+sOyNhvv38PoIlkz9a5xsyd/VxESheGTE7eO26vISkRcaaGan2F71KAujF9S4tByJAf+PY5wJFe/5lA/brindUh72dndSUDLkAYoBicev0NEDA1Q5k8EJBXm/lZsBvDnb9ueD3p6+dwsvZNg8Eqhs/fCs/3obaQSxvGS2FCFVdh1t0SuFluwiserVcv9CuQwkiqhqeT8ifITySZog4W7ZdkkBSe+w11Rp+JuVK4sOk1XzrKSDffU0dnSgafoLdB4gRYc+Mn/EUu6rMob7qFvZlxD8yJbDqOvRLF4oHpF842YQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(346002)(39860400002)(376002)(396003)(6512007)(5660300002)(54906003)(316002)(8936002)(966005)(83380400001)(71200400001)(53546011)(6916009)(478600001)(6486002)(8676002)(2906002)(86362001)(64756008)(2616005)(44832011)(6506007)(4326008)(66946007)(36756003)(66446008)(66556008)(33656002)(26005)(186003)(76116006)(66476007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OW8nSpVTSbQR72i5VA+vBuW9vNI6cfYPJ2hfOECMfTFwbI1IozpE2LCf6QHl?=
 =?us-ascii?Q?l4yugMfiuTrbgjTE9geSWYoPGds1hjOSiJkNcl1ewOFtsnq8TSe72dyNfrxs?=
 =?us-ascii?Q?3MLZ1yka4+xyRnyii/N1BWzJVLO/i6vmmMpkVg6cTRChlRgwtDvYDhV3h/FM?=
 =?us-ascii?Q?KMopBEvEQEqCj4e3gCD8Rt/2M6cz8qTRQHg0COMROV5l47t4jLwCTcTdIw8s?=
 =?us-ascii?Q?8qK/GKKb6Kx0xSvzqijvZO8q1LoUc63Suj1iNx+kkoSkuT+zgszyMBx2q9yb?=
 =?us-ascii?Q?UkDUsviI8XUmEkU39ySaV2sBk3I3Gfck4gqpVhQBjCDv3mvN65nN2tGqeq6a?=
 =?us-ascii?Q?Er0TcC9iVr4wE3T1NhVxMOj6K5MufpuQBlBqjSa8uepKi3kV6PgtJR39+Ta4?=
 =?us-ascii?Q?Uq6GdDgWIY5wcwdKGrQobCqqneSuV2Rxaym0HLPEF8eXY1gfZ1tq4G7VRMQd?=
 =?us-ascii?Q?EmId/19qSNn20Y7HK34nzsjgaueIL3IHBPjwpS7UcUsk5a926KJBxwyzPLtJ?=
 =?us-ascii?Q?B/+PyiNFVYOn0xiRyXU9sVZJUaLX4onH5YfhpYiOJ2cZSBWPzfK3d0PWeAhd?=
 =?us-ascii?Q?CUYsJjBzbgY/b/3W6IvGoOZTm7Sb53amau7Nhg2XZ3CXGUcPdfjnxqzh+Aqe?=
 =?us-ascii?Q?o9uwP/bm3UW+RxZrTPsyxu30FdzPa1nX/rWztbza4B604WCMfHWDqfZsnG7W?=
 =?us-ascii?Q?ld6n+BIoMOt2YBr7HyhGlJgo0Y0NRhl0QKCrCWfayg5f+e0Qv1VrOcG4GWwA?=
 =?us-ascii?Q?6fpc4a6jxEMTjc+HvKBuOlHswi0QPyRzck5CEmq9EPJ5m1/L0Wiw9XlbSOkK?=
 =?us-ascii?Q?fDf6NuhiLvyfSWzkgNTjhj6dMKX168P8b4WFHy4pcLdt+xaRftMJLh01fzs+?=
 =?us-ascii?Q?Fn4F5cC0WVkUYuylR69C2mh7/NfsCC03zbS8TdLwXsoOXjDqIeglqz1BVU1Y?=
 =?us-ascii?Q?49nR5bI4ZyJpayzQPG7Wsz1fZZoELngehJaZc64CQBKwgWBfiHxXE7XtLR7o?=
 =?us-ascii?Q?4L3DmmNFkPRevS8Cc/3I+NNZ+Sb/ruSlwIGbsLB8q16g/YqfFGkoRUzrWyd5?=
 =?us-ascii?Q?Gyr89xhEXzuV1mD6XKUiTYmHfAwrWYED2e7zbwPPQPKfCzZXVYxgZwbJYOrl?=
 =?us-ascii?Q?ZbvLAAzc0rfLVe39HTMSgp8WY+m5SVWSVF2ccV8KlZdSvW6tPvGgCeVbOyuV?=
 =?us-ascii?Q?4O6AwGYyR2HLxUZrPEegGRI++qaEMrHYqlkWoI5dPeYCJRPIYKayEJfjo9us?=
 =?us-ascii?Q?K1zVhagJ1zsZLwkw2Uc7xAbMK39PVVHJk7fyV08sy3DjpBP8PdJxo2EvC4pV?=
 =?us-ascii?Q?8roQqHoU6EUQrIzIcnYsXMUZKj3RevrqXMLOhJmxrjPFLg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <28EF972AA1F94F47A40A6F6A7AF7F224@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08988667-10b1-4c02-da5f-08d8e98d313e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 21:39:49.7809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+uqBOr5CQs0xSTPXGEiyy6H72tDWjnbfDMXKmhdkCCCzWpSxWvXlcDR1RblhJklyd2UICj/V9pkZ9v1aMjG8jAqpgsSmclcXmQDpyYKfms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2718
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170151
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_214011_455642_182F9347 
X-CRM114-Status: GOOD (  30.16  )
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



> On Mar 17, 2021, at 3:37 PM, Keith Busch <kbusch@kernel.org> wrote:
> 
> All nvme transport drivers preallocate an nvme command for each request.
> Assume to use that command for nvme_setup_cmd() instead of requiring
> drivers pass a pointer to it. All nvme drivers must initialize the
> generic nvme_request 'cmd' to point to the transport's preallocated
> nvme_command.
> 
> The generic nvme_request cmd pointer had previously been used only as a
> temporary copy for passthrough commands. Since it now points to the
> command that gets dispatched, passthrough commands must directly set it
> up prior to executing the request.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> drivers/nvme/host/core.c   | 23 ++++++++++-------------
> drivers/nvme/host/fc.c     |  5 ++---
> drivers/nvme/host/nvme.h   |  3 +--
> drivers/nvme/host/pci.c    |  3 ++-
> drivers/nvme/host/rdma.c   |  5 +++--
> drivers/nvme/host/tcp.c    |  5 ++++-
> drivers/nvme/target/loop.c |  4 +++-
> 7 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 512e5578c6e4..bfc868d6bda9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -575,6 +575,9 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
> 
> static inline void nvme_clear_nvme_request(struct request *req)
> {
> +	struct nvme_command *cmd = nvme_req(req)->cmd;
> +
> +	memset(cmd, 0, sizeof(*cmd));
> 	nvme_req(req)->retries = 0;
> 	nvme_req(req)->flags = 0;
> 	req->rq_flags |= RQF_DONTPREP;
> @@ -593,9 +596,12 @@ static inline void nvme_init_request(struct request *req,
> 	else /* no queuedata implies admin queue */
> 		req->timeout = NVME_ADMIN_TIMEOUT;
> 
> +	/* passthru commands should let the driver set the SGL flags */
> + 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> +
> 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> 	nvme_clear_nvme_request(req);
> -	nvme_req(req)->cmd = cmd;
> +	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
> }
> 
> struct request *nvme_alloc_request(struct request_queue *q,
> @@ -724,14 +730,6 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
> 		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
> }
> 
> -static inline void nvme_setup_passthrough(struct request *req,
> -		struct nvme_command *cmd)
> -{
> -	memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
> -	/* passthru commands should let the driver set the SGL flags */
> -	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> -}
> -
> static inline void nvme_setup_flush(struct nvme_ns *ns,
> 		struct nvme_command *cmnd)
> {
> @@ -886,19 +884,18 @@ void nvme_cleanup_cmd(struct request *req)
> }
> EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
> 
> -blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
> -		struct nvme_command *cmd)
> +blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
> {
> +	struct nvme_command *cmd = nvme_req(req)->cmd;
> 	blk_status_t ret = BLK_STS_OK;
> 
> 	if (!(req->rq_flags & RQF_DONTPREP))
> 		nvme_clear_nvme_request(req);
> 
> -	memset(cmd, 0, sizeof(*cmd));
> 	switch (req_op(req)) {
> 	case REQ_OP_DRV_IN:
> 	case REQ_OP_DRV_OUT:
> -		nvme_setup_passthrough(req, cmd);
> +		/* these are setup prior to execution in nvme_init_request() */
> 		break;
> 	case REQ_OP_FLUSH:
> 		nvme_setup_flush(ns, cmd);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index fe8c32f0efb1..0d4fb8edbf7c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2128,6 +2128,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
> 	op->op.fcp_req.first_sgl = op->sgl;
> 	op->op.fcp_req.private = &op->priv[0];
> 	nvme_req(rq)->ctrl = &ctrl->ctrl;
> +	nvme_req(rq)->cmd = &op->op.cmd_iu.sqe;
> 	return res;
> }
> 
> @@ -2759,8 +2760,6 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	struct nvme_fc_ctrl *ctrl = queue->ctrl;
> 	struct request *rq = bd->rq;
> 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> -	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
> -	struct nvme_command *sqe = &cmdiu->sqe;
> 	enum nvmefc_fcp_datadir	io_dir;
> 	bool queue_ready = test_bit(NVME_FC_Q_LIVE, &queue->flags);
> 	u32 data_len;
> @@ -2770,7 +2769,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
> 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
> 
> -	ret = nvme_setup_cmd(ns, rq, sqe);
> +	ret = nvme_setup_cmd(ns, rq);
> 	if (ret)
> 		return ret;
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 76de7ed55d90..b0863c59fac4 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -623,8 +623,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
> struct request *nvme_alloc_request(struct request_queue *q,
> 		struct nvme_command *cmd, blk_mq_req_flags_t flags);
> void nvme_cleanup_cmd(struct request *req);
> -blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
> -		struct nvme_command *cmd);
> +blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
> int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> 		void *buf, unsigned bufflen);
> int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1a0912146c74..d47bb18b976a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -430,6 +430,7 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
> 	iod->nvmeq = nvmeq;
> 
> 	nvme_req(req)->ctrl = &dev->ctrl;
> +	nvme_req(req)->cmd = &iod->cmd;
> 	return 0;
> }
> 
> @@ -932,7 +933,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
> 		return BLK_STS_IOERR;
> 
> -	ret = nvme_setup_cmd(ns, req, cmnd);
> +	ret = nvme_setup_cmd(ns, req);
> 	if (ret)
> 		return ret;
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9b0a61841851..f94c6e7d5d93 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -314,6 +314,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
> 			NVME_RDMA_DATA_SGL_SIZE;
> 
> 	req->queue = queue;
> +	nvme_req(rq)->cmd = req->sqe.data;
> 
> 	return 0;
> }
> @@ -2038,7 +2039,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	struct request *rq = bd->rq;
> 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
> 	struct nvme_rdma_qe *sqe = &req->sqe;
> -	struct nvme_command *c = sqe->data;
> +	struct nvme_command *c = nvme_req(rq)->cmd;
> 	struct ib_device *dev;
> 	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
> 	blk_status_t ret;
> @@ -2061,7 +2062,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
> 			sizeof(struct nvme_command), DMA_TO_DEVICE);
> 
> -	ret = nvme_setup_cmd(ns, rq, c);
> +	ret = nvme_setup_cmd(ns, rq);
> 	if (ret)
> 		goto unmap_qe;
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ee25492ec130..4d9ea6c2ef87 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -417,6 +417,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
> {
> 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
> 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_cmd_pdu *pdu;
> 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
> 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
> 	u8 hdgst = nvme_tcp_hdgst_len(queue);
> @@ -427,8 +428,10 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
> 	if (!req->pdu)
> 		return -ENOMEM;
> 
> +	pdu = req->pdu;
> 	req->queue = queue;
> 	nvme_req(rq)->ctrl = &ctrl->ctrl;
> +	nvme_req(rq)->cmd = &pdu->cmd;
> 
> 	return 0;
> }
> @@ -2259,7 +2262,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
> 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
> 	blk_status_t ret;
> 
> -	ret = nvme_setup_cmd(ns, rq, &pdu->cmd);
> +	ret = nvme_setup_cmd(ns, rq);
> 	if (ret)
> 		return ret;
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 8fd53df5cf7d..6665da3b634f 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -141,7 +141,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
> 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, req);
> 
> -	ret = nvme_setup_cmd(ns, req, &iod->cmd);
> +	ret = nvme_setup_cmd(ns, req);
> 	if (ret)
> 		return ret;
> 
> @@ -205,8 +205,10 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
> 		unsigned int numa_node)
> {
> 	struct nvme_loop_ctrl *ctrl = set->driver_data;
> +	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
> 
> 	nvme_req(req)->ctrl = &ctrl->ctrl;
> +	nvme_req(req)->cmd = &iod->cmd;
> 	return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
> 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
> }
> -- 
> 2.25.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
