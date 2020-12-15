Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F64C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 14:07:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7740224D2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 14:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7740224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LSrT9FRg9nNqKXYZfSmQmblTlwioD79bikYXrG7nO8Y=; b=VenRPQJHrZ5Z6Mm4RpFhhEBxC
	QYAOluThv7tRxw9E6g+yHsjQc26UK78U3B7Y6YqpbcK5FToEeBnkpOWWqoPzrtH8dMxrywKoEt69h
	C/O6azWoq6TBuh/pIyihgvPuErtzRVZIsW1/QsUi6ReleGahQzl2PetC6Sa284B3GtQdPShdL9yTi
	pODb4RsBE5JYorBSO41YzyA8UbpE8z1lRIqxfqSJrjDBh7BTrexqZgMH65/DpULaepgf7zcbS/BZg
	HvWRsgd5IwRTy1f5ftxInB/JtQHDxfNWCXo3sVagSg1RaT7vLdk4NkMaS8S5o9QUCO+Z8kOjdA0h4
	lv6HgRPpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpAzZ-00065M-DZ; Tue, 15 Dec 2020 14:07:53 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpAzV-00064M-3V
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 14:07:51 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BFE5Pes017878; Tue, 15 Dec 2020 06:07:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=oVsJs+BsOWGf/cnXayDSTzemfkvOw+8n7MyYSq0Rdv8=;
 b=QBDbQiWU3+O8RwWOYBH6MwHYzSxOBboAt2xD9QCr0ggM5KRct3Hn5pneHj3EL2TIj/Aa
 /yUFXbO/2cqoMCBMDk4eV+aXTIAkuRIDa94nNHTK2vLk60LuAJH5X35FVcq4u/qcPYbE
 FnQM6MfO1JNc68kNHPUpRlURfmuuvdhyqvVDqBoaIG9JYxMRvC3ISLxCk4C77U6v1bLa
 xNa3f2Vfv9E6kIesZ4tW1i6MprynsL/ivjVkRVl0ThGeZ/y9ViYwszLDW5VBxaChWutD
 2j8Yvs0vwtcsM/ivSUNv+B0EPmYbHIk2gptJ/z77G+oiR60RdqSisZLcqUaZXMJ31srZ hg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 35cv3t036b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 15 Dec 2020 06:07:30 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 15 Dec 2020 06:07:29 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 15 Dec 2020 06:07:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 06:07:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVcGXRbOfm+RKZLS8+iMf9jWtfbR8whOPaAqnrS7iS1sjfCYPzNp3Cgs5Az6xdiGsjXiQqsq7Dbq3G+XEez+l1c5i1FH34ggsWTuFjPjNOOM3WcwDu5J7LqItCPF789r6rJTRMCRpJuaLK2m8o8uAZDzZyzo20ZIaylfquzkrb506ZuSrpv4TwZPKvk0LMGzH8VCmHe5+oPfHyYrPwpyk0fMdB3BDyxe22dQlpixWx1mBlMvAzhU/RIjk0FKxC0NDAYQfSaBG1/wSPkEViNhWlULBD3QmjpmPZ6jl7nNIy/GUB+LwvowXYm6rIjfCVse/DqHj6HI5UtXsngKg86zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVsJs+BsOWGf/cnXayDSTzemfkvOw+8n7MyYSq0Rdv8=;
 b=Z6mbfcNk2ER6I5mfrm7nDkLFferyfRFDou4e2VKWgmCToEI0KrfFMWMpHbjLYuCrzcY0PzVKrwJ2qFS/7b2qGpnZPTqy6MVrBSKkUgaY8HUtCRChZPw0vZlZnlyr3xNnDoLYoo0H3H5KPINET+/p1ylYNUyHyvL7t40ZG4LE0Jzs9dYIyng9AZXHF+eG25UB1prCi3b8K7Q5AfdShFzkf4KDv7xV5Qt3p9+c4sUTyvqCNhH0xQQ8eF6BFsFrs8ksL3I5XV46G7OrpDUmPk760o+rlzbRvenFDCdSuxofCjgzKv1JgtJ81HJV2jiHWsTm1/VUi4IXdRA6cOa4yPQa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVsJs+BsOWGf/cnXayDSTzemfkvOw+8n7MyYSq0Rdv8=;
 b=Q5TB7DPWioBbexI9y064I8rtLpwMhICB885mTU/olTO7XYTBk1xf4IexjMRLywUoV2Wl+wE8aPhhQAevjsrQXLY4FVrCCAPeaDZyIBVeGiKBDvTYkxfWbLxatFIX+PGVPj+8hehZnJ4v8/Mbn8yGKBCG/vq9Uux4kbDTIFkvu/I=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB4021.namprd18.prod.outlook.com (2603:10b6:510:2e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.24; Tue, 15 Dec
 2020 14:07:27 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::cd9b:85b8:cef5:e543]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::cd9b:85b8:cef5:e543%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 14:07:27 +0000
From: Shai Malin <smalin@marvell.com>
To: Boris Pismenny <borisp@mellanox.com>, "kuba@kernel.org" <kuba@kernel.org>, 
 "davem@davemloft.net" <davem@davemloft.net>, "saeedm@nvidia.com"
 <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v1 net-next 07/15] nvme-tcp : Recalculate crc in the end
 of the capsule
Thread-Topic: [PATCH v1 net-next 07/15] nvme-tcp : Recalculate crc in the end
 of the capsule
Thread-Index: AQHWzN2HLXk+GuEMLUevzlHdst1Vp6n4OoYg
Date: Tue, 15 Dec 2020 14:07:27 +0000
Message-ID: <PH0PR18MB3845EC64645DFFA3BA9BCD63CCC60@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-8-borisp@mellanox.com>
In-Reply-To: <20201207210649.19194-8-borisp@mellanox.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [79.182.80.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97ee8f7a-8e5b-4a5d-e7cd-08d8a102c102
x-ms-traffictypediagnostic: PH0PR18MB4021:
x-microsoft-antispam-prvs: <PH0PR18MB4021812711E08BA71CB4BA4ECCC60@PH0PR18MB4021.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLV28NEGRbzSGE4QuJYkeMSLOQe9XzWjUWRFv/Ij5XjEygzxyo54ygsN0TRF9Zw2oDatkBYMgTS2BzhD4B9JYwhObv8zKtnof7Ej1LN2em27mY8rk2gIAz8df8k1jmlhdHvm/kipC32V/QrL3rPhQFDsD2Eno5JngVLZ6Q34cyObbSfcN6STPVbjHkQEOkK6hvMfPDy9QL89EAzZ1EU1lpnks16z0F12RWnN6oMGkHxAnXRMLOGgyuQT7PefwnAtjBXbFjVh0HYKmEBzS4R2A/jvXnQ4Vn6IN1xbJq1p8Ju9CB2ab/hliNeM6fOazxKqTz6hAwtN9I/jh1q/43F+ZqvJiN+ZoDy08e+0NBOIXAXm/0ddaxfRoFe49vbuZ5cS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(498600001)(66476007)(66946007)(64756008)(4326008)(76116006)(86362001)(52536014)(5660300002)(66446008)(55016002)(71200400001)(921005)(9686003)(2906002)(8676002)(26005)(54906003)(83380400001)(110136005)(8936002)(7696005)(186003)(6506007)(33656002)(7416002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rHC/6BDGuZ+y5zqVAL4fW+PMVegExASDEpq8yLdU83kyjMS/jQRWGPJ14+9K?=
 =?us-ascii?Q?dIyV2CIEwyr1jbpOiDXCqNz+0fC+5lUau8GgYt+HAmt8T163yM7Jh7DQljpC?=
 =?us-ascii?Q?9D6Q2HKIhf8DYZm9805cnfttqa3XtLBozE0A8gqqsZOmUdRBylHFhtItL90p?=
 =?us-ascii?Q?2k/degKODckzqkqVX0kWtlz1ub32g/PSW1d6MPpQHiWxsh1QSlXPYqhi/Kh0?=
 =?us-ascii?Q?ySbon68j4LPuggRaBng8W0U2Hk10doD5Z6T8txfL9XV4/XGoPp2a9xaaZUxC?=
 =?us-ascii?Q?j/109MG4ugwn4nak53pJRBkcf9g1KBpNj+wWyTkuhXbr6jmAsQ6GivgTVTE3?=
 =?us-ascii?Q?gEj9J/F6RCh1xGs5+m+70uc/AFFEfgZGlI8wBqsJA9E9QH7lDP2LIVTSbs/w?=
 =?us-ascii?Q?W+gLcQXRLseuth1DNS5LFhVe1FtXl/diwFLC55Eyymg1LbH7PRhVrjLWOhxd?=
 =?us-ascii?Q?AP0NJXepCU98Ntb0K8cFrnMBe3A/FH4gH/gW2RWBWDeMYT0y7oU+YD2FdHFc?=
 =?us-ascii?Q?9HYZsh6pMWnPXOlLTLt9yK24aFKr9Vd5Sns2YpWmvEtuJvaje2MtV72lCLuh?=
 =?us-ascii?Q?1V9h0Jr3fJUj/uY9IXsvokLp84uQJoLhH6KjVYmgEctMF5LVAl3VwVGO1+SM?=
 =?us-ascii?Q?ijni9C1KIxnGiZpyGa8vIB9Ij5GOsVRjoFrDBWpIMCPQHndRmyswGaTv0LZq?=
 =?us-ascii?Q?H27X+x3zeZnC26S9zlOZWA+TJAhjLYcAAmrka6AdwyiP0ppQb/hfJMdKkUJh?=
 =?us-ascii?Q?YmRi0dkTSoQ2GW1a1Fv8EfMfKkuSlEdEs5vA91yCpe9d0LiMaQj6jloscQbT?=
 =?us-ascii?Q?h5EAE4qMJ4vzUbSBW0P65wnJ8bj+S1tKuaHj3ApGuIB5sm3u4kn59pU5nxee?=
 =?us-ascii?Q?sEKoTyDfrE5lMSvTz7T99t55rZ0D/iUEcoqygmnL1ntNXssA5pxHoTvqgbVZ?=
 =?us-ascii?Q?94Si7HZT5J0CWU3fLD8joK4HfhFl6D5dDBG1JD5Uj7o=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ee8f7a-8e5b-4a5d-e7cd-08d8a102c102
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 14:07:27.1969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMFGeUYCox16icV1HGhgo7yJ+xn11ccOwUb8LrOpob+JcFcfTgHHxEsjpFpCNiHHw5fGrY9NQBSr1lz+Dhji7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4021
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-15_10:2020-12-15,
 2020-12-15 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_090749_386933_54EA0273 
X-CRM114-Status: GOOD (  17.34  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "yorayz@nvidia.com" <yorayz@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "benishay@nvidia.com" <benishay@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 "ogerlitz@nvidia.com" <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> crc offload of the nvme capsule. Check if all the skb bits are on, and if not
> recalculate the crc in SW and check it.
> 
> This patch reworks the receive-side crc calculation to always run at the end,
> so as to keep a single flow for both offload and non-offload. This change
> simplifies the code, but it may degrade performance for non-offload crc
> calculation.
> 
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> ---
>  drivers/nvme/host/tcp.c | 111 ++++++++++++++++++++++++++++++++----
> ----
>  1 file changed, 91 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index
> 534fd5c00f33..3c10c8876036 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -69,6 +69,7 @@ enum nvme_tcp_queue_flags {
>  	NVME_TCP_Q_LIVE		= 1,
>  	NVME_TCP_Q_POLLING	= 2,
>  	NVME_TCP_Q_OFFLOADS     = 3,
> +	NVME_TCP_Q_OFF_CRC_RX   = 4,

Because only the data digest is offloaded, and not the header digest, 
in order to avoid confusion, I suggest replacing the term 
NVME_TCP_Q_OFF_CRC_RX with NVME_TCP_Q_OFF_DDGST_RX.

>  };


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
