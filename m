Return-Path: <SRS0=k/Zk=66=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA8C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2020 04:30:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1048206D4
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2020 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TdhUrG4c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="acEog7oU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lxUFKYb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1048206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=UirjTlnLx2StggVGfPtGTsO/S6t9X2YseFNLITOa35E=; b=TdhUrG4cV+rwEA
	UpZ6lQn0rLHAHI3GaopokH6NM+h8TF1KX3FvzclV6jOt8q1KGAfIZ/KyXPi4pt0CvglGUF6pE8hRd
	7ziJ2mTR9v1Bh1M1yo6i0YQJ5liNQ8H3TKZp9h9UGNB0uuYeI1Hjpo1+GhFYiEr5gGvOEuFbxMdep
	qMQAktQuZtuO26E9meWXovJuSot/sIGJVl+UUI5miFJvajA/xUeIZ2Sb1wfZ6GSRp0UTEalsUF4+m
	dRHj82ZyWLT7L1uIRdjDgYVfUe+Zsf+VrJa2QTCc6bEM68vaZ7WzTiN8jLadJbbPfHUKuimh0rYgK
	JYq9pqZCtCsS6ILvMImQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZoT8-00050F-Sd; Sat, 16 May 2020 04:30:38 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZoT6-0004zc-R6
 for linux-nvme@lists.infradead.org; Sat, 16 May 2020 04:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589603436; x=1621139436;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=S9mN3V5FEqT4uSzHKAReGkPhtLjFim0BSylvcy5mOkk=;
 b=acEog7oUbxcuIRKoyX+lVvuFVMNMEtyqTa6diuP7TUuUSdgGvWvciRDE
 Ad604c/5IDsKHj0SOChfUEkbf2VQDsawLdJ3hlrhHoeX4t4oTKofkpWDN
 h9YNyNPOR95Dsetq68CumfN7Q5t4oZCVXB6caVlSHIsyHVBqIdrh7fQkc
 P7lMkYzeWx792PZa/ptf+nAzJchUwmpNyBueJ7KlUglFXpXsVoIed65DI
 TvwUrQq8XMD0+Dm7ynQzzAWE1lgGrQE2a1WFegi7KsTo2syzMzlqily5x
 zDN+eHAmbSB1vMNHaxD1lXAw3xexb4YMxCC+SqZxVZjrCuHfbXtq++h7r A==;
IronPort-SDR: pOAQ87yCZk/A1hWzWOk+ah7K+iRymjfDetmTE8AT0rx2PPrJj5Qk6xgyA0vmia6iK25/r8kmcl
 xK33EkqmHagHfBOaHA+5hQhc5AKuaEbmT3uI25xXvAhHEvCKyFBbuy7LoNtEvZEKfT/BGO27ij
 c/5xF5u2iPpM2zvvxWDyHsEkkXjgVcLzCxvUI6bI27RAbxRRRCkhWJ6UZ9MQsT9j8XF/oT4lWS
 H2McEKZAl5esyoyB9iSD+MIl4Iws2gjpJu2VLPT8JwPvztpnTm+dfoEMvOvW35ByTp0hzD+w9x
 vxU=
X-IronPort-AV: E=Sophos;i="5.73,397,1583164800"; d="scan'208";a="137830033"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 12:30:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azUFZRq0md9SRknfa9hkWvMICBzISyHk0w7m32qBim1DC4y+dTcQsov+ugO8KzkQAY6NrDRUEeqrvAbs6nEYQnhon22Q1Ar4uCRI4pXDRTpahAztRaymFOR1XJTC37EKHgiru5jONM8cbzB1lr5Zz+mysa5TtsP27aCsPshufKbZeZTLnXVgPZi+7MvNy7/XiqoXVA3h73MsuY0VRU70PoXmNtic+s3bqL6I1EQh0eNjk1wYEMIV7Mf1VBTwEQSc3dZcMRytQjuwGHwEmANoK5+zqGGzLw3o/3k4j4a/1PkF5q361xSgYY0rRAsu+ORo52yb9C79e5KfvDWtRPzlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9mN3V5FEqT4uSzHKAReGkPhtLjFim0BSylvcy5mOkk=;
 b=YjOnWgPIgTeVgt4Zw6bALfHmq9wMIh8zW8ctEDwqZK4/GhSn6ojwQ1Oyoc4l2AxbFJ7lXYA/vzKV1zitJEfHZtVbpPfwAuBj5JajoOwB+pjv9d86TOLKN6OOsyOeSmTzUHM0ZX6irXMvdtk8ZCVjIVB/pyK1fVmjxgUB2rBUyda5z6eBXK5/1l1ykVOqR4k4FKWvxoHLcsbMX7uceog8pGJmRJc6cgsQRRXUQTJRF7muIklu36ctfknpfdeuF/HSPucNt+HsnPgfe9v+YKfQohNglWuRszfcMEqqzwROXcIc1N0GY4LdWXQsdM8RyMAdlhgGomb/kUOOGHyjifE8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9mN3V5FEqT4uSzHKAReGkPhtLjFim0BSylvcy5mOkk=;
 b=lxUFKYb8vEHVWXuwVLOvRxW1L8xr2t7Nu/8XuFAT0pXSK6+8T2UFLe8CycvAcSAL/Chjd4/5/3Qk8BZ9WtUBLLN2iSW7WQLJnpyrj0/CKygZsAlrY/FjrrbwID83C2TA/j8lPN/1QDfAemXnS5a6/h9gumlIZRURxSlcPAsy7So=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sat, 16 May
 2020 04:30:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 04:30:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: delete an unnecessary declaration
Thread-Topic: [PATCH] nvme: delete an unnecessary declaration
Thread-Index: AQHWKrFj5g2Ydx9+5kOkNZxOsbqnxA==
Date: Sat, 16 May 2020 04:30:27 +0000
Message-ID: <BYAPR04MB4965F14859CEF98DCA8BD22686BA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200515120659.GA575846@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfd958d3-70ee-4387-8dae-08d7f951dc2f
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-microsoft-antispam-prvs: <BYAPR04MB5829E42C155A2803E0A5E85986BA0@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:279;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24QejT9hlu9nXu5Jg1VB5cU4zTa56JIC8l6LN/5pjnFPtmd3rzq+7l3V36dwhUaB2o3BZB1Ztxtnfj+KQFpHgUZwsiCR5TRDdxsUEucOo+tZWXWtjB/NlDSNd3Y/zh2C1LXyTpmfPoLZFKNW/ykIk2mMlw4OTKlYd0Cd2TS9IFXbGyk+nGZxA6kFhlY5Bdy21CpuZ+Fi+EFWI24bHYugpzKVyDI9KdfICRLhAzCB6jtfTauVok4wthxTan8vqpoYbkcFBBdpqAJ9veHx1pf0+Y+7Y4OmTxQqOVTagVCDBUJ/PmbXfczKr8iM2U4NqbcGEl5ieVb8+asZYgPOTL4PydRf/qEqpmQTVR0XRlACvoeXrnin7q8PPxfmB6lL4gB86t6tN1ACgeY/uB5fNfzuuxeNThhuQ/bs5B8jNCIxyrHes0l/cbahVs8TrzA1VFFV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(55016002)(8936002)(8676002)(26005)(186003)(6506007)(9686003)(71200400001)(478600001)(7696005)(558084003)(4326008)(54906003)(53546011)(316002)(110136005)(86362001)(33656002)(64756008)(66476007)(2906002)(66946007)(76116006)(66446008)(52536014)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hwyoJ+AsG8zYuKyiWzjbTQNL2N2GI7yUghUW8Eqgx/IcajiZ04GYRxpR3afnT5yVwD5+fDREhkCfpKSyWb0nuGJdRPuN8JyExBlU7iB6DRXhLChjkmWbjAvfu7RINFhU847VgT8goZrw3X4dBuyu6+cEQ1spCwDymR491TD8R4HweFL6WwnpygU/SVUEHRSMeXR6zFTzDE8i0eXLwQLaO8L64Y/4R1kspnCt53YKqLAdpzoJXWcFk3FfD10KDIFHQR96BVN/2BV8dYytN+Io/XlTP9bIeT1En1zu7G77ofRdqXbcIEVvWNlgmyBCFvKc5sko1sJ5zhszqePIqxArLJnoAS4YVi5ZCiZamVVurYPn6TgoOGKZnXv76qzuDexNpnITGKlqIYPm4hIN75ED0l/M43jLA9Hxjbyeoj0x3P+Z1QGP/y7QPcR/isv4geGhUiUyjyml1MBSXrZO790gGZJ4JKRe/ei9xpdpo3li0MI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd958d3-70ee-4387-8dae-08d7f951dc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 04:30:27.6416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StnpU92DR5i5LnKwKRozDrvo3IfjFwKVxvO3KPJZOCKOGuOel6NkDIV/Cp7At53C6vppWkoVPLpgMNQN48kv7aO77hRQpB44q74A9FNNyzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200515_213036_927187_B9E106A1 
X-CRM114-Status: UNSURE (   8.04  )
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
Cc: Jens Axboe <axboe@fb.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 05/15/2020 05:07 AM, Dan Carpenter wrote:
> The nvme_put_ctrl() is implemented earlier as an inline function so
> this declaration isn't required.
>
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
