Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B360C388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 05:12:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE7C20639
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 05:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IajTmSfY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AtTkqYFV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="MNyfDsAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE7C20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=liaKZyRf3MV4mBdu9+zwFG8CL/UquX9a99Rwq8A8OnU=; b=IajTmSfYQ1zr4L9SpBARC3lJY
	EmIWNNSGg5joHMosMYoNQIX76kZ3voi7MEFyWYpE4F6pjarOYpbSwu9U65veGR1vjS0tA0AGErVN+
	BDScmajYXwdStxVv7CnXudakfyMsUQKz/HvRMnJkxJVvH12FZs9uchcwVLCHcMcCFv1x/dOxndNkL
	k3uf8JjbG9GiPDEXIYO/6CVcFAAv3cWhw8IRDPaAjTkyEwwPWoIB3A05bb6GzXI/ri4VPIeQPoGE8
	rDZlqphF/jBHZA4Ypih9F7hgfBoblLI3LoBRtjdOIwTbQmREiMU1UfYuMwAFHlgjAeOC9nMg87QnK
	AtYc2vjtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kciR2-0004B8-2o; Wed, 11 Nov 2020 05:12:44 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kciQz-0004Ad-1n
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 05:12:42 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AB5B81o001282; Tue, 10 Nov 2020 21:12:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=a/Idq+U9JyhpNjFKva44WaUnjgzIFDwEKfRwl40AGAM=;
 b=AtTkqYFVESnXj18YVVMEbMV3PcGqesXCfdQOgIlAoiFvNX+ZGy9EIwcLsDRSiCo0voJ8
 9VqVzj0fLxk+7gfdBeCFAPngCfAvhracH4mWedrxnGgFLEg/m1OoV1sM7ilzU+4m/ILH
 YHcWPrCzqNCax83X7Kiaq0vdGkvE2cPveRTatMG5WS5+01yolKTBfVFL8SOb5zeG7p+l
 NQ59ncizf3w1fClkWRwmRUW+6NN9t0vhAM+AZDlx3ZtWqWFmfNCbsH3nSpgzwnyMAbuC
 wIUN3oAMYvxwIqhtXNZcrYRKCeRoDRKhWa1TZdBGOz+ARJRYAdixwpr6D0Tzq92gBOjx dA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 34nstu5wj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2020 21:12:13 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Nov
 2020 21:12:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 10 Nov 2020 21:12:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKiV19RLZQV3nVNgwOQQAQnJunntLiglJAOaRb9uhyvur0WfEJNK7HctZA4n+MHcNTsXEKWiRo6ZjGif0J/QupnsBtefeOAU5cEFFNe1zn9G3dznKAqM4JKbRx8CKA2ja3qmGFj6mS68yWbAKXst4OrZPTWzesxIKNEtIoUUN2JIw8D4tsMjX4eiYssMyXOpzxraeHCm4KQMShjOfOT63q4jaXkD6veCgX4W8PGeBFsI5B4Iov0JZZ8CVLAmNUNQ/uEW2Feu4QjWdpYXf/BNGKMAbWtUz1iwMCpVLwqwEguTawhamwQFs8Xg9eeLYkjeAd3flI5Qr0Y5GYO3zgHwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Idq+U9JyhpNjFKva44WaUnjgzIFDwEKfRwl40AGAM=;
 b=XR7caOzTv7cQ2Vp5jYMsj5hqcr2DXcAdLSBOtOX8YQaaDNslF6nZORD/kKNzEOVAcQKiER1dfGdmJ/0kmyjDlSBmMnDG4ArZhjUec5dNfK+KN+bcExMeKEny04y8ncGlfn+fHJ6uzAduEaZDndF5U0UYVAK6J6vgn5/RJd+68fOFQW4tQeANaBPip/DjCgSR9w5tq5h0jwZGBI85KIKMU8pRzPi3DKGuuqobhryICIWYKegm1c4qdbkbQrSe920tUIWgdTIKyqGgU7pb9+o/Eq5d+2i0kU/a2c+aq8r3ActLvaJO6aowPDHen2rAdrSEj3szXLXcHu5dHVq4DSKJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Idq+U9JyhpNjFKva44WaUnjgzIFDwEKfRwl40AGAM=;
 b=MNyfDsAJBqc58DaxurryGNwbMIvJwPCjoTgdeNpBlXEd0Eras/FaXkwg2d08679ao9G0WzDobxf9wuP5ZbFPGsuLemUWnSkOQJuAcAm2IoWxYWlccf++pV6r2X/SekNSPLBNM0Os54qx2uYNIl/o/50j/cw17agDibs+1aZNH5k=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB3957.namprd18.prod.outlook.com (2603:10b6:510:1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Wed, 11 Nov
 2020 05:12:11 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13%4]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 05:12:11 +0000
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
Subject: FW: [PATCH net-next RFC v1 05/10] nvme-tcp: Add DDP offload control
 path
Thread-Topic: [PATCH net-next RFC v1 05/10] nvme-tcp: Add DDP offload control
 path
Thread-Index: AQHWl0YkhZx0w+eA2kKERaDc7kEIzKmOU6cAgCzu6ACAAsQ98IACqW8AgAHwpIA=
Date: Wed, 11 Nov 2020 05:12:10 +0000
Message-ID: <PH0PR18MB38458A4B836AB72B5770C8BACCE80@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-6-borisp@mellanox.com>
 <c6bb16cc-fdda-3c4e-41f6-9155911aa2c8@grimberg.me>
 <PH0PR18MB3845430DDF572E0DD4832D06CCED0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <PH0PR18MB3845CCB614E7D0EC51F91258CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <a41ff414-4286-e5e9-5b80-85d87533361e@grimberg.me>
In-Reply-To: <a41ff414-4286-e5e9-5b80-85d87533361e@grimberg.me>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [79.179.110.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1929629b-66e0-40be-78e6-08d886005836
x-ms-traffictypediagnostic: PH0PR18MB3957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR18MB39575EBEF798166C2BF7AE4FCCE80@PH0PR18MB3957.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eePoe6WEUSt5Xuftrvyi/BcThMvIPoyfSUK6j4QDp8n7oQlcWClbYZaVHUzyC4Ce0hpRtGQRECiAD+OdfU9UXUvETOzrGFUApkeooumcIakg6drVM1Zubi7YoPU0V3A3R67I6yRdEooJabVhF3KqXsEpWTHLaPYlLH+57jYXOwXsmWwcvZOguRmoT03LISYruWZiXmbGwzpt3o0SQnbb46DbTu8dLtleIzVm/wt0vAuDVDEp+qM6sPAUw+cZg6xLHbDceAA9Tr+pbAK0YQ+2A/QJLPUn5EENdb4KjX6lTiYLZXuihNsfJZFmu6MqBgNCaDL1EI4X7aoT9+YtL1jmi6CvJTpkfjrQh2+gfPknVIampG2psWtxixuZ1PMq1StX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39850400004)(376002)(8676002)(66446008)(66556008)(26005)(54906003)(66476007)(316002)(110136005)(71200400001)(7416002)(64756008)(33656002)(9686003)(55016002)(86362001)(478600001)(66946007)(5660300002)(6506007)(2906002)(8936002)(186003)(52536014)(4326008)(7696005)(53546011)(76116006)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BmzVrGCJwv7CXHw4OEXfdAvQn7Nqd4UmbaZZOgWVQn4MhaSy5DVAA+MD8MvZbLcAl33gSkaUiaMJtUDE5pkMaYIpHgQVRlpQTXJWtjeU6Pl2YUquqEY19rxYggR+a2olOwfHAqtV3ziHwuMfXcQ+Ou08ZNdO9ei/tfqyVENPBWegNCBuxMmR8CYqMucDgbZPHAlBgqqtzygzWK4t+8P8ZG/XJgLZp5lireeE23hhQYnHHqT5x3VeXhNUdjlglhupZT4vxYxCN+xV273adyqfxJeHwdPvqwtT4/TlU9TFcJs/PsZL8K3NW15bWIFDwia1J1TF4yqEncQf9054c/lm/wbZziF3FFfy3mD2/kWl4pHj1vJf1SdRAf+DKMp+xhNlWjGHbiShJhfRuRb7xNPRHZaEx8dcM6waQA/of3b5rLEff7duOUdqEzakIgAcGUWysxzpCI1xIQxOZCYDDvDJVZkHKS6CKZquhwsHX1AY8H2EPDymSUxGj0ZTyf9egZwKSZtf+S/QYVnPXYE55nNIbjJJyP+DnCJJnKAYiaS6iZoiTa6EU+D+o8bTGRYdTcqo79Ied+j4EMGfuSpD6dHZO9tANOfIwrmuTysWq6dU8FsVMCo9c9VI/5OhZi+5v6dQqPUZbPt/G/7PkesXm7jl/w==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1929629b-66e0-40be-78e6-08d886005836
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 05:12:10.9857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGJDWm2Zd307LOQPARaC+2aL/FrkjSd8xKiexBEfsi2+DGCDsFKqUY7z95q1CqCeBSXL3hj3CvB6kHqNNGoDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3957
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-11_01:2020-11-10,
 2020-11-11 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_001241_334902_FF6B906C 
X-CRM114-Status: GOOD (  19.53  )
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

> >>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index
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
> > NVMeTCP Offload ULP module that we are working on at Marvell in which
> > a TCP_OFFLOAD transport type would be added,
> 
> We still need to see how this pans out.. it's hard to predict if this is the best
> approach before seeing the code. I'd suggest to share some code so others
> can share their input.
> 

We plan to do this soon.

> > we are concerned that perhaps the generic term "offload" for both the
> transport type (for the Marvell work) and for the DDP and CRC offload queue
> (for the Mellanox work) may be misleading and confusing to developers and
> to users. Perhaps the naming should be "direct data placement", e.g.
> NVME_TCP_Q_DDP or NVME_TCP_Q_DIRECT?
> 
> We can call this NVME_TCP_Q_DDP, no issues with that.
> 

Great. Thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
