Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1851C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2019B611AB
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2019B611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=X5n4rVGcwuGVMACvQSorTUCNEX5imnQpSXBtQTWY7+E=; b=YZ509IUJTvNCq2eHkEUBPlbhC
	k4OwftLrRMAfOj9AMhjBY3AZDaJPnQtpN9rdtiRcetueQ4WjJcJL9SbVzORsc6ZIrJ0iN5N6ow4xg
	3u0TrUYMQ2Bep6bn1bjtwrcg1895BMfwygP8nU3xaXAewltWUmTm4tDZWBh3mn84St/ryUkA98+jl
	2lWNKiOJaTPY6DUl8uwCciDrDIa4znFNtMD1SNhH7MgSNEplAxKH5napB4qL/4Dp2ISoJY8lD+baV
	F7bYVdXMJM4qhG1Ai5Sk0CfU9ofwNEA9TB29jmFslwiLEC73/fvDj8zIfetI8dj/OE/IT5c91P1Gk
	XLKp2lwOQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgBOU-00FWcz-PM; Mon, 10 May 2021 19:16:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNl-00FWUd-7F
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 19:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=7W36z1vuzLjewnzIechDofXLqKvBgZYwA4BMZa6Fbog=; b=TX4aVl3j490nwlLLYTbsw8oDvB
 U1xe3hdSvyqSdXrDUjJwAQnrdkTyJtCzh9+eZ5qNhe0dlF0c/uV1cuZ25tzS7nsADxRGzSe6WPYHr
 VL69JlblhtyzQLktDWXtXbc2aoa/sSwvT047Sbm8SUuPe1+alvn9P0RyxkgxrclSQfIccn6n8Fr7A
 U7Suge2E/x8YcelsJnv0ud4rDqH+kTANfIL3KUwLqTwIyYwN5UeciH2MvA+byeVLMIWZh1bDP7CWN
 S3ka5w4yiE7xPQXVotU7jamlHlP0LCd0GajWd1guOKS3yv0wYUqtYlpA6/niPm/ycAr6viqqea9BH
 rciUjORQ==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNi-0093uo-Mq
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 19:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620674154; x=1652210154;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AZIHeJJFJxLHaV4IQQ2VO7MHnD8rzispOKBTIqxH7Co=;
 b=WWAEEWlnbqRcoKzXCXfMvS4iC7p29MbSI93zS3Z7mf7FXuZ7NAmxL6Cx
 pZ5toRqPQ7q2xj7URrdaqFnr5K3JI0qGDYTEhXj3Nobe/6o/B3atyOHKJ
 cR2PM5SAmF12Z/ooTij64xQ7KdxFLF5EOLQImFnhOyWFsZOL/3rZ8OC6i
 24kcElLRzuP6tjErohw8NBSXKwOPDbT/0OO1S5oxgMaN+C4VP2opqksr1
 BshzICFITrILqXnVRJDItGvIBad1jmL1Qx+KzLIywdaWLfjI2RM3mHGV3
 aep3qhi0IkvwBqNA4i6Lc8RvOlA+Hi1/2g2sEXj36rPNVkahnVxWw35Op A==;
IronPort-SDR: s941bo1hkm22e11UpxR06kIrXIoi3uzxKgvIMyCAKRHTej9xs7VoKQGFXsrbUGsETcyO9Qkh5L
 /IbSsAOPvXp7Os2YF+X3citOCMcurNWIcANSy2vfvtc1NmgeI8HfbseZ9hkU12ha3bdgVSR9Vj
 eQU67g0KM+gN6lTtRYiMe2+gAYG+umzb8jq79/PU0HHfhJRaLc/sfO3ObDc3NMui8LweKgslQO
 svsnIpVU1p0LcuPPgV19uGrvvmo/pB0yRy+eJL4BAHsB/q0+LbbWywLnynzVVV1CFy0tb0wwg/
 bFM=
X-IronPort-AV: E=Sophos;i="5.82,288,1613404800"; d="scan'208";a="166992013"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 03:15:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDH6Ycn6TXbMjWXL7qfNRZWSLWAEe+mg+XXe/uJPL5IKKAWwR1TII0LWeV9z6j+MQeY3r4n96lwJzLxxLf2gQMaE1VuJNe6KrXAcftjM5AzKP9aXGuADQ6XddcfeISoiny6QrKx2bl8+g4U6WudOgqojGypWEGxLKhJqvDxyn0auXhu+ISQQZI3dNSRv1sniVvNHzX2nh5X0wY3y+0v+QZ/vN5u+MtVCv4bRRysZqMmriUowM9unvndPV58Xx0DRUbzS+LmcWCmtytKgsU4saLF95k7+jMqjrw/TgYN8/5d2NcKWojEPWVnoWkusx39kLEwhxNnbSG8+lLyff/WceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W36z1vuzLjewnzIechDofXLqKvBgZYwA4BMZa6Fbog=;
 b=UtsrcGXhb1ml5xJhadI5aTxE/6O2fN/tNMuUWC9OiJv/LI/hqGlAZbP5aV6TqvWpw5wXww7+H8JKmwkWAmvrisDFQ1zFZUHD00N8xesIsa7vxd7+ePCY3apDYpEtX5QZjZpcBnSC2JNTMWlZO3yIg4bIQHL3jLfbebxEFpkMefkSb9KP7tHhCJMzkw18n1/7Ov08oasimbI+ItBFKQnwyzLCAWXThW2R5a1HYTAt60OktIE3Z6XcT77wID6ED8hdg/836wAeLkPHE+G5uEmasuF7nghf293QFsSGr+uMUJtghVm6sLFvKgMb/ifXal15KnSHjI09ywM+wwYvJthOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W36z1vuzLjewnzIechDofXLqKvBgZYwA4BMZa6Fbog=;
 b=WPshqBSYd+EMVmS7Y82g3gJ9uWKBYHvFpkXniFqVGvkW/NndkPZ+e/hmpkH5f+9eIOL34ebuGusR75nhfR9YsoL/fnSSzIN1w5eYObHvOwCQn4fswsyU/GBILL+nDj9GAKHQjlAq+n0YBm6bbp/sbhoohbHx6YdrSc5BQ+GuDvc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5256.namprd04.prod.outlook.com (2603:10b6:a03:c5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Mon, 10 May
 2021 19:15:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:15:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>
Subject: Re: [PATCH 0/3] nvemt: demote high frequency err msg to debug
Thread-Topic: [PATCH 0/3] nvemt: demote high frequency err msg to debug
Thread-Index: AQHXPV0jd9LaY9OOv0aQyZJsUec0rQ==
Date: Mon, 10 May 2021 19:15:51 +0000
Message-ID: <BYAPR04MB496546597257397C115025E986549@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
 <20210510065955.GA30907@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0804b48-91b2-43a7-011d-08d913e80678
x-ms-traffictypediagnostic: BYAPR04MB5256:
x-microsoft-antispam-prvs: <BYAPR04MB5256B3FDE5B745052F50C14586549@BYAPR04MB5256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxoN70unyRV3+ReLAvKHRqrr0IeTFwCBtznl1CvuW/iztGkVQ6RTIq4V/CJZkynMjWk60TwtabhrwwvsGHCngRivxlTiTaF1DBwcQTUAaKj5GHue+SiW2lDetUedcp2t7KJtp7I+Uuj+E9xPJri213BrcDF0bGeblCBdq7cL4YXhDK477lRjXsp6NvWAvGPDFBd+esMw4WS465KqKo4HxbatHiOr6nTtnEeQPy74pm+LagGSLwlJkuJ/FSvZ+BumSCCdHOdJ3NoGcV54dhYMS+FB13HrXtm2Y87IdDGeLTHaq2gt3K55SVrHpcdlBvtqJC0tM1/AW24G5S8rtWFnmXZnLnvD64z0huijtnhAjg+TpFuO4AfGLJPOXO6nrC4Cira074qtb6qTrBsk30OYjoBgIzZ+7W9VxXKYSFJd4SmfQBHx0hRih2odUY6cI3+wASbwfZcWZ60bnrrK12Qqc/YUw92W1YFMaX3W6J1nCpOK7igwk+ZScXuVw8TDWyXB5dlVr/szaKzfE37jV8wJmSh2RxKtt0lMQKKesC6T07oCqbU9t5cIpJdnYgKmYD4AoVLZFEm1O2Vy98zHt7v2UgG2Vnb2kt3yE4VrP60CsL4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(2906002)(122000001)(54906003)(86362001)(76116006)(52536014)(38100700002)(66946007)(66446008)(7696005)(64756008)(186003)(478600001)(316002)(66476007)(26005)(5660300002)(8676002)(71200400001)(4326008)(6506007)(33656002)(53546011)(558084003)(55016002)(8936002)(9686003)(66556008)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dfhAQutE6pvxUPm50EkPBqkOxs91CjrjQ56jABy4vB8zZfd5Verdy4CK5D1B?=
 =?us-ascii?Q?QcLypjetwWsL7aCjZANP3pJU+Fh9APwDUPvpgHaZlP9Sq1wbv2IOJpC5XrSf?=
 =?us-ascii?Q?JhPK1VcPdf3rjL815Gh1e0SP1zgbV6Jg9uHxtwKSPPA/twT3V03Wil/BgTr5?=
 =?us-ascii?Q?tuHREFaJPRBS1p1Z3jT5VxZ7MSJOWATk1Z9nbcegugu+ixBSxtF56XUxLEu8?=
 =?us-ascii?Q?KKqvz77GgrlYnxhAt5T9+fc840c2OyHQiWF036VU0VSrWI6H8nD+i8LDvfx3?=
 =?us-ascii?Q?zB252hOkbNPu08A6ToOw7oFLOI1J7tA6FSSJsqvz7daYrtYaIOlqe/cVac0o?=
 =?us-ascii?Q?svh2pKa6/V5mGw6w9+AiVFCHt9LA6bE5hnELwIpWnBucQCToSoIhNW8qsZf5?=
 =?us-ascii?Q?WogCaX7FpHcQ9bklsCgK1DVn/L7ARyrx7+XOXeAOLAsTYwGuvt1fnn3CjT1l?=
 =?us-ascii?Q?NiObULBlqv/GuzwWXmjBi8yCU7XoxraytFkNhcWwjoED/PZmIoTFaI2Q+jdV?=
 =?us-ascii?Q?NUVReoc48UHJm7fjRVQI2dOkpnhWOXu0hTnxFFc7gtncoL9SKD60OXnnkSIG?=
 =?us-ascii?Q?pGL9xnPw0WNgCsi0iu6xruPdk2+NamLRp4bB1/OFOWgasIm4gNqbnnCEujiW?=
 =?us-ascii?Q?wGeYA7sLYT7zBy2QBZzgOQnmBDJeZq3AUS9WGJGZ8GqGgDM0nrWZ3+pV5HuD?=
 =?us-ascii?Q?MOfi8HsHdgbIenjwECrm9Ff9EWXCF+r0lU8vE3uiv3ERQpYvcP5pz9GcZW4A?=
 =?us-ascii?Q?Wt5oxJqqFZfRuo1YX+g1Pr340O0e7ePAmbDIv2g7Ex4ED5EWlUpoNEv55KDX?=
 =?us-ascii?Q?ltHVIY/BjGaCT6yM7sPq5SqJ8W5ER0LFCKbVsnFlcSFkEyvEAAwMyfzrV24S?=
 =?us-ascii?Q?CRFEGTtbq924U7LwG2sFuicr//gKH3UrCmLC7N8yzkBmN/LJMisYsXUjS6DH?=
 =?us-ascii?Q?BNdS7pR6lqltITeOB4ZOBHW8Ljb7kbW6HWDNUdvmHz++a4UZctEgnpXrf8B9?=
 =?us-ascii?Q?QvFgYAQIERHd9kBaLJ2ESIvim9ZK30LHGkNgFyTJQ6ErdaIQP/oxkaojot7T?=
 =?us-ascii?Q?DneeHTwkk+lXoqDWkexmSOnb+Bve4Lundr60ZkgvbaThZfvZtcUz6sHRLj7z?=
 =?us-ascii?Q?Cg5D2Kh/KEHJm/B9XfasuDq0J/4SU3dXGLd8L9gsUKLMsx76ts2I1rMKw7hb?=
 =?us-ascii?Q?ZPkNHtMSC3yfedQvZV9JoTqIbibmJLH/eBUNZDytyAroobbnsiMsH6dh/2b0?=
 =?us-ascii?Q?KZwYsv/7IpdgL4RB4CWzUS253wA5d2r4iZXqkawEMXetkKx3J5YIrnRVjUaY?=
 =?us-ascii?Q?AR10A2agostRo4S2ri4EWdHn?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0804b48-91b2-43a7-011d-08d913e80678
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 19:15:51.0754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtbGOoE0kyKU0XZNDB07cvkOM3iWzqVccC+RIvQryjiN2dj7h8Y/DTaCfwuEg9jIiw2O0WKd6I5A9cGoqOe+0udYSjdiT7oPXDXi/ebbcuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5256
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_121554_889674_E621637E 
X-CRM114-Status: GOOD (  10.47  )
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

On 5/10/21 00:00, Christoph Hellwig wrote:
> I can't get this to apply.  Can you resend this to the latests nvme-5.13
> I'm about to send out.
>

Sent V2, hope its not too late.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
