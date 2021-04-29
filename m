Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBDC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:18:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2E061450
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2E061450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Ho7OPtOTyacEnrnmzzuLGdfh7ge3Imi0sIwg8E01pUo=; b=JKjshM4qEg0ke6D2usydH/rxa
	Tp4dkCt2qgX7+l0ZhdyC3C7Dp1jFc3nrfNOT1qTMBGXxEtkl6u3MPUxa1r9/hAqxpqIJ1JANat3K7
	Hjl0LFo66Mgsn8alrsZ3KpyA8NOH84Xax4QSP/2mmmK9gKqJADHn7q8x6WO7nIOebGpfk372NV81u
	jjxakcf/Oi5TOZfib6G8uoY4NGmvQDxuBvHg88iv5wakPgpaSl+bbn9bh0uuDiEahNvFm8ePcFP13
	zYmcNW/pEL6MrQXlj0AKjixF+hCfewb6kBN62JC3aGlpYJ+qxNNWez6aqV7XRyU0nIuxKDvRxX4yh
	zbudW1i0A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcBEU-006AQ1-Sp; Thu, 29 Apr 2021 18:17:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBEQ-006APg-BP
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 18:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=hm0TGXZZNxA7c4C/P5vEC9ZiP0MwywYjhdnCb3wwE4c=; b=SAQd6ZKhYyK+fXC/l7j37tjnBz
 e2Zjf57YwhicPOGtOvuq1bFhpLNYfUTkhmyHDwSpUDcLKwdfp3Oe9Y9R2GsU/JTFmWE7ZQK42umAY
 joPOGSI2Lk8UQjbigEggEid01Dh53kevGQ+tdVQt5tMAjy09O0tCeZtmfKyjdLpDsBZDmnKHSihtM
 oKG2yHna4K1XSiaTx09XRTHOc8aa+KHDg0uKXGl7mBxuKnnZ3UG56Ba6XcCvkwVvtJ/QewbKoWp1m
 AYRGPRuV9hmKGuOIZrpsBdxpbShPUPx5EJN53GDlxY9cCiUyfd4BXJcefAR3c2T2FIglTUzWgSBuh
 xDzHSd6A==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBEM-000qTw-PC
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 18:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619720262; x=1651256262;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hm0TGXZZNxA7c4C/P5vEC9ZiP0MwywYjhdnCb3wwE4c=;
 b=n4ZkCx2wu6C5otDaoj7Vo3w0n9odjCBORBPHkRUZh5j7IcvpWs/kN0la
 MpbV9nDVKnijTJ4fA8E9CKRzwfT9hs0IJha3/1w6HMKwKiFOV3THv/1eY
 1McFKc2pJHmLqXiKcfokS09MPgVh3fct/SZb9PueGopTBLUuykKlZdoi0
 71vWsZqH6ShcN8eX9H2zdBZE92Hait37PxCSn0vqDzlyskDrVK/kSG/1p
 aAxR23iknsLUtUbkobiqFchMz13USjy2hqL/nD30xGHAhWVesLZkbJG2P
 5Pfn/5bkDj7nR/VpCG+gmpPW7MtmehBw2r8nJfJi+SW4gUXXqt7+eOZFg Q==;
IronPort-SDR: 6e5A5a0JdwL+AWA1rketj1c2FQ4RD2x6/qtJD0rR3MMPmrAduTi/hlYk/N8o8bBxhJoTLDYazy
 Qakc75Yhm0JJMOcZtu0qBzTu/ePni+jzelhNnS7KFwfa+p4fx8/Phe7x7lybrWJNIXtXNrUX2o
 aEwLAbZsq6dS7X1XKwMeVK0bwNpTidxHol0gKYzqPy5Dm6hyD4+nGQNBLnfVy/+B/RP/zoradW
 u+8ugJyd0HotmCY4touwKQVAp/3D7ATgiiltvfc8/GBe+4uz1Nn2ksoSl+VAFfZZ0HO5+Iq3Dk
 Pi4=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="166032153"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 02:17:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsRxFAgSymtZ98HVWDvdDb7SRozhHo3uIpthCEo/QfgB6jy4gCQWP98r4njODoslkm8c6s2c0FQY/2n3r8q1J9lbNU783Ji/95w3XYMkHJg/eQkb3PjTkEs5UE2y9Thvha6RhbOQbPUFUR/O/Y0aOMzTFKih57pyJrrsGT0QDtzw7K1tdHsU8Aq3Gue0V/o92dozfUAcBtKftaZKGb+6Jucp54CixXHd1/uuUKxW10R2eTzpos8r8sTPH7gwCjiltrqEKTq6X1/PnxFF4MDcCzpmY8Sos5cRLY80NPPDcq/jH4ywawT4z90i71QqNF/voEVi1zkbEHt3ENbhwPlLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm0TGXZZNxA7c4C/P5vEC9ZiP0MwywYjhdnCb3wwE4c=;
 b=gtChnhLbx9ip8TZjINesLr2picMjtawO1SeCQPWOvOaqztCaY80w2GfZUPCWzPVW++ZpXGZ/hDwUSCaOSKVdjSZQeBoIqsuDhieyAh6ivZRWOMev10B0oH9eiuL+XbnrrlzQB6FZ8RZI9DSxBxCKu5d2C2D9c8P9pp3idz2CENF64mjPyA66/iyiNrJ5M5wk5vSxX0z68RXvUJdBQNDc4zF8JFhosIUHUr2vLgKqw9E4aGYPXPXi0YUPemsIgiKGs9Lco5SbZ3dhl8FG8Cij5HyFpvQHhSr3VrRSRCq0aNYGsaMcVGtcU8p0AeEOvzJfKOrzrxsKlRcrU3L95Q/bhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm0TGXZZNxA7c4C/P5vEC9ZiP0MwywYjhdnCb3wwE4c=;
 b=kV8Cbkkh/EuY0bo+7872EItqo9GFjUVriyyKCqdGSas+1XS4FmoTKhH5Ppe4tCSm9iEtQHl+YUjH7HrSM0l0ZqjyVit5k3/647pbwXoVo1g1wEREod5ZlIGANlFP9o+TS7po30CsCSYhrONDm5EFh+BM05M8JMsZSF6tL0djEFY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4136.namprd04.prod.outlook.com (2603:10b6:a02:f3::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 29 Apr
 2021 18:17:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4065.030; Thu, 29 Apr 2021
 18:17:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet: remove unsupported command noise
Thread-Topic: [PATCH] nvmet: remove unsupported command noise
Thread-Index: AQHXPK/FuaGfEEu2skmJDDY4cpbXcg==
Date: Thu, 29 Apr 2021 18:17:36 +0000
Message-ID: <BYAPR04MB49653EAFD1B530304E38A6E3865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210429042558.905404-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b35e17-88d2-457c-ba06-08d90b3b1155
x-ms-traffictypediagnostic: BYAPR04MB4136:
x-microsoft-antispam-prvs: <BYAPR04MB41367BB7BBA136651805F0D9865F9@BYAPR04MB4136.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/TESjk1LIF36JVydBg0bRgTbez9STp6SM9dufYN+5bu4w5k4WH4aUKzPkej6AmW6lIy+LFPr3vkWMSWu34T5cD98B8LHvlfOQPy3H/9PPjiioL6NC/ao6z3Vdol63nHEt+jAnZNI/j2EvTYgFQwiCtUEUiJRpQX6RNa/be+RywWHcMBflGOoA+m8WQTBu/b6sSOauiu05iYGq/yJc1YATc9KGLy9hkRobcQdNx33NKCDja4FD6VtfhFkNefwjr4Ys/u7PeBBvXiazUWsBg5YGcY6WYoUHMHiIUcDzeoa1SVXAshPKiMRafNPSfiuRBFmCSma4PFqD/iNe8pLcyCwr4TPXHbCq9/OCc5Ps2MJjdu+zVwqvVfElkpCaiEdblruL9h6AUnnxFnFD1+6ePtRKnmjIL88IzaGaoz1ab0cNK706DDBJfq9jM4xfqQDZdrO/K8Jmqp5GiNnTEbM8wBP3Hd9BptmvTrMAoGToEIF4/5c5Z++5Okmmx8Ca8G/QE6/yWN5YfZYUDgj84aYzXBQzwKPrrPeEN2mSuGpYbQDEtTMUNhmV92O/k2JqfH5ZvT0guGWm4qIbz/IA+XM++lDWxgxU2A+cD7je7vTT4KQ8g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(8936002)(6506007)(110136005)(71200400001)(9686003)(55016002)(53546011)(316002)(2906002)(478600001)(5660300002)(66556008)(52536014)(86362001)(8676002)(7696005)(66446008)(66476007)(66946007)(76116006)(4744005)(122000001)(64756008)(186003)(83380400001)(4326008)(26005)(38100700002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/kHlADcLocxtCr30TFoD2wc78sCJOrub1sjOoMNEZRBc1hkEXOSRuNcmXJOY?=
 =?us-ascii?Q?0VNJB++tfaTQ7Fs7D1tevB7wg9G/IFM35h+kV8gdMhHeJlWDkjSxls1d9AGc?=
 =?us-ascii?Q?YJatMcfXlB5mZZjkkma5dSsx2nKsmZ9CwtcgE1ieLE2aHbHrsCk1mXAsA9BT?=
 =?us-ascii?Q?P4IbDjS2YKqWVSG3kBean93gydN6UNCykAFPDAMQ5GuO57sFWBQmRJ0BCBfa?=
 =?us-ascii?Q?YfLjfXpXV3CEq5eV+M7nZ0q+4S+eoAlvY/eqHlhsn6/lO1JYT/LCcIsb1wUx?=
 =?us-ascii?Q?cwdCH+dM6AuYaMRmc93QNXIN3Ig/qs/eG8cO6VB0Vv1iM4I7PoCD7GSWELjl?=
 =?us-ascii?Q?6ZDkOO2SEJPAGhnkd3zxQ337YNujZkY+8AQRdhqAiWuE3gT2W9tVnIDKTd1O?=
 =?us-ascii?Q?JPE7YCXqKVxPSijXwEmr/eCXPba1tlKGCk161JBlWUYFo+TxcDkskDFjy6dd?=
 =?us-ascii?Q?u/LEUaLFMJh8va4EQL1GIDaK7ZTlTHiysirUDS1jWRnk31xSduBwtsmQAomR?=
 =?us-ascii?Q?RiwjsGOQNlRYQNYGXP9dsUpkok2uHTtZrPestkThOYABc1/RJGjXc48RnCN5?=
 =?us-ascii?Q?d9Sb5IYAxsu3nm/6+wdlQ58azGd3YXtn/yvIWLKJpiJVemrbuEvywx0OyDhw?=
 =?us-ascii?Q?vXkSoGZoH6wK0A0iY4gTMRuU0/s9no080YSXSiBSjFcTgeLT8SM6ThLwfrfA?=
 =?us-ascii?Q?Z4YfsLdBgv2OjNcCP4qs89sZ1ChVDFw8jqAPjaeIX/RNGH0cepLu/YaDQUBs?=
 =?us-ascii?Q?IJNv90uhQd9PrhZKbQcKxApcI6ChLPUe5rWwhqynSWUCx7xFrpo8fv0qCz/W?=
 =?us-ascii?Q?C6nuiGWFDc+OLmfpHnYYCbU2bWXZW0hRnmDQfFvFTbVmuXBszG/kMBw315wx?=
 =?us-ascii?Q?9FFC2JMOMgaW4fXFjq3chTD8kCIKA1UVk3L0fyipegR9OKYwzpkUrEZv8wdh?=
 =?us-ascii?Q?aHyYa0k0E719qvRnBhtr6ssX9FpOe4Hd7/KR1oA8zn9m6QaBlkdi94EjMDlA?=
 =?us-ascii?Q?uhLVw1hgMrKXHD0rkVXF8aF6HvZLl+hkA5S+0jMkLNe4e+YJL7ilgUfZdNnD?=
 =?us-ascii?Q?HmTgvs1EK4oLIH5BAWcyqIQEuoGY0UPm9THGiZfOitvVBPQtDTiK94G83kMb?=
 =?us-ascii?Q?vvlh4aaO2b9deeSl+nQSCUXsa4TIMzpPv1YAk23gvW8DGmT8rLxxJ7g93ZpL?=
 =?us-ascii?Q?KVlHJgPVkMKZKQMKBmHU7cPvuqDIF/EpCWZ3cHjKCUS1CDIVH82R5LhnvtFQ?=
 =?us-ascii?Q?Y69CEY8OzO8MJgbYa5Q0vOO6lwoHOXaAp3Jk7Juoy3SPs0reizpv7kXuerCr?=
 =?us-ascii?Q?BUUS74+tBi8Vlomxe2lb01fx?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b35e17-88d2-457c-ba06-08d90b3b1155
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 18:17:37.0153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1T7twFTdO03V61H14nQe1a0BIgqj6z3tRRbAmgJcqxyVmLLI71S/SbWt0ebAVtHZ8uZqWWQFjF/+VyjZoHqHFP8Y7bbnDdeU8tpLaK55qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_111742_975515_5B96955D 
X-CRM114-Status: UNSURE (   9.70  )
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

On 4/28/21 21:26, Keith Busch wrote:
> Nothing can stop a host from submitting invalid commands. The target
> just needs to respond with an appropriate status, but that's not a
> target error. Demote invalid command messages to the debug level so
> these events don't spam the kernel logs.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
