Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C3C388F2
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 06:59:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7CC20719
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 06:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SX8PycQX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HHUaoSDm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="I6ed9FLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7CC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iEtx03HJkpaH8tNPh+Qvj2sV3IRr2GqcroOG7ZgV+ko=; b=SX8PycQXnb/bcRs7DFe434lGy
	s00T/Ut6701K3y9Nkry/W07VehD0Z4fesZwVRX86GP0vvCI7kvjwo8bZqKcW6QziSJhzDlnOJdaER
	hBRg4wQ6kb0tRIJ57i2obyQpw2m7APpWSwhSUjUf1ItaBgGJ1iHjYL6uis/7ILAEKLSxIl6r4i492
	JDaxZL3sXvJlpwF7D3Oqa0grTb38hCYWyTyNuWXGrbRU3EogBlWM461HiZwaJ0ZIOM3scF/FpZSYi
	rv3vX/iBQmKWEmbjuDAAbqCO9KuJwmeUeJW5L4zjKQIPRDkwHz9V1vq48/0F8GUK3/UUYJpdpRXqJ
	sed1+gwdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbefl-0005NR-FZ; Sun, 08 Nov 2020 06:59:33 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbefg-0005K9-5u
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 06:59:30 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A86p6K3012083; Sat, 7 Nov 2020 22:59:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=WN3VLtk8aA9xfS9h6m0q36pqOvwmQ1XA/qtxslypigE=;
 b=HHUaoSDmH3/arwN9m1Qa9CJSBCSUTkULoElpwwEjh/t4aKpsVbzlPOa4OcvCgeJ9Mv2Y
 8jZCRuD128GTt6EtoqEj5zM2dAwNmy3sTY0HicC6X0a84BQxf1BuGJGeGhajq+JAYHDg
 j32E1CO560hGreZbqVWPnbX0wRQ85kUN2lm2vENW3Hd8P02ndJPc61rI1pjZfvj1MVlZ
 oHDKxD8Tca8em5unuweknUybWDtnO68vYDwCXJLnmYMxNLxDWabUXrkJPYod3dF0iOVl
 IH0Poz2W0gI7GCJdChI+PfXtk2oQcAXQh38fMo6fSFKBp88N8Td/iYxHVEVIlPvp3U+c fg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 34nuys3h1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2020 22:59:14 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 7 Nov
 2020 22:59:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Sat, 7 Nov 2020 22:59:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcgTAFZ7G7RLZfg/tL+mXSXoURS2slggUL9wP73TjN9pPzymzkAAvPkOSUsrxhGBSFBxK8eNvskR60wegPsI5F5GompLADnsY9xgZzz/iLOTss1fHwiN4FORWsWsgVtgr03z3dGjTtEyTzYTjSMIQxhkbEXEgj/SwSxZ/Kje8WP0s8nTlyTtGfL/jD3wllZ3R2uqZEx65Yv+hZN2V+CcgUoruot4g6pzb/ezNxuBT7NCtHBExEqdwpWyfnl3W9SHwcF0UVPUx9TihRCU7o7viDihOgqMFwc5z0MscEWLIJ1dwIcm3azBPjD1qBTYxpu7jRJRqc1jdh0ClrkZjQzOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN3VLtk8aA9xfS9h6m0q36pqOvwmQ1XA/qtxslypigE=;
 b=Tg3/kf1QSblNEOcqajBQhDTWTQDzG0SWKZxD/KLZQLLQhr2tjPqyGffGaMJNN68qR8v/nmYzzmFQfHaoPcra9BZUoZxsbxrfNkDwGsZFDd6zpKEq85KKtLYqAN8mcJNVU0/UQpdu36IyhxvQ9ZWKhjTDq235WZdAjQTSzXZ9K7+gphhFmzFN+w/yuXsyh4fEZCMKMxVpiaMsvYxMb4mUPcM0JqS+wl9w/Y0RYaWpsWmtpZ1MXkUFm1TCsSFByrNFf4WmuNCyRd9Rl9Hwx4uYwnV0SF1fKn844fz+gvCByBwyO9YORczX/ewJQ4p9CuuxCVfmV5qlXxlIxmY4m+LwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN3VLtk8aA9xfS9h6m0q36pqOvwmQ1XA/qtxslypigE=;
 b=I6ed9FLLkrsp1eKuCRN2QMbj0WiC+EggM/x38urYX7CUMjfSe75tv0thtFJ17j1y3uvP7GI3IKraFnTtuiILaFyAP2IjI6XJd5wIqQu/P2/F8J8jY02csDtMusfIPHIGvyo1zt319hZqM0SDGScJR8KBu8c0iQNK0YyjkFI4xjU=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB3799.namprd18.prod.outlook.com (2603:10b6:510:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 06:59:10 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13%4]) with mapi id 15.20.3541.025; Sun, 8 Nov 2020
 06:59:10 +0000
From: Shai Malin <smalin@marvell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Sagi
 Grimberg" <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net-next RFC v1 07/10] nvme-tcp : Recalculate crc in the
 end of the capsule
Thread-Topic: [PATCH net-next RFC v1 07/10] nvme-tcp : Recalculate crc in the
 end of the capsule
Thread-Index: AQHWl0Yna4d84Bylz061qvDJvCsPuKmOWoOAgCzq6+CAAsCY0IAAAIuQ
Date: Sun, 8 Nov 2020 06:59:10 +0000
Message-ID: <PH0PR18MB3845FDA1C8E6063A03ECCE14CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-8-borisp@mellanox.com>
 <a17cf1ca-4183-8f6c-8470-9d45febb755b@grimberg.me>
 <PH0PR18MB3845764B48FD24C87FA34304CCED0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <PH0PR18MB38458FD325BD77983D2623D4CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB38458FD325BD77983D2623D4CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [79.179.110.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a0ebe4-54ae-45e5-7ab1-08d883b3cb5e
x-ms-traffictypediagnostic: PH0PR18MB3799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR18MB3799C288A4C0F05140078498CCEB0@PH0PR18MB3799.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoY6pRQ7t/se5zbHG7gAfPDqgyG9h2rOrnLs5Vx7OhL5CTa/KmsnJwm7jTmh17oLHR8ieJVwLF2r+DZB/9HdbnaWnwPg2UepwLBmEXc2IBo2sHOSQy6Fxh9Cq5uWvZfXjRLgUa0/QMg5iG96sPPY360Tx6iRXOvdmcDJjJZGKAl3PcTWMsSCCUVWl8lPbDHHCFp5X0HLYGq2a/DtaItzPjPM9JXawiLlhHSp+ix4d/ywfugLY8HhUjrti1ijFXbgJ5te+fddo/WsUhp9VKoRqkIxAiXkuwdz+hIEgyBvCoKKpKcBOT+HKa6kzMxaQI9YR6X3XDw3Xi0pletXaOn7PwgNwfcv67EKxsVO+zAOGBuNO78XMEaUAg78MSO0UYoX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39850400004)(136003)(346002)(366004)(33656002)(8936002)(2906002)(8676002)(64756008)(66556008)(7696005)(76116006)(66446008)(6506007)(107886003)(53546011)(4326008)(83380400001)(86362001)(52536014)(55016002)(7416002)(5660300002)(9686003)(316002)(54906003)(110136005)(66476007)(66946007)(2940100002)(478600001)(186003)(26005)(71200400001)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NixhAA2dgAFaUL7lCw/Y5bJljR5w1fqPq7qcV5cr8jCf41Cx3ClaRBNtHoS9tl1pE0Xv7c7kSvQhIS9Vnt34W3+E5dM3IX2hzINbHQ+VEsIkNnKuQWjdimJZpurzKrKFUtSACPU2UqULcMBrkMgISHoVtAZxah7i0kGj9/aSBFY+/5rV+wLhWWrgVCxlAhadv0xqGvBJjU2Sq8Iw82IivaDzS5d3ykDMa7rNsyGFACHxZIwcPraqzCix4hYxIwQ1sepmehkYLu6PRqf+t4UQLHOFOw0/lmPDqO7syTTXbjq7uCPZcVWLGXW0G3mTYe81/6w+WFYNDqTlqrumuB1k2ksHuTLOEKMzymArWPosldxEuoby6mxTdzdcx/nfwGl7gW97U+zzh7Yd2GMBklXB44yQOUzw97JLBcEaH+hEe8q+4L6nMuBcWiBjZkjoB22UNk8WlatapnjLn/cp50ubrU3TSnugz6UwrUN1HxaRq18tIxs4FuMeHlt3nXA+8OqD3W0iUvj7guaLx/Yjep/dhdWA+EtDnSNPw5OsKlpudVcgw3bD4jBSgY2ZbBMLD531t0/a7edqq46sshJ0rJnb1nBPbxFKiVkHfJzn6m80WHtbAiEvognru4SV2IUROOOF27sNJCR0Ttb265WMcyLTDA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a0ebe4-54ae-45e5-7ab1-08d883b3cb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 06:59:10.6549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BpckQIxNmUYOUweqAxox3fzL3DdPhL5G0wgKN+XgVq//VFtalge7eG8tUZVjwpBwuSqZHove1P53T0r+V+W2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3799
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-08_01:2020-11-05,
 2020-11-08 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_015928_318775_14946D29 
X-CRM114-Status: GOOD (  23.41  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 09/10/2020 1:44, Sagi Grimberg wrote:
> On 9/30/20 7:20 PM, Boris Pismenny wrote:
> 
> > crc offload of the nvme capsule. Check if all the skb bits are on, 
> > and if not recalculate the crc in SW and check it.
> 
> Can you clarify in the patch description that this is only for pdu 
> data digest and not header digest?
> 

Not a security expert, but according to my understanding, the NVMeTCP data digest is a layer 5 CRC,  and as such it is expected to be end-to-end, meaning it is computed by layer 5 on the transmitter and verified on layer 5 on the receiver.
Any data corruption which happens in any of the lower layers, including their software processing, should be protected by this CRC. For example, if the IP or TCP stack has a bug that corrupts the NVMeTCP payload data, the CRC should protect against it. It seems that may not be the case with this offload.


> >
> > This patch reworks the receive-side crc calculation to always run at 
> > the end, so as to keep a single flow for both offload and non-offload.
> > This change simplifies the code, but it may degrade performance for 
> > non-offload crc calculation.
> 
> ??
> 
>  From my scan it doeesn't look like you do that.. Am I missing something?
> Can you explain?
> 
> >
> > Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> > Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> > Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> > Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> > ---
> >   drivers/nvme/host/tcp.c | 66
> ++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 58 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index
> > 7bd97f856677..9a620d1dacb4 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -94,6 +94,7 @@ struct nvme_tcp_queue {
> >   	size_t			data_remaining;
> >   	size_t			ddgst_remaining;
> >   	unsigned int		nr_cqe;
> > +	bool			crc_valid;

I suggest to rename it to ddgst_valid.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
