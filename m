Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421ACC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 18:39:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D296C64ECE
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 18:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D296C64ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cYs7M/sFybeqkZKdS4KWnszZsTsBGL/6VLORuhZtLU0=; b=oIlfPz1ycTzsBayoL9TJpJrYw
	fplHVpVQ2TOgJ3D0re/NtidEN4ws0vrSUfDfZy7/DJLJtW2QCT3wS1dmjCezZq6pkSkdyxbOO7Dgh
	YzPR6xDo1aCTsp6M5bN9mmxFSHWqr+gWdP3dJUB3WyHjCzp25RwJKF6EWk78TV9LMZzGG5ycqwnjy
	a0OAbAj68qehRuIzK5YJBjR0Kn3YiOtjeH4uEWNNWMNms2I5O5PzRH95iSQEPdNIl1PTi+PnmzqyW
	cLHw1JEyPj5UyldqPi0hkerSnMWe4bRd2GGHY/Gq7uH1ch4RGdJM3Rcai0TPdagQkdxeYpU8+JBM0
	nW1hA4UsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCoC6-0007y6-LK; Thu, 18 Feb 2021 18:38:30 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCoC3-0007xL-OH
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 18:38:29 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IIPJsW007581; Thu, 18 Feb 2021 10:38:12 -0800
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 36pd0w07s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 18 Feb 2021 10:38:12 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 18 Feb 2021 10:38:10 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 18 Feb 2021 10:38:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 18 Feb 2021 10:38:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju27EVj+AUMsp2hf797dP/VvBtT8ZpsQUOt33HTW18kSFy66V1HCcQj6PsLv3JFWSFyT1FKisNfPWrQK8kxW6cNhr6C5ImOvUuhjx5+EmIp6BqBQJpIJap1458XUcWfRFyMtaJAd7AxGbyIKT7qY9ij/qntWeCxRHgYk6bPP4Zr2jnEyG8c4hn4oBafSsRfeWcyM7IIgm3xpYTisLlQTEGnljXFY3h5KqbNJjQnSb6Nznv8Ccoc96CuoFI+WUP86NdZ/4TSg26wSaBX4UPGIRrhBI2dpC8qNyBjim/UN80pdTRGQfIWPKzWIY/jTMHEGvYd8F+AODElhrWk5tpqOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLwHgF8edCCExRxBO9RJdq8omIUdLQ0z935w/RTmXe4=;
 b=DZpT0nvyuL9Etxyt/5qcw+ujguFRQeEVvXyTfaraW9/lDNRfpj7ebsCAP6sfqxQWDwmzBGEPVZpni0e/mZVnKvdU8m+a36gFfOQQyszlKShChFTkF0GXRSUG8vz8L4wASZT2XMtWf1Gheuj3hw2WBfil1jcRiao4P05Bi80oNAGpSkIWzJEXCtcZcaCa53jDg9DtzlaRdV16tnJ1oQ6So5S6nnN+aEzlwgQ4WS3h7bUzqfQ/2MzlBxv70vrBzT1yzVmmQ/yuKGxduP12fCTknh1p69JjI32zO9P2Md8sP7/oUeybj4MOeP3a7Jzf2OERgHW1SjAAvGrBd9TtQdOXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLwHgF8edCCExRxBO9RJdq8omIUdLQ0z935w/RTmXe4=;
 b=sJcRrm7CuUQhafIwOt8nHS0fUHRS5ToC0BaCz4rre8e1MOnUtC/lRqELDAZuoLhhBBOVXwbcMn+ti2LBGhDKuT1giFdT/jRK+uD/auevfhQHWae7txpVhN5qkCYlJBgrI/EBluJ2fY1icDENQWGmid3GQhf9N5uZZNXwfMJ5LiY=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB3957.namprd18.prod.outlook.com (2603:10b6:510:1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 18 Feb
 2021 18:38:08 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::ddb2:e0f3:6511:ce83]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::ddb2:e0f3:6511:ce83%5]) with mapi id 15.20.3846.043; Thu, 18 Feb 2021
 18:38:08 +0000
From: Shai Malin <smalin@marvell.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: RE: [RFC PATCH v3 00/11] NVMeTCP Offload ULP and QEDN Device Driver
Thread-Topic: [RFC PATCH v3 00/11] NVMeTCP Offload ULP and QEDN Device Driver
Thread-Index: AQHW/XzyCQakpkZPDUGk3xKAeiwf/KpeQyhg
Date: Thu, 18 Feb 2021 18:38:07 +0000
Message-ID: <PH0PR18MB3845E15A62826C9B5A520628CC859@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20210207181324.11429-1-smalin@marvell.com>
In-Reply-To: <20210207181324.11429-1-smalin@marvell.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [2a10:8006:bf01:0:9593:5dad:567d:b9f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1075d9d-8aeb-4ba0-b73d-08d8d43c5617
x-ms-traffictypediagnostic: PH0PR18MB3957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR18MB39578A444C0E5D43442CA7AFCC859@PH0PR18MB3957.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOcKnKsrrRSoPqAz1sShH8OaSrUNCWD/VIwsHwfrhiMHAhP+o1uJJ0k+SvGuiZG2xPqJDEMiQhdleLPLIDUT/OWxZCgNXkPw7m6uFi2p8APmygrmXIO+9StNplEu4TJwX+tpzUdFc+KvPK8eMst1c0Rw+gLRWXtNiAzi6eJk45Ht/fDNqIDGj8pqA2HgNbG/qhG6I1IwRMNfHDwLYhsDI8SkygIvYf9haH1gVU/oxo5/Ebg9K2zx8ECp0mDXZ0RK10i/ybU3WVpKzOHnSN5hXqr5Zvg3jqH7mAWHllBwYBUECpA4OmZUw/1kjcHj58ebejkKAyKU3LeWrYl0tlkq5DoASjdaSvUbMNgFH9CStjZ38srEu987+ey3W84UWlv5xhkA0griLheBx0nYDl0L6W1fHw7utM3930A8E7tW+uEx7Xjt9tirZ3Gdvua3zUCUSXomRurWCNJiSdH6gtVIICfpy1t1haLmXEv4SFTVXTLR6R8mIyIu2KbAjnUw7itJPVu56HaYu1lSO4stcdsv+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(316002)(52536014)(66946007)(2906002)(478600001)(5660300002)(4326008)(8936002)(86362001)(55016002)(8676002)(186003)(110136005)(6506007)(7696005)(71200400001)(64756008)(7416002)(107886003)(54906003)(66556008)(66446008)(9686003)(33656002)(76116006)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pub7cZtJ85+vUXRobIduxe1vvz6Wo8SjnKxFoYmL7oJcJQGI/jYvOq5KWkbZ?=
 =?us-ascii?Q?dC0d9up5kvVGETje+VUvDeSSFZPkdPz7NEWKoH7UF4u3T04iLmh0xHyNVkaN?=
 =?us-ascii?Q?FoNVun9uYviUeAR7F++XOvNrOZcpm3SmQmvDd9gXG+ymCgSDzqtWmWaTHnpI?=
 =?us-ascii?Q?Qt47LWjxXazZOAyYon4IG22ZnVQsbsqKnt4ywniySHddRhvZMgB3bjqH2xd8?=
 =?us-ascii?Q?M3OVHAA0NbgDTmE41Cx/MiJ+8+viSYkZn3LwKtg7DBLNHBZ1yx/okHg/5A7j?=
 =?us-ascii?Q?I0QJxnIU+yYL3K0vHPGzquwmz8XNHPNl7X9iaVxxPpQV20/hiFydhW/Ys8Uo?=
 =?us-ascii?Q?Uob+fKpGEvO5dfyd+8Ih4XeMochCfi/V/tkOk4tFg5ejcXxMh1DfsrcoQLNH?=
 =?us-ascii?Q?CF7gQf5JnqKqp/dQvXt7OC2JqPGqV55rQJNqkuzl1L31mqrYZZG1ef0KUv1g?=
 =?us-ascii?Q?BtkLhdhJ1kNX9LaJ57xMHjkxmZHne/QAhg4L4lpD7mDMSvDKT5rXxt8Mn0KR?=
 =?us-ascii?Q?laZ1c/vf8RETPk553oZjC81XhgQ+bRdWL/420sv37f49WF+Gfsp/jEyy7h+j?=
 =?us-ascii?Q?jRgv9zvM7Vq43f85k75Pl5uDha9jY72pnLxW8uxVXG1u8xBoQgEoSo9tNCcQ?=
 =?us-ascii?Q?L2iBjZGzcOoKAd11wwAXPRCRITr0rLfFNN1IKSk3z7SZRr/aYK3FEXJ/Denl?=
 =?us-ascii?Q?unXIGRXqzkGA38uBvC+Uoiy2UXq0jSHbj8xAPaiEwHKR7xUZOVMvCtWngQNO?=
 =?us-ascii?Q?XTX87nm/jB7kvrrGbQadYH9vkuNZXMWQ4giWg4khIXtqtq3WOohUVUe96bgD?=
 =?us-ascii?Q?OvylOp7z01Lfv6CJh8VNVlVDkDW0jwnDt5ruUy+p6doTLZOicrCpjdRcR6dW?=
 =?us-ascii?Q?ohyAVPZXt3s4pO9PMPVGiIqzBhbBJykVppbLEyHWKEkGhhLKUzKXLVTYCKV8?=
 =?us-ascii?Q?EmX7LHRQx8Nxjt0WHR/H1Hq4coJM1OWz3J9/b6jdIqh6qKMKsIwELpWTE/A1?=
 =?us-ascii?Q?Y+h1AuDCE1tlMtlprsKT4Wk7OEex9hS/wRn0b1fyKpu9p38ZAA2Cy/+BpB8P?=
 =?us-ascii?Q?1SVE4y+lXgLWPOoXVrDlTc0W6QEpckpbpGdbvM/GpH+576p3fl20arhvoIPw?=
 =?us-ascii?Q?33WM44IOsu8jNEhw0xPGmaGAkhpEvlbtr7WDRzu4sDR6/ibg4Mkw7JpNycU3?=
 =?us-ascii?Q?+h9phVCQZfoV5FZ4Qo9qdr8PCXwUzqzUMaYnJ1riw/iVjer9u5/u0KRap0bJ?=
 =?us-ascii?Q?N7nFRWNVrS/81RgIE9bzSPx+FBPAxAFQniv9liX4F33TMnizQzFYnqTiVqAi?=
 =?us-ascii?Q?EvpmbhPG8p9zDfmQ/9TyVPUOCHP+PPAbgUvqTgKruCbep4nB/yFveynhKB3R?=
 =?us-ascii?Q?7LJhvwGiF1lnGVmad5THtN/ADiK+?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1075d9d-8aeb-4ba0-b73d-08d8d43c5617
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 18:38:07.9062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkU70YzqSoZYg3t9dQ59p8cStbzLa5+GtWS016/BcOd4z6UW6n8/QCW72cwCKfr/RGoBkQcGelZ/dEGFyGaIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3957
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-18_09:2021-02-18,
 2021-02-18 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_133828_087366_9D00FDB0 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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
Cc: Shai Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>,
 Michal Kalderon <mkalderon@marvell.com>, Nikolay Assa <nassa@marvell.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>,
 "Douglas.Farley@dell.com" <Douglas.Farley@dell.com>,
 "Erik.Smith@dell.com" <Erik.Smith@dell.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Prabhakar
 Kushwaha <pkushwaha@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> 
> With the goal of enabling a generic infrastructure that allows NVMe/TCP
> offload devices like NICs to seamlessly plug into the NVMe-oF stack, this
> patch series introduces the nvme-tcp-offload ULP host layer, which will be a
> new transport type called "tcp-offload" and will serve as an abstraction layer
> to work with vendor specific nvme-tcp offload drivers.
> 
> NVMeTCP offload is a full offload of the NVMeTCP protocol, this includes
> both the TCP level and the NVMeTCP level.
> 
> The nvme-tcp-offload transport can co-exist with the existing tcp and other
> transports. The tcp offload was designed so that stack changes are kept to a
> bare minimum: only registering new transports.
> All other APIs, ops etc. are identical to the regular tcp transport.
> Representing the TCP offload as a new transport allows clear and
> manageable differentiation between the connections which should use the
> offload path and those that are not offloaded (even on the same device).
> 

Sagi, Christoph, Jens, Keith,
So, as there are no more comments / questions, we understand the direction 
is acceptable and will proceed to the full series.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
