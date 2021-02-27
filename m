Return-Path: <SRS0=5wgU=H5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B8C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Feb 2021 14:57:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BB864ED5
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Feb 2021 14:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BB864ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gviCtWx9fJNVM5AogF1JNhAKBRBwhbGwMgJSfodSJ8E=; b=uz3wS4BA8S+ekZR69NGIUcQ5c6
	3c4/PWF3mR7iMz2qBIrgrp8VV0jyogkNDNNrEHh0ePaY/ZcYuPoXYDv/WePcdb255LJ7MSd2PU9H/
	CvSClw1TOw6IPe8+pgNNnX8Ldy5kUn3SmjdvbCdha/TE5nYaP7Sq709s3jqucUmsY62WVP5a9pzWQ
	sFaX9Vc4d/KFSe0LJt8pA2vsE2mLROC5PGNCbN0Lht3TyGYBJfkZUukFkQ0WTMa9dMdDsUPsXkAKX
	WmYNcR99wemjNiMa1UUc8XujergqVJscGN3wdFGzb8Z3rszxXxYiBD8tYLSoDMrdrIlVqBd/kpuUb
	5TVpGHBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lG12B-0008GU-SY; Sat, 27 Feb 2021 14:57:31 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lG128-0008G1-66
 for linux-nvme@lists.infradead.org; Sat, 27 Feb 2021 14:57:29 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11REvFTL004131
 for <linux-nvme@lists.infradead.org>; Sat, 27 Feb 2021 09:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7NucMijCpzXihwlLJrPE0GueVzgubIewQFrBoK/lbTY=;
 b=akw04Ph6KiAQOTQuJt00EyXCKwrOeP2y7dJ3Hrh5YH75RJsaLz8nmVG3OpC3zAyhuNH3
 7D5Xd6hD1pet1w8/78Ue3Do1eHxRBPxvpas39SLRHEB2rksdyIs74bLO0tvdJlKVKzBg
 ECuUMCrve44A4pn0vPqdOhJpN95Qyp4bW1NUPtDeYW/D65pW/7u8J+sY+O6B08e63sYD
 qBlC/Ui9p7sCMVwLdxnQlW5rEDkkiX/qzzUG4b/VqMNUZ2yhpwJVPSHJ13AJtykt1dqI
 R7xEXOYCYT5qjrF/myZb/5RBtQa13XxCXPGA5ZrmoQkyFCzZXGWlGg0Vua/LwDezJj5h Og== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 36yj4jrej4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sat, 27 Feb 2021 09:57:26 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11REu2Ds030059
 for <linux-nvme@lists.infradead.org>; Sat, 27 Feb 2021 09:57:25 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
 by mx0a-00154901.pphosted.com with ESMTP id 36yhkjjyhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sat, 27 Feb 2021 09:57:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCD1E01zEs4wE+SKDfFaEvtMrE5opcz0kPv9sL0ES1rYgnXUPwM3bNFvntGhYpnMBNlaCvJozGs9hlqZDsFX6lKD5A2RMOTbpVAZzN8WoXgacQ4VHnqEb8oyGieD4PQbbRU5Rim48WahpoaB6Xjjtj2IY+BOrQ8XQAFiA1zjdmlHCHqwfUA5VFd1rJn9aoYVE5G1xPmZo6OCKxY2KawZqjKhuk/RqtziG5LmPqclUkUukOJaqicHO67ffvIqL2NVw7hHz/wV5nxd5MvkuE2dLAxD3tsGP8eYt/W9ej750Bv2SvHNh3inBz5vb6j7NN3z2QBoR0MUhlKiwqqWkEhv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NucMijCpzXihwlLJrPE0GueVzgubIewQFrBoK/lbTY=;
 b=RXLgv02Orx+iA5DK9/6O9O5X+43xC0/gi0fPOrQYVmxy+pSSgJdq1ZDSodxDemYBrb+SGD65fsVuiKmt5GQ5fpMM4lxcgCx+4+0R4l+I4AAEijbfSVPdH18X9d19q8/T8pIPZ18OkJHohGGp8PFsPih9gZjdOslp3IZSRzkWJ54GLfkAQ6iP6P2SQqBaDAv+ZzK6wIoWLlmIoObxcxYywsblS7HPTAuMdPJ7m5eWKCUv+c6P1FFWIlfY9KBL4GeQWv7WsKYgI2PQUOJxefRROfOStk5GZv7HewaF9rLjDCoUA2NxqmxVBjZdgouYf3dFcu9LLg7wkYk2lCxbqyNNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3556.namprd19.prod.outlook.com (2603:10b6:a03:1c9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sat, 27 Feb
 2021 14:57:21 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2903:29b8:91ce:57c4]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2903:29b8:91ce:57c4%8]) with mapi id 15.20.3890.026; Sat, 27 Feb 2021
 14:57:21 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-discover: Computer freezes up when persistent device loses
 connection to controller
Thread-Topic: nvme-discover: Computer freezes up when persistent device loses
 connection to controller
Thread-Index: AQHXDG110OvEJ+VPRkuYgXzCViT0GqpsGMF0
Date: Sat, 27 Feb 2021 14:57:21 +0000
Message-ID: <SJ0PR19MB454458D28B479E2B8E082294F29C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <SJ0PR19MB45442613CD5D226582EB6DBBF29D9@SJ0PR19MB4544.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB45442613CD5D226582EB6DBBF29D9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-02-27T14:57:20.985Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Standard; 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 150382d6-4a3b-423e-9fae-08d8db2ffc5d
x-ms-traffictypediagnostic: BY5PR19MB3556:
x-microsoft-antispam-prvs: <BY5PR19MB355640ADA45206A3FD134F3AF29C9@BY5PR19MB3556.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YPkvy72U2RkyjbNf0w1LXnJjV32o2FY/Dpz8itoBjfxB656vfwhY+lUWV4g7kf+GxG2OOi5kc4nmct0fSE5KTS47Vu92xcZqZ4fGjXqn32GLeSoxjOtKD0OhZCffFJbOXGgGvenj0Y4cLtHp1xXjhxzV8FzE8kv12ddTnX6vbxAfJzMc1DmfHZxUu8GkGOaZAZM2ADSngLhQXe1Vp9h3vHi9CDH+scDKt/KIT0d7CnQ7OUeP97AaPA+6wU3Kjbho6oQJDY4DVRJsiArgy9GwVRUt+BIvGhY/Vwqpmmpi+7Tnf9nEO2a6chaHRWdfzoYslLmzAeD9Cun8ao1Tb9WfZ/w6TVK4y8R9JmdnXs1/7XIwr7oFY27uhUGdRyHlD6/iGD3M50XMXfs4AiRScnoBddRldKE90e4dfqc8/iiZA1JPkIyRxh8JnHOpb11yJeCiFTyOluTzVlzrzll7GzCA7YMejZwB9hEJAFS1m5yZSI6qkbTAsyJ7aYMhV0MNqwrFUXGUTIa+qHfkQMdGzAzuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(7696005)(6506007)(53546011)(64756008)(478600001)(66446008)(5660300002)(86362001)(66946007)(55016002)(52536014)(9686003)(66476007)(91956017)(6916009)(76116006)(71200400001)(8676002)(66556008)(2906002)(316002)(8936002)(33656002)(83380400001)(26005)(786003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LKGDih3xDzkzT83N8jrlGCUa4yfYM/J67TmsK+IaIa7xK+FHUQgnCqTGK1Cs?=
 =?us-ascii?Q?NhWBDMDCJiW+VJXUAWOG2ENn6OqG6gmlKkP8C0UvZ3e8Tg7tVZqRvfB92FaF?=
 =?us-ascii?Q?jb2PL5oBkUpWHVveE3CB+FAOiXcjgQM30rSKJKLqPR33zduEnno350jROfhD?=
 =?us-ascii?Q?xaPq+F+duaa5e3M7PqyPhmt8wXeYZRrZd4ZhBlZEe5gTc2BHtkZTqWyHnew/?=
 =?us-ascii?Q?Ssf60fI3D+kGsACiaIl8GhpFV/NSYenU7IJI5txw4obYjJIT7nFnFskZ3CAD?=
 =?us-ascii?Q?l7wup3IIw/awGI1fjza4cK/vDa+IhYlZp286P72g7LlZHI2jLokhmRCjdzY9?=
 =?us-ascii?Q?mWXpEcege8wjCShuVpK5OhTGdGQGLjFMVt7+wx+0ToCTJQ2zq4fP9ch+atbt?=
 =?us-ascii?Q?+7dtXgiYThwUW3vbu80TItnBMFT71btWBguAgUrIPCC959SoyVGAm6GHVEmB?=
 =?us-ascii?Q?u8r/0465OXm6iR5K2SKCTF7L4WoTdSsB5tcbVbujhAVWANM/s9LFqoULQaSi?=
 =?us-ascii?Q?mLY4H/eJUb0NqQkrLdReVOVrlpu5rKj+Iz9Uj06Gynr17qaiADWDlkf3UqiT?=
 =?us-ascii?Q?IRWtHO2hkl94YBZtM2Qhb/6jSbPshN6+iwOjtQ+kP9nxUpYYJJCtG5UccEZT?=
 =?us-ascii?Q?1kItPDzma8LO9fDF2/RzY7Ji/n0YxDuk51uQNXyTqGGFluJ8BEQJoyIo7TOI?=
 =?us-ascii?Q?NSg+/W7SVD9iKSrUOEW/oMYVWgDSXqu84jMrUeHKloNgODDq3vhmEt6COo8s?=
 =?us-ascii?Q?/UL9NPs2CATNhvK86wRaYNKUOxySLAEG0IKvzjyTWXMk4BdCpr4MyiMuPFyT?=
 =?us-ascii?Q?sRdOgUFT8rFNz5imsLXQNx95ezthLcwC5FJ5HiZ8svA+RGrKwi9aKWvMyDe0?=
 =?us-ascii?Q?8EKwmTjlEElfaiazVXaESGDjfGRvkG9fwYxaSAayVksIECo29PxT4BV8uVNL?=
 =?us-ascii?Q?HU/hS6Fnr6kiqHXklQHgJ4KxGHpPAWuIMh9WGY5TGW/vZlUdBVIXjeM0fUXZ?=
 =?us-ascii?Q?Z99v9I6Bs24OvZ8AjumNlrXBveJ3sSUEFt4sAtNdKz0eWTpTv3ZlJ5Ekq081?=
 =?us-ascii?Q?nqkuYtPhN0Y4CZUcqB+17Pgv2wQFg21xip5xWlHnXgpVcg/JUBnTJYF110J3?=
 =?us-ascii?Q?6AWrROSX+y3/5VpwjjQFKjwmV7JyJiMw6tbqHyWxP0+tAeoH9W5KqVQ8mJ5y?=
 =?us-ascii?Q?VmficYgm33mD27R3qmtg9ChwNG9NH8FAgpEAeEmrTl4yXfBZGBGZlfroowtP?=
 =?us-ascii?Q?Vy4tT6IMWCnmKXUTcQnzJ2uRUSsy+71ftu3VkWZtQqqS+XjnV5MrgawYrpBG?=
 =?us-ascii?Q?7CRUCSrYiLEDsZ0Y2cBZYJvE?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150382d6-4a3b-423e-9fae-08d8db2ffc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2021 14:57:21.5670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rakAxu9IIQ0mT0Fjd7YGlQb+80eCcrW8Nh+lbP0GREyAcf3P74r+ODONGK9das3Hzwq+mxNqPTQNMLCFDWfcA8p8UISuLrdy5jWtXbSLDWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3556
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-27_09:2021-02-26,
 2021-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102270131
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102270131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210227_095728_463526_91FA561C 
X-CRM114-Status: GOOD (  17.69  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

Update.

I reported this issue after experimenting on Ubuntu 20.04 (kernel 5.8).

I repeated the same experiment on Fedora 33 (kernel 5.10) and I'm not seeing the freeze.

It seems that the issue has been resolved between kerel 5.8 and 5.10.

Regards,
Martin

________________________________________
From: Belanger, Martin <Martin_Belanger@Dell.com>
Sent: Friday, February 26, 2021 13:41
To: linux-nvme@lists.infradead.org
Subject: nvme-discover: Computer freezes up when persistent device loses connection to controller

I was experimenting with persistent tcp connections using nvme-discover/nvme-tcp and nvmet-tcp and caused my computer to freeze up.

The steps are as follows (detailed commands below):
1) Configure nvmet to listen for tcp connection at 127.0.0.1:8009 and configure 2 storage subsystems.
2) Use nvme-discover to set a permanent tcp connection to 127.0.0.1:8009
3) Confirm that a persistent device was created (/dev/nvme1)
4) Confirm that we can retrieve log pages from persistent nvme1
5) Remove all nvmet configuration.
6) Confirm that the persistent device /dev/nvme1 is still there.
7) Try to retrieve log pages from persistent device nvme1
8) Computer freezes

Detailed operations:

1) Configure nvmet to listen for tcp connection at 127.0.0.1:8009 and coonfigure 2 storage subsystems
# modprobe null_blk nr_devices=2
# modprobe nvmet-tcp

# mkdir       /sys/kernel/config/nvmet/subsystems/storage1
# echo -n 1 > /sys/kernel/config/nvmet/subsystems/storage1/attr_allow_any_host

# mkdir                 /sys/kernel/config/nvmet/subsystems/storage1/namespaces/1
# echo -n /dev/nullb0 > /sys/kernel/config/nvmet/subsystems/storage1/namespaces/1/device_path"
# echo -n 1           > /sys/kernel/config/nvmet/subsystems/storage1/namespaces/1/enable

# mkdir       /sys/kernel/config/nvmet/subsystems/storage2
# echo -n 1 > /sys/kernel/config/nvmet/subsystems/storage2/attr_allow_any_host

# mkdir                 /sys/kernel/config/nvmet/subsystems/storage2/namespaces/1
# echo -n /dev/nullb0 > /sys/kernel/config/nvmet/subsystems/storage2/namespaces/1/device_path"
# echo -n 1           > /sys/kernel/config/nvmet/subsystems/storage2/namespaces/1/enable

# mkdir /sys/kernel/config/nvmet/ports/1
# echo -n 127.0.0.1 > /sys/kernel/config/nvmet/ports/1/addr_traddr
# echo -n tcp       > /sys/kernel/config/nvmet/ports/1/addr_trtype
# echo -n 8009      > /sys/kernel/config/nvmet/ports/1/addr_trsvcid
# echo -n ipv4      > /sys/kernel/config/nvmet/ports/1/addr_adrfam

# cd /sys/kernel/config/nvmet/ports/1/subsystems
# ln -s ../../../subsystems/storage1 storage1
# ln -s ../../../subsystems/storage2 storage2

2) Use nvme-cli to set a permanent tcp connection to 127.0.0.1:8009
$ sudo nvme discover -g -G -o json -t tcp -a 127.0.0.1 -s 8009 --persistent
{
  "device" : "nvme1",
  "genctr" : 4,
  "records" : [
    {
      "trtype" : "tcp",
      "adrfam" : "ipv4",
      "subtype" : "nvme subsystem",
      "treq" : "not specified, sq flow control disable supported",
      "portid" : 1,
      "trsvcid" : "8009",
      "subnqn" : "storage1",
      "traddr" : "127.0.0.1",
      "sectype" : "none"
    },
    {
      "trtype" : "tcp",
      "adrfam" : "ipv4",
      "subtype" : "nvme subsystem",
      "treq" : "not specified, sq flow control disable supported",
      "portid" : 1,
      "trsvcid" : "8009",
      "subnqn" : "storage2",
      "traddr" : "127.0.0.1",
      "sectype" : "none"
    }
  ]
}

3) Confirm that a new device was created (/dev/nvme1)
$ ls -l /dev/nvme*
crw------- 1 root root 240,  0 Feb 26 11:09 /dev/nvme0
brw-rw---- 1 root disk 259,  0 Feb 26 11:09 /dev/nvme0n1
brw-rw---- 1 root disk 259,  1 Feb 26 11:09 /dev/nvme0n1p1
brw-rw---- 1 root disk 259,  2 Feb 26 11:09 /dev/nvme0n1p2
brw-rw---- 1 root disk 259,  3 Feb 26 11:09 /dev/nvme0n1p3
brw-rw---- 1 root disk 259,  4 Feb 26 11:09 /dev/nvme0n1p4
brw-rw---- 1 root disk 259,  5 Feb 26 11:09 /dev/nvme0n1p5
crw------- 1 root root 240,  1 Feb 26 11:16 /dev/nvme1
crw------- 1 root root  10, 33 Feb 26 11:11 /dev/nvme-fabrics

4) Confirm that we can retrieve log pages from persistent /dev/nvme1
$ sudo nvme discover -d nvme1 -o json
{
  "device" : "nvme1",
  "genctr" : 4,
  "records" : [
    {
      "trtype" : "tcp",
      "adrfam" : "ipv4",
      "subtype" : "nvme subsystem",
      "treq" : "not specified, sq flow control disable supported",
      "portid" : 1,
      "trsvcid" : "8009",
      "subnqn" : "storage1",
      "traddr" : "127.0.0.1",
      "sectype" : "none"
    },
    {
      "trtype" : "tcp",
      "adrfam" : "ipv4",
      "subtype" : "nvme subsystem",
      "treq" : "not specified, sq flow control disable supported",
      "portid" : 1,
      "trsvcid" : "8009",
      "subnqn" : "storage2",
      "traddr" : "127.0.0.1",
      "sectype" : "none"
    }
  ]
}

5) Remove all nvmet configuration
# rm -f /sys/kernel/config/nvmet/ports/1/subsystems/storage1
# rm -f /sys/kernel/config/nvmet/ports/1/subsystems/storage2
# rmdir /sys/kernel/config/nvmet/ports/1
# rmdir /sys/kernel/config/nvmet/subsystems/storage1/namespaces/1
# rmdir /sys/kernel/config/nvmet/subsystems/storage2/namespaces/1
# rmdir /sys/kernel/config/nvmet/subsystems/storage1
# rmdir /sys/kernel/config/nvmet/subsystems/storage2

6) Confirm that the persistent device /dev/nvme1 is still there
$ ls -l /dev/nvme*
crw------- 1 root root 240,  0 Feb 26 11:09 /dev/nvme0
brw-rw---- 1 root disk 259,  0 Feb 26 11:09 /dev/nvme0n1
brw-rw---- 1 root disk 259,  1 Feb 26 11:09 /dev/nvme0n1p1
brw-rw---- 1 root disk 259,  2 Feb 26 11:09 /dev/nvme0n1p2
brw-rw---- 1 root disk 259,  3 Feb 26 11:09 /dev/nvme0n1p3
brw-rw---- 1 root disk 259,  4 Feb 26 11:09 /dev/nvme0n1p4
brw-rw---- 1 root disk 259,  5 Feb 26 11:09 /dev/nvme0n1p5
crw------- 1 root root 240,  1 Feb 26 11:32 /dev/nvme1    <- Should this device remain if the connection is lost?
crw------- 1 root root  10, 33 Feb 26 11:11 /dev/nvme-fabrics


7) Try to retrieve log pages from /dev/nvme1
$ sudo nvme discover --device nvme1 -o json

8) !!!! COMPUTER IS BRICKED !!!!

Regards,

Martin Belanger
Dell Inc.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
