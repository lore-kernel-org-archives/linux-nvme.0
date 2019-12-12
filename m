Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6DC43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 19:42:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F84B2077B
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 19:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vfj9EkYV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="D2AJDyXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F84B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5C54sbHmd6jzNmq59opUdVlYzBeHdmhTsj/jpX61leI=; b=Vfj9EkYV2CW5l8
	/prYmFB2CYZDEIMcFoNgU9DSGRYUMVHbAtR/TVkogJNdXvJgxRCbyAsSnOXQwwIoQXBSNQmNA8UTK
	mbVbbCeQMHuc0cBGYv9ajxV97fD7JDMxKdaN/0XfUWB1d4C/QVQ9jGbYsiN8/hvFgtPxsRW0rXxqT
	+zTFwHbAIIobGrNNDRjTsANzzCCS36SY1veP+kHGQ4zybrpDX2lCW0kggea/i/E9+oDT9LCgJP0F/
	NZeS4KERemD5xzclQjetu/yH5ticoIlzmjwX7J0rvTxwvncY2ZbGdxGRFjAsS/mGAulIiYAOAK9g0
	GQU8QtzLx6entxFj0M/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifULW-0005a0-Bf; Thu, 12 Dec 2019 19:41:58 +0000
Received: from mail-bl2nam02on062c.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::62c]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifULS-0005Vt-6i
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 19:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W50L5fX5ojKYourAcXvN+6mV7lkOc8tX4ZA265SY/8+pBTgCBpi4f6iauAst+MlAlBWEhD03hpSsCWrcVh91cItj9k3TNzEa4d4xkEY8Q01TrekuCabY1Uakgdw0RZK/q4gKzbwSHr3sii47wXuUpNpD3yn+5dXbWijwCnAZVbZOr+evVw6NIdWOdqLs85xVnL5Nw++cymeMWWbrXYqECRoJVGQhGh1UpkFZkKeUgEJiCjypUo3OcVdFV2NnxaH9NLd6/4QiYg/BHnOF8rHWzt6ci4dsSyCnA+nPcqRdDeo7CpU2NRqwkpqlJupfgMjG28xQl6blpIA6BkTk/qEzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy0/O1RMtdtxhDLv5cvvqwtIJ117L9rcHB35Sthlm7E=;
 b=l9GGM8mmwt3s6JYk2M2otYd172gzPJeKOwnYCMpAJxeJf/D1Bmh+N4nOQIJSOaCJWqDEVR4VAE4fGCOT6SPEuYylvITc+4Hd3LZSOIpgtyVUpsuqkc4DyEi+wgW46SD/aQmZOPphW2/uCb8Xypvx9WAv0tR9jO2bNuK4YcVFiY2jc93rmHX8+pCKM6is/rBGi3wKfktiXICEJaPes/o60SuOMQr7FEt9yjrFhoTQ59VANygAsKKjrLLgIZDsCBtN5QddfHu1LGdTyQgjY+tjiMAFz5E0cfIH1Vg85Gdcch2A61IPOitFbaxvKUUnW9KFekFr2kyKSNpqPyP6tUlkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy0/O1RMtdtxhDLv5cvvqwtIJ117L9rcHB35Sthlm7E=;
 b=D2AJDyXJJlXsCfz4YnfYAbz+a6bgByMwL5EvVMxuLJNsJRePWZsFgMA4f+jJUKLj/CgPIMPYci3IDePxfZE5mWYoFCJfHKj6UES/AGc/HoeFyNE+qb7/+DpvgP0BhFISKwMeRPhx8mC8j+31ylbg85YBJMFc164OyaCYCc1V0AQ=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5602.namprd06.prod.outlook.com (20.178.210.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 19:41:50 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 19:41:50 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Translate more status codes to blk_status_t
Thread-Topic: [PATCH] nvme: Translate more status codes to blk_status_t
Thread-Index: AQHVq6ZMkO6rhLvvLE+5xlPgo7ojn6e2nUWA
Date: Thu, 12 Dec 2019 19:41:50 +0000
Message-ID: <93B95176-A634-4A62-A8BF-2C599E597979@netapp.com>
References: <20191205195730.5774-1-kbusch@kernel.org>
In-Reply-To: <20191205195730.5774-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7a94800-e98f-449b-5cf9-08d77f3b555f
x-ms-traffictypediagnostic: BN8PR06MB5602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB5602DD4EB59E758360A5ADE4E4550@BN8PR06MB5602.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(6486002)(54906003)(478600001)(36756003)(2906002)(4326008)(107886003)(316002)(33656002)(66556008)(81156014)(26005)(66946007)(76116006)(6512007)(66476007)(2616005)(5660300002)(64756008)(71200400001)(8676002)(8936002)(53546011)(6506007)(110136005)(66446008)(55236004)(186003)(81166006)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB5602;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oS5wxh7JB0+azBu9e9vEIoQMdAaJ7n5uqzBjfILBzegz6AqOeFEvqYwAY9F82EVszRLBvMxPjvQiEfmouiGDxy7omEEIe7GUglXnzlSnL46WRgIxwPEJHr0ZLC5PLzoVLYzoqFvNW1jZxZGNE/x2ky3TEaauXodeP5tmR90ZvFbN7NPWzQcCSFMCDpnfLOqlH9UZhMK6zBOcstym9MvIIa9TrG85MUN9qticfCWEHbw3stBdcaxp3Cn0NjK/GaLvcckN6oA9P8zZ6faYY3HmvGiBTJMx0+Ce2YU1z7pk7ZX4V1ZBSZwbaKVYzXy5VZRO0bywc6RiX6HRVzaMo/BVM7n15hftFSujipqKEvfaMGIhkNA1f3mBiJRwClCi2L3BVPd1Zp6hU0VuKPpOV13Rye5laiKgtaoRhmecB10JApVOXV8wXuCagUsBqa3jTL6S
Content-ID: <2DF29E162FCB19458AE9F29C8363AF5D@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a94800-e98f-449b-5cf9-08d77f3b555f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 19:41:50.6666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RSjt6m0MB47t/IkMJ/zyTk/rNVNTcuY8ChYkqLpi+6LqIPtjWdqAZwDahnN4K32RJEZW9QsvwZDQb+Q4r7WlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5602
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_114154_346917_CE0D6856 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: Hannes Reinecke <hare@suse.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvNS8xOSwgMjo1OCBQTSwgIktlaXRoIEJ1c2NoIiA8a2J1c2NoQGtlcm5lbC5vcmc+IHdy
b3RlOg0KICAgIA0KICAgIERlY29kZSBpbnRlcnJ1cHRlZCBjb21tYW5kIGFuZCBub3QgcmVhZHkg
bmFtZXNwYWNlIG52bWUgc3RhdHVzIGNvZGVzIHRvDQogICAgQkxLX1NUU19UQVJHRVQuIFRoZXNl
IGFyZSBub3QgZ2VuZXJpYyBJTyBlcnJvcnMgYW5kIHNob3VsZCB1c2UgYSBub24tcGF0aA0KICAg
IHNwZWNpZmljIGVycm9yIHNvIHRoYXQgaXQgY2FuIHVzZSB0aGUgbm9uLWZhaWxvdmVyIHJldHJ5
IHBhdGguDQogICAgDQogICAgUmVwb3J0ZWQtYnk6IEpvaG4gTWVuZWdoaW5pIDxKb2huLk1lbmVn
aGluaUBuZXRhcHAuY29tPg0KICAgIENjOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4N
CiAgICBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQogICAg
LS0tDQogICAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDIgKysNCiAgICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KICAgIA0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCiAgICBpbmRleCAyYTg0
ZTE0MDIyNDQuLmYxNzMxZDg0N2UzOCAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMNCiAgICArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCiAgICBAQCAtMjIy
LDYgKzIyMiw4IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9lcnJvcl9zdGF0dXModTE2IHN0
YXR1cykNCiAgICAgICAgICAgIGNhc2UgTlZNRV9TQ19DQVBfRVhDRUVERUQ6DQogICAgICAgICAg
ICAgICAgICAgIHJldHVybiBCTEtfU1RTX05PU1BDOw0KICAgICAgICAgICAgY2FzZSBOVk1FX1ND
X0xCQV9SQU5HRToNCiAgICArICAgICAgIGNhc2UgTlZNRV9TQ19DTURfSU5URVJSVVBURUQ6DQog
ICAgKyAgICAgICBjYXNlIE5WTUVfU0NfTlNfTk9UX1JFQURZOg0KICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gQkxLX1NUU19UQVJHRVQ7DQogICAgICAgICAgICBjYXNlIE5WTUVfU0NfQkFEX0FU
VFJJQlVURVM6DQogICAgICAgICAgICBjYXNlIE5WTUVfU0NfT05DU19OT1RfU1VQUE9SVEVEOg0K
ICAgIC0tDQogICAgMi4yMS4wDQogICAgDQpTby4uLiBJIHRoaW5rIHRoaXMgd2lsbCBhZGRyZXNz
IHRoZSBwcm9ibGVtIEkgcmVwb3J0ZWQgaW4gW1BBVENIIFYyXSBudm1lOiBBZGQgc3VwcG9ydCBm
b3IgQUNSRSBDb21tYW5kIEludGVycnVwdGVkIHN0YXR1cw0KDQpJIGd1ZXNzIHdlJ3JlIG5vdCBj
b25jZXJuZWQgYWJvdXQgb3ZlcmxvYWRpbmcgIEJMS19TVFNfVEFSR0VULi4uICBJIHN0aWxsIHRo
aW5rIHVzaW5nIEJMS19TVFNfREVWX1JFU09VUkNFDQp0byBoYW5kbGUgTlZNRV9TQ19DTURfSU5U
RVJSVVBURUQgaXMgYSBiZXR0ZXIgaWRlYS4NCg0KW0JMS19TVFNfVEFSR0VUXSAgICAgICAgPSB7
IC1FUkVNT1RFSU8sICJjcml0aWNhbCB0YXJnZXQiIH0sDQpbQkxLX1NUU19ERVZfUkVTT1VSQ0Vd
ICA9IHsgLUVCVVNZLCAgICAgImRldmljZSByZXNvdXJjZSIgfSwNCg0KDQpMZXQgbWUgdGVzdCB0
aGlzIG91dCBhbmQgSeKAmWxsIHNlZSB3aGF0IGhhcHBlbnMuDQoNClRoYW5rcywNCg0KL0pvaG4N
Cg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
