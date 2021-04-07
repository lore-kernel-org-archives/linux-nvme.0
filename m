Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3520BC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:16:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BFD610E8
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BFD610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Sg/e2tdihaseKDJUOaqP7rmrLhS3+pyDye/yGPiYg6Q=; b=NzCSPc6Eaqq2MDFwYEYR9L2dn
	ANwL0W+frOMtaGGDTJRhQUsLZad+QXKgmkiSobEGsrSKBa287LPqU5UrEHfvRZ+mzxjH3IOwMmG71
	xLHsxIbv9X/ofrsPZ8X6Y9pHdn1JB7fYI8HBPmRsH2+FDTRD8JhGSHfCDNz79E+paw5WMBvC1pXyI
	ENN1AmuS51QmZQ2mmWZUE2egEukZYWfYeAwJRthBCXZSD33PKMsTS8+p1LtQN/199AOLuWe7TONwx
	XwpmSkV0Tv8oBfSk73JvsROozrdl4/E9af0SfVRAw5lXakJzGx0JKdTA45k2t++FOIodaH1krKpFK
	+u8DAsh6g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUHPI-006G6K-LJ; Wed, 07 Apr 2021 23:16:20 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUHPA-006G2z-Ps
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 23:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617837372; x=1649373372;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=V/3QxC4zfp474uJIoUmXs94yneN4SSio/jBssRqpDlg=;
 b=NboLWogc8THygI+OF3DKRr2ojyxmVwE+8r3VHh26Ei0km41FjO70ikAK
 its//4K5hXRZ4yzOUkQ+/VcOoCWmTHnOpLwH2x6v9emZS9ybwUUv4HsMM
 rc/hInsmfuSM3/uz52gnF1H0vmjsyMuONS/Y7IM27rXZSNag1kYlLy1HA
 eUDQhJG9StNPVlWvX8Oj9NqEAsTLfX/Bqr4u/Oy9It8w0VYpFftXl7cb2
 ucSkfuZ2nToT/7bi3dFR0K3YGN5bLG2PlFjADh36JnyDjh9TRNUmqZC0P
 XVWpDWmez/Y5QQoU9EYJaF0b9IwWI5C+y7j63MTW+rYvtQSA4jG1cR/WF w==;
IronPort-SDR: F8w9oVEkdeB7sN4UoHNjY/5oj3Sk9eN094WAKVl4E0qamMEpCfEhLREkj5PoNe/JsoGpJra/Mk
 GVoED/lVzDIxFbReoBEJgzVY16SqbJ7kaQmd3dzoiAzS3Y5G2ODT4X7sx5HQWcZEhXVVnfV/Js
 a9aMcGGbDH9vS0o/J+o3kjNJ36iJbr1YZT9hT2hwYSL5UHeRsvF3/nRvjK4agia1NxpbdxJYo0
 GjOTAc8ZRhv4vDytfP0aYuwLIJN1fuDYXgH3SFJ0GGGkhInMXB8ckAhoLXj809YT/GuE799Ajc
 SRs=
X-IronPort-AV: E=Sophos;i="5.82,204,1613404800"; d="scan'208";a="274988181"
Received: from mail-mw2nam08lp2174.outbound.protection.outlook.com (HELO
 NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 07:16:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmHoJxvwbQc1ABb0Yg0qFTOiK3K41wps7jujEMCkxRDvdWdRYud4CMX40JOBD2RD2W+YEZZ7r2bQSAeadOEsU5o+IRjrmYWvr84PVwN8UJ4UILYdZV6VjTWi75kXgT1YpL37mnMadq00j3wqZw55x1hQijqVKZVtaiBXDcMwBp6BbTl6AavRTzvvg2cpGIZCokL35SfbmxhN48amG0DmhftzVpeBRQxAfM4ZoKKP0JEuPb2UmzZ38zYAm9tBWpAKFFjaDmGWtwPdf2WTH/s+3UOOhozY2zOTBYjNBnnrm3C4iChaczZWK/gVAMw3iTRBN9Qxf8xr2SafDSIyoeg1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/3QxC4zfp474uJIoUmXs94yneN4SSio/jBssRqpDlg=;
 b=oUs1I3QNKea8Vdf2t7upgbq9sjTbdGmJHqPVwR83FPb1++1eOuwh+XKzDYkhR5YasHo7XcTqF9c77oNzV9oHtglX5HfmaVfU2Fyy2aaWo7JI9uyYobylKb6jdz7Tt5EHiDPJLhfxEPmLWzhwsXp7fJZwvbWcDDnn8U8m24AEQhnc534PfvJDL9wffggVDyYq37FqD+O9BmU2Kj5qsDlT9lviBbta1PnL3RTSkOBRlxKd9/5dBX1REkbqxM/h8HOBGJEh4VJLUWnb8NyK6GRkC52lQx6oqO/5EAlIIrTQQrwDA0CCbK6UXhTAcBrD7g4kZa+AKUFgdghe64l+va24ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/3QxC4zfp474uJIoUmXs94yneN4SSio/jBssRqpDlg=;
 b=K9gP6Lsk+gaclC2lQ0c+12TMKFmpGwnd2eaBdr6ZhslqLM7Tzlm7M5m30VkGNL7OXR4hQR3DhjxQBNrgH/fCBCRh/rhTyT2LKtnwZR/x+EH337nHgNa7ow1tJpMWCi1mXsVPQhgh5LhYWypSCk2CVL+MUPB9l5sEFHMcFpeLnXo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 23:16:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 23:16:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "tasleson@redhat.com" <tasleson@redhat.com>, "tbzatek@redhat.com"
 <tbzatek@redhat.com>, "prakash.v@samsung.com" <prakash.v@samsung.com>,
 "d.palani@samsung.com" <d.palani@samsung.com>, "javier.gonz@samsung.com"
 <javier.gonz@samsung.com>, "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "mohit.kap@samsung.com" <mohit.kap@samsung.com>, "krish.reddy@samsung.com"
 <krish.reddy@samsung.com>
Subject: Re: libnvme questions
Thread-Topic: libnvme questions
Thread-Index: AQHXEJkDKinop2xAF0e5sqK7JXt5sg==
Date: Wed, 7 Apr 2021 23:16:02 +0000
Message-ID: <BYAPR04MB4965314610B9338D1D6D32E986759@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c8585d3-6da5-40fc-153f-08d8fa1b1c89
x-ms-traffictypediagnostic: SJ0PR04MB7744:
x-microsoft-antispam-prvs: <SJ0PR04MB77445C3446ED453B851BEFB186759@SJ0PR04MB7744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McLIH9+AsqHjtQk3Y1Y4fo+Ko1HP5feVJIGvfB9Da1JMxHMIapSm0fEteKUNG8EYVDVDEwMnIKb7dVxyPPVePtCOPQKi+gLiowhfyFqJwtPkkt1R+mSesHKPYsfrM1MGmGCgC6Deov9VlkTV8aQ9lOz0fspO6Q2ky3Ho+HbstN61A/r2P2wiMCcPwmswwd6G4gL45ChZX4X2SvMMVTE3Ka4s0GZ6ae/vTKYZWh7cNhwhvrgZR0fY3QkX6weCGOHxmepd5pmsx936S9nvAUPwJ/VR2X9n5BreIHypj4XGCrbfcCgrDMGVS3ZxnZmumfOaMh15rWQ/Ed4/DXQt8v6HMmUE8vhfUjCkMK7WfsRVrbudIVHhleN7OCNR6q2e6hWiHq6MrVKMotPq2pQJnewFH2Klk4x1PZQ/dR/lydoTV1Wm/NZYXbrKQ0YjZizkedUGTb+5yaQ0Nox/oCZWiKT0JzcifU9CuneaJKYHaBBiT/eEL65niGLuOxhjsNxnMtQH3VZjISplVxg+1GqtQypYJ3zxWYTyNMXvrirrRWVv+gOAqUhYvJv1l51SmGBroijpXqpu6j8uaCHtyPpdundk4E4EnPuvBx4STr94yKMKNQlpNJcaCuXnE3gC6tDdLHcxzC/SxAxScipP7QZhSGPhGVADRps1gpp6ZADiGw/S0kY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(110136005)(4326008)(33656002)(54906003)(71200400001)(316002)(66446008)(8936002)(38100700001)(8676002)(5660300002)(558084003)(2906002)(76116006)(52536014)(186003)(7696005)(6506007)(53546011)(7116003)(7416002)(26005)(66476007)(55016002)(66556008)(478600001)(64756008)(86362001)(66946007)(3480700007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?veIBz80GZSjhM4iaR4rKIFzrKeOXpMxXV3/6PLOlkB80KHWvTqsTs0wzL4ab?=
 =?us-ascii?Q?omjR1rdmOzpxac8yTbZt4XMR3yezKp0MuXvRINnXZIhOUTdgPslZjuTKbVAW?=
 =?us-ascii?Q?tptSGBajYTC5MQ1LK4oyIpnnH0jzbM4QXRlM3iN+sepbny1IdD6Mi5/Q/kAt?=
 =?us-ascii?Q?D9wTWnpqRTo2xPNROfkllvEBq/ktulx5/UT++TErdGsSRG0RnpZXayzhW3ss?=
 =?us-ascii?Q?4lCRiLCNeF0SYucnfz/fYJFbx+y8T7y0vmS5AGSiFhhNzPcsW+Ee3REBxjPB?=
 =?us-ascii?Q?xVt9kAszU5jAQAAfJNZs7WJDbwpAN7Z88wYNg8Qa+fEVs9FfhjFN85sFYOIl?=
 =?us-ascii?Q?VC0b/O5MzerB+y1jhrkh+9WDnSnlfKIaUIPk4HzA6EXYzBIqEPy+ei1AtKJe?=
 =?us-ascii?Q?ZdA2cFAx9igpEbk/MgGUNBn9SlhQxAlyPJGLRDkVm7ydzlVvdjOeGD4m59zX?=
 =?us-ascii?Q?8hzhumNYMifj+kUQ/j2v7piod1FKzcHNhz9Ts6VSJnSdk7onTNOjQle+QBmJ?=
 =?us-ascii?Q?CPAtEmG3B2mRUG/L/sojWP1ChRJzSNDSn+l+/JEX/srAVg/Za0HOeWq7wwno?=
 =?us-ascii?Q?olm+Jgw5K70d8YPb99aKGKPCOkaDXQH6fYe5bw1TdphQstPSrOI+kXUZasgX?=
 =?us-ascii?Q?1/5dfu/5QkXkqSrJl7MJg/o6dGSBjJxYHWVZDgmWT9ZClabeTsSfVU/IZPN+?=
 =?us-ascii?Q?JPuxlcMLQCqVrTgBUQpLc52031eCczPzCJMwkwzSlcNLEjZ8E7GkpN5/b06e?=
 =?us-ascii?Q?EFEDFlGEFjx9ZtMx40jqUO9EgWi0FPzE4yz9f9l1cPkdNG1y4KkuIXfr5iB1?=
 =?us-ascii?Q?VXxEEJ6mLhVbqN5NlM4vVQeXQGOq6TA5YhP1rSb1GW6coWrBdLnzjTDjyoWp?=
 =?us-ascii?Q?Z6nOYneRNWvICJwhmzta5t8Gg+DrKTwHYwRqY381T4ceZGxczzlJJASLCq+q?=
 =?us-ascii?Q?5QLDNS2YVeaBLsw4/opVq55XvYw0ZaytKYD5KiLprAFKwnIfi6cMuXzzdeyx?=
 =?us-ascii?Q?mG4Xeok40Iwmovtb99eABCetPN43EWqAK4YBtA+NZldiK2sWdNPT0I0wmaDY?=
 =?us-ascii?Q?WSbwBGBhcR20Ufzrr91ZjE9goOuYLPQCOrcFN4YkMaHWi8iUWEqV31qhF0nz?=
 =?us-ascii?Q?Mp6G9OVng4QIr7Fk4KC8HXviUk0C6f6Ae6FhNxJBC6TzLVcPKPvVioOPTs9D?=
 =?us-ascii?Q?9IgR4t3ApIzKRXoWBYT7xRPwn3GGaM1vzuwcG523AAl3UB3Av4ql3KuhP24T?=
 =?us-ascii?Q?HzUZKLD4/lvFB9CTzkyVZpMo+4Fn6HoeXCFbQYdlyGmBV4b/6zVYFvRKeoay?=
 =?us-ascii?Q?lC520AAA/kLLd9ujpNnHJvGf?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8585d3-6da5-40fc-153f-08d8fa1b1c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 23:16:02.1312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9n9uiD+48/R29nx9FvymaO0s/dmvuLZ16eR5JJB+O/NS88BzaKxynlDsLEWPgy45VGLt+WnuWk+SnTSVtWBnfTiU7ncYjMbBdh0+hEjH2V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_001613_618899_7BBB447C 
X-CRM114-Status: UNSURE (   7.34  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/7/21 05:46, Padmakar Kalghatgi wrote:
> Along with this, we planned to implement the sideband MI command handling in QEMU.

why ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
