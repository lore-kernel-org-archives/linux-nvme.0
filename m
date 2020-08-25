Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF60EC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 22:18:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9697B206EB
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 22:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZ5gPrA9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y4yiQgkq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HSSIjPC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9697B206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=aUFS4JDiWWVl6Cx+gNfjYAgiebKim2hS6rlq69I5wi0=; b=JZ5gPrA9rSi+xUTx6gpMODwcX
	eR9q03hG/l4sab764IgUYeGADi7+5kzx/kXDwubH9iubLE7SApKvxQvbhmB1LgF+6vznEXdyJBFdw
	vq2QbxB7H3HFDPkMnKrxC6LYpy+7SHjCDXll6o3R8CVlRSlIld5yqwXMX94SnG3vDInXoWcu24OyM
	tO0M2Ugn1j4QqnToRFxuFBcJbHSTDipIMRdi1ePLYTfvLrazkPxYEKaHvoc92Lzj5fUFW1YcmG2Q5
	5U2GQxbrLZxYtVjlcy52WjWs8emgkC6IXKbSAc2J/b4vREY4LHQohwO+s9vBbt4mwFQ9KlqbRgX+p
	16Zg9MY0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAhH4-0002YF-5J; Tue, 25 Aug 2020 22:18:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAhH1-0002XG-E9
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 22:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598394010; x=1629930010;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vYb/23Ox1jsGgheuhugvjDIKXwBGUyn5fumoV4i0doo=;
 b=Y4yiQgkqNBBhFhtpCKpjRB1O4DYssjpHXyr3CRF3jliQcZBJyghfbnEb
 UICOvz9EqHea65ZBQIEmh0WbOlq3ISeoFcToT1iAZ9Uv1jqioUluST/ah
 TPRIqKHDTaki6p68wVEAMPCkG1JJca+WHelIgb+ov1ENjAUohvmTgzF2c
 /1BiqfHiR/ybzBVFqkF1IXtxlks3XNiT7D2EqTjceYHwGaYeTsWn2noO7
 AC7YC+uY5Idc0vYagS6pJTafX3EsLDO8ZodCSax9tVBKG0LNNUVHj4TJI
 xrepSS7F2RDCM17cid+dNTYfoyBi86s4DV3y1doujALWV1tnhf2APesl3 Q==;
IronPort-SDR: 8KKtOuMNx1Np3uHaJ3J+lXnroLXMQsAHwEb5CSjbuhQJixcO6jPPRS3Sf8UX5z63xB3WfF2bdp
 /GY2ZYluKRvorLrozXJvKBzEEAmVNQ2Yw6gmUNSXBXHDWFoK519Qa0N2zyKMyAVRxZLGlZkXRY
 TRATJ/ICjMdhnf7IRTdqal9BaTRa+SCzSFuAcTc54Yu6rcrvCOPISKS6PvcEaGY6YvVeElbZFa
 t5/zm6zT9Mq7RqU9ft29jMCN31QZIikjEAEx9X30/dBWhuFSIBCbZh0qqTLpRagoU5T4OOedeV
 TdE=
X-IronPort-AV: E=Sophos;i="5.76,354,1592841600"; d="scan'208";a="249053411"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 06:20:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AapqANgmWF5Wx9/bhsrccPWevf9TEaFkyhJ/tvp/oJ2D1PSjeZwTBx7X4blDH2lLN2IIEzY6ckdbiv6bobom/Pw/KlOUwA5GRHCdt2VU8fpnbCreFcKSp8l5+AcumvrznEC6yIGYvooeySRfDVuOFFfpkAf/k9rwOkiXw4PlFJq2UuCglkq7ARqvQCOMKvNVsH/+hn2Tn4h3ZqYIsBSfq2cwCriNpCiOjLbISa79AjamK7GFUZSnqEEDvZQefQWX3Odx9NVJPrzJ0yCTpI02YYl0RaWrSaB0zeAwhINQetIz/1z4w8PNP3w39mMfA5NwhSywfmhpEewb11k0cASaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G8zrs9Q7wx45zj7lz889pQleUiNhzxEkkFxKg/yQkA=;
 b=XaTU81wwJHfZ+pCTFX4GgJ6+660Ldp+v/qSg1JH+UnWDxd+6bRLzuyeoc2Mo3fLiZO0aQWIFX1bCq68hJPQ/lnKVTV/MmtrvhS9MvO5XTBJM1dNyiPmdmTu6mvHcjaCFDRpH0sR8Hhjrn1PlxUDRWTiyTytIjDVUK/i8MWC86sfJk5fU3rZQMnhATcJHiBSC8/TaXdBUSInDrG6OSxhFjtJvGdHfA752P3/ESVTVrVRlSkP902Hkgw2WeeSb0jjlOTTq9j4inoxKWij7kTIBW6rTsn1JzzNsMvhO+qlmVub/R1pVe0C7+o/+Xh0aWaVkNVkHJ5ZC7heDWc0XHJk1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G8zrs9Q7wx45zj7lz889pQleUiNhzxEkkFxKg/yQkA=;
 b=HSSIjPC71yRPg1LsUzmLcVr6UdOKcvKfyk3VYPHrH/wcp62+JYMkpU6lRPiDPfO7UH+BstzxUh3Z6WCkv2wODIjTV2qW4JLga9ukFiwQzwb4zvFymk1EtLZDjZRMC+s2lSHmsz56y3zIKhw/iy8qeqLC0FK4KXAztiF4b6GV9HI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 22:18:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 22:18:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix error handling in nvme_ns_report_zones
Thread-Topic: [PATCH] nvme: fix error handling in nvme_ns_report_zones
Thread-Index: AQHWesescrAWOaC6v0eUZAunw5mYYA==
Date: Tue, 25 Aug 2020 22:18:29 +0000
Message-ID: <BYAPR04MB4965365B38782DA1EF55981086570@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200825095824.3542647-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bf5b164-0376-4830-fa78-08d84944cb82
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124FB90C2C25B66C1858B8686570@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0tU1sl3N6aeJFxCQPkP94HmZZruaaJCSyDqVzXCVU2BLo9UgjVbAFF/3peDILPXpGtRmolecI8S+aI59kgZ6jAYYJ+mzTSnh00U/Sn/MqWHN6FFUF7B4oiedViUgcblhRz5Ohy4fJ/Yr/1bpKYl1OMWqQnIK1g3lpedYLZwMdYBn9cXly34CGmk0L1EoRTkXlIFe6n0ixEyqnhYFPn9zQ96RcmyEjv2/6447lQ/WJm4yqhuOxGK50Tb3PjSikZ2TSxIANaRddq0yG47Eo0NKaLmRhMDCxy71PVNHHfSFfRXkV4jRx03j4nIfresMbuJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(9686003)(2906002)(55016002)(110136005)(316002)(8936002)(4326008)(86362001)(478600001)(33656002)(8676002)(52536014)(186003)(26005)(76116006)(71200400001)(4744005)(5660300002)(66946007)(64756008)(66556008)(66476007)(7696005)(6506007)(53546011)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IqDbhdRO7lvLRP8iTYvR/T1RBciyq9ApCvdoaq8v4RZdOEMJEUce/tY4QBNdNjIHgbKYcEgMMEI+Z42tb1I0fYYmDtEprzHoGOnu7tZRkG/Rxy7NvIuLUeCe3CSyNRSHJsCUONryXQch9TBEoXL5b1UcguF7Qad2SWe3t396WmVo1eNwcmmufdgBPNGunjq8+CmOpYtorGS7Oe1t2okmH4+2jIrL1wzZjI2lY/PzZscIbJ/EmfAujY1qBKctE+ZAHSXxvNfEiddNyg0T9YjrPHg05LnEC34GALIqvVTCPDATZ+LFkKnGP7noPZps1j44tVQKvKNpp8+PGucNWSkzHmJbSpdtQWAHx47qNXlVM5ojPLn86tHsF92QBSTtzMpAe1BRVtzg8LQjWxQSNLzJEsI/k1HiMePwDVq4hCqtUrYtj/jI5rcQCwjLCy7EJlnzILjIq4mQ2N2dFEIJXSkivqVFeZOpn5jr2ns1lBGDeQTIDecaYcIY1nB+K+eO4VxtKWX89scV61Ey0kxt7pcidkSnHJQeQj6eSV7gCaarUGca+uYQyNEzYbkMIg2Iw7j0ThSW/djpi79LSpU2ZgwAQxyVzpm5W3y3FE3CMVzM8BDGVjfB6sDgnlIBOT8LO37SvMnEkgwPTTQwydmJ2S8OKA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf5b164-0376-4830-fa78-08d84944cb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 22:18:29.2478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBNzRsKYrXtPRz3lEsKSlfq3+dfMSYC1NNnhYtqYVX+PzNdHQzpq++AvFNe4pB5GwQ6fDFg1W4WA7gEr7qtAfUa52LqT1ErxlLnTQbWcwUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_181835_661453_1D050C50 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/25/20 03:08, Christoph Hellwig wrote:
> nvme_submit_sync_cmd can return positive NVMe error codes in addition to
> the negative Linux error code, which are currently ignored.  Fix this
> by removing __nvme_ns_report_zones and handling the errors from
> nvme_submit_sync_cmd in the caller instead of multiplexing the return
> value and the zone size into a single return value.
> 
> Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
