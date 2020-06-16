Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2803C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 14:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E974206F1
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 14:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BCOZZeWv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ADx9N3ym";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NZI3VCgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E974206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ElWTH+EF1jjHHivQgUHEwqCvzmMEhFOjZdiTNbRmiXU=; b=BCOZZeWv9d1T9e
	fx3eQva2TVnMQIDFSYowUgGamGpR7Qwr9VQ7npotdnzvstIgVKqO7LnhaMix6GGtIMuB6n6YaXDHt
	kEl5tVMdjNefQdsrqLEhGcFlMiRb+4hcNrYi6J/ooi+UGPkUfKqpIXh7713tFgQUMxNsvxWxstKZy
	6IFxD606Br+rQj6iVxRd1akEDI5qgA/2T5lPuzrdwYjSsxhd2DypA8jQLupKi/jZ9YRKHZK1KC2jW
	8lVFxVEiYeKUePgL+HcHatubQUxbIhFlA16vdomZjGeOuRqS5vd7jjp8G3A4fuIV6Z9d2PDG16Am9
	X3d+m0zYifpUVOrmneCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlCIL-0006aR-9B; Tue, 16 Jun 2020 14:10:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlC2u-0002Gc-PB
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 13:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592315676; x=1623851676;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ADx9N3ymO7S23TndJuITEnQuvd7BJ6Spn31kG7hVb/1JAcAVIaAHTDeb
 pmHn0lGFMow7ORoPW9W/fb7KcVXhGrXfYoKL4Q/SIQoEvAWJgluucX8Gi
 i2hNkc4TkT5MnjfBYFtb3WhxoIXrys4tEZxcfpRq0UYwFgu5OEhYhaKAz
 rKu52CgRmb2LWPbP/VViC69XmPpxCSqEUxxVOqMimPztVArhR/Xi7AzMU
 1FX6Aztk797MJNqdtMZrj3nzN6c52r5Cby0TmAJ30mB9AF5kGueLscTTt
 J33AcZynSGC7Ju9cIxikjh4i2Z5DN5JgGxsC8mRhrWVlLYr4qu0LwMMB2 g==;
IronPort-SDR: HXzVLJpu9wrI7OJJODGd93P0pwsPvvyR+3NVFQjMGRuWpHczacaAZ1HAUQ6fP75N/18QQMtHZa
 exhaHMEbKnzS+W7Pn7Qhr9eSr884FoJnCehQtO6g9oVFRwGO8xbg9bi5OCsZ836a9IzaOb/0A7
 OrSCuwXwKU+dKipXygbOqxb8MHqPX45nQGih1bz+8DGvy46FEvXCrQXlszN1XFoPqn+8FphDlL
 C42Y8sEb+6iMLJecjOLT+lh+n08T7qUighwFpOVTg49hdwf3PvGKCRhEtz9mzTZxWAxjRNyjFU
 IZQ=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; d="scan'208";a="249308125"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 21:54:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ73TV8TbApLeOPRcl/mCyofPlQeQjikzl7wPSF9mfICjYOtGqSWR5+4nMti0jwzUX3Fjp3dE63Vwm5fh0CdO77hrb0hoKHPhKe1R1h+frRYtQjT0H4uKbpmWck4T0Q9XgCkSE7l3nZ4kJi2Ix54wRaYRPuNw95wBa9T0c5b3VVJ0kVHQqK2E8hlk3tifcD04+tXY+Uy6q5sp0bwlGZAcbTaem0ubquP41MgNbmPtGwvY55KHTk9G3OSFpsQL01y+hecRQj61lN69wSM0NJgruaS+LP9DuPRAc/BThLsOXQd+6i0Z2yl+AXxlIRL5tPWCo795Zm4w4aJt43o4e913w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EQCCuqbo/NyV3T2kHGWT05Oklar8Bz5FF98SJPvA85yqcdxWPo8Dqab4XnsNE44Aqsi6GY+iNlGfDbWef2TlnK9AuhuT+D5I5RPU3NhxmNCTyokAKS7EP7Yj+/6ZuI/Glcp8K+ZTQxXs5Vy4oDVFqA8o0UFCxH3FED8exq+9XuBtBxTFc/qYEVA5H3XHjty/t+NZNqznLtBA8mSAc8YmVXXgKVsc/JkweQiyMCoqfzkAlNb2hWDOmhchnkuuAwKTWpB4wvpsv1TkfhPi3eogAY7D9qUlxtMBdk5Hb2ThcsSmGZqF7rsUaiI5rzyFRAwX/f8q4XNEeSM+4vysbzn+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NZI3VCgCGNK5+ir1qWNycUYLsy98WEHTcEbxTo555BjRO9NTJ1ExGLckpOX4MFfJ0EQJ2keNjqjdCgOpWV630Y8MAPusIRbmWRtR6Wj6QqG8PwV0/+isSVmDXvS/8qMloo8WTyep2lpURZ298jHgys+I1E1Z20lAWY/33eSfT60=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5008.namprd04.prod.outlook.com
 (2603:10b6:805:9f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 13:54:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 13:54:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <Keith.Busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/5] block: add capacity field to zone descriptors
Thread-Topic: [PATCH 1/5] block: add capacity field to zone descriptors
Thread-Index: AQHWQ22jSTXT7ZVDAUSTEUb6up1N/Q==
Date: Tue, 16 Jun 2020 13:54:32 +0000
Message-ID: <SN4PR0401MB3598614C587D65D549AA1DBB9B9D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-2-keith.busch@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20658fb9-4d2e-4949-81d1-08d811fccc5f
x-ms-traffictypediagnostic: SN6PR04MB5008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5008B39DC00B8CB5340557AC9B9D0@SN6PR04MB5008.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbqCk+vsqhbCT8Xge1TLdg+vvpMgF/3GR2/0zyk63l+GJmFiSnibZIq0mH3iP1E1y4SeIbZb3yye2rto7MNU9igqcv0mhpOOMvaBMytyrZhcmKzPKIAfbUAZZRQ6XOsxK1RFbLo+p2VwQtOP2dwy4dkWnnWRvXYNhIF3JB3taz36pGRTiyOI1x5jTy6yJQXeozO6BJ3GZRdkbR23Hzus4I7ymdrEHJ15eZeMUycfaMtigjtl5h7S7/jlhufmo+CZEZklc1XbCvxqNAYI3nuXCoOho6dThyAUTch/KaCHVVZl3Lg/B2bpVnp9bSi81g84vBr3FCzxXE/vkyXo0dJNAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(19618925003)(26005)(4270600006)(71200400001)(498600001)(4326008)(6506007)(8936002)(110136005)(54906003)(52536014)(8676002)(91956017)(86362001)(7696005)(76116006)(66946007)(66476007)(64756008)(5660300002)(66446008)(66556008)(33656002)(558084003)(2906002)(9686003)(186003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vQBO3kx9lsO5aGPcMwek9tx1EIJm6BwC/2S2f6IfcjCckqT+z4YWO8+Z4MhMgwDxLEGBzjA6fdxm4bWOYrLjsp6TPAe21Ql8P2jDOf5ID+I2PGB4TYszLR38+fF0pZDjVgdiJu+4LKRjqNkIWbb/kSeFdNALzSzq8fIw+FdAI8/OpKx+RZ9ZNwEjF5iQRzosoD/pINyP8XVpT8XqV+pu/qnILZShqn9SPdfJ+s4wDVOrDcekwxaE1fcq/yPQ0AL95p2TQDCj8pZlI30sKeV9Y6jjNkg/YfbWj5aqW1Kg1OaHjXF1G1Dhp26fBeZhW2mF2h58IpZ8bAn0hBJe5M2fcLZn5Np2TwlkIjOr+crPOVJyO5hEcLWqUXK8eJmpXZcFdW7ubbdkfYo939o3/CM2dwDh7ZB5gKegJfi0i1d74PYjlqcj5zFUZCVmmxARMne4be8bRfMoGqrsD5QQNyhRO1F5P1NIR7Ya5f5fDL6mlUaNj4wYKk/C2SMBLQ5EfpEd
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20658fb9-4d2e-4949-81d1-08d811fccc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 13:54:32.9428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWuxPky98JmVxrI11ETQ/lIacLlYwqnhY4evDe+uqPlZ32IQ0l6ImKFtSgEm7BdUswlniN8OKfaxTxwPiuQ6vKH3uLijvkyUNfn08ZvPCyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_065436_890300_AC5895B8 
X-CRM114-Status: UNSURE (   8.06  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
