Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50492C64E90
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 03:40:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A1A20725
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 03:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKs/fRP2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hHAUBoV1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rr5qTKnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A1A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=QSmfhN8XaA9bnQTQULX4yq5axcAMCLQAyUXlgugz+4w=; b=jKs/fRP2xR8cgM47GGoIjYwx3
	5h6jN27G/DOg9OaqmOCA+fFwTRues6L9OA5V469kSH67KQnuOcHCjlxIQ1THdFY9mZFk5FeSv6WfA
	Ut+QWO+f5m7ogtqpsWuYW7Chmov+ni2XYZIbmt3H2WVHj1be9uDqY2HaK/zlguiHGgBm7f+Ca8HJN
	AkKGWznH2YtusLNyVE/3qXL7M/WQjZkUSfkW3buGZ1Om75iH4UU9MOZMzvOEPYJlo6WIZV31YwFdy
	B8OsUL8E0tcLkZxvYUuR4shFcWFgPMWJrtv0TP1Q191o1Rkr/8femI0CWIkIcY1iMZ06utUGkd/oN
	tTScQsubg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjwX0-000681-G3; Tue, 01 Dec 2020 03:40:46 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjwWy-00067W-7w
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 03:40:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606794215; x=1638330215;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=qPuGUeLuW0mbx9KIm4K3yoTp+ZBJl9ZtEoBN4Bty7NU=;
 b=hHAUBoV1pENib1CPGT6Jte1GOTV/cRy1NgOqly4nazC71FWMxu5W7tVe
 aMDmMjnrecDCHoSYGO+ub72FNbSeQqgzmkF0N1Z/lEwh8wO3UrQeTRHrD
 x2dHvBg7OeItFbTCauohG+bJpbvqOFMN4f1nLG371p1hOwLajdHcPRilf
 +CpJjrIrTck9kI6E1cvNrBV4S3J2UBgwYdp1VtzxnxWOKURby5O2UuJHo
 ERx5PvTt9babvpB/MdomsmnBWFQWB0AK1w+UrRkXJYfLwHegFuTpbzZoM
 f69h+BaH8crz6Gw0/lpsC1+0EGsiD5s3CxYIjAnWEGzWdNdSXHyTVDeYY Q==;
IronPort-SDR: CmbuAvG/Fs7Du9tTnQvgk6uLCXucI5AKTjOS3rnrHUAVNqTPvbh1iQrPgQsBnSoLEDvqJHAFOq
 dKE6iFVV5rXDH6mfb6WxhSAmX0s4Mx+5qNY74ZHkxteqVGBf+iHZOaBAtFAcTkDgpg/pFhPvmr
 Fk1XPeVnE31ro/Hhifdn1L5SsNQrvuinGa2QpMkiQ1W5KUSCypI9Yne421jofxByD7qB0bWZf/
 ZLVwOqfTqsalct6/DaDqQApIg/9ITYcS6AQpUOE0kkGqUyXRuxAEKEzH9I4hSE3WaiVIsxM9Oq
 QJo=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; d="scan'208";a="257556660"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 11:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtcwdKxQ47tM8ZVne605hvITNW6ylhy5UgH5sJYX6F6M4eyLkGRybyTfwXqOLJxtInmk5VNFgbEtC5lJMD1xwn0UDyiuVF9DafUwerpUcJE7I7vRxZjWRrreWplMZ2brQL7Nc7vPiP08vQ/F2wd2TDmOFFWZFqWIeFZdR5jUGBShjvc8OkzJZYrz8PjJoJW1nakK4Hi094K/sSA8PY4AfxacLKnS+4P/tcm7AcJWLRElfsz3mChz+n1xAa9K+lvRfK/K/FISyZEMdhswiekA6muI0szbfVini7M3dmtKmTZV4kimTx4zgUlczaE5vX7CDts/BtbFzXZUpK6FGZPN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXh1o3QxVgdvrqNqrQfpUFZbsozUJG44lTMj9S2uiWo=;
 b=GoHmPlt8APNtzefn3nxm1qFeQPhtPiNeNQyP0hzeO3koWnFEEdbKwZ2BZ3Ciz46pv0BM5MD+Nqxv1Zp6ZLFa/YoYKOtnUQMcvjJvwIP6UlgNgKpUgp+N6klKjOfsLxZwXzPermcVCesK46nhoXedqm94B1o3DY5cumMZhIQSFyi2ZDtwj48AvezZzMNtJtchQMfGZNpondH/LwmV+nTdzVREUC8/Dg9Q7Pq5jF+iBvKZTxsPuYlhDb7I2nEBXD1GnPr4M04QsxgPVF3O6hF8oGz3V1/kXtFn5h1oIeDy9lEKw+NDMGkdU8MsKBMB/2Gf7fNyKpPo+xIjJXyu59x6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXh1o3QxVgdvrqNqrQfpUFZbsozUJG44lTMj9S2uiWo=;
 b=Rr5qTKnEr0bbiykFE3VzBqfuKWWwmppnIFq3Kyv/1XY2/3RLrCO60K77T3a7jir7Bm+Tbs7H15B8F0aMujHZKCjL1iI8bI7OqAAWSBzpHGFwsVhQHf2kGiIJZjsDQcvpO0UZ/9cKTf5zScTyQHFpa73TKVdUlKzigeKS6+uOE0s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5429.namprd04.prod.outlook.com (2603:10b6:a03:d1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 03:40:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 03:40:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 8/9] nvmet: add zns bdev config support
Thread-Topic: [PATCH V2 8/9] nvmet: add zns bdev config support
Thread-Index: AQHWxskhxS2YjO5SB0C4HEgp+lS8fQ==
Date: Tue, 1 Dec 2020 03:40:40 +0000
Message-ID: <BYAPR04MB4965BBC8F6A2A4AE0F90022F86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-9-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652254AAA057F2604DFCEEC3E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa4c33cc-c823-4870-3be6-08d895aae014
x-ms-traffictypediagnostic: BYAPR04MB5429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB54291E03726657BB65CCC07386F40@BYAPR04MB5429.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6hKq03CJwZW/kxr77ZCl6Odp3GyulsWlhzTVoNOBP9rommyQB07iFlQbFf4ALVOFtnT6bPpZkNYiCiDdXWWz/WN8b35spRtFCYZlJx7g8KPh85qlAhNXmM2MdoICBfUhCBpZPclOLlFe52W8IvxPOSuWBQZ1mKTyh+EqnOT8fy408Y3w9Wm1veZJ/+63w2mxf7tGD1Ag0EKahDP0uApLNPLU+Gj0ABkxfeUphuCaAse47dM3C87Jg7sJt4vRZciyEu8zseFqRavsSdyQgw/k2ACssCEFfwKC55AD0krYoY6q4I7WpkjItirQ2D5H/nR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(52536014)(66476007)(110136005)(64756008)(316002)(8676002)(55016002)(4326008)(9686003)(54906003)(26005)(478600001)(2906002)(8936002)(186003)(7696005)(6506007)(5660300002)(86362001)(33656002)(53546011)(76116006)(66446008)(66946007)(66556008)(71200400001)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oA62tZGPvGxgNLO60pUcxSfvUWaERkmGxQngyJ/TdJ1RQUAbqzpiutQnNENR?=
 =?us-ascii?Q?+pxG84VIt9fb4ipz2EoVlffuYTB5zNvn40uc1nDEtnkdC0j4qgvpU8Uby7zD?=
 =?us-ascii?Q?VK593CSNfUUA7mRsYyzPIcl0HkLNXU+orYw+/0r9mKBZfvEXNwwgBBkKCQHd?=
 =?us-ascii?Q?HPwH4P8OkxCZlFQjAbuKr/0fh0GdUJqUzyfQgY2dh5TPQz3ngK8Tu3Gv1ee8?=
 =?us-ascii?Q?rVN39ZPJ1GZtJfk+zfxPF19ODvAdqBbMrsAszQLJhmLhCOBnOUQyMJ6J4FBI?=
 =?us-ascii?Q?/rwr5/CwVvt7BcnBhgPefn4Y5I6EqfDvuQUldUKtHDEf+8JtAGw8lFsVxtEy?=
 =?us-ascii?Q?3yY6Qza+XoI58Wrkn28Jrg5vC04p7XCYTekeIICPfMvzke4eEUdpKcA3lQ6h?=
 =?us-ascii?Q?Py7W4uHJF/TDClFfjLqy+lIhIDOQyl2IobYk3699CbAtldQ6w/IeJ/fF3uoo?=
 =?us-ascii?Q?216KZIdo/YeDWcavhtVqbXOSYw7cbZgbPiw2N0lumvi2HW0w5OcOgcTw+tKO?=
 =?us-ascii?Q?jPfpWgugZpkWg4jMheRSh+3S0WZpcYMoXQsnxdjJTikgus/7XkGBlS4M8fKs?=
 =?us-ascii?Q?7dlpJNGynk3rOqUvwpNyWLOdw40HVyRVONz77/MRv3BxEBXmlAqcLaRinKc0?=
 =?us-ascii?Q?gw1iB08UTmAQUx+oRy0UARCJjCat9L3wB4ismT/88gNLZ9c2cGTHG1KDyhUO?=
 =?us-ascii?Q?1PYAcM9lU6g469qQ2dyFOgVSW/WPIeC0xbYCdbTBCLmrMQwnW35/laUnPpXU?=
 =?us-ascii?Q?lhVt9IoHO3RzKMDrCLw1/hoz3s5DqHlcj5UpeYjfeYUAuZMKFi0u8+H2PT+b?=
 =?us-ascii?Q?dzTigsTLmntRZ+Q91Wl6JGZKZaTTJpvYDlrkQr72H3oj+YhwMEhd3er+03aA?=
 =?us-ascii?Q?ROpldbyNfx6Oa3B9xES/MN2BocIEQmAQ2GDqJE6pBFb9V4BF7ERl4amOQCq/?=
 =?us-ascii?Q?gI/fSJ5+xK2fbJL0ZHw3//UtE5bwlk7hX/D+mH1BGMBzt8T7TCft71+m+E3l?=
 =?us-ascii?Q?pP48?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4c33cc-c823-4870-3be6-08d895aae014
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:40:40.8407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CQLSqUaFcx188vKJvA+wkmwGoBQDfOM7tfb275/Rp4xY2yo0GUHegKLrfAyzuq5C2HqQf17L+4C29plFcSYsmoP8WlSqg+lCSQBcRHm2t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_224044_422595_09D74072 
X-CRM114-Status: GOOD (  12.66  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/30/20 04:02, Damien Le Moal wrote:
>>  
>>
> I think this should be merged with patch 9. I do not see the point in having
> this as a separate patch.

These two patches are doing different things, one deals with the target side

configuration management and other deals with the host side I/O handlers
which

has no relation to the target side configuration management, so I kept
it separate.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
