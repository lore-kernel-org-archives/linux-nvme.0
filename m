Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC90C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 11:48:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345EF64DDB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 11:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345EF64DDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8w10GudJSdTY0bjXd2Vp2ou2HNBQu5PkARl+dCqiWlE=; b=1d9J7ycGbCqrxaJitktQ+5BzK
	aTBcbbIilK78TXfVXjgjAJTmnjwqgtpSE073WBsDY+UtC7f/Z/10HHx3mK3XSAdZYz34+dXoJMjbq
	hUIqPfbCftXXkQd2fXnK8da/lg8+6xBxq0oakaqcYgwGmH2z1uv/1N70f01riHxI28VhuB6U1gM4d
	kgTuIAznWtIrUD6U+AW1qCKP1OpNs6/eL2mr3nfarcK+fPqhfxNbWUq7fKw4mvRMqX7r/S6bZH9SP
	nIfEWXoenB5UhGz26XRanrS7FenKVEVNA0d7k5e2XRaXOMSR45p6qVhnD+ttG2fwEIb1zx4I+x3SG
	pZJXdKQXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l55mf-00057V-LF; Thu, 28 Jan 2021 11:48:21 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l55md-00056C-45
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 11:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611834499; x=1643370499;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZKd/Ju05mQZVjVdLfEquUJp8eUvGlFpOWNUWixdUukY=;
 b=jI9H/GGlI9eUyAwDkxh3pRQ8q2Ldr0uLiuiQnwn5OoiKUXlPzsTm+6Z4
 Rl7lcNguzXjKLMQGZ4nYVvW5aZFkZHHCsqztNmsKZ9g/9dsqXmtVYJLtA
 DstGYxzEZH6375Mg0xCi2/3fNQVmChcQFvRzo1dIqwcahkWqiI5PwOF7M
 3VF7K34kTF99BF4jIB4CosHpGAT/yOeNoKD76PFglVhHltzanML5lrREX
 XEHTsml9mnhhAyUSCxCN39PcH8WpwiWiQaDNfY/+1oU/dnmirg0SpgFoj
 rB5FeEy/J/RUhxQDdcq52e+JVihKcYxr6h2o1H5rWLMnNYj5cRmSEmV0h w==;
IronPort-SDR: aXeqoVkVWznWYYfHd56k9+BqzG2sv/SCD9FB0sGca81H4UgK8d65AQDpKDS6sq0kkUgM0xN3p/
 ThR272GjutKlPOlflLMLtJ+EdM2+NCW5hLRIyVBo06F9UJS4fwCYJaUJCtPpq34UX7M5b9T0Pr
 uqj5L790OFkXNhgzY6r0dWYeAKUxpIq+n+Ko1S54DwsIzNfOvHpi+sr9oDIQthiNjMMo+Aa+Fz
 SSCe5o+3Xx6LkAL02enpYwl9Vl9AAcqoflonpR5l9hXP4Cdv70L5UTTKKVl2TYzm7pakHzk1lh
 QJI=
X-IronPort-AV: E=Sophos;i="5.79,382,1602518400"; d="scan'208";a="159713341"
Received: from mail-dm6nam08lp2046.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 19:48:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho25gdqWsfX/aNKFCF1ZvuU0OlaBIy/0ioWeYDkCLTaJrXXbOlv6Lxbw5kSuyTNBe/77O+pceU0cKteaHr/jlUYnqlgmEIvL10YeAYHLLtM0w0yU6hvceMkp3/o2KRD29Fw9qSg870ChhZcrtXGGVBo2z3Wxx5HJwe921bJZHfkBV02XJU25D5PersykDj9y+8DT6Rbz0FNGdy+h5NjTtIwTuyKIPnHljzpQimTxioEffAA4ksCnSXinGHRIUkreXidHbVn7/jyLGfEwDRAB31HSM9DmcfRGBLyc06GfdDUblEZdChmqvBvvQ6CVJ3Prpi6acafE/kGhbysg1HvqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKd/Ju05mQZVjVdLfEquUJp8eUvGlFpOWNUWixdUukY=;
 b=E7q92DW+sUKyVhH0W1A3ZqYDdDMPY/aO2vtuA7J51/u+ZfUVrRe5u294TQRYflODEJovNubCGp/AVGgltZiT+G4x+ahkY5mC7dGlIh/bWWcVF7209qQEwGS2g0gS5DJFsVDVZ4AkPPDjs330NeqzW58nKJlb9l7PHE1AJ+Eyqwlg1UIt1KKxhILNb7WYcvQO86YPtCFkD0AvFtOlPOfHSsW3ZMtIRJ/CoN93TJaF4LaGRUk3vGYHbE7BToR10Ed8leJoCxkKOBq5FXvWdwA0LfrqEYF2M5m+XPcHCiXwDCQZ71jxX1xYi2j4+7smBehk3cpftmr/10TioZPTM++u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKd/Ju05mQZVjVdLfEquUJp8eUvGlFpOWNUWixdUukY=;
 b=Ks28JLtLZw8/Cz4gnAURPLLydu6HfOeMtLQp3utUgCU5EilegZ8Yd2Fd2a7K+oX0OaGsXMxuvqbZHGeoewVmFDD2bXIWoB0jf35wHwOBvSeKVn21ef2/0A6cD85SFTPpWKv9bPUUCWqtFQbgKWLowIZgChDkWZ2l9ipb5OmNdmU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 11:48:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 11:48:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Thread-Topic: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Thread-Index: AQHW9TFKiMPb/ih7U0an7gT/NqHb1g==
Date: Thu, 28 Jan 2021 11:48:15 +0000
Message-ID: <SN4PR0401MB359807459C1C4BA9CA43A14A9BBA9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-9-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d26951f1-ed69-4cdf-0f49-08d8c3829934
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3597BA1E971B1B7EE8E481679BBA9@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMvBrGWMFAdLUL4s9mIGuGZQQYh4hY7SH2G3zOrB75m13OskC042yTM+JzCpfe4J+MgiekrOVkC6lGP/HMuLoqBeBNdudpy+Y1BsQM5D0iMndac4i51RX2ZDVVKEbYk/Z74rn1wg0f/BNYuySgGLveQmRrPXcIe+krVlU58nh4GPQaTCAtZ7Q0JN/LDf3xJ7Mg4KsQoPjb3xjZGqA3U/oyfDHCdybOSA2FP7/EPpfKa+yVVt+yl6OjCyvTabwMbxDILWsflVaES2olWIiST2J9nHsI9/5gTG25oic/Phm3YarDU2PFL7qir3RgUh2Y1lU06pj0XiPkqyJTZ6ajrWJEpoX7JODQhyj0GG1Q0+t5FV66DjxpnE6rEYk+HzAtqUGjpSVGmVcE41QBX0lBpW9EyUHND8bkN+gJqin8HzqjLZyf78sBXitkS98DYzSuDzXdHqQGpev7iZ2lcpwFN1SbP2j6/AVSy+f3R7gug4bFm7WhfyQgaNxzS84i+U9P0AOoVj0GK/LkQj1sMd9popqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(186003)(558084003)(9686003)(33656002)(86362001)(55016002)(7696005)(71200400001)(6506007)(54906003)(4326008)(8676002)(19618925003)(26005)(64756008)(2906002)(66446008)(66476007)(66946007)(66556008)(76116006)(91956017)(4270600006)(8936002)(52536014)(5660300002)(478600001)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YCFry1+Z6OHjtyFypa9Y7tykeWiybtVWTmoMFXHVe605kPQBh6YKrIzVwOrA?=
 =?us-ascii?Q?QvLQ7JZyCJPOSMKTaOCFoGUvV8teKRNpB+9P+HZgjP/mTO8Wei/E+tQdZHIS?=
 =?us-ascii?Q?JvMx0qysLWkySSPxQclas3GrBMIRefmgvuoISojM1LUUGiViCfYJt2O8Kni2?=
 =?us-ascii?Q?PXZ42S4DqHw52P5X7M4BVjZyteY6SbvYH9LmWYejLitGWKzZMYCIbuKYu7rh?=
 =?us-ascii?Q?tXESp988/DDod3PiGnISGSX6dBdu9cvSzGFosmiPJlat8XhCKZNqZWrkFZ+5?=
 =?us-ascii?Q?j5dVdDUmXC/jo+acgITAryNP3Rz1rvqFE4Ph/NZ2Yd9yZRd7ssVtdJ+2wpxs?=
 =?us-ascii?Q?/o/pd6FAy0QkAmPqfPi84c36pqRWiPV/Pr0qKmoXsvMjnnEdn8kfUWm1MoTs?=
 =?us-ascii?Q?m9+v9WHuTfEtJuVslSVRIHRciO1F9jaWbcnVG3w3O6q4l3I5/a2EQH783xqy?=
 =?us-ascii?Q?rAkl3utLKWrhvCb2pN2t1FRxcEXam6K1+/5bXiTca1w2ixJWKv970D+s0W6w?=
 =?us-ascii?Q?3/DiV5yTJwTm93AJ8yxy6p3N0MhaTpDdiPpGLp6s/bCbbfMfpvyATVSDRP0+?=
 =?us-ascii?Q?GOALH8ED5el84WzeVYSNp+JlDRj7P1OhnY/3UPgOofnr9Fdst/B0ITirHTvN?=
 =?us-ascii?Q?UwqPqceF2KKElYgkIIcsfr6IhRaSouboOB6ddMyitwO99sDpPwbf4BiOf8II?=
 =?us-ascii?Q?J5JwAlm+nocbaTAbRJSQaCWRwCO4AyTV+cBN54j2opTSjkmlnEaMwkp27VlV?=
 =?us-ascii?Q?uSsCh6mn2+jROmCJRCVLQj6EC4NV3HM01qdVNXFdwK03YBsAxeyRmhu5qrRU?=
 =?us-ascii?Q?0h+yTjCv/DJjdXUTLVQNhEZ0uwe36qlzfvX5eh2KP0pdtez1QHqd5IxB3PYQ?=
 =?us-ascii?Q?BZ1c8ESaZSjP/pGRCNzJHHG5wWd2BhLEPFb3OsTDY6LKYC9ruX67XBd099RK?=
 =?us-ascii?Q?yaP9tiku06f8s2QMOVj1WPxY61yQVb2iE8ok8+NpF9hadc739rhOrOaAGsot?=
 =?us-ascii?Q?cbnSQHbP8l/gXSlOuEjx9bRuHAwkLoY1U2HBJU6MGo+ykkBE6vTprDH1S7NU?=
 =?us-ascii?Q?DICSS2iuWF+AKt9GYwNoROjOKBBqVw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26951f1-ed69-4cdf-0f49-08d8c3829934
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 11:48:15.5286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXDKfSsBOO3SnMHRX5h53jJBb15Ml4P5WMnwicfjo4H+boUzjDf4wrsiBF8rm0abq7lpT1m3cSmiMkP+VzkITC/VVtJRdOWvqxRmPm3ZSqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_064819_404964_0149509C 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@edc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
