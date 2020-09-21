Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D60C43464
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 06:54:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4E8207BC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 06:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y+UXQV7a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nUuSwkts";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rkBol7je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4E8207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=0lSZfcsRxL8rXTscaCZjw9PAgT23c3oPS0bB0vEnDHs=; b=Y+UXQV7aRACC48ICyA6xWf77I
	REbGxXbC6mF1ZpEgTviv0bv8CHzBzPMWEDEb/LJLJKI3z3O2KPwW72INjlAPHrcvMD9t4lCS8coJw
	k/bKlE0FF9ZeI4I9fHg9oKg0Cy+mAvd66dMr7RcmA37epnYQbWM1VUhB9ULwIbA5+HLzENFxxlxo5
	5nrztjc/MJG6NkJrK/KiUwFcN+Pgc/WdGnobd7x3XTF+h5YVOyuqT8NCsn9CrGOCtKxwBKSCo881e
	420a0cfI4TtkDxGl0tryoHDosH7bK2LWLBpdnn86qiVOID5qcR96CVnz1nMcOH8BPfCBzIQ/jxa7u
	RqhhYoTGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKFiR-0002z9-2s; Mon, 21 Sep 2020 06:54:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKFiM-0002y7-HA
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 06:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600671259; x=1632207259;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nOMd+ztI4K1qDPLorhcR3vFpGvb9LB+wNpFkoQu56Xg=;
 b=nUuSwktsRVoNUuaZQofISc4SvPIV7acBmE7Hqc+CPZnGgl8p1GKzTEWR
 fv2DBtaVYG76A9dnxt5/iKjjS4ZKA08U21jXIEVAeZqvMMy5y75fy/rS0
 fJG1JLg94a63Sbxo6czIDCG0Ykd1lhETJ1wyebmz51tRAmsEprYfZo14n
 YW9VZSMwrnO7CvevsdAj+MULGz/+qBLhU+PVbxUlS+9XocTlXQKJZXFJk
 1fF4DWbMAXOmvLCEdrg5I1paXm8DKZ41m/Au8vc1CqdSfvCc4Z2+MCDXa
 Kovh7jaTweeeifv3PC39zi24WUVIPJwgCUPF68jx35Lg+vIDcGWsbT763 Q==;
IronPort-SDR: CbOvkl6/rugzMDdqIA9irzDJVUlX7uWn21sGQgm4hQnyzXtA9QtWJVRi+J70imHVlVTkksr2mq
 BoSdO1DMinGImVVbAiNjQK3+ktG2iLHDKuWkXZxHgbJpXGE64+gWYxvnOutDkMgOXc7wiieshB
 ihDhwHviyZj/PsxsTT0tkSAg0Zek0hmcHBeGINiTQ6/mJlfh63TmbekT7lAS4XTOYXQl4tbMXO
 9LD2b5iczo+1O75EaxLFyGhKwizQcjZWvzx2CaSoPPN3qWxnx6x9261IXwmEZJgEk5vTAY7/H2
 qXQ=
X-IronPort-AV: E=Sophos;i="5.77,285,1596470400"; d="scan'208";a="152238755"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
 by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 14:54:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2XBdgZSRmtb4SZW2h/EGo7k5ZZXEmvjqHoD4Gjb1MphLR2vOqkTEQcrPWUG/slHSe2ffRc4VZ2baPvhn92CYxp5q/0F9mUkHfWZA5YiwFU7ivWx5UIVvwEJO0SBtD/7i08gfXYznhs6QzHaIDCVKT3D35nyG4v065APzajQB5cnNa9Cj/gXtBvc6x+Ly5HNVyIQXN9uQogzGuETy/Jbl45iOCe9AGH+y8SLoen5GArzRpB1FvsTQCWy4YTTw0v/TbmhB2P28fWjaejdgRoSF+KBx6W9WpbUyt+qSMYmORCI8gD2Z1/3Iey7FwONNwVS8B0Cq6+Uaetbs93sfep4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOxCLo5RS2zj9cIUNbzMB+diNBbBPqEDWnRt8hL72sE=;
 b=TueE/PaNFlTfqq8WuFqcau+ULaWxxTyELwekXl5CkmsxWslAMw4byJcO/U8XqSW46j/OZI7LtAdiakXYJOzVCAPzJl+zplUrWdUTejxNtar/JAisG2reeP/cHtsjObBF7VmGTCARpkiRYT1BZzhcz1yOwla+Uhgy5Sw82gHRp1uu73qvuR/jgnjEgBnoMsP0xcfYTHJABirevkne9AeJbMhOtS2SciAK5RB/Ffx177AhQyTxR7+v1tfcXAfcGBktCKciamARsqO3pocQFSCeP4AyhSNyH7FzDEz5EvwdHEoksMZ1C/ez/g4Q08BTawznkUxXzyZwCefaiO5vlZ7AWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOxCLo5RS2zj9cIUNbzMB+diNBbBPqEDWnRt8hL72sE=;
 b=rkBol7jedfibrgLsP3m1n5lo7Drg+m/yZupzSgVYofocL124bLxQthJKezT4UjT8V7pobo/Kn3XYHHZ1YkvjHHJPHBfxesgbXSmFiTRtvKkZO4f2HZ94zbCxZyEWMXp3gtCToxLJgSNRZ6tTc7huPtgi5bLrakzABsCasqhUJhc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4864.namprd04.prod.outlook.com
 (2603:10b6:805:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17; Mon, 21 Sep
 2020 06:54:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 06:54:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/4] block: add zone specific block statuses
Thread-Topic: [PATCHv3 1/4] block: add zone specific block statuses
Thread-Index: AQHWjUjpcQ/OOMMUgU+KxaV/geAZWA==
Date: Mon, 21 Sep 2020 06:54:10 +0000
Message-ID: <SN4PR0401MB35987C8C8D294A37CD12A36E9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-2-kbusch@kernel.org>
 <SN4PR0401MB35983DBC8B0B97A4083CDF8B9B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200918194056.GB4030837@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 038f6fa4-bd82-4d24-4fe1-08d85dfb24b2
x-ms-traffictypediagnostic: SN6PR04MB4864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4864729917E0BD6A532B9E259B3A0@SN6PR04MB4864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhNSfypXmMAcM37ncazeexUjEpK6rpimegHVTTEGbMsrnmaeXb9pW4l7WQl6iuHrwz6rXUhv1AtwucqS5mWUf+4ArFO+le2f7id52hwuq2AvdvxHFEvJs4ZC03reU0eu2kaLDSJugHVsciFublsd7guOe5dgAWJiGo3kLze2zdk4mrwe59HW7TSyiAcBUOaCRkWDXm5B7clU9kqoILRwTR0QhBmEflUNfJ6kg0v+rOt2FjrVEeOeNqvE2A+KISmWTKRMgpJbEtGAYEqTbD/nKoEgbEKvfiAnvIhsutBGBYkNaduQH7aeVE1AyA93jVvIi7jxZTW1v09Ib/JJVPdmEt0lbNwDLh1yeO3uZqZRrcB21ieS7MoLSEAmST8w28Vkd3xBMwpGBEGr1Li5UnlBng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(966005)(4326008)(4744005)(478600001)(6916009)(2906002)(54906003)(55016002)(9686003)(52536014)(7696005)(26005)(5660300002)(316002)(86362001)(83380400001)(8676002)(53546011)(6506007)(33656002)(8936002)(66446008)(76116006)(71200400001)(66946007)(66556008)(64756008)(66476007)(91956017)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1KnM2Zu7fE43V283BaSecBLO7vPclMIiSOaYYQjm3B+IS54c6KmzjTMI83PtLKOZbRTFIeuio7miNK3PteH7kfnTcgHwAi5iJ2IMwJ8w+5UGeuHQrEgS7zMNDcYF8YzMd9EV0lqMlaPNWH+qhygCPYkEE4eyUx8PCZLrJJXmWW8ZAIGOYCoNFTWxz74pHjAXHipOzzTJsAlyChwbDGwNq4hHenumdHX3lfc+2qu5apYhRpHJj6TpH6xapj50mOTMt5f8VtllnOVyQ+oQg4l3nhyQHTbtpvGjZTvY3JRODemMXOGKz8MkEGKuSWlG0vJcXqxIKkHsfAbfZcyA5S7Uy9ZOd18XE3xXKiuyyTrWZ6YUIdWQyDxeGwrncm/qeCD1n95KvBd2BDobRin6sTNcspTmSX8w6I2f48Q9KBvizgyl4+vKEgw+209gMi6Rk4Lu04nxk5T7h8oZpr4V6CU6Cjo0Amon9EdiVDTYRzl/IEeaaHYEmUNAvsTf916/hUYNTS/hWqEHD4cUalovsB+NorYb3C64AI6fAhk9m4NCL0mbB7aqA3bTJ+lB6nITRKpMSopr93iGXC5k1CLLusZ7AC9cd2/iTAw7v1OFH0g0nRnTY5Jalv8NqBQLlNam8Km1pMQHnZ8YsKCrd/sQdApEIA==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038f6fa4-bd82-4d24-4fe1-08d85dfb24b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 06:54:10.5266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKEO0lz8j9FXKrfbAlS/DGWOEh5dnJQZeP4mXVMe3tiL8xBE2feHMmS1/hvfT87TmkmM+boOCauSwPVnmSAjZr7Pu8NvRW2nXchTnbcwxuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4864
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_025418_871770_AADC85BB 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18/09/2020 21:41, Keith Busch wrote:
[...]
> 
> Yes, good point. Those updates need to come from this repo
> 
>   https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> 
> right? If so, I can send updates there once it looks like this is the
> form that will be committed.
> 

I think so yes. Should we also Cc linux-api on this matter?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
