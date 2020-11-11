Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC718C55ABD
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 05:43:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D38220756
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 05:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFrOXZjh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lI9ILEoA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="A0HkjU6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D38220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eqHaR+mWJ0vyNeVxYkB6wPGus8PBrjLyvoeEOijdAbo=; b=NFrOXZjh1MiZdRrU5HVl/Jh2A
	F32dmn6ZM5jVrp3693Wy7ICtdIGXAoJDixpBUTTLWirgWd4/x46krCF6sayPcPJDuHjWpRnmIM6uO
	MTHgqfd8XKLdIn2O4T2lC1H6rAoFMj2f30AL+dnA2Z2WWfkQOL2LtooF40TjWApuxoNlNZSnYn05n
	uxekPLSXJjJG4sUKsQ+4EPEmD69Yop4Ef0fQa50hA6bJgIYAzVZN+xxhx1N5OelhIF89UigzySgmX
	w82biXvVY0sMpRI70RHaTWcH134+kotF+AOw53q27RMwMaGqlEe/+ufPknf1hdkEFztiqE1xF9TiQ
	SMtifJo/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kciut-0006Q7-G1; Wed, 11 Nov 2020 05:43:35 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kciuo-0006Pi-H7
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 05:43:31 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AB5eEqG014114; Tue, 10 Nov 2020 21:43:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=PuVPVwQBjg/LekVpK2DYpsLWxhJsngfsKMWlR79tBlc=;
 b=lI9ILEoAS6IEJy+RACD4rhP38bYXmERMsQvNFTz223yf7dl7gIV3p04Z7ERvdV4NrPcH
 /B6BU/KMmcI+VS2ltzVlFGRgwUesP/c/s/LvHu6Utm9EWEVNVpozbW4K5IAiD4kz26yE
 NTM5D37hpajYYujTULCFfPvB+mN2DP3dPZp1JzjppCyGoQhYPfSZcKsX0TGHG0sRkjYU
 YEVSxj0HZ3TeZAW9YYUzvZOBL/MDz5V7ejOBTrkByAKZEw3OSb4so/Kbi9w+XUKwy1fT
 7Xy2w55x+uRCnvX5Fy9VWx+rUdhmcSXK9kM9mA3gdfcRJ+LJlvSvdTizRqOMxT320Fbh SQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 34nuysn78j-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2020 21:43:04 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Nov
 2020 21:43:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 10 Nov 2020 21:43:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRICRTenn2fM196L8w09q0WSCH1Oa2LpteYPSzr3IYrC+OeqdEw+5HBOLqrwVm+wgHwqahHASiXi07ac1i9ggPoU5u80/9hR6GUVQAxb54BqVui129op3omETMhy+3ffRM8myonbHBip8YkY85EefEx7DQcXb0eIosnATtBv0a+Pd/u/d+YuD+NN5P1XPZoGQkoZ3XV9RKrAKc3bLygcbhrh/AajwxAofWFPadXEO/CQNeIAob15gt1CKsInA1rUxyrxOoQek4blPoVhAO5TC1gFh60QK8AhuYpcNzR0G3Xu8t+0QHWGOXMqaAGBudkDV0xCU3tWNl/l1nBS72DsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuVPVwQBjg/LekVpK2DYpsLWxhJsngfsKMWlR79tBlc=;
 b=Yu0PiGqL2k67FJa/lS4jKd/eE44gcTz6QSTIPoRdf5h/zp0BCCwVdoM5D/n9rbcPRWk1uniAzGGlYmM8yO3VT+pauioQtruGXjLMSe/tSpju+EI8lkBM/CbK8J0hWk07SHv+xvSMA+YcpqDMv5RYYu41g+hMP+koi8tgRGONgKiiZaGplb30C0u5yW929nrG/oJ8O6ytbEJDClINyerLlRGriS7ZJakEngMCyHSAvZIPw4VQ6HJjsuwnM1KLg0cfRsgktL/D6AEKqrpx1LAHkF89LSZ+tUEjqJid3WX/+MhKoTCc7nUbdcdd53SGoVngGGT5tq7zOGc58AwLaHoGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuVPVwQBjg/LekVpK2DYpsLWxhJsngfsKMWlR79tBlc=;
 b=A0HkjU6NS+aScmXAC6iIbcDO9nXlHxwAcvc+9TZo+Ezy7NGtJP1YfbrxDsxFj6JkAHvNm+CJUj92Qiv5VXQfi44cAmxjzc2s/v/pZSDWSZ/yZe5QIezikLEedqueH0q6VaUx9EgARfnI5OYM8sYqofieGbJ3vwyRQmRE41o3eVw=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB3815.namprd18.prod.outlook.com (2603:10b6:510:22::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 05:43:01 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13%4]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 05:43:01 +0000
From: Shai Malin <smalin@marvell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Sagi
 Grimberg" <sagi@grimberg.me>, Boris Pismenny <borispismenny@gmail.com>,
 "Boris Pismenny" <borisp@mellanox.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "saeedm@nvidia.com"
 <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>, "axboe@fb.com"
 <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "edumazet@google.com"
 <edumazet@google.com>
Subject: RE: [PATCH net-next RFC v1 05/10] nvme-tcp: Add DDP offload control
 path
Thread-Topic: [PATCH net-next RFC v1 05/10] nvme-tcp: Add DDP offload control
 path
Thread-Index: AQHWl0YkhZx0w+eA2kKERaDc7kEIzKmOU6cAgCzu6ACAAsQ98IACqW8AgAHwpICAAAmU8A==
Date: Wed, 11 Nov 2020 05:43:01 +0000
Message-ID: <PH0PR18MB38459981C2CC78885426C456CCE80@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-6-borisp@mellanox.com>
 <c6bb16cc-fdda-3c4e-41f6-9155911aa2c8@grimberg.me>
 <PH0PR18MB3845430DDF572E0DD4832D06CCED0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <PH0PR18MB3845CCB614E7D0EC51F91258CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <a41ff414-4286-e5e9-5b80-85d87533361e@grimberg.me>
 <PH0PR18MB38458A4B836AB72B5770C8BACCE80@PH0PR18MB3845.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB38458A4B836AB72B5770C8BACCE80@PH0PR18MB3845.namprd18.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [79.179.110.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92f9a286-87bf-4d71-9ea2-08d88604a710
x-ms-traffictypediagnostic: PH0PR18MB3815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR18MB38158326F8BC62A8BD943B2ACCE80@PH0PR18MB3815.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1X3TM6ZhNAYfLksxeXbDgG1cWWYp4UjdfkoJMljDrjQKP01gOiM4oTTN5Bp+eEaBGdnIoicowXI7tvUbBHepsoGIiA0uQz2kjgADvuplR+4Z+fJf0nhzhuivLzGEkCL8H/5VO32Dx1FngFno3t8aBnsG1304v072xEXwdTfnRq8wtHwi6gIJqqKKgvYRkVUdG3PtbIkCnXO/UeUME+5OxnEY9h80iGtdAm3JzWuPy2RsqPXrXyKShlrouUgn6L0F2fvfvQDH6wKmI+34rDZ2K/ZHZRA/RjayHmWS9Nu6YvbqTq6YJTzWynJ26ndEM2/YczXtg4TKMTadx6rIhbE8fj5Dv7wtkqT+0MxGc5phmVCzTMieq1t2RY6y+SLryDA6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66476007)(110136005)(7696005)(53546011)(8676002)(8936002)(86362001)(33656002)(26005)(7416002)(6506007)(54906003)(2906002)(316002)(71200400001)(478600001)(9686003)(186003)(76116006)(52536014)(66946007)(66446008)(5660300002)(55016002)(2940100002)(4326008)(64756008)(66556008)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZV/ucRlmfwzc2ygZMKDUTDA9qjcATRNdisImiJOhLSlirEkLad8lqBJS2ycgQ6i6W7Qc42c1aWnFKHRwz/jfnOy/o+Tn8knk4KJ4lJMEQfCVrxsWiHHUybB9SK9GBC7LRBeOS+0PG6j+7W1dUF0Zh5OWo/SnrD+yXZn1l/zJ8dBmqGu6UQ9blrbNexLFEnVR/3Jco1TYzW4mlydW5Lh1PG9lKVTbc3BVt5HbLMTnHnyglnS3RzcZSZQBAT+2tc6svd289xy8yPoXZ87cLPZFeB/8QQ4BMxmafiyH13pZpY77JKNd7lXRVJewjwwG4E5XOpyGmab9KL3FcF8yg6oU6NqYigjz/FZjehRpsenv9HjqOqiyrJDp0Rk+KTOkO2nLoDHHdKzq8qzJhNOlFrS+iojVuCTauVcZOZIDNzuCNfoPllAI4UAbHBrJBW+5tTF85hYS/u7LtXznp+B0HLUX2VT1SSvQjL8x+V6SEz22LCzc4zV1ouTwyyHBz0dBB00IbDA4J7wKXh3w30AyMETmOg6mV67b5LlRR3lfRpdhSD+icCSBajQ5oJxOYDcHQ9Q6qiv1yI99OmUDG8MDMX0jhMgB35uE2vq+lfP3+eTfMTj2cRSRHTfqTalP81qQsRzqoda3JY11DxX916QlbMyzrw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f9a286-87bf-4d71-9ea2-08d88604a710
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 05:43:01.2844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sat8Mzyw8gJF/8/8RRLVXkiaUqARHWVj/r/YIg6gRJLb7u3wROI9lff5LdjUzMjjnYltf4hx932a8oVagyLXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3815
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-11_01:2020-11-10,
 2020-11-11 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_004330_651106_AE7C570C 
X-CRM114-Status: GOOD (  19.16  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>, Ben
 Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 11/10/2020 1:24 AM, Sagi Grimberg wrote: 

> >>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c 
> >>> index
> >>> 8f4f29f18b8c..06711ac095f2 100644
> >>> --- a/drivers/nvme/host/tcp.c
> >>> +++ b/drivers/nvme/host/tcp.c
> >>> @@ -62,6 +62,7 @@ enum nvme_tcp_queue_flags {
> >>>    	NVME_TCP_Q_ALLOCATED	= 0,
> >>>    	NVME_TCP_Q_LIVE		= 1,
> >>>    	NVME_TCP_Q_POLLING	= 2,
> >>> +	NVME_TCP_Q_OFFLOADS     = 3,
> >
> > Sagi - following our discussion and your suggestions regarding the 
> > NVMeTCP Offload ULP module that we are working on at Marvell in 
> > which a TCP_OFFLOAD transport type would be added,
> 
> We still need to see how this pans out.. it's hard to predict if this 
> is the best approach before seeing the code. I'd suggest to share some 
> code so others can share their input.
> 

We plan to do this soon.

> > we are concerned that perhaps the generic term "offload" for both 
> > the
> transport type (for the Marvell work) and for the DDP and CRC offload 
> queue (for the Mellanox work) may be misleading and confusing to 
> developers and to users. Perhaps the naming should be "direct data placement", e.g.
> NVME_TCP_Q_DDP or NVME_TCP_Q_DIRECT?
> 
> We can call this NVME_TCP_Q_DDP, no issues with that.
> 

Great. Thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
